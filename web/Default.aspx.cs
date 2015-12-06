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
            string[] mainPageXpaths = Database.CarParsingSettingsMainPage(siteAv);
            int[] urlIds = Download.UrlsGet(mainPageXpaths[0], siteAv, mainPageXpaths[1], mainPageXpaths[2], mainPageXpaths[3]);

            string[] xPathArray = Database.CarParsingSettingsGet(siteAv);
            Database.CarParsingInsert(urlAv, xPathArray, urlIds, mainPageXpaths[4], siteAv);

            // abw.by
            mainPageXpaths = Database.CarParsingSettingsMainPage(siteAbwA);
            urlIds = Download.UrlsGet(mainPageXpaths[0], siteAbwA, mainPageXpaths[1], mainPageXpaths[2], mainPageXpaths[3]);

            Database.CarParsingInsert(urlAbw, xPathArray, urlIds, mainPageXpaths[4], "abw.by");

            // ab.onliner.by
            xPathArray = Database.CarParsingSettingsGet(siteAb);

            //int[] urlIds = Download.UrlsGet(urlSiteAb, "//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/div[2]/div[2]/table/tbody", siteAb, ".//div[@class='b-listing-item-title']//a[@href]", "href", "public.php?event=View&public_id=");
            urlIds = new int[] { 2463032, 2441437, 2441221, 2395719 };

            Database.CarParsingInsert(urlAb, xPathArray, urlIds, mainPageXpaths[4], siteAb);

            Database.CarMerge();
        }
    }
}