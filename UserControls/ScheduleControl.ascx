<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ScheduleControl.ascx.cs"
    Inherits="FlexibleTennisLeague.UserControls.ScheduleControl" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<script language="javascript" type="text/javascript">
    var acceptMatchId;
    var acceptMatchDate;
    var acceptMatchTime;

    function openScoreRadWindow(opponentId, matchId) {
        var oWnd = radopen("/Common/ReportScore.aspx?opponentId=" + opponentId + "&matchid=" + matchId + "&mode=existing", "RadWindow1");
        oWnd.setSize(450, 500);
        oWnd.Center();
    }
    function openScoreRadWindowNewMatch() {
        var oWnd = radopen("/Common/ReportScore.aspx", "RadWindow1");
        oWnd.setSize(450, 500);
        oWnd.Center();
    }
    function openGameRatingWindow(opponentId, matchId) {
        var oWnd = radopen("/Common/GameRating.aspx?opponentId=" + opponentId + "&matchId=" + matchId, "RadWindow1");
        oWnd.setSize(850, 575);
        oWnd.Center();
    }
    function openTennisCourtDetailsWindow(courtId) {
        var oWnd = radopen("/Common/TennisCourtDetails.aspx?courtId=" + courtId, "RadWindow1");
        oWnd.setSize(450, 560);
        oWnd.Center();

    }
    function RefreshGrid(oWnd, args) {
        callServerSide('RefreshPreviousMatches');
    }
</script>

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz az well)
            return oWindow;
        }
        function closeRadWindowAndShowAlert() {
            var oWnd = GetRadWindow();

            oWnd.BrowserWindow.radalert("Match request updated succesfully!"); // The operation is not blocking ;
            // You cannot block this thread ;
            oWnd.close();
        }
        function recordValue() {
            var dropDown = document.getElementById("locationDropDownList");
            var hiddenField = document.getElementById("HiddenField1");
            hiddenField.value = dropDown.options[dropDown.selectedIndex].value;
        }
        function callServerSide(arg) {
            var argument = arg;
            if (arg == 'RefreshPreviousMatches')
                $find("<%= RadAjaxManager.GetCurrent(Page).ClientID %>").ajaxRequest(argument);
        }
    </script>

</telerik:RadCodeBlock>
<p align="center">
    <asp:Image ID="warningImage" runat="server" ImageUrl="~/Resources/Images/Warning.png"
        Width="32" Height="32" ImageAlign="Middle" Visible="false" /><asp:LinkButton ID="warningLinkButton"
            runat="server" Visible="false"></asp:LinkButton><br />
    <asp:Image ID="Image1" runat="server" ImageUrl="~/Resources/Images/OK.png" Width="32"
        Height="32" ImageAlign="Middle" /><asp:HyperLink ID="HyperLink1" runat="server" Font-Size="Medium"
            Font-Bold="true" NavigateUrl="javascript:openScoreRadWindowNewMatch();">Submit A Score</asp:HyperLink></p>
<div class="greyContent">
    <p class="heading">
        :: Upcoming Matches
    </p>
    <telerik:RadGrid ID="upcomingMatchesRadGrid" runat="server" AutoGenerateColumns="False"
        GridLines="None" Skin="WebBlue" OnItemDataBound="upcomingMatchesRadGrid_ItemDataBound"
        OnItemCommand="upcomingMatchesRadGrid_ItemCommand">
        <HeaderContextMenu EnableTheming="True">
            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
        </HeaderContextMenu>
        <MasterTableView DataKeyNames="UserId,MatchId,CourtId,AspNetUserId">
            <RowIndicatorColumn>
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>
            <ExpandCollapseColumn>
                <HeaderStyle Width="20px"></HeaderStyle>
            </ExpandCollapseColumn>
            <Columns>
                <telerik:GridTemplateColumn HeaderText="" UniqueName="Action">
                    <ItemTemplate>
                        <asp:LinkButton ID="actionLinkButton" runat="server" ForeColor="#2C1F1E" Font-Bold="true"></asp:LinkButton><br />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Date" UniqueName="MatchDate">
                    <ItemTemplate>
                        <asp:Label ID="dateLabel" runat="server" Text='<%# Eval("MatchDate", "{0:MM/dd/yy}") %>'></asp:Label>
                        <br />
                        <asp:Label ID="timeLabel" runat="server" Text='<%# Eval("MatchDate", "{0:h:mm tt}") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Location" UniqueName="CourtName">
                    <ItemTemplate>
                        <asp:LinkButton ID="courtLinkButton" runat="server"><%# Eval("CourtName") %></asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Opponent" UniqueName="Opponent">
                    <ItemTemplate>
                        <asp:LinkButton ID="opponentLinkButton" runat="server" CommandName="ShowPublicProfile"><%# Eval("FirstName") %>&nbsp;<%# Eval("LastName") %></asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Email" UniqueName="EmailId">
                    <ItemTemplate>
                        <asp:LinkButton ID="emailLinkButton" runat="server"><%# Eval("EmailId") %></asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="Phone" HeaderText="Phone" UniqueName="Phone">
                </telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
        <FilterMenu EnableTheming="True">
            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
        </FilterMenu>
    </telerik:RadGrid>
