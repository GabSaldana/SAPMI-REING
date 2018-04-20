/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.Button){
ColdFusion.Button={};
}
var $BT=ColdFusion.Button;
ColdFusion.Button.init=function(_5ee,_5ef,icon,tips,_5f2,_5f3,_5f4,_5f5,_5f6){
var _5f7={renderTo:_5ee,enableToggle:_5f6,text:_5ef,onClick:_5f2,onToggle:_5f3,onMouseOver:_5f4,onMouseout:_5f5,tooltip:tips,icon:icon};
var _5f8={renderTo:_5ee,enableToggle:_5f6,text:_5ef};
if(tips!=null&&typeof tips!="undefined"){
_5f8.tooltip=tips;
Ext.QuickTips.init();
}
if(icon!=null&&typeof icon!="undefined"){
_5f8.icon=icon;
}
if(icon&&_5ef){
_5f8.iconCls="x-btn-text-icon";
}else{
if(icon&&!_5ef){
_5f8.iconCls="x-btn-icon";
}
}
var _5f9=new Ext.Button(_5f8);
if(_5f2!=null&&typeof _5f2=="function"){
_5f9.on("click",_5f2,_5f7);
}
if(_5f3!=null&&typeof _5f3=="function"){
_5f9.on("toggle",_5f3,_5f7);
}
if(_5f4!=null&&typeof _5f4=="function"){
_5f9.on("mouseover",_5f4,_5f7);
}
if(_5f5!=null&&typeof _5f5=="function"){
_5f9.on("mouseout",_5f5,_5f7);
}
_5f7.buttonComp=_5f9;
ColdFusion.objectCache[_5ee]=_5f7;
ColdFusion.Log.info("button.initialized","widget",[_5ee]);
};
$BT.show=function(_5fa){
var _5fb=$BT.getButtonObject(_5fa);
if(_5fb!=null){
_5fb.show();
}
ColdFusion.Log.info("button.show.shown","widget",[_5fa]);
};
$BT.hide=function(_5fc){
var _5fd=$BT.getButtonObject(_5fc);
if(_5fd!=null){
_5fd.hide();
}
ColdFusion.Log.info("button.hide.hidden","widget",[_5fc]);
};
$BT.disable=function(_5fe){
var _5ff=$BT.getButtonObject(_5fe);
if(_5ff!=null){
_5ff.disable();
}
ColdFusion.Log.info("button.disable.disabled","widget",[_5fe]);
};
$BT.enable=function(_600){
var _601=$BT.getButtonObject(_600);
if(_601!=null){
_601.enable();
}
ColdFusion.Log.info("button.enable.enabled","widget",[_600]);
};
$BT.getButtonObject=function(_602){
var _603=$BT.getButtonConfigObj(_602);
if(_603!=null){
return _603.buttonComp;
}else{
ColdFusion.handleError(null,"button.component.notFound","widget",[_602],null,null,true);
}
};
$BT.setLabel=function(_604,_605){
var _606=$BT.getButtonObject(_604);
if(_606!=null){
_606.text=_605;
}
};
$BT.getButtonConfigObj=function(_607){
var _608=ColdFusion.objectCache[_607];
if(_608==null||typeof (_608)=="undefined"){
ColdFusion.handleError(null,"button.component.notFound","widget",[_607],null,null,true);
}
return _608;
};
$BT.toggle=function(_609){
var _60a=$BT.getButtonObject(_609);
if(_60a!=null){
_60a.toggle();
}
};
