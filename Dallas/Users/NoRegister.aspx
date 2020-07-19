<%@ Page Title="" Language="C#" MasterPageFile="~/Dallas/FlexibleTennisLeague.Master" AutoEventWireup="true" CodeBehind="NoRegister.aspx.cs" Inherits="FlexibleTennisLeague.Dallas.Users.NoRegister" %>
<%@ Register Src="~/UserControls/JoinMailingList.ascx" TagName="JoinMailingList" TagPrefix="JML" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="contentGreyTopBorder" style="padding-top: 20px;">
<h1>Thank you for your interest in Flexible Tennis League.</h1>
<h2>We currently don't have an active league in the Dallas area. We are hoping to start a league this fall.</h2>
<h2>Please do leave us your email Id and we will get in touch with you when next season starts. Don't worry we won't spam your inbox - it's a promise.</h2>
<h2>In the mean time please checkout our <a href="http://blog.flexibletennisleague.com">BLOG</a> for the latest news from the world of tennis and the Flexible Tennis League</h2>
<JML:JoinMailingList ID="JoinMailingList1" runat="server"></JML:JoinMailingList>
</div>
</asp:Content>
