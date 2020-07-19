<%@ Page Title="Denver Tennis League | Denver, CO" Language="C#" MasterPageFile="~/Denver/FlexibleTennisLeague.Master"
    AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FlexibleTennisLeague.Denver.Default"
    EnableViewState="false" %>

<%@ Register Src="~/UserControls/FeaturedPlayerControls.ascx" TagName="FeaturedPlayer"
    TagPrefix="FP" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="contentGreyTopBorder" style="padding-top: 20px;">
        <div style="float: left; width: 420px;">
            <h1>
                Denver Tennis League - Play Competitive Tennis, at Your Convenience
            </h1>
            <h2>
                Denver's Flexible Tennis League connects you to serious Tennis enthusiasts in a
                competitive setting. Play serious Tennis that works for your schedule.</h2>
            :: You have the flexibility to decide when to play, whom to play and where to play.<br />
            :: Play in a competitive or non-competitive Tennis league that fits your skill level.<br />
            :: Schedule matches at your convenience.<br />
            :: Report scores and track your progress.<br />
            :: Find Tennis courts in the Denver metro area.<br />
            <br />
            <a href="HowItWorks.aspx">
                <img src="../Resources/Images/How_Does_It_Work.jpg" border="0" alt="How Does It Work" /></a>
        </div>
        <div class="contentSplitter" style="height: 250px; float: left">
        </div>
        <div style="float: left; padding-left: 10px; width: 400px;">
            <h2>
                <b>Denver Summer 2010 Tennis League</b></h2>
            Flexible Tennis league serves the following locations in the Denver Metro: Aurora,
            Denver, Englewood, Golden, Highlands Ranch, Lakewood, Littleton, Parker and Westminster.<br />
            <h2>
                Starts : 06/18/2010</h2>
            <h2>
                Playoffs Begin : 08/13/2010</h2>
            <h2>
                Ends : 08/30/2010</h2>
                <h2>
                Cost : Abosolutely Free</h2>
            <br />
            <a href="Register.aspx">
                <img src="../Resources/Images/Sign_Up.jpg" border="0" alt="Sign Up" /></a>
        </div>
        <div style="clear: both">
            <p>
                &nbsp;</p>
        </div>
        <div class="greyContent" style="width: 830px;">
            <div style="float: left; width: 415px;">
            <b>Featured Denver Player</b><br /><br />
                <FP:FeaturedPlayer ID="featuredPlayer1" runat="server"/>
            </div>
            <div class="contentSplitter" style="height: 150px; float: left">
            </div>
            <div style="float: left; padding-left: 10px; width: 400px;">
                <b>News & Events</b><br />
                <br />
                <a href="http://blog.flexibletennisleague.com/post/2010/05/24/Denver-Spring-2010-League-PlayoffsMixer.aspx"><img src="../Denver/Resources/Images/SpringMixer.jpg" width="156" height="115" align="left" style="margin-right: 5px;" /></a>
                <ul>
                    <li><a href="http://blog.flexibletennisleague.com/post/2010/06/08/Rob-Jaecks-wins-the-Denver-Spring-2010-Tennis-League.aspx">Rob Jaecks wins the Spring 2010 league.</a></li>
                    <li></li>
                    <li><a href="http://blog.flexibletennisleague.com/post/2010/05/24/Denver-Spring-2010-League-PlayoffsMixer.aspx">Check out pictures from our Spring league's playoffs/mixer</a></li>
                    <li></li>
                    <li><a href="Register.aspx">The Summer league starts 06/18 - Join for free.</a></li>
                </ul>
            </div>
            <div style="clear: both">
            </div>
        </div>
    </div>
</asp:Content>
