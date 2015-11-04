using System;
using System.IO;
using System.Net;
using HtmlAgilityPack;
using System.Collections.Generic;

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
                var html = webGet.DownloadString(url);
                doc.LoadHtml(html);
            }

            string[] returnArray = new string[xPathArray.Length];

            string[] returnArrayAbw = new string[9];
            if (webSite == "abw") 
                returnArrayAbw = GetDataAbw("//*[@id=\"news\"]/tr[2]/td/div[2]/table", doc);

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

            if (webSite == "abw")
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
            StreamReader reader = new StreamReader(data);
            string s = reader.ReadToEnd();
            data.Close();
            reader.Close();
            return s;
        }

        public static string[] GetDataAbw(string xPath, HtmlDocument doc)
        {
            HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode(xPath);

            List<int> lstCarParams = new List<int>();

            int counter = 0;

            foreach (HtmlNode node in bodyNode.SelectNodes("//td[@class='adv_left']")) 
            {
                switch (node.InnerText)
                {
                    case ("Год выпуска:"): lstCarParams.Insert(0, counter);
                        break;
                    case ("Цвет:"): lstCarParams.Insert(1, counter);
                        break;
                    case ("Пробег:"): lstCarParams.Insert(2, counter);
                        break;
                    case ("Двигатель:"): lstCarParams.Insert(3, counter);
                        break;
                    case ("Объем:"): lstCarParams.Insert(4, counter);
                        break;
                    case ("Трансмиссия:"): lstCarParams.Insert(5, counter);
                        break;
                    case ("Кузов:"): lstCarParams.Insert(6, counter);
                        break;
                    case ("Привод:"): lstCarParams.Insert(7, counter);
                        break;
                    case ("Состояние:"): lstCarParams.Insert(8, counter);
                        break;
                }

                counter++;
            }

            counter = 0;

            List<string> lstCarValues = new List<string>();

            foreach (HtmlNode node in bodyNode.SelectNodes("//td[@class='adv_right']"))
            {
                if (counter == lstCarParams[0]) lstCarValues.Insert(0, node.InnerHtml);
                if (counter == lstCarParams[1]) lstCarValues.Insert(1, node.InnerHtml);
                if (counter == lstCarParams[2]) lstCarValues.Insert(2, node.InnerHtml);
                if (counter == lstCarParams[3]) lstCarValues.Insert(3, node.InnerHtml);
                if (counter == lstCarParams[4]) lstCarValues.Insert(4, node.InnerHtml);
                if (counter == lstCarParams[5]) lstCarValues.Insert(5, node.InnerHtml);
                if (counter == lstCarParams[6]) lstCarValues.Insert(6, node.InnerHtml);
                if (counter == lstCarParams[7]) lstCarValues.Insert(7, node.InnerHtml);
                if (counter == lstCarParams[8]) lstCarValues.Insert(8, node.InnerHtml);

                counter++;
            }

            return lstCarValues.ToArray();
        }

    }
}
