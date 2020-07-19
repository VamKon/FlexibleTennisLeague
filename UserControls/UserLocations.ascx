<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserLocations.ascx.cs"
    Inherits="FlexibleTennisLeague.UserControls.UserLocations" %>

<script type="text/javascript" src="http://dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=6.2"></script>

<script type="text/javascript">
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
        map.SetMapStyle(VEMapStyle.Road);
    }

    function loadCollection() {
        layer = new VEShapeLayer();
        var veLayerSpec = new VEShapeSourceSpecification(VEDataType.GeoRSS, '<%=geoRSSFeed %>', layer);
        //var veLayerSpec = new VEShapeSourceSpecification(VEDataType.VECollection, 'AA39228CD7CD85FA!159', layer);
        map.ImportShapeLayerData(veLayerSpec, onFeed1Load, true);
    }

    function onFeed1Load(layer) {
        var numShapes = layer.GetShapeCount();
        for (var i = 0; i < numShapes; ++i) {
            var s = layer.GetShapeByIndex(i);
            s.SetCustomIcon("/resources/images/schedule.png");
        }
    }


</script>
<div class="greyContent">
    <p class="heading">
        <asp:Label ID="leagueLabel" runat="server" Text="Player Locator"></asp:Label>
    </p>
    (Mouse over the pushpins to see player details.)
<div id='myMap' name="myMap" style="position: relative; width: 825px; height: 400px;">
</div>
</div>

<script type="text/javascript">
    window.onload = GetMap;
</script>

