<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ContactFormControl.ascx.cs"
    Inherits="FlexibleTennisLeague.UserControls.ContactFormControl" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Height="75px"
    Width="75px">
    <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
        style="border: 0px;" />
</telerik:RadAjaxLoadingPanel>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="cityDropDownList">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="leagueDropDownList" LoadingPanelID="RadAjaxLoadingPanel1" />
                <telerik:AjaxUpdatedControl ControlID="radCaptcha"/>
                <telerik:AjaxUpdatedControl ControlID="radCaptcha1"/>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div style="width: 400px; float: left">
    <h1>
        Contact Us :: Please submit your questions/comments
    </h1>
    <div class="greyContent" style="width: 400px; float: left">
        Please use the contact form to:
        <ul>
            <li>Send us comments, complaints or suggestions about improving the league or website.
            </li>
            <li>Get clarification on any rules or regulations.</li>
            <li>Add missing tennis courts.</li>
            <li>Contest a submitted score.</li>
        </ul>
        <table align="center" border="0" cellpadding="3" cellspacing="0">
            <tr>
                <td>
                    First Name
                </td>
                <td>
                    <asp:TextBox ID="firstNameTextBox" runat="server" Width="200"></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter your first name"
                        ControlToValidate="firstNameTextBox" Display="Dynamic" ValidationGroup="commentValidation"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Last Name
                </td>
                <td>
                    <asp:TextBox ID="lastNameTextBox" runat="server" Width="200"></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter your last name"
                        ControlToValidate="lastNameTextBox" Display="Dynamic" ValidationGroup="commentValidation"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Email
                </td>
                <td>
                    <asp:TextBox ID="emailTextBox" runat="server" Width="200"></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter your email id"
                        ControlToValidate="emailTextBox" Display="Dynamic" ValidationGroup="commentValidation"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    City
                </td>
                <td>
                    <asp:DropDownList ID="cityDropDownList" runat="server" OnSelectedIndexChanged="cityDropDownList_SelectedIndexChanged"
                        AutoPostBack="true" Width="205">
                    </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please select your city"
                        ControlToValidate="cityDropDownList" Display="Dynamic" ValidationGroup="commentValidation"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    League
                </td>
                <td>
                    <asp:DropDownList ID="leagueDropDownList" runat="server" Width="205">
                    </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please select your league"
                        ControlToValidate="leagueDropDownList" Display="Dynamic" ValidationGroup="commentValidation"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    Comments/Questions
                </td>
                <td>
                    <asp:TextBox ID="commentsTextBox" runat="server" Rows="10" TextMode="MultiLine" Columns="30"
                        Width="200"></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please enter your comments"
                        ControlToValidate="commentsTextBox" Display="Dynamic" ValidationGroup="commentValidation"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <telerik:RadCaptcha runat="server" ID="radCaptcha" Display="Dynamic" ForeColor="Red"
                        ValidationGroup="commentValidation" ErrorMessage="Incorrect code entered." Width="155px">
                    </telerik:RadCaptcha>
                    <br />
                    <asp:Button ID="submitButton" runat="server" Text="Submit" OnClick="submitButton_Click"
                        ValidationGroup="commentValidation" />
                </td>
            </tr>
        </table>
        <p align="center">
            <asp:Label ID="statusLabel" runat="server" Text="" ForeColor="Red"></asp:Label></p>
    </div>
</div>
<div style="width: 400px; float: right">
    <h1>
        Subscribe to our mailing list
    </h1>
    <div class="greyContent" style="width: 400px; float: right">
        Interested in our site/league, but dont't have time right now. Tell us your email
        Id and we'll keep you posted on all the important news. We won't spam your inbox
        - It's a promise!!<br />
        <br />
        <table>
            <tr>
                <td>
                    Email Address&nbsp;&nbsp;
                </td>
                <td>
                    <asp:TextBox ID="mailingListEmailTextBox" runat="server" Width="200"></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Please enter your email address"
                        ControlToValidate="mailingListEmailTextBox" Display="Dynamic" ValidationGroup="mailingListValidation"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Your City
                </td>
                <td>
                    <asp:TextBox ID="cityTextBox" runat="server" Width="200"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td align="center">
                    <telerik:RadCaptcha runat="server" ID="radCaptcha1" Display="Dynamic" ForeColor="Red"
                        ValidationGroup="mailingListValidation" ErrorMessage="Incorrect code entered."
                        Width="155px">
                    </telerik:RadCaptcha>
                    <br />
                    <asp:Button ID="mailingListButton" runat="server" Text="Submit" ValidationGroup="mailingListValidation"
                        OnClick="mailingListButton_Click" />
                </td>
            </tr>
        </table>
        <p align="center">
            <asp:Label ID="mailingListStatusLabel" runat="server" Text="" ForeColor="Red"></asp:Label></p>
    </div>
</div>
<div style="clear: both">
    <p>
    </p>
</div>
