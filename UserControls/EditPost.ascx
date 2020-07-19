<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditPost.ascx.cs" Inherits="FlexibleTennisLeague.UserControls.EditPost" %>
    <div id="messageInput" style="height:155px">
        <asp:TextBox ID="messageTextBox" runat="server" Width="651px" Rows="2" TextMode="MultiLine"
            Height="150px"></asp:TextBox>
        &nbsp;
        <asp:Button ID="postMessageButton" runat="server" Text="Save Changes" OnClick="postMessageButton_Click" />
        <br />
    </div>