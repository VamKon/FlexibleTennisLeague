using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using System.Text;
using DLL;

namespace FlexibleTennisLeague.TennisCourts
{
    public class PlayerLocations : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/xml";

            //if (HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"] != "216.10.242.41")
            //    return;
            int divisionId = Convert.ToInt32(Encryption.Decrypt(context.Request.QueryString["Division"].ToString(), "skhdhkrwshrkhwrh"));
            //int divisionId = 15;
            List<SelectUserZipByDivisionResult> users=null;
            //Get courts from db
            using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
            {
                users = dataContext.SelectUserZipByDivision(divisionId).ToList();
            }

            var uniqueZipCodes = users.GroupBy(p => p.Zip);
            
            

            using (XmlTextWriter geoRSS = new XmlTextWriter(HttpContext.Current.Response.OutputStream, System.Text.Encoding.UTF8))
            {

                geoRSS.Formatting = Formatting.Indented;
                geoRSS.Indentation = 2;

                geoRSS.WriteStartDocument(true);

                geoRSS.WriteStartElement("rss");
                geoRSS.WriteAttributeString("xmlns:georss", "http://www.georss.org/georss");
                geoRSS.WriteAttributeString("version", "2.0");

                geoRSS.WriteStartElement("channel");

                geoRSS.WriteStartElement("title");
                geoRSS.WriteString("courts");
                geoRSS.WriteEndElement();

                geoRSS.WriteStartElement("link");
                geoRSS.WriteEndElement();

                geoRSS.WriteStartElement("description");
                //geoRSS.WriteString(System.Net.Dns.GetHostEntry(context.Request.UserHostAddress).HostName);
                geoRSS.WriteEndElement();

                foreach (var results in uniqueZipCodes)
                {
                    geoRSS.WriteStartElement("item");

                    //Title
                    geoRSS.WriteStartElement("title");
                    geoRSS.WriteString(string.Format("<u>{0}</u>",results.First().Zip));
                    geoRSS.WriteEndElement();

                    //link
                    geoRSS.WriteStartElement("link");
                    geoRSS.WriteEndElement();

                    //description
                    geoRSS.WriteStartElement("description");
                    StringBuilder sb = new StringBuilder();
                    foreach (SelectUserZipByDivisionResult result in results)
                    {
                        sb.Append(string.Format("<p><b>{0} {1}</b><br>",result.FirstName,result.LastName));
                        sb.Append(string.Format("Phone : {0}<br>Email : {1}</p>", result.Phone, result.EmailId));
                    }
                    geoRSS.WriteString(sb.ToString());
                    geoRSS.WriteEndElement();

                    //point
                    geoRSS.WriteStartElement("georss:point");
                    geoRSS.WriteString(results.First().Latitude + " " + results.First().Longitude);
                    geoRSS.WriteEndElement();

                    geoRSS.WriteEndElement();
                }
               
                geoRSS.WriteEndElement();
                geoRSS.WriteEndElement();
                //geoRSS.WriteEndElement();
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }

    public class PlayersLocation
    {
        public int Zip { get; set; }
        public string Players { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }

        public PlayersLocation(int zip,string players,double latitude, double longitude)
        {
            Zip = zip;
            Players = players;
            Latitude = latitude;
            Longitude = longitude;
        }
    }
}
