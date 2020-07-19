using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace FlexibleTennisLeague
{
    public partial class Locations : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, typeof(Page), "SetMapDimensions", string.Format("setMapWidthHeight({0},{1},'{2}');", 625, 375, "/Courts/FlexibleTennisLeague.xml"), true);

            HtmlMeta meta = new HtmlMeta();
            meta.Name = "Keywords";
            meta.Content = "tennis league locations, flexible tennis league locations";
            this.Header.Controls.Add(meta);

            meta = new HtmlMeta();
            meta.Name = "Description";
            meta.Content = "Cities that Flexible Tennis League is currently serving";
            this.Header.Controls.Add(meta);

            HtmlLink link = new HtmlLink();
            link.Attributes.Add("rel", "canonical");
            link.Href = "http://www.flexibletennisleague.com/locations.aspx";
            this.Header.Controls.Add(link);

        }
    }
}
