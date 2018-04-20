/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.Map){
ColdFusion.Map={};
}
var coldFusion_markerObjCache=new Array();
var $MAP=ColdFusion.Map;
$MAP.statusCodeObject={code200:"A directions request could not be successfully parsed. For example, the request may have been rejected if it contained more than the maximum number of waypoints allowed.",code400:"A directions request could not be successfully parsed. For example, the request may have been rejected if it contained more than the maximum number of waypoints allowed.",code500:"A geocoding or directions request could not be successfully processed, yet the exact reason for the failure is not known",code601:"The HTTP query parameter was either missing or had no value. For geocoding requests, this means that an empty address was specified as input. For directions requests, this means that no query was specified in the input",code602:"No corresponding geographic location could be found for the specified address. This may be due to the fact that the address is relatively new, or it may be incorrect",code603:"The geocode for the given address or the route for the given directions query cannot be returned due to legal or contractual reasons",code604:"The GDirections object could not compute directions between the points mentioned in the query. This is usually because there is no route available between the two points, or because we do not have data for routing in that region",code610:"This request was invalid.",code620:"The webpage has gone over the requests limit in too short a period of time."};
ColdFusion.Map._init=function(_417,_418,_419,type,_41b,_41c,_41d,_41e,_41f,_420,_421,_422,_423,_424,_425,_426,_427,_428,_429,_42a,_42b,_42c,_42d,_42e,_42f,_430,_431,_432,_433,_434,_435){
var _436=null;
if(navigator.geolocation){
navigator.geolocation.getCurrentPosition(function(_437){
if(_435<1){
_42a=_437.coords.latitude;
_42b=_437.coords.longitude;
_429=null;
}
if(_435!==0){
if(_435<0){
_435=_435*-1;
}
_42f[_435-1].latitude=_437.coords.latitude;
_42f[_435-1].longitude=_437.coords.longitude;
}
_436=ColdFusion.Map.init(_417,_418,_419,type,_41b,_41c,_41d,_41e,_41f,_420,_421,_422,_423,_424,_425,_426,_427,_428,_429,_42a,_42b,_42c,_42d,_42e,_42f,_430,_431,_432,_433,_434);
},function(_438){
_436=ColdFusion.Map.init(_417,_418,_419,type,_41b,_41c,_41d,_41e,_41f,_420,_421,_422,_423,_424,_425,_426,_427,_428,_429,_42a,_42b,_42c,_42d,_42e,_42f,_430,_431,_432,_433,_434);
});
}else{
_436=ColdFusion.Map.init(_417,_418,_419,type,_41b,_41c,_41d,_41e,_41f,_420,_421,_422,_423,_424,_425,_426,_427,_428,_429,_42a,_42b,_42c,_42d,_42e,_42f,_430,_431,_432,_433,_434);
}
return _436;
};
ColdFusion.Map.init=function(_439,_43a,_43b,type,_43d,_43e,_43f,_440,_441,_442,_443,_444,_445,_446,_447,_448,_449,_44a,_44b,_44c,_44d,_44e,_44f,_450,_451,_452,_453,_454,_455,_456){
var _457={divName:_439,type:type,layout:"fit",renderTo:_439,centerAddress:_44b,centerLatitude:_44c,centerLongitude:_44d,markerItems:_451,onLoad:_452,onError:_453,showCenterMarker:_446,showAllMarker:_447,markerColor:_44f,markerIcon:_450,markerBindListener:_455,initShow:_440};
if(_43b!=null&&typeof (_43b)!="undefined"){
_457.width=_43b;
}else{
_457.width=400;
}
if(_43a!=null&&typeof (_43a)!="undefined"){
_457.height=_43a;
}else{
_457.height=400;
}
if(_43d!=null&&typeof (_43d)!="undefined"){
_457.zoomLevel=_43d;
}else{
_457.zoomLevel=3;
}
_457.hideBorders=_43f;
if(!_43f){
if(_43e==null||typeof _43e==="undefined"||_43e.length==0){
_43e=" ";
}
_457.title=_43e;
_457.collapsible=_441;
}
if(_44f==null&&_450==null){
_457.markerColor="#00FF00";
}
var _458=new Ext.Panel(_457);
ColdFusion.objectCache[_439]=_457;
_457.mapPanel=_458;
var _459=["enableDragging"];
var swz=false;
if(_442){
swz=true;
}
if(_443){
_459.push("enableDoubleClickZoom");
}else{
_459.push("disableDoubleClickZoom");
}
if(_444){
_459.push("enableContinuousZoom");
}else{
_459.push("disableContinuousZoom");
}
var _45b=["NonExistantControl"];
if(_445){
_45b.push("scaleControl");
}
var mtc=false;
var mtco="";
if(_449&&_449.toUpperCase()=="BASIC"){
mtc=true;
mtco="google.maps.MapTypeControlStyle.HORIZONTAL_BAR";
}else{
if(_449&&_449.toUpperCase()=="ADVANCED"){
mtc="true";
mtco=google.maps.MapTypeControlStyle.DROPDOWN_MENU;
}
}
if(_448){
_45b.push("overviewMapControl");
}
var zc=false;
var zco="";
if(_44a!=null&&_44a!="undefined"){
_44a=_44a.toUpperCase();
switch(_44a){
case "SMALL":
zco=google.maps.ZoomControlStyle.SMALL;
zc=true;
break;
case "SMALL3D":
zco=google.maps.ZoomControlStyle.SMALL;
zc=true;
break;
case "LARGE":
zco=google.maps.ZoomControlStyle.LARGE;
zc=true;
break;
case "LARGE3D":
zco=google.maps.ZoomControlStyle.LARGE;
zc=true;
break;
}
}
var _460=[];
for(i=0;i<_457.markerItems.length;i++){
var _461=$MAP.parseMarker(_457.markerItems[i],_439);
_460.push(_461);
}
if(_44e==null||typeof _44e==="undefined"){
_44e="";
}
var _462={marker:{title:_44e,iscenter:true}};
if(_457.markerColor!=null&&typeof _457.markerColor!="undefined"){
_462.marker.markercolor=_457.markerColor;
}else{
if(_457.markerIcon!=null&&typeof _457.markerIcon!="undefined"){
_462.marker.markericon=_457.markerIcon;
}
}
if(_454===true){
_462.listeners={click:$MAP.markerOnClickHandler};
if(_456!=null){
_462.marker.markerwindowcontent=_456;
}else{
_462.marker.bindcallback=_455;
}
_462.marker.name=_439;
}
if(_457.centerAddress!=null&&typeof _457.centerAddress==="string"){
_462.geoCodeAddr=_457.centerAddress;
_462.marker.address=_457.centerAddress;
}else{
_462.lat=_457.centerLatitude;
_462.lng=_457.centerLongitude;
_462.marker.address=_457.centerAddress;
}
var _463=false;
if(_449!=null&&typeof _449=="string"&&_449.toUpperCase()=="ADVANCED"){
_463=true;
}
var _464=new Ext.ux.GMapPanel({xtype:"gmappanel",region:"center",zoomLevel:_457.zoomLevel,gmapType:_457.type,mapConfOpts:_459,mapControls:_45b,setCenter:_462,markers:_460,border:!_457.hideBorders,onLoadhandler:$MAP.onLoadCompleteHandler,onErrorhandler:_453,name:_457.divName,noCenterMarker:!_446,showAllMarker:_447,advanceMapTypeControl:_463,initShow:_440,zc:zc,zco:zco,mtc:mtc,mtco:mtco,swz:swz});
_458.add(_464);
_457.mapPanelObject=_464;
if(_440===false){
_458.hide();
}else{
_458.doLayout();
}
ColdFusion.Log.info("map.initialized","widget",[_439]);
return _458;
};
$MAP.addMarker=function(name,_466){
var _467=$MAP.getMapPanelObject(name);
var _468=$MAP.parseMarker(_466,name);
var _469=[];
_469.push(_468);
_467.addMarkers(_469);
ColdFusion.Log.info("map.addmarker.markeradded","widget",[name,_469.length]);
};
$MAP.setCenter=function(name,_46b){
var _46c=$MAP.getMapPanelObject(name);
var lat;
var lng;
if(_46b.latitude&&_46b.longitude){
if(typeof _46b.latitude!="number"||typeof _46b.longitude!="number"){
ColdFusion.handleError(null,"map.setcenter.latlngnonnumeric","widget",[name,_46b.latitude,_46b.longitude],null,null,true);
}else{
lat=_46b.latitude;
lng=_46b.longitude;
}
var _46f=new google.maps.LatLng(lat,lng);
_46c.getMap().setCenter(_46f,_46c.zoomLevel);
var _470={};
_470.markercolor="#00FF00";
_46c.addMarker(new google.maps.LatLng(_46b.latitude,_46b.longitude),_470,null,true);
}else{
if(_46b.address){
if(typeof _46b.address!="string"){
ColdFusion.handleError(null,"map.setcenter.addressnotstring","widget",[name,_46b.address],null,null,true);
}else{
_46c.geoCodeLookup(_46b.address,null,null,true);
}
}else{
ColdFusion.handleError(null,"map.setcenter.invalidcenter","widget",[name],null,null,true);
}
}
ColdFusion.Log.info("map.setcenter.centerset","widget",[name]);
};
$MAP.getLatitudeLongitude=function(_471,_472){
geocoder=new google.maps.Geocoder();
if(_472==null||!typeof _472==="function"){
_472=$MAP.LatitudeLongitudeHandler;
}
geocoder.geocode({"address":_471},_472);
};
$MAP.addEvent=function(name,_474,_475,_476){
if(_474=="singlerightclick"){
_474="rightclick";
}
if(_474=="maptypechanged"){
_474="maptypeid_changed";
}
var _477=$MAP.getMapPanelObject(name);
_477.addEventToMap(_474,_475,_476);
};
$MAP.setZoomLevel=function(name,_479){
var _47a=$MAP.getMapPanelObject(name);
_47a.zoomLevel=_479;
_47a.getMap().setZoom(_479);
};
$MAP.getMapObject=function(name){
var _47c=$MAP.getMapPanelObject(name);
if(_47c!=null){
return _47c.getMap();
}
};
$MAP.parseMarker=function(_47d,_47e){
var _47f={};
if(_47d.latitude&&_47d.longitude){
if(typeof _47d.latitude!="number"||typeof _47d.longitude!="number"){
ColdFusion.handleError(null,"map.marker.latlngnonnumeric","widget",[_47d.latitude,_47d.longitude],null,null,true);
}else{
_47f.lat=_47d.latitude;
_47f.lng=_47d.longitude;
}
}else{
if(_47d.address!=null){
if(typeof _47d.address!="string"){
ColdFusion.handleError(null,"map.marker.addressnotstring","widget",[_47d.address],null,null,true);
}else{
_47f.address=_47d.address;
}
}
}
var _480={};
if(_47d.tip==null){
_480.title="";
}else{
_480.title=_47d.tip;
}
if(_47d.markercolor!=null&&typeof _47d.markercolor!="undefined"){
_480.markercolor=_47d.markercolor;
}else{
if(_47d.markericon!=null&&typeof _47d.markericon!="undefined"){
_480.markericon=_47d.markericon;
}
}
if(_47d.showmarkerwindow===true||_47d.markerwindowcontent!=null){
var _481=ColdFusion.objectCache[_47e];
var _482;
if(_481!=null||typeof (_481)!="undefined"){
_482=_481.markerBindListener;
}
if(_482!=null||_47d.markerwindowcontent!=null){
_47f.listeners={click:$MAP.markerOnClickHandler};
if(_47d.markerwindowcontent!=null){
_480.markerwindowcontent=_47d.markerwindowcontent;
}else{
_480.bindcallback=_482;
}
_480.name=_47d.name;
}
}
_47f.marker=_480;
return _47f;
};
$MAP.onErrorHandler=function(name,_484){
var _485=ColdFusion.objectCache[name];
var _486=$MAP.statusCodeObject;
var _487=$MAP.retrieveStatueMessage(_484);
var _488=_485.onError;
if(_488!=null&&typeof _488==="function"){
_488.call(null,_484,_487);
}else{
alert("Error: "+_487);
}
ColdFusion.handleError(null,"map.loadMap.error","map",[name,_484,_487],null,null,true);
};
$MAP.onLoadCompleteHandler=function(name){
var _48a=ColdFusion.objectCache[name];
var _48b=_48a.onLoad;
if(_48b!=null&&typeof _48b==="function"){
_48b.call();
}
};
$MAP.retrieveStatueMessage=function(code){
var _48d;
switch(code){
case "ZERO_RESULTS":
_48d=$MAP.statusCodeObject.code602;
break;
case "OVER_QUERY_LIMIT":
_48d=$MAP.statusCodeObject.code620;
break;
case "REQUEST_DENIED":
_48d=$MAP.statusCodeObject.code610;
break;
case "INVALID_REQUEST":
_48d=$MAP.statusCodeObject.code610;
break;
}
return _48d;
};
var currentopenwindow="";
$MAP.markerOnClickHandler=function(_48e){
coldFusion_markerObjCache[this.name]=this.scope.marker;
if(this.bindcallback!=null&&typeof this.bindcallback=="function"){
var _48f=this.address;
if(_48f==null||typeof _48f=="undefined"){
_48f="";
}
this.bindcallback.call(null,this.name,_48e.latLng.lat(),_48e.latLng.lng(),_48f);
}else{
if(this.scope.statictext!=null&&typeof this.scope.statictext!="undefined"){
var me=this,infoWindow=new google.maps.InfoWindow({content:this.scope.statictext,position:this.scope.marker.position});
if(currentopenwindow!=""){
currentopenwindow.close();
}
infoWindow.open(this.scope.marker.map);
currentopenwindow=infoWindow;
}
}
};
ColdFusion.Map.loadMarkerWindowInfo=function(data,_492){
var _493=coldFusion_markerObjCache[_492._cf_marker_name];
var me=this,infoWindow=new google.maps.InfoWindow({content:data,position:_493.position});
if(currentopenwindow!=""){
currentopenwindow.close();
}
infoWindow.open(_493.map);
currentopenwindow=infoWindow;
};
ColdFusion.Map.bindOnErrorHandler=function(data,_496){
ColdFusion.handleError(null,"map.markerbind.binderror","widget",[data],null,null,true);
};
$MAP.getMapPanelObject=function(name){
var _498=ColdFusion.objectCache[name];
if(_498==null||typeof (_498)=="undefined"){
ColdFusion.handleError(null,"map.getmappanelobject.notfound","widget",[name],null,null,true);
}
return _498.mapPanelObject;
};
$MAP.refresh=function(name){
var _49a=ColdFusion.objectCache[name];
if(_49a==null||typeof (_49a)=="undefined"){
ColdFusion.handleError(null,"map.refresh.notfound","widget",[name],null,null,true);
}
_49a.mapPanel.doLayout();
};
$MAP.hide=function(name){
var _49c=ColdFusion.objectCache[name];
if(_49c==null||typeof (_49c)=="undefined"){
ColdFusion.handleError(null,"map.hide.notfound","widget",[name],null,null,true);
}
_49c.mapPanel.hide();
};
$MAP.show=function(name){
var _49e=ColdFusion.objectCache[name];
if(_49e==null||typeof (_49e)=="undefined"){
ColdFusion.handleError(null,"map.show.notfound","widget",[name],null,null,true);
}
_49e.mapPanel.show();
_49e.mapPanel.doLayout();
};
