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
    }
}