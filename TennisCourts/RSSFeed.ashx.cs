using System;
using System.Collections.Generic;
using System.Web;
using System.Xml;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;
using System.Data.Linq;
using System.Text;
using System.Linq;
using DLL;

namespace FlexibleTennisLeague.TennisCourts
{
    /// <summary>
    /// Summary description for $codebehindclassname$
    /// </summary>
    public class RSSFeed : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/xml";

            //if (!HttpContext.Current.Request.ServerVariables["SERVER_NAME"].Contains("flexibletennisleague"))
            //    return;
            int leagueId = Convert.ToInt32(Encryption.Decrypt(context.Request.QueryString["League"].ToString(), DateTime.Now.ToString("MMddyymm")));
            //int leagueId = 3;

            List<Court> courts = new List<Court>();

            //Get courts from db
            using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
            {
                List<TennisCourt> tennisCourts = dataContext.SelectTennisCourtsByLeague(leagueId).ToList();
                foreach (TennisCourt tennisCourt in tennisCourts)
                {
                    Court court = new Court();

                    court.Title = tennisCourt.CourtName;
                    court.Link = string.Empty;
                    court.Description = string.Format("{0}, {1}, {2} {3}<br/><br/>Courts : {4}<br/>Lights : {5}<br/>Public : {6}<br/>Court Fees : {7}", tennisCourt.Address, tennisCourt.City, tennisCourt.State, tennisCourt.Zip, tennisCourt.NumberCourts, tennisCourt.HasLights == true ? "Yes" : "No", tennisCourt.IsPublic == true ? "Yes" : "No", tennisCourt.HasFees == true ? "Yes" : "No");
                    court.Point = string.Format("{0} {1}", tennisCourt.Latitude, tennisCourt.Longitude);

                    courts.Add(court);
                }
            }

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

                for (int counter = 0; counter < courts.Count; counter++)
                {
                    geoRSS.WriteStartElement("item");

                    //Title
                    geoRSS.WriteStartElement("title");
                    geoRSS.WriteString(courts[counter].Title);
                    geoRSS.WriteEndElement();

                    //link
                    geoRSS.WriteStartElement("link");
                    geoRSS.WriteEndElement();

                    //description
                    geoRSS.WriteStartElement("description");
                    geoRSS.WriteString(courts[counter].Description);
                    geoRSS.WriteEndElement();

                    //point
                    geoRSS.WriteStartElement("georss:point");
                    geoRSS.WriteString(courts[counter].Point);
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
}
