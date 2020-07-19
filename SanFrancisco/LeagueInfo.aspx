<%@ Page  Title="Flexible Tennis League | San Francisco, CA | League Info" Language="C#" MasterPageFile="~/SanFrancisco/ControlPanel.Master" AutoEventWireup="true" CodeBehind="LeagueInfo.aspx.cs" Inherits="FlexibleTennisLeague.SanFrancisco.LeagueInfo" %>
<%@ Register Src="~/UserControls/LeagueInfoControl.ascx" TagName="LeagueInfo" TagPrefix="LI"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<LI:LeagueInfo ID="LeagueInfo1" runat="server"></LI:LeagueInfo>
</asp:Content>
