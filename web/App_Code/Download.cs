using System;
using System.IO;
using System.Net;
using HtmlAgilityPack;
using System.Collections.Generic;
using System.Linq;

namespace FindAndFollow
{
    public class Download
    {
        public static string[] GetData(string url, string[] xPathArray, string webSite)
        {
            WebClient webGet = new WebClient();
            HtmlDocument doc = new HtmlDocument();

            webGet.Headers.Add("user-agent", "Mozilla/5.0 (Windows; Windows NT 5.1; rv:1.9.2.4) Gecko/20100611 Firefox/3.6.4");

            if (webSite == "ab.onliner.by")
            {
                webGet.Encoding = System.Text.Encoding.UTF8;
                doc.LoadHtml(DownloadPage(url));
            }
            else
            {
                try
                {
                    var html = webGet.DownloadString(url);
                    doc.LoadHtml(html);
                }
                catch (Exception ex)
                {
                   Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
                }
            }

            string[] returnArray = new string[xPathArray.Length];

            string[] returnArrayAbw = new string[9];
            if (webSite == "abw.by")
                returnArrayAbw = GetDataAbw("/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[3]", doc);

            for (int i = 0; i < xPathArray.Length; i++)
            {
                try
                {
                    HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode(xPathArray[i]);
                    returnArray[i] = bodyNode.InnerHtml.Trim();
                }
                catch (Exception)
                {
                    returnArray[i] = null;
                }
            }

            if (webSite == "av.by")
            {
                returnArray[16] = CityGetGetAv(doc, xPathArray[16], url);
                returnArray[17] = OwnerPhoneGetAv(doc, xPathArray[17], url);
                returnArray[18] = CarImagesGet(doc, xPathArray[18], url, "a[@href]", "href");
                returnArray[19] = OptionListGetAv(doc, xPathArray[19], url);
            }

            if (webSite == "abw.by")
            {
                returnArray[2] = returnArrayAbw[0];
                returnArray[4] = returnArrayAbw[2];
                returnArray[5] = returnArrayAbw[4];
                returnArray[6] = returnArrayAbw[1];
                returnArray[7] = returnArrayAbw[6];
                returnArray[8] = returnArrayAbw[3];
                returnArray[9] = returnArrayAbw[5];
                returnArray[10] = returnArrayAbw[7];
                returnArray[14] = returnArrayAbw[8];
                returnArray[18] = CarImagesGet(doc, xPathArray[18], url, ".//a[@rel='group']", "href");
                returnArray[19] = OptionListGetAbw(doc, xPathArray[19], url);
            }

            if (webSite == "ab.onliner.by")
            {
                returnArray[17] = OwnerPhoneGetAb(doc, xPathArray[17], url);
                returnArray[18] = CarImagesGet(doc, xPathArray[18], url, ".//img[@src]", "src");
                returnArray[19] = OptionListGetAb(doc, xPathArray[19], url);
            }

            return returnArray;
        }

        public static bool IsPageExist(string url)
        {
            try
            {
                HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;
                request.Method = "HEAD";
                HttpWebResponse response = request.GetResponse() as HttpWebResponse;
                //Returns TRUE if the Status code == 200
                return (response.StatusCode == HttpStatusCode.OK);
            }
            catch
            {
                return false;
            }
        }

        public static bool IsContentExist(string url, string xPath, string webSite)
        {
            WebClient webGet = new WebClient();
            HtmlDocument doc = new HtmlDocument();

            webGet.Headers.Add("user-agent", "Mozilla/5.0 (Windows; Windows NT 5.1; rv:1.9.2.4) Gecko/20100611 Firefox/3.6.4");

            if (webSite == "ab.onliner.by")
            {
                webGet.Encoding = System.Text.Encoding.UTF8;
                doc.LoadHtml(DownloadPage(url));
            }
            else
            {
                try
                {
                    var html = webGet.DownloadString(url);
                    doc.LoadHtml(html);
                }
                catch (Exception ex)
                {
                    Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
                }
            }
            // xPath = /html[1]/body[1]/div[2]/div[1]/div[2]/div[1]/div[2]/div[1]
            HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode(xPath);
            if (bodyNode == null)
            {
                return true;
            }
            string pageText = bodyNode.InnerHtml;

            // *Объявление №11009027 не найдено !*
            if (pageText.Contains("не найдено"))
            {
                return false;
            }
            else
            {
                return true;
            }
        }


