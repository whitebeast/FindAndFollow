using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HtmlAgilityPack; // need add reference
using System.Net;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;

namespace FindAndFollow
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          // loading page..
        }

        public static List<string> getLinks(string url, string siteName)
        {
            // upload web page
            var webGet = new HtmlWeb();
            webGet.OverrideEncoding = Encoding.UTF8;
            webGet.PreRequest += request =>
            {
                request.CookieContainer = new System.Net.CookieContainer();
                return true;
            };
            var doc = webGet.Load(url);

            List<string> lst = new List<string>();

            if (siteName == "av.by")
            {
                // get block with links
                HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode("/html[1]/body[1]/div[2]/div[1]/div[2]/div[1]/div[2]/div[2]");
                // get links
                HtmlNodeCollection oursNode = bodyNode.SelectNodes("/html[1]/body[1]/div[2]/div[1]/div[2]/div[1]/div[2]/div[2]//a[@href]");

                foreach (HtmlNode href in oursNode)
                {
                    lst.Add(href.Attributes["href"].Value);
                }
            }
            if (siteName == "abw.by")
            {
                // get block with links
                HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode("/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[3]/td[1]");
                // get links
                HtmlNodeCollection oursNode = bodyNode.SelectNodes("/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[3]/td[1]//a[@href]");

                foreach (HtmlNode href in oursNode)
                {
                    lst.Add(href.Attributes["href"].Value);
                }
            }
            if (siteName == "ab.onliner.by")
            {
                // get block with links
                HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode("/html[1]/body[1]/div[1]/div[1]/div[4]/div[1]/div[2]/div[1]/div[1]/div[2]/div[2]/table[1]");
                // get links
                HtmlNodeCollection oursNode = bodyNode.SelectNodes("/html[1]/body[1]/div[1]/div[1]/div[4]/div[1]/div[2]/div[1]/div[1]/div[2]/div[2]/table[1]//a[@href]");

                foreach (HtmlNode href in oursNode)
                {
                    lst.Add(href.Attributes["href"].Value);
                }
            }
            return lst;
        }

        public static string getData(string url, string XPath, string contentType)
        {
            // upload page
            WebClient webGet = new WebClient();
            webGet.Headers.Add("user-agent", "Mozilla/5.0 (Windows; Windows NT 5.1; rv:1.9.2.4) Gecko/20100611 Firefox/3.6.4");
            var html = webGet.DownloadString(url);
            HtmlDocument doc = new HtmlDocument();
            doc.LoadHtml(html);

            // get block with data
            HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode(XPath);
            if (bodyNode == null)
            {
                return "null!";
            }
            else
            {
                return bodyNode.InnerHtml;
            }
        }

        protected void BtnUploadData_Click(object sender, EventArgs e)
        {
            string urlPageAv = "http://www.av.by/public/search.php?event=Search&currency_id=USD";
            List<string> lstAv = getLinks(urlPageAv, "av.by");

            string urlPageAbw = "http://www.abw.by/index.php?set_small_form_1=1&act=public_search&do=search&index=1&adv_type=1&adv_group=&marka%5B%5D=&model%5B%5D=&type_engine=&transmission=&vol1=&vol2=&year1=1960&year2=2015&cost_val1=&cost_val2=&u_city=&period=&sort=&na_rf=&type_body=&privod=&probeg_col1=&probeg_col2=&key_word_a=";
            List<string> lstAbw = getLinks(urlPageAbw, "abw.by");

            string urlPageAb = "http://ab.onliner.by";
            List<string> lstAb = getLinks(urlPageAb, "ab.onliner.by");

            // TODO - run clean stored procedure from db

            // INSERT Statement
            string insertStmt = "INSERT INTO dbo.UrlsTemp(OriginalURL) VALUES(@URL)";
            
            // Set up SQL Server connection
            string connStr = ConfigurationManager.ConnectionStrings["FindAndFollowConnectionString"].ConnectionString;
            SqlConnection sqlConnection = new SqlConnection(connStr);
            
            sqlConnection.Open();
            SqlCommand commandInsert = new SqlCommand(insertStmt, sqlConnection);
            
            // Define parameters
            commandInsert.Parameters.Add("@URL", SqlDbType.NVarChar, 1000);

            // av.by
            foreach (string Url in lstAv)
            {
                commandInsert.Parameters["@URL"].Value = getData("http://www.av.by/public/" + Url,"/html[1]/body[1]/div[2]/div[1]/div[2]/div[1]/div[2]/header[1]/h1[1]", "CarName");
                commandInsert.ExecuteNonQuery();
            }
            
            // abw.by
            foreach (string Url in lstAbw)
            {
                commandInsert.Parameters["@URL"].Value = getData("http://www.abw.by/" + Url, "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[3]/p[1]/b[1]", "CarName");
                commandInsert.ExecuteNonQuery();
            }
            
            // ab.onliner.by
            foreach (string Url in lstAb)
            {
                commandInsert.Parameters["@URL"].Value = getData("http://www.ab.onliner.by/" + Url, "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[3]/p[1]/b[1]", "CarName");
                commandInsert.ExecuteNonQuery();
            }
            
            sqlConnection.Close();
        }
    }
}