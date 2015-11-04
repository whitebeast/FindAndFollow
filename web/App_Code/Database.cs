﻿using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace FindAndFollow
{
    public class Database
    {
        // db logic
        public static void CarParsingInsert(string url, string[] xPathArray, int startId, int finishId, string webSite)
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

            string[] dataArray;

            // Insert data
            for (int i = startId; i < finishId; i++)
            {
                if (Download.IsPageExist(url + i.ToString()))
                {
                    dataArray = Download.GetData(url + i.ToString(), xPathArray, webSite);

                    #region "if av.by"
                    if (webSite == "av.by")
                    {
                        dataArray[3] = StringClass.ConcatenateSpaces(StringClass.RemoveText(dataArray[3], "р.", url + i), url + i);
                        dataArray[4] = StringClass.RemoveText(dataArray[4], "км.", url + i);
                        dataArray[5] = StringClass.RemoveText(dataArray[5], "см", url + i);
                        dataArray[6] = StringClass.ColorGet(dataArray[6], url + i);
                        dataArray[7] = StringClass.BodyTypeGet(dataArray[7], url + i);
                        dataArray[8] = StringClass.EngineTypeGet(dataArray[8], url + i);
                        dataArray[9] = StringClass.TransmissionGet(dataArray[9], url + i);
                        dataArray[10] = StringClass.DriveTypeGet(dataArray[10], url + i);
                        dataArray[11] = StringClass.RemoveText(dataArray[11], "Комментарий продавца:", url + i);
                        dataArray[12] = StringClass.DatetimeFormat(StringClass.RemoveText(dataArray[12], "Добавлено: ", url + i), url + i);
                        dataArray[14] = StringClass.ConditionGetAv(StringClass.RemoveText(dataArray[4], "км.", url + i), url + i);
                    }
                    #endregion "if av.by"

                    #region "if abw.by"
                    if (webSite == "abw")
                    {
                        dataArray[3] = StringClass.MultiplyValue(StringClass.RemoveText(dataArray[3], " млн б.р.", url + i), 1000000, url + i);
                        dataArray[4] = StringClass.MultiplyValue(StringClass.RemoveText(dataArray[4], "тыс. км", url + i), 1000, url + i);
                        dataArray[5] = StringClass.RemoveText(dataArray[5], " см3", url + i);
                        dataArray[6] = StringClass.ColorGet(dataArray[6], url + i);
                        dataArray[7] = StringClass.BodyTypeGet(dataArray[7], url + i);
                        dataArray[8] = StringClass.EngineTypeGet(dataArray[8], url + i);
                        dataArray[9] = StringClass.TransmissionGet(dataArray[9], url + i);
                        dataArray[10] = StringClass.DriveTypeGet(dataArray[10], url + i);
                        dataArray[12] = StringClass.DatetimeFormat(StringClass.MonthConvert(StringClass.RemoveText(dataArray[12], "Размещено: ", url + i), url + i), url + i);
                        dataArray[14] = StringClass.ConditionGetAbw(dataArray[14], url + i);
                    }
                    #endregion "if abw.by"

                    #region "if ab.onliner.by"
                    if (webSite == "ab.onliner.by")
                    {
                        dataArray[0] = StringClass.SelectWordGet(dataArray[0], ' ', 1, url + i);
                        dataArray[1] = StringClass.SelectWordGet(dataArray[1], ' ', 2, url + i);
                        dataArray[3] = StringClass.ConcatenateSpaces(dataArray[3], url + i);
                        dataArray[4] = StringClass.ConcatenateSpaces(dataArray[4], url + i);
                        dataArray[5] = StringClass.MultiplyValue(dataArray[5], 1000, url + i);
                        dataArray[6] = StringClass.ColorGet(StringClass.SelectWordGet(dataArray[6], ',', 1, url + i), url + i);
                        dataArray[7] = StringClass.BodyTypeGet(StringClass.SelectWordGet(dataArray[7], ',', 2, url + i), url + i);
                        dataArray[8] = StringClass.EngineTypeGet(StringClass.SelectWordGet(dataArray[8], ',', 3, url + i), url + i);
                        dataArray[9] = StringClass.TransmissionGet(StringClass.SelectWordGet(dataArray[9], ',', 2, url + i), url + i);
                        dataArray[10] = StringClass.DriveTypeGet(StringClass.SelectWordGet(dataArray[10], ',', 3, url + i), url + i);
                        dataArray[12] = StringClass.DatetimeFormat(StringClass.MonthConvert(dataArray[12], url + i), url + i);
                        dataArray[14] = StringClass.ConditionGetAb(dataArray[14], url + i);
                    }
                    #endregion "if ab.onliner.by"

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
                    commandInsert.Parameters.Add("@pSiteID", SqlDbType.NVarChar, 50).Value = webSite;
                    commandInsert.Parameters.Add("@pIsPageExist", SqlDbType.Bit).Value = true;
                    commandInsert.Parameters.Add("@pSellerType", SqlDbType.NVarChar, 1000).Value = dataArray[13] == null ? "Частное" : "Автохаус";
                    commandInsert.Parameters.Add("@pCondition", SqlDbType.NVarChar, 1000).Value = dataArray[14] ?? sqlParameters[0].Value;
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
                    commandInsert.Parameters.Add("@pSiteID", SqlDbType.NVarChar, 50).Value = webSite;
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

        public static string[] CarParsingSettingsGet(string url)
        {
            string[] xPathArray = new string[16];

            string connStr = ConfigurationManager.ConnectionStrings["FindAndFollowConnectionString"].ConnectionString;
            SqlConnection sqlConnection = new SqlConnection(connStr);

            SqlCommand commandSelect = new SqlCommand("CarParsingSettingsGet", sqlConnection);
            commandSelect.CommandType = CommandType.StoredProcedure;
            commandSelect.Parameters.AddWithValue("@pSiteUrl", url);

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
                xPathArray[13] = dataReader["SellerTypeXPath"].ToString();
                xPathArray[14] = dataReader["ConditionXPath"].ToString();
                xPathArray[15] = dataReader["IsSwapXPath"].ToString();
            }

            sqlConnection.Close();

            return xPathArray;
        }

        public static string ErrorLogInsert(string exMessage, string exStackTrace, string url)
        {
            string connStr = ConfigurationManager.ConnectionStrings["FindAndFollowConnectionString"].ConnectionString;
            SqlConnection sqlConnection = new SqlConnection(connStr);

            SqlCommand commandInsert = new SqlCommand("ErrorLogInsert", sqlConnection);
            commandInsert.CommandType = CommandType.StoredProcedure;
            commandInsert.Parameters.AddWithValue("@pErrorNumber", 0);
            commandInsert.Parameters.AddWithValue("@pErrorObject", exStackTrace.Substring(6, exStackTrace.IndexOf(" in ")));
            commandInsert.Parameters.AddWithValue("@pIsService", Convert.ToBoolean(1));
            commandInsert.Parameters.AddWithValue("@pErrorMessageShort", url);
            commandInsert.Parameters.AddWithValue("@pErrorMessageFull", exStackTrace);

            sqlConnection.Open();
            commandInsert.ExecuteNonQuery();

            sqlConnection.Close();

            return null;
        }

        public static void CarMerge()
        {
            string connStr = ConfigurationManager.ConnectionStrings["FindAndFollowConnectionString"].ConnectionString;
            SqlConnection sqlConnection = new SqlConnection(connStr);

            sqlConnection.Open();

            SqlCommand commandInsert = new SqlCommand("CarParsingMergeCar", sqlConnection);
            commandInsert.CommandType = CommandType.StoredProcedure;

            commandInsert.ExecuteNonQuery();

            sqlConnection.Close();
        }

        public static int CarParsingSettingsCurrentIdGet(string url)
        {
            int currentId = new int();

            string connStr = ConfigurationManager.ConnectionStrings["FindAndFollowConnectionString"].ConnectionString;
            SqlConnection sqlConnection = new SqlConnection(connStr);

            SqlCommand commandSelect = new SqlCommand("CarParsingSettingsGet_CurrentId", sqlConnection);
            commandSelect.CommandType = CommandType.StoredProcedure;
            commandSelect.Parameters.AddWithValue("@pSiteUrl", url);

            sqlConnection.Open();

            // Get data from db
            SqlDataReader dataReader = commandSelect.ExecuteReader();
            while (dataReader.Read())
            {
                currentId = int.Parse(dataReader["CurrentID"].ToString());
            }

            sqlConnection.Close();

            return currentId;
        }
    }
}