        public static string DownloadPage(string url)
        {
            WebClient client = new WebClient();

            Stream data = client.OpenRead(url);
            if (data != null)
            {
                StreamReader reader = new StreamReader(data);
                string s = reader.ReadToEnd();
                data.Close();
                reader.Close();
                return s;
            }
            else
            {
                return "404";
            }
        }

        public static string[] GetDataAbw(string xPath, HtmlDocument doc)
        {
            HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode(xPath);

            List<string> lstCarParams = new List<string>();

            int counter = 0;

            foreach (HtmlNode node in bodyNode.SelectNodes("//td[@class='adv_left']")) 
            {
                switch (node.InnerText)
                {
                    case ("Год выпуска:"): lstCarParams.Insert(counter, "modelYear");
                        break;
                    case ("Цвет:"): lstCarParams.Insert(counter, "color");
                        break;
                    case ("Пробег:"): lstCarParams.Insert(counter, "mileAge");
                        break;
                    case ("Двигатель:"): lstCarParams.Insert(counter, "engineType");
                        break;
                    case ("Объем:"): lstCarParams.Insert(counter, "engineSize");
                        break;
                    case ("Трансмиссия:"): lstCarParams.Insert(counter, "transmission");
                        break;
                    case ("Кузов:"): lstCarParams.Insert(counter, "bodyType");
                        break;
                    case ("Привод:"): lstCarParams.Insert(counter, "driveType");
                        break;
                    case ("Состояние:"): lstCarParams.Insert(counter, "condition");
                        break;
                    default: lstCarParams.Insert(counter, "other");
                        break;
                }

                counter++;
            }

            counter = 0;

            List<string> lstCarValues = new List<string>();
            for (int i = 0; i < 9; i++)
            {
                lstCarValues.Insert(i, "");
            }

            foreach (HtmlNode node in bodyNode.SelectNodes("//td[@class='adv_right']"))
            {
                switch (lstCarParams[counter])
                {
                    case ("modelYear"): lstCarValues[0] = node.InnerHtml;
                        break;
                    case ("color"): lstCarValues[1] = node.InnerHtml;
                        break;
                    case ("mileAge"): lstCarValues[2] = node.InnerHtml;
                        break;
                    case ("engineType"): lstCarValues[3] = node.InnerHtml;
                        break;
                    case ("engineSize"): lstCarValues[4] = node.InnerHtml;
                        break;
                    case ("transmission"): lstCarValues[5] = node.InnerHtml;
                        break;
                    case ("bodyType"): lstCarValues[6] = node.InnerHtml;
                        break;
                    case ("driveType"): lstCarValues[7] = node.InnerHtml;
                        break;
                    case ("condition"): lstCarValues[8] = node.InnerHtml;
                        break;
                }

                counter++;
            }

            return lstCarValues.ToArray();
        }

