using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace FlexibleTennisLeague.Atlanta
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HtmlMeta meta = new HtmlMeta();
            meta.Name = "Keywords";
            meta.Content = "atlanta tennis league, tennis atlanta, atlanta flexible tennis league, atlanta metro tennis league";
            this.Header.Controls.Add(meta);

            meta = new HtmlMeta();
            meta.Name = "Description";
            meta.Content = "Play in a competitive Atlanta Tennis league, at your convenience. Contact, schedule and play tennis when it's convenient for you. Compete for prizes and improve your game.";
            this.Header.Controls.Add(meta);

            HtmlLink link = new HtmlLink();
            link.Attributes.Add("rel", "canonical");
            link.Href = "http://www.flexibletennisleague.com/atlanta/";
            this.Header.Controls.Add(link);
        }
    }
}
