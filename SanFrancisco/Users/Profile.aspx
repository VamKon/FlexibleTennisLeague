<%@ Page  Title="Flexible Tennis League | San Francisco, CA | My Profile" Language="C#" MasterPageFile="~/SanFrancisco/ControlPanel.master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="FlexibleTennisLeague.SanFrancisco.Users.Profile" %>
<%@ Register Src="~/UserControls/ProfileControl.ascx" TagName="ProfileControl" TagPrefix="PC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<PC:ProfileControl ID="ProfileControl1" runat="server"/>
</asp:Content>
