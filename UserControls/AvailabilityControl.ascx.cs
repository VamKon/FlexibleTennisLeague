using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using DLL;
using Telerik.Web.UI;

namespace FlexibleTennisLeague.UserControls
{
    public partial class AvailabilityControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
                Response.Redirect(WebConfigurationManager.AppSettings["LoginPageURL"].ToString());

            sundayUnavailableCheckBox.Attributes.Add("onclick", "clearTextBoxes(this);");
            mondayUnavailableCheckBox.Attributes.Add("onclick", "clearTextBoxes(this);");
            tuesdayUnavailableCheckBox.Attributes.Add("onclick", "clearTextBoxes(this);");
            wednesdayUnavailableCheckBox.Attributes.Add("onclick", "clearTextBoxes(this);");
            thursdayUnavailableCheckBox.Attributes.Add("onclick", "clearTextBoxes(this);");
            fridayUnavailableCheckBox.Attributes.Add("onclick", "clearTextBoxes(this);");
            saturdayUnavailableCheckBox.Attributes.Add("onclick", "clearTextBoxes(this);");

            sundayFromRadTimePicker.Attributes.Add("onkeypress", "clearCheckBox(this);");
            sundayToRadTimePicker.Attributes.Add("onkeypress", "clearCheckBox(this);");
            mondayFromRadTimePicker.Attributes.Add("onkeypress", "clearCheckBox(this);");
            mondayToRadTimePicker.Attributes.Add("onkeypress", "clearCheckBox(this);");
            tuesdayFromRadTimePicker.Attributes.Add("onkeypress", "clearCheckBox(this);");
            tuesdayToRadTimePicker.Attributes.Add("onkeypress", "clearCheckBox(this);");
            wednesdayFromRadTimePicker.Attributes.Add("onkeypress", "clearCheckBox(this);");
            wednesdayToRadTimePicker.Attributes.Add("onkeypress", "clearCheckBox(this);");
            thursdayFromRadTimePicker.Attributes.Add("onkeypress", "clearCheckBox(this);");
            thursdayToRadTimePicker.Attributes.Add("onkeypress", "clearCheckBox(this);");
            fridayFromRadTimePicker.Attributes.Add("onkeypress", "clearCheckBox(this);");
            fridayToRadTimePicker.Attributes.Add("onkeypress", "clearCheckBox(this);");
            saturdayFromRadTimePicker.Attributes.Add("onkeypress", "clearCheckBox(this);");
            saturdayToRadTimePicker.Attributes.Add("onkeypress", "clearCheckBox(this);");

