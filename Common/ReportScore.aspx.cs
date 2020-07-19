using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Linq;
using System.Transactions;
using System.Text;
using System.Net.Mail;
using System.Web.Configuration;
using DLL;

namespace FlexibleTennisLeague.Common
{
    public partial class ReportScore : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsAuthenticated)
            {
                int? opponentId = null;
                int? matchId = null;
                string mode = string.Empty;
                if (Request.QueryString["opponentId"] != null)
                {
                    opponentId = Convert.ToInt32(Request.QueryString["opponentId"]);
                    opponentIdHiddenField.Value = opponentId.ToString();
                }
                //RadDatePicker1.MinDate = DateTime.Now;
                if (Request.QueryString["matchId"] != null)
                {
                    matchId = Convert.ToInt32(Request.QueryString["matchId"]);
                    matchIdHiddenField.Value = matchId.ToString();
                }
                if (Request.QueryString["mode"] != null)
                {
                    mode = Request.QueryString["mode"].ToString();
                }
                ViewState["Submitted"] = false;

                Page.Title = "Report Score";
                if (!Page.IsPostBack)
                {
                    using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                    {
                        opponentDropDownList.Items.Clear();
                        List<LeaguePerformance> leaguePerformances = dataContext.SelectLeaguePerformanceByDivision(StoredData.User.Division).ToList();
                        opponentDropDownList.Items.Add(new ListItem(string.Empty, string.Empty));
                        foreach (LeaguePerformance leaguePerformance in leaguePerformances)
                        {
                            if (leaguePerformance.UserId != StoredData.User.UserId)
                                opponentDropDownList.Items.Add(new ListItem(leaguePerformance.FirstName + " " + leaguePerformance.LastName, leaguePerformance.UserId.ToString()));
                        }
                        opponentDropDownList.SelectedValue = opponentId.ToString();
                        

                        List<TennisCourt> tennisCourts = dataContext.SelectTennisCourtsByLeague(leaguePerformances[0].LeagueId).ToList();
                        locationDropDownList.DataSource = tennisCourts;
                        locationDropDownList.DataTextField = "CourtName";
                        locationDropDownList.DataValueField = "CourtId";
                        locationDropDownList.DataBind();

                        //RadDatePicker1.MinDate = Convert.ToDateTime("1/1/2009");
                        if (!string.IsNullOrEmpty(mode))
                        {
                            RadDatePicker1.MinDate = DateTime.Now.AddDays(-14);
                        }
                        
                        if (matchId.HasValue)
                        {
                            ISingleResult<SelectMatchResult> matches = dataContext.SelectMatch(matchId);
                            SelectMatchResult match = matches.First();
                            RadDatePicker1.SelectedDate = match.MatchDate;
                            RadTimePicker1.SelectedDate = match.MatchDate;
                            locationDropDownList.SelectedValue = match.TennisCourt.ToString();
                            RadDatePicker1.MaxDate = match.MatchDate;
                        }
                        else
                        {
                            locationDropDownList.SelectedValue = StoredData.User.HomeCourt.ToString();
                            RadDatePicker1.MaxDate = DateTime.Now;
                        }

                        winnerDropDownList.Items.Clear();
                        winnerDropDownList.Items.Add(new ListItem());
                        winnerDropDownList.Items.Add(new ListItem(StoredData.User.FirstName + " " + StoredData.User.LastName, StoredData.User.UserId.ToString()));
                        if (opponentId.HasValue)
                        {
                            winnerDropDownList.Items.Add(new ListItem(opponentDropDownList.SelectedItem.Text, opponentDropDownList.SelectedItem.Value));
                            opponentDropDownList.Enabled = false;
                        }

                    }

                }
            }
        }

        protected void submitButton_Click(object sender, EventArgs e)
        {
            if (validate() && !Convert.ToBoolean(ViewState["Submitted"]))
            {
                if (!noShowCheckBox.Checked)
                {
                    ViewState["Submitted"] = true;
                    int userTravelPoints = 0;
                    int opponentTravelPoints = 0;
                    int userScorePoints = 0;
                    int opponentScorePoints = 0;
                    int userWinPoints = 0;
                    int opponentWinPoints = 0;
                    bool userWin = false;
                    bool opponentWin = false;
                    int userWinNumber = 0;
                    int userLossNumber = 0;
                    int opponentWinNumber = 0;
                    int opponentLossNumber = 0;

                    //ScorePoints
                    if (Convert.ToInt32(playerSet3DropDownListSet.SelectedValue) > 0 || Convert.ToInt32(opponentSet3DropDownList.SelectedValue) > 0)
                    {
                        if (Convert.ToInt32(winnerDropDownList.SelectedValue) == StoredData.User.UserId)
                        {
                            userWinPoints = 3;
                            userWin = true;
                            userWinNumber = 1;
                            opponentLossNumber = 1;
                        }
                        else
                        {
                            opponentWinPoints = 3;
                            opponentWin = true;
                            opponentWinNumber = 1;
                            userLossNumber = 1;
                        }
                    }
                    else
                    {
                        if (Convert.ToInt32(winnerDropDownList.SelectedValue) == StoredData.User.UserId)
                        {
                            userWinPoints = 3;
                            userScorePoints = 1;
                            userWin = true;
                            userWinNumber = 1;
                            opponentLossNumber = 1;
                        }
                        else
                        {
                            opponentWinPoints = 3;
                            opponentScorePoints = 1;
                            opponentWin = true;
                            opponentWinNumber = 1;
                            userLossNumber = 1;
                        }
                    }
                    //Convert match score to string
                    StringBuilder scoreString = new StringBuilder();
                    scoreString.Append(string.Format("{0}-{1},{2}-{3}", playerSet1DropDownListSet.SelectedValue, opponentSet1DropDownList.SelectedValue, playerSet2DropDownListSet.SelectedValue, opponentSet2DropDownList.SelectedValue));
                    if (Convert.ToInt32(playerSet3DropDownListSet.SelectedValue) > 0 || Convert.ToInt32(opponentSet3DropDownList.SelectedValue) > 0)
                        scoreString.Append(string.Format(",{0}-{1}", playerSet3DropDownListSet.SelectedValue, opponentSet3DropDownList.SelectedValue, playerSet2DropDownListSet.SelectedValue, opponentSet2DropDownList.SelectedValue));

                    DateTime selectedDateTime = Convert.ToDateTime(RadDatePicker1.SelectedDate.Value.ToShortDateString() + " " + RadTimePicker1.SelectedDate.Value.ToShortTimeString());
                    bool success = false;
                    using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                    {
                        List<SelectUserPublicProfileResult> selectUserPublicProfileResult = dataContext.SelectUserPublicProfile(Convert.ToInt32(opponentIdHiddenField.Value)).ToList();

                        //TravelPoints
                        int selectedCourtId = Convert.ToInt32(locationDropDownList.SelectedItem.Value);
                        if (selectedCourtId != StoredData.User.HomeCourt)
                            userTravelPoints = 1;
                        if (selectedCourtId != selectUserPublicProfileResult[0].HomeCourt)
                            opponentTravelPoints = 1;

                        
                        //Check travel points
                        int? oppponentTotalTravelPoints=0;
                        List<SelectTotalTravelPointsByUserIdResult> pastTravelPoints = dataContext.SelectTotalTravelPointsByUserId(StoredData.User.UserId, Convert.ToInt32(opponentIdHiddenField.Value), StoredData.User.Division, ref oppponentTotalTravelPoints).ToList();

                        if (pastTravelPoints.Count > 0)
                        {
                            if (pastTravelPoints[0].TotalTravelPoints == 4)
                                userTravelPoints = 0;
                        }
                        if (oppponentTotalTravelPoints.Value == 4)
                            opponentTravelPoints = 0;

                        

                        int? matchPointLogId = 0;
                        int? matchId=null;
                        int? opponentId = null;
                        using (TransactionScope transactionScope = new TransactionScope())
                        {
                            if (string.IsNullOrEmpty(matchIdHiddenField.Value))
                            {
                                opponentId = Convert.ToInt32(opponentDropDownList.SelectedItem.Value);
                                dataContext.InsertMatch(selectedDateTime, selectedCourtId, StoredData.User.UserId, Convert.ToInt32(opponentDropDownList.SelectedItem.Value), 2, scoreString.ToString(), ref matchId);
                            }
                            else
                            {
                                matchId = Convert.ToInt32(matchIdHiddenField.Value);
                                opponentId = Convert.ToInt32(opponentIdHiddenField.Value);
                                dataContext.UpdateMatch(matchId.Value, selectedDateTime, selectedCourtId, Convert.ToInt32(MatchStatus.Completed), scoreString.ToString());
                            }

                            dataContext.InsertMatchPointLog(matchId.Value, StoredData.User.UserId, userWin, 1, userTravelPoints, userScorePoints, userWinPoints, ref matchPointLogId);
                            dataContext.InsertMatchPointLog(matchId.Value, opponentId.Value, opponentWin, 1, opponentTravelPoints, opponentScorePoints, opponentWinPoints, ref matchPointLogId);

                            dataContext.UpdatePerformance(StoredData.User.UserId, userWinNumber, userLossNumber, userScorePoints + userTravelPoints + userWinPoints + 1,userTravelPoints);
                            dataContext.UpdatePerformance(opponentId.Value, opponentWinNumber, opponentLossNumber, opponentScorePoints + opponentTravelPoints + opponentWinPoints + 1,opponentTravelPoints);

                            transactionScope.Complete();
                            success = true;
                        }

                        if (selectUserPublicProfileResult.Count > 0)
                        {
                            if (userWin)
                                SendEmail(selectUserPublicProfileResult[0].EmailId, StoredData.User.FirstName + " " + StoredData.User.LastName, scoreString.ToString());
                            else
                                SendEmail(selectUserPublicProfileResult[0].EmailId, opponentDropDownList.SelectedItem.Text, scoreString.ToString());
                        }
                    }
                    if (success)
                    {
                        string closingScript = "closeRadWindowAndShowAlert('Score successfully submited.')";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "radalert", "(function(){var f = function(){" + closingScript + ";Sys.Application.remove_load(f);};Sys.Application.add_load(f);})()", true);
                    }
                }
                else
                {
                    StringBuilder stringBuilder = new StringBuilder();
                    stringBuilder.Append("radconfirm('We are sorry to hear that your opponent did not show up.<br/> We take such incidents very seriously.<br/> Your opponent will receive two penalty points.<br/>Do you want to continue?");

                    stringBuilder.Append("',confirmCallBackFn,400,null,null,'No Show!!')");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "radconfirm", "(function(){var f = function(){" + stringBuilder.ToString() + ";Sys.Application.remove_load(f);};Sys.Application.add_load(f);})()", true);
                }
            }
        }

        private void SendEmail(string opponentEmailId, string winner, string score)
        {
            StringBuilder stringBuilder = new StringBuilder();
            string subject = "Score posted on FlexibleTennisLeague";
            try
            {
                MailMessage mailMessage = new MailMessage();

                mailMessage.From = new MailAddress("admin@FlexibleTennisLeague.com");
                mailMessage.To.Add(opponentEmailId);
                mailMessage.CC.Add(StoredData.User.EmailId);
                mailMessage.Bcc.Add(WebConfigurationManager.AppSettings["EmailId"].ToString());
                mailMessage.Subject = subject;
            
                stringBuilder.Append(string.Format("Dear {0},\r\n\r\n", opponentDropDownList.SelectedItem.Text));
                stringBuilder.Append(string.Format("The following score for your recent match against {0} {1} at {2} has been posted on {3} {4}\r\n\r\n", StoredData.User.FirstName, StoredData.User.LastName,locationDropDownList.SelectedItem.Text,DateTime.Now.ToShortDateString(), DateTime.Now.ToShortTimeString()));
                stringBuilder.Append(string.Format("Winner : {0}\r\n", winner));
                stringBuilder.Append(string.Format("Score : {0}\r\n",score));
                stringBuilder.Append(string.Format("Was no show : {0}\r\n\r\n", noShowCheckBox.Checked.ToString()));
                stringBuilder.Append("Please login to the FlexibleTennisLeague.com to rate your game and your opponent's game.\r\n");
                stringBuilder.Append("Please email incorrect scores and other complaints/suggestions to admin@flexibletennisleague.com.\r\n\r\n");
                stringBuilder.Append("Thank you for choosing FlexibleTennisLeague.\r\n");
                stringBuilder.Append("Administrator -- FlexibleTennisLeague.");

                mailMessage.Body = Server.HtmlEncode(stringBuilder.ToString());

                SmtpClient smtpClient = new SmtpClient();
                smtpClient.Send(mailMessage);
            }
            catch(Exception exception)
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    int? id = null;
                    dataContext.InsertEmailError(StoredData.User.UserId, opponentEmailId, StoredData.User.EmailId, subject, stringBuilder.ToString(), exception.Message + "\r\n\r\n" + exception.StackTrace, ref id);
                }
            }
        }

        private bool validate()
        {
            bool isValidated = true;
            try
            {
                string selectedDateTime = RadDatePicker1.SelectedDate.Value.ToShortDateString() + " " + RadTimePicker1.SelectedDate.Value.ToShortTimeString();
                DateTime dateTime = Convert.ToDateTime(selectedDateTime);
            }
            catch
            {
                isValidated = false;
                string closingScript = "showAlert('Please enter appropriate Date/Time values.')";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "radconfirm", "(function(){var f = function(){" + closingScript + ";Sys.Application.remove_load(f);};Sys.Application.add_load(f);})()", true);
            }

            //Check if scores entered match the result entered
            if (Convert.ToInt32(winnerDropDownList.SelectedValue) == StoredData.User.UserId && !noShowCheckBox.Checked)
            {
                int userWin = 0;

                if (Convert.ToInt32(playerSet1DropDownListSet.SelectedValue) > Convert.ToInt32(opponentSet1DropDownList.SelectedValue))
                    userWin++;
                if (Convert.ToInt32(playerSet2DropDownListSet.SelectedValue) > Convert.ToInt32(opponentSet2DropDownList.SelectedValue))
                    userWin++;
                if (Convert.ToInt32(playerSet3DropDownListSet.SelectedValue) > Convert.ToInt32(opponentSet3DropDownList.SelectedValue))
                    userWin++;

                if (userWin < 2)
                {
                    isValidated = false;
                    string closingScript = "showAlert('The match result varies from the score. Please verify.')";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "radconfirm", "(function(){var f = function(){" + closingScript + ";Sys.Application.remove_load(f);};Sys.Application.add_load(f);})()", true);
                }

            }
            else if (Convert.ToInt32(winnerDropDownList.SelectedValue) == Convert.ToInt32(opponentIdHiddenField.Value) && !noShowCheckBox.Checked)
            {
                int userWin = 0;

                if (Convert.ToInt32(playerSet1DropDownListSet.SelectedValue) < Convert.ToInt32(opponentSet1DropDownList.SelectedValue))
                    userWin++;
                if (Convert.ToInt32(playerSet2DropDownListSet.SelectedValue) < Convert.ToInt32(opponentSet2DropDownList.SelectedValue))
                    userWin++;
                if (Convert.ToInt32(playerSet3DropDownListSet.SelectedValue) < Convert.ToInt32(opponentSet3DropDownList.SelectedValue))
                    userWin++;

                if (userWin < 2)
                {
                    isValidated = false;
                    string closingScript = "showAlert('The match result varies from the score. Please verify.')";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "radconfirm", "(function(){var f = function(){" + closingScript + ";Sys.Application.remove_load(f);};Sys.Application.add_load(f);})()", true);
                }
            }

            //Check if score dropdowns are populated in the order

            if ((Convert.ToInt32(playerSet3DropDownListSet.SelectedValue) > 0 || Convert.ToInt32(opponentSet3DropDownList.SelectedValue) > 0) && ((Convert.ToInt32(playerSet1DropDownListSet.SelectedValue) == 0 && Convert.ToInt32(opponentSet1DropDownList.SelectedValue) == 0) || (Convert.ToInt32(playerSet2DropDownListSet.SelectedValue) == 0 && Convert.ToInt32(opponentSet2DropDownList.SelectedValue) == 0)))
            {
                isValidated = false;
                string closingScript = "showAlert('Score not entered in proper format. Please verify.')";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "radconfirm", "(function(){var f = function(){" + closingScript + ";Sys.Application.remove_load(f);};Sys.Application.add_load(f);})()", true);
            }

            if (StoredData.User.AccessExpired.Value || StoredData.User.TempDivision.Value)
                isValidated = false;

            if(isValidated)
                ScriptManager.RegisterStartupScript(this, this.GetType(), "DisableButton", "changeButtonState('true');", true);

            return isValidated;
        }

        protected string GetLocalTime(DateTime utcTime)
        {
            return utcTime.ToLocalTime().ToShortTimeString();
        }

        protected string GetLocalDate(DateTime utcTime)
        {
            return utcTime.ToLocalTime().ToShortDateString();
        }

        protected void RadAjaxManager1_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
        {
            if (e.Argument == "true")
            {
                if (!StoredData.User.AccessExpired.Value && !StoredData.User.TempDivision.Value)
                {
                    bool success = false;
                    using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                    {
                        int? matchPointLogId = 0;
                        int? matchId = null;
                        int? opponentId = null;
                        DateTime selectedDateTime = Convert.ToDateTime(RadDatePicker1.SelectedDate.Value.ToShortDateString() + " " + RadTimePicker1.SelectedDate.Value.ToShortTimeString());
                        using (TransactionScope transactionScope = new TransactionScope())
                        {
                            if (string.IsNullOrEmpty(matchIdHiddenField.Value))
                            {
                                opponentId = Convert.ToInt32(opponentDropDownList.SelectedItem.Value);
                                dataContext.InsertMatch(selectedDateTime, Convert.ToInt32(locationDropDownList.Text), StoredData.User.UserId, Convert.ToInt32(opponentDropDownList.SelectedItem.Value), 2, "0-0,0-0", ref matchId);
                            }
                            else
                            {
                                matchId = Convert.ToInt32(matchIdHiddenField.Value);
                                opponentId = Convert.ToInt32(opponentIdHiddenField.Value);
                                dataContext.UpdateMatch(matchId.Value, selectedDateTime, Convert.ToInt32(locationDropDownList.Text), Convert.ToInt32(MatchStatus.Completed), "0-0,0-0");
                            }

                            dataContext.InsertMatchPointLog(matchId.Value, StoredData.User.UserId, true, 1, 0, 0, 3, ref matchPointLogId);
                            dataContext.InsertMatchPointLog(matchId.Value, opponentId.Value, false, 0, 0, 0, 0, ref matchPointLogId);

                            dataContext.UpdatePerformance(StoredData.User.UserId, 1, 0, 4,0);
                            dataContext.UpdatePerformance(opponentId.Value, 0, 1, 0,0);

                            dataContext.UpdateUserWarningByUserId(opponentId.Value, 2);

                            transactionScope.Complete();
                            success = true;
                        }
                    }
                    if (success)
                    {
                        string closingScript = "<script type='text/javascript'>Sys.Application.add_load(function () {closeRadWindowAndShowAlert('No show successfully recorded.');}); </script> ";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "radalert", closingScript, false);
                    }
                }
                
            }
            else
                ScriptManager.RegisterStartupScript(this, this.GetType(), "EnableButton", "changeButtonState('false');", true);
        }

        protected void opponentDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            opponentIdHiddenField.Value = opponentDropDownList.SelectedItem.Value;
            winnerDropDownList.Items.Add(new ListItem(opponentDropDownList.SelectedItem.Text, opponentDropDownList.SelectedItem.Value));
        }
    }
}
