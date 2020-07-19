using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Transactions;
using System.Text;
using System.Net.Mail;
using DLL;
using Telerik.Web.UI;

namespace FlexibleTennisLeague.UserControls
{
    public partial class CalendarControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
                Response.Redirect(WebConfigurationManager.AppSettings["LoginPageURL"].ToString());

            RadAjaxManager.GetCurrent(Page).AjaxRequest += new RadAjaxControl.AjaxRequestDelegate(Schedule_AjaxRequest);
            RadScheduler1.CustomAttributeNames = new string[] { "UserId" };

            if (!StoredData.User.TempDivision.Value && !StoredData.User.AccessExpired.Value)
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    if (!Page.IsPostBack)
                    {
                        List<SelectDivisionResult> selectDivisionResult = dataContext.SelectDivision(StoredData.User.Division.Value).ToList();
                        foreach (SelectDivisionResult result in selectDivisionResult)
                        {
                            if (result.StartDate > DateTime.Now)
                            {
                                warningImage.Visible = true;
                                warningLinkButton.Visible = true;
                                warningLinkButton.Text = "Although you may play practice matches with members in your league. You will not be able to record scores until the league start date of " + result.StartDate.ToShortDateString();
                            }
                            else
                            {
                                List<LeaguePerformance> leaguePerformance = dataContext.SelectLeaguePerformanceByDivision(StoredData.User.Division).ToList();
                                leaguePerformance.Remove(leaguePerformance.Find(p => p.UserId == StoredData.User.UserId));
                                playersRadGrid.DataSource = leaguePerformance;
                            }
                        }

                    }
                    //If a player has been selected from the players grid - get appointments fro both players
                    //else just get appointment for current user.
                    List<DLL.Appointment> appointments = new List<DLL.Appointment>();
                    bool opponentAvailabilitySet = false;
                    if (playersRadGrid.SelectedItems.Count > 0)
                    {
                        int opponentId = Convert.ToInt32(playersRadGrid.SelectedItems[0].OwnerTableView.DataKeyValues[playersRadGrid.SelectedItems[0].ItemIndex]["UserId"]);
                        appointments = GetAppointments(StoredData.User.UserId, opponentId, out opponentAvailabilitySet);
                    }
                    else
                    {
                        appointments = GetAppointments(StoredData.User.UserId, -1, out opponentAvailabilitySet);
                    }
                    RadScheduler1.DataSource = appointments;
                }
            }
            else
            {
                RadScheduler1.Enabled = false;
                playersRadGrid.Enabled = false;
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
        }

        protected void Schedule_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            List<DLL.Appointment> appointments = new List<DLL.Appointment>();
            if (e.Argument == "RefreshScheduler")
            {
                bool opponentAvailabilitySet = false;
                if (playersRadGrid.SelectedItems.Count > 0)
                {
                    int opponentId = Convert.ToInt32(playersRadGrid.SelectedItems[0].OwnerTableView.DataKeyValues[playersRadGrid.SelectedItems[0].ItemIndex]["UserId"]);
                    appointments = GetAppointments(StoredData.User.UserId, opponentId, out opponentAvailabilitySet);
                }
                else
                {
                    appointments = GetAppointments(StoredData.User.UserId, -1, out opponentAvailabilitySet);
                }
            }
            else if (e.Argument == "DeleteSchedule")
            {
                if (ViewState["DeletedAppointment"] != null)
                {
                    Telerik.Web.UI.Appointment deletedAppointment = (Telerik.Web.UI.Appointment)ViewState["DeletedAppointment"];
                    using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                    {
                        //Find match by the deleted appointment id
                        List<SelectMatchByAppointmentIdResult> selectMatchByAppointmentIdResult = dataContext.SelectMatchByAppointmentId(Convert.ToInt32(deletedAppointment.ID)).ToList();
                        int? matchId = null;
                        //If there are matches by the appointment id
                        if (selectMatchByAppointmentIdResult.Count > 0)
                        {
                            int opponentId = 0;
                            matchId = selectMatchByAppointmentIdResult[0].MatchId;
                            if (selectMatchByAppointmentIdResult[0].User1 == StoredData.User.UserId)
                                opponentId = selectMatchByAppointmentIdResult[0].User2.Value;
                            else
                                opponentId = selectMatchByAppointmentIdResult[0].User1.Value;

                            //If a score has already been submitted for the match, then don't delete it. Else delete it.
                            List<SelectMatchPointLogsByMatchIdResult> selectMatchPointLogsByMatchIdResult = dataContext.SelectMatchPointLogsByMatchId(Convert.ToInt32(matchId)).ToList();
                            if (selectMatchPointLogsByMatchIdResult.Count > 0)
                            {
                                RadAjaxManager.GetCurrent(Page).ResponseScripts.Add(@"radalert('A score has been submitted for this match.<br>This match cannot be deleted.',250,150,'Unable To Delete');");
                            }
                            else
                            {
                                dataContext.DeleteAppointmentsByMatchId(matchId);

                                //Send email
                                List<SelectUserPublicProfileResult> opponents = dataContext.SelectUserPublicProfile(opponentId).ToList();
                                StringBuilder message = new StringBuilder();
                                message.Append("Your opponent has requested the following match to be cancelled\r\n\r\n");
                                message.Append(string.Format("Players: {0} vs {1}\r\n", StoredData.User.FirstName + " " + StoredData.User.LastName, opponents[0].FirstName + " " + opponents[0].LastName));
                                message.Append(string.Format("Date & Time: {0} @ {1}\r\n", deletedAppointment.Start.ToShortDateString(), deletedAppointment.Start.ToShortTimeString()));
                                message.Append(string.Format("Your opponent's Phone Number: {0}\r\n", StoredData.User.Phone));
                                message.Append(string.Format("Your opponent's Email Id: {0}\r\n\r\n", StoredData.User.EmailId));
                                message.Append("Please respond to this request as soon as you can");

                                if (!SendEmail(opponents[0].EmailId, message, "Tennis Match cancellation request"))
                                    RadAjaxManager.GetCurrent(Page).ResponseScripts.Add(@"radalert('System was unable to send an email to your opponent about this change<br>Please contact your opponent regarding this update.',250,150,'Error!!');");
                                else
                                    RadAjaxManager.GetCurrent(Page).ResponseScripts.Add(@"radalert('Although an email has been sent requesting the cancellation of this match, please contact your opponent to confirm.',250,150,'Match Cancelled!!');");
                            }
                        }

                    }
                }
            }
            else
            {
                string[] arguments = e.Argument.Split('|');
                int gridRowId = Convert.ToInt32(arguments[0]);
                GridDataItem gridDataItem = playersRadGrid.Items[gridRowId];
                int opponentId = Convert.ToInt32(gridDataItem.OwnerTableView.DataKeyValues[gridRowId]["UserId"]);
                bool opponentAvailabilitySet = false;
                appointments = GetAppointments(StoredData.User.UserId, opponentId,out opponentAvailabilitySet);

                if (!opponentAvailabilitySet)
                {
                    RadAjaxManager.GetCurrent(Page).ResponseScripts.Add(@"radalert('The selected player has not set his/her availability.',250,150,'Availability Not Set!!');");
                }
            }

            RadScheduler1.DataSource = appointments;
            RadScheduler1.Rebind();
        }

        protected void RadScheduler1_AppointmentDataBound(object sender, SchedulerEventArgs e)
        {
            if (e.Appointment.DataItem != null)
            {
                if ((e.Appointment.DataItem as DLL.Appointment).UserId != StoredData.User.UserId)
                {
                    e.Appointment.BackColor = System.Drawing.Color.Pink;
                    e.Appointment.ForeColor = System.Drawing.Color.Black;
                }
                else
                {
                    e.Appointment.BackColor = System.Drawing.Color.DarkSeaGreen;
                    e.Appointment.ForeColor = System.Drawing.Color.White;
                }
            }
        }

        protected void playersRadGrid_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item.ItemType == Telerik.Web.UI.GridItemType.Item || e.Item.ItemType == Telerik.Web.UI.GridItemType.AlternatingItem)
            {
                int userId = Convert.ToInt32(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["UserId"]);
                LinkButton matchRequestButton = (LinkButton)e.Item.FindControl("matchRequestButton");
                matchRequestButton.Attributes.Add("onClick", string.Format("openRadWindow('{0}'); return false;", userId));
            }
        }

        protected void RadScheduler1_AppointmentDelete(object sender, SchedulerCancelEventArgs e)
        {
            if (Convert.ToInt32(e.Appointment.Attributes["UserId"]) == StoredData.User.UserId && string.IsNullOrEmpty(e.Appointment.RecurrenceRule))
            {
                ViewState["DeletedAppointment"] = e.Appointment;
                RadAjaxManager.GetCurrent(Page).ResponseScripts.Add(@"radconfirm('If you are trying to delete this match within 5 hours of the scheduled time, your opponent can claim a walkover. Which can result in 2 penalty points against you.<br><br>Do you want to continue?',confirmCallBackDelete);");
            }
            else
            {
                e.Cancel = true;
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
                message.Append("Administrator -- FlexibleTennisLeague.\r\n\r\n");

                mailMessage.Body = Server.HtmlEncode(message.ToString());

                SmtpClient smtpClient = new SmtpClient();
                //smtpClient.Send(mailMessage);
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

        private List<DLL.Appointment> CombineAppointmentsWithAvailability(List<SelectAvailabilitiesByUserIdResult> availability, List<DLL.Appointment> appointments, int userId)
        {
            //Find the next days of week
            #region Days of week
            DateTime sunday = DateTime.Now;
            DateTime monday = DateTime.Now;
            DateTime tuesday = DateTime.Now;
            DateTime wednesday = DateTime.Now;
            DateTime thursday = DateTime.Now;
            DateTime friday = DateTime.Now;
            DateTime saturday = DateTime.Now;

            switch (DateTime.Now.DayOfWeek)
            {
                case DayOfWeek.Sunday: monday = DateTime.Now.AddDays(1);
                    tuesday = DateTime.Now.AddDays(2);
                    wednesday = DateTime.Now.AddDays(3);
                    thursday = DateTime.Now.AddDays(4);
                    friday = DateTime.Now.AddDays(5);
                    saturday = DateTime.Now.AddDays(6);
                    break;
                case DayOfWeek.Monday: tuesday = DateTime.Now.AddDays(1);
                    wednesday = DateTime.Now.AddDays(2);
                    thursday = DateTime.Now.AddDays(3);
                    friday = DateTime.Now.AddDays(4);
                    saturday = DateTime.Now.AddDays(5);
                    sunday = DateTime.Now.AddDays(6);
                    break;
                case DayOfWeek.Tuesday: wednesday = DateTime.Now.AddDays(1);
                    thursday = DateTime.Now.AddDays(2);
                    friday = DateTime.Now.AddDays(3);
                    saturday = DateTime.Now.AddDays(4);
                    sunday = DateTime.Now.AddDays(5);
                    monday = DateTime.Now.AddDays(6);
                    break;
                case DayOfWeek.Wednesday: thursday = DateTime.Now.AddDays(1);
                    friday = DateTime.Now.AddDays(2);
                    saturday = DateTime.Now.AddDays(3);
                    sunday = DateTime.Now.AddDays(4);
                    monday = DateTime.Now.AddDays(5);
                    tuesday = DateTime.Now.AddDays(6);
                    break;
                case DayOfWeek.Thursday: friday = DateTime.Now.AddDays(1);
                    saturday = DateTime.Now.AddDays(2);
                    sunday = DateTime.Now.AddDays(3);
                    monday = DateTime.Now.AddDays(4);
                    tuesday = DateTime.Now.AddDays(5);
                    wednesday = DateTime.Now.AddDays(6);
                    break;
                case DayOfWeek.Friday: saturday = DateTime.Now.AddDays(1);
                    sunday = DateTime.Now.AddDays(2);
                    monday = DateTime.Now.AddDays(3);
                    tuesday = DateTime.Now.AddDays(4);
                    wednesday = DateTime.Now.AddDays(5);
                    thursday = DateTime.Now.AddDays(6);
                    break;
                case DayOfWeek.Saturday: sunday = DateTime.Now.AddDays(1);
                    monday = DateTime.Now.AddDays(2);
                    tuesday = DateTime.Now.AddDays(3);
                    wednesday = DateTime.Now.AddDays(4);
                    thursday = DateTime.Now.AddDays(5);
                    friday = DateTime.Now.AddDays(6);
                    break;
            }
            #endregion

            List<DLL.Appointment> sundayAvailability = TransformAvailabilityToAppointment(availability[0].SundayStart, availability[0].SundayEnd, availability[0].SundayUnavailable.Value, sunday, "SU", userId);
            foreach (DLL.Appointment appointment in sundayAvailability)
            {
                appointments.Add(appointment);
            }

            List<DLL.Appointment> mondayAvailability = TransformAvailabilityToAppointment(availability[0].MondayStart, availability[0].MondayEnd, availability[0].MondayUnavailable.Value, monday, "MO", userId);
            foreach (DLL.Appointment appointment in mondayAvailability)
            {
                appointments.Add(appointment);
            }

            List<DLL.Appointment> tuesdayAvailability = TransformAvailabilityToAppointment(availability[0].TuesdayStart, availability[0].TuesdayEnd, availability[0].TuesdayUnavailable.Value, tuesday, "TU", userId);
            foreach (DLL.Appointment appointment in tuesdayAvailability)
            {
                appointments.Add(appointment);
            }

            List<DLL.Appointment> wednesdayAvailability = TransformAvailabilityToAppointment(availability[0].WednesdayStart, availability[0].WednesdayEnd, availability[0].WednesdayUnavailable.Value, wednesday, "WE", userId);
            foreach (DLL.Appointment appointment in wednesdayAvailability)
            {
                appointments.Add(appointment);
            }

            List<DLL.Appointment> thursdayAvailability = TransformAvailabilityToAppointment(availability[0].ThursdayStart, availability[0].ThursdayEnd, availability[0].ThursdayUnavailable.Value, thursday, "TH", userId);
            foreach (DLL.Appointment appointment in thursdayAvailability)
            {
                appointments.Add(appointment);
            }

            List<DLL.Appointment> fridayAvailability = TransformAvailabilityToAppointment(availability[0].FridayStart, availability[0].FridayEnd, availability[0].FridayUnavailable.Value, friday, "FR", userId);
            foreach (DLL.Appointment appointment in fridayAvailability)
            {
                appointments.Add(appointment);
            }

            List<DLL.Appointment> saturdayAvailability = TransformAvailabilityToAppointment(availability[0].SaturdayStart, availability[0].SaturdayEnd, availability[0].SaturdayUnavailable.Value, saturday, "SA", userId);
            foreach (DLL.Appointment appointment in saturdayAvailability)
            {
                appointments.Add(appointment);
            }

            return appointments;
        }

        private List<DLL.Appointment> TransformAvailabilityToAppointment(DateTime? availabilityStart, DateTime? availabilityEnd, bool unavailable, DateTime dayOfWeek, string dayOfWeekAbbr, int userId)
        {
            List<DLL.Appointment> appointments = new List<DLL.Appointment>();

            DLL.Appointment appointment = new DLL.Appointment();
            DLL.Appointment appointment2 = new DLL.Appointment();

            appointment.Subject = "Unavailable";
            appointment.UserId = userId;
            if (unavailable)
            {
                appointment.Start = Convert.ToDateTime(dayOfWeek.ToShortDateString() + " 12:00:00 AM");
                appointment.End = Convert.ToDateTime(dayOfWeek.ToShortDateString() + " 11:59:59 PM");
                string dtstart = dayOfWeek.ToString("yyyyMMdd") + "T" + "000000";
                string dtend = dayOfWeek.ToString("yyyyMMdd") + "T" + "235959";
                appointment.RecurrenceRule = string.Format("DTSTART:{0}Z\r\nDTEND:{1}Z\r\nRRULE:FREQ=WEEKLY;INTERVAL=1;BYDAY={2}", dtstart, dtend, dayOfWeekAbbr);

                appointments.Add(appointment);
            }
            else
            {
                appointment.Start = Convert.ToDateTime(dayOfWeek.ToShortDateString() + " 12:00:00 AM");
                appointment.End = Convert.ToDateTime(dayOfWeek.ToShortDateString() + " " + availabilityStart.Value.ToShortTimeString()); ;
                string dtstart = dayOfWeek.ToString("yyyyMMdd") + "T" + "000000";
                string dtend = dayOfWeek.ToString("yyyyMMdd") + "T" + availabilityStart.Value.ToString("HHmmss");
                appointment.RecurrenceRule = string.Format("DTSTART:{0}Z\r\nDTEND:{1}Z\r\nRRULE:FREQ=WEEKLY;INTERVAL=1;BYDAY={2}", dtstart, dtend, dayOfWeekAbbr);

                appointment2.Start = Convert.ToDateTime(dayOfWeek.ToShortDateString() + " " + availabilityEnd.Value.ToShortTimeString());
                appointment2.End = Convert.ToDateTime(dayOfWeek.ToShortDateString() + " 11:59:59 PM");
                string dtstart2 = dayOfWeek.ToString("yyyyMMdd") + "T" + availabilityEnd.Value.ToString("HHmmss");
                string dtend2 = dayOfWeek.ToString("yyyyMMdd") + "T" + "235959";
                appointment2.RecurrenceRule = string.Format("DTSTART:{0}Z\r\nDTEND:{1}Z\r\nRRULE:FREQ=WEEKLY;INTERVAL=1;BYDAY={2}", dtstart2, dtend2, dayOfWeekAbbr);
                appointment2.Subject = "Unavailable";
                appointment2.UserId = userId;

                appointments.Add(appointment);
                appointments.Add(appointment2);
            }

            return appointments;
        }

        private bool OpponentAvailable(int opponentId, DateTime selectedDateTime)
        {
            bool isTimeValid = true;
            using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
            {
                //Get opponents availability
                List<SelectAvailabilitiesByUserIdResult> availability = dataContext.SelectAvailabilitiesByUserId(opponentId).ToList();

                if (availability.Count > 0)
                {
                    //Find day of week for currently selected date and get opponents availability for that date.
                    DateTime availabilityStart = selectedDateTime;
                    DateTime availabilityEnd = selectedDateTime;
                    switch (selectedDateTime.DayOfWeek)
                    {
                        case DayOfWeek.Sunday: if (availability[0].SundayStart.HasValue)
                            {
                                availabilityStart = availability[0].SundayStart.Value;
                                availabilityEnd = availability[0].SundayEnd.Value;
                            }
                            else if (availability[0].SundayUnavailable.Value)
                                isTimeValid = false;
                            break;
                        case DayOfWeek.Monday: if (availability[0].MondayStart.HasValue)
                            {
                                availabilityStart = availability[0].MondayStart.Value;
                                availabilityEnd = availability[0].MondayEnd.Value;
                            }
                            else if (availability[0].MondayUnavailable.Value)
                                isTimeValid = false;
                            break;
                        case DayOfWeek.Tuesday: if (availability[0].TuesdayStart.HasValue)
                            {
                                availabilityStart = availability[0].TuesdayStart.Value;
                                availabilityEnd = availability[0].TuesdayEnd.Value;
                            }
                            else if (availability[0].TuesdayUnavailable.Value)
                                isTimeValid = false;
                            break;
                        case DayOfWeek.Wednesday: if (availability[0].WednesdayStart.HasValue)
                            {
                                availabilityStart = availability[0].WednesdayStart.Value;
                                availabilityEnd = availability[0].WednesdayEnd.Value;
                            }
                            else if (availability[0].WednesdayUnavailable.Value)
                                isTimeValid = false;
                            break;
                        case DayOfWeek.Thursday: if (availability[0].ThursdayStart.HasValue)
                            {
                                availabilityStart = availability[0].ThursdayStart.Value;
                                availabilityEnd = availability[0].ThursdayEnd.Value;
                            }
                            else if (availability[0].ThursdayUnavailable.Value)
                                isTimeValid = false;
                            break;
                        case DayOfWeek.Friday: if (availability[0].FridayStart.HasValue)
                            {
                                availabilityStart = availability[0].FridayStart.Value;
                                availabilityEnd = availability[0].FridayEnd.Value;
                            }
                            else if (availability[0].FridayUnavailable.Value)
                                isTimeValid = false;
                            break;
                        case DayOfWeek.Saturday: if (availability[0].SaturdayStart.HasValue)
                            {
                                availabilityStart = availability[0].SaturdayStart.Value;
                                availabilityEnd = availability[0].SaturdayEnd.Value;
                            }
                            else if (availability[0].SaturdayUnavailable.Value)
                                isTimeValid = false;
                            break;
                    }

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
                            isTimeValid = false;
                        }
                    }
                    else if (!isTimeValid)
                    {
                        StringBuilder stringBuilder = new StringBuilder();
                        stringBuilder.Append("radalert('The start time for the match is in conflict with your opponents availability. Please pick another time.')");
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "radalert1", "(function(){var f = function(){" + stringBuilder.ToString() + ";Sys.Application.remove_load(f);};Sys.Application.add_load(f);})()", true);
                    }
                }
            }
            return isTimeValid;
        }

        private List<DLL.Appointment> GetAppointments(int userId, int opponentId, out bool opponentAvailabilitySet)
        {
            List<DLL.Appointment> appointments = new List<DLL.Appointment>();
            opponentAvailabilitySet = false;
            using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
            {
                appointments = dataContext.SelectAppointmentsByUserIdOpponentId(StoredData.User.UserId, opponentId).ToList();
                //Get availability for current user
                List<SelectAvailabilitiesByUserIdResult> availability = dataContext.SelectAvailabilitiesByUserId(StoredData.User.UserId).ToList();
                if (availability.Count > 0)
                    appointments = CombineAppointmentsWithAvailability(availability, appointments, StoredData.User.UserId);

                //Get availability for opponent
                List<SelectAvailabilitiesByUserIdResult> opponentAvailability = dataContext.SelectAvailabilitiesByUserId(opponentId).ToList();
                if (opponentAvailability.Count > 0)
                {
                    appointments = CombineAppointmentsWithAvailability(opponentAvailability, appointments, opponentId);
                    opponentAvailabilitySet = true;
                }
            }
            return appointments;
        }
    }
}