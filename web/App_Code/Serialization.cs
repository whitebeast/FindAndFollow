using System;
using System.Web;
using System.IO;
using System.Collections.Generic;
using System.Web.Script.Serialization;

namespace FindAndFollow
{
    public class Serialization
    {
        public class OwnerPhone
        {
            public string phoneNumber { get; set; }
        }

        public static string SerializePhoneAv(List<string> lstOwnerPhones, string url)
        {
            try
            {
                var OwnerPhones = new List<OwnerPhone>();

                for (int i = 0; i < lstOwnerPhones.Count; i++)
                {
                    if (lstOwnerPhones[i] != "")
                    {
                        StringWriter myWriter = new StringWriter();

                        OwnerPhones.Add(new OwnerPhone() { phoneNumber = StringClass.OwnerPhoneGetAv(lstOwnerPhones[i], url) });
                        HttpUtility.HtmlDecode(OwnerPhones[i].phoneNumber.ToString(), myWriter);
                        OwnerPhones[i].phoneNumber = myWriter.ToString();
                    }
                }

                var serializer = new JavaScriptSerializer();
                var serializedResult = serializer.Serialize(OwnerPhones);

                return serializedResult.Trim().ToString();
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

    }
}