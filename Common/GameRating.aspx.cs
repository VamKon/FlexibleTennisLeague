using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Linq;
using System.Transactions;
using System.Text;
using DLL;

namespace FlexibleTennisLeague.Common
{
    public partial class GameRating : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsAuthenticated)
            {
                int opponentId = Convert.ToInt32(Request.QueryString["opponentId"]);
                int matchId = Convert.ToInt32(Request.QueryString["matchId"]);
                matchIdHiddenField.Value = matchId.ToString();
                opponentIdHiddenField.Value = opponentId.ToString();

                if (!Page.IsPostBack)
                {
                    using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                    {
                        ISingleResult<SelectUserPublicProfileResult> users = dataContext.SelectUserPublicProfile(opponentId);
                        SelectUserPublicProfileResult user = users.First();

                        ISingleResult<SelectMatchResult> matches = dataContext.SelectMatch(matchId);
                        SelectMatchResult match = matches.First();

                        ISingleResult<SelectMatchPointLogsByMatchIdResult> matchResults = dataContext.SelectMatchPointLogsByMatchId(matchId);
                        SelectMatchPointLogsByMatchIdResult matchResult = matchResults.First();

                        string winner = string.Empty;
                        if (matchResult.UserId == StoredData.User.UserId)
                        {
                            if (matchResult.Win)
                                winner = StoredData.User.FirstName + " " + StoredData.User.LastName;
                            else
                                winner = user.FirstName + " " + user.LastName;
                        }
                        else
                        {
                            if (matchResult.Win)
                                winner = user.FirstName + " " + user.LastName;
                            else
                                winner = StoredData.User.FirstName + " " + StoredData.User.LastName;
                        }

                        matchLabel.Text = string.Format("{0} vs {1} on {2} {3}. Winner: {4} ({5})", StoredData.User.FirstName + " " + StoredData.User.LastName, user.FirstName + " " + user.LastName, match.MatchDate.ToShortDateString(), match.MatchDate.ToShortTimeString(), winner, match.Score);

                        ISingleResult<SelectMatchPointLogsByMatchIdUserIdResult> ratings = dataContext.SelectMatchPointLogsByMatchIdUserId(matchId, StoredData.User.UserId);
                        SelectMatchPointLogsByMatchIdUserIdResult rating = ratings.First();

                        ownBackhandRadSlider.Value = rating.OwnBackhand.Value;
                        ownCourtCoverageRadSlider.Value = rating.OwnCourtCoverage.Value;
                        ownDropRadSlider.Value = rating.OwnDrop.Value;
                        ownForehandRadSlider.Value = rating.OwnForehand.Value;
                        ownOverheadRadSlider.Value = rating.OwnOverhead.Value;
                        ownServeRadSlider.Value = rating.OwnServe.Value;
                        ownVolleyRadSlider.Value = rating.OwnVolley.Value;
                        opponentBackhandRadSlider.Value = rating.OpponentBackhand.Value;
                        opponentCourtCoverageRadSlider.Value = rating.OpponentCourtCoverage.Value;
                        opponentDropRadSlider.Value = rating.OpponentDrop.Value;
                        opponentForehandRadSlider.Value = rating.OpponentForehand.Value;
                        opponentOverheadRadSlider.Value = rating.OpponentOverhead.Value;
                        opponentServeRadSlider.Value = rating.OpponentServe.Value;
                        opponentVolleyRadSlider.Value = rating.OpponentVolley.Value;
                    }

                }
            }
        }

        protected void submitButton_Click(object sender, EventArgs e)
        {
            if (!StoredData.User.AccessExpired.Value && !StoredData.User.TempDivision.Value)
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    dataContext.UpdateMatchPointRankingLogByMatchIdUserId(Convert.ToInt32(matchIdHiddenField.Value), StoredData.User.UserId, ownServeRadSlider.Value, ownForehandRadSlider.Value, ownBackhandRadSlider.Value, ownVolleyRadSlider.Value, ownDropRadSlider.Value, ownOverheadRadSlider.Value, ownCourtCoverageRadSlider.Value, opponentServeRadSlider.Value, opponentForehandRadSlider.Value, opponentBackhandRadSlider.Value, opponentVolleyRadSlider.Value, opponentDropRadSlider.Value, opponentOverheadRadSlider.Value, opponentCourtCoverageRadSlider.Value);
                    string closingScript = "<script type='text/javascript'>Sys.Application.add_load(function () {closeRadWindowAndShowAlert('Match rating successfully recorded.');}); </script> ";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "radalert", closingScript, false);
                }
            }
        }

        protected string GetLocalTime(DateTime utcTime)
        {
            return utcTime.ToLocalTime().ToShortTimeString();
        }

        protected string GetLocalDate(DateTime utcTime)
        {
            return utcTime.ToLocalTime().ToShortDateString();
        }


    }
}
