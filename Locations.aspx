<%@ Page Title="Flexible Tennis League | Locations" Language="C#" MasterPageFile="~/FlexibleTennisLeague.Master" AutoEventWireup="true"
    CodeBehind="Locations.aspx.cs" Inherits="FlexibleTennisLeague.Locations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript" src="http://dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=6.2"></script>
    <div class="contentGreyTopBorder">
        <h1>Flexible Tennis League Locations</h1>
        <div style="float: left;padding-right:5px;">
        <h2>Hover over your city's pushpin from the map below and click on the link for your city's league</h2>
            <div id='myMap' name="myMap" style="position: relative; width: 625px; height: 375px;">
            </div>
        </div>
        <div class="contentSplitter" style="height: 425px; float: left;">
        </div>
        <div style="float: right; padding-left: 5px; width: 195px;height:425;overflow:auto">
        <h2>(Or) Click on your city's name</h2>
        <a href="atlanta/">Atlanta, GA</a><br /><br />
        <a href="chicago/">Chicago, IL</a><br /><br />
        <a href="dallas/">Dallas, TX</a><br /><br />
        <a href="denver/">Denver, CO</a><br /><br />
        <a href="houston/">Houston, TX</a><br /><br />
        <a href="losangeles/">Los Angeles, CA</a><br /><br />
        <a href="sanfrancisco/">San Francisco, CA</a><br /><br />
        <a href="sanjose/">San Jose, CA</a><br /><br />
        </div>
        <div style="clear: both"></div>
    </div>
    <script type="text/javascript">
        window.onload = GetMapLocation;
    </script>
</asp:Content>
