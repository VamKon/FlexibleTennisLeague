<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TennisCourtsGrid.ascx.cs"
    Inherits="FlexibleTennisLeague.UserControls.TennisCourtsGrid" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="tennisCourtsRadGrid">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tennisCourtsRadGrid" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="citiesDropDownList">
            <UpdatedControls >
                <telerik:AjaxUpdatedControl ControlID="tennisCourtsRadGrid" LoadingPanelID="RadAjaxLoadingPanel1"/>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default">
</telerik:RadAjaxLoadingPanel>
<asp:Label ID="textLabel" runat="server" Text=""></asp:Label>
<div class="greyContent" style="text-align: center">
    Show me Tennis courts in : 
    <asp:DropDownList ID="citiesDropDownList" runat="server" AutoPostBack="True" 
        onselectedindexchanged="citiesDropDownList_SelectedIndexChanged">
    </asp:DropDownList>
</div><br />
<telerik:RadGrid ID="tennisCourtsRadGrid" runat="server" AutoGenerateColumns="False"
    GridLines="None" Skin="WebBlue" 
    onitemdatabound="tennisCourtsRadGrid_ItemDataBound" 
    GroupHeaderItemStyle-Font-Bold="true" AllowPaging="True" 
    onneeddatasource="tennisCourtsRadGrid_NeedDataSource" PageSize="25" GroupPanel-ForeColor="White">
    <HeaderContextMenu EnableTheming="True">
        <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
    </HeaderContextMenu>
    <MasterTableView DataKeyNames="MapId">
        <GroupByExpressions>
            <telerik:GridGroupByExpression>
                <SelectFields>
                    <telerik:GridGroupByField FieldAlias="City" FieldName="City" 
                        ></telerik:GridGroupByField>
                </SelectFields>
                <GroupByFields>
                    <telerik:GridGroupByField FieldName="City" SortOrder="Ascending"></telerik:GridGroupByField>
                </GroupByFields>
            </telerik:GridGroupByExpression>
        </GroupByExpressions>
        <RowIndicatorColumn>
            <HeaderStyle Width="20px"></HeaderStyle>
        </RowIndicatorColumn>
        <ExpandCollapseColumn>
            <HeaderStyle Width="20px"></HeaderStyle>
        </ExpandCollapseColumn>
        <Columns>
            <telerik:GridBoundColumn DataField="City" HeaderText="City" UniqueName="City" Visible="false">
            </telerik:GridBoundColumn>
            <telerik:GridTemplateColumn HeaderText="" UniqueName="Action" ItemStyle-Width="50">
                <ItemTemplate>
                    <asp:ImageButton ID="zoomImageButton" runat="server" ImageUrl="~/Resources/Images/Zoom.png" Width="14" Height="14" AlternateText="Zoom to tennis court" ToolTip="Zoom to tennis court"/>&nbsp;&nbsp;
                    <asp:ImageButton ID="directionsImageButton" runat="server" ImageUrl="~/Resources/Images/DrivingDirections.png" Width="14" Height="14" AlternateText="Get driving directions to this tennis court" ToolTip="Get driving directions to this tennis court"/>
                </ItemTemplate>

<ItemStyle Width="50px"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridBoundColumn DataField="CourtName" HeaderText="Name" UniqueName="Name" ItemStyle-ForeColor="Black">
<ItemStyle ForeColor="Black"></ItemStyle>
            </telerik:GridBoundColumn>
            <telerik:GridTemplateColumn HeaderText="Location" UniqueName="CourtName">
                <ItemTemplate>
                    <asp:Label ID="locationLabel" runat="server" ForeColor="#878787" Text='<%# Eval("Address") + ", " + Eval("City") + ", " + Eval("State") + " " + Eval("Zip") %>'></asp:Label>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridBoundColumn DataField="NumberCourts" HeaderText="Courts" UniqueName="Courts">
            </telerik:GridBoundColumn>
            <telerik:GridTemplateColumn HeaderText="Open to All" UniqueName="OpenToAll" HeaderStyle-Width="70">
                <ItemTemplate>
                    <asp:Label ID="openToAllLabel" runat="server" ForeColor="#878787" Text='<%# Format(Convert.ToBoolean(Eval("IsPublic"))) %>'></asp:Label>
                </ItemTemplate>

<HeaderStyle Width="70px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Lights" UniqueName="Lights">
                <ItemTemplate>
                    <asp:Label ID="lightsLabel" runat="server" ForeColor="#878787" Text='<%# Format(Convert.ToBoolean(Eval("HasLights"))) %>'></asp:Label>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Fees" UniqueName="Fees">
                <ItemTemplate>
                    <asp:Label ID="feesLabel" runat="server" ForeColor="#878787" Text='<%# Format(Convert.ToBoolean(Eval("HasLights"))) %>'></asp:Label>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
        </Columns>
    </MasterTableView>

<GroupHeaderItemStyle Font-Bold="True"></GroupHeaderItemStyle>

    <FilterMenu EnableTheming="True">
        <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
    </FilterMenu>
</telerik:RadGrid>
