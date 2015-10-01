using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace FindAndFollow
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // loading page..
        }

        protected void BtnUploadData_Click(object sender, EventArgs e)
        {
            // INSERT Statement
            string insertStmt = "INSERT INTO dbo.UrlsTemp(OriginalURL) VALUES(NULLIF(@URL, 'null'))";

            // Set up SQL Server connection
            string connStr = ConfigurationManager.ConnectionStrings["FindAndFollowConnectionString"].ConnectionString;
            SqlConnection sqlConnection = new SqlConnection(connStr);

            sqlConnection.Open();
            SqlCommand commandInsert = new SqlCommand(insertStmt, sqlConnection);

            // Define parameters
            commandInsert.Parameters.Add("@URL", SqlDbType.NVarChar, 1000);

            // av.by
            for (int i = 10707100; i < 10707116; i++)
            {
                commandInsert.Parameters["@URL"].Value = Download.getData("http://www.av.by/public/public.php?event=View&public_id=" + i.ToString(), "/html[1]/body[1]/div[2]/div[1]/div[2]/div[1]/div[2]/header[1]/h1[1]", "CarName");
                commandInsert.ExecuteNonQuery();
            }

            // abw.by
            for (int i = 8155541; i < 8155561; i++)
            {
                commandInsert.Parameters["@URL"].Value = Download.getData("http://www.abw.by/allpublic/sell/" + i.ToString(), "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[3]/p[1]/b[1]", "CarName");
                commandInsert.ExecuteNonQuery();
            }

            // ab.onliner.by
            for (int i = 2328800; i < 2328850; i++)
            {
                commandInsert.Parameters["@URL"].Value = Download.getData("http://ab.onliner.by/car/" + i.ToString(), "//*[@id='minWidth']/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[1]/span[1]/strong", "CarName");
                commandInsert.ExecuteNonQuery();
            }

            sqlConnection.Close();

            // TODO add call stored procedure for clean "left" data
        }

    }
}