using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Linq;
using DLL;

namespace FlexibleTennisLeague.UserControls
{
    public partial class LeagueControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
                Response.Redirect(WebConfigurationManager.AppSettings["LoginPageURL"].ToString());

            if (!Page.IsPostBack)
            {
                //Hide next division panel if the current user is not signed up for next division.
                if (StoredData.User.NextDivision==StoredData.User.Division)
                    nextLeaguePanel.Visible = false;

                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    if (StoredData.User.TempDivision.Value || StoredData.User.AccessExpired.Value)
                    {
                        warningImage.Visible = true;
                        warningLinkButton.Visible = true;
                        if (StoredData.User.TempDivision.Value)
                            warningLinkButton.Text = "Your account is still being created. You will not be able to schedule matches or report scores. Please wait for the email confirming your account activation.";
                        else if (StoredData.User.AccessExpired.Value)
                        {
                            warningLinkButton.Text = "Your access has expired. Please click here to subscribe to the current season and regain access.";
                            warningLinkButton.PostBackUrl = WebConfigurationManager.AppSettings["NewLeagueRegisterURL"].ToString();
                        }
                    }
                    else
                    {
                        leagueRadGrid.Rebind();
                        nextLeagueRadGrid.Rebind();
                    }

                    List<SelectDivisionResult> selectDivisionResult = dataContext.SelectDivision(StoredData.User.Division).ToList();
                    if (selectDivisionResult.Count > 0)
                    {
                        leagueLabel.Text = selectDivisionResult[0].Division;
                    }

                    if (StoredData.User.NextDivision!=StoredData.User.Division)
                    {
                        List<SelectDivisionResult> selectNextDivisionResult = dataContext.SelectDivision(StoredData.User.NextDivision.Value).ToList();
                        if (selectNextDivisionResult.Count > 0)
                        {
                            nextLeagueLabel.Text = selectNextDivisionResult[0].Division + " (Your Next Season)";
                        }
                    }
                }
            }
        }

        protected void leagueRadGrid_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.Item.ItemType == Telerik.Web.UI.GridItemType.Item || e.Item.ItemType == Telerik.Web.UI.GridItemType.AlternatingItem)
            {
                if (e.CommandName == "ShowPublicProfile")
                {
                    Response.Redirect(WebConfigurationManager.AppSettings["PublicProfilePath"].ToString() + "?UserId=" + e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["AspNetUserId"].ToString());
                }
            }
        }

        protected void leagueRadGrid_NeedDataSource(object source, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            if (!StoredData.User.TempDivision.Value && !StoredData.User.AccessExpired.Value)
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    List<LeaguePerformance> leaguePerformance = dataContext.SelectLeaguePerformanceByDivision(StoredData.User.Division).ToList();
                    leagueRadGrid.DataSource = leaguePerformance;
                }
            }
        }

        protected void nextLeagueRadGrid_NeedDataSource(object source, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            if (!StoredData.User.TempDivision.Value && !StoredData.User.AccessExpired.Value && StoredData.User.NextDivision.HasValue)
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    List<LeaguePerformance> leaguePerformance = dataContext.SelectLeaguePerformanceByDivision(StoredData.User.NextDivision.Value).ToList();
                    nextLeagueRadGrid.DataSource = leaguePerformance;
                }
            }
        }
    }
}