using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace FlexibleTennisLeague.SanFrancisco
{
    public partial class TennisCourts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HtmlMeta meta = new HtmlMeta();
            meta.Name = "Keywords";
            meta.Content = "San Francisco tennis courts, map of San Francisco tennis courts, search for San Francisco tennis courts, San Francisco tennis courts";
            this.Header.Controls.Add(meta);

            meta = new HtmlMeta();
            meta.Name = "Description";
            meta.Content = "Find San Francisco Tennis courts, see a map of all San Francisco Tennis courts, get driving directions - find a court that works best for you.";
            this.Header.Controls.Add(meta);
        }
    }
}
