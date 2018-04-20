/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
cfinitgrid=function(){
Ext.override(Ext.form.field.Number,{decimalPrecision:6});
if(!ColdFusion.Grid){
ColdFusion.Grid={};
}
var $G=ColdFusion.Grid;
if(!$G.GridBindelementsMap){
$G.GridBindelementsMap={};
}
var $L=ColdFusion.Log;
$G.init=function(id,name,_62f,_630,edit,_632,_633,_634,_635,_636,_637,_638,_639,_63a,_63b,_63c,_63d,_63e,_63f,_640,_641,_642,_643,_644,_645,_646,_647,_648,_649,_64a){
var grid;
var _64c;
var _64d=false;
if(_63e&&typeof (_63e)!="undefined"){
_64c=_63e;
_64d=true;
}else{
_64c="rowmodel";
_64c=new Ext.selection.RowModel({mode:"MULTI"});
}
var _64e=_635;
var _64f={store:_636,columns:_635,selModel:_64c,autoSizeColumns:_633,autoSizeHeaders:_633,stripeRows:_639,autoExpandColumnId:_634};
if(_648!=null&&typeof _648!="undefined"){
_64f.plugins=_648;
}
var _650=ColdFusion.objectCache[id];
var _651=document.getElementById(_650.gridId);
if(_651!=null){
var _652=_651.style.cssText;
if(typeof _652=="undefined"){
_652="";
}
_652="width:"+_637+"px;"+_652;
_651.style.cssText=_652;
}
_64f.width=_637;
if(_633===true){
_64f.viewConfig={forceFit:true};
_64f.forceFit=true;
}else{
if(_63e&&typeof (_63e)!="undefined"){
_64f.autoExpandColumn=_634;
}else{
_64f.autoExpandColumn=_634;
}
}
if(_638){
_64f.height=_638;
}else{
_64f.autoHeight=true;
var _653=".x-grid3-header {position: relative;}";
Ext.util.CSS.createStyleSheet(_653,"_cf_grid"+id);
}
if(_640&&typeof (_640)!="undefined"){
_64f.features={ftype:"grouping",groupHeaderTpl:"{columnName}: {groupValue} ({rows.length} items)"};
}
_64f.title=_641;
_64f.collapsible=_63f;
if(_63f&&_641==null){
_64f.title="  ";
}
var _654=ColdFusion.objectCache[id];
_654.bindOnLoad=_632;
_654.dynamic=_630;
_654.styles=_63a;
_654.grouping=_640;
_654.onLoadFunction=_647;
_654.multiRowSelection=_64d;
_64f.renderTo=_654.gridId;
Ext.onReady(function(){
_64f.dockedItems={xtype:"toolbar",dock:"top"};
_64f.tbar=new Ext.Toolbar({hidden:true});
if(_630){
_64f.bbar=new Ext.PagingToolbar({pageSize:_63b,store:_636});
if(_645&&(_642||_643)){
var _655=_64f.bbar;
if(_642){
_655.add({xtype:"button",text:_642,handler:$G.insertRow,scope:_654});
_655.add({xtype:"button",text:" save ",handler:$G.saveNewRecord,scope:_654});
_655.add({xtype:"button",text:" cancel ",handler:$G.cancelNewRecord,scope:_654});
}
if(_643){
_655.add({xtype:"button",text:_643,handler:$G.deleteRow,scope:_654});
}
}
}
if(edit&&!_630){
var bbar=new Ext.Toolbar();
if(_642||_643){
if(_642){
bbar.add({xtype:"button",text:_642,handler:$G.insertRow,scope:_654});
}
if(_643){
bbar.add({xtype:"button",text:_643,handler:$G.deleteRow,scope:_654});
}
}else{
var bbar=new Ext.Toolbar({hidden:true});
}
_64f.bbar=bbar;
}
_636.pageSize=_63b;
var fn=function(){
grid=Ext.create("Ext.grid.Panel",_64f);
$G.Ext_caseInsensitive_sorting();
_636.addListener("load",$G.Actions.onLoad,_654,{delay:50});
grid.view.addListener("beforeshow",function(menu){
var _659=_64e.getColumnCount();
for(var i=0;i<_659;i++){
if("CFGRIDROWINDEX"==_64e.getDataIndex(i)){
menu.remove(menu.items["items"][i]);
break;
}
}
},this);
_654.grid=grid;
if(!_630){
_636.addListener("load",$G.Actions.onLoad,_654,{delay:50});
_636.load();
}
if(_630){
_636._cf_errorHandler=_646;
_636.proxy._cf_actions=_654;
_636.load({params:{start:0,limit:_63b}});
}else{
$G.applyStyles(_654);
}
if(_649){
ColdFusion.Bind.register(_649,{actions:_654},$G.bindHandler,false);
}
$L.info("grid.init.created","widget",[id]);
_654.init(id,name,_62f,_644,_630,edit,_645,_646,_63d,_63b,_63c,_640);
};
if(_630&&_64a){
setTimeout(fn,0);
}else{
fn();
}
});
};
$G.applyStyles=function(_65b){
Ext.util.CSS.createStyleSheet(_65b.styles);
_65b.stylesApplied=true;
};
$G.bindHandler=function(e,_65d){
$G.refresh(_65d.actions.id);
};
$G.bindHandler._cf_bindhandler=true;
$G.refresh=function(_65e,_65f){
var _660=ColdFusion.objectCache[_65e];
if(_660&&$G.Actions.prototype.isPrototypeOf(_660)==true){
var _661=_660.grid.getStore();
if(_660.dynamic){
_660.editOldValue=null;
_660.selectedRow=-1;
var bind=$G.GridBindelementsMap[_65e];
if(bind){
var url=_661.proxy.url;
var _664=bind.split(";");
for(i=0;i<_664.length;i++){
var _665=_664[i].split(",");
indx=url.indexOf(_665[0]+"=");
url1=url.substring(0,indx);
nxtindx=url.indexOf("&",indx);
url2=url.substring(nxtindx);
var eval=ColdFusion.Bind.getBindElementValue(_665[1],_665[2],_665[3]);
url=url1+"&"+_665[0]+"="+eval+url2;
}
_661.proxy.url=url;
}
if(_65f){
_661.lastOptions.page=1;
_661.currentPage=1;
_661.reload();
}else{
_661.reload({params:{start:0,limit:_660.pageSize}});
}
}
}else{
ColdFusion.handleError(null,"grid.refresh.notfound","widget",[_65e],null,null,true);
return;
}
if(_660.multiRowSelection){
}
$L.info("grid.refresh.success","widget",[_65e]);
};
$G.Ext_caseInsensitive_sorting=function(){
Ext.data.Store.prototype.sortData=function(f,_668){
_668=_668||"ASC";
var st=this.fields.get(f).sortType;
var fn=function(r1,r2){
var v1=st(r1.data[f]),v2=st(r2.data[f]);
if(v1.toLowerCase){
v1=v1.toLowerCase();
v2=v2.toLowerCase();
}
return v1>v2?1:(v1<v2?-1:0);
};
this.data.sort(_668,fn);
if(this.snapshot&&this.snapshot!=this.data){
this.snapshot.sort(_668,fn);
}
};
};
$G.getTopToolbar=function(_66e){
var _66f=ColdFusion.objectCache[_66e];
if(!_66f){
ColdFusion.handleError(null,"grid.getTopToolbar.notfound","widget",[_66e],null,null,true);
return;
}
return _66f.grid.getDockedItems()[1];
};
$G.showTopToolbar=function(_670){
var _671=ColdFusion.objectCache[_670];
if(!_671){
ColdFusion.handleError(null,"grid.showTopToolbar.notfound","widget",[_670],null,null,true);
return;
}
var tbar=_671.grid.getDockedItems()[1];
if(!tbar){
ColdFusion.handleError(null,"grid.showTopToolbar.toolbarNotDefined","widget",[_670],null,null,true);
return;
}
tbar.show();
};
$G.hideTopToolbar=function(_673){
var _674=ColdFusion.objectCache[_673];
if(!_674){
ColdFusion.handleError(null,"grid.hideTopToolbar.notfound","widget",[_673],null,null,true);
return;
}
var tbar=_674.grid.getDockedItems()[1];
if(!tbar){
ColdFusion.handleError(null,"grid.hideTopToolbar.toolbarNotDefined","widget",[_673],null,null,true);
return;
}
tbar.hide();
};
$G.refreshTopToolbar=function(_676){
var _677=ColdFusion.objectCache[_676];
if(!_677){
ColdFusion.handleError(null,"grid.refreshTopToolbar.notfound","widget",[_676],null,null,true);
return;
}
var tbar=_677.grid.getDockedItems()[1];
if(!tbar){
ColdFusion.handleError(null,"grid.refreshTopToolbar.toolbarNotDefined","widget",[_676],null,null,true);
return;
}
tbar.doLayout();
if(tbar.isVisible()==false){
tbar.show();
}
};
$G.getBottomToolbar=function(_679){
var _67a=ColdFusion.objectCache[_679];
if(!_67a){
ColdFusion.handleError(null,"grid.getBottomToolbar.notfound","widget",[_679],null,null,true);
return;
}
return _67a.grid.getDockedItems()[_67a.grid.getDockedItems().length-1];
};
$G.showBottomToolbar=function(_67b){
var _67c=ColdFusion.objectCache[_67b];
if(!_67c){
ColdFusion.handleError(null,"grid.showBottomToolbar.notfound","widget",[_67b],null,null,true);
return;
}
var tbar=_67c.grid.getDockedItems()[_67c.grid.getDockedItems().length-1];
if(!tbar){
ColdFusion.handleError(null,"grid.showBottomToolbar.toolbarNotDefined","widget",[_67b],null,null,true);
return;
}
tbar.show();
};
$G.hideBottomToolbar=function(_67e){
var _67f=ColdFusion.objectCache[_67e];
if(!_67f){
ColdFusion.handleError(null,"grid.hideBottomToolbar.notfound","widget",[_67e],null,null,true);
return;
}
var tbar=_67f.grid.getDockedItems()[_67f.grid.getDockedItems().length-1];
if(!tbar){
ColdFusion.handleError(null,"grid.hideBottomToolbar.toolbarNotDefined","widget",[_67e],null,null,true);
return;
}
tbar.hide();
};
$G.refreshBottomToolbar=function(_681){
var _682=ColdFusion.objectCache[_681];
if(!_682){
ColdFusion.handleError(null,"grid.refreshBottomToolbar.notfound","widget",[_681],null,null,true);
return;
}
var tbar=_682.grid.getDockedItems()[_682.grid.getDockedItems().length-1];
if(!tbar){
ColdFusion.handleError(null,"grid.refreshBottomToolbar.toolbarNotDefined","widget",[_681],null,null,true);
return;
}
tbar.doLayout();
if(tbar.isVisible()==false){
tbar.show();
}
};
$G.sort=function(_684,_685,_686){
var _687=ColdFusion.objectCache[_684];
if(!_687){
ColdFusion.handleError(null,"grid.sort.notfound","widget",[_684],null,null,true);
return;
}
_685=_685.toUpperCase();
var _688=-1;
var _689=_687.grid.columns;
for(var i=0;i<_689.length-1;i++){
if(_685==_689[i].colName){
_688=i;
break;
}
}
if(_688==-1){
ColdFusion.handleError(null,"grid.sort.colnotfound","widget",[_685,_684],null,null,true);
return;
}
if(!_686){
_686="ASC";
}
_686=_686.toUpperCase();
if(_686!="ASC"&&_686!="DESC"){
ColdFusion.handleError(null,"grid.sort.invalidsortdir","widget",[_686,_684],null,null,true);
return;
}
var _68b=_687.grid.getStore();
_68b.sort(_685,_686);
};
$G.getGridObject=function(_68c){
if(!_68c){
ColdFusion.handleError(null,"grid.getgridobject.missinggridname","widget",null,null,null,true);
return;
}
var _68d=ColdFusion.objectCache[_68c];
if(_68d==null||$G.Actions.prototype.isPrototypeOf(_68d)==false){
ColdFusion.handleError(null,"grid.getgridobject.notfound","widget",[_68c],null,null,true);
return;
}
return _68d.grid;
};
$G.getSelectedRows=function(_68e){
if(!_68e){
ColdFusion.handleError(null,"grid.getSelectedRowData.missinggridname","widget",null,null,null,true);
return;
}
var _68f=ColdFusion.objectCache[_68e];
var _690=new Array();
var _691=_68f.grid.getSelectionModel();
var _692=_691.selected;
var _693=_68f.grid.columns;
var _694=0;
if(_68f.multiRowSelection===true&&_68f.dynamic===false){
_694++;
}
for(i=0;i<_692.length;i++){
var _695=_692.items[i].data;
var _696={};
for(var _697=_694;_697<_693.length-1;_697++){
var key=_693[_697].dataIndex;
_696[key]=_695[key];
}
_690[i]=_696;
}
return _690;
};
$G.clearSelectedRows=function(_699){
if(!_699){
ColdFusion.handleError(null,"grid.getSelectedRowData.missinggridname","widget",null,null,null,true);
return;
}
var _69a=ColdFusion.objectCache[_699];
var _69b=_69a.grid.getSelectionModel();
_69b.deselectAll();
if(_69a.multiRowSelection){
}
};
$G.Actions=function(_69c){
this.gridId=_69c;
this.init=$G.Actions.init;
this.onChangeHandler=$G.Actions.onChangeHandler;
this.onChangeHandler_MultiRowsDelete=$G.Actions.onChangeHandler_MultiRowsDelete;
this.selectionChangeEvent=new ColdFusion.Event.CustomEvent("cfGridSelectionChange",_69c);
this.fireSelectionChangeEvent=$G.fireSelectionChangeEvent;
this._cf_getAttribute=$G.Actions._cf_getAttribute;
this._cf_register=$G.Actions._cf_register;
this.loaded=false;
};
$G.Actions.init=function(id,_69e,_69f,_6a0,_6a1,edit,_6a3,_6a4,_6a5,_6a6,_6a7,_6a8){
this.id=id;
this.gridName=_69e;
this.formId=_69f;
this.form=document.getElementById(_69f);
this.cellClickInfo=_6a0;
this.edit=edit;
this.onChangeFunction=_6a3;
this.onErrorFunction=_6a4;
this.preservePageOnSort=_6a5;
this.pageSize=_6a6;
this.selectedRow=-1;
this.selectOnLoad=_6a7;
this.grouping=_6a8;
this.grid.addListener("cellclick",$G.cellClick,this,true);
this.editField=document.createElement("input");
this.editField.setAttribute("name",_69e);
this.editField.setAttribute("type","hidden");
this.form.appendChild(this.editField);
if(edit){
if(!_6a1){
var _6a9=this.grid.columns;
this.editFieldPrefix="__CFGRID__EDIT__=";
var i=0;
var _6ab=_6a9.length-1;
if(this.multiRowSelection===true&&this.dynamic===false){
i++;
_6ab--;
}
this.editFieldPrefix+=_6ab+$G.Actions.fieldSep;
var _6ac=true;
for(i;i<_6a9.length-1;i++){
if(!_6ac){
this.editFieldPrefix+=$G.Actions.fieldSep;
}
this.editFieldPrefix+=_6a9[i].colName;
this.editFieldPrefix+=$G.Actions.valueSep;
if(_6a9[i].getEditor()){
this.editFieldPrefix+="Y";
}else{
this.editFieldPrefix+="N";
}
_6ac=false;
}
this.editFieldPrefix+=$G.Actions.fieldSep;
}
this.editFieldState=[];
this.editFieldState.length=this.grid.getStore().getTotalCount();
$G.Actions.computeEditField(this);
this.insertInProgress=false;
this.insertEvent=null;
this.grid.addListener("beforeedit",$G.Actions.beforeEdit,this);
this.grid.addListener("edit",$G.Actions.afterEdit,this,true);
}
if(_6a1){
this.grid.getStore().addListener("beforeload",$G.Actions.beforeLoad,this,true);
}
this.grid.getSelectionModel().addListener("select",$G.rowSelect,this,true);
this.grid.getSelectionModel().addListener("beforerowselect",$G.beforeRowSelect,this,true);
};
$G.Actions.beforeLoad=function(_6ad,_6ae){
var _6af=_6ad.sortInfo;
var _6b0=(_6ae.sorters[0]&&_6ae.sorters[0].property!=this.sortCol);
if(_6b0&&!this.preservePageOnSort){
_6ae.start=0;
_6ae.page=1;
_6ad.currentPage=1;
}
if(_6ae.sorters[0]){
this.sortCol=_6ae.sorters[0].property;
this.sortDir=_6ae.sorters[0].direction;
}
};
$G.Actions.onLoad=function(_6b1){
this.editOldValue=null;
this.selectedRow=-1;
this.insertInProgress=false;
var _6b2=0;
if((this.bindOnLoad||!this.dynamic)&&this.selectOnLoad&&!this.grouping&&(_6b1.data&&_6b1.data.length)){
this.grid.getSelectionModel().select(_6b2,false);
}
if(!this.gridRendered&&this.onLoadFunction&&typeof this.onLoadFunction=="function"){
this.gridRendered=true;
this.onLoadFunction.call(null,this.grid);
}
$G.applyStyles(_6b1);
try{
var _6b3=Ext.ComponentQuery.query("tabpanel");
if(_6b3&&this.grid&&this.loaded==false){
for(var i=0;i<_6b3.length;i++){
if(_6b3[i].body.dom.innerHTML.indexOf(this.grid.id)>0){
_6b3[i].doComponentLayout();
this.loaded=true;
}
}
}
}
catch(exception){
}
};
$G.Actions._cf_getAttribute=function(_6b5){
_6b5=_6b5.toUpperCase();
var _6b6=this.selectedRow;
var _6b7=null;
if(_6b6!=0&&(!_6b6||_6b6==-1)){
return _6b7;
}
var ds=this.grid.getStore();
var _6b9=(this.dynamic)?ds.getAt(_6b6):ds.getById(_6b6);
_6b7=_6b9.get(_6b5);
return _6b7;
};
$G.Actions._cf_register=function(_6ba,_6bb,_6bc){
this.selectionChangeEvent.subscribe(_6bb,_6bc);
};
$G.rowSelect=function(_6bd,_6be,row){
var _6c0="";
var _6c1=_6bd.selected.items;
if(_6c1.length==0){
return;
}
var _6c2=_6c1[0].get("CFGRIDROWINDEX")||row;
if(this.selectedRow!=_6c2){
this.selectedRow=_6c2;
var _6c3=true;
for(col in _6c1[0].data){
if(col=="CFGRIDROWINDEX"){
continue;
}
if(typeof col=="undefined"||col=="undefined"){
continue;
}
if(!_6c3){
_6c0+="; ";
}
_6c0+="__CFGRID__COLUMN__="+col+"; ";
_6c0+="__CFGRID__DATA__="+_6c1[0].data[col];
_6c3=false;
}
this.fireSelectionChangeEvent();
this.insertInProgress=false;
}
};
$G.beforeRowSelect=function(_6c4,row){
var ds=this.grid.getStore();
var _6c7=ds.getAt(row);
return !$G.isNullRow(_6c7.data);
};
$G.isNullRow=function(data){
var _6c9=true;
for(col in data){
if(data[col]!=null){
_6c9=false;
break;
}
}
return _6c9;
};
$G.fireSelectionChangeEvent=function(){
$L.info("grid.fireselectionchangeevent.fire","widget",[this.id]);
this.selectionChangeEvent.fire();
};
$G.cellClick=function(grid,td,_6cc,_6cd,tr,_6cf,e,_6d1){
var _6d2=this.cellClickInfo.colInfo[_6cc];
if(_6d2){
var _6d3=grid.getSelectionModel().selected;
var url;
if(_6d3.items.length>0&&_6d3.items[0].raw){
url=_6d3.items[0].raw[_6d2.href.toUpperCase()];
}
if(!url){
url=_6d2.href;
}
var _6d5=_6d2.hrefKey;
var _6d6=_6d2.target;
var _6d7=this.appendKey;
if(this.cellClickInfo.appendKey){
var _6d8;
if(_6d5||_6d5==0){
var _6d9=grid.getStore().getAt(_6cf);
var _6da=grid.panel.columns[_6d5].dataIndex;
_6d8=_6d9.get(_6da);
}else{
var _6db=this.grid.columns;
_6d8=_6d3.items[0].get(_6db[0].dataIndex);
for(var i=1;i<_6db.length-1;i++){
_6d8+=","+_6d3.items[0].get(_6db[i].dataIndex);
}
}
if(url.indexOf("?")!=-1){
url+="&CFGRIDKEY="+_6d8;
}else{
url+="?CFGRIDKEY="+_6d8;
}
}
if(_6d6){
_6d6=_6d6.toLowerCase();
if(_6d6=="_top"){
_6d6="top";
}else{
if(_6d6=="_parent"){
_6d6="parent";
}else{
if(_6d6=="_self"){
_6d6=window.name;
}else{
if(_6d6=="_blank"){
window.open(encodeURI(url));
return;
}
}
}
}
if(!parent[_6d6]){
ColdFusion.handleError(null,"grid.cellclick.targetnotfound","widget",[_6d6]);
return;
}
parent[_6d6].location=encodeURI(url);
}else{
window.location=encodeURI(url);
}
}
};
$G.insertRow=function(){
if(this.insertInProgress&&this.dynamic){
ColdFusion.handleError(null,"Multiple row insert is not supported","Grid",[this.gridId],null,null,true);
return;
}
var _6dd={action:"I",values:[]};
var _6de=this.grid.columns;
var _6df=this.grid.getStore();
var _6e0={};
var _6e1="{[";
for(var i=0;i<_6de.length-1;i++){
var _6e3="";
_6dd.values[i]=[_6e3,_6e3];
_6e0[_6de[i].dataIndex]=_6e3;
_6e1=_6e1+_6de[i].colName+":'"+_6e3+"',";
}
_6e0["CFGRIDROWINDEX"]=_6df.getCount()+1;
_6e1=_6e1+"CFGRIDROWINDEX:'"+(_6df.getCount()+1)+"']}";
_6df.add(_6e1);
_6df.getAt(_6df.getCount()-1).data["CFGRIDROWINDEX"]=_6df.getCount();
if(this.dynamic==true){
this.selectedRow=_6df.getCount();
}
this.editFieldState.push(_6dd);
this.grid.getSelectionModel().select(_6df.getCount()-1);
this.insertInProgress=true;
$G.Actions.computeEditField(this);
};
$G.saveNewRecord=function(){
if(!this.insertInProgress){
return;
}
var _6e4=this.selectedRow;
var _6e5=this.insertEvent;
if(_6e4==-1){
return;
}
if(this.onChangeFunction){
this.onChangeHandler("I",_6e4-1,_6e5,$G.insertRowCallback);
}else{
if(this.dynamic==false){
var _6e6=this.grid.getStore();
var _6e7=_6e5.record;
var _6e8=new Array(1);
_6e8[0]=_6e7;
var _6e9=_6e6.getAt(this.selectedRow-1);
_6e6.remove(_6e9);
_6e6.add(_6e8);
}
}
this.insertInProgress=false;
this.insertEvent=null;
};
$G.cancelNewRecord=function(){
if(!this.insertInProgress){
return;
}
this.editFieldState.pop();
var _6ea=this.grid.getStore();
var _6eb=_6ea.getAt(this.selectedRow-1);
_6ea.remove(_6eb);
this.insertInProgress=false;
this.insertEvent=null;
this.selectedRow=this.selectedrow-1;
};
$G.deleteRow=function(){
var _6ec=null;
var _6ed;
if(this.multiRowSelection===true){
var _6ee=this.grid.getSelectionModel();
_6ec=_6ee.selected;
}
_6ec=this.grid.getSelectionModel().getSelection();
if(_6ec!=null&&_6ec.length<2){
_6ec=null;
}
if(_6ec==null){
_6ed=this.selectedRow;
}
if(_6ed==-1&&_6ec==null){
return;
}
if(this.onChangeFunction){
if(_6ec!=null){
this.onChangeHandler_MultiRowsDelete("D",_6ec,null,$G.deleteRowCallback);
}else{
this.onChangeHandler("D",_6ed,null,$G.deleteRowCallback);
}
}else{
if(!this.dynamic){
var _6ef=this.grid.getStore();
if(_6ec!=null){
for(i=0;i<_6ec.length;i++){
var _6f0=_6ef.indexOf(_6ec[i]);
var _6f1=this.editFieldState[_6f0];
if(_6f1){
_6f1.action="D";
}else{
_6f1=$G.Actions.initEditState(this,"D",_6ec[i],_6f0+1);
}
}
for(i=0;i<_6ec.length;i++){
_6ef.remove(_6ec[i]);
}
}else{
var _6f1=this.editFieldState[_6ed-1];
if(_6f1){
_6f1.action="D";
}else{
var _6f2=this.grid.getStore().getById(_6ed);
_6f1=$G.Actions.initEditState(this,"D",_6f2,_6ed);
}
_6ef.remove(this.grid.getSelectionModel().getSelection());
}
$G.Actions.computeEditField(this);
this.grid.editingPlugin.completeEdit();
this.selectedRow=-1;
}
}
};
$G.deleteRowCallback=function(_6f3,_6f4){
var _6f5=_6f4._cf_grid.getStore();
var _6f6=_6f4._cf_grid_properties;
var _6f4=_6f5.lastOptions;
var key="start";
if(_6f5.getCount()==1){
if(_6f4.start>=_6f4.limit){
_6f4.start=_6f4.start-_6f4.limit;
}
_6f4.page=_6f4.page-1;
_6f5.reload(_6f4);
}else{
_6f5.reload();
}
if(_6f6.multiRowSelection){
var _6f8=_6f6.grid.getView().headerCt(0);
if(_6f8!=null){
var _6f9=Ext.Element.get(_6f8).first();
if(_6f9){
_6f9.replaceClass("x-grid3-hd-checker-on");
}
}
}
};
$G.insertRowCallback=function(_6fa,_6fb){
var _6fc=_6fb._cf_grid.getStore();
var _6fd=_6fb._cf_grid.actions;
_6fc.reload();
};
$G.Actions.beforeEdit=function(_6fe,e,_700){
if($G.isNullRow(e.record.data)){
return false;
}
this.editColumn=e.column;
this.editOldValue=e.value;
};
$G.Actions.afterEdit=function(_701,_702,_703){
var _704=_702.value;
if(_704==this.editOldValue){
return;
}
if(this.insertInProgress==false&&this.onChangeFunction){
this.onChangeHandler("U",this.selectedRow,_702);
}else{
if(!this.dynamic){
rowidx=_702.rowIdx;
if(!rowidx&&rowidx!=0){
rowidx=_702.row;
}
var _705=$G.computeActualRow_editField(this.editFieldState,_702.record.data.CFGRIDROWINDEX);
var _706=this.editFieldState[_705-1];
var _707=_702.colIdx;
if(!_707&&_707!=0){
_707=_702.column;
}
if(_706){
if(this.multiRowSelection===true&&this.insertInProgress==true){
_707=_707-1;
}
_706.values[_707][1]=_704;
}else{
var _708=this.grid.getStore().getById(_702.record.data.CFGRIDROWINDEX);
_706=$G.Actions.initEditState(this,"U",_708,_705);
var _709=this.editOldValue+"";
if(_702.column.type=="date"){
if(_709&&typeof _709=="string"){
_709=new Date(_709);
}
var _70a="F, j Y H:i:s";
if(_702.column&&_702.column.format){
_70a=_702.column.format;
}
_706.values[_707][1]=Ext.Date.format(_704,_70a);
_706.values[_707][0]=_709?Ext.Date.format(_709,_70a):_709;
}else{
_706.values[_707][0]=_709;
_706.values[_707][1]=_704;
}
}
$G.Actions.computeEditField(this);
}
}
this.editOldValue=null;
this.fireSelectionChangeEvent();
};
$G.computeActualRow_editField=function(_70b,_70c){
if(_70b.length==_70c){
return _70c;
}
var _70d=0;
var _70e=0;
for(;_70e<_70b.length&&_70d<_70c;_70e++){
var _70f=_70b[_70e];
if(!_70f||_70f.action!="D"){
_70d++;
}
}
return _70e;
};
$G.Actions.onChangeHandler=function(_710,_711,_712,_713){
var _714={};
var _715={};
var data="";
if(null==_712){
data=this.grid.getStore().getAt(_711).data;
}else{
data=_712?_712.record.data:this.grid.getStore().getAt(_711).data;
}
for(col in data){
_714[col]=data[col];
}
if(_710=="U"){
if((_712.value==null||_712.value=="")&&(_712.originalValue==null||_712.originalValue=="")){
return;
}
if(_712.value&&_712.column.type=="date"){
if(typeof _712.originalValue=="string"){
var _717=new Date(_712.originalValue);
}
if(_717!=null&&_717.getElapsed(_712.value)==0){
return;
}else{
_714[_712.field]=_712.originalValue;
var _718="F, j Y H:i:s";
if(_712.column.format){
_718=_712.column.format;
}
_715[_712.field]=Ext.Date.format(_712.value,_718);
}
}else{
_714[_712.field]=_712.originalValue;
_715[_712.field]=_712.value;
}
}
this.onChangeFunction(_710,_714,_715,_713,this.grid,this.onErrorFunction,this);
};
$G.Actions.onChangeHandler_MultiRowsDelete=function(_719,_71a,_71b,_71c){
var _71d=new Array();
var _71e={};
for(i=0;i<_71a.length;i++){
_71d[i]=_71a.items[i].data;
}
this.onChangeFunction(_719,_71d,_71e,_71c,this.grid,this.onErrorFunction,this);
};
$G.Actions.initEditState=function(_71f,_720,_721,_722){
var _723={action:_720,values:[]};
var _724=_71f.grid.columns;
var _725=_724.length-1;
_723.values.length=_725;
var i=0;
if(_71f.multiRowSelection===true&&_71f.dynamic===false){
i=i++;
}
for(i;i<_725;i++){
var _727=_721.get(_724[i].colName);
_723.values[i]=[_727,_727];
}
_71f.editFieldState[_722-1]=_723;
return _723;
};
$G.Actions.fieldSep=eval("'\\u0001'");
$G.Actions.valueSep=eval("'\\u0002'");
$G.Actions.nullValue=eval("'\\u0003'");
$G.Actions.computeEditField=function(_728){
if(_728.dynamic){
return;
}
var _729=_728.editFieldPrefix;
var _72a=_728.editFieldState;
var _72b=_728.grid.columns;
var _72c=0;
var _72d="";
for(var i=0;i<_72a.length;i++){
var _72f=_72a[i];
if(_72f){
_72c++;
_72d+=$G.Actions.fieldSep;
_72d+=_72f.action+$G.Actions.valueSep;
var _730=_72f.values;
if(_728.multiRowSelection===true&&_728.dynamic===false&&_72f.action!="I"){
_730=_730.slice(1,_730.length);
}
for(var j=0;j<_730.length;j++){
if(j>0){
_72d+=$G.Actions.valueSep;
}
var _732=($G.Actions.isNull(_730[j][0]))?$G.Actions.nullValue:_730[j][0];
var _733=($G.Actions.isNull(_730[j][1]))?$G.Actions.nullValue:_730[j][1];
var _734=j;
if(_728.multiRowSelection===true){
_734++;
}
if(_72b[_734].getEditor()&&_733==$G.Actions.nullValue&&_72b[_734].getEditor().xtype=="checkbox"){
_733="0";
}
if(_72f.action!="I"||(_72f.action=="I"&&_72b[_734].getEditor())){
_72d+=_733;
if(_72f.action=="U"&&_72b[_734].getEditor()){
_72d+=$G.Actions.valueSep+_732;
}
}
}
}
}
_729+=_72c+_72d;
_728.editField.setAttribute("value",_729);
};
$G.Actions.isNull=function(val){
var ret=(val==null||typeof (val)=="undefined"||val.length==0);
return ret;
};
$G.loadData=function(data,_738){
_738._cf_gridDataProxy.loadResponse(data,_738);
var _739=ColdFusion.objectCache[_738._cf_gridname];
$G.applyStyles(_739);
$L.info("grid.loaddata.loaded","widget",[_738._cf_gridname]);
if($G.Actions.isNull(data.TOTALROWCOUNT)==false&&data.TOTALROWCOUNT==0){
_739.fireSelectionChangeEvent();
}
};
$G.printObject=function(obj){
var str="";
for(key in obj){
str=str+"  "+key+"=";
value=obj[key];
str+=value;
}
return str;
};
$G.formatBoolean=function(v,p,_73e){
return "<div class=\"x-grid3-check-col"+(v?"-on":"")+" x-grid3-cc-"+this.id+"\">&#160;</div>";
};
$G.formatDate=function(_73f,p,_741){
if(_73f&&!_73f.dateFormat){
_73f=new Date(_73f);
}
var _742=this.dateFormat?this.dateFormat:"m/d/y";
return _73f?Ext.Date.dateFormat(_73f,_742):"";
};
$G.convertDate=function(_743,p,_745){
if(_743&&!_743.dateFormat){
_743=new Date(_743);
}
var _746=this.dateFormat?this.dateFormat:"m/d/y";
return _743;
};
$G.ExtProxy=function(_747,_748){
this.api={load:true,create:undefined,save:undefined,destroy:undefined};
$G.ExtProxy.superclass.constructor.call(this);
this.bindHandler=_747;
this.errorHandler=_748;
};
Ext.extend($G.ExtProxy,Ext.data.DataProxy,{_cf_firstLoad:true,load:function(_749,_74a,_74b,_74c,arg){
if(!this._cf_actions.bindOnLoad){
var _74e={"_cf_reader":_74a,"_cf_grid_errorhandler":this.errorHandler,"_cf_scope":_74c,"_cf_gridDataProxy":this,"_cf_gridname":this._cf_gridName,"_cf_arg":arg,"_cf_callback":_74b,"ignoreData":true};
var data=[];
for(i=0;i<_749.limit;i++){
data.push(new Ext.data.Record({}));
}
this.loadResponse(data,_74e);
this._cf_actions.bindOnLoad=true;
}else{
var _750=(_749.start/_749.limit)+1;
if(!_749.sort){
_749.sort="";
}
if(!_749.dir){
_749.dir="";
}
this.bindHandler(this,_750,_749.limit,_749.sort,_749.dir,this.errorHandler,_74b,_74c,arg,_74a);
}
},loadResponse:function(data,_752){
var _753=null;
if(_752.ignoreData){
_753={success:true,records:data,totalRecords:data.length};
}else{
var _754;
if(!data){
_754="grid.extproxy.loadresponse.emptyresponse";
}else{
if(!data.TOTALROWCOUNT&&data.TOTALROWCOUNT!=0){
_754="grid.extproxy.loadresponse.totalrowcountmissing";
}else{
if(!ColdFusion.Util.isInteger(data.TOTALROWCOUNT)){
_754="grid.extproxy.loadresponse.totalrowcountinvalid";
}else{
if(!data.QUERY){
_754="grid.extproxy.loadresponse.querymissing";
}else{
if(!data.QUERY.COLUMNS||!ColdFusion.Util.isArray(data.QUERY.COLUMNS)||!data.QUERY.DATA||!ColdFusion.Util.isArray(data.QUERY.DATA)||(data.QUERY.DATA.length>0&&!ColdFusion.Util.isArray(data.QUERY.DATA[0]))){
_754="grid.extproxy.loadresponse.queryinvalid";
}
}
}
}
}
if(_754){
ColdFusion.handleError(_752._cf_grid_errorHandler,_754,"widget");
this.fireEvent("loadexception",this,_752,data,e);
return;
}
_753=_752._cf_reader.readRecords(data);
}
this.fireEvent("load",this,_752,_752._cf_arg);
_752._cf_callback.call(_752._cf_scope,_753,_752._cf_arg,true);
},update:function(_755){
},updateResponse:function(_756){
}});
$G.ExtReader=function(_757){
this.recordType=Ext.data.Record.create(_757);
};
Ext.extend($G.ExtReader,Ext.data.DataReader,{readRecords:function(_758){
var _759=[];
var cols=_758.QUERY.COLUMNS;
var data=_758.QUERY.DATA;
for(var i=0;i<data.length;i++){
var _75d={};
for(var j=0;j<cols.length;j++){
_75d[cols[j]]=data[i][j];
}
_759.push(new Ext.data.Record(_75d));
}
return {success:true,records:_759,totalRecords:_758.TOTALROWCOUNT};
}});
$G.CheckColumn=function(_75f){
Ext.apply(this,_75f);
if(!this.id){
this.id=Ext.id();
}
this.renderer=this.renderer.bind(this);
};
$G.findColumnIndex=function(grid,_761){
var _762=grid.headerCt.getGridColumns();
for(var i=0;i<_762.length;i++){
if(_762[i].dataIndex==_761){
return i;
}
}
};
$G.CheckColumn.prototype={init:function(grid){
this.grid=grid;
this.count=0;
this.columnIndex=$G.findColumnIndex(this.grid,this.dataIndex);
this.grid.on("render",function(){
var view=this.grid.getView();
if(this.editable==true){
this.grid.addListener("itemmousedown",this.onMouseDown,this);
}
},this);
},onMouseDown:function(thi,_767,item,_769,e,_76b){
var t=e.target;
if(t.className&&t.className.indexOf("x-grid-cc-"+this.id)!=-1){
e.stopEvent();
var _76d=ColdFusion.clone(_767);
_76d.data=ColdFusion.clone(_767.data);
this.grid.getSelectionModel().select(_769);
this.grid.getSelectionModel().fireEvent("rowselect",this.grid.getSelectionModel(),_769);
this.grid.fireEvent("beforeedit",this,{grid:this.grid,row:_769,record:_767,column:this.columnIndex,field:this.dataIndex,value:_767.data[this.dataIndex]});
_767.set(this.dataIndex,this.toggleBooleanValue(_767.data[this.dataIndex]));
this.grid.fireEvent("edit",this,{grid:this.grid,row:_769,record:_76d,column:this.columnIndex,field:this.dataIndex,value:_767.data[this.dataIndex],originalValue:_76d.data[this.dataIndex]});
}
},toggleBooleanValue:function(v){
v=typeof v=="undefined"?"N":(typeof v=="string"?v.toUpperCase():v);
if(v==="Y"){
return "N";
}
if(v==="N"){
return "Y";
}
if(v===true){
return false;
}
if(v===false){
return true;
}
if(v===0){
return 1;
}
if(v===1){
return 0;
}
if(v==="YES"){
return "NO";
}
if(v==="NO"){
return "YES";
}
if(v==="T"){
return "F";
}
if(v==="F"){
return "T";
}
return "Y";
},renderer:function(v,p,_771){
p.css+=" x-grid-check-col-td";
var _772=false;
v=(typeof v=="string")?v.toUpperCase():v;
if(typeof v!="undefined"&&(v==1||v=="1"||v=="Y"||v=="YES"||v=="TRUE"||v===true||v==="T")){
_772=true;
}
return "<div style=\"background-repeat: no-repeat;background-position:center center;width:auto\" class=\"x-grid-cell-checker"+(_772!=true?"-off":"")+" x-grid-cc-"+this.id+"\">&#160;</div>";
}};
$G.convertBoolean=function(v,_774){
v=typeof v=="undefined"?"N":(typeof v=="string"?v.toUpperCase():v);
if(v==="Y"){
return "YES";
}
if(v==="N"){
return "NO";
}
if(v===true){
return "YES";
}
if(v===false){
return "NO";
}
if(v===0){
return "NO";
}
if(v===1){
return "YES";
}
if(v==="YES"){
return "YES";
}
if(v==="NO"){
return "NO";
}
if(v==="T"){
return "YES";
}
if(v==="F"){
return "NO";
}
if(v==="FALSE"){
return "NO";
}
if(v==""){
return "NO";
}
if(v.toUpperCase()=="NULL"){
return "NO";
}
return "YES";
};
Ext.define("MyReader",{extend:"Ext.data.reader.Json",alias:"reader.my-json",read:function(_775){
var _776=_775.responseText;
if(!_776){
_776=_775;
}
var _777="";
if(!this.proxy._cf_actions.bindOnLoad){
_777="{  totalrows:0, data :[] }";
this.proxy._cf_actions.bindOnLoad=true;
}else{
_777=$G.queryToJson(_776);
}
$G.applyStyles(this.proxy._cf_actions);
return this.callParent([Ext.decode(_777)]);
}});
Ext.define("customcfajax",{extend:"Ext.data.proxy.Ajax",alias:"proxy.customcfajax",getParams:function(_778){
params=this.callParent(arguments);
if(!(this.sortParam&&_778.sorters&&_778.sorters.length>0)){
params[this.sortParam]="";
params[this.directionParam]="ASC";
}
return params;
}});
Ext.define("Ext.data.proxy.JsProxy",{requires:["Ext.util.MixedCollection","Ext.Ajax"],extend:"Ext.data.proxy.Server",alias:"proxy.jsajax",alternateClassName:["Ext.data.HttpProxy","Ext.data.JsProxy"],actionMethods:{create:"POST",read:"GET",update:"POST",destroy:"POST"},binary:false,jsfunction:"",extraparams:[],getParams:function(_779){
params=this.callParent(arguments);
if(!(this.sortParam&&_779.sorters&&_779.sorters.length>0)){
params[this.sortParam]="";
params[this.directionParam]="ASC";
}
return params;
},processResponse:function(_77a,_77b,_77c,_77d,_77e,_77f){
var me=this,reader,result;
if(_77a===true){
reader=me.getReader();
reader.applyDefaults=_77b.action==="read";
result=reader.read(me.extractResponseData(_77d));
if(result.success!==false){
Ext.apply(_77b,{response:_77d,resultSet:result});
_77b.commitRecords(result.records);
_77b.setCompleted();
_77b.setSuccessful();
}else{
_77b.setException(result.message);
me.fireEvent("exception",this,_77d,_77b);
}
}else{
me.setException(_77b,_77d);
me.fireEvent("exception",this,_77d,_77b);
}
if(typeof _77e=="function"){
_77e.call(_77f||me,_77b);
}
},doRequest:function(_781,_782,_783){
var me=this;
op=_781;
sorters=_781.sorters;
sortcol="";
sortdir="ASC";
if(sorters.length>0){
sortcol=sorters[0].property;
sortdir=sorters[0].direction;
}
if(this._cf_actions.bindOnLoad){
result=eval(this.jsfunction);
}else{
var _785=[];
for(i=0;i<this._cf_actions.grid.columns.length;i++){
var _786=this._cf_actions.grid.columns[i];
_785[i]=_786.colName;
}
result="{  totalrows:0, QUERY : { COLUMNS : "+_785+" data :[] }}";
}
me.processResponse(true,_781,"",result,_782,_783);
return null;
},getMethod:function(_787){
return this.actionMethods[_787.action];
},createRequestCallback:function(_788,_789,_78a,_78b){
var me=this;
return function(_78d,_78e,_78f){
me.processResponse(_78e,_789,_788,_78f,_78a,_78b);
};
}},function(){
Ext.data.HttpProxy=this;
});
$G.queryToJson=function(data){
var _791=[];
jsondata=ColdFusion.AjaxProxy.JSON.decode(data);
var cols=jsondata.QUERY.COLUMNS;
var data=jsondata.QUERY.DATA;
var _793="{  totalrows:"+jsondata.TOTALROWCOUNT+", data :[";
for(var i=0;i<data.length;i++){
var _795={};
_793=_793+"{";
for(var j=0;j<cols.length;j++){
if(data[i][j]==null){
data[i][j]="";
}
_795[cols[j]]=data[i][j];
encodedata=ColdFusion.AjaxProxy.JSON.encode(data[i][j]);
_793=_793+cols[j]+":"+encodedata;
if(j!=cols.length-1){
_793=_793+",";
}
}
_793=_793+"}";
if(i!=data.length-1){
_793=_793+",";
}
}
_793=_793+"]}";
return _793;
};
$G.queryToArray=function(data){
var _798=[];
jsondata=ColdFusion.AjaxProxy.JSON.decode(data);
var cols=jsondata.QUERY.COLUMNS;
var data=jsondata.QUERY.DATA;
var _79a=new Array();
for(var i=0;i<data.length;i++){
var _79c=new Array(1);
for(var j=0;j<cols.length;j++){
_79c[j]=data[i][j];
}
_79a[i]=_79c;
}
return _79a;
};
};
cfinitgrid();
