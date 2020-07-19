<%@ Page  Title="Flexible Tennis League | San Jose, CA | Recover Password" Language="C#" MasterPageFile="~/SanJose/FlexibleTennisLeague.Master" AutoEventWireup="true" CodeBehind="RecoverPassword.aspx.cs" Inherits="FlexibleTennisLeague.SanJose.RecoverPassword" %>
<%@ Register Src="~/UserControls/RecoverPasswordControl.ascx" TagName="RecoverPassword" TagPrefix="RP"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div style="float: left">
            <h1>
                ::Recover your Password
            </h1>
            <div class="tennisBallBanner" align="right">
               <RP:RecoverPassword ID="RecoverPassword1" runat="server"></RP:RecoverPassword>
            </div>
        </div>
        <div class="contentSplitter" style="height: 200px; float: left">
        </div>
        <div style="float: right;width:410px;">
            <h1>
                ::Recover Password Help
            </h1>
            <div class="greyGradient" style="width:400px;">
                :: Enter your email id and click the "Recover Password" button.<br />
                :: If your password is recovered succesfully you will be redirected to the login page.<br />
                :: Please check your email for the password.<br />
                :: Please enter your password at the login page.<br />
                <br />
            </div>
        </div>
    </div>
    <div style="height: 10px;">
    </div>
</asp:Content>
