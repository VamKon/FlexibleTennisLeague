<%@ Page  Title="Flexible Tennis League | Denver, CO | My Calendar" Language="C#" MasterPageFile="~/Denver/ControlPanel.master" AutoEventWireup="true" CodeBehind="Calendar.aspx.cs" Inherits="FlexibleTennisLeague.Denver.Users.Calendar" %>
<%@ Register Src="~/UserControls/CalendarControl.ascx" TagName="CalendarControl" TagPrefix="CC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<CC:CalendarControl ID="CalendarControl" runat="server"/>
</asp:Content>
