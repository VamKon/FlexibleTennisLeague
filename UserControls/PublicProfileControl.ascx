<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PublicProfileControl.ascx.cs"
    Inherits="FlexibleTennisLeague.UserControls.PublicProfileControl" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<script language="javascript" type="text/javascript">
    function openRadWindow(opponentId) {
        var oWnd = radopen("/Common/MatchRequest.aspx?opponentId=" + opponentId, "RadWindow1");
        oWnd.Center();
    }

</script>

<div style="width: 840px">
    <div style="float: left; padding-right: 10px; width: 160px">
        <asp:Image ID="profileImage" runat="server" ImageUrl="~/Resources/Images/NoProfile.gif"
            ImageAlign="Middle" /><br />
        <br />
        <div class="greyContent" style="width: 150px">
            <table>
                <tr>
                    <td style="height: 25px">
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/Resources/Images/MatchRequest.png"
                            ImageAlign="Middle" />
                        <asp:LinkButton ID="matchRequestLinkButton" runat="server">Send Match Request</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div style="float: left; width: 660px">
        <div class="greyContent" style="width: 660px; height: 200px;">
            <p class="heading">
                <asp:Label ID="userLabel" runat="server" Text="Label"></asp:Label>
            </p>
            <div>
                <div style="width: 330px; float: left">
                    <table>
                        <tr>
                            <td class="signUpBold">
                                Division:
                            </td>
                            <td class="signUp">
                                <asp:Label ID="divisionLabel" runat="server" ForeColor="#878787"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="signUpBold">
                                Email Id:
                            </td>
                            <td class="signUp">
                                <asp:HyperLink ID="emailHyperLink" runat="server"></asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td class="signUpBold">
                                Phone:
                            </td>
                            <td class="signUp">
                                <asp:Label ID="phoneLabel" runat="server" ForeColor="#878787"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="signUpBold">
                                Home Court:
                            </td>
                            <td class="signUp">
                                <asp:Label ID="homeCourtLabel" runat="server" ForeColor="#878787"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="signUpBold">
                                NTRP Ranking:
                            </td>
                            <td class="signUp">
                                <asp:Label ID="ntrpRankingLabel" runat="server" ForeColor="#878787"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="signUpBold">
                                Age Group:
                            </td>
                            <td class="signUp">
                                <asp:Label ID="ageGroupLabel" runat="server" ForeColor="#878787"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="signUpBold">
                                Racquet Hand:
                            </td>
                            <td class="signUp">
                                <asp:Label ID="racquetHandLabel" runat="server" ForeColor="#878787"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="width: 330px; float: right">
                    <table>
                        <tr>
                            <td class="signUpBold">
                                Favorite Shot:
                            </td>
                            <td class="signUp">
                                <asp:Label ID="favoriteShotLabel" runat="server" ForeColor="#878787"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="signUpBold">
                                Racquet:
                            </td>
                            <td class="signUp">
                                <asp:Label ID="racquetLabel" runat="server" ForeColor="#878787"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="signUpBold">
                                Facebook:
                            </td>
                            <td class="signUp">
                                <asp:HyperLink ID="facebookHyperLink" runat="server" Target="_blank"></asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td class="signUpBold">
                                LinkedIn:
                            </td>
                            <td class="signUp">
                                <asp:HyperLink ID="linkedInHyperLink" runat="server" Target="_blank"></asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td class="signUpBold">
                                MySpace:
                            </td>
                            <td class="signUp">
                                <asp:HyperLink ID="myspaceHyperLink" runat="server" Target="_blank"></asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td class="signUpBold">
                                Orkut:
                            </td>
                            <td class="signUp">
                                <asp:HyperLink ID="orkutHyperLink" runat="server" Target="_blank"></asp:HyperLink>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <br />
        <div class="greyContent" style="width: 660px">
            <table width="670">
                <tr>
                    <td class="signUpBoldNoWidth">
                        Season Wins:&nbsp;<asp:Label ID="seasonWinsLabel" runat="server" Text=""></asp:Label>
                    </td>
                    <td class="signUpBoldNoWidth">
                        Season Points:&nbsp;<asp:Label ID="seasonPointsLabel" runat="server" Text=""></asp:Label>
                    </td>
                    <td class="signUpBoldNoWidth">
                        Overall Wins:&nbsp;<asp:Label ID="overallWinsLabel" runat="server" Text=""></asp:Label>
                    </td>
                    <td class="signUpBoldNoWidth">
                        Overall Points:&nbsp;<asp:Label ID="overallPointsLabel" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <div class="greyContent" style="width: 660px">
            <p class="heading">
                :: Availability
            </p>
            <table width="670">
                <tr>
                    <td class="signUpBoldNoWidth">
                        SUN:&nbsp;<asp:Label ID="sundayLabel" runat="server" Text=""></asp:Label>
                    </td>
                    <td class="signUpBoldNoWidth">
                        MON:&nbsp;<asp:Label ID="mondayLabel" runat="server" Text=""></asp:Label>
                    </td>
                    <td class="signUpBoldNoWidth">
                        TUE:&nbsp;<asp:Label ID="tuesdayLabel" runat="server" Text=""></asp:Label>
                    </td>
                    <td class="signUpBoldNoWidth">
                        WED:&nbsp;<asp:Label ID="wednesdayLabel" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="signUpBoldNoWidth">
                        THR:&nbsp;<asp:Label ID="thursdayLabel" runat="server" Text=""></asp:Label>
                    </td>
                    <td class="signUpBoldNoWidth">
                        FRI:&nbsp;<asp:Label ID="fridayLabel" runat="server" Text=""></asp:Label>
                    </td>
                    <td class="signUpBoldNoWidth">
                        SAT:&nbsp;<asp:Label ID="saturdayLabel" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <div class="greyContent" style="width: 660px">
            <p class="heading">
                :: Upcoming Matches
            </p>
            <telerik:RadGrid ID="upcomingMatchesRadGrid" runat="server" AutoGenerateColumns="False"
                GridLines="None" Skin="Vista" Width="660">
                <HeaderContextMenu EnableTheming="True">
                    <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                </HeaderContextMenu>
                <MasterTableView>
                    <RowIndicatorColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </ExpandCollapseColumn>
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Date" UniqueName="MatchDate">
                            <ItemTemplate>
                                <asp:Label ID="dateLabel" runat="server" Text='<%# Eval("MatchDate", "{0:MM/dd/yy}") %>'></asp:Label>
                                <br />
                                <asp:Label ID="timeLabel" runat="server" Text='<%# Eval("MatchDate", "{0:h:mm tt}") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Opponent" UniqueName="Opponent">
                            <ItemTemplate>
                                <asp:LinkButton ID="opponentLinkButton" runat="server"><%# Eval("FirstName") %>&nbsp;<%# Eval("LastName") %></asp:LinkButton>
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
        <br />
        <div class="greyContent" style="width: 660px">
            <p class="heading">
                :: Previous Matches
            </p>
            <telerik:RadGrid ID="previousMatchesRadGrid" runat="server" AutoGenerateColumns="False"
                GridLines="None" Skin="Vista" Width="660" AllowPaging="True" PageSize="25">
                <HeaderContextMenu EnableTheming="True">
                    <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                </HeaderContextMenu>
                <MasterTableView>
                    <RowIndicatorColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </ExpandCollapseColumn>
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Date" UniqueName="MatchDate">
                            <ItemTemplate>
                                <asp:Label ID="dateLabel" runat="server" Text='<%# Eval("MatchDate", "{0:MM/dd/yy}") %>'></asp:Label>
                                <br />
                                <asp:Label ID="timeLabel" runat="server" Text='<%# Eval("MatchDate", "{0:h:mm tt}") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Opponent" UniqueName="Opponent">
                            <ItemTemplate>
                                <asp:LinkButton ID="opponentLinkButton" runat="server"><%# Eval("FirstName") %>&nbsp;<%# Eval("LastName") %></asp:LinkButton>
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
            P: Play Points, T: Travel Points, S: Score Points, W: Win Point
        </div>
    </div>
    <div style="clear: both" />
</div>
<telerik:RadWindowManager ID="RadWindowManager1" runat="server" Modal="True" ShowContentDuringLoad="False"
    VisibleStatusbar="False" Width="370px" Height="300px" Behavior="Default" Behaviors="Close"
    VisibleOnPageLoad="False">
</telerik:RadWindowManager>
