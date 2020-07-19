<%@ Page  Title="Flexible Tennis League | Los Angeles, CA | My Schedule" Language="C#" MasterPageFile="~/LosAngeles/ControlPanel.master" AutoEventWireup="true" CodeBehind="Schedule.aspx.cs" Inherits="FlexibleTennisLeague.LosAngeles.Users.Schedule" %>
<%@ Register Src="~/UserControls/ScheduleControl.ascx" TagName="ScheduleControl" TagPrefix="SC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<SC:ScheduleControl ID="ScheduleControl1" runat="server"></SC:ScheduleControl>
</asp:Content>
