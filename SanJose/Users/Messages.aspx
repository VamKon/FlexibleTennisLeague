<%@ Page Title="" Language="C#" MasterPageFile="~/SanJose/ControlPanel.master" AutoEventWireup="true"
    CodeBehind="Messages.aspx.cs" Inherits="FlexibleTennisLeague.SanJose.Users.Messages" %>
<%@ Register Src="~/UserControls/Messages.ascx" TagName="MessageControl" TagPrefix="MC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<MC:MessageControl ID="MessageControl1" runat="server"></MC:MessageControl>
</asp:Content>
