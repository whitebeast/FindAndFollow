using System;
using System.Net;
using HtmlAgilityPack;
using System.Data.SqlClient;

public class Download
{
    public static string[] getData(string url, string[] XPathArray, string contentType)
    {
        // Upload page
        WebClient webGet = new WebClient();
        webGet.Headers.Add("user-agent", "Mozilla/5.0 (Windows; Windows NT 5.1; rv:1.9.2.4) Gecko/20100611 Firefox/3.6.4");

        var html = webGet.DownloadString(url);
        HtmlDocument doc = new HtmlDocument();
        doc.LoadHtml(html);

        string[] returnArray = new string[XPathArray.Length];

        for (int i = 0; i < XPathArray.Length ;i++)
        {
            try
            {
                // Get block with data
                HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode(XPathArray[i]);
                if (bodyNode == null)
                {
                    returnArray[i] = null;
                }
                else
                {
                    returnArray[i] = bodyNode.InnerHtml;
                }
            }
            catch (Exception)
            {
                returnArray[i] = null;
            }
        }
        return returnArray;
    }

    public static bool isPageExist(string url)
    {
        try
        {
            //Creating the HttpWebRequest
            HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;
            //Setting the Request method HEAD, you can also use GET too.
            request.Method = "HEAD";
            //Getting the Web Response.
            HttpWebResponse response = request.GetResponse() as HttpWebResponse;
            //Returns TRUE if the Status code == 200
            return (response.StatusCode == HttpStatusCode.OK);
        }
        catch
        {
            //Any exception will returns false.
            return false;
        }
    }
}
