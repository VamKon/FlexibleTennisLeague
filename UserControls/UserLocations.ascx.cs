using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DLL;

namespace FlexibleTennisLeague.UserControls
{
    public partial class UserLocations : System.Web.UI.UserControl
    {
        public string geoRSSFeed;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!StoredData.User.AccessExpired.Value && !StoredData.User.TempDivision.Value)
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    geoRSSFeed = string.Format("/TennisCourts/PlayerLocations.ashx?Division={0}", Encryption.Encrypt(StoredData.User.Division.Value.ToString(), "skhdhkrwshrkhwrh"));
                }
            }
        }
    }
}