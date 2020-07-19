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
    public partial class PublicProfileControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
                Response.Redirect(WebConfigurationManager.AppSettings["LoginPageURL"].ToString());

            Guid userId = new Guid(Request.QueryString["UserId"]);
            using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
            {
                ISingleResult<SelectUserPublicProfileByProfileIdResult> users = dataContext.SelectUserPublicProfileByProfileId(userId);
                SelectUserPublicProfileByProfileIdResult user = users.First();
                userLabel.Text = user.FirstName + " " + user.LastName;

                //Load Image
                if (user.ProfileImageName.HasValue)
                    profileImage.ImageUrl = string.Format("~/ProfileImages/{0}.jpg", user.ProfileImageName.ToString());

                divisionLabel.Text = user.Division;
                homeCourtLabel.Text = user.CourtName;
                ntrpRankingLabel.Text = user.NTRPRanking.ToString();
                ageGroupLabel.Text = user.AgeGroup;
                racquetHandLabel.Text = user.RacquetHand;
                favoriteShotLabel.Text = user.FavoriteShot;
                racquetLabel.Text = user.Racquet;


                if (!StoredData.User.TempDivision.Value || (user.DivisionId != StoredData.User.Division) || !StoredData.User.AccessExpired.Value)
                {
                    emailHyperLink.Text = user.EmailId;
                    emailHyperLink.NavigateUrl = string.Format("mailto:{0}", user.EmailId);
                    phoneLabel.Text = user.Phone;
                    facebookHyperLink.Text = user.Facebook;
                    facebookHyperLink.NavigateUrl = user.Facebook;
                    linkedInHyperLink.Text = user.LinkedIn;
                    linkedInHyperLink.NavigateUrl = user.LinkedIn;
                    myspaceHyperLink.Text = user.MySpace;
                    myspaceHyperLink.NavigateUrl = user.MySpace;
                    orkutHyperLink.Text = user.Orkut;
                    orkutHyperLink.NavigateUrl = user.Orkut;
                }

                List<Performance> performances = dataContext.SelectPerformanceByUserId(user.UserId).ToList();

                Performance seasonPerformance = performances.Find(p => p.DivisionId == user.DivisionId);
                seasonWinsLabel.Text = string.Format("{0}W - {1}L", seasonPerformance.Win, seasonPerformance.Loss);
                seasonPointsLabel.Text = seasonPerformance.TotalPoints.ToString();

                overallWinsLabel.Text = string.Format("{0}W - {1}L", performances.Sum(p => p.Win), performances.Sum(p => p.Loss));
                overallPointsLabel.Text = performances.Sum(p => p.TotalPoints).ToString();

                if (!StoredData.User.TempDivision.Value)
                {
                    List<GetUpcomingMatchesResult> upcomingMatches = dataContext.GetUpcomingMatches(user.UserId).ToList();
                    upcomingMatchesRadGrid.DataSource = upcomingMatches;
                    upcomingMatchesRadGrid.DataBind();

                    List<GetPreviousMatchesResult> previousMatches = dataContext.GetPreviousMatches(user.UserId).ToList();
                    previousMatchesRadGrid.DataSource = previousMatches;
                    previousMatchesRadGrid.DataBind();


                    int upcomingMatchCount = Convert.ToInt32(upcomingMatches.Count(p => p.UserId == StoredData.User.UserId));
                    int previousMatchCount = Convert.ToInt32(previousMatches.Count(p => p.UserId == StoredData.User.UserId));
                }

                //Get availability
                List<SelectAvailabilitiesByUserIdResult> availabilities = dataContext.SelectAvailabilitiesByUserId(user.UserId).ToList();
                SetAvailabilities(availabilities);

                if (StoredData.User.TempDivision.Value || StoredData.User.AccessExpired.Value)
                    matchRequestLinkButton.Enabled = false;
                else
                {
                    List<SelectDivisionResult> selectDivisionResult = dataContext.SelectDivision(StoredData.User.Division.Value).ToList();
                    foreach (SelectDivisionResult result in selectDivisionResult)
                    {
                        if (result.StartDate > DateTime.Now)
                        {
                            matchRequestLinkButton.Enabled = false;
                        }
                    }
                }

                //TODO: Have to uncomment these lines below
                //if ((upcomingMatchCount + previousMatchCount) < 2)
                matchRequestLinkButton.Attributes.Add("onClick", string.Format("openRadWindow('{0}'); return false;", user.UserId));
                //else
                //matchRequestLinkButton.Attributes.Add("onClick", "alert('You have already played two matches against this player for the season. You cannot play against a player more than twice.');return false;");
                //matchRequestLinkButton.PostBackUrl = WebConfigurationManager.AppSettings["MatchRequestPath"].ToString();
            }
        }

        private void SetAvailabilities(List<SelectAvailabilitiesByUserIdResult> availabilities)
        {
            if (availabilities.Count == 0)
            {
                sundayLabel.Text = mondayLabel.Text = tuesdayLabel.Text = wednesdayLabel.Text = thursdayLabel.Text = fridayLabel.Text = saturdayLabel.Text = "-";
            }
            else
            {
                if (availabilities[0].SundayUnavailable.Value)
                    sundayLabel.Text = "Busy";
                else
                    sundayLabel.Text = availabilities[0].SundayStart.Value.ToShortTimeString() + "-" + availabilities[0].SundayEnd.Value.ToShortTimeString();

                if (availabilities[0].MondayUnavailable.Value)
                    mondayLabel.Text = "Busy";
                else
                    mondayLabel.Text = availabilities[0].MondayStart.Value.ToShortTimeString() + "-" + availabilities[0].MondayEnd.Value.ToShortTimeString();

                if (availabilities[0].TuesdayUnavailable.Value)
                    tuesdayLabel.Text = "Busy";
                else
                    tuesdayLabel.Text = availabilities[0].TuesdayStart.Value.ToShortTimeString() + "-" + availabilities[0].TuesdayEnd.Value.ToShortTimeString();

                if (availabilities[0].WednesdayUnavailable.Value)
                    wednesdayLabel.Text = "Busy";
                else
                    wednesdayLabel.Text = availabilities[0].WednesdayStart.Value.ToShortTimeString() + "-" + availabilities[0].WednesdayEnd.Value.ToShortTimeString();

                if (availabilities[0].ThursdayUnavailable.Value)
                    thursdayLabel.Text = "Busy";
                else
                    thursdayLabel.Text = availabilities[0].ThursdayStart.Value.ToShortTimeString() + "-" + availabilities[0].ThursdayEnd.Value.ToShortTimeString();

                if (availabilities[0].FridayUnavailable.Value)
                    fridayLabel.Text = "Busy";
                else
                    fridayLabel.Text = availabilities[0].FridayStart.Value.ToShortTimeString() + "-" + availabilities[0].FridayEnd.Value.ToShortTimeString();

                if (availabilities[0].SaturdayUnavailable.Value)
                    saturdayLabel.Text = "Busy";
                else
                    saturdayLabel.Text = availabilities[0].SaturdayStart.Value.ToShortTimeString() + "-" + availabilities[0].SaturdayEnd.Value.ToShortTimeString();
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

    }
}