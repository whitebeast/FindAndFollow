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

            string urlSiteAv = "http://av.by/public/search.php?name_form=search_form&event=Search&country_id=0&body_type_id=0&class_id=0&engine_type_all=1&volume_value=0&volume_value_max=0&cylinders_number=0&run_value=0&run_value_max=0&run_unit=-1&transmission_id=0&year_id=0&year_id_max=0&price_value=0&price_value_max=0&currency_id=USD&door_id=0&region_id=0&city_id=Array&public_pass_rf=0&public_new=0&public_exchange=0&public_image=0&public_show_id=0&order_id=2&category_parent[0]=0&category_id[0]=0&";
            string urlSiteAbw = "http://www.abw.by/index.php?set_small_form_1=1&act=public_search&do=search&index=1&adv_type=1&adv_group=&marka%5B%5D=&model%5B%5D=&type_engine=&transmission=&vol1=&vol2=&year1=1960&year2=2015&cost_val1=&cost_val2=&u_country=&u_city=&period=&sort=&na_rf=&type_body=&privod=&probeg_col1=&probeg_col2=&key_word_a=&volume1=&volume2=&cylinders=&doors=&probeg_type=&class=&photo=&adv_type=1&period=&sort=date_add";
            string urlSiteAb = "http://ab.onliner.by/#currency=USD&sort[]=creation_date&page=1";

            // av.by
            string[] mainPageXpaths = Database.CarParsingSettingsMainPage(siteAv);
            int[] urlIds = Download.UrlsGet(urlSiteAv, mainPageXpaths[0], siteAv, mainPageXpaths[1], mainPageXpaths[2], mainPageXpaths[3]);

            string[] xPathArray = Database.CarParsingSettingsGet(siteAv);
            Database.CarParsingInsert(urlAv, xPathArray, urlIds, mainPageXpaths[4], siteAv);

            // abw.by
            mainPageXpaths = Database.CarParsingSettingsMainPage(siteAbwA);
            urlIds = Download.UrlsGet(urlSiteAbw, mainPageXpaths[0], siteAbwA, mainPageXpaths[1], mainPageXpaths[2], mainPageXpaths[3]);

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