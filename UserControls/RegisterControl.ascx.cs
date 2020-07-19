using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Transactions;
using System.Data.Linq;
using System.Net.Mail;
using System.Text;
using System.Web.Configuration;
using DLL;
using Telerik.Web.UI;
namespace FlexibleTennisLeague.UserControls
{
    public partial class RegisterControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DropDownList homeCourtDropDownList = (DropDownList)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("homeCourtDropDownList");
            DropDownList leagueCityDropDownList = (DropDownList)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("leagueCityDropDownList");
            RadCaptcha radCaptcha = (RadCaptcha)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("radCaptcha");
            RadAjaxManager radAjaxManage = RadAjaxManager.GetCurrent(Page);
            radAjaxManage.AjaxSettings.AddAjaxSetting(leagueCityDropDownList, homeCourtDropDownList);
            radAjaxManage.AjaxSettings.AddAjaxSetting(leagueCityDropDownList, radCaptcha);
            if (!Page.IsPostBack)
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    List<SelectUniqueTennisCourtCitiesResult> selectUniqueTennisCourtCitiesResults = dataContext.SelectUniqueTennisCourtCities(Convert.ToInt32(WebConfigurationManager.AppSettings["LeagueCityId"])).ToList();
                    foreach (SelectUniqueTennisCourtCitiesResult result in selectUniqueTennisCourtCitiesResults)
                    {
                        leagueCityDropDownList.Items.Add(new ListItem(result.City, result.City));
                    }
                    leagueCityDropDownList.Items[0].Selected = true;
                    homeCourtDropDownList.Items.Add(string.Empty);
                    List<TennisCourt> tennisCourts = dataContext.SelectTennisCourtByCity(selectUniqueTennisCourtCitiesResults[0].City, Convert.ToInt32(WebConfigurationManager.AppSettings["LeagueCityId"])).ToList();
                    foreach (TennisCourt tennisCourt in tennisCourts)
                    {
                        homeCourtDropDownList.Items.Add(new ListItem(tennisCourt.CourtName, tennisCourt.CourtId.ToString()));
                    }
                }
            }
        }

        protected void CreateUserWizard1_CreatingUser(object sender, LoginCancelEventArgs e)
        {
            if (((CheckBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("agreeCheckBox")).Checked)
                CreateUserWizard1.Email = CreateUserWizard1.UserName;
            else
            {
                e.Cancel = true;
                Label error = (Label)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("errorLabel");
                error.Text = "Please agree to our terms and conditions.";
                error.Visible = true;
            }

        }

        protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
        {
            MembershipUser membershipUser = Membership.GetUser(CreateUserWizard1.UserName);
            //Add user to role
            Roles.AddUserToRole(CreateUserWizard1.UserName, "User");

            //Add user to the user table
            Guid aspnetIDGuid = new Guid(membershipUser.ProviderUserKey.ToString());

            TextBox zipTextBox = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("zipTextBox");
            TextBox firstNameTextBox = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("firstNameTextBox");
            TextBox lastNameTextBox = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("lastNameTextBox");
            TextBox phoneTextBox = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("phoneTextBox");
            DropDownList homeCourtDropDownList = (DropDownList)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("homeCourtDropDownList");
            DropDownList nTRPDropDownList = (DropDownList)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("nTRPDropDownList");
            DropDownList leagueCityDropDownList = (DropDownList)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("leagueCityDropDownList");
            TextBox referrerEmailTextBox = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("referrerEmailTextBox");

            int? userId = 0;
            int? performanceId = 0;
            int? divisionId = 0;
            using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
            {
                ISingleResult<SelectLowestDivisionResult> results = dataContext.SelectLowestDivision(Convert.ToInt32(WebConfigurationManager.AppSettings["LeagueCityId"]));
                foreach (SelectLowestDivisionResult result in results)
                {
                    divisionId = result.DivisionId;
                }
                using (TransactionScope transactionScope = new TransactionScope())
                {
                    dataContext.InsertUser(aspnetIDGuid, divisionId.Value, CreateUserWizard1.UserName, zipTextBox.Text, firstNameTextBox.Text, lastNameTextBox.Text, phoneTextBox.Text, Convert.ToInt32(homeCourtDropDownList.Text), Convert.ToDouble(nTRPDropDownList.Text), null, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, null, DateTime.Now, true, false, referrerEmailTextBox.Text, ref userId);
                    dataContext.InsertPerformance(userId.Value, divisionId.Value, ref performanceId);

                    transactionScope.Complete();
                }
            }
        }

        protected void CompleteWizardStep1_Activate(object sender, EventArgs e)
        {
            SendEmail();
            Response.Redirect(WebConfigurationManager.AppSettings["NewLeagueRegisterURL"].ToString());
        }

        private void SendEmail()
        {
            StringBuilder stringBuilder = new StringBuilder();
            string subject = "Welcome to FlexibleTennisLeague";
            try
            {
                MailMessage mailMessage = new MailMessage();

                mailMessage.From = new MailAddress("admin@FlexibleTennisLeague.com");
                mailMessage.To.Add(CreateUserWizard1.UserName);
                mailMessage.Bcc.Add(WebConfigurationManager.AppSettings["EmailId"].ToString());
                mailMessage.Subject = subject;

                TextBox firstNameTextBox = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("firstNameTextBox");
                TextBox lastNameTextBox = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("lastNameTextBox");

                stringBuilder.Append(string.Format("Dear {0} {1},\r\n\r\n", firstNameTextBox.Text, lastNameTextBox.Text));
                stringBuilder.Append("Thank you for joining the FlexibleTennisLeague. Discover how easy it is to play competitive tennis at your convenience.\r\n");
                stringBuilder.Append("While we set up your account please use your login information below to browse through the site and familiarize yourself with the league's rules.\r\n\r\n");
                stringBuilder.Append(string.Format("User Name: {0}\r\n", CreateUserWizard1.UserName));
                stringBuilder.Append(string.Format("Password: {0}\r\n\r\n", CreateUserWizard1.Password));
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
                    dataContext.InsertEmailError(StoredData.User.UserId, CreateUserWizard1.UserName, CreateUserWizard1.UserName, subject, stringBuilder.ToString(), exception.Message + "\r\n\r\n" + exception.StackTrace, ref id);
                }
            }
        }

        protected void leagueCityDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
            {
                DropDownList homeCourtDropDownList = (DropDownList)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("homeCourtDropDownList");
                DropDownList leagueCityDropDownList = (DropDownList)sender;
                List<TennisCourt> tennisCourts = dataContext.SelectTennisCourtByCity(leagueCityDropDownList.SelectedItem.Text, Convert.ToInt32(WebConfigurationManager.AppSettings["LeagueCityId"])).ToList();
                homeCourtDropDownList.Items.Clear();
                homeCourtDropDownList.Items.Add(string.Empty);
                foreach (TennisCourt tennisCourt in tennisCourts)
                {
                    homeCourtDropDownList.Items.Add(new ListItem(tennisCourt.CourtName, tennisCourt.CourtId.ToString()));
                }
            }
        }
    }
}