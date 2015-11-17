﻿using System;
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

        public class CarImage
        {
            public string imageUrl { get; set; }
        }

        public static string PhoneSerializeAv(List<string> lstOwnerPhones, string url)
        {
            try
            {
                var ownerPhones = new List<OwnerPhone>();

                for (int i = 0; i < lstOwnerPhones.Count; i++)
                {
                    if (lstOwnerPhones[i] != "")
                    {
                        StringWriter myWriter = new StringWriter();

                        ownerPhones.Add(new OwnerPhone() { phoneNumber = StringClass.OwnerPhoneGetAv(lstOwnerPhones[i], url) });
                        HttpUtility.HtmlDecode(ownerPhones[i].phoneNumber, myWriter);
                        ownerPhones[i].phoneNumber = myWriter.ToString();
                    }
                }

                var serializer = new JavaScriptSerializer();
                var serializedResult = serializer.Serialize(ownerPhones);

                return serializedResult.Trim();
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string PhoneSerializeAb(List<string> lstOwnerPhones, string url)
        {
            try
            {
                var ownerPhones = new List<OwnerPhone>();

                for (int i = 0; i < lstOwnerPhones.Count; i++)
                {
                    if (lstOwnerPhones[i].Contains("+375"))
                    {
                        StringWriter myWriter = new StringWriter();

                        ownerPhones.Add(new OwnerPhone() { phoneNumber = StringClass.OwnerPhoneGetAb(lstOwnerPhones[i], url) });
                        HttpUtility.HtmlDecode(ownerPhones[i].phoneNumber, myWriter);
                        ownerPhones[i].phoneNumber = myWriter.ToString();
                    }
                }

                var serializer = new JavaScriptSerializer();
                var serializedResult = serializer.Serialize(ownerPhones);

                return serializedResult.Trim();
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string CarImagesSerialize(List<string> lstCarImages, string url)
        {
            try
            {
                var carImages = new List<CarImage>();

                for (int i = 0; i < lstCarImages.Count; i++)
                {
                    StringWriter myWriter = new StringWriter();

                    carImages.Add(new CarImage() { imageUrl = lstCarImages[i] });
                    HttpUtility.HtmlDecode(carImages[i].imageUrl, myWriter);
                    carImages[i].imageUrl = myWriter.ToString();
                }

                var serializer = new JavaScriptSerializer();
                var serializedResult = serializer.Serialize(carImages);

                return serializedResult.Trim();
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

    }
}