using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Linq;
using System.Transactions;
using DLL;
using System.Data;
using System.Text;
using Telerik.Web.UI;

namespace FlexibleTennisLeague.UserControls
{
    public partial class ScheduleControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
                Response.Redirect(WebConfigurationManager.AppSettings["LoginPageURL"].ToString());

            RadAjaxManager.GetCurrent(Page).AjaxRequest += new RadAjaxControl.AjaxRequestDelegate(Schedule_AjaxRequest);
            if (!Page.IsPostBack)
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    if (!StoredData.User.TempDivision.Value && !StoredData.User.AccessExpired.Value)
                    {
                        var upcomingMatches = dataContext.GetUpcomingMatches(StoredData.User.UserId);
                        upcomingMatchesRadGrid.DataSource = upcomingMatches;
                        upcomingMatchesRadGrid.DataBind();

                        var previousMatches = dataContext.GetPreviousMatches(StoredData.User.UserId);
                        previousMatchesRadGrid.DataSource = previousMatches;
                        previousMatchesRadGrid.DataBind();

                        List<SelectDivisionResult> selectDivisionResult = dataContext.SelectDivision(StoredData.User.Division.Value).ToList();
                        foreach (SelectDivisionResult result in selectDivisionResult)
                        {
                            if (result.StartDate > DateTime.Now)
                            {
                                warningImage.Visible = true;
                                warningLinkButton.Visible = true;
                                warningLinkButton.Text = "Although you may play practice matches with members in your league. You will not be able to record scores until the league start date of " + result.StartDate.ToShortDateString();
                                HyperLink1.Visible = false;
                                Image1.Visible = false;
                            }
                        }
                    }
                    else
                    {
                        warningImage.Visible = true;
                        warningLinkButton.Visible = true;
                        Image1.Visible = false;
                        HyperLink1.Visible = false;

                        if (StoredData.User.TempDivision.Value)
                            warningLinkButton.Text = "Your account is still being created. You will not be able to schedule matches or report scores. Please wait for the email confirming your account activation.";
                        else if (StoredData.User.AccessExpired.Value)
                        {
                            warningLinkButton.Text = "Your access has expired. Please click here to subscribe to the current season and regain access.";
                            warningLinkButton.PostBackUrl = WebConfigurationManager.AppSettings["NewLeagueRegisterURL"].ToString();
                        }
                    }
                }
            }
        }

        protected string FormatResult(bool result)
        {
            string returnResult = string.Empty;
            if (result)
                returnResult = "Won";
            else
                returnResult = "Lost";
            return returnResult;
        }

        protected string GetLocalTime(DateTime utcTime)
        {
            return utcTime.ToLocalTime().ToShortTimeString();
        }

        protected string GetLocalDate(DateTime utcTime)
        {
            return utcTime.ToLocalTime().ToShortDateString();
        }

        protected void Schedule_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            if (e.Argument == "RefreshPreviousMatches")
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    var upcomingMatches = dataContext.GetUpcomingMatches(StoredData.User.UserId);
                    upcomingMatchesRadGrid.DataSource = upcomingMatches;
                    upcomingMatchesRadGrid.Rebind();

                    var previousMatches = dataContext.GetPreviousMatches(StoredData.User.UserId);
                    previousMatchesRadGrid.DataSource = previousMatches;
                    previousMatchesRadGrid.Rebind();
                }
            }
        }

        protected void previousMatchesRadGrid_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.Item.ItemType == Telerik.Web.UI.GridItemType.Item || e.Item.ItemType == Telerik.Web.UI.GridItemType.AlternatingItem)
            {
                if (e.CommandName == "ShowPublicProfile")
                {
                    //Response.Redirect("~/Users/PublicProfile.aspx?UserId=" + Convert.ToInt32(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["UserId"]).ToString());
                    Response.Redirect(WebConfigurationManager.AppSettings["PublicProfilePath"].ToString() + "?UserId=" + e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["AspNetUserId"].ToString());
                }
            }
        }

        protected void upcomingMatchesRadGrid_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.Item.ItemType == Telerik.Web.UI.GridItemType.Item || e.Item.ItemType == Telerik.Web.UI.GridItemType.AlternatingItem)
            {
                if (e.CommandName == "ShowPublicProfile")
                {
                    //Response.Redirect("~/Users/PublicProfile.aspx?UserId=" + Convert.ToInt32(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["UserId"]).ToString());
                    Response.Redirect(WebConfigurationManager.AppSettings["PublicProfilePath"].ToString() + "?UserId=" + e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["AspNetUserId"].ToString());
                }
            }
        }

        protected void upcomingMatchesRadGrid_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            int currentUserId = StoredData.User.UserId;
            if (e.Item.ItemType == Telerik.Web.UI.GridItemType.Item || e.Item.ItemType == Telerik.Web.UI.GridItemType.AlternatingItem)
            {
                LinkButton actionLinkButton = (LinkButton)e.Item.FindControl("actionLinkButton");
                LinkButton actionLinkButton2 = (LinkButton)e.Item.FindControl("actionLinkButton2");
                Label dateLabel = (Label)e.Item.FindControl("dateLabel");
                int matchRequestUserId = Convert.ToInt32(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["UserId"]);
                int matchId = Convert.ToInt32(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["MatchId"]);
                DateTime matchDate = Convert.ToDateTime(dateLabel.Text);

                if (DateTime.Now.AddDays(-14) > matchDate)
                {
                    actionLinkButton.Text = "Contact Admin";
                    actionLinkButton.PostBackUrl = "../ContactUs.aspx";
                }
                else
                {
                    actionLinkButton.Text = "Report Score";
                    actionLinkButton.Attributes.Add("onClick", string.Format("openScoreRadWindow('{0}','{1}'); return false;", matchRequestUserId, matchId));
                }

                int courtId = Convert.ToInt32(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["CourtId"]);
                LinkButton courtLinkButton = (LinkButton)e.Item.FindControl("courtLinkButton");
                courtLinkButton.Attributes.Add("onClick", string.Format("openTennisCourtDetailsWindow({0}); return false;", courtId));
            }
        }

        protected void previousMatchesRadGrid_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is Telerik.Web.UI.GridDataItem)
            {
                Telerik.Web.UI.GridDataItem gridDataItem = e.Item as Telerik.Web.UI.GridDataItem;
                LinkButton actionLinkButton = (LinkButton)e.Item.FindControl("actionLinkButton");
                if (gridDataItem["Score"].Text == "0-0,0-0")
                {
                    actionLinkButton.Enabled = false;
                }
                else
                {
                    int matchRequestUserId = Convert.ToInt32(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["UserId"]);
                    int matchId = Convert.ToInt32(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["MatchId"]);
                    string score = gridDataItem["Score"].Text;
                    string result = gridDataItem["Result"].Text;
                    string matchDate = gridDataItem["MatchDate"].Text;

                    actionLinkButton.Attributes.Add("onClick", string.Format("openGameRatingWindow('{0}','{1}'); return false;", matchRequestUserId, matchId));
                }
                int courtId = Convert.ToInt32(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["CourtId"]);
                LinkButton courtLinkButton = (LinkButton)e.Item.FindControl("courtLinkButton");
                courtLinkButton.Attributes.Add("onClick", string.Format("openTennisCourtDetailsWindow({0}); return false;", courtId));
            }
        }
    }
}