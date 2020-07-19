<%@ Page  Title="Flexible Tennis League | Houston, TX | League Info" Language="C#" MasterPageFile="~/Houston/ControlPanel.Master" AutoEventWireup="true" CodeBehind="LeagueInfo.aspx.cs" Inherits="FlexibleTennisLeague.Houston.LeagueInfo" %>
<%@ Register Src="~/UserControls/LeagueInfoControl.ascx" TagName="LeagueInfo" TagPrefix="LI"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<LI:LeagueInfo ID="LeagueInfo1" runat="server"></LI:LeagueInfo>
</asp:Content>
