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
    public partial class JoinMailingList : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void mailingListButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    try
                    {
                        dataContext.InsertMailingList(mailingListEmailTextBox.Text, WebConfigurationManager.AppSettings["City"].ToString());
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