</div>
<br />
<div class="greyContent">
    <p class="heading">
        :: Previous Matches
    </p>
    <telerik:RadGrid ID="previousMatchesRadGrid" runat="server" AutoGenerateColumns="False"
        GridLines="None" Skin="WebBlue" OnItemDataBound="previousMatchesRadGrid_ItemDataBound"
        OnItemCommand="previousMatchesRadGrid_ItemCommand" AllowPaging="True" PageSize="25">
        <HeaderContextMenu EnableTheming="True">
            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
        </HeaderContextMenu>
        <MasterTableView DataKeyNames="UserId,MatchId,CourtId,AspNetUserId">
            <RowIndicatorColumn>
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>
            <ExpandCollapseColumn>
                <HeaderStyle Width="20px"></HeaderStyle>
            </ExpandCollapseColumn>
            <Columns>
                <telerik:GridTemplateColumn HeaderText="" UniqueName="Action">
                    <ItemTemplate>
                        <asp:LinkButton ID="actionLinkButton" Text="Rate your game" runat="server" ForeColor="#2C1F1E"
                            Font-Bold="true"></asp:LinkButton><br />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Date" UniqueName="MatchDate">
                    <ItemTemplate>
                        <asp:Label ID="dateLabel" runat="server" Text='<%# Eval("MatchDate", "{0:MM/dd/yy}") %>'></asp:Label>
                        <br />
                        <asp:Label ID="timeLabel" runat="server" Text='<%# Eval("MatchDate", "{0:h:mm tt}") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Location" UniqueName="CourtName">
                    <ItemTemplate>
                        <asp:LinkButton ID="courtLinkButton" runat="server"><%# Eval("CourtName") %></asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Opponent" UniqueName="Opponent">
                    <ItemTemplate>
                        <asp:LinkButton ID="opponentLinkButton" runat="server" CommandName="ShowPublicProfile"><%# Eval("FirstName") %>&nbsp;<%# Eval("LastName") %></asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Result" UniqueName="Result">
                    <ItemTemplate>
                        <asp:Label ID="resultLabel" runat="server" ForeColor="#878787" Text='<%# FormatResult(Convert.ToBoolean(Eval("Win"))) %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="Score" HeaderText="Score" UniqueName="Score">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn HeaderText="Points (P/T/S/W)" UniqueName="Points">
                    <ItemTemplate>
                        <asp:Label ID="pointsLabel" runat="server" ForeColor="#878787" Text='<%# Eval("TotalPoints")+" ("+ Eval("PlayPoints") +"/"+Eval("TravelPoints")+"/"+Eval("ScorePoints")+"/"+Eval("WinPoints")+")"%>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
        <FilterMenu EnableTheming="True">
            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
        </FilterMenu>
    </telerik:RadGrid><br />
    P: Play Points, T: Travel Points, S: Score Points, W: Win Points<br />
    Only 4 Travel Points per season are allowed.
</div>
<telerik:RadWindowManager ID="RadWindowManager1" runat="server" Modal="True" ShowContentDuringLoad="False"
    VisibleStatusbar="False" Behavior="Default" Behaviors="Close" VisibleOnPageLoad="False"
    OnClientClose="RefreshGrid">
</telerik:RadWindowManager>
<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Height="75px"
    Width="75px">
    <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
        style="border: 0px;" />
</telerik:RadAjaxLoadingPanel>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="previousMatchesRadGrid" LoadingPanelID="RadAjaxLoadingPanel1" />
                <telerik:AjaxUpdatedControl ControlID="upcomingMatchesRadGrid" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
