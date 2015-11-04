using System;
using System.IO;
using System.Net;
using HtmlAgilityPack;
using System.Collections.Generic;
using System.Linq;
using System.Collections;

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

        public static string[] GetDataAbw(string url, string xPath, string webSite)
        {
            WebClient webGet = new WebClient();
            HtmlDocument doc = new HtmlDocument();

            string[] returnArray = new string[10];

            webGet.Headers.Add("user-agent", "Mozilla/5.0 (Windows; Windows NT 5.1; rv:1.9.2.4) Gecko/20100611 Firefox/3.6.4");

            //http://www.abw.by/allpublic/sell/8281453/
            // //*[@id="news"]/tr[2]/td/div[2]/table
            var html = webGet.DownloadString("http://www.abw.by/allpublic/sell/8281453/");
            doc.LoadHtml(html);

            HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode("//*[@id=\"news\"]/tr[2]/td/div[2]/table");

            List<int> lstCapParams = new List<int>();

            int counter = 0;

            foreach (HtmlNode node in bodyNode.SelectNodes("//td[@class='adv_left']")) 
            {
                switch (node.InnerText)
                {
                    case ("Год выпуска:"): lstCapParams.Insert(0, counter);
                        break;
                    case ("Цвет:"): lstCapParams.Insert(1, counter);
                        break;
                    case ("Пробег:"): lstCapParams.Insert(2, counter);
                        break;
                    case ("Двигатель:"): lstCapParams.Insert(3, counter);
                        break;
                    case ("Объем:"): lstCapParams.Insert(4, counter);
                        break;
                    case ("Трансмиссия:"): lstCapParams.Insert(5, counter);
                        break;
                    case ("Кузов:"): lstCapParams.Insert(6, counter);
                        break;
                    case ("Привод:"): lstCapParams.Insert(7, counter);
                        break;
                    case ("Состояние:"): lstCapParams.Insert(8, counter);
                        break;
                }

                counter++;
            }

            counter = 0;

            List<string> lstCapValues = new List<string>();

            foreach (HtmlNode node in bodyNode.SelectNodes("//td[@class='adv_right']"))
            {
                if (counter == lstCapParams[0]) lstCapValues.Insert(0, node.InnerHtml);
                if (counter == lstCapParams[1]) lstCapValues.Insert(1, node.InnerHtml);
                if (counter == lstCapParams[2]) lstCapValues.Insert(2, node.InnerHtml);
                if (counter == lstCapParams[3]) lstCapValues.Insert(3, node.InnerHtml);
                if (counter == lstCapParams[4]) lstCapValues.Insert(4, node.InnerHtml);
                if (counter == lstCapParams[5]) lstCapValues.Insert(5, node.InnerHtml);
                if (counter == lstCapParams[6]) lstCapValues.Insert(6, node.InnerHtml);
                if (counter == lstCapParams[7]) lstCapValues.Insert(7, node.InnerHtml);
                if (counter == lstCapParams[8]) lstCapValues.Insert(8, node.InnerHtml);

                counter++;
            }

            return lstCapValues.ToArray();
        }

    }
}
