<%@ Page  Title="Flexible Tennis League | Denver, CO | League Info" Language="C#" MasterPageFile="~/Denver/ControlPanel.Master" AutoEventWireup="true" CodeBehind="LeagueInfo.aspx.cs" Inherits="FlexibleTennisLeague.Denver.LeagueInfo" %>
<%@ Register Src="~/UserControls/LeagueInfoControl.ascx" TagName="LeagueInfo" TagPrefix="LI"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<LI:LeagueInfo ID="LeagueInfo1" runat="server"></LI:LeagueInfo>
</asp:Content>
