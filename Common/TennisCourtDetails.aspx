<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TennisCourtDetails.aspx.cs"
    Inherits="FlexibleTennisLeague.Common.TennisCourtDetails" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tennis Court Details</title>
    <link href="../App_Themes/FlexibleTennisLeague/Tennis.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="http://dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=6.2"></script>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">
            var map = null;
            var layer = null;
            var ajaxManager = null;

            function pageLoad() {
                ajaxManager = $find('<%= RadAjaxManager1.ClientID %>');
                confirmCallBackFn("ZoomToTennisCourt");
                // Your code  
            }  

            function confirmCallBackFn(arg) {
                ajaxManager.ajaxRequest(arg);
            }
            
            function GetMap() {
                map = new VEMap('myMap');
                map.onLoadMap = loadCollection;
                map.HideScalebar()
                var mapOptions = new VEMapOptions();
                mapOptions.EnableBirdseye = false;
                mapOptions.EnableDashboardLabels = false;
                try {
                    map.LoadMap(null, null, null, null, null, null, null, mapOptions);
                }
                catch (ex) {
                    alert("The following exception has occurred: " + ex.name + ", " + ex.message);
                }
                map.Resize();
                map.SetMapStyle(VEMapStyle.Aerial);
            }

            function loadCollection() {
                layer = new VEShapeLayer();
                var veLayerSpec = new VEShapeSourceSpecification(VEDataType.GeoRSS, '<%=geoRSSFeed %>', layer);
                //var veLayerSpec = new VEShapeSourceSpecification(VEDataType.VECollection, 'AA39228CD7CD85FA!159', layer);
                map.ImportShapeLayerData(veLayerSpec, null, false);
            }

            function zoomToTennisCourt(mapId) {
                var shape = layer.GetShapeByIndex(parseInt(mapId));
                map.SetZoomLevel(17);
                map.SetCenter(new VELatLong(shape.GetPoints()[0].Latitude, shape.GetPoints()[0].Longitude));
            }

            
        </script>

    </telerik:RadCodeBlock>
</head>
<body style="width: 410px;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
    </telerik:RadAjaxManager>
    <div class="greyContent" style="width: 400px">
        <p class="heading">
            <asp:Label ID="nameLabel" runat="server" Text=""></asp:Label>
        </p>
        <div id='myMap' style="position: relative; width: 400px; height: 300px;">
        </div>
    </div>
    <br />
    <div class="greyContent" style="width: 400px">
        <table>
            <tr>
                <td>
                    Address:
                </td>
                <td>
                    <asp:Label ID="addressLabel" runat="server" Text=""></asp:Label>
                </td>
                <td>
                    Phone:
                </td>
                <td style="width: 100px">
                    <asp:Label ID="phoneLabel" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    No. Of Courts:
                </td>
                <td>
                    <asp:Label ID="noOfCourtsLabel" runat="server" Text=""></asp:Label>
                </td>
                <td>
                    Open To Public:
                </td>
                <td>
                    <asp:Label ID="openToPublicLabel" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    Has Lights:
                </td>
                <td>
                    <asp:Label ID="lightsLabel" runat="server" Text=""></asp:Label>
                </td>
                <td>
                    Has Fees:
                </td>
                <td>
                    <asp:Label ID="feesLabel" runat="server" Text=""></asp:Label>
                </td>
            </tr>
        </table>
    </div>

    <script type="text/javascript">
        window.onload = GetMap;
    </script>

    </form>
</body>
</html>
