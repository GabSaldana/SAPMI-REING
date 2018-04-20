/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.FileUpload){
ColdFusion.FileUpload={};
}
var $FS=ColdFusion.FileUpload;
$FS.defaultSWFLocation=_cf_ajaxscriptsrc+"/resources/cf/assets/MultiFileUpload.swf";
var isIE=(navigator.appVersion.indexOf("MSIE")!=-1)?true:false;
var isWin=(navigator.appVersion.toLowerCase().indexOf("win")!=-1)?true:false;
var isOpera=(navigator.userAgent.indexOf("Opera")!=-1)?true:false;
var defaultAddButtonLabel="Add Files";
var defaultUploadButtonLabel="Upload";
var defaultClearButtonLabel="Clear All";
var defaultDeleteButtonLabel="Delete";
var defaultAddIcon=_cf_ajaxscriptsrc+"/resources/cf/images/fileupload/addfile.png";
var defaultUploadIcon=_cf_ajaxscriptsrc+"/resources/cf/images/fileupload/upload.png";
var defaultClearIcon=_cf_ajaxscriptsrc+"/resources/cf/images/fileupload/clear.gif";
var defaultDeleteIcon=_cf_ajaxscriptsrc+"/resources/cf/images/fileupload/delete.png";
var defaultUploadSize=10*1024*1024;
var fileUploadPrefix="cf_fileUpload_";
ColdFusion.FileUpload.create=function(_3c4,_3c5,_3c6,_3c7,_3c8,_3c9,_3ca,_3cb,_3cc,_3cd,_3ce,_3cf,_3d0,_3d1,_3d2,_3d3,_3d4,_3d5,_3d6,_3d7,_3d8,_3d9,_3da,_3db,_3dc,_3dd,_3de,_3df,_3e0,_3e1){
var _3e2={};
_3e2.uploadDivId=_3c4;
_3e2.fileUploadName=fileUploadPrefix+_3c4;
_3e2.url_withoutQuery=_3c5;
_3e2.url_queryString=_3c6;
_3e2.url_CF_cookie=_3c7;
_3e2.url=$FS.constructUrl(_3c5,_3c6,_3c7);
_3e2.onCompleteHandler=_3cf;
_3e2.onUploadCompleteHandler=_3d0;
_3e2.onErrorHandler=_3d1;
_3e2.progressbar=_3dc;
if(_3d4==null){
_3d4="";
}
_3e2.bgcolor=_3d4;
if(_3d5==null){
_3d5="";
}
_3e2.selectcolor=_3d5;
if(_3d6==null){
_3d6="";
}
_3e2.rollovercolor=_3d6;
if(_3d7==null){
_3d7="";
}
_3e2.textcolor=_3d7;
if(_3da==null){
_3da="left";
}
_3e2.titletextalign=_3da;
if(_3d8==null){
_3d8="";
}
_3e2.titletextcolor=_3d8;
if(_3d9==null){
_3d9="";
}
_3e2.headercolor=_3d9;
_3e2.bgcolor=_3d4;
_3e2.bgcolor=_3d4;
if(_3db==null){
_3db="";
}
_3e2.fileFilter=_3db;
_3e2.disableUploadButton=_3de;
if(_3e0==null||typeof _3e0=="undefined"){
_3e0="window";
}
_3e2.wmode=_3e0;
_3e2.stopOnError=_3df;
if(_3c8==null||typeof _3c8==="undefined"){
_3c8=defaultAddButtonLabel;
}
_3e2.addIcon=defaultAddIcon;
_3e2.addButtonLabel=_3c8;
if(_3ca==null||typeof _3ca==="undefined"){
_3ca=defaultUploadButtonLabel;
}
_3e2.uploadButtonLabel=_3ca;
_3e2.uploadIcon=defaultUploadIcon;
if(_3cc==null||typeof _3cc==="undefined"){
_3cc="File Upload ";
}
_3e2.title=_3cc;
_3e2.swfLocation=$FS.defaultSWFLocation;
if(_3c9==null||typeof _3c9==="undefined"){
_3c9=defaultClearButtonLabel;
}
_3e2.clearButtonLabel=_3c9;
_3e2.clearIcon=defaultClearIcon;
if(_3cb==null||typeof _3cb==="undefined"){
_3cb=defaultDeleteButtonLabel;
}
_3e2.deleteButtonLabel=_3cb;
_3e2.deleteIcon=defaultDeleteIcon;
if(_3cd==null||!typeof _3cd==="Number"){
_3cd=-1;
}
_3e2.maxFileSelect=_3cd;
if(_3ce==null||!typeof _3ce==="number"){
_3ce=defaultUploadSize;
}
_3e2.maxUploadSize=_3ce;
if(_3d2==null||typeof _3d2==="undefined"){
_3d2=420;
}
_3e2.widthInPx=_3d2+"px";
_3e2.width=_3d2;
if(_3d3==null||typeof _3d3==="undefined"){
_3d3=300;
}
_3e2.heightInPx=_3d3+"px";
_3e2.height=_3d3;
_3e2.align=_3e1;
ColdFusion.objectCache[_3c4]=_3e2;
ColdFusion.objectCache[_3e2.fileUploadName]=_3e2;
var _3e3=$FS.constructMarkup(_3e2);
var _3e4=document.getElementById(_3c4);
_3e4.innerHTML=_3e3;
ColdFusion.Log.info("fileupload.initialized","widget",[_3c4]);
};
$FS.constructMarkup=function(_3e5){
var str="";
if(isIE&&isWin&&!isOpera){
str+="<object width=\""+_3e5.width+"\" height=\""+_3e5.height+"\"";
str+=" id=\""+_3e5.fileUploadName+"\" name=\""+_3e5.playerName+"\" type=\"application/x-shockwave-flash\" classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" ";
str+=" data=\""+_3e5.swfLocation+"\">";
str+="<param name=\"movie\" value=\""+_3e5.swfLocation+"\" />";
str+="<param name=\"quality\" value=\""+_3e5.quality+"\" />";
str+="<param name=\"allowFullScreen\" value=\""+_3e5.fullScreen+"\" />";
str+="<param name=\"allowScriptAccess\" value=\"sameDomain\" />";
str+="<param name=\"wmode\" value=\""+_3e5.wmode+"\" />";
str+="<param name=\"flashvars\" value=\"uniqueid="+_3e5.fileUploadName+"&url="+_3e5.url+"&addLabel="+_3e5.addButtonLabel+"&deleteLabel="+_3e5.deleteButtonLabel;
str+="&clearLabel="+_3e5.clearButtonLabel+"&uploadLabel="+_3e5.uploadButtonLabel+"&maxUploadSize="+_3e5.maxUploadSize+"&maxFileSelect="+_3e5.maxFileSelect+"&progress="+_3e5.progressbar;
str+="&stopOnError="+_3e5.stopOnError+"&hideUpload="+_3e5.disableUploadButton+"&bgcolor="+_3e5.bgcolor+"&fileFilter="+_3e5.fileFilter+"&deleteIcon="+_3e5.deleteIcon+"&title="+_3e5.title;
str+="&uploadIcon="+_3e5.uploadIcon+"&textcolor="+_3e5.textcolor+"&titletextcolor="+_3e5.titletextcolor+"&headercolor="+_3e5.headercolor+"&titletextalign="+_3e5.titletextalign+"&rollovercolor="+_3e5.rollovercolor+"&selectcolor="+_3e5.selectcolor+"\" />";
str+="</object>";
}else{
str="<embed src=\""+_3e5.swfLocation+"\" allowScriptAccess=\"samedomain\" pluginspage=\"http://www.adobe.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" wmode=\""+_3e5.wmode+"\"";
str+=" name=\""+_3e5.fileUploadName+"\" width=\""+_3e5.width+"\" height=\""+_3e5.height+"\" quality=\" "+_3e5.quality+"\"";
str+=" flashvars=\"uniqueid="+_3e5.fileUploadName+"&url="+_3e5.url+"&addLabel="+_3e5.addButtonLabel+"&deleteLabel="+_3e5.deleteButtonLabel;
str+="&clearLabel="+_3e5.clearButtonLabel+"&uploadLabel="+_3e5.uploadButtonLabel+"&maxUploadSize="+_3e5.maxUploadSize+"&maxFileSelect="+_3e5.maxFileSelect+"&progress="+_3e5.progressbar;
str+="&stopOnError="+_3e5.stopOnError+"&hideUpload="+_3e5.disableUploadButton+"&bgcolor="+_3e5.bgcolor+"&fileFilter="+_3e5.fileFilter+"&deleteIcon="+_3e5.deleteIcon+"&title="+_3e5.title;
str+="&uploadIcon="+_3e5.uploadIcon+"&textcolor="+_3e5.textcolor+"&titletextcolor="+_3e5.titletextcolor+"&headercolor="+_3e5.headercolor+"&titletextalign="+_3e5.titletextalign+"&rollovercolor="+_3e5.rollovercolor+"&selectcolor="+_3e5.selectcolor+"\" />";
}
return str;
};
$FS.constructUrl=function(_3e7,_3e8,_3e9){
var url=_3e7;
if(_3e8!=null){
url+="?"+_3e8;
if(_3e9!=null){
url+="%26"+_3e9;
}
}else{
if(_3e9!=null){
url+="?"+_3e9;
}
}
return url;
};
coldfusion_FileUploadSwf_complete=function(name,_3ec){
var _3ed=$FS.getFileUploadComponent(name);
var _3ee=ColdFusion.objectCache[name];
var _3ef=_3ee.onCompleteHandler;
if(_3ef!=null&&typeof _3ef=="function"){
_3ef.call(this,_3ec);
}
$FS.addResultToArray(_3ec,_3ee);
};
coldfusion_FileUploadSwf_onError=function(name,_3f1){
var _3f2=$FS.getFileUploadComponent(name);
var _3f3=ColdFusion.objectCache[name];
var _3f4=_3f3.onErrorHandler;
if(_3f4!=null&&typeof _3f4=="function"){
_3f4.call(this,_3f1);
}
$FS.addResultToArray(_3f1,_3f3);
};
coldfusion_FileUploadSwf_UploadCompete=function(name){
var _3f6=$FS.getFileUploadComponent(name);
var _3f7=ColdFusion.objectCache[name];
var _3f8=_3f7.onUploadCompleteHandler;
var _3f9=_3f7.resultArray;
if(_3f8!=null&&typeof _3f8=="function"){
_3f8.call(this,_3f9);
}
_3f7.resultArray=new Array();
};
$FS.addResultToArray=function(_3fa,_3fb){
var _3fc=_3fb.resultArray;
if(_3fc==null||typeof _3fc=="undefined"){
_3fc=_3fb.resultArray=new Array();
}
_3fc.push(_3fa);
};
$FS.cancelUpload=function(name){
var _3fe=fileUploadPrefix+name;
var _3ff=$FS.getFileUploadComponent(_3fe);
if(_3ff!=null){
_3ff.cancelFileUpload();
}else{
ColdFusion.handleError(null,"fileupload.cancelupload.notfound","widget",[name],null,null,true);
}
ColdFusion.Log.info("fileupload.cancelupload.cancelled","widget",[name]);
};
$FS.getSelectedFiles=function(name){
var _401=fileUploadPrefix+name;
var _402=$FS.getFileUploadComponent(_401);
if(_402!=null){
return _402.getSelectedFileArray();
}else{
ColdFusion.handleError(null,"fileupload.getSelectedFiles.notfound","widget",[name],null,null,true);
}
ColdFusion.Log.info("fileupload.getSelectedFiles.selected","widget",[name]);
};
$FS.clearAllFiles=function(name){
var _404=fileUploadPrefix+name;
var _405=$FS.getFileUploadComponent(_404);
if(_405!=null){
_405.clearAllUpload();
}else{
ColdFusion.handleError(null,"fileupload.clearallfiles.notfound","widget",[name],null,null,true);
}
ColdFusion.Log.info("fileupload.clearallfiles.cleared","widget",[name]);
};
$FS.setURL=function(name,src){
var _408=$FS.getFileUploadComponent(fileUploadPrefix+name);
var _409=ColdFusion.objectCache[name];
if(_409==null||typeof (_409)=="undefined"){
ColdFusion.handleError(null,"fileupload.setURL.notfound","widget",[name],null,null,true);
}
if(!src||src.length==0){
ColdFusion.handleError(null,"fileupload.setURL.invalidurl","widget",[name],null,null,true);
}
var _40a=null;
if(src.indexOf("?")>0){
_40a=src.substring(src.indexOf("?")+1);
_40a=escape(_40a);
src=src.substring(0,src.indexOf("?"));
}
if(src.charAt(0)!="/"&&src.indexOf("://")<0){
var _40b=_409.url_withoutQuery;
_40b=unescape(_40b);
var _40c="";
if(_40b||_40b.indexOf("/")>-1){
_40c=_40b.substring(0,_40b.lastIndexOf("/")+1);
}
var _40d=_40c+src;
var _40e=_40d.split("/");
var _40f=new Array();
var _410=0;
for(var i=0;i<_40e.length;i++){
if(_40e[i]==".."){
_40f[--_410]="";
}else{
_40f[_410++]=_40e[i];
}
}
src=_40f[0];
for(var i=1;i<_410;i++){
src=src+"/"+_40f[i];
}
}
var _412=$FS.constructUrl(src,_40a,_409.url_CF_cookie);
_409.url=_412;
_408.setSrc(_412);
ColdFusion.Log.info("fileupload.setURL.urlset","widget",[name,_412]);
};
$FS.startUpload=function(name){
var _414=fileUploadPrefix+name;
var _415=$FS.getFileUploadComponent(_414);
if(_415!=null){
_415.submitUploadForm();
}else{
ColdFusion.handleError(null,"fileupload.startupload.notfound","widget",[name],null,null,true);
}
ColdFusion.Log.info("fileupload.startupload.started","widget",[name]);
};
$FS.getFileUploadComponent=function(name){
if(navigator.appName.indexOf("Microsoft")!=-1){
if(window[name]!=null){
return window[name];
}else{
return document[name];
}
}else{
return document[name];
}
};
