using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace FlexibleTennisLeague.Chicago
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HtmlMeta meta = new HtmlMeta();
            meta.Name = "Keywords";
            meta.Content = "sign up for chicago tennis league, register for chicago tennis league, sign up chicago flexible tennis league";
            this.Header.Controls.Add(meta);

            meta = new HtmlMeta();
            meta.Name = "Description";
            meta.Content = "Sign up and discover the easy way to find committed tennis enthusiasts in chicago metro. Schedule matches, post scores, qualify for playoffs, win the division - all at your convenience. Get started with our easy sign up process.";
            this.Header.Controls.Add(meta);

            //Response.Status = "301 Moved Permanently";
            //Response.AddHeader("Location", "http://flexibletennisleague.com/denver/users/NoRegister.aspx");
        }
    }
}
