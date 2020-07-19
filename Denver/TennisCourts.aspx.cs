using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace FlexibleTennisLeague.Denver
{
    public partial class TennisCourts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HtmlMeta meta = new HtmlMeta();
            meta.Name = "Keywords";
            meta.Content = "denver tennis courts, map of denver tennis courts, search for denver tennis courts, denver tennis courts";
            this.Header.Controls.Add(meta);

            meta = new HtmlMeta();
            meta.Name = "Description";
            meta.Content = "Find Denver Tennis courts, see a map of all Denver Tennis courts, get driving directions - find a court that works best for you.";
            this.Header.Controls.Add(meta);
        }
    }
}