            using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
            {
                if (!Page.IsPostBack)
                {
                    List<SelectAvailabilitiesByUserIdResult> availability = dataContext.SelectAvailabilitiesByUserId(StoredData.User.UserId).ToList();
                    if (availability.Count > 0)
                    {
                        if (availability[0].SundayStart.HasValue)
                            sundayFromRadTimePicker.SelectedDate = availability[0].SundayStart;
                        if (availability[0].SundayEnd.HasValue)
                            sundayToRadTimePicker.SelectedDate = availability[0].SundayEnd;
                        if (availability[0].SundayUnavailable.HasValue)
                            sundayUnavailableCheckBox.Checked = availability[0].SundayUnavailable.Value;
                        if (availability[0].MondayStart.HasValue)
                            mondayFromRadTimePicker.SelectedDate = availability[0].MondayStart;
                        if (availability[0].MondayEnd.HasValue)
                            mondayToRadTimePicker.SelectedDate = availability[0].MondayEnd;
                        if (availability[0].MondayUnavailable.HasValue)
                            mondayUnavailableCheckBox.Checked = availability[0].MondayUnavailable.Value;
                        if (availability[0].TuesdayStart.HasValue)
                            tuesdayFromRadTimePicker.SelectedDate = availability[0].TuesdayStart;
                        if (availability[0].TuesdayEnd.HasValue)
                            tuesdayToRadTimePicker.SelectedDate = availability[0].TuesdayEnd;
                        if (availability[0].TuesdayUnavailable.HasValue)
                            tuesdayUnavailableCheckBox.Checked = availability[0].TuesdayUnavailable.Value;
                        if (availability[0].WednesdayStart.HasValue)
                            wednesdayFromRadTimePicker.SelectedDate = availability[0].WednesdayStart;
                        if (availability[0].WednesdayEnd.HasValue)
                            wednesdayToRadTimePicker.SelectedDate = availability[0].WednesdayEnd;
                        if (availability[0].WednesdayUnavailable.HasValue)
                            wednesdayUnavailableCheckBox.Checked = availability[0].WednesdayUnavailable.Value;
                        if (availability[0].ThursdayStart.HasValue)
                            thursdayFromRadTimePicker.SelectedDate = availability[0].ThursdayStart;
                        if (availability[0].ThursdayEnd.HasValue)
                            thursdayToRadTimePicker.SelectedDate = availability[0].ThursdayEnd;
                        if (availability[0].ThursdayUnavailable.HasValue)
                            thursdayUnavailableCheckBox.Checked = availability[0].ThursdayUnavailable.Value;
                        if (availability[0].FridayStart.HasValue)
                            fridayFromRadTimePicker.SelectedDate = availability[0].FridayStart;
                        if (availability[0].FridayEnd.HasValue)
                            fridayToRadTimePicker.SelectedDate = availability[0].FridayEnd;
                        if (availability[0].FridayUnavailable.HasValue)
                            fridayUnavailableCheckBox.Checked = availability[0].FridayUnavailable.Value;
                        if (availability[0].SaturdayStart.HasValue)
                            saturdayFromRadTimePicker.SelectedDate = availability[0].SaturdayStart;
                        if (availability[0].SaturdayEnd.HasValue)
                            saturdayToRadTimePicker.SelectedDate = availability[0].SaturdayEnd;
                        if (availability[0].SaturdayUnavailable.HasValue)
                            saturdayUnavailableCheckBox.Checked = availability[0].SaturdayUnavailable.Value;

                        ViewState["AvailabilityPresent"] = true;
                    }
                }
            }

        }

        protected void updateButton_Click(object sender, EventArgs e)
        {
            if (Validation() && Page.IsValid)
            {
                int? availabilityId = null;
                using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                {
                    bool availabilityPresent = false;
                    if (ViewState["AvailabilityPresent"] != null)
                        availabilityPresent = Convert.ToBoolean(ViewState["AvailabilityPresent"]);

                    if (availabilityPresent)
                    {
                        //update availability
                        dataContext.UpdateAvailability(StoredData.User.UserId, sundayFromRadTimePicker.SelectedDate, sundayToRadTimePicker.SelectedDate, sundayUnavailableCheckBox.Checked, mondayFromRadTimePicker.SelectedDate, mondayToRadTimePicker.SelectedDate, mondayUnavailableCheckBox.Checked, tuesdayFromRadTimePicker.SelectedDate, tuesdayToRadTimePicker.SelectedDate, tuesdayUnavailableCheckBox.Checked, wednesdayFromRadTimePicker.SelectedDate, wednesdayToRadTimePicker.SelectedDate, wednesdayUnavailableCheckBox.Checked, thursdayFromRadTimePicker.SelectedDate, thursdayToRadTimePicker.SelectedDate, thursdayUnavailableCheckBox.Checked, fridayFromRadTimePicker.SelectedDate, fridayToRadTimePicker.SelectedDate, fridayUnavailableCheckBox.Checked, saturdayFromRadTimePicker.SelectedDate, saturdayToRadTimePicker.SelectedDate, saturdayUnavailableCheckBox.Checked);
                    }
                    else
                    {
                        dataContext.InsertAvailability(StoredData.User.UserId, sundayFromRadTimePicker.SelectedDate, sundayToRadTimePicker.SelectedDate, sundayUnavailableCheckBox.Checked, mondayFromRadTimePicker.SelectedDate, mondayToRadTimePicker.SelectedDate, mondayUnavailableCheckBox.Checked, tuesdayFromRadTimePicker.SelectedDate, tuesdayToRadTimePicker.SelectedDate, tuesdayUnavailableCheckBox.Checked, wednesdayFromRadTimePicker.SelectedDate, wednesdayToRadTimePicker.SelectedDate, wednesdayUnavailableCheckBox.Checked, thursdayFromRadTimePicker.SelectedDate, thursdayToRadTimePicker.SelectedDate, thursdayUnavailableCheckBox.Checked, fridayFromRadTimePicker.SelectedDate, fridayToRadTimePicker.SelectedDate, fridayUnavailableCheckBox.Checked, saturdayFromRadTimePicker.SelectedDate, saturdayToRadTimePicker.SelectedDate, saturdayUnavailableCheckBox.Checked, ref availabilityId);
                    }

                    string errorMessage = "radalert('Availability updated succesfully!!',250,150,'Success!!')";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "radalert", "(function(){var f = function(){" + errorMessage + ";Sys.Application.remove_load(f);};Sys.Application.add_load(f);})();", true);
                }
            }
        }

        private bool Validation()
        {
            bool isPageValid = true;
            string errorDay = string.Empty;


            if ((!sundayFromRadTimePicker.SelectedDate.HasValue || !sundayToRadTimePicker.SelectedDate.HasValue) && !sundayUnavailableCheckBox.Checked)
            {
                isPageValid = false;
                errorDay = "Sunday";
            }
            else if ((!mondayFromRadTimePicker.SelectedDate.HasValue || !mondayToRadTimePicker.SelectedDate.HasValue) && !mondayUnavailableCheckBox.Checked)
            {
                isPageValid = false;
                errorDay = "Monday";
            }
            else if ((!tuesdayFromRadTimePicker.SelectedDate.HasValue || !tuesdayToRadTimePicker.SelectedDate.HasValue) && !tuesdayUnavailableCheckBox.Checked)
            {
                isPageValid = false;
                errorDay = "Tuesday";
            }
            else if ((!wednesdayFromRadTimePicker.SelectedDate.HasValue || !wednesdayToRadTimePicker.SelectedDate.HasValue) && !wednesdayUnavailableCheckBox.Checked)
            {
                isPageValid = false;
                errorDay = "Wednesday";
            }
            else if ((!thursdayFromRadTimePicker.SelectedDate.HasValue || !thursdayToRadTimePicker.SelectedDate.HasValue) && !thursdayUnavailableCheckBox.Checked)
            {
                isPageValid = false;
                errorDay = "Thursday";
            }
            else if ((!fridayFromRadTimePicker.SelectedDate.HasValue || !fridayToRadTimePicker.SelectedDate.HasValue) && !fridayUnavailableCheckBox.Checked)
            {
                isPageValid = false;
                errorDay = "Friday";
            }
            else if ((!saturdayFromRadTimePicker.SelectedDate.HasValue || !saturdayToRadTimePicker.SelectedDate.HasValue) && !saturdayUnavailableCheckBox.Checked)
            {
                isPageValid = false;
                errorDay = "Saturday";
            }

            if (!isPageValid)
            {
                string errorMessage = "radalert('Please set your availability for a " + errorDay + "',250,150,'Incomplete Data!!')";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "radalert", "(function(){var f = function(){" + errorMessage + ";Sys.Application.remove_load(f);};Sys.Application.add_load(f);})();", true);
            }

            return isPageValid;
        }
    }
}