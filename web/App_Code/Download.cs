using System;
using System.Net;
using HtmlAgilityPack;

namespace FindAndFollow
{
    public class Download
    {
        // Parsing data class
        public static string getData(string url, string XPath, string contentType)
        {
            // upload page
            WebClient webGet = new WebClient();
            webGet.Headers.Add("user-agent", "Mozilla/5.0 (Windows; Windows NT 5.1; rv:1.9.2.4) Gecko/20100611 Firefox/3.6.4");

            try
            {
                var html = webGet.DownloadString(url);
                HtmlDocument doc = new HtmlDocument();
                doc.LoadHtml(html);

                // get block with data
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
            catch (Exception e)
            {
                return "null";
            }
        }
    }
}