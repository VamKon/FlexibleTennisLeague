using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using DLL;

namespace FlexibleTennisLeague.UserControls
{
    public partial class LoginForm : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    List<SelectLeagueFromEmailIdResult> results = dataContext.SelectLeagueFromEmailId(HttpContext.Current.User.Identity.Name).ToList();
                    foreach (SelectLeagueFromEmailIdResult result in results)
                    {
                        Response.Redirect(string.Format("~/{0}/Users/Messages.aspx", result.LeagueCity.Replace(" ", string.Empty)));
                    }
                }
            }
            LinkButton forgotPasswordLinkButton = (LinkButton)Login1.FindControl("forgotPasswordLinkButton");
            forgotPasswordLinkButton.PostBackUrl = WebConfigurationManager.AppSettings["PasswordRecoveryURL"] == null ? "~/RecoverPassword.aspx" : WebConfigurationManager.AppSettings["PasswordRecoveryURL"].ToString();
        }

        protected void Login1_LoggedIn(object sender, EventArgs e)
        {
            using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
            {
                List<SelectLeagueFromEmailIdResult> results = dataContext.SelectLeagueFromEmailId(Login1.UserName).ToList();
                foreach (SelectLeagueFromEmailIdResult result in results)
                {
                    Response.Redirect(string.Format("~/{0}/LoginPage.aspx", result.LeagueCity.Replace(" ", string.Empty)));
                }
            }
        }
    }
}