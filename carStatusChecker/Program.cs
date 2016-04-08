using System;
using System.Configuration;
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
        static string connStr = ConfigurationManager.ConnectionStrings["CarStatusChecker.Properties.Settings.ConnectionString"].ConnectionString;
        static string dir = Properties.Settings.Default.logFileDir;
        static string fileName = dir + DateTime.Now.ToString("yyyy-MM-dd HH-mm-ss") + ".txt"; 
        static void Main(string[] args)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand command = new SqlCommand("SELECT CarId, OriginalURL FROM dbo.vwCarActive ORDER BY CarId", conn);
                var cars = new List<Car>();
                                
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

                var count = cars.Count;

                foreach (var car in cars)
                {
                    Console.Write((cars.IndexOf(car) + 1) + " from " + count + ":");
                    using (var web = new WebClient())
                    {
                        try
                        {
                            var page = web.DownloadString(car.OriginalURL);

                            if (page.Contains("не найдено"))
                            {
                                LogText(car.CarId, car.OriginalURL, "DELETED");
                                SetNotActive(conn, car.CarId);
                            }
                            else
                            {
                                LogText(car.CarId, car.OriginalURL, "ACTIVE");
                            }
                        }
                        catch (WebException ex)
                        {
                            HttpWebResponse webResponse = (HttpWebResponse)ex.Response;
                            if (webResponse.StatusCode == HttpStatusCode.NotFound)
                            {
                                SetNotActive(conn, car.CarId);
                            }
                        }
                    }
                }
            }
        }

        static void SetNotActive(SqlConnection connection, int carId)
        {
            var updCommand = new SqlCommand("EXECUTE dbo.CarUpdate_IsActive @pCarId = @CarId", connection);
            updCommand.Parameters.AddWithValue("@CarId", carId);
            updCommand.ExecuteNonQuery();
        }

        static void LogText(int CarId, string OriginalURL, string RowType)
        {
            TextWriter tsw = new StreamWriter(fileName, true);
            tsw.WriteLine("{0}\t{1}\t{2}", CarId, OriginalURL, RowType);
            tsw.Close();

            Console.Write(RowType);
            Console.WriteLine("");
        }
    }
}