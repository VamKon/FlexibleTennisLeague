<%@ Page  Title="Flexible Tennis League | Los Angeles, CA | Sign Up" Language="C#" MasterPageFile="~/LosAngeles/FlexibleTennisLeague.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="FlexibleTennisLeague.LosAngeles.Register" %>
<%@ Register Src="~/UserControls/RegisterControl.ascx" TagName="RegisterControl" TagPrefix="RC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<RC:RegisterControl ID="RegisterControl1" runat="server"/>
</asp:Content>
