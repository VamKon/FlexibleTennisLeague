<%@ Page  Title="Flexible Tennis League | San Jose, CA | Sign Up" Language="C#" MasterPageFile="~/SanJose/FlexibleTennisLeague.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="FlexibleTennisLeague.SanJose.Register" %>
<%@ Register Src="~/UserControls/RegisterControl.ascx" TagName="RegisterControl" TagPrefix="RC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<RC:RegisterControl ID="RegisterControl1" runat="server"/>
</asp:Content>
