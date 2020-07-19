<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="JoinMailingList.ascx.cs"
    Inherits="FlexibleTennisLeague.UserControls.JoinMailingList" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<div class="tennisBallBannerSingle" align="right">
    <table>
        <tr>
            <td>
                <b>Email Id</b>:&nbsp;&nbsp;
            </td>
            <td>
                <asp:TextBox ID="mailingListEmailTextBox" runat="server" Width="200"></asp:TextBox><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Please enter your email address"
                    ControlToValidate="mailingListEmailTextBox" Display="Dynamic" ValidationGroup="mailingListValidation"></asp:RequiredFieldValidator>
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

