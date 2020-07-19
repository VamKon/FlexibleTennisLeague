<%@ Page Title="Flexible Tennis League | Dallas, TX | My League" Language="C#" MasterPageFile="~/Dallas/ControlPanel.Master"
    AutoEventWireup="true" CodeBehind="League.aspx.cs" Inherits="FlexibleTennisLeague.Dallas.Users.League" %>

<%@ Register Src="~/UserControls/LeagueControl.ascx" TagName="LeagueControl" TagPrefix="LC" %>
<%@ Register Src="~/UserControls/UserLocations.ascx" TagName="LocationsControl" TagPrefix="LOC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <LC:LeagueControl ID="LeagueControl1" runat="server">
    </LC:LeagueControl>
    <p></p>
    <LOC:LocationsControl ID="LocationsControl1" runat="server">
    </LOC:LocationsControl >
</asp:Content>
