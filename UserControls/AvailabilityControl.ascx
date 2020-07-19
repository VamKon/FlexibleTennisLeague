<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AvailabilityControl.ascx.cs"
    Inherits="FlexibleTennisLeague.UserControls.AvailabilityControl" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<script language="javascript" type="text/javascript">
    function clearTextBoxes(checkBox) {
        if (checkBox.checked == 1) {
            if (checkBox.name.indexOf('sunday', 0) >= 0) {
                var dateInputFrom = $find("<%= sundayFromRadTimePicker.ClientID %>");
                dateInputFrom.clear();
                var dateInputTo = $find("<%= sundayToRadTimePicker.ClientID %>");
                dateInputTo.clear();
            }
            else if (checkBox.name.toString().indexOf('monday', 0) >= 0) {
                var dateInputFrom = $find("<%= mondayFromRadTimePicker.ClientID %>");
                dateInputFrom.clear();
                var dateInputTo = $find("<%= mondayToRadTimePicker.ClientID %>");
                dateInputTo.clear();
            }
            else if (checkBox.name.toString().indexOf('tuesday', 0) >= 0) {
                var dateInputFrom = $find("<%= tuesdayFromRadTimePicker.ClientID %>");
                dateInputFrom.clear();
                var dateInputTo = $find("<%= tuesdayToRadTimePicker.ClientID %>");
                dateInputTo.clear();
            }
            else if (checkBox.name.toString().indexOf('wednesday', 0) >= 0) {
                var dateInputFrom = $find("<%= wednesdayFromRadTimePicker.ClientID %>");
                dateInputFrom.clear();
                var dateInputTo = $find("<%= wednesdayToRadTimePicker.ClientID %>");
                dateInputTo.clear();
            }
            else if (checkBox.name.toString().indexOf('thursday', 0) >= 0) {
                var dateInputFrom = $find("<%= thursdayFromRadTimePicker.ClientID %>");
                dateInputFrom.clear();
                var dateInputTo = $find("<%= thursdayToRadTimePicker.ClientID %>");
                dateInputTo.clear();
            }
            else if (checkBox.name.toString().indexOf('friday', 0) >= 0) {
                var dateInputFrom = $find("<%= fridayFromRadTimePicker.ClientID %>");
                dateInputFrom.clear();
                var dateInputTo = $find("<%= fridayToRadTimePicker.ClientID %>");
                dateInputTo.clear();
            }
            else if (checkBox.name.toString().indexOf('saturday', 0) >= 0) {
                var dateInputFrom = $find("<%= saturdayFromRadTimePicker.ClientID %>");
                dateInputFrom.clear();
                var dateInputTo = $find("<%= saturdayToRadTimePicker.ClientID %>");
                dateInputTo.clear();
            }
        }
    }

    function clearCheckBox(textBox) {
        if (!textBox.isEmpty) {
            if (textBox.id.indexOf('sunday', 0) >= 0) {
                var checkBox = $get("<%= sundayUnavailableCheckBox.ClientID %>");
                checkBox.checked = 0;
            }
            else if (textBox.id.indexOf('monday', 0) >= 0) {
                var checkBox = $get("<%= mondayUnavailableCheckBox.ClientID %>");
                checkBox.checked = 0;
            }
            else if (textBox.id.indexOf('tuesday', 0) >= 0) {
                var checkBox = $get("<%= tuesdayUnavailableCheckBox.ClientID %>");
                checkBox.checked = 0;
            }
            else if (textBox.id.indexOf('wednesday', 0) >= 0) {
                var checkBox = $get("<%= wednesdayUnavailableCheckBox.ClientID %>");
                checkBox.checked = 0;
            }
            else if (textBox.id.indexOf('thursday', 0) >= 0) {
                var checkBox = $get("<%= thursdayUnavailableCheckBox.ClientID %>");
                checkBox.checked = 0;
            }
            else if (textBox.id.indexOf('friday', 0) >= 0) {
                var checkBox = $get("<%= fridayUnavailableCheckBox.ClientID %>");
                checkBox.checked = 0;
            }
            else if (textBox.id.indexOf('saturday', 0) >= 0) {
                var checkBox = $get("<%= saturdayUnavailableCheckBox.ClientID %>");
                checkBox.checked = 0;
            }
        }
    }

    function CheckTimeSunday(sender, args) {
        var beginDate = new Date($find("<%= sundayFromRadTimePicker.ClientID%>").get_selectedDate());
        var endDate = new Date($find("<%= sundayToRadTimePicker.ClientID%>").get_selectedDate());
        args.IsValid = beginDate < endDate;
    }
    function CheckTimeMonday(sender, args) {
        var beginDate = new Date($find("<%= mondayFromRadTimePicker.ClientID%>").get_selectedDate());
        var endDate = new Date($find("<%= mondayToRadTimePicker.ClientID%>").get_selectedDate());
        args.IsValid = beginDate < endDate;
    }
    function CheckTimeTuesday(sender, args) {
        var beginDate = new Date($find("<%= tuesdayFromRadTimePicker.ClientID%>").get_selectedDate());
        var endDate = new Date($find("<%= tuesdayToRadTimePicker.ClientID%>").get_selectedDate());
        args.IsValid = beginDate < endDate;
    }
    function CheckTimeWednesday(sender, args) {
        var beginDate = new Date($find("<%= wednesdayFromRadTimePicker.ClientID%>").get_selectedDate());
        var endDate = new Date($find("<%= wednesdayToRadTimePicker.ClientID%>").get_selectedDate());
        args.IsValid = beginDate < endDate;
    }
    function CheckTimeThursday(sender, args) {
        var beginDate = new Date($find("<%= thursdayFromRadTimePicker.ClientID%>").get_selectedDate());
        var endDate = new Date($find("<%= thursdayToRadTimePicker.ClientID%>").get_selectedDate());
        args.IsValid = beginDate < endDate;
    }
    function CheckTimeFriday(sender, args) {
        var beginDate = new Date($find("<%= fridayFromRadTimePicker.ClientID%>").get_selectedDate());
        var endDate = new Date($find("<%= fridayToRadTimePicker.ClientID%>").get_selectedDate());
        args.IsValid = beginDate < endDate;
    }
    function CheckTimeSaturday(sender, args) {
        var beginDate = new Date($find("<%= saturdayFromRadTimePicker.ClientID%>").get_selectedDate());
        var endDate = new Date($find("<%= saturdayToRadTimePicker.ClientID%>").get_selectedDate());
        args.IsValid = beginDate < endDate;
    }  
    

