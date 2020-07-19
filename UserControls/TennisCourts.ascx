<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TennisCourts.ascx.cs"
    Inherits="FlexibleTennisLeague.UserControls.TennisCourts" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<script type="text/javascript" src="http://dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=6.2"></script>

<div class="greyContent" style="text-align: center">
    Enter your address to find courts closer to your location:
    <input id="locationText" name="locationText" type="text" onkeypress="javascript:if(event.keyCode==13){zoomToLocation();}"/>&nbsp;&nbsp;&nbsp;<input
        id="addressButton" name="addressButton" type="button" value="Zoom To My Address"
        class="button" onclick="zoomToLocation()" />
</div>
<asp:Label ID="textLabel" runat="server" Text=""></asp:Label>
<div id="directionsText" >
    <div style="background-color: Blue; height: 15px" align="right">
        <a href="javascript:closeDirectionsText();" style="color: White; text-decoration: none;">
            Hide Directions(X)</a></div>
    <div id="directionsBody">
    </div>
</div>
<div id='myMap' name="myMap" style="position: relative; width: 400px; height: 400px;">
</div>
<div id="startEndPoints" align="center" class="greyContent" style="margin-top: 10px;
    display: none">
    <table cellspacing="15" cellpadding="0">
        <tr valign="middle">
            <td align="right" valign="middle">
                Start:
            </td>
            <td align="left">
                <input id="startTextBox" type="text" style="width: 200px" onkeypress="javascript:if(event.keyCode==13){validateDirection();}"/>
            </td>
            <td align="center">
                <asp:Image ID="flipImage" runat="server" AlternateText="Reverse direction" ImageUrl="~/Resources/Images/Flip.png" Width="20" Height="20"/>
            </td>
            <td align="right" valign="middle">
                End:
            </td>
            <td align="left">
                <input id="endTextBox" type="text" style="width: 200px" onkeypress="javascript:if(event.keyCode==13){validateDirection();}"/>
            </td>
            <td align="center" valign="middle">
                <input id="Button1" name="Button1" type="button" value="Get Directions" class="button"
                    onclick="validateDirection()" />
            </td>
        </tr>
    </table>
</div>

<script type="text/javascript">
    window.onload = GetMap;
</script>

