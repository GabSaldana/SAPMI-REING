/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.Tooltip){
ColdFusion.Tooltip={};
}
ColdFusion.Tooltip.setToolTipOut=function(_1f2,_1f3){
var _1f4=_1f3.tooltip;
_1f4.tooltipout=true;
};
ColdFusion.Tooltip.getToolTip=function(_1f5,_1f6){
var _1f7=ColdFusion.objectCache[_1f6.context];
if(!_1f7){
if(_1f6.style){
_1f6.styleObj=ColdFusion.Tooltip.parseStyle(_1f6.style);
}
_1f7=new YAHOO.widget.Tooltip(_1f6.context+"_cf_tooltip",_1f6);
ColdFusion.objectCache[_1f6.context]=_1f7;
_1f7.doShow(_1f5,_1f6.context);
if(_1f6._cf_url){
var _1f8=function(req,_1fa){
_1fa.tooltip.cfg.setProperty("text",req.responseText);
if(_1fa.tooltip.tooltipout==false){
_1fa.tooltip.doShow(_1fa.event,_1fa.id);
}
};
YAHOO.util.Event.addListener(_1f6.context,"mouseout",ColdFusion.Tooltip.setToolTipOut,{"tooltip":_1f7});
_1f7.cfg.setProperty("text",_cf_loadingtexthtml);
_1f7.doShow(_1f5,_1f6.context);
try{
ColdFusion.Log.info("tooltip.gettooltip.fetch","widget",[_1f6.context]);
ColdFusion.Ajax.sendMessage(_1f6._cf_url,"GET",_1f6._cf_query,true,_1f8,{tooltip:_1f7,event:_1f5,id:_1f6.context});
}
catch(e){
tooltipdiv=ColdFusion.DOM.getElement(_1f6.context);
tooltipdiv.innerHTML="";
ColdFusion.globalErrorHandler(null,e,tooltipdiv);
}
}
}
_1f7.tooltipout=false;
};
ColdFusion.Tooltip.parseStyle=function(_1fb){
var _1fc={};
if(_1fb&&typeof _1fb==="string"){
var _1fd=_1fb.split(";");
for(var i=0;i<_1fd.length;i++){
var temp=_1fd[i];
tempArray=temp.split(":");
if(tempArray.length===2){
var key=tempArray[0];
key=key.toLowerCase();
var _201=tempArray[1];
switch(key){
case "width":
_1fc.width=_201;
break;
case "color":
_1fc.color=_201;
break;
case "background-color":
_1fc[key]=_201;
break;
case "padding":
_1fc.padding=_201;
break;
default:
_1fc[key]=_201;
}
}
}
}
return _1fc;
};
