using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FindAndFollow
{
    public class Exceptions
    {
        public class ExceptionsFields
        {
            public string exMessage { get; set; }
            public string exStackTrace { get; set; }

            public ExceptionsFields(string exMessage, string exStackTrace)
            {
                this.exMessage = exMessage;
                this.exStackTrace = exStackTrace;
            }
        }
    }
}