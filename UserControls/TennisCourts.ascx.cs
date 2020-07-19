using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data.Linq;
using System.Text;
using DLL;

namespace FlexibleTennisLeague.UserControls
{
    public partial class TennisCourts : System.Web.UI.UserControl
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            flipImage.Attributes.Add("onclick", "flipEndPoints()");
            //ScriptManager.RegisterStartupScript(this, typeof(Page), "SetMapDimensions", string.Format("setMapWidthHeight({0},{1},'{2}');", MapWidth, MapHeight, WebConfigurationManager.AppSettings["GeoRSSPath"].ToString()), true);
            ScriptManager.RegisterStartupScript(this, typeof(Page), "SetMapDimensions", string.Format("setMapWidthHeight({0},{1},'{2}');", MapWidth, MapHeight, string.Format("/TennisCourts/RSSFeed.ashx?League={0}", Encryption.Encrypt(WebConfigurationManager.AppSettings["LeagueCityId"].ToString(), DateTime.Now.ToString("MMddyymm")))), true);
            textLabel.Text = WebConfigurationManager.AppSettings["TennisCourtMapLabelText"].ToString();
        }

        public int MapWidth { get; set; }
        public int MapHeight { get; set; }
    }
}