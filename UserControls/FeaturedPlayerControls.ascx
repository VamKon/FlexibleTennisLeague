<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FeaturedPlayerControls.ascx.cs"
    Inherits="FlexibleTennisLeague.UserControls.FeaturedPlayerControls" %>
<table width="415">
    <tr>
        <td rowspan="6" width="170" align="center" valign="middle">
            <asp:Image ID="playerImage" runat="server" />
        </td>
        <td>
            Name:
            <asp:Label ID="nameLabel" runat="server" Text=""></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            Location:
            <asp:Label ID="locationLabel" runat="server" Text=""></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            NTRP Rating:
            <asp:Label ID="ntrpLabel" runat="server" Text=""></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            Season Record:
            <asp:Label ID="seasonLabel" runat="server" Text=""></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            Season Points:
            <asp:Label ID="seasonPoints" runat="server" Text=""></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            Favorite Shot:
            <asp:Label ID="favortiteLabel" runat="server" Text=""></asp:Label>
        </td>
    </tr>
</table>
