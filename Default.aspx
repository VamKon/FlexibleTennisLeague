<%@ Page Language="C#" MasterPageFile="~/FlexibleTennisLeague.Master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="FlexibleTennisLeague.Default" Title="Flexible Tennis League | Competitive Tennis at Your Convenience" %>

<%@ Register Src="~/UserControls/FeaturedPlayerControls.ascx" TagName="FeaturedPlayer"
    TagPrefix="FP" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="contentGreyTopBorder" style="padding-top: 20px;">
        <div style="float: left; width: 420px;">
            <h1>
                Play Competitive Tennis at Your Convenience
            </h1>
            <h2>
            Flexible Tennis League connects you with serious Tennis enthusiasts in a competitive
            setting. Play serious Tennis that works for your schedule.</h2>
            :: You have the flexibility to decide when to play, whom to play and where to play.<br />
            :: Play in a competitive or non-competetive league that fits your skill level.<br />
            :: Schedule matches at your convenience.<br />
            :: Report scores and track your progress.<br />
            :: Find Tennis courts in your area.<br /><br />
            <a href="HowItWorks.aspx"><img src="Resources/Images/How_Does_It_Work.jpg" border="0" alt="How Does It Work"/></a>
        </div>
        <div class="contentSplitter" style="height: 250px; float: left">
        </div>
        <div style="float: left; padding-left: 10px; width: 400px;">
            <h2>
                <b>Why Flexible Tennis League</b>
            </h2>
            :: Flexibility in scheduling your games - use our innovative scheduling system or
            contact your opponents by phone/email.<br />
            :: Extra points for away games.<br />
            :: Innovative performance tracker - lets you track your progress both from your
            perspective and your opponents perspective.<br />
            :: Free inaugural season. A Low fee there onwards.<br />
            :: Compete for prizes in every league.<br />
            :: Find the nearest Tennis court and get driving directions.<br />
            <br />
            <a href="Locations.aspx"><img src="Resources/Images/Sign_Up.jpg" border="0" alt="Sign Up"/></a>
        </div>
        <div style="clear: both">
            <p>
                &nbsp;</p>
        </div>
        <div class="greyContent" style="width: 830px;">
            <div style="float: left; width: 415px;">
            <b>Featured Player</b><br /><br />
                <FP:FeaturedPlayer ID="featuredPlayer1" runat="server" City="0" />
            </div>
            <div class="contentSplitter" style="height: 150px; float: left">
            </div>
            <div style="float: left; padding-left: 10px; width: 400px;">
                <b>News & Events</b><br />
                <br />
                <img src="Resources/Images/News.jpg" width="117" height="99" align="left" style="margin-right: 5px;" />
                <ul>
                    <li>1. <a href="/sanjose/">San Jose Summer league starts 06/01</a></li>
                    <li>2. Summer leagues for <a href="/chicago/">Chicago</a>, <a href="/atlanta/">Atlanta</a>, <a href="/houston/">Houston</a>, <a href="/losangeles/">Los Angeles</a> start on 06/11. Join for free.<br /></li>
                    <li>3. <a href="/denver/">Denver Summer league starts 06/18.</a></li>
                </ul>
            </div>
            <div style="clear: both"></div>
        </div>
    </div>
</asp:Content>
