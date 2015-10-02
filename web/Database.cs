using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public class Database
{
    // db logic
    public static void CarParsingInsert(string url, string Xpath, int startId, int finishId)
    {
        // Insert statement
        string insertStmt = "INSERT INTO dbo.CarParsing(CarBrand, SiteUrl, IsPageExist) VALUES(NULLIF(@CarBrand, 'null'), @SiteUrl, @IsPageExist)";

        // Set up SQL Server connection
        string connStr = ConfigurationManager.ConnectionStrings["FindAndFollowConnectionString"].ConnectionString;
        SqlConnection sqlConnection = new SqlConnection(connStr);

        sqlConnection.Open();
        SqlCommand commandInsert = new SqlCommand(insertStmt, sqlConnection);

        // Define parameters
        commandInsert.Parameters.Add("@CarBrand", SqlDbType.NVarChar, 1000);
        commandInsert.Parameters.Add("@SiteUrl", SqlDbType.NVarChar, 4000);
        commandInsert.Parameters.Add("@IsPageExist", SqlDbType.Bit);

        // Insert data
        for (int i = startId; i < finishId; i++)
        {
            if (Download.isPageExist(url + i.ToString()))
            {
                commandInsert.Parameters["@CarBrand"].Value = Download.getData(url + i.ToString(), Xpath, "CarName");
                commandInsert.Parameters["@SiteUrl"].Value = url + i.ToString();
                commandInsert.Parameters["@IsPageExist"].Value = true;
                commandInsert.ExecuteNonQuery();
            }
            else
            {
                commandInsert.Parameters["@CarBrand"].Value = "null";
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
