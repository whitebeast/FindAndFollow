using System;
using System.Linq;

namespace FindAndFollow
{
    public class StringClass
    {
        public static string ConcatenateSpaces(string word, string url)
        {
            try
            {
                return word.Replace(" ", string.Empty).Trim();
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string RemoveText(string word, string removeWord, string url)
        {
            try
            {
                return word.Replace(removeWord, string.Empty).Trim();
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string DatetimeFormat(string word, string url)
        {
            try
            {
                DateTime myTime = DateTime.Parse(word);
                return myTime.ToString("yyyy-MM-dd HH:mm:ss").Trim();
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string MultiplyValue(string word, int value, string url)
        {
            try
            {
                double myNumber = double.Parse(word);
                return (myNumber * value).ToString().Trim();
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string ReplaceText(string word, string oldChar, string newChar, string url)
        {
            try
            {
                return word.Replace(oldChar, newChar).Trim();
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string SelectWordGet(string word, char delimeter, int wordNumber, string url)
        {
            try
            {
                string[] words = word.Split(delimeter);
                return words[wordNumber - 1].Trim();
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string ColorGet(string word, string url)
        {
            try
            {
                string color = word.Substring(0, 4).ToLower();

                switch (color)
                {
                    case ("белы"): color = "Белый";
                        break;
                    case ("желт"): color = "Желтый";
                        break;
                    case ("зеле"): color = "Зеленый";
                        break;
                    case ("кори"): color = "Коричневый";
                        break;
                    case ("крас"): color = "Красный";
                        break;
                    case ("оран"): color = "Оранжевый";
                        break;
                    case ("сере"): color = "Серебристый";
                        break;
                    case ("серы"): color = "Серый";
                        break;
                    case ("сини"): color = "Синий";
                        break;
                    case ("фиол"): color = "Фиолетовый";
                        break;
                    case ("черн"): color = "Черный";
                        break;
                    default: color = "Другой";
                        break;
                }

                return color;
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string SearchWord(string word, string resultTrue, string resultFalse, string url)
        {
            if (word != null)
            {
                if (word.ToLower().Contains("кондиционер") || word.ToLower().Contains("климат-контроль"))
                    return resultTrue;
                else
                    return resultFalse;
            }
            else
            {
                return resultFalse;
            }
        }

        public static string TransmissionGet(string word, string url)
        {
            try
            {
                string transmission = word.Substring(0, 3).ToLower();

                switch (transmission)
                {
                    case ("авт"): transmission = "Автомат";
                        break;
                    case ("акп"): transmission = "Автомат";
                        break;
                    case ("мех"): transmission = "Механика";
                        break;
                    case ("мкп"): transmission = "Механика";
                        break;
                    default: transmission = "Другой";
                        break;
                }

                return transmission;
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string DriveTypeGet(string word, string url)
        {
            try
            {
            string driveType = word.Substring(0, 3).ToLower();

            switch (driveType)
            {
                case ("пер"): driveType = "Передний";
                    break;
                case ("зад"): driveType = "Задний";
                    break;
                case ("пол"): driveType = "Полный";
                    break;
                case ("пос"): driveType = "Полный";
                    break;
                case ("под"): driveType = "Полный";
                    break;
                default: driveType = "Другой";
                    break;
            }

            return driveType;
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string EngineTypeGet(string word, string url)
        {
            try
            {
                string engineType = word.Substring(0, 3).ToLower();

                switch (engineType)
                {
                    case ("бен"): engineType = "Бензиновый";
                        break;
                    case ("диз"): engineType = "Дизельный";
                        break;
                    case ("тур"): engineType = "Дизельный";
                        break;
                    case ("газ"): engineType = "Газ";
                        break;
                    case ("эле"): engineType = "Электрический";
                        break;
                    case ("гиб"): engineType = EngineTypeGetHybrid(word, url);
                        break;
                    default: engineType = "Другой";
                        break;
                }

                return engineType;
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string EngineTypeGetHybrid(string word, string url)
        {
            try
            {
                string engineType = word.Substring(0, 10).ToLower();

                switch (engineType)
                {
                    case ("гибридныйб"): engineType = "Гибридный бензиновый";
                        break;
                    case ("гибридныйд"): engineType = "Гибридный дизельный";
                        break;
                    case ("гибрид (бе"): engineType = "Гибридный бензиновый";
                        break;
                    case ("гибрид (ди"): engineType = "Гибридный дизельный";
                        break;
                    default: engineType = "Гибрид";
                        break;
                }

                return engineType;
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string BodyTypeGet(string word, string url)
        {
            try
            {
                string bodyType = word.Substring(0, 4).ToLower();

                switch (bodyType)
                {
                    case ("седа"): bodyType = "Седан";
                        break;
                    case ("унив"): bodyType = "Универсал";
                        break;
                    case ("хетч"): bodyType = "Хетчбэк";
                        break;
                    case ("хэтч"): bodyType = "Хетчбэк";
                        break;
                    case ("мини"): bodyType = "Минивэн";
                        break;
                    case ("внед"): bodyType = "Внедорожник";
                        break;
                    case ("всед"): bodyType = "Внедорожник";
                        break;
                    case ("купе"): bodyType = "Купе";
                        break;
                    case ("кабр"): bodyType = "Кабриолет";
                        break;
                    case ("микр"): bodyType = "Микроавтобус";
                        break;
                    case ("груз"): bodyType = "Грузовик";
                        break;
                    case ("фург"): bodyType = "Грузовик";
                        break;
                    case ("пикa"): bodyType = "Пикап";
                        break;
                    case ("родс"): bodyType = "Родстер";
                        break;
                    case ("авто"): bodyType = "Автобус";
                        break;
                    case ("лифт"): bodyType = "Хетчбэк";
                        break;
                    default: bodyType = "Другой";
                        break;
                }

                return bodyType;
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string MonthConvert(string word, string url)
        {
            try
            {
                string currentYear = DateTime.Now.Year.ToString();
                string monthNumber = SelectWordGet(word, ' ', 2, url);
                string dateNumber = SelectWordGet(word, ' ', 1, url);
                string timeNumber = SelectWordGet(word, ' ', 4, url);

                switch (monthNumber.Substring(0, 3).ToLower())
                {
                    case ("янв"): monthNumber = "01";
                        break;
                    case ("фев"): monthNumber = "02";
                        break;
                    case ("мар"): monthNumber = "03";
                        break;
                    case ("апр"): monthNumber = "04";
                        break;
                    case ("мая"): monthNumber = "05";
                        break;
                    case ("июн"): monthNumber = "06";
                        break;
                    case ("июл"): monthNumber = "07";
                        break;
                    case ("авг"): monthNumber = "08";
                        break;
                    case ("сен"): monthNumber = "09";
                        break;
                    case ("окт"): monthNumber = "10";
                        break;
                    case ("ноя"): monthNumber = "11";
                        break;
                    case ("дек"): monthNumber = "12";
                        break;
                    default: monthNumber = "00";
                        break;
                }

                return currentYear + ' ' + monthNumber + ' ' + dateNumber + ' '  + timeNumber;
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string ConditionGetAb(string word, string url)
        {
            try
            {
                string condition = word.Trim().ToLower();

                if (condition.Contains("ава"))
                    condition = "Аварийный";
                else if (condition.Contains("нов"))
                    condition = "Новый";
                else
                    condition = "С пробегом";

                return condition;
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string ConditionGetAv(string word, string url)
        {
            try
            {
                int mileage = int.Parse(word.Trim());
                string condition;

                condition = mileage <= 50 ? "Новый" : "С пробегом";

                return condition;
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string ConditionGetAbw(string word, string url)
        {
            try
            {
                string condition = word.Trim().Substring(0, 3);

                switch (condition)
                {
                    case ("ава"): condition = "Аварийный";
                        break;
                    case ("нов"): condition = "Новый";
                        break;
                    case ("с п"): condition = "С пробегом";
                        break;
                    default: condition = "Другой";
                        break;
                }

                return condition;
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string CityGetAbw(string word, string url)
        {
            // TODO: optimize method
            try
            {
                int startCut = word.IndexOf("<div align=\"center\">Продавец:");
                string city = RemoveText(word.Trim().Substring(startCut, 130), "<div align=\"center\">Продавец:</b>", url);
                int endCut = city.IndexOf(")");

                return city.Substring(0, endCut).Split(' ').LastOrDefault();
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string OwnerPhoneGetAv(string word, string url)
        {
            try
            {
                int startCut = word.IndexOf("+375 ");
                int endCut = word.IndexOf("</b>");
                string phoneNumber = RemoveText(word.Substring(startCut, endCut - startCut), "<b>", url);

                return phoneNumber.Trim();
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }

        public static string OwnerPhoneGetAb(string word, string url)
        {
            try
            {
                return RemoveText(RemoveText(ReplaceText(word, "-", " ", url), ")", url), "(", url);
            }
            catch (Exception ex)
            {
                return Database.ErrorLogInsert(ex.Message, ex.StackTrace, url);
            }
        }
    }
}