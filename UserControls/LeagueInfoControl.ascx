<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LeagueInfoControl.ascx.cs"
    Inherits="FlexibleTennisLeague.UserControls.LeagueInfoControl" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadPanelBar ID="RadPanelBar1" runat="server" Width="100%" Skin="Office2007"
    AllowCollapseAllItems="True" ExpandMode="FullExpandedItem" Height="500px">
    <Items>
        <telerik:RadPanelItem runat="server" Text="How does the league work?" 
            Expanded="true" Font-Size="Medium">
            <Items>
                <telerik:RadPanelItem runat="server" Expanded="true">
                    <ItemTemplate>
                        <ul>
                            <li>Flexible Tennis League has several seasons in a year depending on where you live.</li>
                            <li>Players sign up for a season.</li>
                            <li>The inaugural season is free for all. There will be a low fee per season
                                thereafter.</li>
                            <li>You can start playing practice games against players in your division immediately.
                                Actual matches will officially begin on previously announced date.</li>
                            <li>Based on their skill level (based on the NTRP ranking, part of the mandatory questions
                                during the signup process), each player is assigned a division. Other factors such
                                as the number of players in each division are also considered. This is done to maximize
                                the playing potential for each player.</li>
                            <li>Players can view details of each other in a division and schedule matches via the
                                match scheduler or by calling/emailing each other.</li>
                            <li>Matches are played for a maximum of three sets with tie-breakers in each set. (winning
                                two sets will win the match.)</li>
                            <li>Players will also have to be the umpires in a match.</li>
                            <li>Once a match is completed the winner posts the scores of the match on the website.
                                Players are highly encouraged to rate each others games, so that they can track
                                the progress of how their game improved over the season. Graphs and charts display
                                how each aspect of your game has progressed over the season.</li>
                            <li>Players should have played at least 5 games in a season to qualify for the playoffs
                                before a date which will be announced at the beginning of the season.</li>
                            <li>8 players qualify for the playoffs depending on points earned from the preliminary
                                round. Playoffs consist of quarter-finals, semi-finals culminating in the final
                                match where the winner for the division is determined.</li>
                            <li>If you are not satisfied with the league you can ask for your money back within
                                7 days from the start date of a league.</li>
                        </ul>
                    </ItemTemplate>
                </telerik:RadPanelItem>
            </Items>
        </telerik:RadPanelItem>
        <telerik:RadPanelItem runat="server" Text="How do I sign up?" 
            Font-Size="Medium">
            <Items>
                <telerik:RadPanelItem runat="server" Expanded="true">
                    <ItemTemplate>
                        <ul>
                            <li>You can sign up by going to FlexibleTennisLeague's home page and clicking on the
                                "Click here to join" button. </li>
                            <li>Alternatively you can choose your location from our home page and then click on
                                the "Click here to join" button.</li>
                            <li>Fill out your details in the registration page and submit the form.</li>
                            <li>If your registration is successful you will be taken to your profile page, where
                                you can complete your profile and upload a profile image.</li>
                            <li>Your account will have a temporary status until your registration process is completed
                                and you are assigned a division by the league's administrator.</li>
                            <li>With your temporary status you can browse through all the pages, but some features
                                will be unavailable to you.</li>
                            <li>The administrator will send you an email when your registration is fully complete,
                                you will also have full access to the site at that time. This process takes no more
                                than 1-2 hours.</li>
                        </ul>
                    </ItemTemplate>
                </telerik:RadPanelItem>
            </Items>
        </telerik:RadPanelItem>
        <telerik:RadPanelItem runat="server" Text="How do I schedule a match?" 
            Font-Size="Medium">
            <Items>
                <telerik:RadPanelItem runat="server" Expanded="true">
                    <ItemTemplate>
                        <ul>
                            <li>You can schedule a match by calling or emailing the players in your division.</li>
                            <li>You will be able to look up emails and phone numbers by logging into the members
                                section of the website.</li>
                            <li>Alternatively you can use the online scheduling system. Using this system you can
                                look at the availability of the players in your league and request to play a match,
                                specifying the time and location of match. The scheduling system sends an email
                                to your opponent notifying them that you have requested to play a match with them.</li>
                            <li>You cannot play more than 2 matches against the same player in a single season.</li>
                        </ul>
                    </ItemTemplate>
                </telerik:RadPanelItem>
            </Items>
        </telerik:RadPanelItem>
        <telerik:RadPanelItem runat="server" Text="How do I report scores?" 
            Font-Size="Medium">
            <Items>
                <telerik:RadPanelItem runat="server" Expanded="true">
                    <ItemTemplate>
                        <ul>
                            <li>Once the match is completed, the match winner can post scores by visiting the Members
                                area.</li>
                            <li>An email is automatically sent by the website informing both players that scores
                                have been posted.</li>
                            <li>Any discrepancy in the scores can be communicated to the league administrator.</li>
                        </ul>
                    </ItemTemplate>
                </telerik:RadPanelItem>
            </Items>
        </telerik:RadPanelItem>
        <telerik:RadPanelItem runat="server" 
            Text="How are the points awarded for a match?" Font-Size="Medium">
            <Items>
                <telerik:RadPanelItem runat="server" Expanded="true">
                    <ItemTemplate>
                        <ul>
                            <li>With FlexibleTennisLeague both player get points just for showing up, so the more
                                you play the more points you get.</li>
                            <li>Points are also awarded for playing a game away from your chosen home court. So
                                you are actually rewarded for having to travel. You can only get a maximum of 4
                                points per season for traveling.</li>
                            <li>Points are distributed in the following manner:
                                <ul>
                                    <li>Winning a game: 3 points</li>
                                    <li>Playing a game: 1 point (both players get this point)</li>
                                    <li>Winning a game in 2 sets: 1 Point</li>
                                    <li>Playing a game at a court other than the home court: 1 Point</li>
                                </ul>
                            </li>
                        </ul>
                    </ItemTemplate>
                </telerik:RadPanelItem>
            </Items>
        </telerik:RadPanelItem>
        <telerik:RadPanelItem runat="server" 
            Text="What if my opponent does not show up?" Font-Size="Medium">
            <Items>
                <telerik:RadPanelItem runat="server" Expanded="true">
                    <ItemTemplate>
                        <ul>
                            <li>We take no-shows very seriously.</li>
                            <li>If your opponent does not show up within 30 minutes of the scheduled time, or call
                                to let you know that he/she will not be able to play before 5 hours before the game,
                                an offense will be noted against your opponent. </li>
                            <li>If that player commits the same offense again, he/she will be banned from participating
                                in the league. </li>
                            <li>You will get 5 points for that game. </li>
                        </ul>
                    </ItemTemplate>
                </telerik:RadPanelItem>
            </Items>
        </telerik:RadPanelItem>
        <telerik:RadPanelItem runat="server" 
            Text="What rules are to be followed before, during and after a match?" 
            Font-Size="Medium">
            <Items>
                <telerik:RadPanelItem runat="server" Expanded="true">
                    <ItemTemplate>
                        <ul>
                            <li>Please contact your opponent to make sure that you both have agreed on the date, time and location.</li>
                            <li>Please arrive to the court promptly.</li>
                            <li>Both players will need to bring at least one new can of balls.</li>
                            <li>Point calls have to be made without delay. Since there are no umpires the calls are made and agreed on an honor basis.</li>
                            <li>You cannot make a call after you have hit the ball.</li>
                            <li>Players will need to switch sides every two games.</li>
                            <li>If a match has to be replayed due to weather or light, the match will need to resume from the same score.</li>
                            <li>Please post your score within 48 hours of playing a match</li>
                            <li>Please contact the administrator if you see that a incorrect score has been posted.</li>
                            <li>Please rate both your game and your opponents game after each game.</li>
                            <li>Please report any misbehavior or foul play on the part of your opponents.</li>
                        </ul>
                    </ItemTemplate>
                </telerik:RadPanelItem>
            </Items>
        </telerik:RadPanelItem>
    </Items>
</telerik:RadPanelBar>