</script>

<div class="greyContent" align="center">
    <table cellpadding="5" cellspacing="5">
        <tr>
            <td>
                <b>Sunday</b>
            </td>
            <td>
                &nbsp;&nbsp;Available From:
                <telerik:RadTimePicker ID="sundayFromRadTimePicker" SharedTimeViewID="SharedTimeView"
                    runat="server">
                </telerik:RadTimePicker>
                &nbsp;&nbsp; To &nbsp;&nbsp;
                <telerik:RadTimePicker ID="sundayToRadTimePicker" SharedTimeViewID="SharedTimeView"
                    runat="server">
                </telerik:RadTimePicker>
                <br />
                <asp:CustomValidator ControlToValidate="sundayToRadTimePicker" runat="server"
                    ID="timeCompareValidator" ErrorMessage="Start time has to be earlier than the end time" Display="Dynamic"
                    ClientValidationFunction="CheckTimeSunday" ValidationGroup="timeValidation">  
                </asp:CustomValidator>
            </td>
            <td>
                <asp:CheckBox ID="sundayUnavailableCheckBox" runat="server" />
                Completely Unavailable
            </td>
        </tr>
        <tr height="10">
        </tr>
        <tr>
            <td>
                <b>Monday</b>
            </td>
            <td>
                &nbsp;&nbsp;Available From:
                <telerik:RadTimePicker ID="mondayFromRadTimePicker" SharedTimeViewID="SharedTimeView"
                    runat="server">
                </telerik:RadTimePicker>
                &nbsp;&nbsp; To &nbsp;&nbsp;
                <telerik:RadTimePicker ID="mondayToRadTimePicker" SharedTimeViewID="SharedTimeView"
                    runat="server">
                </telerik:RadTimePicker>
                <br />
                <asp:CustomValidator ControlToValidate="mondayToRadTimePicker" runat="server"
                    ID="CustomValidator1" ErrorMessage="Start time has to be earlier than the end time" Display="Dynamic"
                    ClientValidationFunction="CheckTimeMonday" ValidationGroup="timeValidation">  
                </asp:CustomValidator>
            </td>
            <td>
                <asp:CheckBox ID="mondayUnavailableCheckBox" runat="server" />
                Completely Unavailable
            </td>
        </tr>
        <tr height="10">
        </tr>
        <tr>
            <td>
                <b>Tuesday</b>
            </td>
            <td>
                &nbsp;&nbsp;Available From:
                <telerik:RadTimePicker ID="tuesdayFromRadTimePicker" SharedTimeViewID="SharedTimeView"
                    runat="server">
                </telerik:RadTimePicker>
                &nbsp;&nbsp; To &nbsp;&nbsp;
                <telerik:RadTimePicker ID="tuesdayToRadTimePicker" SharedTimeViewID="SharedTimeView"
                    runat="server">
                </telerik:RadTimePicker>
                <br />
                <asp:CustomValidator ControlToValidate="tuesdayToRadTimePicker" runat="server"
                    ID="CustomValidator2" ErrorMessage="Start time has to be earlier than the end time" Display="Dynamic"
                    ClientValidationFunction="CheckTimeTuesday" ValidationGroup="timeValidation">  
                </asp:CustomValidator>
            </td>
            <td>
                <asp:CheckBox ID="tuesdayUnavailableCheckBox" runat="server" />
                Completely Unavailable
            </td>
        </tr>
        <tr height="10">
        </tr>
        <tr>
            <td>
                <b>Wednesday</b>
            </td>
            <td>
                &nbsp;&nbsp;Available From:
                <telerik:RadTimePicker ID="wednesdayFromRadTimePicker" SharedTimeViewID="SharedTimeView"
                    runat="server">
                </telerik:RadTimePicker>
                &nbsp;&nbsp; To &nbsp;&nbsp;
                <telerik:RadTimePicker ID="wednesdayToRadTimePicker" SharedTimeViewID="SharedTimeView"
                    runat="server">
                </telerik:RadTimePicker>
                <br />
                <asp:CustomValidator ControlToValidate="wednesdayToRadTimePicker" runat="server"
                    ID="CustomValidator3" ErrorMessage="Start time has to be earlier than the end time" Display="Dynamic"
                    ClientValidationFunction="CheckTimeWednesday" ValidationGroup="timeValidation">  
                </asp:CustomValidator>
            </td>
            <td>
                <asp:CheckBox ID="wednesdayUnavailableCheckBox" runat="server" />
                Completely Unavailable
            </td>
        </tr>
        <tr height="10">
        </tr>
        <tr>
            <td>
                <b>Thursday</b>
            </td>
            <td>
                &nbsp;&nbsp;Available From:
                <telerik:RadTimePicker ID="thursdayFromRadTimePicker" SharedTimeViewID="SharedTimeView"
                    runat="server">
                </telerik:RadTimePicker>
                &nbsp;&nbsp; To &nbsp;&nbsp;
                <telerik:RadTimePicker ID="thursdayToRadTimePicker" SharedTimeViewID="SharedTimeView"
                    runat="server">
                </telerik:RadTimePicker>
                <br>
                <asp:CustomValidator ControlToValidate="thursdayToRadTimePicker" runat="server"
                    ID="CustomValidator4" ErrorMessage="Start time has to be earlier than the end time" Display="Dynamic"
                    ClientValidationFunction="CheckTimeThursday" ValidationGroup="timeValidation">  
                </asp:CustomValidator>
            </td>
            <td>
                <asp:CheckBox ID="thursdayUnavailableCheckBox" runat="server" />
                Completely Unavailable
            </td>
        </tr>
        <tr height="10">
        </tr>
        <tr>
            <td>
                <b>Friday</b>
            </td>
            <td>
                &nbsp;&nbsp;Available From:
                <telerik:RadTimePicker ID="fridayFromRadTimePicker" SharedTimeViewID="SharedTimeView"
                    runat="server">
                </telerik:RadTimePicker>
                &nbsp;&nbsp; To &nbsp;&nbsp;
                <telerik:RadTimePicker ID="fridayToRadTimePicker" SharedTimeViewID="SharedTimeView"
                    runat="server">
                </telerik:RadTimePicker>
                <br />
                <asp:CustomValidator ControlToValidate="fridayToRadTimePicker" runat="server"
                    ID="CustomValidator5" ErrorMessage="Start time has to be earlier than the end time" Display="Dynamic"
                    ClientValidationFunction="CheckTimeFriday" ValidationGroup="timeValidation">  
                </asp:CustomValidator>
            </td>
            <td>
                <asp:CheckBox ID="fridayUnavailableCheckBox" runat="server" />
                Completely Unavailable
            </td>
        </tr>
        <tr height="10">
        </tr>
        <tr>
            <td>
                <b>Saturday</b>
            </td>
            <td>
                &nbsp;&nbsp;Available From:
                <telerik:RadTimePicker ID="saturdayFromRadTimePicker" SharedTimeViewID="SharedTimeView"
                    runat="server">
                </telerik:RadTimePicker>
                &nbsp;&nbsp; To &nbsp;&nbsp;
                <telerik:RadTimePicker ID="saturdayToRadTimePicker" SharedTimeViewID="SharedTimeView"
                    runat="server">
                </telerik:RadTimePicker>
                <br />
                <asp:CustomValidator ControlToValidate="saturdayToRadTimePicker" runat="server"
                    ID="CustomValidator6" ErrorMessage="Start time has to be earlier than the end time" Display="Dynamic"
                    ClientValidationFunction="CheckTimeSaturday" ValidationGroup="timeValidation">  
                </asp:CustomValidator>
            </td>
            <td>
                <asp:CheckBox ID="saturdayUnavailableCheckBox" runat="server" />
                Completely Unavailable
            </td>
        </tr>
        <tr height="10">
        </tr>
        <tr>
            <td colspan="3" align="center">
                <asp:Button ID="updateButton" runat="server" Text="Update Availability" CssClass="button"
                    OnClick="updateButton_Click" ValidationGroup="timeValidation" />
            </td>
        </tr>
    </table>
    <br />
    <telerik:RadTimeView ID="SharedTimeView" runat="server" StartTime="06:00:00">
    </telerik:RadTimeView>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Modal="True" ShowContentDuringLoad="False"
        VisibleStatusbar="False" Width="370px" Height="300px" Behavior="Default" Behaviors="Close"
        VisibleOnPageLoad="False">
    </telerik:RadWindowManager>
</div>
