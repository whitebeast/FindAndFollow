using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

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
                case ("оран"): color = "Оранжевой";
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
            string color = word.Substring(0, 3).ToLower();

            switch (color)
            {
                case ("авт"): color = "Автомат";
                    break;
                case ("акп"): color = "Автомат";
                    break;
                case ("мех"): color = "Механика";
                    break;
                case ("мкп"): color = "Механика";
                    break;
                default: color = "Другой";
                    break;
            }

            return color;
        }

        public static string DriveTypeGet(string word)
        {
            string color = word.Substring(0, 3).ToLower();

            switch (color)
            {
                case ("пер"): color = "Передний";
                    break;
                case ("зад"): color = "Задний";
                    break;
                case ("пол"): color = "Полный";
                    break;
                case ("пос"): color = "Полный";
                    break;
                case ("под"): color = "Полный";
                    break;
                default: color = "Другой";
                    break;
            }

            return color;
        }
    }
}