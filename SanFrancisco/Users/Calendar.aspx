<%@ Page  Title="Flexible Tennis League | San Francisco, CA | My Calendar" Language="C#" MasterPageFile="~/SanFrancisco/ControlPanel.master" AutoEventWireup="true" CodeBehind="Calendar.aspx.cs" Inherits="FlexibleTennisLeague.SanFrancisco.Users.Calendar" %>
<%@ Register Src="~/UserControls/CalendarControl.ascx" TagName="CalendarControl" TagPrefix="CC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<CC:CalendarControl ID="CalendarControl" runat="server"/>
</asp:Content>
