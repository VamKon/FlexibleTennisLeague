<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Messages.ascx.cs" Inherits="FlexibleTennisLeague.UserControls.Messages" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<script type="text/javascript" language="javascript">
    function clearText() {
        var messageText = document.getElementById("<%=messageTextBox.ClientID%>");
        if (messageText.value == "Eg: Is anyone available for tennis match at 5PM on Friday?")
            messageText.value = "";
    }
</script>
<p>Use this page to post messages to other players in the league. Ask if anyone is available for a match or write about your tennis racquet for sale. Please post items pertinent to Tennis only. No foul language please....</p>
<div id="messageInput">
    <asp:TextBox ID="messageTextBox" runat="server" Width="651px" Rows="2" TextMode="MultiLine"
        Height="50px" Text="Eg: Is anyone available for tennis match at 5PM on Friday?"></asp:TextBox>
    &nbsp;
    <asp:Button ID="postMessageButton" runat="server" Text="Post Message" OnClick="postMessageButton_Click" />
</div>
<p>
</p>
<telerik:RadGrid ID="messagesRadGrid" runat="server" AutoGenerateColumns="False"
    GridLines="None" OnNeedDataSource="messagesRadGrid_NeedDataSource" Skin="WebBlue"
    OnItemCommand="messagesRadGrid_ItemCommand" AllowPaging="True" 
    PageSize="20">
    <MasterTableView DataKeyNames="MessageId,AspNetUserId">
        <Columns>
            <telerik:GridBoundColumn DataField="MessageId" Display="False" HeaderText="MessageId"
                UniqueName="messageID">
            </telerik:GridBoundColumn>
            <telerik:GridTemplateColumn HeaderText="Message" UniqueName="message">
                <ItemTemplate>
                    <asp:LinkButton ID="messageButton" runat="server" ForeColor="#878787" CommandName="ShowMessage"><%# Eval("Message")%></asp:LinkButton>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Posted By" UniqueName="UserName">
                <ItemTemplate>
                    <asp:LinkButton ID="userLinkButton" runat="server" ForeColor="#878787" CommandName="ShowPublicProfile"><%# Eval("FirstName") + " " + Eval("LastName")%></asp:LinkButton>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Posted On" UniqueName="PostDate">
                <ItemTemplate>
                    <asp:Label ID="dateLabel" runat="server" Text='<%# Eval("DatePosted", "{0:MM/dd/yy}") %>'></asp:Label>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridBoundColumn DataField="Replies" HeaderText="Replies" UniqueName="replies">
            </telerik:GridBoundColumn>
        </Columns>
    </MasterTableView>
</telerik:RadGrid>