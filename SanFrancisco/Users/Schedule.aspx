<%@ Page  Title="Flexible Tennis League | San Francisco, CA | My Schedule" Language="C#" MasterPageFile="~/SanFrancisco/ControlPanel.master" AutoEventWireup="true" CodeBehind="Schedule.aspx.cs" Inherits="FlexibleTennisLeague.SanFrancisco.Users.Schedule" %>
<%@ Register Src="~/UserControls/ScheduleControl.ascx" TagName="ScheduleControl" TagPrefix="SC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<SC:ScheduleControl ID="ScheduleControl1" runat="server"></SC:ScheduleControl>
</asp:Content>
