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

            string[] XPathArray = new string[16];

            // av.by
            XPathArray[0] = "/html/body/div[2]/div[1]/div[2]/div/div[2]/div[1]/ul/li[2]/a";                                                     // CarBrand
            XPathArray[1] = "/html/body/div[2]/div[1]/div[2]/div/div[2]/div[1]/ul/li[3]/a";                                                     // Model
            XPathArray[2] = "/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[2]/dl[1]/dd";                                         // ModelYear
            XPathArray[3] = "/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[1]/div[1]/span";                                      // Price
            XPathArray[4] = "/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[2]/dl[2]/dd";                                         // Mileage
            XPathArray[5] = "/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[2]/dl[3]/dd/text()";                                  // EngineSize
            XPathArray[6] = "/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[2]/dl[4]/dd";                                         // Color
            XPathArray[7] = "/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[2]/dl[5]/dd";                                         // BodyType
            XPathArray[8] = "/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[2]/dl[6]/dd";                                         // EngineType
            XPathArray[9] = "/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[2]/dl[9]/dd";                                         // TransmissionType
            XPathArray[10] = "/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[2]/dl[11]/dd";                                       // DriveType
            XPathArray[11] = "/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[2]/div[3]/h4";                                              // Description
            XPathArray[12] = "/html/body/div[2]/div[1]/div[2]/div/div[2]/header/ul/li[3]";                                                      // CreatedOn
            XPathArray[13] = "/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[3]/small/text()[2]";                                 // SellerType
            XPathArray[14] = "/html[1]/body[1]/div[2]/div[1]/div[2]/div[1]/div[2]/div[2]/div[2]/div[3]/ul[3]";                                  // Condition
            XPathArray[15] = "/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[4]/h5";                                              // IsSwap

            Database.CarParsingInsert(avUrl, XPathArray, 10757949, 10757950, "av.by");
            
            // abw.by
            string[] CheckSellerTypeArray = new string[1];
            CheckSellerTypeArray[0] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[2]/tr[1]/td[1]/script[2]";
            CheckSellerTypeArray = Download.GetData(abwUrl + "6776158", CheckSellerTypeArray, "abw.by");

            if (CheckSellerTypeArray[0] == null)
            {
                // private
                XPathArray[0] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[3]/tr[1]/td[1]/div[1]/span[1]/a[1]";          // CarBrand
                XPathArray[1] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[3]/tr[1]/td[1]/div[1]/span[1]/a[2]";          // Model
                XPathArray[2] = "//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[1]/td[2]";                                                          // ModelYear
                XPathArray[3] = "//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[11]/td[2]/div/span[2]";                                             // Price
                XPathArray[4] = "//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[3]/td[2]";                                                          // Mileage
                XPathArray[5] = "//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[5]/td[2]";                                                          // EngineSize
                XPathArray[6] = "//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[2]/td[2]";                                                          // Color
                XPathArray[7] = "//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[8]/td[2]";                                                          // BodyType
                XPathArray[8] = "//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[4]/td[2]";                                                          // EngineType
                XPathArray[9] = "//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[7]/td[2]";                                                          // TransmissionType
                XPathArray[10] = "//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[10]/td[2]";                                                        // DriveType
                XPathArray[11] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[5]/font[1]";                                   // Description
                XPathArray[12] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/p[5]";                                             // CreatedOn
                XPathArray[13] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[2]/tr[1]/td[1]/script[2]";                   // SellerType
                XPathArray[14] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[4]/table[1]/tbody[1]";                         // Condition
                XPathArray[15] = "empty";                                                                                                       // IsSwap
            }
            else
            {
                // auto agency
                XPathArray[0] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[4]/tr[1]/td[1]/div[1]/span[1]/a[1]";          // CarBrand
                XPathArray[1] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[4]/tr[1]/td[1]/div[1]/span[1]/a[2]";          // Model
                XPathArray[2] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[2]/table[1]/tr[1]/td[2]";                       // ModelYear
                XPathArray[3] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[2]/table[1]/tr[11]/td[2]/div[1]/span[2]";       // Price
                XPathArray[4] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[2]/table[1]/tr[3]/td[2]";                       // Mileage
                XPathArray[5] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[2]/table[1]/tr[5]/td[2]";                       // EngineSize
                XPathArray[6] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[2]/table[1]/tr[2]/td[2]";                       // Color
                XPathArray[7] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[2]/table[1]/tr[8]/td[2]";                       // BodyType
                XPathArray[8] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[2]/table[1]/tr[4]/td[2]";                       // EngineType
                XPathArray[9] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[2]/table[1]/tr[7]/td[2]";                       // TransmissionType
                XPathArray[10] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[2]/table[1]/tr[10]/td[2]";                     // DriveType
                XPathArray[11] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[5]/font[1]";                                   // Description
                XPathArray[12] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/p[5]";                                             // CreatedOn
                XPathArray[13] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[2]/tr[1]/td[1]/script[2]";                   // SellerType
                XPathArray[14] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[4]/table[1]/tbody[1]";                         // Condition
                XPathArray[15] = "empty";                                                                                                       // IsSwap
            }

            Database.CarParsingInsert(abwUrl, XPathArray, 6776158, 6776159, "abw.by");

            // ab.onliner.by
            XPathArray[0] = "//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[1]/span[1]/strong";                                  // CarBrand
            XPathArray[1] = "//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[1]/span[1]/strong";                                  // Model
            XPathArray[2] = "//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[1]/span[2]/span[1]/strong";                          // ModelYear
            XPathArray[3] = "//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/div[5]/span/span/strong";                              // Price
            XPathArray[4] = "//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[1]/span[2]/span[2]/strong";                          // Mileage
            XPathArray[5] = "//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/strong";                                          // EngineSize
            XPathArray[6] = "//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/text()[1]";                                       // Color
            XPathArray[7] = "//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/text()[1]";                                       // BodyType
            XPathArray[8] = "//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/text()[1]";                                       // EngineType
            XPathArray[9] = "//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/text()[2]";                                       // TransmissionType
            XPathArray[10] = "//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/text()[2]";                                      // DriveType
            XPathArray[11] = "/html[1]/body[1]/div[1]/div[1]/div[4]/div[1]/div[2]/div[1]/div[1]/ul[1]/li[1]/div[1]/div[1]/div[1]/div[1]/p[4]/p[1]";                 // Description
            XPathArray[12] = "//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/small/text()";                                                   // CreatedOn
            XPathArray[13] = "empty";                                                                                                                               // SellerType
            XPathArray[14] = "//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/div[3]";                                              // Condition
            XPathArray[15] = "//*[@id=\"minWidth\"]/div/div[4]/div/div[1]/div[2]/strong[2]";                                                                        // IsSwap

            Database.CarParsingInsert(abUrl, XPathArray, 2347924, 2347925, "ab.onliner.by");
            
            Database.CarParsingClean();
        }
    }
}