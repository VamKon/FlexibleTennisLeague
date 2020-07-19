<%@ Page Title="Flexible Tennis League | San Jose, CA | How It Works" Language="C#" MasterPageFile="~/SanJose/FlexibleTennisLeague.Master"
    AutoEventWireup="true" CodeBehind="HowItWorks.aspx.cs" Inherits="FlexibleTennisLeague.SanJose.HowItWorks" %>

<%@ Register Src="~/UserControls/HowItWorksControl.ascx" TagName="HowItWorks" TagPrefix="HIW" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="contentGreyTopBorder" style="padding-top: 20px;">
        <HIW:HowItWorks ID="HowItWorks1" runat="server"></HIW:HowItWorks>
        <p align="center"><a href="Register.aspx"><img src="../Resources/Images/Sign_Up.jpg" border="0" alt="Sign Up"/></a></p>
    </div>
</asp:Content>
