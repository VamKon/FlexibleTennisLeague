<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MessageDetail.ascx.cs" Inherits="FlexibleTennisLeague.UserControls.MessageDetail" %>
<asp:Repeater ID="messageSourceRepeater" runat="server" 
        onitemdatabound="messageSourceRepeater_ItemDataBound">
        <HeaderTemplate>
        </HeaderTemplate>
        <ItemTemplate>
            <div id="messageSource">
                <asp:Literal ID="messageSourceLiteral" runat="server" Text='<%# Eval("Message")%>'></asp:Literal>
                <p>
                    Posted by
                    <asp:HyperLink ID="userSourceHyperLink" runat="server" CssClass="message" ><%# Eval("FirstName")%>&nbsp;<%# Eval("LastName")%></asp:HyperLink>&nbsp
                    on
                    <asp:Literal ID="datePostedSourceLiteral" runat="server" Text='<%# Eval("DatePosted", "{0:MM/dd/yy}") %>'></asp:Literal> | <asp:HyperLink ID="editHyperLink" runat="server" CssClass="message" Visible="false">Edit Post</asp:HyperLink>
                </p>
            </div>
        </ItemTemplate>
        <FooterTemplate>
        </FooterTemplate>
    </asp:Repeater>
    <asp:Repeater ID="messageRepeater" runat="server" EnableTheming="True" 
        onitemdatabound="messageRepeater_ItemDataBound">
        <HeaderTemplate>
        </HeaderTemplate>
        <ItemTemplate>
            <div class="messageReply">
                <asp:Literal ID="messageLiteral" runat="server" Text='<%# Eval("Body")%>'></asp:Literal>
                <p>
                    Posted by
                    <asp:HyperLink ID="userHyperLink" runat="server"><%# Eval("FirstName")%>&nbsp;<%# Eval("LastName")%></asp:HyperLink>&nbsp
                    on
                    <asp:Literal ID="datePostedLiteral" runat="server" Text='<%# Eval("DatePosted", "{0:MM/dd/yy}") %>'></asp:Literal> | <asp:HyperLink ID="editHyperLink" runat="server" Visible="false">Edit Post</asp:HyperLink>
                </p>
            </div>
        </ItemTemplate>
        <FooterTemplate>
        </FooterTemplate>
    </asp:Repeater>
    <p></p>
    <div id="messageInput">
        <asp:TextBox ID="messageTextBox" runat="server" Width="651px" Rows="2" TextMode="MultiLine"
            Height="50px"></asp:TextBox>
        &nbsp;
        <asp:Button ID="postMessageButton" runat="server" Text="Post Reply" OnClick="postMessageButton_Click" />
        <br />
    </div>