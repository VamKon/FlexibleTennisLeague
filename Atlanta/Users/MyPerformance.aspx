<%@ Page  Title="Flexible Tennis League | Atlanta, GA | My Performance" Language="C#" MasterPageFile="~/Atlanta/ControlPanel.Master" AutoEventWireup="true" CodeBehind="MyPerformance.aspx.cs" Inherits="FlexibleTennisLeague.Atlanta.Users.MyPerformance" %>
<%@ Register Src="~/UserControls/PerformanceControl.ascx" TagName="PerformanceControl" TagPrefix="PC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<PC:PerformanceControl ID="PerformanceControl1" runat="server" />
</asp:Content>
