using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace FlexibleTennisLeague
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HtmlMeta meta = new HtmlMeta();
            meta.Name = "Keywords";
            meta.Content = "tennis league, flexible tennis league, competitive tennis league, online tennis league";
            this.Header.Controls.Add(meta);

            meta = new HtmlMeta();
            meta.Name = "Description";
            meta.Content = "Play competitive tennis at your convenience. Contact, schedule and play tennis when it's convenient for you. Compete for prizes and improve your game.";
            this.Header.Controls.Add(meta);

            HtmlLink link = new HtmlLink();
            link.Attributes.Add("rel", "canonical");
            link.Href = "http://www.flexibletennisleague.com/";
            this.Header.Controls.Add(link);
        }
    }
}
