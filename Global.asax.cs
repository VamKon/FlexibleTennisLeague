using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Net.Mail;
using DLL;

namespace FlexibleTennisLeague
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            // Code that runs when a new session is started
            HttpContext context = HttpContext.Current;
            HttpRequest request = context.Request;

            if (request.Url.AbsoluteUri.StartsWith("http://flexibletennisleague.com"))
            {
                Response.StatusCode = 301;
                Response.Redirect(request.Url.AbsoluteUri.Replace("http://flexibletennisleague.com", "http://www.flexibletennisleague.com"), true);
            }
        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {
            if (Server.GetLastError() != null)
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
                if (HttpContext.Current.Request.UrlReferrer != null)
                    err += string.Format("\r\nRequest URI : {0}", HttpContext.Current.Request.UrlReferrer.AbsoluteUri);

                mailMessage.Body = string.Format("{0}\r\n\r\n{1}", err, DateTime.Now);

                //Server.ClearError();

                SmtpClient smtpClient = new SmtpClient();
                smtpClient.Send(mailMessage);
                ////Response.Redirect("~/Error.aspx");
            }
        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {
            StoredData.CleanUp();
        }
    }
}