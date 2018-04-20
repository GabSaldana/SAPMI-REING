<!---
* =====================================================================================
* IPN - CSII
* Sistema: SII 
* Modulo: Principal
* Sub modulo: Pruebas
* Fecha: Agosto 11, 2015
* Descripcion: Componente de negocio para la construcción de reportes estrátegicos.
* =====================================================================================
--->

<cfcomponent>

	<!---
	* Fecha creacion: Marzo 03, 2017
	* @author Alejandro Rosales 
	--->
	<cffunction name="getFiltroUR" access="remote" hint="Obtencion filtro por UR">
			<cfargument name="flag" type="numeric" required="yes" hint="Pk del conjunto de datos">
	
		<cfscript>
		/* if(Session.cbstorage.tree[1].pk EQ 'J00000')
			return "";
        if(flag == 1){
            key = "WHERE";
        }
        else{
        key = "AND";
    	}
			var filtro = " "&key&" (";
			for(i = 1; i<=arrayLen(Session.cbstorage.tree);i++){
              filtro = filtro & "DURURCLAVE = '" & Session.cbstorage.tree[i].pk & "' ";
              if(i != arrayLen(session.cbstorage.tree))
              	filtro = filtro & "OR ";
		}
		filtro = filtro&")";
		return filtro; */
		return "";
		</cfscript>

	</cffunction>


	<!---
	* Descripcion de la modificacion: Filtrado por UR
	* Fecha de la modificacion: Marzo 03, 2017
	* Autor de la modificacion: Alejandro Rosales
	* Descripcion de la modificacion: Limpieza del handler (CN,DAO)
	* Fecha de la modificacion: Febrero 17, 2017
	* Autor de la modificacion: Alejandro Rosales
	* Fecha creacion: Agosto 11, 2015
	* @author Yareli Andrade
	--->    
    <cffunction name="getTipoCol" access="remote" hint="Obtiene los campos de un conjunto de datos">
		<cfargument name="pkConjunto" type="numeric" required="yes" hint="Pk del conjunto de datos">
		<cfscript>
			var filtroUR = getFiltroUR(1);
			daoCampos = CreateObject('component', 'DAO_ConsultaVistaMat');	
			var campos = daoCampos.getTipoCol(pkConjunto);
			writeDump(campos);
			//abort;
			datos = [];
			for (var i = 1; i LTE campos.recordCount; i++){
				if(campos.TIPO[i] != 5){
			
					var nombre = getNombre(campos.VAL[i], Session.cbstorage.conjunto.ID);
					var valores = 0;
					if(campos.PRI[i] != 2){

						if(campos.TIPO[i] == 1 ){
							 eltos = getEltosCampo(nombre.N, Session.cbstorage.conjunto.NOMBRE,filtroUR);
							}
						else{
							 eltos = getEltosCampo(nombre.N, Session.cbstorage.conjunto.NOMBRE,"");
							}
					
						valores = ValueList(eltos.C);
					}
					arrayAppend(datos, {"root": campos.ROOT[i], "gral": campos.GRAL[i], "desc": campos.DES[i], "nombre":campos.NOM[i], "id": campos.VAL[i], "tipo": campos.TIPO[i], "eltos":ListToArray(valores), "priori": campos.PRI[i], "o": campos.OBL[i]});
				}
				else
					arrayAppend(datos, {"root": campos.ROOT[i], "gral": campos.GRAL[i], "desc": campos.DES[i], "nombre":campos.NOM[i], "id": campos.VAL[i], "tipo": campos.TIPO[i], "eltos":"-", "priori": campos.PRI[i]});
				
			}
			return datos;
			
		</cfscript>
    </cffunction>

    <!---
	* Fecha creacion: Agosto 14, 2015
	* @author Yareli Andrade
	--->  
    <cffunction name="getEltosCampo" access="remote" hint="Obtiene los elementos de un campo">
		<cfargument name="vista" type="string" required="yes" hint="Nombre de una vista">
		<cfargument name="columna" type="string" required="yes" hint="Nombre de una columna">
		<cfargument name="filtroUR" type="string" required="yes" hint="Nombre de una columna">
		
		<cfscript>
			daoEltos = CreateObject('component', 'DAO_ConsultaVistaMat');		
			return daoEltos.getEltosCampo(columna, vista,filtroUR);
		</cfscript>
    </cffunction>



	<!---
	* Fecha creacion: Agosto 21, 2015
	* @author Yareli Andrade
	--->  
    <cffunction name="getNombre" access="remote" hint="Obtiene el nombre de un campo">
		<cfargument name="pkCampo" type="numeric" required="yes" hint="Pk del conjunto de datos">
      	<cfargument name="pkConjunto" type="numeric" required="yes" hint="Pk del campo">
		<cfscript>
			daoEltos = CreateObject('component', 'DAO_ConsultaVistaMat');		
			return daoEltos.getNombre(pkConjunto, pkCampo);
		</cfscript>
    </cffunction>

    <!---
	* Fecha creacion: Agosto 31, 2015
	* @author Yareli Andrade
	--->    
    <cffunction name="getTipoCol2" access="remote" hint="Obtiene los campos de un tipo específico">
		<cfargument name="pkConjunto" type="numeric" required="yes" hint="Pk del conjunto de datos">
      	<cfargument name="tipo" type="numeric" required="yes" hint="Tipo de campo">
		<cfscript>
			daoCampos = CreateObject('component', 'DAO_ConsultaVistaMat');		
			return daoCampos.getTipoCol2(pkConjunto, tipo);
		</cfscript>
    </cffunction>


    <!---
	* Fecha creacion: Agosto 31, 2015
	* @author Yareli Andrade
	--->  
    <cffunction name="getEltosCampo2" access="remote" hint="Obtiene los elementos de un campo con base en un filtro definido">		
		<cfargument name="campo" type="string" required="yes" hint="Nombre del campo">
	    <cfargument name="filtro" type="string" required="yes" hint="Filtro">
	    <cfargument name="vista" type="string" required="yes" hint="Nombre de una vista">
	    <cfargument name="filtroUR" type="string" required="yes" hint ="Filtrado por UR">
		<cfscript>			
			daoEltos = CreateObject('component', 'DAO_ConsultaVistaMat');		
			return daoEltos.getEltosCampo2(campo, filtro, vista, filtroUR);
		</cfscript>
    </cffunction>




    <!---
	* Fecha : Septiembre 29, 2015
	* Autor : Yareli Andrade
	--->	
	<cffunction name="getNombreConjuntoDatos" access="public" returntype="struct" hint="Obtiene el nombre de un conjunto de datos">
		<cfargument name="pkConjunto" type="numeric" required="yes" hint="Pk del conjunto de datos">
		<cfscript>
			resultado = structNew();			
			daoConjunto = CreateObject('component', 'DAO_ConsultaVistaMat');		
			conjunto = daoConjunto.getNombreConjuntoDatos(pkConjunto);
			if (conjunto.RECORDCOUNT GT 0){
				resultado.ID = pkConjunto;
				resultado.NOMBRE = conjunto.REF;
				resultado.TITULO = conjunto.TIT;
				resultado.DESC = conjunto.DES;
			}
			return resultado;
		</cfscript>
	</cffunction>

  


	<!---
	* Fecha : Octubre 09, 2015
	* Autor : Yareli Andrade
	--->  
	<cffunction name="getOperacion" access="public" returntype="query" hint="Obtiene las posibles operaciones para aplicar en una columna">
	    <cfargument name="pkColumna" type="numeric" required="yes" hint="Pk de la columna">
	    <cfscript>
	    	daoEltos = createObject("component", "DAO_ConsultaVistaMat");
	    	return daoEltos.getOperacion(pkColumna);	    	
	    </cfscript>
	</cffunction>	

	<!---
	* Fecha : Octubre 09, 2015
	* Autor : Yareli Andrade
	--->  
	<cffunction name="getAggregateFunction" access="public" returntype="query" hint="Obtiene la funcion de una operacion">
	    <cfargument name="pkOperacion" type="numeric" required="yes" hint="Pk de la operacion">
	    <cfscript>
	    	daoEltos = createObject("component", "DAO_ConsultaVistaMat");
	    	return daoEltos.getAggregateFunction(pkOperacion);	    	
	    </cfscript>
	</cffunction>	
	
	<!---
  	* Fecha : Octubre 14, 2015
  	* Autor : Yareli Andrade
  	--->
  	<cffunction name="getRelacion" hint="">
	    <cfargument name="pkColumna" type="numeric" required="yes" hint="Pk de la columna">
      	<cfargument name="pkConjunto" type="numeric" required="yes" hint="Pk del conjunto">
      	<cfargument name="tipo" type="numeric" required="yes" hint="Tipo de columna">
	    <cfscript>
	    	daoEltos = createObject("component", "DAO_ConsultaVistaMat");
	    	return daoEltos.getRelacion(pkColumna, pkConjunto, tipo);	    	
	    </cfscript>
	</cffunction>	


    

    <!--- 
    * Descripcion de la modificacion: Filtrado por UR
	* Fecha de la modificacion: Marzo 03, 2017
	* Autor de la modificacion: Alejandro Rosales
	* Fecha : Octubre 14, 2015
  	* Autor : Yareli Andrade
  --->    
    <cffunction name="getConteoCN2" access="remote" hint="Obtiene conteo V2">
		<cfargument name="rc" type="any" required="yes" hint="Request Collection">
		
		<cfscript>
			var opciones = deserializeJSON(rc.opcion); 
            
			var daoConsulta = createObject('component','DAO_ConsultaVistaMat');
			var ejeY = getNombre(rc.hecho, Session.cbstorage.conjunto.ID);
			var ejeX = getNombre(rc.valores, Session.cbstorage.conjunto.ID);
			var tipo = rc.tipo;
			var etiqueta =  getNombre(rc.et, Session.cbstorage.conjunto.ID);
			var funcOperacion = getAggregateFunction(rc.op);

			//Validar si hay filtros seleccionados
			var filtro = "";
			var operation = "";
			if(arrayLen(opciones)>0){
				filtro = " WHERE ";
				for(var i = 1; i LTE arrayLen(opciones); i++){
					if(arrayLen(opciones[i]["value"]) NEQ 0){
					var nombre = getNombre(opciones[i]["id"], Session.cbstorage.conjunto.ID);
					var valores = "";
					for(var j = 1; j LTE arrayLen(opciones[i]["value"]); j++){
						valores = valores & "'" & opciones[i]["value"][j] & "',";
					}
					valores = left(valores, len(valores)-1);
					filtro = filtro & nombre.N & " IN (" & valores & ") AND ";
					}
				}
				filtro = left(filtro, len(filtro)-5);		
			}
			if(rc.et != "0" and compare(ejeY.N, "LINK")){
				var resultado = daoConsulta.getDatosTablaEtiqueta(ejeY,ejeX,etiqueta,Session.cbstorage.conjunto.NOMBRE,funcOperacion,filtro);
	
				var group = [];
				var label = [];
				var datosG = [];
				for( i= 1; i LTE resultado.RECORDCOUNT; i++){
                	if( arrayContains(label, resultado.TIPO[i]) EQ "NO")
   						arrayAppend(label, resultado.TIPO[i]);
                }

                for( i= 1; i LTE resultado.RECORDCOUNT; i++){
                	if( arrayContains(group, resultado.AGRUPACION[i]) EQ "NO")
   						arrayAppend(group, resultado.AGRUPACION[i]);
                }                
                numConjuntos  = arrayLen(group);
				var datosG = [];
				var currentConj = [];
				arrayAppend(datosG, group);
				nc = 0;
				for(i=1; i LTE resultado.RECORDCOUNT; i++){
					arrayAppend(currentConj, resultado.TOTAL[i]);

					if(arrayLen(currentConj) == numConjuntos){
						arrayAppend(datosG, currentConj);
						currentConj = [];
						nc ++;
					}					
				}
				arrayAppend(datosG, label);
				return datosG;
			}
			else{
			
				var resultado = daoConsulta.getDatosTabla(ejeY,ejeX,Session.cbstorage.conjunto.NOMBRE,funcOperacion,filtro);
				var label = [];
				var conjunto = [];
				var datosG = []; 						
				if(compare(ejeY.N, "LINK")){
				     for( i= 1; i LTE resultado.RECORDCOUNT; i++)               	
	   					 arrayAppend(label, resultado.TIPO[i]);                
	                 for(i= 1; i LTE resultado.RECORDCOUNT; i++)
	   					 arrayAppend(conjunto, resultado.TOTAL[i]);
	                 arrayAppend(datosG, label);
	                 arrayAppend(datosG, conjunto);
			    }	
			    else{				
	                 for( i= 1; i LTE resultado.RECORDCOUNT; i++)               	
   						 arrayAppend(label, resultado.TIPO[i]);                
                     for( i= 1; i LTE resultado.RECORDCOUNT; i++)
   						 arrayAppend(conjunto, resultado.LIGA[i]);
                     arrayAppend(datosG, label);
                     arrayAppend(datosG, conjunto);
                }
			    return datosG;

		}
		</cfscript>
    </cffunction>


    <!--- 
    * Descripcion de la modificacion: Filtrado por UR
	* Fecha de la modificacion: Marzo 03, 2017
	* Autor de la modificacion: Alejandro Rosales
	* Fecha : Octubre 14, 2015
  	* Autor : Yareli Andrade
  	--->    
 	<cffunction name="getCNUR" access="remote" hint="Evento que obtiene los elementos filtrados de un campo">
		<cfargument name="rc" type="any"  hint="Request Collections"> 
		<cfscript>
			//var rc = event-getCollection();
            var filtroUR1 = getFiltroUR(1);
            var filtroUR2 = getFiltroUR(2);
		    datos = [];
			/*Si es que el combo esta vacio*/
		    if(isNull(rc.elto)){
		    	var campos = getRelacion(rc.root, Session.cbstorage.conjunto.ID, rc.tipo);
				for (var i = 1; i LTE campos.recordCount; i++){
					var nombre = getNombre(campos.VAL[i], Session.cbstorage.conjunto.ID);
					eltos = getEltosCampo(nombre.N, Session.cbstorage.conjunto.NOMBRE,filtroUR1);
					desc = ValueList(eltos.C);
					arrayAppend(datos, {"id": campos.VAL[i], "nombre":campos.DES[i], "tipo": campos.TIPO[i], "eltos":ListToArray(desc)});
				}
			}
			else{

				var cambios = deserializeJSON(rc.cambios);
				var campos = getRelacion(rc.elto, Session.cbstorage.conjunto.ID, rc.tipo);
				var ordenMayor = campos.recordCount;
				var filtro = " ";
				var nombreCambio = getNombre(cambios[1].name, Session.cbstorage.conjunto.ID);
				var ordenCambio = nombreCambio.ORD;

				//Incluir el filtro correspondiente al combo modificado en la consulta.
				var filtro = " " & nombreCambio.N & " = '" & cambios[1].value[1] & "' AND ";
				var filtro0 = " " & nombreCambio.N & " = '" & cambios[1].value[1] & "' AND ";				
	
				/* Select2 */		
				//Filtro en el combo 1 y con más de una opción.
				if(arrayLen(cambios[1].value)>1){
					filtro = "";
					nombreFiltro = getNombre(cambios[1].name, Session.cbstorage.conjunto.ID);
					eltosCambios = "";
					// Select2 
					for(var j = 1; j LTE arrayLen(cambios[1].value); j++){
						eltosCambios = eltosCambios & "'" & cambios[1].value[j] & "',";
					}
					eltosCambios = left(eltosCambios, len(eltosCambios)-1);
					filtro = filtro & " " & nombreFiltro.N & " IN (" & eltosCambios & ") AND ";
					filtro0 = filtro;
				}

				//sin Select2
				//Incluir el resto de los filtros en la construcción de la consulta.
				if(arrayLen(cambios)>1){
					for(var i = 2; i LTE arrayLen(cambios); i++){

						nombreFiltro = getNombre(cambios[i].name, Session.cbstorage.conjunto.ID);
						ordenFiltro = nombreFiltro.ORD;						
						eltosCambios = "";
						
						if(ordenFiltro < ordenCambio){
							
							/* Select2 */
							for(var j = 1; j LTE arrayLen(cambios[i].value); j++){
								eltosCambios = eltosCambios & "'" & cambios[i].value[j] & "',";
							}
							eltosCambios = left(eltosCambios, len(eltosCambios)-1);
							filtro = filtro & " " & nombreFiltro.N & " IN (" & eltosCambios & ") AND ";
						}

					}																
				}


						filtro = left(filtro, len(filtro)-5);

			var desc = [];			
			for (var i = 1; i LTE campos.recordCount; i++){
				
				if (ordenCambio > campos.ORD[i]){ 					

					var nombre = getNombre(campos.VAL[i], Session.cbstorage.conjunto.ID);
					var eltos = getEltosCampo2(nombre.N, filtro, Session.cbstorage.conjunto.NOMBRE, filtroUR2);
					desc = ValueList(eltos.C);

					if (listLen(desc) == 1)
					{
						arrayAppend(datos, {"id": campos.VAL[i], "nombre": desc, "tipo": 0});						
						filtro = filtro &  " AND " & nombre.N & " = '" & desc & "' ";
					}	
					else{
						arrayAppend(datos, {"id": campos.VAL[i], "nombre":campos.DES[i], "tipo": campos.TIPO[i], "eltos":ListToArray(desc)});
					}
				}

				else if (ordenCambio < campos.ORD[i]){ 
							
						var nombre = getNombre(campos.VAL[i], Session.cbstorage.conjunto.ID);	
						var eltos = getEltosCampo2(nombre.N, filtro, Session.cbstorage.conjunto.NOMBRE, filtroUR2);
						valores = ValueList(eltos.C);			
						//Genera un objeto con descripción, id y los elementos de una columna.						
						arrayAppend(datos, {"id": campos.VAL[i], "nombre":campos.DES[i], "tipo": campos.TIPO[i], "eltos":ListToArray(valores)});
						
				}			

				else if(ordenMayor == campos.ORD[i]){//El mayor es igual al modificado
					filtroX = right(filtro, len(filtro)-len(filtro0));					
					var nombre = getNombre(campos.VAL[ordenMayor], Session.cbstorage.conjunto.ID);
					var eltos = getEltosCampo2(nombre.N, filtroX, Session.cbstorage.conjunto.NOMBRE, filtroUR2);
					valores = ValueList(eltos.C);
					arrayAppend(datos, {"id": campos.VAL[ordenMayor], "nombre":campos.DES[ordenMayor], "tipo": campos.TIPO[ordenMayor], "eltos":ListToArray(valores)});
					}
				}	

			}
			return datos;

		</cfscript>
	</cffunction>

	<!--- 
	* Fecha : Octubre 14, 2015
  	* Autor : Yareli Andrade
  --->    
	<cffunction name="getCNOperacion" access="public"  hint="Obtiene las posibles operaciones para aplicar en una columna">
	    <cfargument name="pkColumna" type="numeric" required="yes" hint="Pk de la columna">
	    <cfscript>
	    	var operacion = getOperacion(pkColumna);
	    	op = [];
	    	for (var i = 1; i LTE operacion.recordCount; i++){
				arrayAppend(op, {"id": operacion.PK[i], "desc": operacion.NOMBRE[i], "titulo": operacion.TITULO[i]});
			}
			return op;
	    </cfscript>
	</cffunction>

	<!--- 
	* Fecha : Octubre 14, 2015
  	* Autor : Yareli Andrade
  	--->    
	<cffunction name="inicializaCNCombos" access="public"  hint="Obtiene las posibles operaciones para aplicar en una columna">
	    <cfargument name="tipo" type="any" required="yes" hint="tipo">
	 	<cfscript>
	 		campos = getTipoCol2(Session.cbstorage.conjunto.ID, tipo);
			datos = [];
			for (var i = 1; i LTE campos.recordCount; i++){				
				var nombre = getNombre(campos.VAL[i], Session.cbstorage.conjunto.ID);
				var eltos = getEltosCampo(nombre.N, Session.cbstorage.conjunto.NOMBRE,"");
				desc = ValueList(eltos.C);
				arrayAppend(datos, {"id": campos.VAL[i], "nombre":campos.DES[i], "tipo": campos.TIPO[i], "eltos":ListToArray(desc)});
			}
			return datos;
			
	 	</cfscript>    	
	</cffunction>


	
	
	<!--- 
	* Fecha creacion: 15 de abril de 2016
    * @author Yareli Andrade
    --->	
	<cffunction name="getPDF" access="public" hint="Obtiene los datos para el PDF">
		<cfargument name="rc" type="any">
		<cfscript>
			
			//corefile     = ExpandPath('core.jar');
			//rc = event.getCollection();
			resultado = {};
			resultado.hora = TimeFormat(now(), "HH:mm");
			cadena = Session.cbstorage.usuario.pk & '|' & LSDateFormat(now(),"short","Spanish (Standard)")
			& '|' & resultado.hora & '|' & rc.param & '|' & rc.filtros;
			resultado.qr = encrypt(cadena, "IdfO4shkTj9fOYo0HXulCQ==", "AES", "Base64");
	    	barcodeFormat		= CreateObject("java","com.google.zxing.BarcodeFormat");
		    qrCodeWriter 		= CreateObject("java","com.google.zxing.qrcode.QRCodeWriter").init();
		    matrixToImageWriter = CreateObject("java","com.google.zxing.client.j2se.MatrixToImageWriter");
		    qrCode	 			= qrCodeWriter.encode(resultado.qr, barcodeFormat.QR_CODE, 800, 800);
		    request.qr		= ImageNew(matrixToImageWriter.toBufferedImage(qrCode));
		</cfscript>
	</cffunction>
	<!--- 
	* Fecha creacion: 21 de febrero de 2017
    * @author Alejandro Rosales
    --->	
    <cffunction name="getTipoDato" access="remote" hint="Obtiene el tipo de dato de la base de datos">
    	<cfargument name="hecho" type="any" required="yes" hint="hecho_columna">
    	<cfargument name="pkConjunto" type="numeric" required="yes" hint="Pk del conjunto de datos">
    	<cfscript>
    		var ejeY = getNombre(hecho, Session.cbstorage.conjunto.ID);
			
    		var daoConsulta = createObject('component','DAO_ConsultaVistaMat');
			var respuesta = daoConsulta.getTipoDato(pkConjunto,ejeY.N);
			return respuesta;
    	</cfscript> 
    	
    </cffunction>

   <!---
 	* Fecha creacion: 4 de abril de 2017
 	* @author Jonathan Martinez
    ---> 
   <cffunction name="getColumnas" access="remote" hint="Obtiene todas las columnas relaciondas con un conjunto de datos">
     	<cfargument name="pkConjunto" type="numeric" required="yes" hint="Pk del conjunto">
<cfscript>
dao = CreateObject('component', 'DAO_ConsultaVistaMat');	
return dao.getColumnas(pkConjunto);
</cfscript>
   </cffunction>
    
    
</cfcomponent>