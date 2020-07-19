using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;

namespace FlexibleTennisLeague
{
    public partial class Error : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Server.GetLastError() != null)
            {
                try
                {
                    MailMessage mailMessage = new MailMessage();

                    mailMessage.From = new MailAddress("support@flexibletennisleague.com");
                    mailMessage.To.Add(new MailAddress("admin@flexibletennisleague.com"));
                    mailMessage.Subject = "FlexibleTennisLeague - Error";
                    Exception objErr = Server.GetLastError().GetBaseException();
                    string err = "Error Caught in Application_Error event\n" +
                            "Error in: " + Request.Url.ToString() +
                            "\nError Message:" + objErr.Message.ToString() +
                            "\nStack Trace:" + objErr.StackTrace.ToString();

                    mailMessage.Body = string.Format("{0}\r\n\r\n{1}", err, DateTime.Now);

                    Server.ClearError();

                    SmtpClient smtpClient = new SmtpClient();
                    smtpClient.Send(mailMessage);
                }
                catch { }
            }
        }
    }
}
