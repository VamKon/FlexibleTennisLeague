<%@ Page  Title="Flexible Tennis League | San Francisco, CA | Sign Up" Language="C#" MasterPageFile="~/SanFrancisco/FlexibleTennisLeague.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="FlexibleTennisLeague.SanFrancisco.Register" %>
<%@ Register Src="~/UserControls/RegisterControl.ascx" TagName="RegisterControl" TagPrefix="RC"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<RC:RegisterControl ID="RegisterControl1" runat="server"/>
</asp:Content>
