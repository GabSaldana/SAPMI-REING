/**
* My RESTFul Event Handler
*/
//component extends="BaseHandler"{
component {	
	property name="CN" 	 inject="CVU.CN_CVU";
	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only 	= "";
	this.prehandler_except 	= "";
	this.posthandler_only 	= "";
	this.posthandler_except = "";
	this.aroundHandler_only = "";
	this.aroundHandler_except = "";		

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {
		index = 'POST,GET'
	};
	
	/**
	* Index
	*/
	any function index( event, rc, prc ){
		/*GET*/
		// var authDetails = event.getHTTPBasicCredentials();
		// event.renderData( type="JSON", data=authDetails);
		
		message = structNew();
		if(StructKeyExists(rc, "curp")){	
			event.renderData( type="JSON", data=CN.getEstadoInvestigador(rc.CURP));
		}
		else{
			message['message'] = 'CURP no definido';
			event.renderData( type="JSON", data=message);
		}
		/*POST*/
		
		//var authDetails = event.getHTTPBasicCredentials();
		//var test = event.getHTTPContent();
		//var test = rc.curp;
		//var valores = DeserializeJSON(event.getHTTPContent());
		
		//event.renderData( type="JSON", data=CN.getEstadoInvestigador(valores.CURP));
		//event.renderData( type="JSON", data=test);
		//var datos  = event.getHTTPMethod();
		//4event.renderData( type="JSON", data=datos);
		
	}
}