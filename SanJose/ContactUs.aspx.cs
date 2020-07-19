using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace FlexibleTennisLeague.SanJose
{
    public partial class ContactUs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HtmlMeta meta = new HtmlMeta();
            meta.Name = "Keywords";
            meta.Content = "contact San Jose tennis administrator, complaints, comments";
            this.Header.Controls.Add(meta);

            meta = new HtmlMeta();
            meta.Name = "Description";
            meta.Content = "Contact FlexibleTennisLeague's San Jose admin about your questions, comments or suggestions.";
            this.Header.Controls.Add(meta);

            HtmlLink link = new HtmlLink();
            link.Attributes.Add("rel", "canonical");
            link.Href = "http://www.flexibletennisleague.com/ContactUs.aspx";
            this.Header.Controls.Add(link);

        }
    }
}
