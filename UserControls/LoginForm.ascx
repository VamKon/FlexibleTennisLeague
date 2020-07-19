<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoginForm.ascx.cs" Inherits="FlexibleTennisLeague.UserControls.LoginForm" %>
<asp:Login ID="Login1" runat="server" onloggedin="Login1_LoggedIn">
                    <LayoutTemplate>
                        <table border="0" cellpadding="1" cellspacing="0" style="border-collapse: collapse;">
                            <tr>
                                <td>
                                    <table border="0" cellpadding="0">
                                        <tr>
                                            <td align="center" colspan="2">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" Style="font-weight: bold">Email:</asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="UserName" runat="server" Width="200px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                                    ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" Style="font-weight: bold">Password:&nbsp;&nbsp;</asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="Password" runat="server" TextMode="Password" Width="200px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                                    ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="left">
                                                <asp:CheckBox ID="RememberMe" runat="server" Text="Remember me next time." />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2" style="color: Red;">
                                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2">
                                                <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In" ValidationGroup="Login1"
                                                    CssClass="button" /><br />
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" colspan="2">
                                                <asp:LinkButton ID="forgotPasswordLinkButton" runat="server">Forgot your password? Click here.</asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                </asp:Login>