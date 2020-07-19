using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using DLL;
using Telerik.Web.UI;
using System.Data;

namespace FlexibleTennisLeague.UserControls
{
    public partial class TennisCourtsGrid : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            textLabel.Text = WebConfigurationManager.AppSettings["TennisCourtGridLabelText"].ToString();
            if (!Page.IsPostBack)
            {
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    List<SelectUniqueTennisCourtCitiesResult> selectUniqueTennisCourtCitiesResults = dataContext.SelectUniqueTennisCourtCities(Convert.ToInt32(WebConfigurationManager.AppSettings["LeagueCityId"])).ToList();
                    citiesDropDownList.Items.Add(new ListItem("All Cities", "All Cities"));
                    foreach (SelectUniqueTennisCourtCitiesResult result in selectUniqueTennisCourtCitiesResults)
                    {
                        citiesDropDownList.Items.Add(new ListItem(result.City, result.City));
                    }
                    citiesDropDownList.Items[1].Selected = true;
                }
            }
        }

        protected string Format(bool result)
        {
            string returnResult = string.Empty;
            if (result)
                returnResult = "Yes";
            else
                returnResult = "No";
            return returnResult;
        }

        protected void tennisCourtsRadGrid_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridGroupHeaderItem)
            {
                GridGroupHeaderItem item = (GridGroupHeaderItem)e.Item;
                DataRowView groupDataRow = (DataRowView)e.Item.DataItem;
                item.DataCell.Text = "Tennis Courts in " + groupDataRow["City"].ToString();
            }
            else if (e.Item is GridDataItem)
            {
                int mapId = Convert.ToInt32(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["MapId"]);
                ImageButton imageButton = (ImageButton)e.Item.FindControl("zoomImageButton");
                imageButton.Attributes.Add("onClick", string.Format("zoomToTennisCourt({0});", --mapId));
                TennisCourt dataRow = (TennisCourt)e.Item.DataItem;
                ImageButton directionsImageButton = (ImageButton)e.Item.FindControl("directionsImageButton");
                string zip = dataRow.Zip.HasValue ? dataRow.Zip.Value.ToString() : string.Empty;
                directionsImageButton.Attributes.Add("onClick", string.Format("showStartEndPoints('{0},{1},{2} {3}');", dataRow.Address, dataRow.City, dataRow.State, zip));
            }
        }

        protected void tennisCourtsRadGrid_NeedDataSource(object source, GridNeedDataSourceEventArgs e)
        {
            using (FlexibleTennisLeagueDataContext dataContent = new FlexibleTennisLeagueDataContext())
            {
                List<TennisCourt> tennisCourts = new List<TennisCourt>();
                if (citiesDropDownList.SelectedItem.Text == "All Cities")
                    tennisCourts = dataContent.SelectTennisCourtsByLeague(Convert.ToInt32(WebConfigurationManager.AppSettings["LeagueCityId"])).ToList();
                else
                    tennisCourts = dataContent.SelectTennisCourtByCity(citiesDropDownList.SelectedItem.Text, Convert.ToInt32(WebConfigurationManager.AppSettings["LeagueCityId"])).ToList();
                tennisCourtsRadGrid.DataSource = tennisCourts;
                //tennisCourtsRadGrid.DataBind();
            }
        }

        protected void citiesDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            tennisCourtsRadGrid.Rebind();
        }
    }
}