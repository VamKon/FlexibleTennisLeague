<%@ Page  Title="Flexible Tennis League | Recover Password" Language="C#" MasterPageFile="~/FlexibleTennisLeague.Master" AutoEventWireup="true" CodeBehind="RecoverPassword.aspx.cs" Inherits="FlexibleTennisLeague.RecoverPassword" %>
<%@ Register Src="~/UserControls/RecoverPasswordControl.ascx" TagName="RecoverPassword" TagPrefix="RP"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div style="float: left">
            <p class="heading">
                ::Recover your Password
            </p>
            <div class="tennisBallBanner" align="right">
               <RP:RecoverPassword ID="RecoverPassword1" runat="server"></RP:RecoverPassword>
            </div>
        </div>
        <div class="contentSplitter" style="height: 200px; float: left">
        </div>
        <div style="float: right;width:410px;">
            <p class="heading">
                ::Recover Password Help
            </p>
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
