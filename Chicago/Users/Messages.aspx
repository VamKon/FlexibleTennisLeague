<%@ Page Title="" Language="C#" MasterPageFile="~/Chicago/ControlPanel.master" AutoEventWireup="true"
    CodeBehind="Messages.aspx.cs" Inherits="FlexibleTennisLeague.Chicago.Users.Messages" %>
<%@ Register Src="~/UserControls/Messages.ascx" TagName="MessageControl" TagPrefix="MC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<MC:MessageControl ID="MessageControl1" runat="server"></MC:MessageControl>
</asp:Content>
