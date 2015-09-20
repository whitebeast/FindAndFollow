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
//using System.Linq;
//using System.IO;

namespace FindAndFollow
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          // loading page..
        }

        public static List<string> getLinks(string url)
        {
            // upload web page
            var webGet = new HtmlWeb();
            webGet.OverrideEncoding = System.Text.Encoding.UTF8;
            var doc = webGet.Load(url);

            // get block with links
            HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode("/html[1]/body[1]/table[2]/tr[2]/table[4]/td[1]/td[2]/table[1]/tr[8]/td[1]");
            // get links
            HtmlNodeCollection oursNode = bodyNode.SelectNodes("/html[1]/body[1]/table[2]/tr[2]/table[4]/td[1]/td[2]/table[1]/tr[8]/td[1]//a[@href]");

            List<string> lst = new List<string>();
            foreach (HtmlNode href in oursNode)
            {
                lst.Add(href.Attributes["href"].Value);
            }

            return lst;
        }

        public static string getData(string url, string XPath, string contentType)
        {
            // upload web page
            var webGet = new HtmlWeb();
            var doc = webGet.Load(url);

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
            string urlPage = "http://www.av.by/public/search.php?event=Search&category_parent%5B0%5D=0&category_id%5B0%5D=0&year_id=0&year_id_max=0&engine_type_id2=1&engine_type_all=1&body_type_id=0&transmission_id=0&currency_id=USD&price_value=0&price_value_max=0&country_id=0&region_id=0&city_id2=0&order_id=0&submit_presearch=%CF%EE%EA%E0%E7%E0%F2%FC%3A+95138";
            List<string> lst = getLinks(urlPage);

            // TODO - run clean stored procedure from db

            // parser by contentType
            //foreach (string Url in lst)
            //{
            //    // Car Name 
            //    getData(Url, "/html[1]/head[1]/title[1]/#text[1]", "CarName");
            //}

            // INSERT Statement
            string insertStmt = "INSERT INTO dbo.UrlsTemp(OriginalURL) " + "VALUES(@URL)";
            
            // Set up SQL Server connection
            string connStr = ConfigurationManager.ConnectionStrings["FindAndFollowConnectionString"].ConnectionString;
            SqlConnection sqlConnection = new SqlConnection(connStr);
            
            sqlConnection.Open();
            SqlCommand commandInsert = new SqlCommand(insertStmt, sqlConnection);
            
            // Define parameters
            commandInsert.Parameters.Add("@URL", SqlDbType.VarChar, 1000);
            
            foreach (string Url in lst)
            {
                //commandInsert.Parameters["@URL"].Value = "http://www.av.by/public/" + Url;
                commandInsert.Parameters["@URL"].Value = getData("http://www.av.by/public/" + Url, "/html[1]/head[1]/title[1]", "CarName");

                // Run query
                commandInsert.ExecuteNonQuery();
            }
            
            sqlConnection.Close();
        }
    }
}