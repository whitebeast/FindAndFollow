using System;
using System.Threading;

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
            Thread threadAbw = new Thread(AbwThread);
            threadAbw.Start();

            //Thread threadAb = new Thread(AbThread);
            //threadAb.Start(); 

            //string siteAv = "av.by";

            //string urlAv = Database.CarParsingSettingsDownloadMaskUrl(siteAv);

            //string[] mainPageXpaths = Database.CarParsingSettingsMainPage(siteAv);
            //int[] urlIds = Download.UrlsGet(mainPageXpaths[0], siteAv, mainPageXpaths[1], mainPageXpaths[2], mainPageXpaths[3]);

            //string[] xPathArray = Database.CarParsingSettingsGet(siteAv);
            //Database.CarParsingInsert(urlAv, xPathArray, urlIds, mainPageXpaths[4], siteAv);

            Database.CarMerge();
        }

        static void AbwThread()
        {
            string siteAbwP = "abw.by-private";
            string siteAbwA = "abw.by-autoagency";

            string urlAbw = Database.CarParsingSettingsDownloadMaskUrl(siteAbwP);
            string[] xPathArray = Database.CarParsingSettingsGet(siteAbwP);

            string[] mainPageXpaths = Database.CarParsingSettingsMainPage(siteAbwA);
            int[] urlIds = Download.UrlsGet(mainPageXpaths[0], siteAbwA, mainPageXpaths[1], mainPageXpaths[2], mainPageXpaths[3]);

            Database.CarParsingInsert(urlAbw, xPathArray, urlIds, mainPageXpaths[4], "abw.by");

            Database.CarMerge();
        }

        static void AbThread()
        {
            string siteAb = "ab.onliner.by";
            string siteAbwA = "abw.by-autoagency";

            string urlAb = Database.CarParsingSettingsDownloadMaskUrl(siteAb);

            string[] mainPageXpaths = Database.CarParsingSettingsMainPage(siteAbwA);
            string[] xPathArray = Database.CarParsingSettingsGet(siteAb);

            //int[] urlIds = Download.UrlsGet(urlSiteAb, "//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/div[2]/div[2]/table/tbody", siteAb, ".//div[@class='b-listing-item-title']//a[@href]", "href", "public.php?event=View&public_id=");
            int[] urlIds = new int[] { 2478464, 2478462, 2478461, 2478457, 2478453, 2478452 };

            Database.CarParsingInsert(urlAb, xPathArray, urlIds, mainPageXpaths[4], siteAb);

            Database.CarMerge();
        }
    }
}