<%@ Page  Title="Flexible Tennis League | Dallas, TX | Player Profile" Language="C#" MasterPageFile="~/Dallas/ControlPanel.master" AutoEventWireup="true" CodeBehind="PublicProfile.aspx.cs" Inherits="FlexibleTennisLeague.Dallas.Users.PublicProfile" %>
<%@ Register Src="~/UserControls/PublicProfileControl.ascx" TagName="PublicProfileControl" TagPrefix="PPC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<PPC:PublicProfileControl ID="PublicProfileControl1" runat="server"></PPC:PublicProfileControl>
</asp:Content>
