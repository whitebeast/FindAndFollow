using System;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.IO;
using System.Collections.Generic;
using CarStatusChecker.Models;
using HtmlAgilityPack;

namespace CarStatusChecker
{
    class Program
    {
        static string fileName = @"C:\temp\" + DateTime.Now.ToString("HH-mm-ss") + ".txt"; // enter dir for log file
        static void Main(string[] args)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = @"Server=.\ins1;Database=FindAndFollow;Trusted_Connection=true"; // enter database connection properties
                conn.Open();
                SqlCommand command = new SqlCommand("SELECT CarId, OriginalURL FROM Car WHERE IsActive = 1", conn);
                var cars = new List<Car>();
                var carsSort = new List<Car>();
                
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        cars.Add(
                            new Car
                            {
                                CarId = reader.GetInt32(0),
                                OriginalURL = reader.GetString(1)
                            }
                        );
                    }
                }

                cars.Sort((x, y) => String.CompareOrdinal(x.OriginalURL, y.OriginalURL));

                foreach (var car in cars)
                {
                    
                    using (var web = new WebClient())
                    {
                        try
                        {
                            var page = web.DownloadString(car.OriginalURL);

                            if (page.Contains("не найдено"))
                            {
                                Logging(car.CarId, car.OriginalURL, "UPDATE");
                                SetNotFound(conn, car.CarId);
                            }
                            else
                            {
                                Logging(car.CarId, car.OriginalURL, "SKIP");
                            }
                        }
                        catch (WebException ex)
                        {
                            HttpWebResponse webResponse = (HttpWebResponse)ex.Response;
                            if (webResponse.StatusCode == HttpStatusCode.NotFound)
                            {
                                SetNotFound(conn, car.CarId);
                            }
                        }
                        //TODO: log
                        //catch (Exception ex)
                        //{
                        //}
                    }
                }
            }
        }

        static void SetNotFound(SqlConnection connection, int carId)
        {
            var updCommand = new SqlCommand("UPDATE Car SET IsActive = 0 WHERE CarId = @CarId", connection);
            updCommand.Parameters.AddWithValue("@CarId", carId);
            updCommand.ExecuteNonQuery();
        }

        static void Logging(int CarId, string OriginalURL, string RowType)
        {
            TextWriter tsw = new StreamWriter(fileName, true);
            tsw.WriteLine("{0}\t{1}\t{2}", CarId, OriginalURL, RowType);
            tsw.Close();
        }
    }
}