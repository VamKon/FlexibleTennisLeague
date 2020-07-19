<%@ Page  Title="Flexible Tennis League | Houston, TX | Sign Up" Language="C#" MasterPageFile="~/Houston/FlexibleTennisLeague.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="FlexibleTennisLeague.Houston.Register" %>
<%@ Register Src="~/UserControls/RegisterControl.ascx" TagName="RegisterControl" TagPrefix="RC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<RC:RegisterControl ID="RegisterControl1" runat="server"/>
</asp:Content>
