<%@ Page  Title="Flexible Tennis League | San Francisco, CA | Player Profile" Language="C#" MasterPageFile="~/SanFrancisco/ControlPanel.master" AutoEventWireup="true" CodeBehind="PublicProfile.aspx.cs" Inherits="FlexibleTennisLeague.SanFrancisco.Users.PublicProfile" %>
<%@ Register Src="~/UserControls/PublicProfileControl.ascx" TagName="PublicProfileControl" TagPrefix="PPC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<PPC:PublicProfileControl ID="PublicProfileControl1" runat="server"></PPC:PublicProfileControl>
</asp:Content>
