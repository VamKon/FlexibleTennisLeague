<%@ Page  Title="Flexible Tennis League | San Francisco, CA | My Performance" Language="C#" MasterPageFile="~/SanFrancisco/ControlPanel.Master" AutoEventWireup="true" CodeBehind="MyPerformance.aspx.cs" Inherits="FlexibleTennisLeague.SanFrancisco.Users.MyPerformance" %>
<%@ Register Src="~/UserControls/PerformanceControl.ascx" TagName="PerformanceControl" TagPrefix="PC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<PC:PerformanceControl ID="PerformanceControl1" runat="server" />
</asp:Content>
