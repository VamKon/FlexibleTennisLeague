<%@ Page  Title="Flexible Tennis League | San Jose, CA | My Profile" Language="C#" MasterPageFile="~/SanJose/ControlPanel.master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="FlexibleTennisLeague.SanJose.Users.Profile" %>
<%@ Register Src="~/UserControls/ProfileControl.ascx" TagName="ProfileControl" TagPrefix="PC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<PC:ProfileControl ID="ProfileControl1" runat="server"/>
</asp:Content>
