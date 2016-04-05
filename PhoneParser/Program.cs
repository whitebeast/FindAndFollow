using System;
using System.Drawing;

namespace PhoneParser
{
    class Program
    {
        static void Main(string[] args)
        {
            string PhoneNumber = "";
            var phoneImage = new Bitmap(@"e:\image_2.gif");
            int xOffset = 0;
            int sum = 0;
            int lside = 0;
            int rside = 0;

            for (int i = 1; i <= 7; i++)
            {
                sum = 0;
                lside = 0;
                rside = 0;
                for (int y = 3; y < 13; y++)
                {
                    for (int x = xOffset; x < 8 + xOffset; x++)
                    {
                        if (phoneImage.GetPixel(x, y).A == 255) //if pixel is not transparent
                        {
                            sum += 1;
                        }
                    }

                    // trying to find 6
                    if (phoneImage.GetPixel(xOffset, y).A == 255)
                    {
                        lside += 1;
                    }
                    if (phoneImage.GetPixel(7 + xOffset, y).A == 255)
                    {
                        rside += 1;
                    }
                }

                xOffset += 9;

                if (lside == 6 && rside == 2) // was found 6
                {
                    sum = 38;
                }

                switch (sum)
                {
                    case 36: PhoneNumber = PhoneNumber + "0"; break;
                    case 27: PhoneNumber = PhoneNumber + "1"; break;
                    case 32: PhoneNumber = PhoneNumber + "2"; break;
                    case 31: PhoneNumber = PhoneNumber + "3"; break;
                    case 35: PhoneNumber = PhoneNumber + "4"; break;
                    case 37: PhoneNumber = PhoneNumber + "5"; break;
                    case 38: PhoneNumber = PhoneNumber + "6"; break;
                    case 26: PhoneNumber = PhoneNumber + "7"; break;
                    case 40: PhoneNumber = PhoneNumber + "8"; break;
                    case 39: PhoneNumber = PhoneNumber + "9"; break;
                }
            }

            Console.WriteLine(PhoneNumber);
        }
    }
}
