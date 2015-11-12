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
            }

            if (webSite == "av.by")
                returnArray[17] = GetOwnerPhoneAv(doc, xPathArray[17], url);

            if (webSite == "ab.onliner.by")
                returnArray[17] = GetOwnerPhoneAb(doc, xPathArray[17], url);

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


        public static string DownloadPage(string uri)
        {
            WebClient client = new WebClient();

            Stream data = client.OpenRead(uri);
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

        public static string GetOwnerPhoneAv(HtmlDocument doc, string xPath, string url)
        {
            HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode(xPath);

            List<string> lstOwnerPhones = bodyNode.SelectNodes(".//li").Select(node => node.InnerHtml).ToList();

            return Serialization.SerializePhoneAv(lstOwnerPhones, url);
        }

        public static string GetOwnerPhoneAb(HtmlDocument doc, string xPath, string url)
        {
            HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode(xPath);

            List<string> lstOwnerPhones = bodyNode.SelectNodes(".//span[@class='c-bl']").Select(node => node.InnerHtml).ToList();

            return Serialization.SerializePhoneAb(lstOwnerPhones, url);
        }

        public static string GetCarImagesAv(HtmlDocument doc, string xPath, string url)
        {
            HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode(xPath);

            List<string> lstCarImages = bodyNode.SelectNodes("a[@href]").Select(node => node.Attributes["href"].Value).ToList();

            return Serialization.SerializeCarImages(lstCarImages, url);
        }
    }
}
