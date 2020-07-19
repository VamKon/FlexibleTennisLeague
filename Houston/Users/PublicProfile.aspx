<%@ Page  Title="Flexible Tennis League | Houston, TX | Player Profile" Language="C#" MasterPageFile="~/Houston/ControlPanel.master" AutoEventWireup="true" CodeBehind="PublicProfile.aspx.cs" Inherits="FlexibleTennisLeague.Houston.Users.PublicProfile" %>
<%@ Register Src="~/UserControls/PublicProfileControl.ascx" TagName="PublicProfileControl" TagPrefix="PPC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<PPC:PublicProfileControl ID="PublicProfileControl1" runat="server"></PPC:PublicProfileControl>
</asp:Content>
