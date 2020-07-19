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
    public partial class FeaturedPlayerControls : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    List<SelectFeaturedPlayerResult> results = dataContext.SelectFeaturedPlayer(Convert.ToInt32(WebConfigurationManager.AppSettings["LeagueCityId"])).ToList();
                    foreach (SelectFeaturedPlayerResult result in results)
                    {
                        if(result.ProfileImageName.HasValue)
                            playerImage.ImageUrl = "~/ProfileImages/" + result.ProfileImageName.ToString() + ".jpg";
                        else
                            playerImage.ImageUrl = "~/Resources/Images/NoProfile.gif";

                        locationLabel.Text = result.LeagueCity + ", " + result.LeagueState;
                        ntrpLabel.Text = result.NTRPRanking.ToString();
                        seasonLabel.Text = result.Win + "W - " + result.Loss + "L";
                        seasonPoints.Text = result.TotalPoints.ToString();
                        favortiteLabel.Text = result.FavoriteShot;
                        nameLabel.Text = result.FirstName + " " + result.LastName;
                    }
                    if(results.Count ==0)
                        playerImage.ImageUrl = "~/Resources/Images/NoProfile.gif";
                }
            }
        }
    }
}