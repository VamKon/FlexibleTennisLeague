<%@ Page  Title="Flexible Tennis League | Atlanta, GA | Contact Us" Language="C#" MasterPageFile="~/Atlanta/FlexibleTennisLeague.Master" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="FlexibleTennisLeague.Atlanta.ContactUs" %>
<%@ Register Src="~/UserControls/ContactFormControl.ascx" TagName="ContactFormControl" TagPrefix="CFC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="contentGreyTopBorder">

<CFC:ContactFormControl ID="contactFormControl1" runat="server"></CFC:ContactFormControl>
</div>
</asp:Content>
