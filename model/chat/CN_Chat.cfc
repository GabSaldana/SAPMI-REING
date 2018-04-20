<!---
* ================================
* IPN – CSII
* Sistema: PDIPIMP
* Modulo: Chat
* Sub modulo: Administrador de eventos 
* Fecha 12 de junio del 2017
* Descripcion: Model para el manejo de los eventos del modulo de chat
* Autores: Alejandro Rosales 
		   Jonathan Martinez 
* ================================
--->


 <cfcomponent accessors="true" singleton  threadSafe="true" >
	 <cfproperty name="dao" inject="chat/DAO_Chat">
	 <cfproperty name="cache" inject="cachebox:default">
	 <cfproperty name="populator" inject="wirebox:populator">
	 <cfproperty name="wirebox" inject="wirebox">
	
	 <cffunction name="init">
		 <cfscript>
			 return this;
		 </cfscript>
	 </cffunction>
	 <!---
	 	 *Fecha :15 de junio de 2017
	 	 *@author Jonathan Martinez 
     --->
	 <cffunction name="getSubcanales" hint="Funcion para obtener los subcanales" >
	 	 <cfargument name="rol" type="numeric" required="yes" hint="Rol del usuario">
		 <cfscript>
		 	 var chat=dao.getSubcanales(rol);
		 	 return chat.subcanales;
		 </cfscript>
	 </cffunction>
	 <!---
	 	 *Fecha :12 de junio de 2017
	 	 *@author Jonathan Martinez 
     --->
	 <cffunction name="guardarChat" hint="Funcion para guardar conversaciones" >
		 <cfargument name="user">
		 <cfargument name="texto">
		 <cfargument name="hora">
		 <cfargument name="proceso">
		 <cfscript>
		 	 var conversacion = structNew();
		 	 var res=dao.getChat(proceso);
			 if(res.recordcount == 0 || res.CHAT==""){
				 var chat= ArrayNew(1);
			 }
			 else{
			  var chat=deserializeJSON(res.CHAT);
			 }
		 	 conversacion['username']=user;
		 	 conversacion['msg']=texto;
		 	 conversacion['hour']=hora;
		 	 //var res=dao.getChat();
		 	 //var chatBD=deserializeJSON(res.CHAT);
		 	 //ArrayAppend(chat,chatBD,true);
		 	 ArrayAppend(chat, conversacion); 
		 	// cache.set(proceso,chat,120,120);
		 	 dao.guardarChat(chat,proceso);
			 return chat;
		 </cfscript>
		
	 </cffunction>
	  <!---
	 	 *Fecha :14 de junio de 2017
	 	 *@author Jonathan Martinez 
     --->
	<cffunction name="guardarBuzon" hint="Funcion para guardar en el Buzon" >
		 <cfargument name="username">
		 <cfargument name="nombre">
		 <cfscript>
		 	 var buzon=cache.get(nombre);
			 if(isNull(buzon)){
				 var buzon= ArrayNew(1);
			 }
			 if(arrayFind(buzon, username)==0){
			     ArrayAppend(buzon,username);
			     cache.set(nombre,buzon,120,120);
			 }
			 return true;
		 </cfscript>
	 </cffunction>
	 <!---
	 	 *Fecha :15 de junio de 2017
	 	 *@author Jonathan Martinez 
     --->
	 <cffunction name="eliminarBuzon" hint="Funcion para eliminar del Buzon" >
		 <cfargument name="username">
		 <cfargument name="nombre">
		 <cfscript>
		 	 var buzon=cache.get(nombre);
			 if(isNull(buzon)){
				 var buzon= ArrayNew(1);
			 }
			 if(arrayFind(buzon, username)!=0){
			 	 arrayDeleteAt(buzon,arrayFind(buzon, username));
			 	 cache.set(nombre,buzon,120,120);
			 }
			 return 0;
		 </cfscript>
	 </cffunction>
     <!---
	 	 *Fecha :12 de junio de 2017
	 	 *@author Jonathan Martinez 
     --->
	 <cffunction name="obtenerChat" hint="Funcion para obtener conversaciones" >
	 	<cfargument name="canal">
		 <cfscript>
		 	 //var chat=cache.get(canal);
		 	 var res=dao.getChat(canal);
			 if(res.recordcount > 0 && res.CHAT!=""){
				 return deserializeJSON(res.CHAT);
			 }
			 else{
			     return 0;
			 }

		 </cfscript>
	 </cffunction>
	  <!---
	 	 *Fecha :13 de junio de 2017
	 	 *@author Jonathan Martinez 
     --->
	 <cffunction name="obtenerProcesos" hint="Funcion para obtener procesos" >
	 	 <cfargument name="rol" type="numeric" hint="Rol del Usuario">
		 <cfscript>
		 	 var procesos= arrayNew(1);
		 	 var proceso=structNew();

		 	 var listaprocesos=dao.obtenerProcesos(rol);
			 for(var x=1; x lte listaprocesos.recordcount; x++ ){
				 var proceso=populator.populateFromQuery(wirebox.getInstance("chat/Proceso"),listaprocesos,x);
				 aux=cache.get(proceso.getNombre());
				 if(!isNull(aux)){
				  	 proceso.setEntrada(aux);
				 }
				 arrayAppend(procesos, proceso);
			 }
			 if(!isNull(procesos)){
				 return procesos;
			 }
			 else{
			     return 0;
			 }
		 </cfscript>
	 </cffunction>
	 <!---
    	 * Fecha creacion: Junio 12, 2017
    	 * @author Alejandro Rosales 
     --->
     <cffunction name="saveFile" access="remote" hint="Guardar archivo">
         <cfargument name="image" type="any" required="yes" />
         <cfset res = structNew()>
         <cfset thisDir = expandPath("\media")>
         <cffile action="upload" fileField="image" destination="#thisDir#" result="fileUpload" nameconflict="overwrite">
         <cfif fileUpload.fileWasSaved>
             <cfset nameSource = replace(fileUpload.serverFilename," ","-","ALL")> 
             <cfset nameFile = nameSource & "_" &#DateFormat(Now())#&"_"&#Hour(Now())#&"-"&#Minute(Now())#&"-"&#Second(Now())#&"." & fileUpload.serverFileExt>
             <cfset newFileName = fileUpload.serverDirectory & "/" & nameFile >
             <cffile action = "rename" source= "#fileUpload.serverDirectory#/#fileUpload.serverfile#" destination=#newFileName# mode="666"> 
             <cfif IsImageFile("#newFileName#")> 
                 <cfset kd ="IMG">
             <cfelse>
                 <cfset kd ="FILE">    
             </cfif>
         </cfif>
         <cfset src = kd>
         <cfset src = src & ";"& "/media/#getFileFromPath(newFileName)#">
         <cfset src = src & ";"& "#nameFile#">        
         <cfreturn src> 
     </cffunction>
     <!---
    	 * Fecha creacion: Agosto 07, 2017
    	 * @author Alejandro Rosales 
     --->

     <cffunction name="obtenerAProcesos" access="remote" hint="Funcion para obtener todos los procesos del sistema">
     	<cfscript>
 			return dao.obtenerAProcesos();
     	</cfscript>
    </cffunction>
    <!---
    	 * Fecha creacion: Agosto 07, 2017
    	 * @author Alejandro Rosales 
     --->
    <cffunction name="agregarProceso" access="remote" hint="Funcion para agregar un nueo proceso">
    	<cfargument name="name" type="any" required="yes" />
        <cfargument name="desc" type="any" required="yes" />
     	<cfscript>
     		var res=dao.comprobarNombre(name);
     		 if (res.recordcount == 0){ 
     		 	name = Trim(replace(name, " ","", "ALL"));
 				return dao.agregarProceso(name,desc);
     	     }else {
     	        return 0;
     	 	 }
     	</cfscript>
    </cffunction>
    <!---
    	 * Fecha creacion: Agosto 07, 2017
    	 * @author Alejandro Rosales 
     --->
    <cffunction name="eliminarProceso" access="remote" hint="Funcion para eliminar un proceso seleccionado procesos del sistema">
    	<cfargument name="pk" type="any" required="yes" />
      	<cfscript>
    		return dao.eliminarProceso(pk);
     	</cfscript>
    </cffunction>
     <!---
    	 * Fecha creacion: Agosto 07, 2017
    	 * @author Alejandro Rosales 
     --->
    <cffunction name="mostrarProcesos" access="remote" hint="Funcion para obtener los procesos">
      	<cfscript>
    		return dao.mostrarProcesos();
     	</cfscript>
    </cffunction>
     <!---
    	 * Fecha creacion: Agosto 07, 2017
    	 * @author Alejandro Rosales 
     --->
    <cffunction name="consultaTotalGral" access="remote" hint="Funcion para obtener informacion del proceso rol">
      	<cfscript>
    		return dao.consultaTotalGral();
     	</cfscript>
    </cffunction>
     <!---
    	 * Fecha creacion: Agosto 07, 2017
    	 * @author Alejandro Rosales 
     --->
    <cffunction name="altaProcesosRol" access="remote" hint="Alta de un nuevo proceso/rol">
    	<cfargument name="proceso" type="any" required="yes" />
        <cfargument name="rol" type="any" required="yes" />
      	<cfscript>
    		return dao.altaProcesosRol(proceso,rol);
     	</cfscript>
    </cffunction>
     <!---
    	 * Fecha creacion: Agosto 07, 2017
    	 * @author Alejandro Rosales 
     --->
    <cffunction name="bajaProcesosRol" access="remote" hint="Baja de un nuevo proceso/rol">
    	<cfargument name="proceso" type="any" required="yes" />
        <cfargument name="rol" type="any" required="yes" />
      	<cfscript>
    		return dao.bajaProcesosRol(proceso,rol);
     	</cfscript>
    </cffunction>
    <!---
    	 * Fecha creacion: Agosto 14, 2017
    	 * @author Alejandro Rosales 
     --->
    <cffunction name="editarProceso" access="remote" hint="Función para editar un proceso">
    	<cfargument name="pk" type="any" required="yes" />
    	<cfargument name="name" type="any" required="yes" />
        <cfargument name="desc" type="any" required="yes" />
      	<cfscript>
      		name = Trim(replace(name, " ","", "ALL"));
    		return dao.editarProceso(pk,name,desc);
     	</cfscript>
    </cffunction>


    <!---
    	 * Fecha creacion: Agosto 15, 2017
    	 * @author Jonathan Martinez
     --->
    <cffunction name="inicializarProceso" access="remote" hint="Función para inicializar un proceso">
    	<cfargument name="pk" type="any" required="yes" />
      	<cfscript>
    		return dao.inicializarProceso(pk);
     	</cfscript>
    </cffunction>


</cfcomponent>