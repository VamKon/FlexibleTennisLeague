using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DLL;

namespace FlexibleTennisLeague.UserControls
{
    public partial class EditPost : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int messageId = 0;
            int replyId = 0;
            if (Request.QueryString["MessageId"] != null)
                messageId = Convert.ToInt32(Request.QueryString["MessageId"]);
            else if (Request.QueryString["ReplyId"] != null)
                replyId = Convert.ToInt32(Request.QueryString["ReplyId"]);

            if (!Page.IsPostBack)
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    if (messageId > 0)
                    {
                        List<SelectMessageByIdResult> result = dataContext.SelectMessageById(messageId).ToList();
                        messageTextBox.Text = result[0].Message;
                        if (result[0].UserId != StoredData.User.UserId)
                            Response.Redirect("/Messages.aspx");
                    }
                    else if (replyId > 0)
                    {
                        List<SelectReplyByIdResult> selectReplies = dataContext.SelectReplyById(replyId).ToList();
                        messageTextBox.Text = selectReplies[0].Body;
                        if (selectReplies[0].UserId != StoredData.User.UserId)
                            Response.Redirect("/Messages.aspx");
                    }
                }
            }
        }

        protected void postMessageButton_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(messageTextBox.Text))
            {
                int? messageId = 0;
                int replyId = 0;
                if (Request.QueryString["MessageId"] != null)
                    messageId = Convert.ToInt32(Request.QueryString["MessageId"]);
                else if (Request.QueryString["ReplyId"] != null)
                    replyId = Convert.ToInt32(Request.QueryString["ReplyId"]);

                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    if (messageId > 0)
                    {
                        dataContext.UpdateMessage(messageId, messageTextBox.Text);
                        Response.Redirect(string.Format("MessageDetail.aspx?MessageId={0}", messageId));
                    }
                    else if (replyId > 0)
                    {
                        dataContext.UpdateReply(replyId, messageTextBox.Text, ref messageId);
                        Response.Redirect(string.Format("MessageDetail.aspx?MessageId={0}", messageId.Value));
                    }
                }
            }
        }
    }
}