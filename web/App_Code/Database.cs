using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace FindAndFollow
{
    public class Database
    {
        // db logic
        public static void CarParsingInsert(string url, string[] XPathArray, int startId, int finishId, string webSite)
        {
            // Set up SQL Server connection
            string connStr = ConfigurationManager.ConnectionStrings["FindAndFollowConnectionString"].ConnectionString;
            SqlConnection sqlConnection = new SqlConnection(connStr);

            sqlConnection.Open();

            SqlCommand commandInsert = new SqlCommand("CarParsingInsert", sqlConnection);
            commandInsert.CommandType = CommandType.StoredProcedure;

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
                    commandInsert.Parameters.Add("@pCarBrand", SqlDbType.NVarChar, 1000).Value = DataArray[0] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pModel", SqlDbType.NVarChar, 1000).Value = DataArray[1] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pModelYear", SqlDbType.NVarChar, 4000).Value = DataArray[2] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pPrice", SqlDbType.NVarChar, 1000).Value = DataArray[3] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pMileage", SqlDbType.NVarChar, 1000).Value = DataArray[4] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pEngineSize", SqlDbType.NVarChar, 1000).Value = DataArray[5] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pColor", SqlDbType.NVarChar, 1000).Value = DataArray[6] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pBodyType", SqlDbType.NVarChar, 1000).Value = DataArray[7] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pEngineType", SqlDbType.NVarChar, 1000).Value = DataArray[8] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pTransmissionType", SqlDbType.NVarChar, 1000).Value = DataArray[9] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pDriveType", SqlDbType.NVarChar, 1000).Value = DataArray[10] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pDescription", SqlDbType.NVarChar, 4000).Value = DataArray[11] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pPageCreatedOn", SqlDbType.NVarChar, 1000).Value = DataArray[12] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pSiteUrl", SqlDbType.NVarChar, 4000).Value = url + i.ToString();
                    commandInsert.Parameters.Add("@pIsPageExist", SqlDbType.Bit).Value = true;
                    commandInsert.Parameters.Add("@pSellerType", SqlDbType.NVarChar, 1000).Value = DataArray[13] == null ? "частное" : "автохаус";
                    if (DataArray[14] != null)
                    {
                        if (DataArray[14].Contains("Кондиционер") || DataArray[14].Contains("климат-контроль"))
                            commandInsert.Parameters.Add("@pCondition", SqlDbType.NVarChar, 1000).Value = "1";
                        else
                            commandInsert.Parameters.Add("@pCondition", SqlDbType.NVarChar, 1000).Value = "0";
                    }
                    else
                    {
                        commandInsert.Parameters.Add("@pCondition", SqlDbType.NVarChar, 1000).Value = "0";
                    }
                    commandInsert.Parameters.Add("@pIsSwap", SqlDbType.NVarChar, 1000).Value = DataArray[15] == null ? "0" : "1";

                    commandInsert.ExecuteNonQuery();
                }
                else
                {
                    commandInsert.Parameters.Add("@pCarBrand", SqlDbType.NVarChar, 1000).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pModel", SqlDbType.NVarChar, 1000).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pModelYear", SqlDbType.NVarChar, 4000).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pPrice", SqlDbType.NVarChar, 1000).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pMileage", SqlDbType.NVarChar, 1000).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pEngineSize", SqlDbType.NVarChar, 1000).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pColor", SqlDbType.NVarChar, 1000).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pBodyType", SqlDbType.NVarChar, 1000).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pEngineType", SqlDbType.NVarChar, 1000).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pTransmissionType", SqlDbType.NVarChar, 1000).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pDriveType", SqlDbType.NVarChar, 1000).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pPageCreatedOn", SqlDbType.NVarChar, 1000).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pSiteUrl", SqlDbType.NVarChar, 4000).Value = url + i.ToString();
                    commandInsert.Parameters.Add("@pIsPageExist", SqlDbType.Bit).Value = false;
                    commandInsert.Parameters.Add("@pSellerType", SqlDbType.NVarChar, 1000).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pCondition", SqlDbType.NVarChar, 1000).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pIsSwap", SqlDbType.NVarChar, 1000).Value = sqlParameters[0].Value;

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

        public static string[] GetCarParsingSettings(string Url)
        {
            string[] XPathArray = new string[16];
            
            string connStr = ConfigurationManager.ConnectionStrings["FindAndFollowConnectionString"].ConnectionString;
            SqlConnection sqlConnection = new SqlConnection(connStr);

            string selectString = "SELECT CarBrandXPath, ModelXPath, ModelYearXPath, PriceXPath, MileageXPath, EngineSizeXPath," + 
                                    "ColorXPath, BodyTypeXPath, EngineTypeXPath, TransmissionTypeXPath, DriveTypeXPath," + 
                                    "DescriptionXPath, PageCreatedOnXPath, SellerTypeXPath, ConditionXPath, IsSwapXPath " +
                                    "FROM CarParsingSettings WHERE SiteUrlXPath = @SiteUrl";

            SqlCommand commandSelect = new SqlCommand(selectString, sqlConnection);
            commandSelect.Parameters.AddWithValue("@SiteUrl", Url);

            sqlConnection.Open();

            // Get data from db
            SqlDataReader DataReader = commandSelect.ExecuteReader();
            while (DataReader.Read())
            {
                XPathArray[0] = DataReader["CarBrandXPath"].ToString();
                XPathArray[1] = DataReader["ModelXPath"].ToString();
                XPathArray[2] = DataReader["ModelYearXPath"].ToString();
                XPathArray[3] = DataReader["PriceXPath"].ToString();
                XPathArray[4] = DataReader["MileageXPath"].ToString();
                XPathArray[5] = DataReader["EngineSizeXPath"].ToString();
                XPathArray[6] = DataReader["ColorXPath"].ToString();
                XPathArray[7] = DataReader["BodyTypeXPath"].ToString();
                XPathArray[8] = DataReader["EngineTypeXPath"].ToString();
                XPathArray[9] = DataReader["TransmissionTypeXPath"].ToString();
                XPathArray[10] = DataReader["DriveTypeXPath"].ToString();
                XPathArray[11] = DataReader["DescriptionXPath"].ToString();
                XPathArray[12] = DataReader["PageCreatedOnXPath"].ToString();
                XPathArray[13] = DataReader["PageCreatedOnXPath"].ToString();
                XPathArray[14] = DataReader["ConditionXPath"].ToString();
                XPathArray[15] = DataReader["IsSwapXPath"].ToString();
            }

            sqlConnection.Close();

            return XPathArray;
        }
    }
}
