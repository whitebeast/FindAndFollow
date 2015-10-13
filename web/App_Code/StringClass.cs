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
            return word.Replace(" ", string.Empty);
        }

        public static string RemoveText(string word, string removeWord)
        {
            return word.Replace(removeWord, string.Empty);
        }

        public static string DatetimeFormat(string word)
        {
            DateTime myTime = DateTime.Parse(word);
            return myTime.ToString("yyyy-MM-dd HH:mm:ss");
        }

        public static string MultiplyValue(string word, int value)
        {
            double myNumber = double.Parse(word);
            return (myNumber * value).ToString();
        }

        public static string ReplaceText(string word, string oldChar, string newChar)
        {
            return word.Replace(oldChar, newChar);
        }

    }
}