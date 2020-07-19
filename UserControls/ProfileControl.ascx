<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProfileControl.ascx.cs"
    Inherits="FlexibleTennisLeague.UserControls.ProfileControl" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<div style="width: 840px">
    <br />
    <div class="greyContent">
        <p class="heading">
            :: Upcoming Leagues
        </p>
        <asp:Label ID="upcomingLeagueLabel" runat="server" Text=""></asp:Label>&nbsp;&nbsp;<asp:Button
            ID="upcomingLeagueButton" runat="server" Text="Subscribe Me" Visible="false"
            CssClass="button" OnClick="upcomingLeagueButton_Click" />
    </div>
</div>
<div style="width: 840px; clear: both">
    <br />
    <div class="greyContent" style="width: 400px; float: left">
        <p class="heading">
            :: Basic Profile
        </p>
        <table border="0">
            <tr>
                <td class="signUpBold">
                    <asp:Label ID="firstNameLabel" runat="server" AssociatedControlID="firstNameTextBox">First Name:</asp:Label>
                </td>
                <td class="signUp">
                    <asp:TextBox ID="firstNameTextBox" runat="server" class="signUp"></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="firstNameTextBox"
                        ErrorMessage="First Name is required." ToolTip="First Name is required." ValidationGroup="CreateUserWizard1"
                        Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="signUpBold">
                    <asp:Label ID="lastNameLabel" runat="server" AssociatedControlID="lastNameTextBox">Last Name:</asp:Label>
                </td>
                <td class="signUp">
                    <asp:TextBox ID="lastNameTextBox" runat="server" class="signUp"></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="lastNameTextBox"
                        ErrorMessage="Last Name is required." ToolTip="Last Name is required." ValidationGroup="CreateUserWizard1"
                        Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="signUpBold">
                    <asp:Label ID="zipLabel" runat="server" AssociatedControlID="zipTextBox">Zip:</asp:Label>
                </td>
                <td class="signUp">
                    <asp:TextBox ID="zipTextBox" runat="server" class="signUp"></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="zipTextBox"
                        ErrorMessage="Zip is required." ToolTip="Zip is required." ValidationGroup="CreateUserWizard1"
                        Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="signUpBold">
                    <asp:Label ID="phoneLabel" runat="server" AssociatedControlID="phoneTextBox">Phone (xxx)xxx-xxxx:</asp:Label>
                </td>
                <td class="signUp">
                    <asp:TextBox ID="phoneTextBox" runat="server" class="signUp"></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="phoneTextBox"
                        ErrorMessage="Phone is required." ToolTip="Phone is required." ValidationGroup="CreateUserWizard1"
                        Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="signUpBold">
                    <asp:Label ID="homeCourtLabel" runat="server" AssociatedControlID="homeCourtDropDownList">Home Court:</asp:Label>
                </td>
                <td class="signUp">
                    <asp:DropDownList ID="homeCourtDropDownList" runat="server" Width="207px" Enabled="false">
                    </asp:DropDownList>
                    <br />
                    <a href="../ContactUs.aspx">Contact admin to change court</a>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="homeCourtDropDownList"
                        ErrorMessage="Please select a home court." ToolTip="Please select a home court."
                        ValidationGroup="CreateUserWizard1" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="signUpBold">
                    <asp:Label ID="nTRPLabel" runat="server" AssociatedControlID="nTRPDropDownList">NTRP Ranking:</asp:Label>
                </td>
                <td class="signUp">
                    <asp:DropDownList ID="nTRPDropDownList" runat="server" Width="165px">
                        <asp:ListItem Value=""></asp:ListItem>
                        <asp:ListItem Value="1">1.0</asp:ListItem>
                        <asp:ListItem Value="1.5">1.5</asp:ListItem>
                        <asp:ListItem Value="2">2.0</asp:ListItem>
                        <asp:ListItem Value="2.5">2.5</asp:ListItem>
                        <asp:ListItem Value="3">3.0</asp:ListItem>
                        <asp:ListItem Value="3.5">3.5</asp:ListItem>
                        <asp:ListItem Value="4.0">4.0</asp:ListItem>
                        <asp:ListItem Value="4.5">4.5</asp:ListItem>
                        <asp:ListItem Value="5">5.0</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;<asp:HyperLink ID="nTRPHyperLink" NavigateUrl="~/Resources/Documents/NTRPRankings.pdf"
                        Target="_blank" runat="server">Help</asp:HyperLink>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="nTRPDropDownList"
                        ErrorMessage="Please select a ranking." ToolTip="Please select a ranking." ValidationGroup="CreateUserWizard1"
                        Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
        <br />
        <asp:Button ID="basicProfileSaveButton" runat="server" Text="Save Changes" CssClass="button"
            OnClick="basicProfileSaveButton_Click" />&nbsp;</div>
    <div style="width: 400px; float: right" class="greyContent" align="center">
        <p class="heading" align="left">
            :: Profile Image
        </p>
        <asp:Image ID="profileImage" runat="server" ImageUrl="~/Resources/Images/NoProfile.gif"
            ImageAlign="Middle" /><br />
        <asp:LinkButton ID="imageUploadLinkButton" runat="server">Change Profile Image</asp:LinkButton>
    </div>
