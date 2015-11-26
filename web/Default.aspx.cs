using System;
using System.Net;
using HtmlAgilityPack;

namespace FindAndFollow
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // loading page..
            /*
            WebClient webGet = new WebClient();
            HtmlDocument doc = new HtmlDocument();

            webGet.Headers.Add("user-agent", "Mozilla/5.0 (Windows; Windows NT 5.1; rv:1.9.2.4) Gecko/20100611 Firefox/3.6.4");

            string webSite = "av.by";
            string url = "http://av.by/public/search.php?name_form=search_form&event=Search&country_id=0&body_type_id=0&class_id=0&engine_type_all=1&volume_value=0&volume_value_max=0&cylinders_number=0&run_value=0&run_value_max=0&run_unit=-1&transmission_id=0&year_id=0&year_id_max=0&price_value=0&price_value_max=0&currency_id=USD&door_id=0&region_id=0&city_id=Array&public_pass_rf=0&public_new=0&public_exchange=0&public_image=0&public_show_id=0&order_id=2&category_parent[0]=0&category_id[0]=0&";

            if (webSite == "ab.onliner.by")
            {
                webGet.Encoding = System.Text.Encoding.UTF8;
                doc.LoadHtml(Download.DownloadPage(url));
            }
            else
            {
                try
                {
                    var html = webGet.DownloadString(url);
                    doc.LoadHtml(html);
                }
                catch (Exception ex)
                {
                    Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
                }
            }

            int[] urlLinks = Download.UrlsGet(doc, "/html/body/div[2]/div[1]/div[2]/div/div[2]/div[3]", url);
            */
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

            //xPathArray = Database.CarParsingSettingsGet(checkSellerTypeArray[0] == null ? siteAbwP : siteAbwA);

            Database.CarParsingInsert(urlAbw, xPathArray, currentId, currentId + 1, "abw.by");

            // ab.onliner.by
            xPathArray = Database.CarParsingSettingsGet(siteAb);
            currentId = Database.CarParsingSettingsCurrentIdGet(siteAb);

            //Database.CarParsingInsert(urlAb, xPathArray, currentId, currentId + 1, siteAb);

            Database.CarMerge();
        }
    }
}