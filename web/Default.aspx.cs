using System;
using System.Collections.Generic;

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
            string avUrl = "http://www.av.by/public/public.php?event=View&public_id=";
            string abwUrl = "http://www.abw.by/allpublic/sell/";
            string abUrl = "http://ab.onliner.by/car/";

            string[] XPathArray = new string[10];
            XPathArray[0] = "/html[1]/body[1]/div[2]/div[1]/div[2]/div[1]/div[2]/header[1]/h1[1]";              // CarBrand
            XPathArray[1] = "/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[2]/dl[1]/dd";         // ModelYear
            XPathArray[2] = "/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[1]/div[1]/span";    // Price
            XPathArray[3] = "/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[2]/dl[2]/dd";         // Mileage
            XPathArray[4] = "/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[2]/dl[3]/dd/text()";  // EngineSize
            
            Database.CarParsingInsert(avUrl, XPathArray, 10707100, 10707116);
            //Database.CarParsingInsert(abwUrl, "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[3]/p[1]/b[1]", 8155541, 8155561);
            //Database.CarParsingInsert(abUrl, "//*[@id='minWidth']/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[1]/span[1]/strong", 2328800, 2328850);

            Database.CarParsingClean();
        }
    }
}