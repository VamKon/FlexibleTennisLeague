<%@ Page  Title="Flexible Tennis League | Login" Language="C#" MasterPageFile="~/FlexibleTennisLeague.Master" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="FlexibleTennisLeague.LoginPage" %>
<%@ Register Src="~/UserControls/LoginForm.ascx" TagName="LoginForm" TagPrefix="LF"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="contentGreyTopBorder">
        <div style="float: left">
            <h1>
                EXISTING USERS :: LOGIN
            </h1>
            <div class="tennisBallBanner" align="right">
               <LF:LoginForm ID="LoginForm1" runat="Server"></LF:LoginForm>
            </div>
        </div>
        <div class="contentSplitter" style="height: 300px; float: left">
        </div>
        <div style="float: right;width:410px;">
            <h1>
                NEW USERS :: SIGN UP
            </h1>
            <div class="greyGradient" style="width:400px;">
                :: Enjoy the game you love at your convenience.<br />
                :: Meet and play with other Tennis enthusiasts.<br />
                :: Compete for prizes in every division.<br />
                :: Track your progress throughout the season.<br />
                :: Set your availability and be contacted when you want.<br />
                :: Find Tennis courts and get driving directions.<br />
                <br />
                <asp:Button ID="signUpButton" runat="server" Text="Click Here to Sign Up" 
                    CssClass="button" PostBackUrl="Locations.aspx" />
            </div>
        </div>
    </div>
    <div style="height: 10px;">
    </div>
</asp:Content>
