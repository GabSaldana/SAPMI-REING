/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.Tree){
ColdFusion.Tree={};
}
ColdFusion.Tree.AttributesCollection=function(){
this.cache=true;
this.fontname=null;
this.bold=false;
this.italic=false;
this.completepath=false;
this.appendkey=false;
this.delimiter=null;
this.formname=null;
this.fontsize=null;
this.formparamname=null;
this.prevspanid=null;
this.prevspanbackground=null;
this.images={};
this.images.folder=_cf_ajaxscriptsrc+"/resources/cf/images/FolderClose.gif";
this.images.cd=_cf_ajaxscriptsrc+"/resources/cf/images/Cd.png";
this.images.computer=_cf_ajaxscriptsrc+"/resources/cf/images/Computer.png";
this.images.document=_cf_ajaxscriptsrc+"/resources/cf/images/Document.gif";
this.images.element=_cf_ajaxscriptsrc+"/resources/cf/images/Elements.png";
this.images.floppy=_cf_ajaxscriptsrc+"/resources/cf/images/Floppy.png";
this.images.fixed=_cf_ajaxscriptsrc+"/resources/cf/images/HardDrive.png";
this.images.remote=_cf_ajaxscriptsrc+"/resources/cf/images/NetworkDrive.png";
this.imagesopen={};
this.imagesopen.folder=_cf_ajaxscriptsrc+"/resources/cf/images/FolderOpen.gif";
this.imagesopen.cd=_cf_ajaxscriptsrc+"/resources/cf/images/Cd.png";
this.imagesopen.computer=_cf_ajaxscriptsrc+"/resources/cf/images/Computer.png";
this.imagesopen.document=_cf_ajaxscriptsrc+"/resources/cf/images/Document.gif";
this.imagesopen.element=_cf_ajaxscriptsrc+"/resources/cf/images/Elements.png";
this.imagesopen.floppy=_cf_ajaxscriptsrc+"/resources/cf/images/Floppy.png";
this.imagesopen.fixed=_cf_ajaxscriptsrc+"/resources/cf/images/HardDrive.png";
this.imagesopen.remote=_cf_ajaxscriptsrc+"/resources/cf/images/NetworkDrive.png";
this.eventcount=0;
this.eventHandlers=new Array();
this.nodeCounter=0;
};
ColdFusion.Tree.refresh=function(_5b7){
var tree=ColdFusion.objectCache[_5b7];
var _5b9=ColdFusion.objectCache[_5b7+"collection"];
if(!tree||YAHOO.widget.TreeView.prototype.isPrototypeOf(tree)==false){
ColdFusion.handleError(null,"tree.refresh.notfound","widget",[_5b7],null,null,true);
return;
}
if(!_5b9.dynLoadFunction){
ColdFusion.Log.info("tree.refresh.statictree","widget");
return;
}
_5b9.dynLoadFunction.call(null,tree.getRoot());
ColdFusion.Log.info("tree.refresh.success","widget",[_5b7]);
};
ColdFusion.Tree.getTreeObject=function(_5ba){
if(!_5ba){
ColdFusion.handleError(null,"tree.gettreeobject.emptyname","widget",null,null,null,true);
return;
}
var _5bb=ColdFusion.objectCache[_5ba];
if(_5bb==null||YAHOO.widget.TreeView.prototype.isPrototypeOf(_5bb)==false){
ColdFusion.handleError(null,"tree.gettreeobject.notfound","widget",[_5ba],null,null,true);
return;
}
return _5bb;
};
ColdFusion.Tree.loadNodes=function(_5bc,_5bd){
var i=0;
var _5bf=ColdFusion.objectCache[_5bd.treeid+"collection"];
var tree=ColdFusion.objectCache[_5bd.treeid];
var _5c1;
var _5c2=false;
if(_5bc&&typeof (_5bc.length)=="number"&&!_5bc.toUpperCase){
if(_5bc.length>0&&typeof (_5bc[0])!="object"){
_5c2=true;
}
}else{
_5c2=true;
}
if(_5c2){
ColdFusion.handleError(tree.onbinderror,"tree.loadnodes.invalidbindvalue","widget",[_5bd.treeid]);
return;
}
if(_5bd.parent&&!_5bd.parent.isRoot()){
tree.removeChildren(_5bd.parent);
}else{
if(_5bd.parent&&_5bd.parent.hasChildren()){
tree.removeChildren(_5bd.parent);
_5bd.parent=tree.getRoot();
}
}
if(!_5bd.parent.leafnode){
for(i=0;i<_5bc.length;i++){
var _5c3=_5bf.nodeCounter++;
var node={};
node.id=_5bc[i].VALUE;
if(typeof (_5bc[i].DISPLAY)==undefined||_5bc[i].DISPLAY==null){
node.label=_5bc[i].VALUE;
}else{
node.label=_5bc[i].DISPLAY;
}
node.expand=_5bc[i].EXPAND;
node.appendkey=_5bc[i].APPENDKEY;
node.href=_5bc[i].HREF;
node.img=_5bc[i].IMG;
node.imgOpen=_5bc[i].IMGOPEN;
node.imgid="_cf_image"+_5c3;
node.spanid="_cf_span"+_5c3;
node.target=_5bc[i].TARGET;
if(_5bf.appendkey&&_5bf.appendkey==true&&node.href){
var _5c5=new String(node.href);
_5c5=_5c5.toLowerCase();
if(_5c5.indexOf("javascript")<0){
if(_5c5.indexOf("?")>=0){
node.href=_5bc[i].HREF+"&";
}else{
node.href=_5bc[i].HREF+"?";
}
node.href=node.href+"CFTREEITEMKEY="+node.id;
}
}
var _5c6="";
if(node.img){
if(_5bf.images[node.img]){
_5c6="<img src='"+_5bf.images[node.img]+"' id='"+node.imgid+"' style='border:0'/>&nbsp;";
}else{
_5c6="<img src='"+node.img+"' id='"+node.imgid+"' style='border:0'/>&nbsp;";
}
}
if(_5bf.fontname||_5bf.italic==true||_5bf.bold==true||_5bf.fontsize){
_5c6=_5c6+"<span id='"+node.spanid+"' style='";
if(_5bf.fontname){
_5c6=_5c6+"font-family:"+_5bf.fontname+";";
}
if(_5bf.italic==true){
_5c6=_5c6+"font-style:italic;";
}
if(_5bf.bold==true){
_5c6=_5c6+"font-weight:bold;";
}
if(_5bf.fontsize){
_5c6=_5c6+"font-size:"+_5bf.fontsize+";";
}
_5c6=_5c6+"'>"+node.label+"</span>";
node.label=_5c6;
}else{
node.label=_5c6+"<span id='"+node.spanid+"'  >"+node.label+"</span>";
}
node.childrenFetched=false;
var _5c7=new YAHOO.widget.TextNode(node,_5bd.parent,false);
var _5c8=false;
if(_5bc[i].LEAFNODE&&_5bc[i].LEAFNODE==true){
_5c8=true;
_5c7.leafnode=true;
_5c7.iconMode=1;
}
if(_5c8==true||(node.expand&&node.expand==true)){
_5c7.expand();
}
}
}
if(!_5bd.parent.isRoot()){
_5bd.parent.data.childrenFetched=true;
}
if(_5bd.onCompleteCallBack){
_5bd.onCompleteCallBack.call();
}else{
_5bd.parent.tree.draw();
}
ColdFusion.Log.info("tree.loadnodes.success","widget",[_5bd.treeid]);
};
ColdFusion.Tree.onExpand=function(node){
if(node.isRoot()){
return;
}
var _5ca=ColdFusion.objectCache[node.tree.id+"collection"];
if(node.data.imgOpen&&typeof (node.leafnode)=="undefined"){
var _5cb=ColdFusion.DOM.getElement(node.data.imgid,node.tree.id);
var src;
if(_5ca.imagesopen[node.data.imgOpen]){
src=_5ca.imagesopen[node.data.imgOpen];
}else{
src=node.data.imgOpen;
}
_5cb.src=src;
}
if(_5ca.cache==false&&node.data.childrenFetched==false&&_5ca.dynLoadFunction){
node.tree.removeChildren(node);
}
};
ColdFusion.Tree.onCollapse=function(node){
if(node.isRoot()){
return;
}
var _5ce=ColdFusion.objectCache[node.tree.id+"collection"];
if(node.data.img){
var _5cf=ColdFusion.DOM.getElement(node.data.imgid,node.tree.id);
var src;
if(_5ce.images[node.data.img]){
src=_5ce.images[node.data.img];
}else{
src=node.data.img;
}
_5cf.src=src;
}
node.data.childrenFetched=false;
};
ColdFusion.Tree.formPath=function(node,_5d2){
var _5d3=ColdFusion.objectCache[node.tree.id+"collection"];
if(_5d3.completepath==true&&node.isRoot()){
return "";
}else{
if(_5d3.completepath==false&&node.parent.isRoot()){
return "";
}
}
if(!_5d2){
_5d2=node;
}
var _5d4=ColdFusion.Tree.formPath(node.parent,_5d2);
_5d4=_5d4+node.data.id;
if(_5d2.data.id!=node.data.id){
_5d4=_5d4+_5d3.delimiter;
}
return _5d4;
};
ColdFusion.Tree.onLabelClick=function(node){
var _5d6="";
var _5d7=ColdFusion.objectCache[node.tree.id+"collection"];
var _5d6=ColdFusion.Tree.formPath(node);
if(_5d7.prevspanid){
var _5d8=ColdFusion.DOM.getElement(_5d7.prevspanid,node.tree.id);
if(_5d8.style){
_5d8.style.backgroundColor=_5d7.prevspanbackground;
}
}
var _5d9=ColdFusion.DOM.getElement(node.data.spanid,node.tree.id);
if(_5d9&&_5d9.style){
_5d7.prevspanbackground=_5d9.style.backgroundColor;
}
_5d9.style.backgroundColor="lightblue";
_5d7.prevspanid=node.data.spanid;
node.tree._cf_path=_5d6;
node.tree._cf_node=node.data.id;
var val="PATH="+_5d6+"; NODE="+node.data.id;
updateHiddenValue(val,_5d7.formname,_5d7.formparamname);
ColdFusion.Tree.fireSelectionChangeEvent(node.tree.id,_5d7.formname);
};
ColdFusion.Tree.fireSelectionChangeEvent=function(id,_5dc){
ColdFusion.Log.info("tree.fireselectionchangeevent.fire","widget",[id]);
ColdFusion.Event.callBindHandlers(id,_5dc,"change");
};
ColdFusion.Tree.getObject=function(_5dd){
var _5de={};
_5de.id=_5dd.value;
if(_5dd.href&&_5dd.href!="null"){
_5de.href=_5dd.href;
}
_5de.target=_5dd.target;
_5de.label=_5dd.label;
_5de.display=_5dd.display;
_5de.img=_5dd.img;
_5de.imgOpen=_5dd.imgOpen;
_5de.imgid=_5dd.imgid;
_5de.spanid=_5dd.spanid;
_5de.childrenfetched=_5dd.childrenfetched;
return _5de;
};
ColdFusion.Tree.initializeTree=function(_5df,_5e0,_5e1,bold,_5e3,_5e4,_5e5,_5e6,_5e7,_5e8,_5e9,_5ea){
var _5eb=new YAHOO.widget.TreeView(_5df);
_5eb.subscribe("expand",ColdFusion.Tree.onExpand);
_5eb.subscribe("collapse",ColdFusion.Tree.onCollapse);
_5eb.subscribe("labelClick",ColdFusion.Tree.onLabelClick);
_5eb._cf_getAttribute=function(_5ec){
_5ec=_5ec.toUpperCase();
if(_5ec=="PATH"){
return _5eb._cf_path;
}else{
if(_5ec=="NODE"){
return _5eb._cf_node;
}else{
return null;
}
}
};
_5eb.onbinderror=_5e8;
ColdFusion.objectCache[_5df]=_5eb;
var _5ed=new ColdFusion.Tree.AttributesCollection();
_5ed.cache=_5e0;
_5ed.italic=_5e1;
_5ed.bold=bold;
_5ed.completepath=_5e3;
_5ed.delimiter=_5e5;
_5ed.appendkey=_5e4;
_5ed.formname=_5e6;
_5ed.formparamname=_5e7;
_5ed.fontsize=_5e9;
_5ed.fontname=_5ea;
ColdFusion.objectCache[_5df+"collection"]=_5ed;
ColdFusion.Log.info("tree.initializetree.success","widget",[_5df]);
return _5eb;
};
