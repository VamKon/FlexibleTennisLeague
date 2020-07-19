<%@ Page  Title="Flexible Tennis League | Dallas, TX | My Profile" Language="C#" MasterPageFile="~/Dallas/ControlPanel.master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="FlexibleTennisLeague.Dallas.Users.Profile" %>
<%@ Register Src="~/UserControls/ProfileControl.ascx" TagName="ProfileControl" TagPrefix="PC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<PC:ProfileControl ID="ProfileControl1" runat="server" />
</asp:Content>
