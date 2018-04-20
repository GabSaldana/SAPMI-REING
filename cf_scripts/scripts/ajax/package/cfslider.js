/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.Slider){
ColdFusion.Slider={};
}
var $SL=ColdFusion.Slider;
ColdFusion.Slider.init=function(_170,name,_172,_173,_174,_175,_176,_177,_178,_179,tip,_17b,_17c){
var _17d={renderTo:_170,id:name};
if(_178!=null&&typeof (_178)!="undefined"){
_17d.ClicktoChange=_178;
}else{
_17d.ClicktoChange=false;
}
if(_179!=null&&typeof (_179)!="undefined"){
_17d.increment=_179;
}else{
_17d.increment=1;
}
if(_176!=null&&typeof (_176)!=undefined){
_17d.minValue=_176;
}else{
_17d.minValue=0;
}
if(_175!=null&&typeof (_175)!=undefined){
_17d.value=_175;
}else{
_17d.value=_17d.minValue;
}
if(_173!=null&&typeof (_173)!=undefined){
_17d.width=_173;
}else{
_17d.width=200;
}
if(_174!=null&&typeof (_174)!="undefined"){
_17d.height=_174;
}else{
_17d.height=100;
}
if(_177!=null&&typeof (_177)!=undefined){
_17d.maxValue=_177;
}else{
_17d.maxValue=100;
}
if(_172!=null&&typeof (_172)!=undefined){
_17d.vertical=_172;
}else{
_17d.vertical=false;
}
if(_17b!=null&&typeof (_17b)=="function"){
_17d.onChange=_17b;
}
if(_17c!=null&&typeof (_17c)!="undefined"){
_17d.onDrg=_17c;
}
Ext.define("Ext.ux.ST",{extend:"Ext.slider.Tip",minWidth:25,minHeight:25,offsets:[0,-10],init:function(_17e){
_17e.on("dragstart",this.onSlide,this);
_17e.on("drag",this.onSlide,this);
_17e.on("dragend",this.hide,this);
_17e.on("destroy",this.destroy,this);
},onSlide:function(_17f,e,_181){
this.show();
this.body.update(this.getText(_17f));
this.el.alignTo(_181.el,"b-t?",this.offsets);
this.doAutoRender();
},getText:function(_182){
return _182.getValue()==0?"0":_182.getValue();
}});
if(tip!=null&&typeof (tip)!="undefined"){
if(tip){
_17d.plugins=new Ext.ux.ST();
}else{
_17d.useTips=false;
}
}
var _183=Ext.create("Ext.slider.Single",_17d);
_183.on("drag",$SL.onDragHandler,_17d);
_183.on("changecomplete",$SL.onChangeHandler,_17d);
_17d.sliderComp=_183;
ColdFusion.objectCache[name]=_17d;
ColdFusion.Log.info("slider.initialized","widget",[name]);
};
$SL.onDragHandler=function(_184,_185){
var _186=this.onDrg;
if(_186!=null&&typeof (_186)=="function"){
_186.call(this,_184,_185);
}
};
$SL.onChangeHandler=function(_187,_188){
var _189=this.onChange;
if(_189!=null&&typeof (_189)=="function"){
_189.call(this,_187,_188);
}
};
$SL.getValue=function(_18a){
var _18b=ColdFusion.objectCache[_18a];
if(_18b!=null||typeof (_18b)!="undefined"){
var _18c=_18b.sliderComp;
if(_18c){
return _18c.getValue();
}
}else{
ColdFusion.handleError(null,"slider.getvalue.notfound","widget",[_18a],null,null,true);
}
};
$SL.getSliderObject=function(_18d){
var _18e=ColdFusion.objectCache[_18d];
if(_18e!=null||typeof (_18e)!="undefined"){
return _18e.sliderComp;
}else{
return null;
}
};
$SL.setValue=function(_18f,_190){
var _191=ColdFusion.objectCache[_18f];
if(_191!=null||typeof (_191)!="undefined"){
var _192=_191.sliderComp;
if(_192){
return _192.setValue(_190,true);
}
}else{
ColdFusion.handleError(null,"slider.setvalue.notfound","widget",[_18f],null,null,true);
}
};
$SL.show=function(_193){
var _194=ColdFusion.objectCache[_193];
if(_194!=null||typeof (_194)!="undefined"){
var _195=_194.sliderComp;
if(_195){
return _195.show();
}
}else{
ColdFusion.handleError(null,"slider.show.notfound","widget",[_193],null,null,true);
}
ColdFusion.Log.info("slider.show.shown","widget",[_193]);
};
$SL.hide=function(_196){
var _197=ColdFusion.objectCache[_196];
if(_197!=null||typeof (_197)!="undefined"){
var _198=_197.sliderComp;
if(_198){
return _198.hide();
}
}else{
ColdFusion.handleError(null,"slider.hide.notfound","widget",[_196],null,null,true);
}
ColdFusion.Log.info("slider.hide.hidden","widget",[_196]);
};
$SL.enable=function(_199){
var _19a=ColdFusion.objectCache[_199];
if(_19a!=null||typeof (_19a)!="undefined"){
var _19b=_19a.sliderComp;
if(_19b){
return _19b.enable();
}
}else{
ColdFusion.handleError(null,"slider.enable.notfound","widget",[_199],null,null,true);
}
ColdFusion.Log.info("slider.enable.enabled","widget",[_199]);
};
$SL.disable=function(_19c){
var _19d=ColdFusion.objectCache[_19c];
if(_19d!=null||typeof (_19d)!="undefined"){
var _19e=_19d.sliderComp;
if(_19e){
return _19e.disable();
}
}else{
ColdFusion.handleError(null,"slider.disable.notfound","widget",[_19c],null,null,true);
}
ColdFusion.Log.info("slider.disable.disabled","widget",[_19c]);
};
