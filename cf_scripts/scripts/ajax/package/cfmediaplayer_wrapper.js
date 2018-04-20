/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.MediaPlayer){
ColdFusion.MediaPlayer={};
}
var $MP=ColdFusion.MediaPlayer;
$MP.defaultSWFLocation=_cf_ajaxscriptsrc+"/resources/cf/assets/StrobeMediaPlayback.swf",$MP.defaultOptions={swf:$MP.defaultSWFLocation,width:480,height:275,src:"",javascriptControls:true,playButtonOverlay:true,loop:false,autoPlay:false,controlBarMode:"docked",javascriptCallbackFunction:"triggerHandler"};
$MP.playerMap={};
$MP.playerWrapperMap={};
$MP.playerOptionsMap={};
$MP.jsFunctionMap={};
$MP.titleDataMap={};
$MP.videoMonitorMap={};
$MP.bindInfoMap={};
$MP.bindElements={};
$MP.baseURI;
$MP.fancyBoxLeftBorderOffset=5;
$MP.fancyBoxBottonBorderOffset=6;
$MP.hasHTML5VideoPlaybackSupport=!!document.createElement("video").canPlayType;
String.prototype.trim=function(){
return this.replace(/^\s+|\s+$/g,"");
};
ColdFusion.MediaPlayer.init=function(_7a3){
var _7a4=$MP.defaultOptions;
_7a4.id=_7a3.id;
var _7a5={};
var _7a6={};
var _7a7={};
var _7a8=null;
var _7a9={onStart:null,onComplete:null,onPause:null,onError:null,onLoad:null,onStartCallback:playbackStart,onPauseCallback:playbackPause};
if(_7a3.width!=null&&typeof (_7a3.width)!="undefined"){
_7a4.width=_7a3.width;
}else{
_7a4.width=480;
}
if(_7a3.height!=null&&typeof (_7a3.height)!="undefined"){
_7a4.height=_7a3.height;
}else{
_7a4.height=275;
}
if(_7a3.baseURI!=null){
$MP.baseURI=_7a3.baseURI;
}
if(_7a3.src!=null&&_7a3.src!=""){
_7a4.src=resolveSource(_7a3.src);
}else{
_7a4.src="";
}
if(_7a3.PosterImage!=null&&_7a3.PosterImage!=""){
_7a4.poster=resolveSource(_7a3.PosterImage);
}else{
_7a4.poster="";
}
if(_7a3.javascriptControls==null){
_7a4.javascriptControls=true;
}
if(_7a3.playButtonOverlay==null){
_7a4.playButtonOverlay=true;
}
if(_7a3.repeat!=null){
if(_7a3.repeat=="true"){
_7a4.loop=true;
}else{
_7a4.loop=false;
}
}else{
_7a4.loop=false;
}
if(_7a3.autoPlay!=null){
if(_7a3.autoPlay=="true"){
_7a4.autoPlay=true;
}else{
_7a4.autoPlay=false;
}
}else{
_7a4.autoPlay=false;
}
if(_7a3.bgcolor!=null){
_7a4.backgroundColor=_7a3.bgcolor;
_7a6.bgColor=_7a3.bgcolor;
}
if(_7a3.controlbar!=null){
if(_7a3.controlbar==false){
_7a4.controlBarMode="none";
}else{
_7a4.controlBarMode="docked";
}
}
if(_7a3.skin!=null){
_7a4.skin=resolveSource(_7a3.skin);
}else{
_7a4.skin="";
}
if(_7a3.onComplete!=null){
_7a9.onComplete=_7a3.onComplete;
}
if(_7a3.onLoad!=null){
_7a9.onLoad=_7a3.onLoad;
}
if(_7a3.onStart!=null){
_7a9.onStart=_7a3.onStart;
}
if(_7a3.onPause!=null){
_7a9.onPause=_7a3.onPause;
}
if(_7a3.onError!=null){
_7a9.onError=_7a3.onError;
}
if(_7a3.onBind!=null){
_7a9.onBind=_7a3.onBind;
}
if(_7a3.hideTitle!=null){
_7a5.hideTitle=_7a3.hideTitle;
}
if(_7a3.title!=null){
_7a5.title=_7a3.title;
}
if(_7a3.title_text_color!=null){
_7a5.title_text_color=_7a3.title_text_color;
}
if(_7a3.title_bgcolor!=null){
_7a5.title_bgcolor=_7a3.title_bgcolor;
}
if(_7a3.border_left!=null){
_7a6.border_left=_7a3.border_left;
}
if(_7a3.border_right!=null){
_7a6.border_right=_7a3.border_right;
}
if(_7a3.border_top!=null){
_7a6.border_top=_7a3.border_top;
}
if(_7a3.border_bottom!=null){
_7a6.border_bottom=_7a3.border_bottom;
}
if(_7a3.progress_color!=null){
_7a7.progress_color=_7a3.progress_color;
}
if(_7a3.progress_bgcolor!=null){
_7a7.progress_bgcolor=_7a3.progress_bgcolor;
}
if(_7a3.controls_color!=null){
_7a7.controls_color=_7a3.controls_color;
}
if(_7a3.controlbar_bgcolor!=null){
_7a7.controlbar_bgcolor=_7a3.controlbar_bgcolor;
}
if(!_7a4.javascriptControls){
$(".strobeMediaPlaybackControlBar,.smp-error,.playoverlay").show();
}
if(_7a3.bindData!=null&&_7a3.bindData!="undefined"){
_7a8=$.extend(true,{},_7a4);
handleBindingMediaPlayer(_7a8,_7a3.bindData,_7a3.type,_7a9);
return;
}
handleWmode(_7a3,_7a4);
playerInitialization(_7a4,_7a3.type,_7a9,_7a5,_7a6,_7a7);
};
function handleWmode(_7aa,_7ab){
if(navigator.platform.indexOf("Linux")!=-1){
_7ab.wmode="direct";
return;
}
if(_7aa.wmode!=null){
_7ab.wmode=_7aa.wmode;
}else{
_7ab.wmode="direct";
}
var _7ac=document.getElementById(_7ab.id+"_"+"videoTitle");
if((_7ac!==null&&(_7aa.hideTitle==null||_7aa.hideTitle==false))||(_7ab.backgroundColor!=null&&_7ab.backgroundColor.trim()!="")){
_7ab.wmode="transparent";
}
}
function isValidSourceElementExist(_7ad,type){
if(_7ad.src!=null&&_7ad.src!=""){
if(type=="html"&&$MP.hasHTML5VideoPlaybackSupport&&isHTMLFileFormatSupported(_7ad.src)){
return true;
}else{
if(type=="flash"&&isFlashSupported()&&isFlashFileFormatSupported(_7ad.src)){
return true;
}
}
}
var _7af=document.getElementById(_7ad.id+"_extendData");
if(_7af==null||_7af.childNodes==null||!isFlashSupported()){
return false;
}
var _7b0=_7af.getElementsByTagName("source");
for(var k=0;k<_7b0.length;k++){
var src=_7b0[k].getAttribute("src");
if(type=="html"&&$MP.hasHTML5VideoPlaybackSupport&&isHTMLFileFormatSupported(src)){
return true;
}else{
if(type=="flash"&&isFlashSupported()&&isFlashFileFormatSupported(src)){
return true;
}
}
}
return false;
}
function hideTitle(id){
var _7b4=document.getElementById(id+"_"+"videoTitle");
if(_7b4==null){
id=id.substring(0,id.indexOf("_strobemediaplayback-video"));
_7b4=document.getElementById(id+"_"+"videoTitle");
}
if(_7b4!=null){
$("#"+id+"_"+"videoTitle").fadeOut(600,null);
}
}
function playbackStart(id){
var _7b6=getFuncMap(id);
if(_7b6.onStart!=null){
_7b6.onStart();
}
var _7b7=getWrapper(id);
if(_7b7!=null){
_7b7.playOverlay.fadeOut(600);
}
hideTitle(id);
}
function showTitle(id){
var _7b9=document.getElementById(id+"_"+"videoTitle");
if(_7b9==null){
id=id.substring(0,id.indexOf("_strobemediaplayback-video"));
_7b9=document.getElementById(id+"_"+"videoTitle");
}
if(_7b9!=null){
$("#"+id+"_"+"videoTitle").fadeIn(1,null);
}
}
function playbackPause(id){
var _7bb=getFuncMap(id);
if(_7bb.onPause!=null){
_7bb.onPause();
}
var _7bc=getWrapper(id);
if(_7bc!=null){
_7bc.playOverlay.fadeIn(600);
}
showTitle(id);
}
function playbackComplete(id){
var _7be=getFuncMap(id);
if(_7be.onComplete!=null){
_7be.onComplete();
}
var _7bf=getWrapper(id);
if(_7bf!=null){
_7bf.playOverlay.fadeIn(600);
_7bf.slider.css("left",0+"px");
_7bf.currenttime.html("0:00");
}
showTitle(id);
}
function updateFlashVideoSource(_7c0){
if(_7c0.src!=null&&_7c0.src!=""){
if(isFlashSupported()&&isFlashFileFormatSupported(_7c0.src)){
return;
}
}
var _7c1=document.getElementById(_7c0.id+"_extendData");
if(_7c1==null||_7c1.childNodes==null||!isFlashSupported()){
return;
}
var _7c2=_7c1.getElementsByTagName("source");
for(var k=0;k<_7c2.length;k++){
var src=_7c2[k].getAttribute("src");
if(isFlashSupported()&&isFlashFileFormatSupported(src)){
_7c0.src=resolveSource(src);
return;
}
}
return;
}
function playerInitialization(_7c5,type,_7c7,_7c8,_7c9,_7ca){
var _7cb=true;
var _7cc=isValidSourceElementExist(_7c5,"html");
var _7cd=isValidSourceElementExist(_7c5,"flash");
var _7ce=$MP.handleUserDefinedFlashParams(_7c5,type);
if(_7ce){
_7c5.favorFlashOverHtml5Video=true;
}else{
if(isFlashSupported()){
if(type==null||type=="flash"){
if(_7cd){
_7c5.favorFlashOverHtml5Video=true;
}else{
if(_7cc){
_7c5.favorFlashOverHtml5Video=false;
}else{
_7cb=false;
}
}
}else{
if(_7cc){
_7c5.favorFlashOverHtml5Video=false;
}else{
if(_7cd){
_7c5.favorFlashOverHtml5Video=true;
}else{
_7cb=false;
}
}
}
}else{
if($MP.hasHTML5VideoPlaybackSupport){
_7c5.favorFlashOverHtml5Video=false;
}else{
_7cb=false;
}
}
}
if(_7c5.favorFlashOverHtml5Video){
updateFlashVideoSource(_7c5);
}
if(!_7cb){
if($MP.hasHTML5VideoPlaybackSupport){
_7c5.favorFlashOverHtml5Video=false;
}else{
$(".playoverlay").hide();
ColdFusion.MediaPlayer.logError(_7c5.id,"The video could not be loaded");
return;
}
}
var _7cf={"tablet":{"startSize":{"width":+_7c5.width,"height":+_7c5.height},"name":_7c5.id+"_"+"strobemediaplayback-video"},"smartphone":{"startSize":{"width":+_7c5.width,"height":+_7c5.height},"name":_7c5.id+"_"+"strobemediaplayback-video"},"default":{"startSize":{"width":+_7c5.width,"height":+_7c5.height},"name":_7c5.id+"_"+"strobemediaplayback-video"}};
strobeMediaPlayback.draw(_7c5.id+"_"+"strobemediaplayback-video",_7cf,_7c5);
var _7d0=$("#"+_7c5.id+"_"+"strobemediaplayback-video");
var _7d1=$("#"+_7c5.id);
var _7d2=_7d1.get(0);
var _7d3;
if(_7d2==null){
_7c5.id=_7c5.id+"_strobemediaplayback-video";
$MP.playerOptionsMap[_7c5.id]=_7c5;
$MP.videoMonitorMap[_7c5.id]={paused:true,muted:false};
}else{
_7d3=$("#"+_7c5.id+"_"+"strobemediaplayback-video  .html5player").strobemediaplaybackhtml5(_7c5,_7c7);
$MP.playerMap[_7c5.id]=_7d2;
$MP.playerWrapperMap[_7c5.id]=_7d3;
$MP.playerOptionsMap[_7c5.id]=_7c5;
}
$MP.jsFunctionMap[_7c5.id]=_7c7;
$MP.titleDataMap[_7c5.id]=_7c8;
if(_7d2!=null&&_7d2.nodeName!=null&&_7d2.nodeName.toLowerCase()=="video"){
handleVolumeSlider(_7c5.id);
_7d2.volume=0.6;
handlePlayoverlay(_7c5.id,_7c5.width,_7c5.height);
handleErrorElement(_7c5.id,_7c5.width,_7c5.height);
var _7d4=$MP.playerWrapperMap[_7c5.id];
_7d4.playOverlay.css("display","block");
_7d0.css("width","100%");
_7d0.css("height","100%");
handlebackgroundColor(_7c5);
handleControlsStyle(_7c5.id,_7ca);
_7d3.useHTML5=true;
var _7d5=document.getElementById(_7c5.id+"_extendData");
if(_7d5!=null){
$MP.handleUserDefinedHTML5Element(_7d2,_7c5.id+"_extendData");
}else{
handleTitle(_7c5.id,_7c5.src,_7c8);
var _7d6=getFuncMap(_7c5.id);
var _7d7=document.getElementById(_7c5.id);
var _7d8=_7d7.getElementsByTagName("source");
if(_7d8!=null&&_7d8.length!=0){
_7d8[0].setAttribute("onerror","onError(event)");
}
}
}else{
handleTitle(_7c5.id,_7c5.src,_7c8);
}
handleBorderStyle(_7c5.id,_7c9);
if($MP.bindInfoMap[_7c5.id]==null){
var _7d9=document.getElementById(_7c5.id+"_extendData");
if(_7d9==null){
var id=_7c5.id.substring(0,_7c5.id.indexOf("_"));
_7d9=document.getElementById(id+"_extendData");
}
if(_7d9!=null&&_7d9.parentNode!=null){
_7d9.parentNode.removeChild(_7d9);
}
}
}
function handleVolumeChangeUI(_7db,_7dc){
var _7dd=getWrapper(_7db);
if(_7dc<=0){
_7dd.volumeHigh.css("background-position","0px -72px");
}else{
if(_7dc<=0.3){
_7dd.volumeHigh.css("background-position","-24px -72px");
}else{
if(_7dc<=0.7){
_7dd.volumeHigh.css("background-position","-48px -72px");
}else{
_7dd.volumeHigh.css("background-position","-72px -72px");
}
}
}
}
function handleVolumeSlider(_7de){
var _7df=getWrapper(_7de);
var _7e0=_7df.volumeSlider;
_7e0.slider({orientation:"vertical",range:"min",min:0,max:90,value:60,slide:function(_7e1,ui){
var _7e3=ui.value/100;
_7df.currentVolume=_7e3;
handleChangeVolume(_7de,_7e3);
}});
_7df.volumeHigh.mouseover(function(){
var _7e4=getWrapper(_7de);
var _7e5=_7e4.volumeSlider;
_7e5.css("display","block");
_7e4.volumeContainer.css("display","block");
});
_7df.volumeHigh.mouseout(function(_7e6){
var _7e7=getWrapper(_7de);
var _7e8=_7e7.volumeSlider;
var _7e9=_7e7.volumeContainer;
var _7ea=_7e6.relatedTarget;
if(_7ea.className!="controls"){
_7e8.css("display","none");
_7e9.css("display","none");
}
});
_7df.volumeHigh.click(function(_7eb){
var _7ec=getWrapper(_7de);
if(_7ec.currentVolume==null){
_7ec.currentVolume=0.6;
}
var pos=_7df.volumeHigh.css("background-position");
if(pos.indexOf("0px")!=0){
_7df.volumeHigh.css("background-position","0px -72px");
_7df.volumeSlider.slider("value",0);
handleChangeVolume(_7de,0);
}else{
_7df.volumeSlider.slider("value",_7ec.currentVolume*100);
if(_7ec.currentVolume<=0.1){
_7df.volumeHigh.css("background-position","0px -72px");
}else{
if(_7ec.currentVolume<=0.3){
_7df.volumeHigh.css("background-position","-24px -72px");
}else{
if(_7ec.currentVolume<=0.7){
_7df.volumeHigh.css("background-position","-48px -72px");
}else{
_7df.volumeHigh.css("background-position","-72px -72px");
}
}
}
handleChangeVolume(_7de,_7ec.currentVolume);
}
});
_7df.controlbar.mouseout(function(_7ee){
if(_7ee.relatedTarget==null){
return;
}
var _7ef=_7ee.relatedTarget.className;
if(_7ee.relatedTarget.className!="controls"&&_7ef!="volume-container"&&_7ef.indexOf("ui-slider")==-1){
var _7f0=getWrapper(_7de);
var _7f1=_7f0.volumeSlider;
var _7f2=_7f0.volumeContainer;
_7f1.css("display","none");
_7f2.css("display","none");
}
});
}
function handleBindingMediaPlayer(_7f3,_7f4,type,_7f6){
var _7f7=document.getElementById(_7f3.id+"_"+"html5MediaPlayback");
if(_7f7==null){
return;
}
var _7f8=_7f7.innerHTML;
if(_7f8==null){
return;
}
var _7f9={};
_7f9.videoContent=_7f8;
_7f9.type=type;
_7f9.player_options=_7f3;
_7f9.jsfunction=_7f6;
$MP.bindInfoMap[_7f3.id]=_7f9;
var _7fa=-1;
var _7fb=0;
var _7fc=_7f4;
do{
var _7fd;
_7fa=_7f4.indexOf(",",_7fb);
if(_7fa!=-1){
_7fd=_7f4.substring(_7fb,_7fa);
_7fb=_7fa+1;
_7fc=_7f4.substring(_7fa+1);
}else{
_7fd=_7fc;
}
var _7fe=_7fd;
var _7ff;
if(_7fd.indexOf("@")!=-1){
_7fe=_7fd.substring(0,_7fd.indexOf("@"));
_7ff=_7fd.substring(_7fd.indexOf("@")+1);
}else{
_7fe=_7fd;
_7ff="onClick";
}
var _800=document.getElementById(_7fe);
if(_800==null){
continue;
}
handleTitle(_7f3.id,_7f3.src);
var _801=getVideoTitle(_7f3.src);
if(_7ff==null||_7ff.toLowerCase()=="onclick"){
bindFancyBox(false,true,_7fe,_7ff,_7f3,type,_7f6,_7f8,_801);
}else{
var _802=document.getElementById(_7fe);
_7ff=_7ff.substring(2);
$("#"+_7fe).live(_7ff.toLowerCase(),function(e){
bindFancyBox(true,true,_7fe,_7ff,_7f3,type,_7f6,_7f8,_801);
});
}
}while(_7fa!=-1);
var _804=document.getElementById(_7f3.id+"_"+"mediacontainer");
_804.parentNode.removeChild(_804);
}
function bindFancyBox(fire,_806,_807,_808,_809,type,_80b,_80c,_80d){
var _80e=document.getElementById(_809.id+"_"+"videoTitle");
if(_80e==null){
_80d="";
}else{
if(_80d==null||_80d==""){
_80d="video";
}
}
if(fire){
$("#"+_807).fancybox({content:_80c,overlayShow:true,overlayOpacity:0.7,width:_809.width+$MP.fancyBoxLeftBorderOffset,height:_809.height+$MP.fancyBoxBottonBorderOffset,title:_80d,autoDimensions:false,onComplete:function(){
var _80f=$.extend(true,{},$MP.bindInfoMap[_809.id].player_options);
if(_806&&_80b.onBind!=null){
_80b.onBind(_807,_808);
}
var _810=$MP.bindInfoMap[_809.id].player_options;
playerInitialization(_810,type,_80b);
handleBindEvents(_810,$MP.bindInfoMap[_809.id]);
$MP.bindInfoMap[_809.id].player_options=$.extend(true,{},_80f);
}}).trigger("click");
}else{
$("#"+_807).fancybox({content:_80c,overlayShow:true,overlayOpacity:0.7,width:_809.width+$MP.fancyBoxLeftBorderOffset,height:_809.height+$MP.fancyBoxBottonBorderOffset,title:_80d,autoDimensions:false,onComplete:function(){
var _811=$.extend(true,{},$MP.bindInfoMap[_809.id].player_options);
if(_806&&_80b.onBind!=null){
_80b.onBind(_807,_808);
}
var _812=$MP.bindInfoMap[_809.id].player_options;
playerInitialization(_812,type,_80b);
handleBindEvents(_812,$MP.bindInfoMap[_809.id]);
$MP.bindInfoMap[_809.id].player_options=$.extend(true,{},_811);
}});
}
}
function handleBindEvents(_813,_814){
var _815=$MP.getPlayer(_813.id);
if(_814.mute!=null){
_815.muted=mute;
}
if(_814.volume!=null){
handleChangeVolume(_813.id,_814.volume);
}
if(_814.startPlay!=null){
_815.start();
}
if(_814.stopPlay!=null){
_815.pause();
}
}
function updateVideoType(_816){
var _817=_816.childNodes;
if(_817==null){
return;
}
var _818=_816.getElementsByTagName("source");
if(_818==null||_818.length===0){
return;
}
var _819=_818[0].getAttribute("src");
if(_819==null){
return;
}
var type=_818[0].getAttribute("type");
if(type!=null){
return;
}
if(_819.lastIndexOf(".")==-1){
return;
}
var _81b=_819.substring(_819.lastIndexOf(".")+1);
_81b=_81b.toLowerCase();
if(_81b=="mp4"){
_818[0].setAttribute("type","video/mp4");
}else{
if(_81b=="ogv"){
_818[0].setAttribute("type","video/ogg");
}else{
if(_81b=="webm"){
_818[0].setAttribute("type","video/webm");
}
}
}
}
$MP.handleUserDefinedHTML5Element=function(_81c,_81d){
var _81e=document.getElementById(_81d);
var _81f=_81e.childNodes;
var _820=false;
updateVideoType(_81c);
if(_81f!=null){
var _821=null;
for(var k=0;k<_81f.length;k++){
var _823=_81f[k];
if(_823.tagName!=null&&_823.tagName.toLowerCase()=="video"){
_821=_823;
break;
}
}
if(_821==null){
return;
}
_81f=_821.childNodes;
var _824=null;
var _825;
for(var i=0;i<_81f.length;i++){
var _823=_81f[i];
if(_823.tagName!=null&&_823.tagName.toLowerCase()=="track"){
_81c.appendChild(_823);
}else{
if(_823.tagName!=null&&_823.tagName.toLowerCase()=="source"){
if(!_820){
var _827=_81c.getAttribute("src");
if(_827==null){
var _828=_81c.childNodes;
if(_828!=null){
for(var l=0;l<_828.length;l++){
if(_828[l].tagName.toLowerCase()=="source"){
var src=_828[l].getAttribute("src");
if(src!=null&&src.trim()!=0&&isHTMLFileFormatSupported(src)){
_824=src;
break;
}
}
}
}
}
if(_827!=null&&_827!=""&&_827.lastIndexOf(".")!=-1){
var _82b=document.createElement("source");
_82b.setAttribute("src",_827);
var _82c=_827.substring(_827.lastIndexOf(".")+1);
if(_82c=="mp4"){
_82b.setAttribute("type","video/mp4");
}else{
if(_82c=="ogv"){
_82b.setAttribute("type","video/ogg");
}else{
if(_82c=="webm"){
_82b.setAttribute("type","video/webm");
}
}
}
_81c.appendChild(_82b);
}
if(_824==null&&isHTMLFileFormatSupported(_827)){
_824=_827;
}
_81c.removeAttribute("src");
}
var src=_823.getAttribute("src");
src=resolveSource(src);
_823.setAttribute("src",src);
_81c.appendChild(_823);
_820=true;
_825=_823;
if(_824==null&&isHTMLFileFormatSupported(src)){
_824=src;
}
}
}
}
if(_824!=null){
handleTitle(_81c.id,_824);
}
if(_825!=null){
_825.setAttribute("onerror","onError(event)");
}
}
_81c.load();
};
$MP.handleUserDefinedFlashParams=function(_82d,type){
var _82f=document.getElementById(_82d.id+"_extendData");
if(_82f==null||_82f.childNodes==null||!isFlashSupported()){
return;
}
var _830=_82f.childNodes;
var _831=false;
if(_830!=null){
var _832=null;
for(var k=0;k<_830.length;k++){
var _834=_830[k];
if(_834.tagName!=null&&(_834.tagName.toLowerCase()=="object"||_834.tagName.toLowerCase()=="video")){
_832=_834;
var _835=_832.childNodes;
for(var i=0;i<_835.length;i++){
var _834=_835[i];
if(_834.tagName!=null&&_834.tagName.toLowerCase()=="param"){
_831=true;
var _837=_834.getAttribute("name");
if(_837=="flashvars"){
var _838=_834.getAttribute("value");
var _839=0;
var _83a=_838;
do{
var _83b=_83a.indexOf("&");
var _83c;
if(_83b>0){
_83c=_83a.substring(_839,_83b);
}else{
_83c=_83a;
}
if(_83c.indexOf("=")>0){
var _83d=_83c.substring(0,_83c.indexOf("="));
var _83e=_83c.substring(_83c.indexOf("=")+1);
if(_83d!=""||_83e!=""){
_82d[_83d]=resolveSource(_83e);
}
}
_839=_83b+1;
_83a=_83a.substring(_839);
}while(_83b>0);
}
}
}
}
}
return _831;
}
};
function isFlashSupported(){
return swfobject.hasFlashPlayerVersion("1");
}
function isFlashFileFormatSupported(_83f){
if(_83f.indexOf("rtmp")==0){
return true;
}
var _840=["flv","f4v","f4m","m3u","mp4","swf","mpeg-4","m4v","f4f","3gpp","mp3","3gpp2","pbg","gif","jpg","jpeg","aac","speex","nellymoser","QuickTime"];
var _841=_83f.lastIndexOf(".");
var _842=_83f.substring(_841+1,_83f.length);
_842=_842.toLowerCase();
for(var i=0;i<_840.length;i++){
if(_840[i]==_842){
return true;
}
}
return false;
}
function isHTMLFileFormatSupported(_844){
if(_844==null){
return false;
}
var _845=["webm","mp4","ogv"];
var _846=_844.lastIndexOf(".");
var _847=_844.substring(_846+1,_844.length);
_847=_847.toLowerCase();
var elem=document.createElement("video");
var ogg=elem.canPlayType("video/ogg; codecs=\"theora\"");
var h264="video/mp4; codecs=\"avc1.42E01E";
var mp4=elem.canPlayType(h264+"\"")||elem.canPlayType(h264+", mp4a.40.2\"");
var webm=elem.canPlayType("video/webm; codecs=\"vp8, vorbis\"");
for(var i=0;i<_845.length;i++){
if(_845[i]==_847){
if(_847=="ogv"){
return ogg;
}else{
if(_847=="webm"){
return webm;
}else{
if(_847=="mp4"){
return mp4;
}
}
}
}
}
return false;
}
function getWrapper(name){
var _84f=$MP.playerWrapperMap[name];
if(_84f==null||typeof (_84f)=="undefined"){
return $MP.playerWrapperMap[name+"_strobemediaplayback-video"];
}
return _84f;
}
function getFuncMap(name){
var _851=$MP.jsFunctionMap[name];
if(_851==null||typeof (_851)=="undefined"){
return $MP.jsFunctionMap[name+"_strobemediaplayback-video"];
}
return _851;
}
ColdFusion.MediaPlayer.setMute=function(name,mute){
if($MP.bindInfoMap[name]!=null){
var _854=getBindInfo(name);
if(_854==null){
return;
}
_854.mute=mute;
return;
}
var _855=$MP.getPlayer(name);
var _856=$MP.getType(name);
var _857=getWrapper(name);
if(_856=="html"){
_855.muted=mute;
if(mute){
_857.volumeHigh.css("background-position","0px -72px");
_857.volumeSlider.slider("value",0);
}else{
handleChangeVolume(name,_855.volume);
}
}else{
if(_856=="flash"){
_855.setMuted(mute);
}
}
};
function resolveSource(src){
if(src==null){
return null;
}
if(src.charAt(0)!="/"&&src.indexOf("://")<0){
var _859="";
var _85a=document.location.href;
if(_85a||_85a.indexOf("/")>-1){
_859=_85a.substring(0,_85a.lastIndexOf("/")+1);
}
var _85b=_859+src;
var _85c=_85b.split("/");
var _85d=new Array();
var _85e=0;
for(var i=0;i<_85c.length;i++){
if(_85c[i]==".."){
_85d[--_85e]="";
}else{
_85d[_85e++]=_85c[i];
}
}
src=_85d[0];
for(var i=1;i<_85e;i++){
src=src+"/"+_85d[i];
}
}
if(src.indexOf("/")==0){
src=$MP.baseURI+src;
}
return src;
}
ColdFusion.MediaPlayer.getPlayer=function(name){
var _861=$MP.playerMap[name];
if(_861==null||typeof (_861)=="undefined"){
_861=$MP.playerMap[name+"_strobemediaplayback-video"];
if(_861==null||typeof (_861)=="undefined"){
ColdFusion.handleError(null,"mediaplayer.getplayer.notfound","widget",[name],null,null,true);
}
}
return _861;
};
ColdFusion.MediaPlayer.setTitle=function(name,_863){
if(_863==null){
ColdFusion.handleError(null,"mediaplayer.settitle.invalidtitle","widget",[name],null,null,true);
}
var _864=$MP.titleDataMap[name];
if(_864==null){
_864={};
$MP.titleDataMap[name]=_864;
}
var _865=document.getElementById(name+"_videoTitle");
if(_865==null){
var _866="<div id=\""+name+"_videoTitle\">";
$("#"+name+"_videoContainer").prepend(_866);
}
_864.hideTitle=false;
_864.title=_863;
handleTitle(name,_863,_864);
};
ColdFusion.MediaPlayer.setSource=function(name,src){
if(src==null||src=="undefined"){
ColdFusion.handleError(null,"mediaplayer.setsource.invalidsource","widget",[name],null,null,true);
}
if($MP.bindInfoMap[name]!=null){
var _869=getBindInfo(name);
if(_869==null){
return;
}
_869.player_options.src=resolveSource(src);
if(isFlashFileFormatSupported(src)&&isFlashSupported()){
_869.player_options.favorFlashOverHtml5Video=true;
}else{
_869.player_options.favorFlashOverHtml5Video=false;
}
_869.videoTitle=getVideoTitle(src);
return;
}
var _86a=$MP.getPlayer(name);
var _86b=$MP.getType(name);
src=resolveSource(src);
var _86c=getWrapper(name);
var _86d,jsFunctionMap;
if(_86c!=null&&_86c.errorwindow!=null){
_86c.errorwindow.html("");
_86c.errorwindow.hide();
_86d=$MP.playerOptionsMap[_86c.options.id];
}else{
_86d=$MP.playerOptionsMap[name+"_"+"strobemediaplayback-video"];
jsFunctionMap=$MP.jsFunctionMap[name+"_"+"strobemediaplayback-video"];
}
if(_86d==null){
_86d=$MP.defaultOptions;
}
var _86e={"tablet":{"name":_86d.id+"_"+"strobemediaplayback-video"},"smartphone":{"startSize":{"width":360,"height":200},"name":_86d.id+"_"+"strobemediaplayback-video"},"default":{"startSize":{"width":+_86d.width,"height":+_86d.height},"name":_86d.id+"_"+"strobemediaplayback-video"}};
if(_86b=="html"){
if(isHTMLFileFormatSupported(src)){
_86a.src=src;
_86a.load();
_86a.pause();
_86c.playOverlay.fadeIn(600);
_86c.playtoggle.removeClass("paused");
_86c.slider.css({"left":"0%"});
_86c.playedbar.css({"width":"0%"});
_86c.currenttime.html("0:00");
_86c.duration.html("0:00");
var css={"left":"0%","width":"0%"};
_86c.bufferbar.removeClass("done");
_86c.bufferbar.css(css);
var _870=$MP.titleDataMap[_86d.id];
handleTitle(name,src,_870);
}else{
if(isFlashFileFormatSupported(src)&&isFlashSupported()){
_86d.isHTML5=false;
_86d.favorFlashOverHtml5Video=true;
_86d.src=src;
var _870=$MP.titleDataMap[_86d.id];
if(_870.hideTitle!=null&&!_870.hideTitle){
_86d.wmode="opaque";
}
strobeMediaPlayback.draw(_86d.id+"_"+"strobemediaplayback-video",_86e,_86d);
var _871=$("#"+_86d.id+"_"+"strobemediaplayback-video");
var _872=_871.find("video");
var _873=_872.get(0);
var _874=$("#"+_86d.id+"_"+"strobemediaplayback-video  .html5player").strobemediaplaybackhtml5(_86d,_86c.jsCallbackFunctions);
$MP.playerMap[_86d.id]=_873;
$MP.playerWrapperMap[_86d.id]=_874;
handleTitle(_86d.id,_86d.src,_870);
}
}
}else{
if(_86b=="flash"){
if(isFlashFileFormatSupported(src)&&isFlashSupported()){
_86a.setMediaResourceURL(src);
handleTitle(name,src,$MP.titleDataMap[id]);
}else{
if(isHTMLFileFormatSupported(src)){
var id=_86d.id+"_strobemediaplayback-video";
$("#"+id).replaceWith("<div  id=\""+id+"\"></div>");
$("#"+id).css("visibility","visible");
_86d.isHTML5=true;
_86d.favorFlashOverHtml5Video=false;
_86d.src=src;
strobeMediaPlayback.draw(id,_86e,_86d);
var _871=$("#"+id);
var _872=_871.find("video");
var _873=_872.get(0);
if(_873==null){
return;
}
var _876=getFuncMap(id);
var _874=$("#"+id+"  .html5player").strobemediaplaybackhtml5(_86d,_876);
$MP.playerMap[_86d.id]=_873;
$MP.playerWrapperMap[_86d.id]=_874;
handlePlayoverlay(_86d.id,_86d.width,_86d.height);
handleErrorElement(_86d.id,_86d.width,_86d.height);
_874.playOverlay.css("display","block");
handleTitle(_86d.id,_86d.src,$MP.titleDataMap[id]);
_873.load();
if(_86d.autoPlay==false){
_873.pause();
}
}
}
}
}
};
function getBindInfo(name){
var _878=$MP.bindInfoMap[name];
if(_878!=null){
return _878;
}
return;
}
function handleBindElements(_879){
if(_879!=null){
if(_879.bindEvent==null||_879.bindEvent.toLowerCase()=="onclick"){
bindFancyBox(false,false,_879.bindElement,_879.player_options,_879.type,_879.jsFuncc,_879.videoContent,_879.videoTitle);
}else{
var _87a=document.getElementById(_879.bindElement);
var _87b=_879.bindEvent.substring(2);
$("#"+_879.bindElement).live(_87b.toLowerCase(),function(e){
bindFancyBox(true,false,_879.bindElement,_879.player_options,_879.type,_879.jsFuncc,_879.videoContent,_879.videoTitle);
});
}
}
}
function handleChangeVolume(name,_87e){
var _87f=$MP.getPlayer(name);
var _880=$MP.getType(name);
if(_880=="html"){
if(_87f.muted){
_87f.muted=false;
}
_87f.volume=_87e;
var _881=getWrapper(name);
var _882=_881.volumeSlider;
_882.slider("value",_87e*100);
handleVolumeChangeUI(name,_87e);
}else{
if(_880=="flash"){
_87f.setVolume(_87e);
}
}
}
ColdFusion.MediaPlayer.setVolume=function(name,_884){
if(_884<=0){
ColdFusion.handleError(null,"mediaplayer.setvolume.invalidvalue","widget",[name],null,null,true);
}
if($MP.bindInfoMap[name]!=null){
var _885=getBindInfo(name);
if(_885==null){
return;
}
_885.volume=_884;
return;
}
handleChangeVolume(name,_884);
};
ColdFusion.MediaPlayer.resize=function(name,_887,_888){
if(_887<=0||_888<=0){
ColdFusion.handleError(null,"mediaplayer.resize.invalidvalue","widget",[name],null,null,true);
}
if($MP.bindInfoMap[name]!=null){
var _889=getBindInfo(name);
if(_889==null){
return;
}
_889.player_options.width=_887;
_889.player_options.height=_888;
return;
}
var _88a=false;
var _88b=$MP.getPlayer(name);
var _88c=$MP.getType(name);
var _88d=getWrapper(name);
_88b.width=_887;
_88b.height=_888;
if(_88d!=null){
_88d.options.width=_887;
_88d.options.height=_888;
_88d.controlbar.css("width",_887-1.5);
if(_88d.options.width>180){
_88d.progressbar.css("width",_887-180);
_88d.trackswidth=_887-180;
}else{
_88d.progressbar.css("width","50%");
_88d.trackswidth="50%";
}
handlePlayoverlay(name,_887,_888);
handleErrorElement(name,_887,_888);
}
$("#"+name+"_"+"videoContainer").css("width",_887);
$("#"+name+"_"+"videoContainer").css("height",_888);
if(_88b.paused==false){
_88d.playOverlay.hide();
}
};
ColdFusion.MediaPlayer.getType=function(name){
var elem=document.getElementById(name);
if(elem==null||elem=="undefined"){
elem=document.getElementById(name+"_strobemediaplayback-video");
if(elem==null||typeof (elem)=="undefined"){
return "unknown";
}
}
var type=elem.nodeName;
if(type==null){
return "unknown";
}
type=type.toLowerCase();
if(type=="video"){
return "html";
}else{
if(type=="object"){
return "flash";
}else{
return "unknown";
}
}
};
ColdFusion.MediaPlayer.startPlay=function(name){
if($MP.bindInfoMap[name]!=null){
var _892=getBindInfo(name);
if(_892==null){
return;
}
_892.startPlay=true;
return;
}
var _893=$MP.getPlayer(name);
var _894=$MP.getType(name);
if(_894=="html"){
_893.play();
}else{
if(_894=="flash"){
_893.play2();
}
}
};
ColdFusion.MediaPlayer.stopPlay=function(name){
if($MP.bindInfoMap[name]!=null){
var _896=getBindInfo(name);
if(_896==null){
return;
}
_896.stopPlay=true;
return;
}
var _897=$MP.getPlayer(name);
_897.pause();
};
ColdFusion.MediaPlayer.logError=function(name,_899){
if(name==null||_899==null){
return;
}
var _89a=$MP.playerWrapperMap[name];
if(_89a==null){
_89a=$MP.playerWrapperMap[name+"_strobemediaplayback-video"];
if(_89a==null){
return;
}
}
_89a.errorwindow.html(_899);
_89a.errorwindow.show();
_89a.playOverlay.hide();
};
function handlePlayoverlay(name,_89c,_89d){
if(!isDesktop){
return;
}
var _89e=getWrapper(name);
_89e.playOverlay.css("left","");
_89e.playOverlay.css("top","");
_89e.playOverlay.css("left",(_89c-116)/2+"px");
_89e.playOverlay.css("top",(_89d-107)/2+"px");
}
function handleErrorElement(name,_8a0,_8a1){
var _8a2=getWrapper(name);
_8a2.playOverlay.css("display","none");
_8a2.errorwindow.css("left","");
_8a2.errorwindow.css("top","");
_8a2.errorwindow.css("display","none");
var _8a3=_8a2.controlbar;
var _8a4=0;
if(_8a3!=null){
_8a4=_8a3.css("height");
if(_8a4!=null&&_8a4.indexOf("px")!=-1){
_8a4=_8a4.substring(0,_8a4.indexOf("px"));
}else{
_8a4=0;
}
}
_8a2.errorwindow.css("margin-top",_8a1/2-_8a4+"px");
}
function handleTitleResize(id,_8a6,_8a7){
$("#"+id+"_videoTitle").css("width","");
$("#"+id+"_videoTitle").css("width",_8a6+"px");
}
function handleTitle(_8a8,_8a9,_8aa){
var _8ab=document.getElementById(_8a8+"_"+"videoTitle");
if(_8ab==null){
_8a8=_8a8.substring(0,_8a8.indexOf("_strobemediaplayback-video"));
_8ab=document.getElementById(_8a8+"_"+"videoTitle");
}
var _8ac=document.getElementById("fancybox-title-float-main");
if(_8ab!=null){
if(_8aa==null){
_8aa=$MP.titleDataMap[_8a8];
if(_8aa==null||_8aa.hideTitle){
var _8ad=_8ab.parentNode;
_8ad.removeChild(_8ab);
return;
}
}else{
if(_8aa.hideTitle){
var _8ad=_8ab.parentNode;
_8ad.removeChild(_8ab);
return;
}
}
var _8ae=_8aa.title;
if(_8aa==null||_8aa.title==null||_8aa.title.trim()==""){
_8ae=getVideoTitle(_8a9);
}
if(_8ae!=""){
_8ab.innerHTML=_8ae;
}else{
return;
}
$("#"+_8a8+"_"+"videoTitle").css("position","absolute");
$("#"+_8a8+"_"+"videoTitle").css("z-index",2);
if(_8aa==null||_8aa.title_text_color==null){
$("#"+_8a8+"_"+"videoTitle").css("color","white");
}else{
$("#"+_8a8+"_"+"videoTitle").css("color",_8aa.title_text_color);
}
if(_8aa!=null&&_8aa.title_bgcolor!=null){
$("#"+_8a8+"_"+"videoTitle").css("background-color",_8aa.title_bgcolor);
}
$("#"+_8a8+"_"+"videoTitle").css("font-weight","bold");
$("#"+_8a8+"_"+"videoTitle").css("font-family","Arial,Helvetica,sans-serif");
$("#"+_8a8+"_"+"videoTitle").css("font-size","13px");
$("#"+_8a8+"_"+"videoTitle").css("word-wrap","break-word");
if(_8ab.style.backgroundColor==null||_8ab.style.backgroundColor==""){
$("#"+_8a8+"_"+"videoTitle").css("margin-left","5px");
}
$("#"+_8a8+"_"+"videoTitle").show();
$("#"+_8a8+"_"+"strobemediaplayback").css("z-index",1);
}else{
if(_8ac!=null&&_8a9!=null){
$("#fancybox-title-float-main").text(_8a9);
}
}
}
function getVideoTitle(_8af){
var _8b0=null;
if(_8af!=null&&_8af!=""){
var _8b1=_8af.lastIndexOf("/");
if(_8b1==-1){
_8b1=_8af.lastIndexOf("\\");
}
if(_8b1==-1){
_8b0=_8af;
}
if(_8b0==null){
_8b0=_8af.substring(_8b1+1,_8af.length);
}
}
if(_8b0==null||_8b0.indexOf(".")<0){
return _8af;
}else{
return _8b0;
}
}
function handlebackgroundColor(_8b2){
if(_8b2.backgroundColor==null){
return;
}
var _8b3=document.getElementById(_8b2.id);
if(_8b3==null){
return;
}
_8b3.setAttribute("style","background-color:"+_8b2.backgroundColor+";");
}
function handleBorderStyle(_8b4,_8b5){
if(_8b5.hideBorder){
return;
}
var _8b6="#fff";
if(_8b5.bgColor){
_8b6=_8b5.bgColor;
}
var _8b7=document.getElementById(_8b4+"_"+"videoContainer");
if(_8b7==null){
_8b4=_8b4.substring(0,_8b4.indexOf("_"));
}
if(_8b5.border_left!=null){
$("#"+_8b4+"_"+"videoContainer").css("border-left",_8b5.border_left+"px"+" solid "+_8b6);
}
if(_8b5.border_right!=null){
$("#"+_8b4+"_"+"videoContainer").css("border-right",_8b5.border_right+"px"+" solid "+_8b6);
}
if(_8b5.border_top!=null){
$("#"+_8b4+"_"+"videoContainer").css("border-top",_8b5.border_top+"px"+" solid "+_8b6);
}
if(_8b5.border_bottom!=null){
$("#"+_8b4+"_"+"videoContainer").css("border-bottom",_8b5.border_bottom+"px"+" solid "+_8b6);
}
}
function handleControlsStyle(_8b8,_8b9){
var _8ba=getWrapper(_8b8);
if(_8b9.controlbar_bgcolor!=null){
_8ba.controlbar.css("background-color",_8b9.controlbar_bgcolor);
}
if(_8b9.controls_color!=null){
_8ba.playtoggle.css("background-color",_8b9.controls_color);
_8ba.slider.css("background-color",_8b9.controls_color);
_8ba.fullview.css("background-color",_8b9.controls_color);
_8ba.currenttime.css("color",_8b9.controls_color);
_8ba.duration.css("color",_8b9.controls_color);
_8ba.seekbar.css("background-color",_8b9.controls_color);
_8ba.volumeHigh.css("background-color",_8b9.controls_color);
}
if(_8b9.progress_bgcolor!=null){
_8ba.bufferbar.css("background-color",_8b9.progress_bgcolor);
}
if(_8b9.progress_color!=null){
_8ba.playedbar.css("background-color",_8b9.progress_color);
}
}
function triggerHandler(id,_8bc,_8bd){
if(_8bc=="onJavaScriptBridgeCreated"){
return;
}else{
if(_8bc=="play"){
var _8be=getFuncMap(id);
var _8bf=$MP.videoMonitorMap[id];
if(_8be.onStartCallback!=null&&_8bf.paused){
_8be.onStartCallback(id);
_8bf.paused=false;
}
hideTitle(id);
}else{
if(_8bc=="pause"){
var _8be=getFuncMap(id);
var _8bf=$MP.videoMonitorMap[id];
if(_8be.onPauseCallback!=null&&!_8bf.paused){
_8be.onPauseCallback(id);
_8bf.paused=true;
}
showTitle(id);
}else{
if(_8bc=="complete"){
var _8be=getFuncMap(id);
if(_8be.onComplete!=null){
_8be.onComplete();
}
var _8bf=$MP.videoMonitorMap[id];
_8bf.paused=true;
showTitle(id);
}else{
if(_8bc=="loadedmetadata"){
var _8be=getFuncMap(id);
if(_8be.onLoad!=null){
_8be.onLoad();
}
}else{
if(_8bc=="error"){
var _8be=getFuncMap(id);
if(_8be.onError!=null){
_8be.onError();
}
}else{
if(_8bc=="volumechange"){
var _8bf=$MP.videoMonitorMap[id];
_8bf.muted=_8bd.muted;
}
}
}
}
}
}
}
}
function onError(_8c0){
var _8c1;
var _8c2;
var _8c3;
var _8c4;
if(_8c0.target!=null&&_8c0.target.tagName.toLowerCase()=="video"){
_8c3=getFuncMap(_8c0.target.id);
if(_8c0.target.error!=null){
_8c2=_8c0.target.error.code;
}
_8c4=getWrapper(_8c0.target.id);
}else{
if(_8c0.target!=null&&_8c0.target.tagName.toLowerCase()=="source"){
var _8c5=_8c0.target.getAttribute("src");
var _8c6=_8c0.target.getAttribute("onerror");
if(_8c5!=null&&_8c6!=null){
_8c2=4;
}else{
return;
}
}
var _8c7=_8c0.target.parentNode;
_8c3=getFuncMap(_8c7.id);
_8c4=getWrapper(_8c7.id);
}
if(_8c2==null){
return;
}
if(_8c3.onError!=null){
_8c3.onError(_8c2);
return;
}
switch(_8c2){
case 1:
_8c1="You aborted the video playback.";
break;
case 2:
_8c1="A network error caused the video download to fail part-way.";
break;
case 3:
_8c1="The video playback was aborted due to a corruption problem or because the video used features your browser did not support.";
break;
case 4:
_8c1="The video could not be loaded, either because the server or network failed or because the format is not supported.";
break;
default:
_8c1="An unknown error occurred.";
break;
}
_8c4.playOverlay.css("display","none");
_8c4.errorwindow.html(_8c1);
_8c4.errorwindow.show();
}
function onFlashEmbedComplete(_8c8){
var _8c9=$("#"+_8c8.id);
var _8ca=_8c9.get(0);
$MP.playerMap[_8c8.id]=_8ca;
}
function removejscssfile(_8cb,_8cc){
var _8cd=(_8cc=="js")?"script":(_8cc=="css")?"link":"none";
var _8ce=(_8cc=="js")?"src":(_8cc=="css")?"href":"none";
var _8cf=document.getElementsByTagName(_8cd);
for(var i=_8cf.length;i>=0;i--){
if(_8cf[i]&&_8cf[i].getAttribute(_8ce)!=null&&_8cf[i].getAttribute(_8ce).indexOf(_8cb)!=-1){
_8cf[i].parentNode.removeChild(_8cf[i]);
}
}
}
