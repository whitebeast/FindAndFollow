using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public class Database
{
    // db logic
    public static void CarParsingInsert(string url, string[] XPathArray, int startId, int finishId, string webSite)
    {
        // Insert statement
        string insertStmt = "INSERT INTO dbo.CarParsing(CarBrand, Model, ModelYear, Price, Mileage, EngineSize, Color, BodyType, " +
            "EngineType, TransmissionType, DriveType, CreatedOn, Description, SiteUrl, IsPageExist, SellerType, Condition, IsSwap) " +
            "VALUES(@CarBrand, @Model, @ModelYear, @Price, @Mileage, @EngineSize, @Color, @BodyType, @EngineType, @TransmissionType, " +
            "@DriveType, @CreatedOn, @Description, @SiteUrl, @IsPageExist, @SellerType, @Condition, @IsSwap)";

        // Set up SQL Server connection
        string connStr = ConfigurationManager.ConnectionStrings["FindAndFollowConnectionString"].ConnectionString;
        SqlConnection sqlConnection = new SqlConnection(connStr);

        sqlConnection.Open();
        SqlCommand commandInsert = new SqlCommand(insertStmt, sqlConnection);

        // Define parameters
        commandInsert.Parameters.Add("@CarBrand", SqlDbType.NVarChar, 1000);
        commandInsert.Parameters.Add("@Model", SqlDbType.NVarChar, 1000);
        commandInsert.Parameters.Add("@ModelYear", SqlDbType.NVarChar, 4000);
        commandInsert.Parameters.Add("@Price", SqlDbType.NVarChar, 1000);
        commandInsert.Parameters.Add("@Mileage", SqlDbType.NVarChar, 1000);
        commandInsert.Parameters.Add("@EngineSize", SqlDbType.NVarChar, 1000);
        commandInsert.Parameters.Add("@Color", SqlDbType.NVarChar, 1000);
        commandInsert.Parameters.Add("@BodyType", SqlDbType.NVarChar, 1000);
        commandInsert.Parameters.Add("@EngineType", SqlDbType.NVarChar, 1000);
        commandInsert.Parameters.Add("@TransmissionType", SqlDbType.NVarChar, 1000);
        commandInsert.Parameters.Add("@DriveType", SqlDbType.NVarChar, 1000);
        commandInsert.Parameters.Add("@Description", SqlDbType.NVarChar, 4000);
        commandInsert.Parameters.Add("@CreatedOn", SqlDbType.NVarChar, 1000);
        commandInsert.Parameters.Add("@SiteUrl", SqlDbType.NVarChar, 4000);
        commandInsert.Parameters.Add("@IsPageExist", SqlDbType.Bit);
        commandInsert.Parameters.Add("@SellerType", SqlDbType.NVarChar, 1000);
        commandInsert.Parameters.Add("@Condition", SqlDbType.NVarChar, 1000);
        commandInsert.Parameters.Add("@IsSwap", SqlDbType.NVarChar, 1000);
        
        // Set DB Null value
        SqlParameter[] sqlParameters = new SqlParameter[1];
        sqlParameters[0] = new SqlParameter("nvarchar", SqlDbType.NVarChar, 4000);
        sqlParameters[0].Value = DBNull.Value;

        string[] DataArray = new string[XPathArray.Length];

        // Insert data
        for (int i = startId; i < finishId; i++)
        {
            if (Download.IsPageExist(url + i.ToString()))
            {
                DataArray = Download.GetData(url + i.ToString(), XPathArray, webSite);
                commandInsert.Parameters["@CarBrand"].Value = DataArray[0] == null ? sqlParameters[0].Value : DataArray[0];
                commandInsert.Parameters["@Model"].Value = DataArray[1] == null ? sqlParameters[0].Value : DataArray[1];
                commandInsert.Parameters["@ModelYear"].Value = DataArray[2] == null ? sqlParameters[0].Value : DataArray[2];
                commandInsert.Parameters["@Price"].Value = DataArray[3] == null ? sqlParameters[0].Value : DataArray[3];
                commandInsert.Parameters["@Mileage"].Value = DataArray[4] == null ? sqlParameters[0].Value : DataArray[4];
                commandInsert.Parameters["@EngineSize"].Value = DataArray[5] == null ? sqlParameters[0].Value : DataArray[5];
                commandInsert.Parameters["@Color"].Value = DataArray[6] == null ? sqlParameters[0].Value : DataArray[6];
                commandInsert.Parameters["@BodyType"].Value = DataArray[7] == null ? sqlParameters[0].Value : DataArray[7];
                commandInsert.Parameters["@EngineType"].Value = DataArray[8] == null ? sqlParameters[0].Value : DataArray[8];
                commandInsert.Parameters["@TransmissionType"].Value = DataArray[9] == null ? sqlParameters[0].Value : DataArray[9];
                commandInsert.Parameters["@DriveType"].Value = DataArray[10] == null ? sqlParameters[0].Value : DataArray[10];
                commandInsert.Parameters["@Description"].Value = DataArray[11] == null ? sqlParameters[0].Value : DataArray[11];
                commandInsert.Parameters["@CreatedOn"].Value = DataArray[12] == null ? sqlParameters[0].Value : DataArray[12];
                commandInsert.Parameters["@SiteUrl"].Value = url + i.ToString();
                commandInsert.Parameters["@IsPageExist"].Value = true;
                commandInsert.Parameters["@SellerType"].Value = DataArray[13] == null ? "частное" : "автохаус";
                if (DataArray[14] != null)
                {
                    if (DataArray[14].Contains("кондиционер") || DataArray[14].Contains("климат-контроль"))
                    commandInsert.Parameters["@Condition"].Value = "1";
                    else
                    commandInsert.Parameters["@Condition"].Value = "0";
                }
                else
                {
                    commandInsert.Parameters["@Condition"].Value = "0";
                }
                commandInsert.Parameters["@IsSwap"].Value = DataArray[15] == null ? "0" : "1";

                commandInsert.ExecuteNonQuery();
            }
            else
            {
                commandInsert.Parameters["@CarBrand"].Value = sqlParameters[0].Value;
                commandInsert.Parameters["@Model"].Value = sqlParameters[0].Value;
                commandInsert.Parameters["@ModelYear"].Value = sqlParameters[0].Value;
                commandInsert.Parameters["@Price"].Value = sqlParameters[0].Value;
                commandInsert.Parameters["@Mileage"].Value = sqlParameters[0].Value;
                commandInsert.Parameters["@EngineSize"].Value = sqlParameters[0].Value;
                commandInsert.Parameters["@Color"].Value = sqlParameters[0].Value;
                commandInsert.Parameters["@BodyType"].Value = sqlParameters[0].Value;
                commandInsert.Parameters["@EngineType"].Value = sqlParameters[0].Value;
                commandInsert.Parameters["@TransmissionType"].Value = sqlParameters[0].Value;
                commandInsert.Parameters["@DriveType"].Value = sqlParameters[0].Value;
                commandInsert.Parameters["@Description"].Value = sqlParameters[0].Value;
                commandInsert.Parameters["@CreatedOn"].Value = sqlParameters[0].Value;
                commandInsert.Parameters["@SiteUrl"].Value = url + i.ToString();
                commandInsert.Parameters["@IsPageExist"].Value = false;
                commandInsert.Parameters["@SellerType"].Value = sqlParameters[0].Value;
                commandInsert.Parameters["@Condition"].Value = sqlParameters[0].Value;
                commandInsert.Parameters["@IsSwap"].Value = sqlParameters[0].Value;
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
