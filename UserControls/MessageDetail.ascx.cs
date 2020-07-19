using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Text;
using System.Web.Configuration;
using DLL;

namespace FlexibleTennisLeague.UserControls
{
    public partial class MessageDetail : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int messageId = Convert.ToInt32(Request.QueryString["MessageId"]);
            if (!Page.IsPostBack)
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    List<SelectMessageByIdResult> result = dataContext.SelectMessageById(messageId).ToList();
                    if (result[0].DivisionId != StoredData.User.Division)
                        Response.Redirect(WebConfigurationManager.AppSettings["MessagePath"]);

                    messageSourceRepeater.DataSource = result;
                    messageSourceRepeater.DataBind();

                    if (result[0].EmailPost.Value)
                        ViewState["PostOwnerEmail"] = result[0].EmailId;
                    if (result[0].Message.Length < 27)
                        ViewState["Subject"] = result[0].Message;
                    else
                        ViewState["Subject"] = result[0].Message.Substring(0, 25) + "..";

                    List<SelectRepliesResult> selectReplies = dataContext.SelectReplies(messageId).ToList();
                    messageRepeater.DataSource = selectReplies;
                    messageRepeater.DataBind();
                }
            }
        }

        protected void postMessageButton_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(messageTextBox.Text))
            {
                int messageId = Convert.ToInt32(Request.QueryString["MessageId"]);
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    dataContext.InsertMessageReply(messageId, StoredData.User.UserId, messageTextBox.Text);

                    List<SelectRepliesResult> selectReplies = dataContext.SelectReplies(messageId).ToList();
                    messageRepeater.DataSource = selectReplies;
                    messageRepeater.DataBind();

                    List<string> emailIds = new List<string>();
                    if (ViewState["PostOwnerEmail"] != null)
                        emailIds.Add(ViewState["PostOwnerEmail"].ToString());
                    foreach (SelectRepliesResult result in selectReplies)
                    {
                        if (result.EmailPost.Value && !emailIds.Contains(result.EmailId))
                            emailIds.Add(result.EmailId);
                    }

                    StringBuilder sb = new StringBuilder();
                    string subject = string.Empty;
                    if (ViewState["Subject"] != null)
                    {
                        sb.Append(string.Format("Following item was posted by {0} {1} as a reply to {2}", StoredData.User.FirstName, StoredData.User.LastName, ViewState["Subject"].ToString()));
                        subject = "(FlexTennis)" + ViewState["Subject"].ToString();
                    }
                    else
                    {
                        sb.Append("A recent post you have participated in has been updated.");
                        subject = "(FlexTennis) Your post has been updated";
                    }
                    sb.Append("\r\n\r\n-------------------------------------------------\r\n");
                    sb.Append(messageTextBox.Text);

                    messageTextBox.Text = string.Empty;

                    SendEmail(emailIds, sb, subject, StoredData.User.EmailId, StoredData.User.FirstName + " " + StoredData.User.LastName);
                }
            }
        }

        protected void messageSourceRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item)
            {
                if (((SelectMessageByIdResult)e.Item.DataItem).UserId == StoredData.User.UserId)
                {
                    HyperLink hyperlink = (HyperLink)e.Item.FindControl("editHyperLink");
                    hyperlink.Visible = true;
                    hyperlink.NavigateUrl = WebConfigurationManager.AppSettings["EditMessagePath"] + "?MessageId=" + ((SelectMessageByIdResult)e.Item.DataItem).MessageId;
                }
                HyperLink userSourceHyperlink = (HyperLink)e.Item.FindControl("userSourceHyperlink");
                userSourceHyperlink.NavigateUrl = WebConfigurationManager.AppSettings["PublicProfilePath"] + "?UserId=" + ((SelectMessageByIdResult)e.Item.DataItem).AspNetUserId;
            }
        }

        protected void messageRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (((SelectRepliesResult)e.Item.DataItem).UserId == StoredData.User.UserId)
                {
                    HyperLink hyperlink = (HyperLink)e.Item.FindControl("editHyperLink");
                    hyperlink.Visible = true;
                    hyperlink.NavigateUrl = WebConfigurationManager.AppSettings["EditMessagePath"] + "?ReplyId=" + ((SelectRepliesResult)e.Item.DataItem).ReplyId;
                }
                HyperLink userHyperLink = (HyperLink)e.Item.FindControl("userHyperLink");
                userHyperLink.NavigateUrl = WebConfigurationManager.AppSettings["PublicProfilePath"] + "?UserId=" + ((SelectRepliesResult)e.Item.DataItem).AspNetUserId;
            }
        }


        private bool SendEmail(List<string> emailIds, StringBuilder message, string subject, string replyToEmail, string senderName)
        {
            bool emailSent = false;
            try
            {
                MailMessage mailMessage = new MailMessage();

                mailMessage.From = new MailAddress("support@FlexibleTennisLeague.com");
                string toEmailAddresses = string.Empty;
                for (int count = 0; count < emailIds.Count; count++)
                {
                    toEmailAddresses += emailIds[count] + ",";
                }
                toEmailAddresses.TrimEnd(',');
                mailMessage.To.Add(toEmailAddresses);
                mailMessage.ReplyTo = new MailAddress(replyToEmail, senderName);
                mailMessage.Bcc.Add("admin@flexibletennisleague.com");
                mailMessage.Subject = subject;

                message.Append("\r\n\r\nYou are receiving this message because you have either started a new post or replied to a post in FlexibleTennisLeague.com. You can unsubscribe from future notification by selecting not to receive further updates in your profile page.");
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
            }
            return emailSent;
        }
    }
}