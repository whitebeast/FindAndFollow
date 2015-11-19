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
            string siteAv = "av.by";
            string siteAbwP = "abw.by-private";
            string siteAbwA = "abw.by-autoagency";
            string siteAb = "ab.onliner.by";

            string urlAv = Database.CarParsingSettingsDownloadMaskUrl(siteAv);
            string urlAbw = Database.CarParsingSettingsDownloadMaskUrl(siteAbwP);
            string urlAb = Database.CarParsingSettingsDownloadMaskUrl(siteAb);

            // av.by
            string[] xPathArray = Database.CarParsingSettingsGet(siteAv);
            int currentId = Database.CarParsingSettingsCurrentIdGet(siteAv);

            Database.CarParsingInsert(urlAv, xPathArray, currentId, currentId + 1, siteAv);

            // abw.by
            string[] checkSellerTypeArray = new string[1];
            currentId = Database.CarParsingSettingsCurrentIdGet(siteAbwP);

            checkSellerTypeArray[0] = "/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[2]/tr[1]/td[1]/script[2]";
            checkSellerTypeArray = Download.GetData(urlAbw + currentId.ToString(), checkSellerTypeArray, "abw");

            xPathArray = Database.CarParsingSettingsGet(checkSellerTypeArray[0] == null ? siteAbwP : siteAbwA);

            Database.CarParsingInsert(urlAbw, xPathArray, currentId, currentId + 1, "abw.by");

            // ab.onliner.by
            xPathArray = Database.CarParsingSettingsGet(siteAb);
            currentId = Database.CarParsingSettingsCurrentIdGet(siteAb);

            Database.CarParsingInsert(urlAb, xPathArray, currentId, currentId + 1, siteAb);

            Database.CarParsingClean();

            Database.CarMerge();
        }
    }
}