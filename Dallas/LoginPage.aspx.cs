using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace FlexibleTennisLeague.Dallas
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HtmlMeta meta = new HtmlMeta();
            meta.Name = "Keywords";
            meta.Content = "manage your dallas tennis league, schedule tennis matches in dallas";
            this.Header.Controls.Add(meta);

            meta = new HtmlMeta();
            meta.Name = "Description";
            meta.Content = "Login to players only area of Dallas' Flexible Tennis League - to schedule matches, post scores and customize your tennis league experience.";
            this.Header.Controls.Add(meta);

            HtmlLink link = new HtmlLink();
            link.Attributes.Add("rel", "canonical");
            link.Href = "http://www.flexibletennisleague.com/LoginPage.aspx";
            this.Header.Controls.Add(link);
        }
    }
}
