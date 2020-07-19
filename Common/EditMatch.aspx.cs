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
    public partial class EditMatch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsAuthenticated)
            {
                int appointmentId = Convert.ToInt32(Request.QueryString["AppointmentId"]);
                if (!IsPostBack)
                {
                    if (!StoredData.User.TempDivision.Value || !StoredData.User.AccessExpired.Value)
                    {
                        using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                        {
                            List<SelectMatchByAppointmentIdResult> selectMatchByAppointmentIdResult = dataContext.SelectMatchByAppointmentId(appointmentId).ToList();
                            int? matchId = null;
                            if (selectMatchByAppointmentIdResult.Count > 0)
                            {
                                int opponentId = 0;
                                matchId = selectMatchByAppointmentIdResult[0].MatchId;
                                if (selectMatchByAppointmentIdResult[0].User1 == StoredData.User.UserId)
                                    opponentId = selectMatchByAppointmentIdResult[0].User2.Value;
                                else
                                    opponentId = selectMatchByAppointmentIdResult[0].User1.Value;

                                ViewState["opponentId"] = opponentId;
                                ViewState["matchId"] = matchId;

                                ISingleResult<SelectUserPublicProfileResult> users = dataContext.SelectUserPublicProfile(opponentId);
                                SelectUserPublicProfileResult user = users.First();
                                opponentLabel.Text = user.FirstName + " " + user.LastName;

                                RadDatePicker1.SelectedDate = selectMatchByAppointmentIdResult[0].MatchDate;
                                RadDatePicker1.MinDate = DateTime.Now.AddDays(1);
                                RadTimePicker1.SelectedDate = selectMatchByAppointmentIdResult[0].MatchDate;

                                List<TennisCourt> tennisCourts = dataContext.SelectTennisCourtsByEmailId(StoredData.User.EmailId).ToList();
                                locationDropDownList.DataSource = tennisCourts;
                                locationDropDownList.DataTextField = "CourtName";
                                locationDropDownList.DataValueField = "CourtId";
                                locationDropDownList.DataBind();

                                locationDropDownList.SelectedValue = selectMatchByAppointmentIdResult[0].TennisCourt.ToString();
                            }
                        }
                    }
                }
            }
        }

        protected void submitButton_Click(object sender, EventArgs e)
        {
            if (validate())
            {
                DateTime selectedDateTime = Convert.ToDateTime(RadDatePicker1.SelectedDate.Value.ToShortDateString() + " " + RadTimePicker1.SelectedDate.Value.ToShortTimeString());
                int opponentId = Convert.ToInt32(ViewState["opponentId"]);
                int matchId = Convert.ToInt32(ViewState["matchId"]);
                bool timeValid = true;
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    //Get opponents availability
                    List<SelectAvailabilitiesByUserIdResult> availability = dataContext.SelectAvailabilitiesByUserId(opponentId).ToList();
                    #region Availability
                    if (availability.Count > 0)
                    {
                        //Find day of week for currently selected date and get opponents availability for that date.
                        DateTime availabilityStart = selectedDateTime;
                        DateTime availabilityEnd = selectedDateTime;
                        bool unavailable = false;
                        switch (selectedDateTime.DayOfWeek)
                        {
                            case DayOfWeek.Sunday: if (availability[0].SundayStart.HasValue)
                                {
                                    availabilityStart = availability[0].SundayStart.Value;
                                    availabilityEnd = availability[0].SundayEnd.Value;
                                }
                                else if (availability[0].SundayUnavailable.HasValue)
                                {
                                    unavailable = availability[0].SundayUnavailable.Value;
                                }
                                break;
                            case DayOfWeek.Monday: if (availability[0].MondayStart.HasValue)
                                {
                                    availabilityStart = availability[0].MondayStart.Value;
                                    availabilityEnd = availability[0].MondayEnd.Value;
                                }
                                else if (availability[0].MondayUnavailable.HasValue)
                                {
                                    unavailable = availability[0].MondayUnavailable.Value;
                                }
                                break;
                            case DayOfWeek.Tuesday: if (availability[0].TuesdayStart.HasValue)
                                {
                                    availabilityStart = availability[0].TuesdayStart.Value;
                                    availabilityEnd = availability[0].TuesdayEnd.Value;
                                }
                                else if (availability[0].TuesdayUnavailable.HasValue)
                                {
                                    unavailable = availability[0].TuesdayUnavailable.Value;
                                }
                                break;
                            case DayOfWeek.Wednesday: if (availability[0].WednesdayStart.HasValue)
                                {
                                    availabilityStart = availability[0].WednesdayStart.Value;
                                    availabilityEnd = availability[0].WednesdayEnd.Value;
                                }
                                else if (availability[0].WednesdayUnavailable.HasValue)
                                {
                                    unavailable = availability[0].WednesdayUnavailable.Value;
                                }
                                break;
                            case DayOfWeek.Thursday: if (availability[0].ThursdayStart.HasValue)
                                {
                                    availabilityStart = availability[0].ThursdayStart.Value;
                                    availabilityEnd = availability[0].ThursdayEnd.Value;
                                }
                                else if (availability[0].ThursdayUnavailable.HasValue)
                                {
                                    unavailable = availability[0].ThursdayUnavailable.Value;
                                }
                                break;
                            case DayOfWeek.Friday: if (availability[0].FridayStart.HasValue)
                                {
                                    availabilityStart = availability[0].FridayStart.Value;
                                    availabilityEnd = availability[0].FridayEnd.Value;
                                }
                                else if (availability[0].FridayUnavailable.HasValue)
                                {
                                    unavailable = availability[0].FridayUnavailable.Value;
                                }
                                break;
                            case DayOfWeek.Saturday: if (availability[0].SaturdayStart.HasValue)
                                {
                                    availabilityStart = availability[0].SaturdayStart.Value;
                                    availabilityEnd = availability[0].SaturdayEnd.Value;
                                }
                                else if (availability[0].SaturdayUnavailable.HasValue)
                                {
                                    unavailable = availability[0].SaturdayUnavailable.Value;
                                }
                                break;
                        }
                    #endregion
                        //If availability data exists
                        if (availabilityStart != selectedDateTime)
                        {
                            availabilityStart = Convert.ToDateTime(selectedDateTime.ToShortDateString() + " " + availabilityStart.ToShortTimeString());
                            availabilityEnd = Convert.ToDateTime(selectedDateTime.ToShortDateString() + " " + availabilityEnd.ToShortTimeString());

                            //If opponents availability conflicts currently selected date and time then show error
                            if (selectedDateTime < availabilityStart || selectedDateTime >= availabilityEnd)
                            {
                                StringBuilder stringBuilder = new StringBuilder();
                                stringBuilder.Append("radalert('The start time for the match is in conflict with your opponents availability. Please pick another time.')");
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "radalert", "(function(){var f = function(){" + stringBuilder.ToString() + ";Sys.Application.remove_load(f);};Sys.Application.add_load(f);})()", true);
                                timeValid = false;
                            }
                        }
                        //If your opponent is unavailable for the whole day.
                        else if (unavailable)
                        {
                            StringBuilder stringBuilder = new StringBuilder();
                            stringBuilder.Append("radalert('The start time for the match is in conflict with your opponents availability. Please pick another time.')");
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "radalert", "(function(){var f = function(){" + stringBuilder.ToString() + ";Sys.Application.remove_load(f);};Sys.Application.add_load(f);})()", true);
                            timeValid = false;
                        }
                    }
                    if (timeValid)
                    {
                        //Find appointments for both user and opponents that conflict with the time selected
                        List<SelectAppointmentsByUserIdDateResult> appointments = dataContext.SelectAppointmentsByUserIdDate(StoredData.User.UserId, opponentId, selectedDateTime).ToList();
                        //Remove the currently selected appointment from the list, so that we check for conflicts against other appointments
                        appointments.RemoveAll(p => p.MatchId == matchId);
                        if (appointments.Count > 0)
                        {
                            StringBuilder stringBuilder = new StringBuilder();
                            if (appointments[0].UserId == StoredData.User.UserId)
                                stringBuilder.Append("radconfirm('You may have a conflict with one or more events in your schedule.<br>Do you want to continue?',confirmCallBackFn)");
                            else
                                stringBuilder.Append("radconfirm('You may have a conflict with one or more events in your opponents schedule.<br>Do you want to continue?',confirmCallBackFn)");

                            ScriptManager.RegisterStartupScript(this, this.GetType(), "radalert", "(function(){var f = function(){" + stringBuilder.ToString() + ";Sys.Application.remove_load(f);};Sys.Application.add_load(f);})()", true);
                            timeValid = false;
                        }
                    }

                    if (timeValid)
                        UpdateMatch();
                    else
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "EnableButton", "changeButtonState('false');", true);

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
                errorLabel.Text = string.Empty;
            }
            catch
            {
                isValidated = false;
                errorLabel.Text = "Please enter appropriate Date/Time values";
            }

            if (StoredData.User.AccessExpired.Value || StoredData.User.TempDivision.Value)
                isValidated = false;

            if (isValidated)
                ScriptManager.RegisterStartupScript(this, this.GetType(), "DisableButton", "changeButtonState('true');", true);

            return isValidated;
        }

        protected void RadAjaxManager1_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
        {
            if (e.Argument == "true")
            {
                if (!StoredData.User.AccessExpired.Value && !StoredData.User.TempDivision.Value)
                    UpdateMatch();
            }
        }

        private void UpdateMatch()
        {
            bool success = false;
            int opponentId = Convert.ToInt32(ViewState["opponentId"]);
            int appointmentId = Convert.ToInt32(Request.QueryString["AppointmentId"]);
            int matchId = Convert.ToInt32(ViewState["matchId"]);
            DateTime selectedDateTime = Convert.ToDateTime(RadDatePicker1.SelectedDate.Value.ToShortDateString() + " " + RadTimePicker1.SelectedDate.Value.ToShortTimeString());
            using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
            {
                using (TransactionScope transactionScope = new TransactionScope())
                {
                    dataContext.UpdateAppointmentByMatchId(selectedDateTime, selectedDateTime.AddHours(3), string.Empty, null, matchId);
                    dataContext.UpdateMatch(matchId, selectedDateTime, Convert.ToInt32(locationDropDownList.SelectedValue), 1, string.Empty);
                    transactionScope.Complete();
                    success = true;
                }
                if (success)
                {
                    submitButton.Enabled = false;
                    List<SelectUserPublicProfileResult> opponents = dataContext.SelectUserPublicProfile(opponentId).ToList();
                    StringBuilder message = new StringBuilder();
                    message.Append("The folowing tennis match schedule has been updated by your opponent\r\n\r\n");
                    message.Append(string.Format("Players: {0} vs {1}\r\n", StoredData.User.FirstName + " " + StoredData.User.LastName, opponents[0].FirstName + " " + opponents[0].LastName));
                    message.Append(string.Format("New Start Time: {0} @ {1}\r\n", selectedDateTime.ToShortDateString(), selectedDateTime.ToShortTimeString()));
                    message.Append(string.Format("Your opponent's Phone Number: {0}\r\n", StoredData.User.Phone));
                    message.Append(string.Format("Your opponent's Email Id: {0}\r\n\r\n", StoredData.User.EmailId));

                    if (!SendEmail(opponents[0].EmailId, message, "Match schedule change request"))
                    {
                        StringBuilder stringBuilder = new StringBuilder();
                        stringBuilder.Append("radalert('The system was unable to send an email to your opponent about this match update.<br>Please contact you opponent about this match.',250,150,'Match Cancelled!!')");
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "radalert", "(function(){var f = function(){" + stringBuilder.ToString() + ";Sys.Application.remove_load(f);};Sys.Application.add_load(f);})()", true);
                    }

                    string closingScript = "<script type='text/javascript'>Sys.Application.add_load(function () {closeRadWindowAndShowAlert();}); </script> ";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "radalert", closingScript, false);

                }
            }
        }

        private bool SendEmail(string toEmailAddress, StringBuilder message, string subject)
        {
            bool emailSent = false;
            try
            {
                MailMessage mailMessage = new MailMessage();

                mailMessage.From = new MailAddress("support@FlexibleTennisLeague.com");
                mailMessage.To.Add(toEmailAddress);
                mailMessage.CC.Add(StoredData.User.EmailId);
                mailMessage.ReplyTo = new MailAddress(StoredData.User.EmailId, StoredData.User.FirstName + " " + StoredData.User.LastName);
                mailMessage.Bcc.Add(WebConfigurationManager.AppSettings["EmailId"].ToString());
                mailMessage.Subject = subject;

                message.Append("\r\n\r\nPlease email your questions and complaints/suggestions to admin@flexibletennisleague.com.\r\n\r\n");
                message.Append("Thank you for choosing FlexibleTennisLeague.\r\n");
                message.Append("Administrator -- FlexibleTennisLeague.");

                mailMessage.Body = Server.HtmlEncode(message.ToString());

                SmtpClient smtpClient = new SmtpClient();
                smtpClient.Send(mailMessage);
                emailSent = true;
            }
            catch (Exception exception)
            {
                emailSent = false;
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    int? id = null;
                    dataContext.InsertEmailError(StoredData.User.UserId, toEmailAddress, StoredData.User.EmailId, subject, message.ToString(), exception.Message + "\r\n\r\n" + exception.StackTrace, ref id);
                }
            }
            return emailSent;
        }
    }
}
