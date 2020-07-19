<%@ Page  Title="Los Angeles Tennis Courts | Flexible Tennis League" Language="C#" MasterPageFile="~/LosAngeles/FlexibleTennisLeague.Master" AutoEventWireup="true" CodeBehind="TennisCourts.aspx.cs" Inherits="FlexibleTennisLeague.LosAngeles.TennisCourts" %>
<%@ Register Src="../UserControls/TennisCourts.ascx" TagName="TennisCourts" TagPrefix="TC"%>
<%@ Register Src="../UserControls/TennisCourtsGrid.ascx" TagName="TennisCourtsGrid" TagPrefix="TCG"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="contentGreyTopBorder">
<h1>
            Find Los Angeles Tennis courts that are close to you.</h1>
            <h2>
            Search for <b>Los Angeles Tennis courts</b> and get driving directions. Find a court that works best
            for you.</h2>
<TC:TennisCourts ID="TennisCourts1" runat="server" MapWidth="840" MapHeight="400"></TC:TennisCourts>
<br />
<TCG:TennisCourtsGrid ID="TennisCourtsGrid1" runat="server"/>
<p>Please use the <a href="ContactUs.aspx">Contact Us</a> page to tell us about missing <b>Los Angeles Tennis Courts</b>.</p>
</div>
</asp:Content>