        public static string OwnerPhoneGetAv(HtmlDocument doc, string xPath, string url)
        {
            HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode(xPath);

            try
            {
                List<string> lstOwnerPhones = bodyNode.SelectNodes(".//li").Select(node => node.InnerHtml).ToList();
                return Serialization.PhoneSerializeAv(lstOwnerPhones, url);
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string OwnerPhoneGetAb(HtmlDocument doc, string xPath, string url)
        {
            HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode(xPath);

            try
            {
                List<string> lstOwnerPhones = bodyNode.SelectNodes(".//span[@class='c-bl']").Select(node => node.InnerHtml).ToList();
                return Serialization.PhoneSerializeAb(lstOwnerPhones, url);
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string CarImagesGet(HtmlDocument doc, string xPath, string url, string nodeValue, string attributeValue)
        {
            HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode(xPath);

            // check for empty page
            if (bodyNode == null || bodyNode.SelectSingleNode(nodeValue) == null)
                return "[{\"imageUrl\":\"\"}]";

            try
            {
                List<string> lstCarImages = bodyNode.SelectNodes(nodeValue).Select(node => node.Attributes[attributeValue].Value).ToList();
                return Serialization.CarImagesSerialize(lstCarImages, url);
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string OptionListGetAv(HtmlDocument doc, string xPath, string url)
        {
            HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode(xPath);

            // check for empty page
            if (bodyNode == null || bodyNode.SelectSingleNode(".//li") == null)
                return "[{\"optionValue\":\"\"}]";

            try
            {
                List<string> lstOwnerPhones = bodyNode.SelectNodes(".//li").Select(node => node.InnerHtml).ToList();
                return Serialization.CarOptionListSerialize(lstOwnerPhones, url);
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string OptionListGetAbw(HtmlDocument doc, string xPath, string url)
        {
            HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode(xPath);

            // check for empty page
            if (bodyNode == null)
                return "[{\"optionValue\":\"\"}]";

            try
            {
                List<string> lstOwnerPhones = bodyNode.SelectNodes(".//tr/td").Select(node => StringClass.RemoveText(node.InnerHtml, "-", url)).ToList();
                return Serialization.CarOptionListSerialize(lstOwnerPhones, url);
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string OptionListGetAb(HtmlDocument doc, string xPath, string url)
        {
            HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode(xPath);

            // check for empty page
            if (bodyNode == null)
                return "[{\"optionValue\":\"\"}]";

            try
            {
                List<string> lstOwnerPhones = bodyNode.SelectNodes(".//li[not(@class='none')]").Select(node => node.InnerHtml).ToList();
                return Serialization.CarOptionListSerialize(lstOwnerPhones, url);
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static int[] UrlsGet(string url, string xPath, string webSite, string nodeValue, string attributeValue, string removeText)
        {
            WebClient webGet = new WebClient();
            HtmlDocument doc = new HtmlDocument();

            webGet.Headers.Add("user-agent", "Mozilla/5.0 (Windows; Windows NT 5.1; rv:1.9.2.4) Gecko/20100611 Firefox/3.6.4");

            if (webSite == "ab.onliner.by")
            {
                webGet.Encoding = System.Text.Encoding.UTF8;
                doc.LoadHtml(DownloadPage(url));
            }
            else
            {
                try
                {
                    var html = webGet.DownloadString(url);
                    doc.LoadHtml(html);
                }
                catch (Exception ex)
                {
                    Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
                }
            }

            HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode(xPath);

            // noveValue= .//div[@class='b-listing-item-title']//a[@href]
            // attributeValue = href
            // removeText = public.php?event=View&public_id=
            List<string> lstUrls = bodyNode.SelectNodes(nodeValue).Select(node => StringClass.RemoveText(node.Attributes[attributeValue].Value, removeText, url)).ToList();

            // convert to int
            for (int i = 0; i < lstUrls.Count; i++)
            {
                lstUrls[i] = StringClass.ReplaceText(lstUrls[i], "/", "", url);
            }

            int[] ids = Array.ConvertAll(lstUrls.ToArray(), int.Parse);

            return ids;
        }

        public static string CityGetGetAv(HtmlDocument doc, string xPath, string url)
        {
            HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode(xPath);

            try
            {
                List<string> lstCities = bodyNode.SelectNodes(".//p").Select(node => node.InnerHtml).ToList();
                
                //return Serialization.CarOptionListSerialize(lstCities, url);
                return lstCities.Last();
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

    }
}
