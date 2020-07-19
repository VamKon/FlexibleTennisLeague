using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;

namespace FlexibleTennisLeague.UserControls
{
    public partial class RecoverPasswordControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PasswordRecovery1.SuccessPageUrl = WebConfigurationManager.AppSettings["PasswordRecoverySuccessURL"] == null ? "~/LoginPage.aspx" : WebConfigurationManager.AppSettings["PasswordRecoverySuccessURL"].ToString();
        }

        protected void PasswordRecovery1_SendingMail(object sender, MailMessageEventArgs e)
        {
            e.Message.Body = e.Message.Body.Replace("<% UserName %>", PasswordRecovery1.UserName);
            string url = WebConfigurationManager.AppSettings["PasswordRecoverySuccessURL"] == null ? "~/LoginPage.aspx" : WebConfigurationManager.AppSettings["PasswordRecoverySuccessURL"].ToString();
            e.Message.Body = e.Message.Body.Replace("<% URL %>", string.Format("http://flexibletennisleague.com/{0}", url.Remove(0, 1)));
        }
    }
}