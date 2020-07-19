<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RecoverPasswordControl.ascx.cs" Inherits="FlexibleTennisLeague.UserControls.RecoverPasswordControl" %>
<asp:PasswordRecovery ID="PasswordRecovery1" runat="server" 
    MembershipProvider="MyMembershipProvider" 
    onsendingmail="PasswordRecovery1_SendingMail">
    <MailDefinition BodyFileName="~/RecoverPasswordMailBody.txt" 
        From="support@flexibletennisleague.com" 
        Subject="FlexibleTennisLeague - Recover Password">
    </MailDefinition>
    <UserNameTemplate>
        <table border="0" cellpadding="1" cellspacing="0" 
            style="border-collapse:collapse;">
            <tr>
                <td>
                    <table border="0" cellpadding="0">
                        <tr>
                            <td align="center" colspan="2">
                                Enter your User Name to receive your password.<br /><br /></td>
                        </tr>
                        <tr>
                            <td align="left">
                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Email 
                                Id:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="UserName" runat="server" Width="200px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                    ControlToValidate="UserName" ErrorMessage="User Name is required." 
                                    ToolTip="User Name is required." ValidationGroup="ctl00$PasswordRecovery1">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" style="color:Red;">
                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                            <br />
                                <asp:Button ID="SubmitButton" runat="server" CommandName="Submit" 
                                    Text="Recover Password" ValidationGroup="ctl00$PasswordRecovery1" CssClass="button"/>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </UserNameTemplate>
</asp:PasswordRecovery>
