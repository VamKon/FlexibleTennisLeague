<%@ Page  Title="Flexible Tennis League | San Jose, CA | My Availability" Language="C#" MasterPageFile="~/SanJose/ControlPanel.master" AutoEventWireup="true" CodeBehind="Availability.aspx.cs" Inherits="FlexibleTennisLeague.SanJose.Users.Availability" %>
<%@ Register Src="~/UserControls/AvailabilityControl.ascx" TagName="AvailabilityControl" TagPrefix="AC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<AC:AvailabilityControl ID="availabilityControl1" runat="server"></AC:AvailabilityControl>
</asp:Content>
