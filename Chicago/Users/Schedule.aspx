<%@ Page  Title="Flexible Tennis League | Chicago, IL | My Schedule" Language="C#" MasterPageFile="~/Chicago/ControlPanel.master" AutoEventWireup="true" CodeBehind="Schedule.aspx.cs" Inherits="FlexibleTennisLeague.Chicago.Users.Schedule" %>
<%@ Register Src="~/UserControls/ScheduleControl.ascx" TagName="ScheduleControl" TagPrefix="SC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<SC:ScheduleControl ID="ScheduleControl1" runat="server"></SC:ScheduleControl>
</asp:Content>
