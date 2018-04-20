/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.MessageBox){
ColdFusion.MessageBox={};
}
var $MB=ColdFusion.MessageBox;
var $XB=Ext.MessageBox;
var DEFAULT_OK=$XB.buttonText.ok;
var DEFAULT_NO=$XB.buttonText.no;
var DEFAULT_CANCEL=$XB.buttonText.cancel;
var DEFAULT_YES=$XB.buttonText.yes;
var DEFAULT_ALERT_BUTTON_TYPE=$XB.OK;
var DEFAULT_CONFIRM_BUTTON_TYPE=$XB.YESNO;
var DEFAULT_PROMPT_BUTTON_TYPE=$XB.OKCANCEL;
var CF_BEFORE_SHOW_HANDLER_ADDED=false;
var CURRENT_MESSAGEBOX_ID;
ColdFusion.MessageBox.init=function(_8d1,type,_8d3,_8d4,_8d5,_8d6,_8d7,_8d8,_8d9,_8da,_8db,icon,_8dd,x,y,_8e0,_8e1){
var _8e2={messageBoxId:_8d1,type:type,callBack_Fn:_8db,multiline:_8d9,modal:_8da,width:_8dd,bodyStyle:_8e1};
if(_8d3==null||typeof (_8d3)=="undefined"){
_8d3="";
}
_8d3=ColdFusion.Util.replaceAll(_8d3,"\n","<br>");
_8e2.messageText=_8d3;
if(_8d5!=null&&typeof (_8d5)!="undefined"){
_8e2.label_OK=_8d5;
}
if(_8d6!=null&&typeof (_8d6)!="undefined"){
_8e2.label_NO=_8d6;
}
if(_8d8!=null&&typeof (_8d8)!="undefined"){
_8e2.label_YES=_8d8;
}
if(_8d7!=null&&typeof (_8d7)!="undefined"){
_8e2.label_CANCEL=_8d7;
}
if(_8d4==null||typeof (_8d4)=="undefined"){
type=type.toLowerCase();
if(type=="alert"){
_8d4="Alert";
}else{
if(type=="confirm"){
_8d4="Confirm";
}else{
if(type=="prompt"){
_8d4="Prompt";
}
}
}
}
_8e2.title=_8d4;
if(_8e0&&typeof (_8e0)=="string"){
_8e2.buttonType=_8e0;
}
if(icon&&typeof (icon)=="string"){
_8e2.icon=icon;
}
if(typeof x=="number"&&x>=0){
_8e2.x=x;
}
if(typeof y=="number"&&y>=0){
_8e2.y=y;
}
ColdFusion.objectCache[_8d1]=_8e2;
};
$MB.show=function(_8e3){
var _8e4=$MB.getMessageBoxObject(_8e3);
var type=_8e4.type;
type=(new String(type)).toLowerCase();
if(!CF_BEFORE_SHOW_HANDLER_ADDED){
var _8e6=Ext.MessageBox;
_8e6.addListener("show",$MB.beforeShowHandler,_8e4);
CF_BEFORE_SHOW_HANDLER_ADDED=true;
}
CURRENT_MESSAGEBOX_ID=_8e3;
var _8e7=_8e4.buttonType;
var _8e8={ok:DEFAULT_OK,no:DEFAULT_NO,cancel:DEFAULT_CANCEL,yes:DEFAULT_YES};
if(_8e4.label_OK){
_8e8.ok=_8e4.label_OK;
}
if(_8e4.label_YES){
_8e8.yes=_8e4.label_YES;
}
if(_8e4.label_NO){
_8e8.no=_8e4.label_NO;
}
if(_8e4.label_CANCEL){
_8e8.cancel=_8e4.label_CANCEL;
}
Ext.MessageBox.buttonText=_8e8;
if(typeof _8e7!="undefined"){
_8e7=_8e7.toUpperCase();
if(_8e7&&_8e7!=="OKCANCEL"&&_8e7!=="OK"&&_8e7!=="YESNOCANCEL"&&_8e7!=="YESNO"){
ColdFusion.handleError(null,"messagebox.show.invalidbuttontype","widget",[messagebox,_8e7],null,null,true);
}
switch(_8e7){
case "OK":
_8e7=$XB.OK;
break;
case "OKCANCEL":
_8e7=$XB.OKCANCEL;
break;
case "YESNOCANCEL":
_8e7=$XB.YESNOCANCEL;
break;
case "YESNO":
_8e7=$XB.YESNO;
break;
}
}
var icon=_8e4.icon;
var _8ea="";
if(icon&&typeof (icon)==="string"){
icon=icon.toUpperCase();
switch(icon){
case "ERROR":
_8ea=$XB.ERROR;
break;
case "INFO":
_8ea=$XB.INFO;
break;
case "QUESTION":
_8ea=$XB.QUESTION;
break;
case "WARNING":
_8ea=$XB.WARNING;
break;
}
}
var _8eb={title:_8e4.title,msg:_8e4.messageText,fn:_8e4.callBack_Fn,modal:_8e4.modal,icon:_8ea,scope:null};
if(_8e4.width){
_8eb.width=_8e4.width;
if(_8eb.width>600){
_8eb.maxWidth=_8eb.width;
}
if(_8eb.width<100){
_8eb.minWidth=_8eb.width;
}
}
if(type==="alert"){
if(!_8e7){
_8e7=DEFAULT_ALERT_BUTTON_TYPE;
}
_8eb.buttons=_8e7;
$XB.show(_8eb);
}
if(type==="confirm"){
if(!_8e7){
_8e7=DEFAULT_CONFIRM_BUTTON_TYPE;
}
_8eb.buttons=_8e7;
$XB.show(_8eb);
}
if(type==="prompt"){
if(!_8e7){
_8e7=DEFAULT_PROMPT_BUTTON_TYPE;
}
_8eb.buttons=_8e7;
_8eb.prompt=true;
_8eb.multiline=_8e4.multiline;
_8eb.value="",$XB.show(_8eb);
}
ColdFusion.Log.info("messagebox.show.shown","widget",[_8e3]);
};
$MB.create=function(_8ec,type,_8ee,_8ef,_8f0,_8f1){
if(_8ec&&typeof _8ec!="string"){
ColdFusion.handleError(null,"messagebox.create.invalidname","widget",null,null,null,true);
return;
}
if(!_8ec||ColdFusion.trim(_8ec)==""){
ColdFusion.handleError(null,"messagebox.create.invalidname","widget",null,null,null,true);
return;
}
var _8f2=ColdFusion.objectCache[_8ec];
if(_8f2!=null||typeof _8f2!="undefined"){
ColdFusion.handleError(null,"messagebox.create.duplicatename","widget",[_8ec],null,null,true);
return;
}
if(_8ef&&typeof _8ef!="string"){
ColdFusion.handleError(null,"messagebox.create.invalidmessage","widget",[_8ec],null,null,true);
return;
}
if(!_8ef||ColdFusion.trim(_8ef)==""){
ColdFusion.handleError(null,"messagebox.create.invalidmessage","widget",[_8ec],null,null,true);
return;
}
if(_8ee&&typeof _8ee!="string"){
ColdFusion.handleError(null,"messagebox.create.invalidtitle","widget",[_8ec],null,null,true);
return;
}
if(type&&typeof type!="string"){
ColdFusion.handleError(null,"messagebox.create.invalidtype","widget",[_8ec],null,null,true);
return;
}
if(!type||ColdFusion.trim(type)==""){
ColdFusion.handleError(null,"messagebox.create.emptytype","widget",[_8ec],null,null,true);
return;
}
if(_8f0&&typeof _8f0!=="function"){
ColdFusion.handleError(null,"messagebox.create.invalidcallback","widget",[_8ec],null,null,true);
return;
}
var _8f3=DEFAULT_CANCEL;
var _8f4=DEFAULT_NO;
var _8f5=DEFAULT_OK;
var _8f6=DEFAULT_YES;
var _8f7=true;
var _8f8=null;
var _8f9=false;
var icon;
var _8fb;
var x;
var y;
var _8fe;
if(_8f1&&_8f1.labelok){
_8f5=_8f1.labelok;
}
if(_8f1&&_8f1.labelno){
_8f4=_8f1.labelno;
}
if(_8f1&&_8f1.labelyes){
_8f6=_8f1.labelyes;
}
if(_8f1&&_8f1.labelcancel){
_8f3=_8f1.labelcancel;
}
if(_8f1&&typeof _8f1.multiline==="boolean"){
_8f9=_8f1.multiline;
}
if(_8f1&&typeof _8f1.modal==="boolean"){
_8f7=_8f1.modal;
}
if(_8f1&&_8f1.buttontype){
_8f8=_8f1.buttontype;
if(type.toUpperCase()!=="CONFIRM"){
ColdFusion.handleError(null,"messagebox.create.invalidtypeandbuttontypecombination","widget",[_8ec],null,null,true);
}else{
if(_8f8.toUpperCase()!="YESNO"&&_8f8.toUpperCase()!="YESNOCANCEL"){
ColdFusion.handleError(null,"messagebox.create.invalidbuttontype","widget",[_8ec,_8f8],null,null,true);
}
}
}
if(_8f1&&_8f1.width){
_8fb=_8f1.width;
if(_8fb&&typeof _8fb!="number"){
ColdFusion.handleError(null,"messagebox.create.widthnotnumeric","widget",[_8ec,_8fb],null,null,true);
}
}
if(_8f1&&typeof _8f1.x!="undefined "){
if(_8f1.x&&typeof _8f1.x!="number"){
ColdFusion.handleError(null,"messagebox.create.xnotnumeric","widget",[_8ec,_8f1.x],null,null,true);
return;
}
x=_8f1.x;
}
if(_8f1&&typeof _8f1.y!="undefined"){
if(_8f1.y&&typeof _8f1.y!="number"){
ColdFusion.handleError(null,"messagebox.create.ynotnumeric","widget",[_8ec,_8f1.y],null,null,true);
return;
}
y=_8f1.y;
}
if(_8f1&&_8f1.icon){
icon=_8f1.icon;
if(icon){
icon=icon.toUpperCase();
if(icon!="ERROR"&&icon!="INFO"&&icon!="QUESTION"&&icon!="WARNING"){
ColdFusion.handleError(null,"messagebox.create.invalidicon","widget",[_8ec,icon],null,null,true);
}
}
}
if(_8f1&&_8f1.bodystyle){
_8fe=_8f1.bodystyle;
}
$MB.init(_8ec,type,_8ef,_8ee,_8f5,_8f4,_8f3,_8f6,_8f9,_8f7,_8f0,icon,_8fb,x,y,_8f8,_8fe);
ColdFusion.Log.info("messagebox.create.created","widget",[_8ec,type]);
};
$MB.updateMessage=function(_8ff,_900){
var _901=$MB.getMessageBoxObject(_8ff);
_901.messageText=_900;
ColdFusion.Log.info("messagebox.updatemessage.updated","widget",[_8ff]);
};
$MB.updateTitle=function(_902,_903){
var _904=$MB.getMessageBoxObject(_902);
_904.title=_903;
ColdFusion.Log.info("messagebox.updatetitle.updated","widget",[_902]);
};
$MB.update=function(_905,_906){
var _907=$MB.getMessageBoxObject(_905);
var _908={};
if(!_906||typeof _906!="object"){
ColdFusion.handleError(null,"messagebox.update.invalidconfigobject","widget",[_905],null,null,true);
return;
}
if(_906.name&&typeof _906.name=="string"){
ColdFusion.handleError(null,"messagebox.update.nameupdatenotallowed","widget",[_905],null,null,true);
return;
}
if(_906.type&&typeof _906.type=="string"){
ColdFusion.handleError(null,"messagebox.update.typeupdatenotallowed","widget",[_905],null,null,true);
return;
}
if(_906.message){
if(typeof _906.message==="string"||typeof _906.message=="object"){
_908.messageText=_906.message;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidmessage","widget",[_905],null,null,true);
return;
}
}
if(_906.title){
if(typeof _906.title==="string"||typeof _906.title=="object"){
_908.title=_906.title;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidtitle","widget",[_905],null,null,true);
return;
}
}
if(_906.labelok!=null||typeof _906.labelok!="undefined"){
if(typeof _906.labelok==="string"||typeof _906.labelok=="object"){
_908.label_OK=_906.labelok;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidlabelok","widget",[_905],null,null,true);
return;
}
}
if(_906.labelno!=null||typeof _906.labelno!="undefined"){
if(typeof _906.labelno==="string"||typeof _906.labelno=="object"){
_908.label_NO=_906.labelno;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidlabelno","widget",[_905],null,null,true);
return;
}
}
if(_906.labelyes!=null||typeof _906.labelyes!="undefined"){
if(typeof _906.labelyes==="string"||typeof _906.labelyes=="object"){
_908.label_YES=_906.labelyes;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidlabelyes","widget",[_905],null,null,true);
return;
}
}
if(_906.labelcancel!=null||typeof _906.labelcancel!="undefined"){
if(typeof _906.labelcancel==="string"||typeof _906.labelcancel=="object"){
_908.label_CANCEL=_906.labelcancel;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidlabelcancel","widget",[_905],null,null,true);
return;
}
}
if(typeof _906.modal=="boolean"){
_908.modal=_906.modal;
}
if(typeof _906.multiline==="boolean"){
if(_907.type.toLowerCase()!="prompt"){
ColdFusion.handleError(null,"messagebox.update.invalidtypeformultiline","widget",[_905],null,null,true);
return;
}
_908.multiline=_906.multiline;
}
if(_906&&_906.width){
if(typeof _906.width==="number"||typeof _906.width=="object"){
_908.width=_906.width;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidwidth","widget",[_905],null,null,true);
return;
}
}
if(_906.icon!=null||typeof _906.icon!="undefined"){
if(typeof _906.icon==="string"){
icon=_906.icon.toUpperCase();
if(icon!="ERROR"&&icon!="INFO"&&icon!="QUESTION"&&icon!="WARNING"){
ColdFusion.handleError(null,"messagebox.update.invalidicon","widget",[_905],null,null,true);
return;
}
_908.icon=_906.icon;
}else{
if(typeof _906.icon=="object"&&_906.icon==null){
_908.icon=null;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidicon","widget",[_905],null,null,true);
return;
}
}
}
if(_906.callbackhandler!=null||typeof _906.callbackhandler!="undefined"){
if(typeof _906.callbackhandler==="function"||typeof _906.callbackhandler==="object"){
_908.callBack_Fn=_906.callbackhandler;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidcallbackhandler","widget",[_905],null,null,true);
return;
}
}
if(_906.x!=null||typeof _906.x!="undefined"){
if(typeof _906.x==="number"||typeof _906.x=="object"){
_908.x=_906.x;
}else{
ColdFusion.handleError(null,"messagebox.update.xnotnumeric","widget",[_905,_906.x],null,null,true);
return;
}
}
if(_906.y!=null||typeof _906.y!="undefined"){
if(typeof _906.y==="number"||typeof _906.y=="object"){
_908.y=_906.y;
}else{
ColdFusion.handleError(null,"messagebox.update.ynotnumeric","widget",[_905,_906.y],null,null,true);
return;
}
}
if(_906.bodystyle!=null||typeof _906.bodystyle!="undefined"){
if(typeof _906.bodystyle==="string"||typeof _906.bodystyle=="object"){
_908.bodyStyle=_906.bodystyle;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidbodystyle","widget",[_905],null,null,true);
return;
}
}
if(_906.buttontype!=null||typeof _906.buttontype!="undefined"){
if(typeof _906.buttontype==="string"||typeof _906.buttontype==="object"){
buttonType=_906.buttontype;
if(_907.type.toUpperCase()!=="CONFIRM"){
ColdFusion.handleError(null,"messagebox.update.invalidtypeandbuttontypecombination","widget",[_905],null,null,true);
return;
}else{
if(buttonType.toUpperCase()!="YESNO"&&buttonType.toUpperCase()!="YESNOCANCEL"){
ColdFusion.handleError(null,"messagebox.update.invalidbuttontype","widget",[_905],null,null,true);
return;
}
}
_908.buttonType=_906.buttontype;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidbuttontype","widget",[_905],null,null,true);
return;
}
}
for(key in _908){
_907[key]=_908[key];
}
ColdFusion.Log.info("messagebox.update.updated","messagebox",[_905]);
};
$MB.getMessageBoxObject=function(_909){
var _90a=ColdFusion.objectCache[_909];
if(_90a==null||typeof (_90a)=="undefined"){
ColdFusion.handleError(null,"messagebox.getmessageboxobject.missingmessageboxid","widget",[_909],null,null,true);
}
return _90a;
};
$MB.isMessageBoxDefined=function(_90b){
var _90c=ColdFusion.objectCache[_90b];
if(_90c==null||typeof (_90c)=="undefined"){
return false;
}else{
return true;
}
};
$MB.beforeShowHandler=function(_90d){
var _90e=$MB.getMessageBoxObject(CURRENT_MESSAGEBOX_ID);
var _90f=_90e.x;
var _910=_90e.y;
var _911=_90e.bodyStyle;
var _912=_90d.body.parent();
var id=_912.id;
var ele=document.getElementById(id);
if(null!=_911){
ele.style.cssText=_911;
}
if(_90f&&_910&&typeof _90f=="number"&&typeof _910=="number"&&_90f>=0&&_910>=0){
_90d.setPosition(_90f,_910);
}else{
_90d.center();
}
};
