﻿using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace FindAndFollow
{
    public class Database
    {
        public static SqlCommand sqlCommandGet(string connectionString, string pocedureName)
        {
            string connStr = ConfigurationManager.ConnectionStrings[connectionString].ConnectionString;
            SqlConnection sqlConnection = new SqlConnection(connStr);

            sqlConnection.Open();

            SqlCommand command = new SqlCommand(pocedureName, sqlConnection);
            command.CommandType = CommandType.StoredProcedure;

            return command;
        }

        // db logic
        public static void CarParsingInsert(string url, string[] xPathArray, int startId, int finishId, string webSite)
        {
            SqlCommand commandInsert = sqlCommandGet("FindAndFollowConnectionString", "CarParsingInsert");

            // Set DB Null value
            SqlParameter[] sqlParameters = new SqlParameter[1];
            sqlParameters[0] = new SqlParameter("nvarchar", SqlDbType.NVarChar, 4000);
            sqlParameters[0].Value = DBNull.Value;

            // Insert data
            for (int i = startId; i < finishId; i++)
            {
                string urlFull = url + i;
                if (Download.IsPageExist(urlFull))
                {
                    var dataArray = Download.GetData(urlFull, xPathArray, webSite);

                    #region "if av.by"
                    if (webSite == "av.by")
                    {
                        dataArray[3] = StringClass.ConcatenateSpaces(StringClass.RemoveText(dataArray[3], "р.", urlFull), urlFull);
                        dataArray[4] = StringClass.RemoveText(dataArray[4], "км.", urlFull);
                        dataArray[5] = StringClass.RemoveText(dataArray[5], "см", urlFull);
                        dataArray[6] = StringClass.ColorGet(dataArray[6], urlFull);
                        dataArray[7] = StringClass.BodyTypeGet(dataArray[7], urlFull);
                        dataArray[8] = StringClass.EngineTypeGet(dataArray[8], urlFull);
                        dataArray[9] = StringClass.TransmissionGet(dataArray[9], urlFull);
                        dataArray[10] = StringClass.DriveTypeGet(dataArray[10], urlFull);
                        dataArray[11] = StringClass.RemoveText(dataArray[11], "Комментарий продавца:", urlFull);
                        dataArray[12] = StringClass.DatetimeFormat(StringClass.RemoveText(dataArray[12], "Добавлено: ", urlFull), urlFull);
                        dataArray[14] = StringClass.ConditionGetAv(StringClass.RemoveText(dataArray[4], "км.", urlFull), urlFull);
                    }
                    #endregion "if av.by"

                    #region "if abw.by"
                    if (webSite == "abw.by")
                    {
                        dataArray[3] = StringClass.MultiplyValue(StringClass.RemoveText(dataArray[3], " млн б.р.", urlFull), 1000000, urlFull);
                        dataArray[4] = StringClass.MultiplyValue(StringClass.RemoveText(dataArray[4], "тыс. км", urlFull), 1000, urlFull);
                        dataArray[5] = StringClass.RemoveText(dataArray[5], " см3", urlFull);
                        dataArray[6] = StringClass.ColorGet(dataArray[6], urlFull);
                        dataArray[7] = StringClass.BodyTypeGet(dataArray[7], urlFull);
                        dataArray[8] = StringClass.EngineTypeGet(dataArray[8], urlFull);
                        dataArray[9] = StringClass.TransmissionGet(dataArray[9], urlFull);
                        dataArray[10] = StringClass.DriveTypeGet(dataArray[10], urlFull);
                        dataArray[12] = StringClass.DatetimeFormat(StringClass.MonthConvert(StringClass.RemoveText(dataArray[12], "Размещено: ", urlFull), urlFull), urlFull);
                        dataArray[14] = StringClass.ConditionGetAbw(dataArray[14], urlFull);
                        dataArray[16] = StringClass.CityGetAbw(dataArray[16], urlFull);
                    }
                    #endregion "if abw.by"

                    #region "if ab.onliner.by"
                    if (webSite == "ab.onliner.by")
                    {
                        dataArray[0] = StringClass.SelectWordGet(dataArray[0], ' ', 1, urlFull);
                        dataArray[1] = StringClass.SelectWordGet(dataArray[1], ' ', 2, urlFull);
                        dataArray[3] = StringClass.ConcatenateSpaces(dataArray[3], urlFull);
                        dataArray[4] = StringClass.ConcatenateSpaces(dataArray[4], urlFull);
                        dataArray[5] = StringClass.MultiplyValue(dataArray[5], 1000, urlFull);
                        dataArray[6] = StringClass.ColorGet(StringClass.SelectWordGet(dataArray[6], ',', 1, urlFull), urlFull);
                        dataArray[7] = StringClass.BodyTypeGet(StringClass.SelectWordGet(dataArray[7], ',', 2, urlFull), urlFull);
                        dataArray[8] = StringClass.EngineTypeGet(StringClass.SelectWordGet(dataArray[8], ',', 3, urlFull), urlFull);
                        dataArray[9] = StringClass.TransmissionGet(StringClass.SelectWordGet(dataArray[9], ',', 2, urlFull), urlFull);
                        dataArray[10] = StringClass.DriveTypeGet(StringClass.SelectWordGet(dataArray[10], ',', 3, urlFull), urlFull);
                        dataArray[12] = StringClass.DatetimeFormat(StringClass.MonthConvert(dataArray[12], urlFull), urlFull);
                        dataArray[14] = StringClass.ConditionGetAb(dataArray[14], urlFull);
                        dataArray[16] = StringClass.RemoveText(StringClass.SelectWordGet(dataArray[16], ' ', 1, urlFull), ",", urlFull);
                    }
                    #endregion "if ab.onliner.by"

                    commandInsert.Parameters.Add("@pCarBrand", SqlDbType.NVarChar, 50).Value = dataArray[0] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pModel", SqlDbType.NVarChar, 50).Value = dataArray[1] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pModelYear", SqlDbType.NVarChar, 4).Value = dataArray[2] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pPrice", SqlDbType.NVarChar, 100).Value = dataArray[3] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pMileage", SqlDbType.NVarChar, 100).Value = dataArray[4] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pEngineSize", SqlDbType.NVarChar, 5).Value = dataArray[5] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pColor", SqlDbType.NVarChar, 100).Value = dataArray[6] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pBodyType", SqlDbType.NVarChar, 100).Value = dataArray[7] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pEngineType", SqlDbType.NVarChar, 100).Value = dataArray[8] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pTransmissionType", SqlDbType.NVarChar, 100).Value = dataArray[9] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pDriveType", SqlDbType.NVarChar, 100).Value = dataArray[10] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pDescription", SqlDbType.NVarChar, 1000).Value = dataArray[11] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pPageCreatedOn", SqlDbType.NVarChar, 100).Value = dataArray[12] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pSiteUrl", SqlDbType.NVarChar, 2000).Value = urlFull;
                    commandInsert.Parameters.Add("@pSiteID", SqlDbType.NVarChar, 50).Value = webSite;
                    commandInsert.Parameters.Add("@pIsPageExist", SqlDbType.Bit).Value = true;
                    commandInsert.Parameters.Add("@pSellerType", SqlDbType.NVarChar, 100).Value = dataArray[13] == null ? "Частное" : "Автохаус";
                    commandInsert.Parameters.Add("@pCondition", SqlDbType.NVarChar, 100).Value = dataArray[14] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pIsSwap", SqlDbType.NVarChar, 1).Value = dataArray[15] == null ? "0" : "1";
                    commandInsert.Parameters.Add("@pCity", SqlDbType.NVarChar, 100).Value = dataArray[16] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pOwnerPhone", SqlDbType.NVarChar, 100).Value = dataArray[17] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pCarImages", SqlDbType.NVarChar, 4000).Value = dataArray[18] ?? sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pOptionList", SqlDbType.NVarChar, 4000).Value = dataArray[19] ?? sqlParameters[0].Value;

                    commandInsert.ExecuteNonQuery();
                }
                else
                {
                    commandInsert.Parameters.Add("@pCarBrand", SqlDbType.NVarChar, 50).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pModel", SqlDbType.NVarChar, 50).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pModelYear", SqlDbType.NVarChar, 4).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pPrice", SqlDbType.NVarChar, 100).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pMileage", SqlDbType.NVarChar, 100).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pEngineSize", SqlDbType.NVarChar, 5).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pColor", SqlDbType.NVarChar, 100).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pBodyType", SqlDbType.NVarChar, 100).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pEngineType", SqlDbType.NVarChar, 100).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pTransmissionType", SqlDbType.NVarChar, 100).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pDriveType", SqlDbType.NVarChar, 100).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pDescription", SqlDbType.NVarChar, 1000).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pPageCreatedOn", SqlDbType.NVarChar, 100).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pSiteUrl", SqlDbType.NVarChar, 2000).Value = urlFull;
                    commandInsert.Parameters.Add("@pSiteID", SqlDbType.NVarChar, 50).Value = webSite;
                    commandInsert.Parameters.Add("@pIsPageExist", SqlDbType.Bit).Value = false;
                    commandInsert.Parameters.Add("@pSellerType", SqlDbType.NVarChar, 100).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pCondition", SqlDbType.NVarChar, 100).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pIsSwap", SqlDbType.NVarChar, 1).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pCity", SqlDbType.NVarChar, 100).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pOwnerPhone", SqlDbType.NVarChar, 100).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pCarImages", SqlDbType.NVarChar, 4000).Value = sqlParameters[0].Value;
                    commandInsert.Parameters.Add("@pOptionList", SqlDbType.NVarChar, 4000).Value = sqlParameters[0].Value;

                    commandInsert.ExecuteNonQuery();
                    }
            }
        }

        public static void CarParsingClean()
        {
            SqlCommand commandDelete = sqlCommandGet("FindAndFollowConnectionString", "CarParsingClean");
            commandDelete.ExecuteNonQuery();
        }

        public static string[] CarParsingSettingsGet(string url)
        {
            string[] xPathArray = new string[20];

            SqlCommand commandSelect = sqlCommandGet("FindAndFollowConnectionString", "CarParsingSettingsGet");

            commandSelect.Parameters.AddWithValue("@pSiteUrl", url);

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
                xPathArray[16] = dataReader["CityXPath"].ToString();
                xPathArray[17] = dataReader["OwnerPhoneXPath"].ToString();
                xPathArray[18] = dataReader["CarImagesXPath"].ToString();
                xPathArray[19] = dataReader["OptionListXPath"].ToString();
            }

            return xPathArray;
        }

        public static string ErrorLogInsert(string exMessage, string exStackTrace, string url)
        {
            SqlCommand commandInsert = sqlCommandGet("FindAndFollowConnectionString", "ErrorLogInsert");

            commandInsert.Parameters.AddWithValue("@pErrorNumber", 0);
            commandInsert.Parameters.AddWithValue("@pErrorObject", exStackTrace.Substring(6, exStackTrace.IndexOf(" in ", StringComparison.Ordinal)));
            commandInsert.Parameters.AddWithValue("@pIsService", Convert.ToBoolean(1));
            commandInsert.Parameters.AddWithValue("@pErrorMessageShort", url);
            commandInsert.Parameters.AddWithValue("@pErrorMessageFull", exStackTrace);

            commandInsert.ExecuteNonQuery();

            return null;
        }

        public static void CarMerge()
        {
            SqlCommand commandInsert = sqlCommandGet("FindAndFollowConnectionString", "CarParsingMergeCar");
            commandInsert.ExecuteNonQuery();
        }

        public static int CarParsingSettingsCurrentIdGet(string url)
        {
            int currentId = new int();

            SqlCommand commandSelect = sqlCommandGet("FindAndFollowConnectionString", "CarParsingSettingsGet_CurrentId");
            commandSelect.Parameters.AddWithValue("@pSiteUrl", url);

            // Get data from db
            SqlDataReader dataReader = commandSelect.ExecuteReader();
            while (dataReader.Read())
            {
                currentId = int.Parse(dataReader["CurrentID"].ToString());
            }

            return currentId;
        }
    }
}
