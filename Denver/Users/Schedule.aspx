<%@ Page  Title="Flexible Tennis League | Denver, CO | My Schedule" Language="C#" MasterPageFile="~/Denver/ControlPanel.master" AutoEventWireup="true" CodeBehind="Schedule.aspx.cs" Inherits="FlexibleTennisLeague.Denver.Users.Schedule" %>
<%@ Register Src="~/UserControls/ScheduleControl.ascx" TagName="ScheduleControl" TagPrefix="SC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p align=center><asp:Image ID="playOffs" runat="server" ImageUrl="/Resources/Images/PlayOffs.JPG" Visible="false"/></p>
<SC:ScheduleControl ID="ScheduleControl1" runat="server"></SC:ScheduleControl>
</asp:Content>
