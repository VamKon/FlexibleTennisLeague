<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditMatch.aspx.cs" Inherits="FlexibleTennisLeague.Common.EditMatch" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Match</title>
    <link href="../App_Themes/FlexibleTennisLeague/Tennis.css" rel="stylesheet" type="text/css" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">
            function confirmCallBackFn(arg) {
                var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                ajaxManager.ajaxRequest(arg);
            }
            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz az well)
                return oWindow;
            }
            function closeRadWindowAndShowAlert() {
                var oWnd = GetRadWindow();

                oWnd.BrowserWindow.radalert("Match request updated succesfully!<br>If you don't hear back from your opponent please confirm his participation before the game day."); // The operation is not blocking ;
                // You cannot block this thread ;

                oWnd.close();
            }
            function recordValue() {
                var dropDown = document.getElementById("locationDropDownList");
                var hiddenField = document.getElementById("HiddenField1");
                var hiddenField2 = document.getElementById("HiddenField2");
                hiddenField.value = dropDown.options[dropDown.selectedIndex].value;
                hiddenField2.value = dropDown.options[dropDown.selectedIndex].text;
            }
            function changeButtonState(enabled) {
                var submitButton = document.getElementById("submitButton");
                if (enabled == 'true') {
                    submitButton.disabled = true;
                }
                else {
                    submitButton.disabled = false;
                }
            }
            
        </script>
    </telerik:RadCodeBlock>
</head>
<body style="width: 310px;" >
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <br />
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
    </telerik:RadWindowManager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="submitButton">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="submitButton" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <div class="greyContent" style="width: 300px">
        <table>
            <tr>
                <td class="signUpBold" style="height: 30px">
                    Opponent:
                </td>
                <td class="signUpBold">
                    <asp:Label ID="opponentLabel" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="signUpBold" style="height: 30px">
                    Date:
                </td>
                <td class="signUp">
                    <telerik:RadDatePicker ID="RadDatePicker1" runat="server" Calendar-ShowOtherMonthsDays="False"
                        Calendar-UseRowHeadersAsSelectors="False" Calendar-ShowRowHeaders="False" Width="150">
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Date is required"
                        ControlToValidate="RadDatePicker1" Display="Dynamic" ValidationGroup="validate1"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="signUpBold" style="height: 30px">
                    Time:
                </td>
                <td class="signUp">
                    <telerik:RadTimePicker ID="RadTimePicker1" runat="server" Width="150" TimePopupButton-Visible="False">
                    </telerik:RadTimePicker>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Time is required"
                        ControlToValidate="RadTimePicker1" Display="Dynamic" ValidationGroup="validate1"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="signUpBold" style="height: 30px">
                    Location:
                </td>
                <td class="signUp">
                    <asp:DropDownList ID="locationDropDownList" runat="server" Width="200" onChange="recordValue();">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Location is required"
                        ControlToValidate="locationDropDownList" Display="Dynamic" ValidationGroup="validate1"></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
        <br />
        <asp:Label ID="Label1" runat="server" 
            Text="Please allow more than 24 hours while re-scheduling a match. Please contact your opponent directly if you want to play this match within the next 24 hours."></asp:Label>
        <asp:Label ID="errorLabel" runat="server" ForeColor="Red"></asp:Label><br />
        <asp:Label ID="successLabel" runat="server"></asp:Label><br />
        <asp:Button ID="submitButton" runat="server" Text="Submit Request" CssClass="button"
            ValidationGroup="validate1" OnClick="submitButton_Click" />
    </div>
    </form>
</body>
</html>
