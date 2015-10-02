using System;
using System.Net;
using HtmlAgilityPack;

public class Download
{
    public static string getData(string url, string XPath, string contentType)
    {
        // Upload page
        WebClient webGet = new WebClient();
        webGet.Headers.Add("user-agent", "Mozilla/5.0 (Windows; Windows NT 5.1; rv:1.9.2.4) Gecko/20100611 Firefox/3.6.4");

        try
        {
            var html = webGet.DownloadString(url);
            HtmlDocument doc = new HtmlDocument();
            doc.LoadHtml(html);

            // Get block with data
            HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode(XPath);
            if (bodyNode == null)
            {
                return "null";
            }
            else
            {
                return bodyNode.InnerHtml;
            }
        }
        catch (Exception)
        {
            return "null";
        }
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
