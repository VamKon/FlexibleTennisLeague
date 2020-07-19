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

namespace FlexibleTennisLeague.UserControls
{
    public partial class ContactFormControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    List<SelectLeagueAllResult> selectLeagueAllResults = dataContext.SelectLeagueAll().ToList();
                    cityDropDownList.Items.Add(new ListItem(string.Empty, string.Empty));
                    foreach (SelectLeagueAllResult result in selectLeagueAllResults)
                    {
                        cityDropDownList.Items.Add(new ListItem(result.LeagueCity + ", " + result.LeagueState, result.LeagueId.ToString()));
                    }
                }
            }
        }

        protected void cityDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
            {
                if (!string.IsNullOrEmpty(cityDropDownList.SelectedItem.Value))
                {
                    leagueDropDownList.Items.Clear();
                    List<SelectDivisionByLeagueIdResult> results = dataContext.SelectDivisionByLeagueId(Convert.ToInt32(cityDropDownList.SelectedItem.Value)).ToList();
                    foreach (SelectDivisionByLeagueIdResult result in results)
                    {
                        leagueDropDownList.Items.Add(new ListItem(result.Division, result.DivisionId.ToString()));
                    }
                }
            }
        }

        protected void submitButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {

                try
                {
                    MailMessage mailMessage = new MailMessage();

                    mailMessage.From = new MailAddress("admin@FlexibleTennisLeague.com");
                    mailMessage.To.Add(WebConfigurationManager.AppSettings["EmailId"].ToString());
                    mailMessage.Subject = "User Comment";

                    StringBuilder stringBuilder = new StringBuilder();
                    stringBuilder.Append(string.Format("The following comment was submitted on: {0} at {1}\r\n\r\n", DateTime.Now.ToShortDateString(), DateTime.Now.ToShortTimeString()));
                    stringBuilder.Append(string.Format("First Name: {0}\r\n", firstNameTextBox.Text));
                    stringBuilder.Append(string.Format("Last Name: {0}\r\n", lastNameTextBox.Text));
                    stringBuilder.Append(string.Format("Email: {0}\r\n", emailTextBox.Text));
                    stringBuilder.Append(string.Format("City: {0}\r\n", cityDropDownList.Text));
                    stringBuilder.Append(string.Format("League: {0}\r\n", leagueDropDownList.Text));
                    stringBuilder.Append(string.Format("Comments: {0}\r\n", commentsTextBox.Text));

                    mailMessage.Body = Server.HtmlEncode(stringBuilder.ToString());

                    SmtpClient smtpClient = new SmtpClient();
                    smtpClient.Send(mailMessage);
                    statusLabel.Text = "Thank you for contacting us. We will get in touch with you as soon as possible.";
                }
                catch (SmtpException)
                {
                    statusLabel.Text = "Email could not be sent. Please try again";
                }

            }
        }

        protected void mailingListButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    try
                    {
                        dataContext.InsertMailingList(mailingListEmailTextBox.Text, cityTextBox.Text);
                        mailingListStatusLabel.Text = "We have received your email address. Thank you.";
                    }
                    catch
                    {
                    }
                }
            }
        }
    }
}