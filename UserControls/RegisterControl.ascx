<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RegisterControl.ascx.cs"
    Inherits="FlexibleTennisLeague.UserControls.RegisterControl" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
</telerik:RadAjaxManagerProxy>
<div class="contentGreyTopBorder">
    <div style="float: left">
        <p class="heading">
            :: Sign Up For Your New Account
        </p>
        <div class="greyGradient" style="padding-left: 5px; padding-top: 5px;">
            <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" ContinueButtonText="Join"
                CreateUserButtonText="Join" OnCreatedUser="CreateUserWizard1_CreatedUser" OnCreatingUser="CreateUserWizard1_CreatingUser">
                <CreateUserButtonStyle />
                <WizardSteps>
                    <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                        <ContentTemplate>
                            <table border="0">
                                <tr>
                                    <td class="signUpBold">
                                        <asp:Label ID="firstNameLabel" runat="server" AssociatedControlID="UserName">First Name:</asp:Label>
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
                                        <asp:Label ID="lastNameLabel" runat="server" AssociatedControlID="UserName">Last Name:</asp:Label>
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
                                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Email Id:</asp:Label>
                                    </td>
                                    <td class="signUp">
                                        <asp:TextBox ID="UserName" runat="server" class="signUp"></asp:TextBox><br />
                                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                            ErrorMessage="Email Id is required." ToolTip="Email Id is required." ValidationGroup="CreateUserWizard1"
                                            Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Please enter a valid email id."
                                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="CreateUserWizard1"
                                            Display="Dynamic" ControlToValidate="UserName"></asp:RegularExpressionValidator><asp:TextBox
                                                ID="Email" runat="server" Visible="False" Width="1px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="signUpBold">
                                        <asp:Label ID="zipLabel" runat="server" AssociatedControlID="ConfirmPassword">Zip:</asp:Label>
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
                                        <asp:Label ID="LeagueCity" runat="server" AssociatedControlID="leagueCityDropDownList">Home Court City:</asp:Label>
                                    </td>
                                    <td class="signUp">
                                        <asp:DropDownList ID="leagueCityDropDownList" runat="server" Width="207px" AutoPostBack="True"
                                            OnSelectedIndexChanged="leagueCityDropDownList_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="leagueCityDropDownList"
                                            ErrorMessage="Please select a city." ToolTip="Please select a city." ValidationGroup="CreateUserWizard1"
                                            Display="Dynamic"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="signUpBold">
                                        <asp:Label ID="homeCourtLabel" runat="server" AssociatedControlID="homeCourtDropDownList">Home Court:</asp:Label>
                                    </td>
                                    <td class="signUp">
                                        <asp:DropDownList ID="homeCourtDropDownList" runat="server" Width="207px">
                                        </asp:DropDownList>
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
                                        <asp:DropDownList ID="nTRPDropDownList" runat="server" Width="150px">
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
                                <tr>
                                    <td class="signUpBold">
                                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                    </td>
                                    <td class="signUp">
                                        <asp:TextBox ID="Password" runat="server" TextMode="Password" class="signUp"></asp:TextBox><br />
                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                            ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="CreateUserWizard1"
                                            Display="Dynamic"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="signUpBold">
                                        <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Confirm Password:</asp:Label>
                                    </td>
                                    <td class="signUp">
                                        <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" class="signUp"></asp:TextBox><br />
                                        <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword"
                                            ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required."
                                            ValidationGroup="CreateUserWizard1" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password"
                                            ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match."
                                            ValidationGroup="CreateUserWizard1"></asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="signUpBold">
                                        <asp:Label ID="Label2" runat="server" AssociatedControlID="referrerEmailTextBox">Referred by a friend?</asp:Label><br />
                                        <asp:Label ID="Label3" runat="server" AssociatedControlID="referrerEmailTextBox">Please enter email Id</asp:Label>
                                    </td>
                                    <td class="signUp">
                                        <asp:TextBox ID="referrerEmailTextBox" runat="server" class="signUp"></asp:TextBox><br />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Please enter a valid email id."
                                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="CreateUserWizard1"
                                            Display="Dynamic" ControlToValidate="referrerEmailTextBox"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <br />
                                        <asp:CheckBox ID="agreeCheckBox" runat="server" /><asp:HyperLink ID="agreeHyperLink"
                                            runat="server" NavigateUrl="~/TermsAndConditions.aspx" Target="_blank">I agree to FlexibleTennisLeague.com's terms and conditions</asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="signUp" colspan="2" style="color: Red;">
                                        <asp:Literal ID="ErrorMessage" runat="server"></asp:Literal>
                                        <asp:Label ID="errorLabel" runat="server" ForeColor="Red" Text="Label" Visible="False"></asp:Label><br />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <telerik:RadCaptcha runat="server" ID="radCaptcha" Display="Dynamic" ForeColor="Red"
                                            ValidationGroup="CreateUserWizard1" ErrorMessage="Incorrect code entered." Width="155px">
                                        </telerik:RadCaptcha>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                        <CustomNavigationTemplate>
                            <table border="0" cellspacing="5" style="width: 100%; height: 100%;">
                                <tr align="right">
                                    <td align="center" colspan="0">
                                        <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" CssClass="button"
                                            Text="Join" ValidationGroup="CreateUserWizard1" />
                                    </td>
                                </tr>
                            </table>
                        </CustomNavigationTemplate>
                    </asp:CreateUserWizardStep>
                    <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server" OnActivate="CompleteWizardStep1_Activate">
                        <ContentTemplate>
                            <table border="0">
                                <tr>
                                    <td align="center" colspan="2">
                                        Complete
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Your account has been successfully created.
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2">
                                        <asp:Button ID="ContinueButton" runat="server" CausesValidation="False" CommandName="Continue"
                                            Text="Join" ValidationGroup="CreateUserWizard1" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:CompleteWizardStep>
                </WizardSteps>
            </asp:CreateUserWizard>
        </div>
    </div>
    <div class="contentSplitter" style="height: 300px; float: left">
    </div>
    <div style="float: right; padding-left: 6px; width: 400px;">
        <p class="heading">
            :: Sign Up Help
        </p>
        <div class="greyGradient" style="padding: 5px; width: 400px;">
            <span class="bold">Email Id</span> :: Your email is also your login. Don't worry
            we will never spam your inbox or sell your email Id.<br />
            <span class="bold">Phone</span> :: Your phone and email are only visible to other
            league members who are signed in to the website. They are the primary of means of
            communication between the members.<br />
            <span class="bold">Home Court City</span> :: Please pick the city where you live
            so that we can filter the Tennis courts to show you the courts closer to you<br />
            <span class="bold">Home Court</span> :: Please pick a court that's convinient for
            you. This allows the system to grant you points for playing more away games. Please
            look at the point system for more details. If you don't see the court you are looking
            for please pick any court and we can change it before you play your first match.<br />
            <span class="bold">NTRP Ranking</span> :: Please pick a ranking that you feel is
            most appropriate for your Tennis skills from the <a href="../Resources/Documents/NTRPRankings.pdf"
                target="_blank">USTA Guide</a>. Picking the right rating ensures that you will
            be placed in a pool with players of similar skill level, which makes for more competitive
            matches.<br />
            <span class="bold">Referred by a friend?</span> :: Please enter your friend's email
            Id, so that we can give him credit for referring you.<br />
        </div>
    </div>
</div>
<div style="clear: both; min-height: 225px; z-index: -100; position: relative">
</div>
