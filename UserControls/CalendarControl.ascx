<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CalendarControl.ascx.cs"
    Inherits="FlexibleTennisLeague.UserControls.CalendarControl" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<style type="text/css">
    .RadScheduler .rsAptContent, .RadScheduler .rsAptIn, .RadScheduler .rsAptMid, .RadScheduler .rsAptOut
    {
        background-image: none;
    }
</style>

<script type="text/javascript">
    function openRadWindow(opponentId) {
        var oWnd = radopen("/Common/MatchRequest.aspx?opponentId=" + opponentId, "RadWindow1");
        oWnd.Center();
    }
    function RefreshScheduler(oWnd, args) {
        callServerSide('RefreshScheduler');
    }
    function AppointmentEditing(sender, eventArgs) {
        var apt = eventArgs.get_appointment();
        var aptID = apt.get_id();
        var oWnd = radopen("/Common/EditMatch.aspx?AppointmentId=" + aptID, "Edit Match");
        oWnd.setSize(370, 330);
        oWnd.Center();
        eventArgs.set_cancel(true);
    }
    function OnClientAppointmentMoving(sender, eventArgs) {
        eventArgs.set_cancel(true);
    }   
    function RecurrenceActionDialogShowing(sender, eventArgs) {
        eventArgs.set_cancel(true);
    }
    function OnClientAppointmentResizing(sender, eventArgs) {
        eventArgs.set_cancel(true);
    }
</script>

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

    <script type="text/javascript">
        function RowSelected(sender, eventArgs) {
            var e = eventArgs.get_domEvent();
            callServerSide(eventArgs.get_itemIndexHierarchical());
        }

        function callServerSide(arg) {
            var argument = arg;
            $find("<%= RadAjaxManager.GetCurrent(Page).ClientID %>").ajaxRequest(argument);
        }
        function confirmCallBackFn(arg) {
            if (arg)
                callServerSide('UpdateSchedule');
            else
                callServerSide('RefreshScheduler');
        }
        function confirmCallBackDelete(arg) {
            if (arg)
                callServerSide('DeleteSchedule');
            else
                callServerSide('RefreshScheduler');
        }
    </script>

</telerik:RadCodeBlock>
<telerik:RadWindowManager ID="RadWindowManager1" runat="server" Modal="True" ShowContentDuringLoad="False"
    VisibleStatusbar="False" Width="370px" Height="300px" Behavior="Default" Behaviors="Close"
    VisibleOnPageLoad="False" OnClientClose="RefreshScheduler">
</telerik:RadWindowManager>
<asp:Image ID="warningImage" runat="server" ImageUrl="~/Resources/Images/Warning.png"
    Width="32" Height="32" ImageAlign="Middle" Visible="false" /><asp:LinkButton ID="warningLinkButton"
            runat="server" Visible="false"></asp:LinkButton><br />
        <telerik:RadPanelBar ID="RadPanelBar1" runat="server" Width="100%" Skin="Office2007"
    AllowCollapseAllItems="True" ExpandMode="MultipleExpandedItems">
    <Items>
        <telerik:RadPanelItem runat="server" Text="How do I use the scheduler?" Expanded="false"
            Font-Size="Small">
            <Items>
                <telerik:RadPanelItem runat="server" Expanded="false">
                    <ItemTemplate>
                    <div style="padding:5px">
                        <p>
                            <b>What items are displayed on the calendar?</b>
                            <br />
                            Both your availability and your scheduled matches are displayed on the calendar.
                            The time that you have set as unavailable in the availability section is displayed
                            as "Unavailable" on the calendar.</p>
                        <p>
                            <b>How do I check the availability of other players?</b><br />
                            You will need to click on the name of the player towards the right of the calendar.
                            This will reload the calendar with both you and the selected player's schedule.
                            Your schedule will be displayed in Green and your opponent's schedule in Pink. Your
                            opponent's schedule cannot be displayed if his/her availability is not set.</p>
                        <p>
                            <b>How do I schedule a match?</b><br />
                            <ul>
                                <li>Check your opponent's availability by viewing his/her schedule.</li>
                                <li>Click on the "Send Match Request" link next to their name.</li>
                                <li>In the "Match request" form that pops up fill in all the details and click "Submit
                                    Request" button.</li>
                                <li>This will add the match to both you and your opponent's schedule. An email will
                                    also be automatically sent to you opponent informing him of the match request.</li>
                                <li>If you don't get a response from your opponent please confirm his/her participation
                                    before the game day.</li></ul>
                        </p>
                        <p>
                            <b>How do I change a scheduled match?</b><br />
                            <ul>
                                <li>While the match is displayed on your calendar, double click on the match.</li>
                                <li>Your existing schedule for the match will be displayed in a pop-up window, where you can change the schedule.</li>
                                <li>Please don't change a scheduled match within 4 hours of the start time. If you do
                                    so your opponent can report this as a no-show.</li>
                                <li>Apart from updating both schedules an email will be sent to your opponent informing
                                    him/her of the change.</li>
                                <li>If you don't get a response from your opponent please confirm his participation
                                    before the game day.</li></ul>
                        </p>
                        <p>
                            <b>How do I cancel a scheduled match?</b><br />
                            <ul>
                                <li>While the match is being displayed on your calendar, hover your mouse over the match.</li>
                                <li>Click on the "x" displayed on the top right corner of the match block.</li>
                                <li>Please don't cancel a scheduled match within 4 hours of the start time. If you do
                                    so your opponent can report this as a no-show.</li>
                                <li>Apart from updating both schedules an email will be sent to your opponent informing
                                    him/her of the change.</li>
                                <li>If you don't get a response from your opponent please confirm the receipt of the
                                    cancellation before the game day.</li></ul>
                        </p>
                        <p><b>Please contact the admin with your questions or comments about this feature by sending an email to admin@flexibletennisleague.com or by using the contact form.</b></p>
                        </div>
                    </ItemTemplate>
                </telerik:RadPanelItem>
            </Items>
        </telerik:RadPanelItem>
    </Items>
