<cfcomponent accessors="true"  >
	<cfproperty name="PK_FILA">
	<cfproperty name="EVALUACION_ETAPAS">
	<cfproperty name="PKCPRODUCTO">
	<cfproperty name="EVALUACIONPRODUCTOEDI">
	<cfproperty name="PROCESO">
	<cfproperty name="SELECCIONADO">
	<cfproperty name="SELECCIONADOINC">
	<cfproperty name="CLASIFICACION">
	<cfproperty name="CLASIFICACION_ROMANO">
	<cfproperty name="SUBCLASIFICACION">
	<cfproperty name="SUBCLASIFICACION_ROMANO">
	<cfproperty name="MAX_PUNTUACION">
	<cfproperty name="MAX_PRODUCTOS">
	<cfproperty name="CESTADO_EVALUACION">
	<cfproperty name="PKTPRODUCTOEDI">
	<cfproperty name="celdas" type="array">
	<cfproperty name="anio">

	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>	
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="filaToJSON" hint=" crea el json de una fila">
		<cfargument name="secciones">
		<cfscript>
			var listaJson = '{"PK_FILA":'&this.getPK_FILA();
			for (var celda in this.getceldas()){
				listaJson= listaJson &','&celda.celdaToJSON();
			}
			return listaJson&'}';
		</cfscript>
	</cffunction>
	
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getCeldabyPKColumna" hint="obtiene una celda de la fila por el pk de la celda">
		<cfargument name="pkColumna">
		<cfscript>
			for (var celda in this.getCeldas()){
				if (celda.getPK_COLUMNA() eq pkColumna){
					return celda;
				}
			}
		</cfscript>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="sumarValoresToArray" hint="suma los valores de la fila al array que se envia">
		<cfargument name="structSumas">
		<cfscript>
			//var estructura = structSumas;
			for (celda in this.getCeldas()){				
				var valorCelda = replace(celda.getvalorcelda(),",","","all" );
				if( isNumeric(valorCelda )){
					if (structkeyexists(structSumas,celda.getPK_COLUMNA())){
						structSumas[celda.getPK_COLUMNA()] = structSumas[celda.getPK_COLUMNA()] + valorCelda;
					} else {
						structSumas[celda.getPK_COLUMNA()] = valorCelda;
					}
				}
			}
			return structSumas;
		</cfscript>
	</cffunction>

	<!---
    * Fecha : Enero 2018
    * author : Daniel Memije
	--->
	<cffunction name="extraerAnio" hint="extrae el anio de una cadena">
		<cfargument name="valor">
		<cfscript>
			valor =trim(valor);
			var anioCompleto = reFind("^\d{4}$",valor);
			var anioDosDigitos = reFind("/\d{2}$",valor);
			var anioCuatroDigitos = reFind("/\d{4}$",valor);
			var resultado = '';
			if(anioCompleto){
				resultado = valor;
			}else if(anioDosDigitos){
				var anio = Mid(valor,anioDosDigitos+1,(Len(valor)-anioDosDigitos)+1);
				resultado = "20"&anio;
			}else{
				var anio = Mid(valor,anioCuatroDigitos+1,(Len(valor)-anioCuatroDigitos)+1);
				resultado = anio;
			}
			return resultado;
		</cfscript>
	</cffunction>

	<!---
    * Fecha : Enero 2018
    * author : Daniel Memije
	--->        
	<cffunction name="initAnio" hint="Establece el valor de anio para el producto">		
		<cfscript>											
			var anioInicio = '';
			var anioFin = '';
			var anioProducto = '';
			for(celda in this.getCELDAS()){				
				var valor = celda.getVALORCELDA();				
				switch (celda.getPK_TIPOFECHA()) {
					case 1: // Fecha de Inicio						
						anioInicio = this.extraerAnio(valor);
					break;
					case 2: // Fecha de Fin								
						anioFin = this.extraerAnio(valor);																							
					break;
					case 3: // Anio						
						anioProducto = this.extraerAnio(valor);
					break;
					default:
				}								
			}	

			// Si tiene anio completo
			if(anioProducto NEQ ''){
				this.setANIO(anioProducto);				
			}
			// Si tiene anio de inicio y fin, toma el de fin
			else if(anioInicio NEQ '' AND anioFin NEQ ''){
				this.setANIO(anioFin);
			}
			// Si tiene anio de fin, pero no de inicio
			else if(anioFin NEQ ''){
				this.setANIO(anioFin);
			}
			// Si no, toma el de inicio
			else{
				this.setANIO(anioInicio);
			}

		</cfscript>
	</cffunction>
	
	<!---
    * Fecha : Febrero 2018
    * author : Marco Torres
	--->
	<cffunction name="getNombreProducto" hint="extrae el anio de una cadena">
		<cfscript>
			for (celda in this.getCeldas()){
				if(celda.getISNOMBRE() eq 1){
				
				return celda.getvalorcelda();
				}				
			}
			return '';
		</cfscript>
	</cffunction>

	<cffunction name="setEtapasEditar" hint="establece las etapas que se pueden eeditar de acuerdo al estado del aspirante">
		<cfargument name="accionesSolicitud">
		<cfscript>
			
			var primero = true;
			for (etapa in this.getEVALUACION_ETAPAS()){
				if(primero){
					if(listFind(accionesSolicitud,'solicEDI.evalSIP','$')  AND /*listFind(#etapa.getACCIONESCVE()#,'evalEDI.evalSIP','$') AND */etapa.getCVETIPO() EQ 'evalEDI.evalSIP'
						AND etapa.getFK_EVALUADOR() eq session.cbstorage.usuario.PK){
						etapa.setEditable(true);
						primero = false;
					} else if (listFind(accionesSolicitud,'solicEDI.evalCE','$') AND /*listFind(#etapa.getACCIONESCVE()#,'evalEDI.evalCE','$') AND */listFind(#etapa.getCVETIPO()#,'evalEDI.evalCE','$')
						AND etapa.getFK_EVALUADOR() eq session.cbstorage.usuario.PK){
						etapa.setEditable(true);
						primero = false;
					}else if (listFind(accionesSolicitud,'solicEDI.evalCA','$') AND /*listFind(#etapa.getACCIONESCVE()#,'evalEDI.evalCA','$') AND */listFind(#etapa.getCVETIPO()#,'evalEDI.evalCA','$')
						AND etapa.getFK_EVALUADOR() eq session.cbstorage.usuario.PK){
						etapa.setEditable(true);
						primero = false;
					}else if (listFind(accionesSolicitud,'solicEDI.evalRI','$') AND /*listFind(#etapa.getACCIONESCVE()#,'evalEDI.evalRI','$') AND */listFind(#etapa.getCVETIPO()#,'evalEDI.evalRI','$')
						AND etapa.getFK_EVALUADOR() eq session.cbstorage.usuario.PK){
						etapa.setEditable(true);
						primero = false;
					} else 
						etapa.setEditable(false);
				} else{
					etapa.setEditable(false);
				} 
			}
		</cfscript>
	</cffunction>



</cfcomponent>