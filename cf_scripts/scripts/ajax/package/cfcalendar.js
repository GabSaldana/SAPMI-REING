/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.Calendar){
ColdFusion.Calendar={};
}
ColdFusion.Calendar.monthNamesShort=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
ColdFusion.Calendar.monthNamesLong=new Array("January","February","March","April","May","June","July","August","September","October","November","December");
ColdFusion.Calendar.dayNamesShort=new Array("Sun","Mon","Tue","Wed","Thu","Fri","Sat");
ColdFusion.Calendar.dayNamesLong=new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday");
ColdFusion.Calendar.calTableIdCounter=0;
if(navigator.userAgent.toLowerCase().indexOf("safari")>-1){
var set_month=Date.prototype.setMonth;
Date.prototype.setMonth=function(num){
if(num<=-1){
var n=Math.ceil(-num);
var _776=Math.ceil(n/12);
var _777=(n%12)?12-n%12:0;
this.setFullYear(this.getFullYear()-_776);
return set_month.call(this,_777);
}else{
return set_month.apply(this,arguments);
}
};
}
if(!String.escape){
String.escape=function(_778){
return _778.replace(/('|\\)/g,"\\$1");
};
}
ColdFusion.Calendar.setUpCalendar=function(_779,mask,_77b,_77c,_77d,_77e,_77f){
var _780=ColdFusion.DOM.getElement(_779+_77e+"_cf_button",_77e);
var _781=ColdFusion.DOM.getElement(_779,_77e);
var _782=null;
var _783=null;
if(_781.value!=""){
_782=_781.value;
_783=_782.split("/");
}
var _784=_779+"_cf_calendar"+ColdFusion.Calendar.calTableIdCounter;
ColdFusion.Calendar.calTableIdCounter++;
var _785=ColdFusion.DOM.getElement(_779+_77e+"_cf_container",_77e);
var _786=_781.offsetLeft;
ColdFusion.DOM.getElement(_779+_77e+"_cf_container",_77e).style.left=_786;
YAHOO.widget.Calendar.IMG_ROOT=_cf_ajaxscriptsrc+"/resources/yui/";
var _787;
if(_783&&_783[0]&&_783[2]){
_787=new YAHOO.widget.Calendar(_784,_779+_77e+"_cf_container",{close:true,pagedate:_783[0]+"/"+_783[2]});
}else{
_787=new YAHOO.widget.Calendar(_784,_779+_77e+"_cf_container",{close:true});
}
_787.calendarinputid=_779;
_787.calendarinput=_781;
_787.mask=mask;
_787.formname=_77e;
_787.cfg.setProperty("MONTHS_LONG",_77d);
_787.cfg.setProperty("WEEKDAYS_SHORT",_77c);
_787.cfg.setProperty("START_WEEKDAY",_77b);
ColdFusion.objectCache[_784+_77e]=_787;
_787.select(_782);
_787.render();
_787.hide();
_787.selectEvent.subscribe(ColdFusion.Calendar.handleDateSelect,_787,true);
YAHOO.util.Event.addListener(_779+_77e+"_cf_button","click",ColdFusion.Calendar.handleCalendarLinkClick,_787,true);
if(_77f!=null){
var year=_77f.year;
var _789=_77f.month;
var day=_77f.day;
var _78b=new Date(year,_789.valueOf()-1,day);
_781.value=ColdFusion.Calendar.createFormattedOutput(_779,mask,year,_789,day,_78b);
}
};
ColdFusion.Calendar.openedCalendarInstance=null;
ColdFusion.Calendar.handleCalendarLinkClick=function(type,args){
var _78e=args;
if(ColdFusion.Calendar.openedCalendarInstance){
ColdFusion.Calendar.openedCalendarInstance.hide();
}
if(!_78e.extMask){
var _78f=ColdFusion.Calendar.convertToExtMask(_78e.mask);
_78e.extMask=_78f;
}
var _790=ColdFusion.DOM.getElement(args.calendarinputid,_78e.formname).value;
var _791=null;
if(typeof (_790)!="undefined"&&ColdFusion.trim(_790)!=""){
_791=Ext.Date.parse(_790,_78e.extMask);
}
if(_791!=null){
_78e.setMonth(_791.getMonth());
_78e.setYear(_791.getFullYear());
_78e.select(_791);
_78e.render();
}
ColdFusion.Calendar.openedCalendarInstance=_78e;
_78e.show();
};
ColdFusion.Calendar.handleDateSelect=function(type,args,_794){
var _795=args[0];
var date=_795[0];
var year=date[0],month=date[1],day=date[2];
var _798=new Date(year,month.valueOf()-1,day);
var _799=_794.calendarinput.value;
_794.calendarinput.value=ColdFusion.Calendar.createFormattedOutput(_794.calendarinputid,_794.mask,year,month,day,_798);
ColdFusion.Event.callBindHandlers(_794.calendarinputid,null,"change");
_794.hide();
var node=document.getElementById(_794.calendarinputid);
if(node){
if(node.onchange){
if(node.value!=_799){
node.onchange();
}
}
}
};
ColdFusion.Calendar.convertToExtMask=function(mask){
mask=mask.toUpperCase();
if(mask.indexOf("DD")!=-1){
mask=mask.replace(/DD/g,"d");
}
if(mask.indexOf("D")!=-1){
mask=mask.replace(/D/g,"d");
}
if(mask.indexOf("MMMM")!=-1){
mask=mask.replace(/MMMM/g,"F");
}else{
if(mask.indexOf("MMM")!=-1){
mask=mask.replace(/MMM/g,"M");
}else{
if(mask.indexOf("MM")!=-1){
mask=mask.replace(/MM/g,"m");
}else{
if(mask.indexOf("M")!=-1){
mask=mask.replace(/M/g,"m");
}
}
}
}
if(mask.indexOf("YYYY")!=-1){
mask=mask.replace(/YYYY/g,"Y");
}
if(mask.indexOf("YY")!=-1){
mask=mask.replace(/YY/g,"y");
}
if(mask.indexOf("EEEE")!=-1){
mask=mask.replace(/EEEE/g,"l");
}
if(mask.indexOf("EEE")!=-1){
mask=mask.replace(/EEE/g,"D");
}
if(mask.indexOf("E")!=-1){
mask=mask.replace(/E/g,"w");
}
return mask;
};
ColdFusion.Calendar.createFormattedOutput=function(_79c,mask,year,_79f,day,date){
mask=mask.toUpperCase();
year=new String(year);
_79f=new String(_79f);
day=new String(day);
var _7a2=date.getDay();
if(mask.indexOf("DD")!=-1){
if(day.length==1){
day="0"+day;
}
mask=mask.replace(/DD/g,day);
}
if(mask.indexOf("D"!=-1)){
if(day.length!=-1&&day.charAt(0)=="0"){
day=day.charAt(1);
}
mask=mask.replace(/D/g,day);
}
if(mask.indexOf("MMMM")!=-1){
_79f=ColdFusion.Calendar.monthNamesLong[_79f.valueOf()-1];
mask=mask.replace(/MMMM/g,_79f);
}else{
if(mask.indexOf("MMM")!=-1){
_79f=ColdFusion.Calendar.monthNamesShort[_79f.valueOf()-1];
mask=mask.replace(/MMM/g,_79f);
}else{
if(mask.indexOf("MM")!=-1){
if(_79f.length==1){
_79f="0"+_79f;
}
mask=mask.replace(/MM/g,_79f);
}else{
if(mask.indexOf("M")!=-1){
if(_79f.length!=-1&&_79f.charAt(0)=="0"){
_79f=_79f.charAt(1);
}
mask=mask.replace(/M/g,_79f);
}
}
}
}
if(mask.indexOf("YYYY")!=-1){
mask=mask.replace(/YYYY/g,year);
}
if(mask.indexOf("YY")!=-1){
year=year.substring(2);
mask=mask.replace(/YY/g,year);
}
if(mask.indexOf("EEEE")!=-1){
_7a2=ColdFusion.Calendar.dayNamesLong[_7a2.valueOf()];
mask=mask.replace(/EEEE/g,_7a2);
}
if(mask.indexOf("EEE")!=-1){
_7a2=ColdFusion.Calendar.dayNamesShort[_7a2.valueOf()];
mask=mask.replace(/EEE/g,_7a2);
}
if(mask.indexOf("E")!=-1){
_7a2=_7a2.valueOf();
_7a2=new String(_7a2);
if(_7a2.length!=-1&&_7a2.charAt(0)=="0"&&_7a2.charAt(1)){
_7a2=_7a2.charAt(1);
}
mask=mask.replace(/E/g,_7a2);
}
return mask;
};
