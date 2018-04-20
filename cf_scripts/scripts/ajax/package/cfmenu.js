/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.Menu){
ColdFusion.Menu={};
}
ColdFusion.Menu.menuItemMouseOver=function(id,_203){
var _204=document.getElementById(id);
_204.tempfontcolor=_204.firstChild.style.color;
if(_203){
_204.firstChild.style.color=_203;
}
};
ColdFusion.Menu.menuItemMouseOut=function(id){
var _206=document.getElementById(id);
if(_206.tempfontcolor){
_206.firstChild.style.color=_206.tempfontcolor;
}else{
_206.firstChild.style.color="black";
}
};
ColdFusion.Menu.initMenu=function(_207,_208){
return new YAHOO.widget.Menu(_207,_208);
};
ColdFusion.Menu.initMenuBar=function(_209,_20a){
return new YAHOO.widget.MenuBar(_209,_20a);
};
