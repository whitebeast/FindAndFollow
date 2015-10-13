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

            // av.by
            string[] XPathArray = Database.GetCarParsingSettings("av.by");

            Database.CarParsingInsert(avUrl, XPathArray, 10708341, 10708342, "av.by");

            // abw.by
            string[] CheckSellerTypeArray = new string[1];
            CheckSellerTypeArray[0] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[2]/tr[1]/td[1]/script[2]";
            CheckSellerTypeArray = Download.GetData(abwUrl + "6776158", CheckSellerTypeArray, "abw.by");

            if (CheckSellerTypeArray[0] == null)
            {
                // private
                XPathArray = Database.GetCarParsingSettings("abw.by-private");
            }
            else
            {
                // auto agency
                XPathArray = Database.GetCarParsingSettings("abw.by-autoagency");
            }
            
            Database.CarParsingInsert(abwUrl, XPathArray, 6776158, 6776159, "abw.by");

            // ab.onliner.by
            XPathArray = Database.GetCarParsingSettings("ab.onliner.by");

            Database.CarParsingInsert(abUrl, XPathArray, 2347924, 2347925, "ab.onliner.by");
 
            Database.CarParsingClean();
        }
    }
}