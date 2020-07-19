<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LeagueControl.ascx.cs"
    Inherits="FlexibleTennisLeague.UserControls.LeagueControl" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Height="75px"
    Width="75px">
    <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
        style="border: 0px;" />
</telerik:RadAjaxLoadingPanel>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="cityDropDownList">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="leagueDropDownList" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="leagueDropDownList">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="leagueLabel" LoadingPanelID="RadAjaxLoadingPanel1" />
                <telerik:AjaxUpdatedControl ControlID="leagueRadGrid" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<p align="center">
    <asp:Image ID="warningImage" runat="server" ImageUrl="~/Resources/Images/Warning.png"
        Width="32" Height="32" ImageAlign="Middle" Visible="false" /><asp:LinkButton ID="warningLinkButton"
            runat="server" Visible="false"></asp:LinkButton>
</p>
<div class="greyContent">
    <p class="heading">
        <asp:Label ID="leagueLabel" runat="server" Text="Label"></asp:Label>
    </p>
    Sort the table by clicking on a column header<br />
    <sup style="color:red">NEW</sup> Interest column displays a player's preference for Singles, Doubles or Both
    <telerik:RadGrid ID="leagueRadGrid" runat="server" AutoGenerateColumns="False" GridLines="None"
        Skin="WebBlue" AllowSorting="True" OnItemCommand="leagueRadGrid_ItemCommand"
        OnNeedDataSource="leagueRadGrid_NeedDataSource">
        <HeaderContextMenu EnableTheming="True">
            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
        </HeaderContextMenu>
        <MasterTableView DataKeyNames="UserId,AspNetUserId">
            <SortExpressions>
                <telerik:GridSortExpression FieldName="TotalPoints" SortOrder="Descending" />
            </SortExpressions>
            <RowIndicatorColumn>
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>
            <ExpandCollapseColumn>
                <HeaderStyle Width="20px"></HeaderStyle>
            </ExpandCollapseColumn>
            <Columns>
                <telerik:GridTemplateColumn HeaderText="Name" UniqueName="Name" SortExpression="FirstName">
                    <ItemTemplate>
                        <asp:LinkButton ID="opponentLinkButton" runat="server" CommandName="ShowPublicProfile"><%# Eval("FirstName") %>&nbsp;<%# Eval("LastName") %></asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="EmailId" HeaderText="Email" UniqueName="EmailId"
                    SortExpression="EmailId">
                    <ItemTemplate>
                        <asp:LinkButton ID="emailLinkButton" runat="server"><%# Eval("EmailId") %></asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="Phone" HeaderText="Phone" UniqueName="Phone"
                    SortExpression="Phone">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn HeaderText="Record" UniqueName="SeasonRecord"
                    SortExpression="Win">
                    <ItemTemplate>
                        <asp:Label ID="seasonRecordLabel" runat="server"><%# Eval("Win") %>W&nbsp;-&nbsp;<%# Eval("Loss") %>L</asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Points" UniqueName="SeasonPoints" DataField="TotalPoints"
                    SortExpression="TotalPoints">
                    <ItemTemplate>
                        <asp:Label ID="seasonPointsLabel" runat="server"><%# Eval("TotalPoints") %></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="NTRPRanking" HeaderText="NTRP" UniqueName="NTRP"
                    SortExpression="NTRPRanking">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Zip" HeaderText="Zip" UniqueName="Zip" SortExpression="Zip">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Interest" HeaderText="Interest" UniqueName="Interest" SortExpression="Interest">
                </telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
        <FilterMenu EnableTheming="True">
            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
        </FilterMenu>
    </telerik:RadGrid>
</div>
<asp:Panel ID="nextLeaguePanel" runat="server">
    <div class="greyContent">
        <p class="heading">
            <asp:Label ID="nextLeagueLabel" runat="server" Text="Label"></asp:Label>
        </p>
        <telerik:RadGrid ID="nextLeagueRadGrid" runat="server" AutoGenerateColumns="False"
            GridLines="None" Skin="WebBlue" AllowSorting="True" OnItemCommand="leagueRadGrid_ItemCommand"
            OnNeedDataSource="nextLeagueRadGrid_NeedDataSource">
            <HeaderContextMenu EnableTheming="True">
                <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
            </HeaderContextMenu>
            <MasterTableView DataKeyNames="UserId,AspNetUserId">
                <SortExpressions>
                    <telerik:GridSortExpression FieldName="TotalPoints" SortOrder="Descending" />
                </SortExpressions>
                <RowIndicatorColumn>
                    <HeaderStyle Width="20px"></HeaderStyle>
                </RowIndicatorColumn>
                <ExpandCollapseColumn>
                    <HeaderStyle Width="20px"></HeaderStyle>
                </ExpandCollapseColumn>
                <Columns>
                    <telerik:GridTemplateColumn HeaderText="Name" UniqueName="Name" SortExpression="FirstName">
                        <ItemTemplate>
                            <asp:LinkButton ID="opponentLinkButton" runat="server" CommandName="ShowPublicProfile"><%# Eval("FirstName") %>&nbsp;<%# Eval("LastName") %></asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="EmailId" HeaderText="Email" UniqueName="EmailId"
                        SortExpression="EmailId">
                        <ItemTemplate>
                            <asp:LinkButton ID="emailLinkButton" runat="server"><%# Eval("EmailId") %></asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="Phone" HeaderText="Phone" UniqueName="Phone"
                        SortExpression="Phone">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="Season Record" UniqueName="SeasonRecord"
                        SortExpression="Win">
                        <ItemTemplate>
                            <asp:Label ID="seasonRecordLabel" runat="server"><%# Eval("Win") %>W&nbsp;-&nbsp;<%# Eval("Loss") %>L</asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Points" UniqueName="SeasonPoints" DataField="TotalPoints"
                        SortExpression="TotalPoints">
                        <ItemTemplate>
                            <asp:Label ID="seasonPointsLabel" runat="server"><%# Eval("TotalPoints") %></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="NTRPRanking" HeaderText="NTRP" UniqueName="NTRP"
                        SortExpression="NTRPRanking">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Zip" HeaderText="Zip" UniqueName="Zip" SortExpression="Zip">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <FilterMenu EnableTheming="True">
                <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
            </FilterMenu>
        </telerik:RadGrid>
    </div>
</asp:Panel>
