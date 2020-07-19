<%@ Page Title="" Language="C#" MasterPageFile="~/Atlanta/ControlPanel.master" AutoEventWireup="true"
    CodeBehind="EditPost.aspx.cs" Inherits="FlexibleTennisLeague.Atlanta.Users.EditPost" %>
<%@ Register Src="~/UserControls/EditPost.ascx" TagName="EditPost" TagPrefix="EP" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <EP:EditPost ID="editPost1" runat="server"></EP:EditPost>
</asp:Content>
