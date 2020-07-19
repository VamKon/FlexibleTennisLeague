using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace FlexibleTennisLeague.Atlanta
{
    public partial class TennisCourts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HtmlMeta meta = new HtmlMeta();
            meta.Name = "Keywords";
            meta.Content = "atlanta tennis courts, map of atlanta tennis courts, search for atlanta tennis courts, atlanta tennis courts";
            this.Header.Controls.Add(meta);

            meta = new HtmlMeta();
            meta.Name = "Description";
            meta.Content = "Find Atlanta Tennis courts, see a map of all Atlanta Tennis courts, get driving directions - find a court that works best for you.";
            this.Header.Controls.Add(meta);
        }
    }
}
