using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Charting;
using DLL;


namespace FlexibleTennisLeague.UserControls
{
    public partial class PerformanceControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
                Response.Redirect(WebConfigurationManager.AppSettings["LoginPageURL"].ToString());

            if (!Page.IsPostBack)
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    List<Performance> performances = dataContext.SelectPerformanceByUserId(StoredData.User.UserId).ToList();

                    Performance seasonPerformance = performances.Find(p => p.DivisionId == StoredData.User.Division);
                    seasonWinsLabel.Text = string.Format("{0}W - {1}L", seasonPerformance.Win, seasonPerformance.Loss);
                    seasonPointsLabel.Text = seasonPerformance.TotalPoints.ToString();

                    overallWinsLabel.Text = string.Format("{0}W - {1}L", performances.Sum(p => p.Win), performances.Sum(p => p.Loss));
                    overallPointsLabel.Text = performances.Sum(p => p.TotalPoints).ToString();

                    ISingleResult<SelectDivisionResult> divisions = dataContext.SelectDivision(StoredData.User.Division);
                    SelectDivisionResult division = divisions.First();

                    List<SelectRatingsByUserIdStartEndDateResult> ratings = dataContext.SelectRatingsByUserIdStartEndDate(StoredData.User.UserId, division.StartDate, division.EndDate).ToList();

                    List<SelectRatingsByUserIdStartEndDateResult> validOwnRatings = ratings.FindAll(p => p.OwnForehand.HasValue);
                    if (validOwnRatings.Count > 0)
                    {
                        DrawRateOwnPerformanceChart(validOwnRatings);
                        DrawRateOwnDetailPerformanceChart(validOwnRatings);
                    }

