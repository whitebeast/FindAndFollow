using System;

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
            int currentId = Database.CarParsingSettingsCurrentIdGet("av.by");

            Database.CarParsingInsert(avUrl, xPathArray, currentId, currentId + 1, "av.by");

            // abw.by
            string[] checkSellerTypeArray = new string[1];
            currentId = Database.CarParsingSettingsCurrentIdGet("abw.by-private");

            checkSellerTypeArray[0] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[2]/tr[1]/td[1]/script[2]";
            checkSellerTypeArray = Download.GetData(abwUrl + currentId.ToString(), checkSellerTypeArray, "abw.by");

            xPathArray = Database.CarParsingSettingsGet(checkSellerTypeArray[0] == null ? "abw.by-private" : "abw.by-autoagency");

            Database.CarParsingInsert(abwUrl, xPathArray, currentId, currentId + 1, "abw.by");

            // ab.onliner.by
            xPathArray = Database.CarParsingSettingsGet("ab.onliner.by");
            currentId = Database.CarParsingSettingsCurrentIdGet("ab.onliner.by");

            Database.CarParsingInsert(abUrl, xPathArray, currentId, currentId + 1, "ab.onliner.by");

            Database.CarParsingClean();

            Database.CarMerge();
        }
    }
}