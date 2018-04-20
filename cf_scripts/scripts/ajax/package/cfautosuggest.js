/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.Autosuggest){
ColdFusion.Autosuggest={};
}
var staticgifpath=_cf_ajaxscriptsrc+"/resources/cf/images/static.gif";
var dynamicgifpath=_cf_ajaxscriptsrc+"/resources/cf/images/loading.gif";
ColdFusion.Autosuggest.loadAutoSuggest=function(_696,_697){
var _698=ColdFusion.objectCache[_697.autosuggestid];
if(typeof (_696)=="string"){
_696=_696.split(",");
}else{
var _699=false;
if(_696&&ColdFusion.Util.isArray(_696)){
_699=true;
if(_696.length>0&&(typeof (_696[0])!="string"&&typeof (_696[0])!="number")){
_699=false;
}
}
if(!_699){
ColdFusion.handleError(_698.onbinderror,"autosuggest.loadautosuggest.invalidvalue","widget",[_697.autosuggestid]);
return;
}
}
var _69a=document.getElementById(_697.autosuggestid).value;
if(_69a.length==1&&_696.length==0){
var _69b=new Array();
_698.dataSource.flushCache();
_698.dataSource=new YAHOO.widget.DS_JSArray(_69b);
_698.autosuggestitems=_69b;
}
if(_696.length>0){
var i=0;
var _69d=false;
var _69b=new Array();
for(i=0;i<_696.length;i++){
if(_696[i]){
if(typeof (_696[i])=="string"){
_69b[i]=_696[i];
}else{
if(typeof (_696[i])=="number"){
_69b[i]=_696[i]+"";
}else{
_69b[i]=new String(_696[i]);
}
}
if(_69b[i].indexOf(_69a)==0){
_69d=true;
}
}
}
if(_69d==false&&_698.showloadingicon==true){
document.getElementById(_697.autosuggestid+"_cf_button").src=staticgifpath;
}
_698.dataSource.flushCache();
_698.dataSource=new YAHOO.widget.DS_JSArray(_69b);
_698.autosuggestitems=_69b;
if(_698.queryMatchContains){
_698.dataSource.queryMatchContains=_698.queryMatchContains;
}
_698._sendQuery(_69a);
}else{
if(_698.showloadingicon==true){
document.getElementById(_697.autosuggestid+"_cf_button").src=staticgifpath;
_698.showloadingicon==false;
}
}
};
ColdFusion.Autosuggest.checkToMakeBindCall=function(arg,_69f,_6a0,_6a1,_6a2){
var _6a1=document.getElementById(_69f).value;
if(!_6a0.isContainerOpen()&&_6a1.length>0&&arg.keyCode!=39&&(arg.keyCode>31||(arg.keyCode==8&&_6a0.valuePresent==true))){
_6a0.valuePresent=false;
if(_6a0.showloadingicon==true){
document.getElementById(_69f+"_cf_button").src=dynamicgifpath;
}
ColdFusion.Log.info("autosuggest.checktomakebindcall.fetching","widget",[_69f,_6a1]);
if(_6a0.cfqueryDelay>0){
var _6a3=setTimeout(_6a2,_6a0.cfqueryDelay*1000,this);
if(_6a0._nDelayID!=-1){
clearTimeout(_6a0._cf_nDelayID);
}
_6a0._cf_nDelayID=_6a3;
}else{
_6a2.call(this);
}
}
};
ColdFusion.Autosuggest.checkValueNotInAutosuggest=function(_6a4,_6a5){
if(_6a4.autosuggestitems){
for(var i=0;i<_6a4.autosuggestitems.length;i++){
if(_6a5==_6a4.autosuggestitems[i]){
return false;
}
}
}
return true;
};
ColdFusion.Autosuggest.triggerOnChange=function(type,args){
var _6a9=args[0];
var _6aa=document.getElementById(_6a9.id);
ColdFusion.Event.callBindHandlers(_6a9.id,null,"change");
};
ColdFusion.Autosuggest.init=function(_6ab,_6ac,_6ad){
return new YAHOO.widget.AutoComplete(_6ab,_6ac,_6ad);
};
ColdFusion.Autosuggest.getAutosuggestObject=function(_6ae){
var _6af=ColdFusion.objectCache[_6ae];
if(_6af==null||typeof (_6af)=="undefined"){
ColdFusion.handleError(null,"autosuggest.getAutosuggestObject.notfound","widget",[_6ae],null,null,true);
}
return _6af;
};
ColdFusion.Autosuggest.initJS_ARRAY=function(_6b0){
return new YAHOO.widget.DS_JSArray(_6b0);
};
