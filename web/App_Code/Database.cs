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

            string[] dataArray = new string[XPathArray.Length];

            // Insert data
            for (int i = startId; i < finishId; i++)
            {
                if (Download.IsPageExist(url + i.ToString()))
                {
                    dataArray = Download.GetData(url + i.ToString(), XPathArray, webSite);

                    if (webSite == "av.by")
                    {
                        dataArray[3] = StringClass.ConcatenateSpaces(StringClass.RemoveText(dataArray[3], "р."));
                        dataArray[4] = StringClass.RemoveText(dataArray[4], "км.");
                        dataArray[5] = StringClass.RemoveText(dataArray[5], "см");
                        dataArray[11] = StringClass.RemoveText(dataArray[11], "Комментарий продавца:");
                        dataArray[12] = StringClass.DatetimeFormat(StringClass.RemoveText(dataArray[12], "Добавлено: "));
                    }

                    commandInsert.Parameters.Add("@pCarBrand", SqlDbType.NVarChar, 1000).Value = dataArray[0] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pModel", SqlDbType.NVarChar, 1000).Value = dataArray[1] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pModelYear", SqlDbType.NVarChar, 4000).Value = dataArray[2] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pPrice", SqlDbType.NVarChar, 1000).Value = dataArray[3] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pMileage", SqlDbType.NVarChar, 1000).Value = dataArray[4] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pEngineSize", SqlDbType.NVarChar, 1000).Value = dataArray[5] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pColor", SqlDbType.NVarChar, 1000).Value = dataArray[6] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pBodyType", SqlDbType.NVarChar, 1000).Value = dataArray[7] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pEngineType", SqlDbType.NVarChar, 1000).Value = dataArray[8] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pTransmissionType", SqlDbType.NVarChar, 1000).Value = dataArray[9] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pDriveType", SqlDbType.NVarChar, 1000).Value = dataArray[10] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pDescription", SqlDbType.NVarChar, 4000).Value = dataArray[11] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pPageCreatedOn", SqlDbType.NVarChar, 1000).Value = dataArray[12] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pSiteUrl", SqlDbType.NVarChar, 4000).Value = url + i.ToString();
                    commandInsert.Parameters.Add("@pIsPageExist", SqlDbType.Bit).Value = true;
                    commandInsert.Parameters.Add("@pSellerType", SqlDbType.NVarChar, 1000).Value = dataArray[13] == null ? "частное" : "автохаус";
                    if (dataArray[14] != null)
                    {
                        if (dataArray[14].Contains("Кондиционер") || dataArray[14].Contains("климат-контроль"))
                            commandInsert.Parameters.Add("@pCondition", SqlDbType.NVarChar, 1000).Value = "1";
                        else
                            commandInsert.Parameters.Add("@pCondition", SqlDbType.NVarChar, 1000).Value = "0";
                    }
                    else
                    {
                        commandInsert.Parameters.Add("@pCondition", SqlDbType.NVarChar, 1000).Value = "0";
                    }
                    commandInsert.Parameters.Add("@pIsSwap", SqlDbType.NVarChar, 1000).Value = dataArray[15] == null ? "0" : "1";

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
            string[] xPathArray = new string[16];
            
            string connStr = ConfigurationManager.ConnectionStrings["FindAndFollowConnectionString"].ConnectionString;
            SqlConnection sqlConnection = new SqlConnection(connStr);

            SqlCommand commandSelect = new SqlCommand("CarParsingSettingsGet", sqlConnection);
            commandSelect.CommandType = CommandType.StoredProcedure;
            commandSelect.Parameters.AddWithValue("@pSiteUrl", Url);

            sqlConnection.Open();

            // Get data from db
            SqlDataReader dataReader = commandSelect.ExecuteReader();
            while (dataReader.Read())
            {
                xPathArray[0] = dataReader["CarBrandXPath"].ToString();
                xPathArray[1] = dataReader["ModelXPath"].ToString();
                xPathArray[2] = dataReader["ModelYearXPath"].ToString();
                xPathArray[3] = dataReader["PriceXPath"].ToString();
                xPathArray[4] = dataReader["MileageXPath"].ToString();
                xPathArray[5] = dataReader["EngineSizeXPath"].ToString();
                xPathArray[6] = dataReader["ColorXPath"].ToString();
                xPathArray[7] = dataReader["BodyTypeXPath"].ToString();
                xPathArray[8] = dataReader["EngineTypeXPath"].ToString();
                xPathArray[9] = dataReader["TransmissionTypeXPath"].ToString();
                xPathArray[10] = dataReader["DriveTypeXPath"].ToString();
                xPathArray[11] = dataReader["DescriptionXPath"].ToString();
                xPathArray[12] = dataReader["PageCreatedOnXPath"].ToString();
                xPathArray[13] = dataReader["PageCreatedOnXPath"].ToString();
                xPathArray[14] = dataReader["ConditionXPath"].ToString();
                xPathArray[15] = dataReader["IsSwapXPath"].ToString();
            }

            sqlConnection.Close();

            return xPathArray;
        }
    }
}
