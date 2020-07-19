<%@ Page  Title="Flexible Tennis League | Los Angeles, CA | League Info" Language="C#" MasterPageFile="~/LosAngeles/ControlPanel.Master" AutoEventWireup="true" CodeBehind="LeagueInfo.aspx.cs" Inherits="FlexibleTennisLeague.LosAngeles.LeagueInfo" %>
<%@ Register Src="~/UserControls/LeagueInfoControl.ascx" TagName="LeagueInfo" TagPrefix="LI"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<LI:LeagueInfo ID="LeagueInfo1" runat="server"></LI:LeagueInfo>
</asp:Content>
