using System;
using System.Net;
using HtmlAgilityPack;
using System.IO;

public class Download
{
    public static string[] GetData(string url, string[] XPathArray, string webSite)
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

        string[] returnArray = new string[XPathArray.Length];

        for (int i = 0; i < XPathArray.Length; i++)
        {
            try
            {
                HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode(XPathArray[i]);
                returnArray[i] = bodyNode.InnerHtml;
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
}
