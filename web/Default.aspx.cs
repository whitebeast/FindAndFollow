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
            string[] xPathArray = Database.CarParsingSettingsGet("av.by");

            Database.CarParsingInsert(avUrl, xPathArray, 10708341, 10708342, "av.by");

            // abw.by
            string[] checkSellerTypeArray = new string[1];
            checkSellerTypeArray[0] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[2]/tr[1]/td[1]/script[2]";
            checkSellerTypeArray = Download.GetData(abwUrl + "8310288", checkSellerTypeArray, "abw.by");

            if (checkSellerTypeArray[0] == null)
            {
                // private
                xPathArray = Database.CarParsingSettingsGet("abw.by-private");
            }
            else
            {
                // auto agency
                xPathArray = Database.CarParsingSettingsGet("abw.by-autoagency");
            }

            Database.CarParsingInsert(abwUrl, xPathArray, 8310288, 8310289, "abw.by");

            // ab.onliner.by
            xPathArray = Database.CarParsingSettingsGet("ab.onliner.by");

            Database.CarParsingInsert(abUrl, xPathArray, 2339068, 2339069, "ab.onliner.by");

            Database.CarParsingClean();

            Database.CarMerge();
        }
    }
}