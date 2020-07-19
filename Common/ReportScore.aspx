<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportScore.aspx.cs" Inherits="FlexibleTennisLeague.Common.ReportScore" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Update Match Request</title>
    <link href="../App_Themes/FlexibleTennisLeague/Tennis.css" rel="stylesheet" type="text/css" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">
            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz az well)
                return oWindow;
            }
            function closeRadWindowAndShowAlert(message) {
                var oWnd = GetRadWindow();
                oWnd.BrowserWindow.radalert(message, 400, null, 'Success'); // The operation is not blocking ;
                // You cannot block this thread ;
                oWnd.close();
            }

            function closeRadWindow() {
                var oWnd = GetRadWindow();
                oWnd.close();
            }

            function showAlert(message) {
                var oWnd = GetRadWindow();
                oWnd.BrowserWindow.radalert(message, 400, null, 'Error'); // The operation is not blocking ;
            }

            function confirmCallBackFn(arg) {
                var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                ajaxManager.ajaxRequest(arg);
            }
            
            
        </script>

    </telerik:RadCodeBlock>

    <script language="javascript" type="text/javascript">
        function changeWinner() {
            var noShowCheckBox = document.getElementById("noShowCheckBox");
            var winnerDropDown = document.getElementById("winnerDropDownList");
            if (noShowCheckBox.checked) {
                winnerDropDown.disabled = true;
            }
            else {
                winnerDropDown.disabled = false;
            }
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

</head>
<body style="width: 450px;overflow:hidden">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
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
    <br />
    <div class="greyContent" style="width: 400px;margin-left:auto;margin-right:auto">
        <table width="400">
            <tr>
                <td class="signUpBold" style="height: 30px">
                    Opponent:
                </td>
                <td class="signUpBold">
                    <asp:DropDownList ID="opponentDropDownList" runat="server" Width="200" 
                        AutoPostBack="True" 
                        onselectedindexchanged="opponentDropDownList_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Opponent is required"
                        ControlToValidate="opponentDropDownList" Display="Dynamic" ValidationGroup="validate1"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="signUpBold" style="height: 30px">
                    Date:
                </td>
                <td class="signUp">
                    <telerik:RadDatePicker ID="RadDatePicker1" runat="server" Calendar-ShowOtherMonthsDays="False"
                        Calendar-UseRowHeadersAsSelectors="False" Calendar-ShowRowHeaders="False" Width="150">
                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ShowRowHeaders="False"
                            ShowOtherMonthsDays="False" ViewSelectorText="x">
                        </Calendar>
                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
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
                        <TimePopupButton CssClass="" ImageUrl="" HoverImageUrl="" Visible="False"></TimePopupButton>
                        <TimeView CellSpacing="-1">
                        </TimeView>
                        <DateInput Width="" LabelCssClass="">
                        </DateInput>
                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x">
                        </Calendar>
                        <DatePopupButton Visible="False" CssClass="" ImageUrl="" HoverImageUrl=""></DatePopupButton>
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
                    <asp:DropDownList ID="locationDropDownList" runat="server" Width="200">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Location is required"
                        ControlToValidate="locationDropDownList" Display="Dynamic" ValidationGroup="validate1"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="signUpBold" style="height: 30px">
                    Winner:
                </td>
                <td class="signUp">
                    <asp:DropDownList ID="winnerDropDownList" runat="server" Width="200">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Winner is required"
                        ControlToValidate="winnerDropDownList" Display="Dynamic" ValidationGroup="validate1"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="signUpBold" rowspan="3">
                    Score:
                </td>
                <td valign="middle">
                    <asp:DropDownList ID="playerSet1DropDownListSet" runat="server">
                        <asp:ListItem Value="0" Selected="True">0</asp:ListItem>
                        <asp:ListItem Value="1" Selected="False">1</asp:ListItem>
                        <asp:ListItem Value="2" Selected="False">2</asp:ListItem>
                        <asp:ListItem Value="3" Selected="False">3</asp:ListItem>
                        <asp:ListItem Value="4" Selected="False">4</asp:ListItem>
                        <asp:ListItem Value="5" Selected="False">5</asp:ListItem>
                        <asp:ListItem Value="6" Selected="False">6</asp:ListItem>
                        <asp:ListItem Value="7" Selected="False">7</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;&nbsp;
                    <asp:DropDownList ID="playerSet2DropDownListSet" runat="server">
                        <asp:ListItem Value="0" Selected="True">0</asp:ListItem>
                        <asp:ListItem Value="1" Selected="False">1</asp:ListItem>
                        <asp:ListItem Value="2" Selected="False">2</asp:ListItem>
                        <asp:ListItem Value="3" Selected="False">3</asp:ListItem>
                        <asp:ListItem Value="4" Selected="False">4</asp:ListItem>
                        <asp:ListItem Value="5" Selected="False">5</asp:ListItem>
                        <asp:ListItem Value="6" Selected="False">6</asp:ListItem>
                        <asp:ListItem Value="7" Selected="False">7</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;&nbsp;
                    <asp:DropDownList ID="playerSet3DropDownListSet" runat="server">
                        <asp:ListItem Value="0" Selected="True">0</asp:ListItem>
                        <asp:ListItem Value="1" Selected="False">1</asp:ListItem>
                        <asp:ListItem Value="2" Selected="False">2</asp:ListItem>
                        <asp:ListItem Value="3" Selected="False">3</asp:ListItem>
                        <asp:ListItem Value="4" Selected="False">4</asp:ListItem>
                        <asp:ListItem Value="5" Selected="False">5</asp:ListItem>
                        <asp:ListItem Value="6" Selected="False">6</asp:ListItem>
                        <asp:ListItem Value="7" Selected="False">7</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;&nbsp;
                    <asp:Label ID="playerLabel" runat="server" Text="Your Score"></asp:Label>
                </td>
            </tr>
            <tr>
                <td valign="middle">
                    <asp:DropDownList ID="opponentSet1DropDownList" runat="server">
                        <asp:ListItem Value="0" Selected="True">0</asp:ListItem>
                        <asp:ListItem Value="1" Selected="False">1</asp:ListItem>
                        <asp:ListItem Value="2" Selected="False">2</asp:ListItem>
                        <asp:ListItem Value="3" Selected="False">3</asp:ListItem>
                        <asp:ListItem Value="4" Selected="False">4</asp:ListItem>
                        <asp:ListItem Value="5" Selected="False">5</asp:ListItem>
                        <asp:ListItem Value="6" Selected="False">6</asp:ListItem>
                        <asp:ListItem Value="7" Selected="False">7</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;&nbsp;
                    <asp:DropDownList ID="opponentSet2DropDownList" runat="server">
                        <asp:ListItem Value="0" Selected="True">0</asp:ListItem>
                        <asp:ListItem Value="1" Selected="False">1</asp:ListItem>
                        <asp:ListItem Value="2" Selected="False">2</asp:ListItem>
                        <asp:ListItem Value="3" Selected="False">3</asp:ListItem>
                        <asp:ListItem Value="4" Selected="False">4</asp:ListItem>
                        <asp:ListItem Value="5" Selected="False">5</asp:ListItem>
                        <asp:ListItem Value="6" Selected="False">6</asp:ListItem>
                        <asp:ListItem Value="7" Selected="False">7</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;&nbsp;
                    <asp:DropDownList ID="opponentSet3DropDownList" runat="server">
                        <asp:ListItem Value="0" Selected="True">0</asp:ListItem>
                        <asp:ListItem Value="1" Selected="False">1</asp:ListItem>
                        <asp:ListItem Value="2" Selected="False">2</asp:ListItem>
                        <asp:ListItem Value="3" Selected="False">3</asp:ListItem>
                        <asp:ListItem Value="4" Selected="False">4</asp:ListItem>
                        <asp:ListItem Value="5" Selected="False">5</asp:ListItem>
                        <asp:ListItem Value="6" Selected="False">6</asp:ListItem>
                        <asp:ListItem Value="7" Selected="False">7</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;&nbsp;
                    <asp:Label ID="opponentPlayerLabel" runat="server" Text="Opponent's Score"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="height: 30px; vertical-align: middle">
                    <p>
                        <asp:CheckBox ID="noShowCheckBox" runat="server" Text="The opponent did not show up or call."
                            onclick="changeWinner()" /></p>
                </td>
            </tr>
            <tr>
                <td class="signUpBold" style="height: 30px">
                    Comments:
                </td>
                <td class="signUp">
                    <asp:TextBox ID="messageTextBox" runat="server" TextMode="MultiLine" Height="100"></asp:TextBox>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <asp:Button ID="submitButton" runat="server" Text="Report Score" CssClass="button"
            ValidationGroup="validate1" OnClick="submitButton_Click" />
        <asp:HiddenField ID="matchIdHiddenField" runat="server" />
        <asp:HiddenField ID="opponentIdHiddenField" runat="server" />
        <asp:HiddenField ID="opponentCourtHiddenField" runat="server" />
        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    </div>
    </form>
</body>
</html>
