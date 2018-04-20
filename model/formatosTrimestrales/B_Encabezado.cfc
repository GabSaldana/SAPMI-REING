<cfcomponent accessors="true"  >
	<cfproperty name="columnas" type="array">
	<cfproperty name="niveles">
	
	<cffunction name="init">
		<cfscript>
			celdas=[];
			return this;
		</cfscript>
	</cffunction>	

	<cffunction name="getListaNombresEncabezado" hint=" ">
		<cfscript>
			var listaJson = '';
			var cont = 0;
			for (var columna in this.getcolumnas()){
				if(columna.getNivel() eq this.getNiveles()){
					if (cont eq 0){
						listaJson= listaJson&'"' &JSStringFormat(columna.getNOM_COLUMNA())&'"';
					} else{
						listaJson= listaJson &','&'"'& JSStringFormat(columna.getNOM_COLUMNA())&'"';
					}
					cont++;
				}
			}
			return listaJson;
		</cfscript>
	</cffunction>
	
	<cffunction name="getJSONSumables" hint=" ">
		<cfscript>
			var listaJson = '[';
			
			for (var columna in this.getcolumnas()){
				if(columna.getTIPO_DATO() eq 5){
					//listaJson = listaJson&'{destino:'&columna.getOrden()&', origen:[';
					listaJson = listaJson&'{destino:'&columna.getpk_columna()&', origen:[';
					var suman = columna.getsumandos();
					var cont = 0;
			
					for(elem in suman ){
						if (cont eq 0){							
								listaJson= listaJson & elem;
						} else {							
								listaJson= listaJson &','& elem;	
						}
						cont++;
					}
					listaJson = listaJson & '], operandos:[';
					var oper = columna.getoperandos();
					var cont = 0;
			
					for(elem in oper ){
						if (cont eq 0){							
								listaJson= listaJson & elem;
						} else {							
								listaJson= listaJson &','& elem;	
						}
						cont++;
					}
					listaJson = listaJson & ']},';
				}
				
			}
			listaJson = listaJson &']';
			return listaJson;
		</cfscript>
	</cffunction>
	
	<cffunction name="getColumnaByPK" hint=" ">
		<cfargument name="pkColumna">
		<cfscript>
			for (var columna in this.getcolumnas()){
				if (columna.getpk_columna() eq pkColumna){
					return columna;
				}
			}
		</cfscript>
	</cffunction>
	
	<cffunction name="getColumnasUltimoNivel" hint=" ">
		<cfscript>
			var columnasUltimoNivel = [];
			for (var columna in this.getcolumnas()){
				if (columna.getNivel() eq this.getNiveles()){
					arrayAppend(columnasUltimoNivel,columna);
				}
			}
			return  columnasUltimoNivel;
		</cfscript>
	</cffunction>
	
	<cffunction name="calculaHijos" hint=" ">
		<cfscript>
			var columnasUltimoNivel = [];
			var numhijos = '0';
			if(this.getniveles() gt 1){
				for (var columna in this.getcolumnas()){
					this.sumarhijosUlimoNivel(columna);
					
				}
			}
		</cfscript>
	</cffunction>
	
	<cffunction name="sumarhijosUlimoNivel" hint="Funcion recursiva para obtener el total de hijos de ultimo nivel que tiene una columna">
		<cfargument name="columnaPadre">
		<cfscript>
			var pkColumna = columnaPadre.getpk_columna();
			var sumaHijos = 0;
			for (var hijos in this.getcolumnas()){
				
				if (pkColumna eq hijos.getpk_Padre()){
					/*si es de ultimo nivel suma a los hijos si no vuelve a llamar para obtener el total de hijos*/
					if(hijos.getNivel() eq this.getniveles()){
						sumaHijos ++;
					} else {
						sumaHijos = sumaHijos + sumarhijosUlimoNivel(hijos);
					}
					/*establece al hijo de niovel maximo para cada columna*/
					if( columnaPadre.getHijosDeNivel() lt hijos.getNivel() ){
						columnaPadre.setHijosDeNivel(hijos.getNivel());
					}
				}
				
			}
			columnaPadre.setTotalHijosUltimoNivel(sumaHijos);
			return sumaHijos;
		</cfscript>
	</cffunction>
	
	<cffunction name="getMergeJSON" hint="Obtiene el JSON con la definicion del merge del encabezado">
		<cfscript>
			var listaJson = '[';
			if(this.getniveles() gt 1){
				for (i = 0; i lt this.getniveles(); i++){
					var posCol = 0;
					for (var columna in this.getcolumnas()){
						if(columna.getNivel()-1 eq i){
							if(columna.getTotalHijosUltimoNivel() gt 1){
								listaJson = listaJson & '{';
								listaJson = listaJson & '"row":'& i;
								listaJson = listaJson & ',"col":'&	posCol;
								listaJson = listaJson & ',"rowspan":'&(columna.getHijosDeNivel()-columna.getNivel());
								listaJson = listaJson & ',"colspan":'&columna.getTotalHijosUltimoNivel();
								listaJson = listaJson & '},';
							}
							posCol = posCol +  columna.getTotalHijosUltimoNivel();
						}
					}
				}
			}
			listaJson = listaJson &']';
			return listaJson;
		</cfscript>
	</cffunction>
	
	<cffunction name="getJSONPkUltimoNivel" hint=" obtiene un json con los pks de los hijos de ultimo nivel para concatenarlo con la informacion">
		<cfscript>
			var columnasUltimoNivel = [];
			var numhijos = '0';
			var ListaJson = '';
			
				for (i = 1; i lte this.getniveles(); i++){
					ListaJson = ListaJson & '{PK_FILA:"encabezado",'; 
					for (var columna in this.getcolumnas()){
						if(columna.getNivel() eq i){
							ListaJson = ListaJson & this.getAllHijos(columna,i,columna.getNOM_COLUMNA());
						}					
					}
					ListaJson = ListaJson & '},';
				}
			return ListaJson &'' ;
		</cfscript>
	</cffunction>
	
	<cffunction name="getAllHijos" hint="Funcion recursiva para obtener el total de hijos de ultimo nivel que tiene una columna">
		<cfargument name="columnaPadre">
		<cfargument name="nivel">
		<cfargument name="nombrePadre">
		<cfscript>
			var pkColumna = columnaPadre.getpk_columna();
			var ListaJson2 = '';
			var llenado = false;
			if(nivel eq this.getniveles()){
				ListaJson2 = ListaJson2 & columnaPadre.getpk_columna() & ':"' & JSStringFormat(nombrePadre)&'",';
			} else{
				for (var hijos in this.getcolumnas()){
					if (pkColumna eq hijos.getpk_Padre()){
						/*si es de ultimo nivel suma a los hijos si no vuelve a llamar para obtener el total de hijos*/
						if(hijos.getNivel() eq this.getniveles()){
							if(not llenado){
								ListaJson2 = ListaJson2 & hijos.getpk_columna() & ':"' & JSStringFormat(nombrePadre)&'",';
								llenado = true;
							} else {
								ListaJson2 = ListaJson2 & hijos.getpk_columna() & ':"0",';
							}
						} else {
							ListaJson2 = ListaJson2 & getAllHijos(hijos,nivel,nombrePadre);
						}
					}
				}
			}
			return ListaJson2;
		</cfscript>
	</cffunction>

	<cffunction name="compararFormato" hint="">
		<cfargument name="encabezadoAsociado" hint="Formato asociado">
		<cfargument name="pkFmtAsoc" hint="Pk del formato asociado">
		<cfscript>
			var arrayColumnasAsociadas = [];
			for (var i = this.getniveles(); i gte 1 ; i = i-1){
			var posicionEnFila = 1;
 				for (var columna in this.getcolumnas()){
					if( columna.getNivel() eq i ){
						arrayAppend(arrayColumnasAsociadas ,this.compararColumnas(columna, this.getniveles()-i, posicionEnFila, encabezadoAsociado, pkFmtAsoc));
						posicionEnFila ++;
					}
				}
			}

			return arrayColumnasAsociadas;
		</cfscript>
	</cffunction>
	

	<cffunction name="compararColumnas" hint=" ">
		<cfargument name="columnaPadre">
		<cfargument name="filaPadre">
		<cfargument name="posicionEnFilaPadre">
		<cfargument name="encabezadoAsociado" hint="Formato asociado">
		<cfargument name="pkFmtAsoc" hint="Pk del formato asociado">
		<cfscript>
			var coincidencias = [];  
			var match = structNew();
			var nivelesContenedor = this.getNiveles();

			for (var i = encabezadoAsociado.getEncabezado().getniveles(); i gte 1 ; i = i-1){
				var posicionEnFilaHijo = 1;
				
				match.padre = -1;
				match.hijo = -1;
				match.pkAsociado = pkFmtAsoc;
				match.porcentaje = 0;
						
				for (var columnaHijo in encabezadoAsociado.getEncabezado().getcolumnas()){

					if (encabezadoAsociado.getEncabezado().getniveles()-columnaHijo.getNivel() eq  filaPadre){

						if (posicionEnFilaPadre eq posicionEnFilaHijo){							

							if (columnaPadre.getNIVEL() EQ columnaHijo.getnivel()){						
								if (columnaPadre.getNOM_COLUMNA() EQ columnaHijo.getNOM_COLUMNA()){
									if (columnaPadre.gettotalHijosUltimoNivel() EQ columnaHijo.gettotalHijosUltimoNivel()){	
										var nivelPadre = nivelesContenedor - columnaPadre.getNIVEL();
										var nivelHijo = (encabezadoAsociado.getEncabezado().getNiveles()) - columnaHijo.getnivel();
										if (nivelPadre EQ nivelHijo){
											match.padre = columnaPadre.getpk_columna();
											match.hijo = columnaHijo.getpk_columna();
											match.pkAsociado = pkFmtAsoc;
											match.porcentaje = 100;
										}
									}
								}
							}else{
								match.padre = columnaPadre.getpk_columna();
								match.hijo = columnaHijo.getpk_columna();
								match.pkAsociado = pkFmtAsoc;
								match.porcentaje = 0;
							}

						}

						posicionEnFilaHijo++;
					}
				}
			}

			return match;
		</cfscript>
	</cffunction>



</cfcomponent>