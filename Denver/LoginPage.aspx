<%@ Page  Title="Flexible Tennis League | Denver, CO | Login" Language="C#" MasterPageFile="~/Denver/FlexibleTennisLeague.Master" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="FlexibleTennisLeague.Denver.LoginPage" %>
<%@ Register Src="../UserControls/LoginForm.ascx" TagName="LoginForm" TagPrefix="LF"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="contentGreyTopBorder">
        <div style="float: left">
            <h1>
                EXISTING USERS :: LOGIN
            </h1>
            <div class="tennisBallBanner" align="right">
               <LF:LoginForm ID="LoginForm1" runat="server" PasswordRecoveryURL="~/Denver/RecoverPassword.aspx"></LF:LoginForm><br />
            </div>
            
        </div>
        <div class="contentSplitter" style="height: 300px; float: left">
        </div>
        <div style="float: right;width:410px;">
        Get all the information and updates you need directly in Facebook!
           <script type="text/javascript" src="http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php/en_US"></script><script type="text/javascript">FB.init("2cf3c74fa1bbb36bae3fc63b5c9888f6");</script><fb:fan profile_id="338569539665" stream="0" connections="10" logobar="0" width="300"></fb:fan><div style="font-size:8px; padding-left:10px"><a href="http://www.facebook.com/pages/Denver-CO/Denver-Flexible-Tennis-League/338569539665">Denver Flexible Tennis League</a> on Facebook</div>
        </div>
    </div>
    <div style="height: 10px;">
    </div>
</asp:Content>