</div>
<div style="width: 840px; clear: both">
    <br />
    <div class="greyContent" style="width: 400px; float: left">
        <p class="heading">
            :: Tennis Profile
        </p>
        <table>
            <tr>
                <td class="signUpBold">
                    Interested In:
                </td>
                <td class="signUp">
                    <asp:DropDownList ID="playTypeDropDownList" runat="server" Width="207px">
                        <asp:ListItem Value=""></asp:ListItem>
                        <asp:ListItem Value="Singles" Selected="True">Singles</asp:ListItem>
                        <asp:ListItem Value="Doubles">Doubles</asp:ListItem>
                        <asp:ListItem Value="Both">Both</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="playTypeRequired" runat="server" ControlToValidate="playTypeDropDownList"
                                            ErrorMessage="Please indicate your preference." ToolTip="Please indicate your preference." ValidationGroup="TennisProfile"
                                            Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="signUpBold">
                    Age Group:
                </td>
                <td class="signUp">
                    <asp:DropDownList ID="ageGroupDropDownList" runat="server" Width="207px">
                        <asp:ListItem Value=""></asp:ListItem>
                        <asp:ListItem Value="15-20">15 - 20</asp:ListItem>
                        <asp:ListItem Value="21-25">21 - 25</asp:ListItem>
                        <asp:ListItem Value="26-30">26 - 30</asp:ListItem>
                        <asp:ListItem Value="31-35">31 - 35</asp:ListItem>
                        <asp:ListItem Value="36-40">36 - 40</asp:ListItem>
                        <asp:ListItem Value="41-45">41 - 45</asp:ListItem>
                        <asp:ListItem Value="46-50">46 - 50</asp:ListItem>
                        <asp:ListItem Value="51-55">51 - 55</asp:ListItem>
                        <asp:ListItem Value="56-60">56 - 60</asp:ListItem>
                        <asp:ListItem Value="61-65">61 - 65</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="signUpBold">
                    Racquet Hand:
                </td>
                <td class="signUp">
                    <asp:DropDownList ID="racquetHandDropDownList" runat="server" Width="207px">
                        <asp:ListItem Value=""></asp:ListItem>
                        <asp:ListItem Value="Left">Left Hand</asp:ListItem>
                        <asp:ListItem Value="Right">Right Hand</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="signUpBold">
                    Favorite Shot:
                </td>
                <td class="signUp">
                    <asp:DropDownList ID="favoriteShotDropDownList" runat="server" Width="207px">
                        <asp:ListItem Value=""></asp:ListItem>
                        <asp:ListItem Value="Backhand">Backhand Groundstroke</asp:ListItem>
                        <asp:ListItem Value="Drop">Drop Shot</asp:ListItem>
                        <asp:ListItem Value="Forehand">Forehand Groundstroke</asp:ListItem>
                        <asp:ListItem Value="HalfVolley">Half Volley</asp:ListItem>
                        <asp:ListItem Value="Lob">Lob</asp:ListItem>
                        <asp:ListItem Value="Serve">Serve</asp:ListItem>
                        <asp:ListItem Value="Smash">Smash</asp:ListItem>
                        <asp:ListItem Value="Volley">Volley</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="signUpBold">
                    Your Racquet Model:
                </td>
                <td class="signUp">
                    <asp:TextBox ID="racquetTextBox" runat="server" class="signUp"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="signUpBold">
                    Facebook Profile:
                </td>
                <td class="signUp">
                    <asp:TextBox ID="facebookTextBox" runat="server" class="signUp"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="signUpBold">
                    LinkedIn Profile:
                </td>
                <td class="signUp">
                    <asp:TextBox ID="linkedInTextBox" runat="server" class="signUp"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="signUpBold">
                    MySpace Profile:
                </td>
                <td class="signUp">
                    <asp:TextBox ID="mySpaceTextBox" runat="server" class="signUp"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="signUpBold">
                    Orkut Profile:
                </td>
                <td class="signUp">
                    <asp:TextBox ID="orkutTextBox" runat="server" class="signUp"></asp:TextBox>
                </td>
            </tr>
        </table>
        <br />
        <asp:Button ID="tennisProfileSaveButton" runat="server" Text="Save Changes" CssClass="button"
            OnClick="tennisProfileSaveButton_Click" ValidationGroup="TennisProfile"/>
    </div>
    <div class="greyContent" style="width: 400px; float: right">
        <p class="heading">
            :: Change Password
        </p>
        <asp:ChangePassword ID="ChangePassword1" runat="server" MembershipProvider="MyMembershipProvider"
            ChangePasswordFailureText="Password incorrect or New Password invalid.<br/> New Password length minimum: {0}. "
            OnSendingMail="ChangePassword1_SendingMail">
            <MailDefinition BodyFileName="~/RecoverPasswordMailBody.txt" From="support@flexibletennisleague.com"
                Subject="FlexibleTennisLeague - Change Password">
            </MailDefinition>
            <ChangePasswordTemplate>
                <table border="0" cellpadding="1" cellspacing="0" style="border-collapse: collapse;">
                    <tr>
                        <td>
                            <table border="0" cellpadding="0">
                                <tr>
                                    <td align="left" class="signUpBold">
                                        <asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword">Password:</asp:Label>
                                    </td>
                                    <td class="signUp">
                                        <asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password" class="signUp"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword"
                                            ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="ChangePassword1"
                                            Display="Dynamic">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" class="signUpBold">
                                        <asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword">New Password:</asp:Label>
                                    </td>
                                    <td class="signUp">
                                        <asp:TextBox ID="NewPassword" runat="server" TextMode="Password" class="signUp"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword"
                                            ErrorMessage="New Password is required." ToolTip="New Password is required."
                                            ValidationGroup="ChangePassword1" Display="Dynamic">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" class="signUpBold">
                                        <asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword">Confirm New Password:</asp:Label>
                                    </td>
                                    <td class="signUp">
                                        <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password" class="signUp"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword"
                                            ErrorMessage="Confirm New Password is required." ToolTip="Confirm New Password is required."
                                            ValidationGroup="ChangePassword1" Display="Dynamic">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
                                        <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword"
                                            ControlToValidate="ConfirmNewPassword" Display="Dynamic" ErrorMessage="The Confirm New Password must match the New Password entry."
                                            ValidationGroup="ChangePassword1"></asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2" style="color: Red;">
                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <br />
                                        <asp:Button ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword"
                                            Text="Change Password" ValidationGroup="ChangePassword1" CssClass="button" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2" style="color: Black;">
                                        <br />
                                        <asp:Literal ID="Literal1" runat="server" EnableViewState="False">You will be redirected to the login page<br />&nbsp;so that you can try out your new password!</asp:Literal>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ChangePasswordTemplate>
        </asp:ChangePassword>
    </div>
</div>
<div style="clear: both">
    <p>
    </p>
</div>
<div class="greyContent">
    <p class="heading">
        :: Communication Preferences
    </p>
    <asp:CheckBox ID="postEmailCheckBox" runat="server" Text="Send email for message
    posts that I have participated in." /><br />
    <br />
    <asp:Button ID="communicationButton" runat="server" Text="Save Changes" CssClass="button"
        OnClick="communicationButton_Click" />
</div>
<telerik:RadWindow ID="photoRadWindow1" runat="server" DestroyOnClose="True" KeepInScreenBounds="True"
    Modal="True" Animation="None" VisibleStatusbar="False" Width="510px" Height="310px"
    Behavior="Default" Behaviors="Close" VisibleOnPageLoad="False" OpenerElementID="ctl00_ctl00_ContentPlaceHolder1_ContentPlaceHolder1_ProfileControl1_imageUploadLinkButton">
</telerik:RadWindow>
<telerik:RadWindowManager runat="server">
</telerik:RadWindowManager>
