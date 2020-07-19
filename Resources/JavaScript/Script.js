var map = null;
var layer = null;
var directionTextContainer = null;
var mapCollectionId = null;

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
}

function loadCollection() {
    layer = new VEShapeLayer();
    var veLayerSpec = new VEShapeSourceSpecification(VEDataType.GeoRSS, mapCollectionId, layer);
    map.ImportShapeLayerData(veLayerSpec);
}

function GetMapLocation() {
    map = new VEMap('myMap');
    map.onLoadMap = loadCollectionLocation;
    map.HideScalebar();
    map.HideDashboard();
    var mapOptions = new VEMapOptions();
    mapOptions.EnableBirdseye = false;
    mapOptions.EnableDashboardLabels = false;
    try {
        map.LoadMap(new VELatLong(37.456636011596196, -97.40085000000001), null, null, null, null, null, null, mapOptions);
    }
    catch (ex) {
        alert("The following exception has occurred: " + ex.name + ", " + ex.message);
    }
}

function loadCollectionLocation() {
    layer = new VEShapeLayer();
    var veLayerSpec = new VEShapeSourceSpecification(VEDataType.GeoRSS, mapCollectionId, layer);
    map.ImportShapeLayerData(veLayerSpec,null,0);
}

function setMapWidthHeight(width, height, mapCollection) {
    var map = document.getElementById("myMap");
    map.style.width = width+"px";
    map.style.height = height+"px";
    mapCollectionId = mapCollection;
}

function zoomToTennisCourt(mapId) {
    map.HideInfoBox();
    var shape = layer.GetShapeByIndex(mapId);
    map.SetZoomLevel(17);
    map.SetCenter(new VELatLong(shape.GetPoints()[0].Latitude, shape.GetPoints()[0].Longitude));
    map.ShowInfoBox(shape);
    document.getElementById("myMap").focus();
    //ShowPopupMenu()
}

function ShowPopupMenu(startAddress, endAddress) {
    var x = map.GetLeft();
    var y = map.GetTop();

    try {
        directionTextContainer = document.getElementById('directionsText');
        var mapWidth = document.getElementById("myMap").style.width;
        directionTextContainer.style.display = 'block'; //Showing the menu
        directionTextContainer.style.left = x + (parseInt(mapWidth) - 400); //Positioning the menu
        directionTextContainer.style.top = y;

        var options = new VERouteOptions();
        options.DrawRoute = true;
        options.SetBestMapView = false;
        options.ShowDisambiguation = true;
        options.RouteCallback = onGotRoute;
        var locations = new Array(startAddress.replace("&", " and "), endAddress.replace("&", " and "));
        map.GetDirections(locations, options);
    }
    catch (e) {
        alert(e.message);
    }
}

function onGotRoute(route) {
    // Unroll route           
    var legs = route.RouteLegs;
    var turns = "<b>Total distance: " + route.Distance.toFixed(1) + " mi</b><br/><br/>";
    var numTurns = 0;
    var leg = null;
    // Get intermediate legs            
    for (var i = 0; i < legs.length; i++) {
        // Get this leg so we don't have to derefernce multiple times               
        leg = legs[i];
        // Leg is a VERouteLeg object                                 
        // Unroll each intermediate leg               
        var turn = null;
        // The itinerary leg                                 
        for (var j = 0; j < leg.Itinerary.Items.length; j++) {
            turn = leg.Itinerary.Items[j];
            // turn is a VERouteItineraryItem object
            numTurns++;
            turns += numTurns + ".&nbsp;&nbsp;" + turn.Text + " (" + turn.Distance.toFixed(1) + " mi)<br/>";
        }
    }
    document.getElementById("directionsBody").innerHTML = turns;
    layer.Hide();
    map.AttachEvent("onchangeview", panMap);
    map.SetMapView(layer.GetBoundingRectangle());
    map.DetachEvent("onchangeview", panMap);
}

function panMap() {
    map.Pan(200, 0);
}

function closeDirectionsText() {
    document.getElementById("directionsBody").innerHTML = "";
    directionTextContainer.style.display = "none";
    map.DeleteRoute();
    map.Pan(-200, 0);
    layer.Show();
    map.SetMapView(layer.GetBoundingRectangle());
}

function showStartEndPoints(endPoint) {
    document.getElementById("startEndPoints").style.display = 'block';
    document.getElementById("startTextBox").focus();
    document.getElementById("endTextBox").value = endPoint;
}

function validateDirection() {
    var error = "";
    var startAddress = document.getElementById("startTextBox").value;
    var endAddress = document.getElementById("endTextBox").value;
    if (startAddress == "") {
        error = "Please enter a start address";
    }
    if (endAddress == "") {
        error += "<br/>Please enter a destination address";
    }
    if (error != "") {
        alert(error);
    }
    else {
        ShowPopupMenu(startAddress, endAddress);
    }
}

function flipEndPoints() {
    var error = "";
    var startAddressTextBox = document.getElementById("startTextBox");
    var endAddressTextBox = document.getElementById("endTextBox");

    var startAddress = startAddressTextBox.value;
    var endAddress = endAddressTextBox.value;
    startAddressTextBox.value = endAddress;
    endAddressTextBox.value = startAddress;
}

function zoomToLocation() {
    var locationTextBox = document.getElementById("locationText");
    map.Find(null, locationTextBox.value);
}