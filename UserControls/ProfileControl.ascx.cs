using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.Linq;
using System.Text;
using System.Net.Mail;
using DLL;

namespace FlexibleTennisLeague.UserControls
{
    public partial class ProfileControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
                Response.Redirect(WebConfigurationManager.AppSettings["LoginPageURL"].ToString());

            ChangePassword1.SuccessPageUrl = WebConfigurationManager.AppSettings["SuccessPageURL"].ToString();
            photoRadWindow1.NavigateUrl = WebConfigurationManager.AppSettings["PhotoUploadNavigateURL"].ToString();

            //if (!Page.IsPostBack)
            //{
            //    upcomingLeagueButton.Attributes.Add("onclick", "this.style.display='none';");
            //}

            using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
            {
                if (!Page.IsPostBack)
                {
                    List<TennisCourt> tennisCourts = dataContext.SelectTennisCourtsByLeague(Convert.ToInt32(WebConfigurationManager.AppSettings["LeagueCityId"])).ToList();
                    homeCourtDropDownList.Items.Add(string.Empty);
                    foreach (TennisCourt tennisCourt in tennisCourts)
                    {
                        homeCourtDropDownList.Items.Add(new ListItem(tennisCourt.CourtName, tennisCourt.CourtId.ToString()));
                    }
                    int userNextDivision = 0;

                    ISingleResult<SelectUserByEmailIdResult> users = dataContext.SelectUserByEmailId(HttpContext.Current.User.Identity.Name);
                    foreach (SelectUserByEmailIdResult user in users)
                    {
                        firstNameTextBox.Text = user.FirstName;
                        lastNameTextBox.Text = user.LastName;
                        zipTextBox.Text = user.Zip;
                        phoneTextBox.Text = user.Phone;
                        homeCourtDropDownList.SelectedValue = user.HomeCourt.ToString();
                        nTRPDropDownList.Text = user.NTRPRanking.ToString();
                        ageGroupDropDownList.SelectedValue = user.AgeGroup;
                        racquetHandDropDownList.SelectedValue = user.RacquetHand;
                        favoriteShotDropDownList.SelectedValue = user.FavoriteShot;
                        racquetTextBox.Text = user.Racquet;
                        facebookTextBox.Text = user.Facebook;
                        linkedInTextBox.Text = user.LinkedIn;
                        mySpaceTextBox.Text = user.MySpace;
                        orkutTextBox.Text = user.Orkut;
                        if (user.ProfileImageName.HasValue)
                            profileImage.ImageUrl = string.Format("~/ProfileImages/{0}.jpg", user.ProfileImageName.ToString());
                        if (user.NextDivision.HasValue)
                            userNextDivision = user.NextDivision.Value;
                        if (user.EmailPost.HasValue)
                            postEmailCheckBox.Checked = user.EmailPost.Value;
                        playTypeDropDownList.SelectedValue = user.Interest;
                    }

                    //List<SelectDivisionByLeagueIdResult> selectDivisionByLeagueIdResult = dataContext.SelectDivisionByLeagueId(Convert.ToInt32(WebConfigurationManager.AppSettings["LeagueCityId"])).ToList();
                    //SelectDivisionByLeagueIdResult nextDivision = selectDivisionByLeagueIdResult.Find(p => p.DivisionId == selectDivisionByLeagueIdResult.Max(q => q.DivisionId));
                    List<SelectDivisionResult> selectDivisionResult = dataContext.SelectDivision(StoredData.User.NextDivision).ToList();
                    if (StoredData.User.Division != StoredData.User.NextDivision)
                    {
                        ViewState["NextDivision"] = StoredData.User.NextDivision;
                        ViewState["NextDivisionText"] = selectDivisionResult[0].Division;
                        upcomingLeagueLabel.Text = string.Format("{0} {1} - {2}", selectDivisionResult[0].Division, selectDivisionResult[0].StartDate.ToShortDateString(), selectDivisionResult[0].EndDate.ToShortDateString());
                        upcomingLeagueButton.Visible = true;
                    }
                    else
                        upcomingLeagueLabel.Text = string.Format("You are currently subscribed to the {0} {1} - {2}", selectDivisionResult[0].Division, selectDivisionResult[0].StartDate.ToShortDateString(), selectDivisionResult[0].EndDate.ToShortDateString());
                }

                List<SelectProfileImageByEmailIdResult> selectProfileImageByEmailIdResult = dataContext.SelectProfileImageByEmailId(HttpContext.Current.User.Identity.Name).ToList();
                if (selectProfileImageByEmailIdResult.Count > 0)
                    profileImage.ImageUrl = string.Format("~/ProfileImages/{0}.jpg", selectProfileImageByEmailIdResult[0].ProfileImageName.ToString());
            }
        }

        protected void basicProfileSaveButton_Click(object sender, EventArgs e)
        {
            using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
            {
                dataContext.UpdateBasicUserInfoByEmailId(HttpContext.Current.User.Identity.Name, zipTextBox.Text, firstNameTextBox.Text, lastNameTextBox.Text, phoneTextBox.Text, Convert.ToInt32(homeCourtDropDownList.SelectedValue), Convert.ToDouble(nTRPDropDownList.Text));
                HttpContext.Current.Items["User"] = null;
            }
        }

        protected void tennisProfileSaveButton_Click(object sender, EventArgs e)
        {
            using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
            {
                dataContext.UpdateTennisUserInfoByEmailId(HttpContext.Current.User.Identity.Name, ageGroupDropDownList.SelectedValue, racquetHandDropDownList.SelectedValue, favoriteShotDropDownList.SelectedValue, racquetTextBox.Text, facebookTextBox.Text, linkedInTextBox.Text, mySpaceTextBox.Text, orkutTextBox.Text, playTypeDropDownList.Text);
                HttpContext.Current.Items["User"] = null;
            }
        }

        protected void ChangePassword1_SendingMail(object sender, MailMessageEventArgs e)
        {
            e.Message.Body = e.Message.Body.Replace("<% UserName %>", ChangePassword1.UserName);
            if (!string.IsNullOrEmpty(WebConfigurationManager.AppSettings["SuccessPageURL"].ToString()))
                e.Message.Body = e.Message.Body.Replace("<% URL %>", string.Format("http://flexibletennisleague.com{0}", WebConfigurationManager.AppSettings["SuccessPageURL"].ToString().Remove(0, 1)));
            else
                e.Message.Body = e.Message.Body.Replace("<% URL %>", "http://flexibletennisleague.com/LoginPage.aspx");
            Session.Abandon();
            FormsAuthentication.SignOut();
        }

        protected void upcomingLeagueButton_Click(object sender, EventArgs e)
        {
            using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
            {
                upcomingLeagueButton.Enabled = false;
                dataContext.UpdateNextDivision(HttpContext.Current.User.Identity.Name, Convert.ToInt32(ViewState["NextDivision"]));
                HttpContext.Current.Items["User"] = null;
                string radalertscript = "<script language='javascript'>function f(){radalert('Thank you for signing up.<br>Your account will be updated within 12 hours.', 330, 210,'Thank you!!'); Sys.Application.remove_load(f);}; Sys.Application.add_load(f);</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "radalert", radalertscript);
                SendEmail();
            }
        }

        private void SendEmail()
        {
            StringBuilder stringBuilder = new StringBuilder();
            string subject = "Welcome to FlexibleTennisLeague";
            try
            {
                MailMessage mailMessage = new MailMessage();

                mailMessage.From = new MailAddress("admin@FlexibleTennisLeague.com");
                mailMessage.To.Add(HttpContext.Current.User.Identity.Name);
                mailMessage.Bcc.Add(WebConfigurationManager.AppSettings["EmailId"].ToString());
                mailMessage.Subject = subject;

                stringBuilder.Append(string.Format("Dear {0} {1},\r\n\r\n", StoredData.User.FirstName, StoredData.User.LastName));
                stringBuilder.Append(string.Format("Thank you for joining the {0} season of the FlexibleTennisLeague.\r\n", ViewState["NextDivisionText"].ToString()));
                stringBuilder.Append("Once we complete setting up your account, we will send you an email informing you of your account status. This process is usually completed within 12 hours.\r\n");
                stringBuilder.Append("FlexibleTennisLeague takes its customer satisfaction very seriously. If you have any questions, comments or suggestions please email us at: admin@flexibletennisleague.com or customersupport@flexibletennisleague.com.\r\n\r\n");
                stringBuilder.Append("In order to ensure the timely delivery of emails regarding your tennis matches or scores please add admin@FlexibleTennisLeague.com to your list of known senders.\r\n\r\n");
                stringBuilder.Append("Thank you for signing up with FlexibleTennisLeague\r\n");
                stringBuilder.Append("Administrator -- FlexibleTennisLeague.");


                mailMessage.Body = Server.HtmlEncode(stringBuilder.ToString());

                SmtpClient smtpClient = new SmtpClient();
                smtpClient.Send(mailMessage);
            }
            catch (Exception exception)
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    int? id = null;
                    dataContext.InsertEmailError(StoredData.User.UserId, HttpContext.Current.User.Identity.Name, HttpContext.Current.User.Identity.Name, subject, stringBuilder.ToString(), exception.Message + "\r\n\r\n" + exception.StackTrace, ref id);
                }
            }
        }

        protected void communicationButton_Click(object sender, EventArgs e)
        {
            using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
            {
                dataContext.UpdateCommunicationPreferences(StoredData.User.EmailId, postEmailCheckBox.Checked);
            }
        }
    }
}