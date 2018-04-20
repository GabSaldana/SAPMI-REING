/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.ProgressBar){
ColdFusion.ProgressBar={};
}
var $P=ColdFusion.ProgressBar;
ColdFusion.ProgressBar.create=function(_65f,_660,_661,_662,_663,_664,_665,_666,_667,_668){
var _669={renderTo:_65f,interval:_662,onComplete:_666,autodisplay:_665,onError:_668};
var _66a={renderTo:_65f};
if(_664!=null&&typeof (_664)!=undefined){
_669.width=_664;
_66a.width=_664;
}else{
_66a.width=400;
}
if(_663!=null&&typeof (_663)!=undefined){
_669.height=_663;
_66a.height=_663;
}else{
_669.autoHeight=true;
_66a.autoHeight=true;
}
if(_660!=null){
_669.manual=true;
_669.status_retrieval_fn=_660;
}else{
_669.manual=false;
_669.duration=_661;
}
_669.hidden=!_665;
_66a.hidden=_669.hidden;
if(_667!=null&&typeof _667!="undefined"){
_669.cls=_667;
_66a.cls=_667;
}
var _66b=new Ext.ProgressBar(_66a);
_669.progressBarComp=_66b;
ColdFusion.objectCache[_65f]=_669;
ColdFusion.Log.info("progressbar.create.created","widget",[_65f]);
};
$P.start=function(_66c){
var _66d=$P.getProgressBarObject(_66c);
var _66e=ColdFusion.objectCache[_66c];
if(!_66d.isVisible()){
_66d=_66d.show();
}
_66e.started=true;
if(_66e.manual==false){
var _66f=_66e.interval;
var _670=_66e.duration;
var _671=_670/_66f;
_66d.wait({interval:_66f,duration:_670,increment:_671,fn:$P.automaticPBCompleteHandler,scope:_66e});
}else{
var _672=setInterval(_66e.status_retrieval_fn,_66e.interval);
_66e.processId=_672;
}
ColdFusion.Log.info("progressbar.start.started","widget",[_66c]);
};
$P.stop=function(_673,_674){
var pBar=$P.getProgressBarObject(_673);
var _676=ColdFusion.objectCache[_673];
var _677=_676.processId;
if(typeof _676.started!="undefined"&&_676.started==true){
_676.started=false;
}else{
ColdFusion.Log.info("progressbar.stop.nonrunning","widget",[_673]);
return;
}
if(_677!=null&&typeof (_677)!="undefined"){
clearInterval(_677);
}
if(typeof _676.manual!="undefined"&&_676.manual==false){
pBar.reset();
}
if(_674&&_674==true){
var _678=_676.onComplete;
if(_678!=null&&_678.call){
_678.call();
}
}
ColdFusion.Log.info("progressbar.stop.stopped","widget",[_673]);
};
$P.hide=function(_679){
var pBar=$P.getProgressBarObject(_679);
if(pBar.isVisible()){
pBar.hide();
}
ColdFusion.Log.info("progressbar.hide.hidden","widget",[_679]);
};
$P.show=function(_67b){
var pBar=$P.getProgressBarObject(_67b);
if(!pBar.isVisible()){
pBar.show();
}
ColdFusion.Log.info("progressbar.show.shown","widget",[_67b]);
};
$P.reset=function(_67d){
var pBar=$P.getProgressBarObject(_67d);
if(typeof pBar!="undefined"){
pBar.reset();
}
ColdFusion.Log.info("progressbar.reset.reset","widget",[_67d]);
};
$P.updateStatus=function(_67f,_680,_681){
var pBar=$P.getProgressBarObject(_67f);
if(typeof (_680)=="undefined"||typeof (_680)!="number"){
ColdFusion.handleError(null,"progressbar.updatestatus.invalidstatus","widget",[_67f,_680],null,null,true);
return;
}
if(typeof pBar!="undefined"){
pBar.updateProgress(_680,_681);
}
ColdFusion.Log.info("progressbar.updatestatus.updated","widget",[_67f]);
};
$P.update=function(_683,_684){
var _685={};
var _686=ColdFusion.objectCache[_683];
if(_686==null||typeof (_686)=="undefined"){
ColdFusion.handleError(null,"progressbar.update.notfound","widget",[_683],null,null,true);
return;
}
if(_684.duration){
if(typeof _684.duration==="number"||typeof _684.duration=="object"){
_685.duration=_684.duration;
}else{
ColdFusion.handleError(null,"progressbar.update.invalidduration","widget",[_683],null,null,true);
return;
}
}
if(_684.interval){
if(typeof _684.interval==="number"||typeof _684.interval=="object"){
_685.interval=_684.interval;
}else{
ColdFusion.handleError(null,"progressbar.update.invalidinterval","widget",[_683],null,null,true);
return;
}
}
if(_684.oncomplete){
if(typeof _684.oncomplete==="function"||typeof _684.oncomplete=="object"){
_685.onComplete=_684.oncomplete;
}else{
ColdFusion.handleError(null,"progressbar.update.invalidoncomplete","widget",[_683],null,null,true);
return;
}
}
for(key in _685){
_686[key]=_685[key];
}
ColdFusion.Log.info("progressbar.update.updated","widget",[_683]);
};
$P.loadStatus=function(data,_688){
var _689=ColdFusion.AjaxProxy.JSON.decode(data);
var _68a=_689.MESSAGE;
var _68b=_689.STATUS;
var pBar=$P.getProgressBarObject(_688._cf_progressbarid);
pBar.updateProgress(_68b,_68a);
if(_68b&&(_68b===1||_68b==1||_68b>1)){
$P.stop(_688._cf_progressbarid,true);
}
};
$P.automaticPBCompleteHandler=function(){
var _68d=this.progressBarComp;
_68d.updateProgress(1);
if(this.onComplete&&typeof this.onComplete=="function"){
this.onComplete.call(_68d,_68d);
}
};
$P.errorHandler=function(_68e,_68f,_690){
var pbId=_690.bindToParams._cf_progressbarid;
var _692=ColdFusion.objectCache[pbId];
var _693=_692.onError;
if(_693!=null&&typeof _693==="function"){
_693.call(null,_68e,_68f);
}
$P.stop(pbId);
};
$P.getProgressBarObject=function(_694){
var _695=ColdFusion.objectCache[_694];
if(_695==null||typeof (_695)=="undefined"){
ColdFusion.handleError(null,"progressbar.getProgressBarObject.missingprogressbarid","widget",[_694],null,null,true);
return;
}
if(_695.progressBarComp&&typeof _695.progressBarComp!="undefined"){
return _695.progressBarComp;
}else{
ColdFusion.handleError(null,"progressbar.getProgressBarObject.missingprogressbarcomponent","widget",[_694],null,null,true);
return;
}
};
