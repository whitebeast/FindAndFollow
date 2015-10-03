using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public class Database
{
    // db logic
    public static void CarParsingInsert(string url, string[] XPathArray, int startId, int finishId)
    {
        // Insert statement
        string insertStmt = "INSERT INTO dbo.CarParsing(CarBrand, ModelYear, Price, Mileage, EngineSize, SiteUrl, IsPageExist) " +
            "VALUES(NULLIF(@CarBrand, 'null'), NULLIF(@ModelYear, 'null'), NULLIF(@Price, 'null'), NULLIF(@Mileage, 'null'), " +
            "NULLIF(@EngineSize, 'null'), @SiteUrl, @IsPageExist)";

        // Set up SQL Server connection
        string connStr = ConfigurationManager.ConnectionStrings["FindAndFollowConnectionString"].ConnectionString;
        SqlConnection sqlConnection = new SqlConnection(connStr);

        sqlConnection.Open();
        SqlCommand commandInsert = new SqlCommand(insertStmt, sqlConnection);

        // Define parameters
        commandInsert.Parameters.Add("@CarBrand", SqlDbType.NVarChar, 1000);
        commandInsert.Parameters.Add("@ModelYear", SqlDbType.NVarChar, 1000);
        commandInsert.Parameters.Add("@Price", SqlDbType.NVarChar, 1000);
        commandInsert.Parameters.Add("@Mileage", SqlDbType.NVarChar, 1000);
        commandInsert.Parameters.Add("@EngineSize", SqlDbType.NVarChar, 1000);
        commandInsert.Parameters.Add("@SiteUrl", SqlDbType.NVarChar, 4000);
        commandInsert.Parameters.Add("@IsPageExist", SqlDbType.Bit);

        // Insert data
        for (int i = startId; i < finishId; i++)
        {
            if (Download.isPageExist(url + i.ToString()))
            {
                commandInsert.Parameters["@CarBrand"].Value = Download.getData(url + i.ToString(), XPathArray[0], "CarBrand");
                commandInsert.Parameters["@ModelYear"].Value = Download.getData(url + i.ToString(), XPathArray[1], "ModelYear");
                commandInsert.Parameters["@Price"].Value = Download.getData(url + i.ToString(), XPathArray[2], "Price");
                commandInsert.Parameters["@Mileage"].Value = Download.getData(url + i.ToString(), XPathArray[3], "Mileage");
                commandInsert.Parameters["@EngineSize"].Value = Download.getData(url + i.ToString(), XPathArray[4], "EngineSize");
                commandInsert.Parameters["@SiteUrl"].Value = url + i.ToString();
                commandInsert.Parameters["@IsPageExist"].Value = true;
                commandInsert.ExecuteNonQuery();
            }
            else
            {
                commandInsert.Parameters["@CarBrand"].Value = "null";
                commandInsert.Parameters["@ModelYear"].Value = "null";
                commandInsert.Parameters["@Price"].Value = "null";
                commandInsert.Parameters["@Mileage"].Value = "null";
                commandInsert.Parameters["@EngineSize"].Value = "null";
                commandInsert.Parameters["@SiteUrl"].Value = url + i.ToString();
                commandInsert.Parameters["@IsPageExist"].Value = false;
                commandInsert.ExecuteNonQuery();
            }
        }
        sqlConnection.Close();
    }

    public static void CarParsingClean()
    {
        // Set up SQL Server connection
        string connStr = ConfigurationManager.ConnectionStrings["FindAndFollowConnectionString"].ConnectionString;
        SqlConnection sqlConnection = new SqlConnection(connStr);

        sqlConnection.Open();
        SqlCommand commandDelete = new SqlCommand("CarParsingClean", sqlConnection);

        // Clean "left" data
        commandDelete.CommandType = CommandType.StoredProcedure;
        commandDelete.ExecuteNonQuery();

        sqlConnection.Close();
    }
}
