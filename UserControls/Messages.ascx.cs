using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using DLL;

namespace FlexibleTennisLeague.UserControls
{
    public partial class Messages : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
                Response.Redirect(WebConfigurationManager.AppSettings["LoginPageURL"].ToString());
            if (StoredData.User.TempDivision.Value || StoredData.User.AccessExpired.Value)
                postMessageButton.Enabled = false;

            messageTextBox.Attributes.Add("onclick", "clearText();");
            
        }

        protected void postMessageButton_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(messageTextBox.Text) && messageTextBox.Text != "Eg: Is anyone available for tennis match at 5PM on Friday?")
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    dataContext.InsertMessage(StoredData.User.UserId, StoredData.User.Division, messageTextBox.Text);
                }
                messagesRadGrid.Rebind();
            }
        }

        protected void messagesRadGrid_NeedDataSource(object source, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            if (!StoredData.User.TempDivision.Value && !StoredData.User.AccessExpired.Value)
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    List<SelectMessageResult> messages = dataContext.SelectMessage(StoredData.User.Division).ToList();
                    messagesRadGrid.DataSource = messages;
                }
            }
        }

        protected void messagesRadGrid_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.Item.ItemType == Telerik.Web.UI.GridItemType.Item || e.Item.ItemType == Telerik.Web.UI.GridItemType.AlternatingItem)
            {
                if (e.CommandName == "ShowPublicProfile")
                {
                    Response.Redirect(WebConfigurationManager.AppSettings["PublicProfilePath"].ToString() + "?UserId=" + e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["AspNetUserId"].ToString());
                }
                else if (e.CommandName == "ShowMessage")
                {
                    Response.Redirect(string.Format("MessageDetail.aspx?MessageId={0}",e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["MessageId"].ToString()));
                }
            }
        }

       
    }
}