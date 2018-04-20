/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
ColdFusion.WebSocket={NS:"coldfusion.websocket.channels",WELCOME:"welcome",AUTHENTICATE:"authenticate",SUBSCRIBE:"subscribe",UNSUBSCRIBE:"unsubscribe",PUBLISH:"publish",INVOKE_AND_PUBLISH:"invokeAndPublish",GET_CHANNELS:"getChannels",GET_SUBSCRIBER_COUNT:"getSubscriberCount",GET_SUBSCRIPTIONS:"getSubscriptions",SEND_MESSAGE:"sendMessage",INVOKE_AND_MESSAGE:"invokeAndSend",INVOKE:"invoke",STOP:"stop",init:function(id,_1a0,_1a1,_1a2,_1a3,_1a4,_1a5,_1a6,_1a7,_1a8,_1a9){
if(cf_ws.isWebSocketSupported()){
lWSC=new cf_ws.CFWebSocketWrapper();
ColdFusion.WebSocket[id]=lWSC;
lWSC.options={OnWelcome:this.cfonOpencallBk,OnMessage:this.cfMessageHandlerCallBk,OnClose:_1a6,onError:_1a7,appName:_1a0,cfauth:_1a2,subscribeTo:_1a3,referrer:_1a8};
var _1aa=self.location.hostname;
if(!(self.WebSocket||self.MozWebSocket)&&_1a1==true){
var _1ab={ns:ColdFusion.WebSocket.NS,reqType:ColdFusion.WebSocket.WELCOME,code:-1,msg:"WebSocket over SSL will not work as your browser does not have native WebSockets support."};
var _1ac=_1a7!=null?_1a7:_1a4;
_1ac(_1ab);
return;
}
if(_1a1==false&&_1aa&&_1aa=="localhost"){
_1aa="127.0.0.1";
}
var _1ad;
var port;
if(_1a9){
if(self.location.port!=""){
port=self.location.port;
}else{
if(self.location.protocol!=""&&self.location.protocol=="https:"){
port=443;
}else{
port=80;
}
}
if(self.location.protocol!=""&&self.location.protocol=="https:"){
protocol="wss://";
}else{
protocol="ws://";
}
_1ad="/cfws";
}else{
port=_1a1?_cf_websocket_ssl_port:_cf_websocket_port;
_1ad="/cfusion"+"/cfusion";
protocol=_1a1?"wss://":"ws://";
}
var lURL=protocol+(_1aa)+":"+port+_1ad;
lWSC.options.url=lURL;
var lRes=lWSC.open(lURL,lWSC.options);
lWSC.isOpen=true;
lWSC.processConnected=function(_1b1){
};
lWSC.processDisconnected=function(_1b2){
};
lWSC.defaultMessageHandler=_1a4;
if(_1a5){
lWSC.appOnOpenHandler=_1a5;
}
lWSC.channelSpecificResHandlers={};
lWSC.subscribercount_callbackHandlers={};
return lWSC;
}else{
var _1ab={ns:ColdFusion.WebSocket.NS,reqType:ColdFusion.WebSocket.WELCOME,code:-1,msg:"Browser neither have native WebSocket support nor a flash player for the fallback."};
var _1ac=_1a7!=null?_1a7:_1a4;
_1ac(_1ab);
}
},welcome:function(_1b3,_1b4,_1b5){
var lRes=this.isConnected();
if(lRes==true){
this.sendToken({ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.WELCOME,authKey:_1b3,subscribeTo:_1b4,appName:_1b5});
}
return lRes;
},authenticate:function(_1b7,_1b8){
var lRes=this.isConnected();
if(lRes==true){
this.sendToken({ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.AUTHENTICATE,username:_1b7,password:_1b8,appName:this.options.appName});
}
return lRes;
},subscribe:function(_1ba,_1bb,_1bc){
var lRes=this.isConnected();
if(lRes==true){
var _1be={ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.SUBSCRIBE,channel:_1ba,appName:this.options.appName};
if(_1bb!=null&&(typeof _1bb=="object")){
_1be.customOptions=_1bb;
}
this.sendToken(_1be);
if(_1bc){
this.channelSpecificResHandlers[_1ba]=_1bc;
this.channelName_subscriptionInProcess=_1ba;
}
}
return lRes;
},unsubscribe:function(_1bf){
var lRes=this.isConnected();
if(lRes==true){
var _1c1={ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.UNSUBSCRIBE,channel:_1bf,appName:this.options.appName};
this.sendToken(_1c1);
delete this.channelSpecificResHandlers[_1bf];
}
return lRes;
},publish:function(_1c2,_1c3,_1c4){
var lRes=this.isConnected();
if(lRes==true){
var _1c6={ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.PUBLISH,channel:_1c2,data:_1c3,appName:this.options.appName};
if(_1c4!=null&&(typeof _1c4=="object")){
_1c6.customOptions=_1c4;
}
this.sendToken(_1c6);
}
return lRes;
},invokeAndPublish:function(_1c7,_1c8,_1c9,_1ca,_1cb){
var lRes=this.isConnected();
if(lRes==true){
var _1cd={ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.INVOKE_AND_PUBLISH,channel:_1c7,cfcName:_1c8,cfcMethod:_1c9,methodArguments:_1ca,appName:this.options.appName,referrer:this.options.referrer};
if(_1cb!=null&&(typeof _1cb=="object")){
_1cd.customOptions=_1cb;
}
this.sendToken(_1cd);
}
return lRes;
},getSubscriberCount:function(_1ce,_1cf){
var lRes=this.isConnected();
if(lRes==true){
var _1d1={ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.GET_SUBSCRIBER_COUNT,channel:_1ce,appName:this.options.appName};
this.sendToken(_1d1);
}
if(_1cf){
if(!this.subscribercount_callbackHandlers){
this.subscribercount_callbackHandlers={};
}
this.subscribercount_callbackHandlers[_1ce]=_1cf;
}
return lRes;
},getSubscriptions:function(_1d2){
var lRes=this.isConnected();
if(lRes==true){
var _1d4={ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.GET_SUBSCRIPTIONS,appName:this.options.appName};
this.sendToken(_1d4);
}
if(_1d2){
this.subscriptions_callbackHandler=_1d2;
}
return lRes;
},sendMessage:function(_1d5,_1d6,_1d7){
var lRes=this.isConnected();
if(lRes==true){
var _1d9={ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.SEND_MESSAGE,targetId:_1d5,data:_1d6,appName:this.options.appName};
if(_1d7!=null&&(typeof _1d7=="object")){
_1d9.customOptions=_1d7;
}
this.sendToken(_1d9);
}
return lRes;
},invokeAndSend:function(_1da,_1db,_1dc,_1dd,_1de){
var lRes=this.isConnected();
if(lRes==true){
var _1e0={ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.INVOKE_AND_MESSAGE,target:_1da,cfcName:_1db,cfcMethod:_1dc,methodArguments:_1dd,appName:this.options.appName};
if(_1de!=null&&(typeof _1de=="object")){
_1e0.customOptions=_1de;
}
this.sendToken(_1e0);
}
return lRes;
},invoke:function(_1e1,_1e2,_1e3,_1e4){
var lRes=this.isConnected();
if(lRes==true){
var _1e6={ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.INVOKE,cfcName:_1e1,cfcMethod:_1e2,methodArguments:_1e3,appName:this.options.appName,referrer:this.options.referrer};
if(_1e4!=null&&(typeof _1e4=="object")){
_1e6.customOptions=_1e4;
}
this.sendToken(_1e6);
}
return lRes;
},openConnection:function(){
var lURL=lWSC.options.url;
this.open(lURL,this.options);
},isConnectionOpen:function(){
var _1e8=this.isConnected();
return _1e8;
},closeConnection:function(){
this.close({fireClose:true});
},cfonOpencallBk:function(_1e9){
if(this.cfauth!=null||this.susbcribeTo!=null){
_1e9.welcome(this.cfauth,this.subscribeTo,this.appName);
}
if(_1e9.appOnOpenHandler){
_1e9.appOnOpenHandler(_1e9);
}
},cfMessageHandlerCallBk:function(_1ea,_1eb){
var _1ec=_1eb.defaultMessageHandler;
if((_1ea.type=="event")&&(_1ea.name=="connect"||_1ea.name=="disconnect")){
return;
}
if((_1ea.reqType=="subscribe")&&_1eb.channelName_subscriptionInProcess!=null){
if(_1ea.code==-1){
delete _1eb.channelSpecificResHandlers[_1eb.channelName_subscriptionInProcess];
}
delete _1eb.channelName_subscriptionInProcess;
}
if((_1ea.reqType=="getSubscriberCount")&&_1eb.subscribercount_callbackHandlers[_1ea.channel]!=null){
_1eb.subscribercount_callbackHandlers[_1ea.channel].call(this,_1ea);
delete _1eb.subscribercount_callbackHandlers[_1ea.channelname];
return;
}
if((_1ea.reqType=="getSubscriptions")&&_1eb.subscriptions_callbackHandler!=null){
_1eb.subscriptions_callbackHandler(_1ea);
delete _1eb.subscriptions_callbackHandler;
return;
}
if(_1ea.type=="data"&&_1ea.channelname){
var _1ed=_1ea.channelname;
var _1ee=_1eb.channelSpecificResHandlers[_1ed];
while(_1ee==null){
var lPos=_1ed.lastIndexOf(".");
if(lPos>0){
_1ed=_1ed.substr(0,lPos);
_1ee=_1eb.channelSpecificResHandlers[_1ed];
}else{
break;
}
}
if(_1ee){
_1ec=_1ee;
}
}
_1ec.call(this,_1ea);
}};
function cfwebsocketinit(){
var _1f0=ColdFusion.WebSocket;
ns=cf_ws;
for(var _1f1 in _1f0){
ns["CFWebSocketWrapper"].prototype[_1f1]=_1f0[_1f1];
}
}
cfwebsocketinit();
