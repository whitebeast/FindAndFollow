using System;

namespace FindAndFollow
{
    public class StringClass
    {
        public static string ConcatenateSpaces(string word)
        {
            return word.Replace(" ", string.Empty).Trim();
        }

        public static string RemoveText(string word, string removeWord)
        {
            return word.Replace(removeWord, string.Empty).Trim();
        }

        public static string DatetimeFormat(string word)
        {
            DateTime myTime = DateTime.Parse(word);
            return myTime.ToString("yyyy-MM-dd HH:mm:ss").Trim();
        }

        public static string MultiplyValue(string word, int value)
        {
            double myNumber = double.Parse(word);
            return (myNumber * value).ToString().Trim();
        }

        public static string ReplaceText(string word, string oldChar, string newChar)
        {
            return word.Replace(oldChar, newChar).Trim();
        }

        public static string SelectWordGet(string word, char delimeter, int wordNumber)
        {
            string[] words = word.Split(delimeter);
            return words[wordNumber - 1].Trim();
        }

        public static string ColorGet(string word)
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

        public static string SearchWord(string word, string resultTrue, string resultFalse)
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

        public static string TransmissionGet(string word)
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

        public static string DriveTypeGet(string word)
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

        public static string EngineTypeGet(string word)
        {
            string engineType = word.Substring(0, 3).ToLower();

            switch (engineType)
            {
                case ("бен"): engineType = "Бензиновый";
                    break;
                case ("диз"): engineType = "Дизельный";
                    break;
                case ("газ"): engineType = "Газ";
                    break;
                case ("гиб"): engineType = EngineTypeGetHybrid(word);
                    break;
                default: engineType = "Другой";
                    break;
            }

            return engineType;
        }

        public static string EngineTypeGetHybrid(string word)
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

        public static string BodyTypeGet(string word)
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

        public static string MonthConvert(string word)
        {
            string currentYear = DateTime.Now.Year.ToString();
            string monthNumber = SelectWordGet(word, ' ', 2);
            string dateNumber = SelectWordGet(word, ' ', 1);
            string timeNumber = SelectWordGet(word, ' ', 4);

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
    }
}