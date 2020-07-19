using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DLL;

namespace FlexibleTennisLeague.Common
{
    public partial class TennisCourtDetails : System.Web.UI.Page
    {
        public string geoRSSFeed;
        protected void Page_Load(object sender, EventArgs e)
        {
            int courtId = Convert.ToInt32(Request.QueryString["CourtId"]);
            using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
            {
                List<SelectTennisCourtResult> selectTennisCourtResult = dataContext.SelectTennisCourt(courtId).ToList();
                if (selectTennisCourtResult.Count > 0)
                {
                    nameLabel.Text = selectTennisCourtResult[0].CourtName;
                    addressLabel.Text = selectTennisCourtResult[0].Address + ", " + selectTennisCourtResult[0].City + ", " + selectTennisCourtResult[0].State + " " + selectTennisCourtResult[0].Zip;
                    phoneLabel.Text = selectTennisCourtResult[0].Phone;
                    noOfCourtsLabel.Text = selectTennisCourtResult[0].NumberCourts.ToString();
                    openToPublicLabel.Text = selectTennisCourtResult[0].IsPublic ? "Yes" : "No";
                    lightsLabel.Text = selectTennisCourtResult[0].HasLights ? "Yes" : "No";
                    feesLabel.Text = selectTennisCourtResult[0].HasFees ? "Yes" : "No";
                    ViewState["mapId"] = selectTennisCourtResult[0].MapId-1;
                    //geoRSSFeed = selectTennisCourtResult[0].GeoRSSPath;
                    geoRSSFeed = string.Format("/TennisCourts/RSSFeed.ashx?League={0}", Encryption.Encrypt(selectTennisCourtResult[0].League.ToString(), DateTime.Now.ToString("MMddyymm")));
                }
            }
        }

        protected void RadAjaxManager1_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
        {
            if (e.Argument == "ZoomToTennisCourt")
            {
                if (ViewState["mapId"] != null)
                {
                    int courtMapId = Convert.ToInt32(ViewState["mapId"]);
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "ZoomToCourt", string.Format("zoomToTennisCourt({0});", courtMapId), true);
                }
            }
        }
    }
}