                    List<SelectOpponentRatingsByUserIdStartEndDateResult> opponentRatings = dataContext.SelectOpponentRatingsByUserIdStartEndDate(StoredData.User.UserId, division.StartDate, division.EndDate).ToList();
                    List<SelectOpponentRatingsByUserIdStartEndDateResult> validOpponentRatings = opponentRatings.FindAll(p => p.OpponentForehand.HasValue);
                    if (validOpponentRatings.Count > 0)
                    {
                        DrawRateOthersPerformanceChart(validOpponentRatings);
                        DrawRateOpponentServeChart(validOpponentRatings);
                    }
                }
            }
        }

        private void DrawRateOwnPerformanceChart(List<SelectRatingsByUserIdStartEndDateResult> validRatings)
        {
            int ownServe = Convert.ToInt32(validRatings.Sum(p => p.OwnServe));
            double ownServeAvg = 0;

            int ownForehand = Convert.ToInt32(validRatings.Sum(p => p.OwnForehand));
            double ownForehandAvg = 0;

            int ownBackhand = Convert.ToInt32(validRatings.Sum(p => p.OwnBackhand));
            double ownBackhandAvg = 0;

            int ownVolley = Convert.ToInt32(validRatings.Sum(p => p.OwnVolley));
            double ownVolleyAvg = 0;

            int ownDrop = Convert.ToInt32(validRatings.Sum(p => p.OwnDrop));
            double ownDropAvg = 0;

            int ownOverhead = Convert.ToInt32(validRatings.Sum(p => p.OwnOverhead));
            double ownOverheadAvg = 0;

            int ownCourtCoverage = Convert.ToInt32(validRatings.Sum(p => p.OwnCourtCoverage));
            double ownCourtCoverateAvg = 0;

            if (validRatings.Count > 0)
            {
                ownServeAvg = ownServe / validRatings.Count;
                ownForehandAvg = ownForehand / validRatings.Count;
                ownBackhandAvg = ownBackhand / validRatings.Count;
                ownVolleyAvg = ownVolley / validRatings.Count;
                ownDropAvg = ownDrop / validRatings.Count;
                ownOverheadAvg = ownOverhead / validRatings.Count;
                ownCourtCoverateAvg = ownCourtCoverage / validRatings.Count;
            }

            ownPerformanceRadChart.Series[0].AddItem(ownServeAvg);
            ownPerformanceRadChart.Series[0].AddItem(ownForehandAvg);
            ownPerformanceRadChart.Series[0].AddItem(ownBackhandAvg);
            ownPerformanceRadChart.Series[0].AddItem(ownVolleyAvg);
            ownPerformanceRadChart.Series[0].AddItem(ownDropAvg);
            ownPerformanceRadChart.Series[0].AddItem(ownOverheadAvg);
            ownPerformanceRadChart.Series[0].AddItem(ownCourtCoverateAvg);

            ownPerformanceRadChart.PlotArea.XAxis.AutoScale = false;
            ownPerformanceRadChart.PlotArea.XAxis.AddRange(1, 7, 1);
            ownPerformanceRadChart.PlotArea.XAxis[0].TextBlock.Text = "Serve";
            ownPerformanceRadChart.PlotArea.XAxis[1].TextBlock.Text = "F'Hand";
            ownPerformanceRadChart.PlotArea.XAxis[2].TextBlock.Text = "B'Hand";
            ownPerformanceRadChart.PlotArea.XAxis[3].TextBlock.Text = "Volley";
            ownPerformanceRadChart.PlotArea.XAxis[4].TextBlock.Text = "Drop";
            ownPerformanceRadChart.PlotArea.XAxis[5].TextBlock.Text = "O'Head";
            ownPerformanceRadChart.PlotArea.XAxis[6].TextBlock.Text = "Cover";

            ownPerformanceRadChart.PlotArea.YAxis.AutoScale = false;
            ownPerformanceRadChart.PlotArea.YAxis.AddRange(0, 5, 1);
            ownPerformanceRadChart.PlotArea.YAxis[0].TextBlock.Text = "N.A";
            ownPerformanceRadChart.PlotArea.YAxis[1].TextBlock.Text = "V.Bad";
            ownPerformanceRadChart.PlotArea.YAxis[2].TextBlock.Text = "Bad";
            ownPerformanceRadChart.PlotArea.YAxis[3].TextBlock.Text = "Average";
            ownPerformanceRadChart.PlotArea.YAxis[4].TextBlock.Text = "Good";
            ownPerformanceRadChart.PlotArea.YAxis[5].TextBlock.Text = "V.Good";

        }

        private void DrawRateOthersPerformanceChart(List<SelectOpponentRatingsByUserIdStartEndDateResult> validRatings)
        {
            int othersServe = Convert.ToInt32(validRatings.Sum(p => p.OpponentServe));
            double othersServeAvg = 0;

            int othersForehand = Convert.ToInt32(validRatings.Sum(p => p.OpponentForehand));
            double othersForehandAvg = 0;

            int othersBackhand = Convert.ToInt32(validRatings.Sum(p => p.OpponentBackhand));
            double othersBackhandAvg = 0;

            int othersVolley = Convert.ToInt32(validRatings.Sum(p => p.OpponentVolley));
            double othersVolleyAvg = 0;

            int othersDrop = Convert.ToInt32(validRatings.Sum(p => p.OpponentDrop));
            double othersDropAvg = 0;

            int othersOverhead = Convert.ToInt32(validRatings.Sum(p => p.OpponentOverhead));
            double othersOverheadAvg = 0;

            int othersCourtCoverage = Convert.ToInt32(validRatings.Sum(p => p.OpponentCourtCoverage));
            double othersCourtCoverateAvg = 0;

            int sumValidServe = 0;
            int sumValidForehand = 0;
            int sumValidBackhand = 0;
            int sumValidVolley = 0;
            int sumValidDrop = 0;
            int sumValidOverhead = 0;
            int sumValidCourtCoverage = 0;

            foreach (SelectOpponentRatingsByUserIdStartEndDateResult result in validRatings)
            {
                if (result.OpponentServe.Value > 0)
                    sumValidServe++;
                if (result.OpponentForehand.Value > 0)
                    sumValidForehand++;
                if (result.OpponentBackhand.Value > 0)
                    sumValidBackhand++;
                if (result.OpponentVolley.Value > 0)
                    sumValidVolley++;
                if (result.OpponentDrop.Value > 0)
                    sumValidDrop++;
                if (result.OpponentOverhead.Value > 0)
                    sumValidOverhead++;
                if (result.OpponentCourtCoverage.Value > 0)
                    sumValidCourtCoverage++;
            }

            if (sumValidServe > 0)
                othersServeAvg = othersServe / sumValidServe;
            if (sumValidForehand > 0)
                othersForehandAvg = othersForehand / sumValidForehand;
            if (sumValidBackhand > 0)
                othersBackhandAvg = othersBackhand / sumValidBackhand;
            if (sumValidVolley > 0)
                othersVolleyAvg = othersVolley / sumValidVolley;
            if (sumValidDrop > 0)
                othersDropAvg = othersDrop / sumValidDrop;
            if (sumValidOverhead > 0)
                othersOverheadAvg = othersOverhead / sumValidOverhead;
            if (sumValidCourtCoverage>0)
                othersCourtCoverateAvg = othersCourtCoverage / sumValidCourtCoverage;

            opponentPerformanceRadChart.Series[0].AddItem(othersServeAvg);
            opponentPerformanceRadChart.Series[0].AddItem(othersForehandAvg);
            opponentPerformanceRadChart.Series[0].AddItem(othersBackhandAvg);
            opponentPerformanceRadChart.Series[0].AddItem(othersVolleyAvg);
            opponentPerformanceRadChart.Series[0].AddItem(othersDropAvg);
            opponentPerformanceRadChart.Series[0].AddItem(othersOverheadAvg);
            opponentPerformanceRadChart.Series[0].AddItem(othersCourtCoverateAvg);

            opponentPerformanceRadChart.PlotArea.XAxis.AutoScale = false;
            opponentPerformanceRadChart.PlotArea.XAxis.AddRange(1, 7, 1);
            opponentPerformanceRadChart.PlotArea.XAxis[0].TextBlock.Text = "Serve";
            opponentPerformanceRadChart.PlotArea.XAxis[1].TextBlock.Text = "F'Hand";
            opponentPerformanceRadChart.PlotArea.XAxis[2].TextBlock.Text = "B'Hand";
            opponentPerformanceRadChart.PlotArea.XAxis[3].TextBlock.Text = "Volley";
            opponentPerformanceRadChart.PlotArea.XAxis[4].TextBlock.Text = "Drop";
            opponentPerformanceRadChart.PlotArea.XAxis[5].TextBlock.Text = "O'Head";
            opponentPerformanceRadChart.PlotArea.XAxis[6].TextBlock.Text = "Cover";

            opponentPerformanceRadChart.PlotArea.YAxis.AutoScale = false;
            opponentPerformanceRadChart.PlotArea.YAxis.AddRange(0, 5, 1);
            opponentPerformanceRadChart.PlotArea.YAxis[0].TextBlock.Text = "N.A";
            opponentPerformanceRadChart.PlotArea.YAxis[1].TextBlock.Text = "V.Bad";
            opponentPerformanceRadChart.PlotArea.YAxis[2].TextBlock.Text = "Bad";
            opponentPerformanceRadChart.PlotArea.YAxis[3].TextBlock.Text = "Average";
            opponentPerformanceRadChart.PlotArea.YAxis[4].TextBlock.Text = "Good";
            opponentPerformanceRadChart.PlotArea.YAxis[5].TextBlock.Text = "V.Good";

        }


        private void DrawRateOwnDetailPerformanceChart(List<SelectRatingsByUserIdStartEndDateResult> validRatings)
        {

            ownPerformanceDetailRadChart.PlotArea.XAxis.AutoScale = false;
            ownPerformanceDetailRadChart.PlotArea.XAxis.AddRange(1, validRatings.Count, 1);
            for (int counter = 0; counter < validRatings.Count; counter++)
            {
                string result = string.Empty;
                if (validRatings[counter].Win)
                    result = "W";
                else
                    result = "L";
                ownPerformanceDetailRadChart.PlotArea.XAxis[counter].TextBlock.Text = string.Format("{0}/{1}\r\n({2})", validRatings[counter].MatchDate.Month, validRatings[counter].MatchDate.Day, result);
                ownPerformanceDetailRadChart.Series[0].AddItem(validRatings[counter].OwnServe.Value);
                ownPerformanceDetailRadChart.Series[1].AddItem(validRatings[counter].OwnForehand.Value);
                ownPerformanceDetailRadChart.Series[2].AddItem(validRatings[counter].OwnBackhand.Value);
                ownPerformanceDetailRadChart.Series[3].AddItem(validRatings[counter].OwnVolley.Value);
                ownPerformanceDetailRadChart.Series[4].AddItem(validRatings[counter].OwnDrop.Value);
                ownPerformanceDetailRadChart.Series[5].AddItem(validRatings[counter].OwnOverhead.Value);
                ownPerformanceDetailRadChart.Series[6].AddItem(validRatings[counter].OwnCourtCoverage.Value);
            }

            ownPerformanceDetailRadChart.PlotArea.YAxis.AutoScale = false;
            ownPerformanceDetailRadChart.PlotArea.YAxis.AddRange(0, 5, 1);
            ownPerformanceDetailRadChart.PlotArea.YAxis[0].TextBlock.Text = "N.A";
            ownPerformanceDetailRadChart.PlotArea.YAxis[1].TextBlock.Text = "V.Bad";
            ownPerformanceDetailRadChart.PlotArea.YAxis[2].TextBlock.Text = "Bad";
            ownPerformanceDetailRadChart.PlotArea.YAxis[3].TextBlock.Text = "Average";
            ownPerformanceDetailRadChart.PlotArea.YAxis[4].TextBlock.Text = "Good";
            ownPerformanceDetailRadChart.PlotArea.YAxis[5].TextBlock.Text = "V.Good";

        }

        private void DrawRateOpponentServeChart(List<SelectOpponentRatingsByUserIdStartEndDateResult> validRatings)
        {

            validRatings.Sort((x, y) => DateTime.Compare(x.MatchDate, y.MatchDate));
            othersPerformanceDetailRadChart.PlotArea.XAxis.AutoScale = false;
            othersPerformanceDetailRadChart.PlotArea.XAxis.AddRange(1, validRatings.Count, 1);
            for (int counter = 0; counter < validRatings.Count; counter++)
            {
                string result = string.Empty;
                if (validRatings[counter].Win)
                    result = "L";
                else
                    result = "W";
                othersPerformanceDetailRadChart.PlotArea.XAxis[counter].TextBlock.Text = string.Format("{0}/{1}\r\n({2})", validRatings[counter].MatchDate.Month, validRatings[counter].MatchDate.Day, result);
                othersPerformanceDetailRadChart.Series[0].AddItem(validRatings[counter].OpponentServe.Value);
                othersPerformanceDetailRadChart.Series[1].AddItem(validRatings[counter].OpponentForehand.Value);
                othersPerformanceDetailRadChart.Series[2].AddItem(validRatings[counter].OpponentBackhand.Value);
                othersPerformanceDetailRadChart.Series[3].AddItem(validRatings[counter].OpponentVolley.Value);
                othersPerformanceDetailRadChart.Series[4].AddItem(validRatings[counter].OpponentDrop.Value);
                othersPerformanceDetailRadChart.Series[5].AddItem(validRatings[counter].OpponentOverhead.Value);
                othersPerformanceDetailRadChart.Series[6].AddItem(validRatings[counter].OpponentCourtCoverage.Value);
            }

            othersPerformanceDetailRadChart.PlotArea.YAxis.AutoScale = false;
            othersPerformanceDetailRadChart.PlotArea.YAxis.AddRange(0, 5, 1);
            othersPerformanceDetailRadChart.PlotArea.YAxis[0].TextBlock.Text = "N.A";
            othersPerformanceDetailRadChart.PlotArea.YAxis[1].TextBlock.Text = "V.Bad";
            othersPerformanceDetailRadChart.PlotArea.YAxis[2].TextBlock.Text = "Bad";
            othersPerformanceDetailRadChart.PlotArea.YAxis[3].TextBlock.Text = "Average";
            othersPerformanceDetailRadChart.PlotArea.YAxis[4].TextBlock.Text = "Good";
            othersPerformanceDetailRadChart.PlotArea.YAxis[5].TextBlock.Text = "V.Good";

        }
    }
}