</telerik:RadPanelBar>
<div style="width:100%;height:90px;">
<p>Please allow more than 24 hours while scheduling a match with the Scheduler.<br />
Even though the system sends automated emails, your opponent still needs to check their email and respond to you.<br />
Please do not proceed to the tennis court without hearing back from your opponent.</p>
<table>
<tr>
<td style="background-color:#8DBC8F;width:40px;"></td><td>&nbsp;&nbsp;Your schedule.</td><td style="width:20px;"></td><td style="background-color:#FFC8CB;width:40px;"></td><td>&nbsp;&nbsp;Selected player's schedule (You can select a player by clicking on the name).</td>
</tr>
</table>
</div>
<div style="width: 75%; float: left">
    <telerik:RadScheduler ID="RadScheduler1" runat="server" AllowInsert="false" OnAppointmentDataBound="RadScheduler1_AppointmentDataBound"
        Height="800" ShowFullTime="true" ShowFooter="false" OnAppointmentDelete="RadScheduler1_AppointmentDelete"
        EnableRecurrenceSupport="True" 
        Skin="Outlook" MaximumRecurrenceCandidates="10000" DataKeyField="ID" DataStartField="Start"
        DataEndField="End" DataSubjectField="Subject" DataRecurrenceField="RecurrenceRule"
        DataRecurrenceParentKeyField="RecurrenceParentID" DisplayDeleteConfirmation="false" OnClientAppointmentEditing="AppointmentEditing" OnClientRecurrenceActionDialogShowing="RecurrenceActionDialogShowing" MonthView-ReadOnly="true" TimelineView-ReadOnly="true" OnClientAppointmentMoving="OnClientAppointmentMoving" OnClientAppointmentResizing="OnClientAppointmentResizing">
    </telerik:RadScheduler>
</div>
<div style="float: left; width: 25%">
    <telerik:RadGrid ID="playersRadGrid" runat="server" AutoGenerateColumns="False" GridLines="None"
        Skin="Outlook" ShowHeader="false" ClientSettings-ClientEvents-OnRowSelected="RowSelected"
        OnItemDataBound="playersRadGrid_ItemDataBound">
        <ClientSettings EnableRowHoverStyle="true">
            <Selecting AllowRowSelect="True" />
        </ClientSettings>
        <HeaderContextMenu EnableTheming="True">
            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
        </HeaderContextMenu>
        <MasterTableView DataKeyNames="UserId" TableLayout="Fixed">
            <RowIndicatorColumn>
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>
            <ExpandCollapseColumn>
                <HeaderStyle Width="20px"></HeaderStyle>
            </ExpandCollapseColumn>
            <Columns>
                <telerik:GridTemplateColumn HeaderText="Location" UniqueName="CourtName" ItemStyle-Width="27%">
                    <ItemTemplate>
                        <asp:LinkButton ID="matchRequestButton" runat="server">Send Match<br /> Request</asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Season Record" UniqueName="SeasonRecord"
                    SortExpression="Win" ItemStyle-Width="73%">
                    <ItemTemplate>
                        <asp:Label ID="nameLabel" runat="server" Font-Bold="true"><%# Eval("FirstName") %>&nbsp;<%# Eval("LastName") %></asp:Label>
                        <br />
                        <asp:Label ID="seasonRecordLabel" runat="server">Season:&nbsp;<%# Eval("Win") %>W&nbsp;-&nbsp;<%# Eval("Loss") %>L</asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
        <FilterMenu EnableTheming="True">
            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
        </FilterMenu>
    </telerik:RadGrid>
</div>
<div style="clear: both">
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Height="75px"
        Width="75px">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadScheduler1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="playersRadGrid">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
</div>

