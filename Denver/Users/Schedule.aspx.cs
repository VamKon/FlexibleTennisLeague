using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DLL;

namespace FlexibleTennisLeague.Denver.Users
{
    public partial class Schedule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (StoredData.User.Division == 15)
                    playOffs.Visible = true;
            }
            catch { }
        }
    }
}
