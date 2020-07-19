<%@ Page  Title="Flexible Tennis League | Chicago, IL | My Availability" Language="C#" MasterPageFile="~/Chicago/ControlPanel.master" AutoEventWireup="true" CodeBehind="Availability.aspx.cs" Inherits="FlexibleTennisLeague.Chicago.Users.Availability" %>
<%@ Register Src="~/UserControls/AvailabilityControl.ascx" TagName="AvailabilityControl" TagPrefix="AC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<AC:AvailabilityControl ID="availabilityControl1" runat="server"></AC:AvailabilityControl>
</asp:Content>
