<link href="/includes/bootstrap/bootstrap-checkbox/bcheckbox.css" rel="stylesheet">
<!--- <script type="text/javascript">
	colores = [];
	clases = ['red','yellow','green'];
</script> --->
<style type="text/css">
	/*Propuesta de colores*/
	.red{
		background: #F7B8B8;
	}
	.yellow{
		background: #FDFEB9;
	}
	.green{
		background: #C1F1B2;	
	}
</style>
<cfset index = 1>
<cfprocessingdirective pageEncoding="utf-8">
<div class="container" style="width:100%;">
	<div class="row">
		<div class="col-md-12" id="CuentaInvestigacion" style="display: none">
			<div class="alert alert-success">
				<span class="fa fa-check"></span> Usted ha seleccionado al menos un producto para la solicitud.<br>
			</div>
		</div>
		<div class="col-md-12 noProcede " id="NoCuentaInvestigacion" style="display: none">
			<div class="alert alert-danger">
				<span class="fa fa-times"></span> Usted <strong>No</strong> ha seleccionado ningún producto para la solicitud.<br>
				Seleccione al menos una, de lo contrario <strong>No</strong> podrá participar en el programa.
			</div>
		</div>
	</div>
	<div class="row">
		<div class="input-group pull-right mail-search col-md-12">
			<input id="buscar_inv" class="form-control input-sm" name="search" placeholder="Buscar" type="text" onkeyup="busquedaInv()">
		</div>
	</div>
	
	<span style="color:red;">Todos los campos y documentos marcados con (*) son obligatorios para la evaluación</span><br>
	<span style="color:red;">Solo se muestran productos no evaluados en convocatorias anteriores</span>
	<div class="row" id="agrupaciones">
		<cfloop from="1" to="#arrayLen(prc.productos)#" index="numReporte">
			<cfset producto = prc.productos[numReporte].reporte>
			<cfset ruta =  prc.productos[numReporte].ruta>
			<cfset filas = producto.getFilas()>
			<cfset encabezado = producto.getEncabezado()>
			<cfset columnas = encabezado.getColumnas()>
			<cfset pkReporte = producto.getPkReporte()>
			<cfset pkformato = producto.getPkTFormato()>
			<cfset pkperiodo = producto.getPkPeriodo()>
			<cfset nombre = producto.getNombre()>
			
			<cfif arraylen(filas) GT 0>
				<cfloop array="#filas#" index="fila">
					<!--- Edicion de la fila ----->
					<div class="col-lg-12 investigaBusqueda" nombreClasif="<cfoutput>#ruta[1]#</cfoutput>" clasific="<cfoutput>#fila.getClASIFICACION()#</cfoutput>" clasificacion="<cfif fila.getClASIFICACION() neq ""><cfoutput>#fila.getClASIFICACION()#.</cfoutput><cfelse>0.</cfif><cfif fila.getSUBClASIFICACION() neq ""><cfoutput>#fila.getSUBClASIFICACION()#</cfoutput><cfelse>0</cfif>">
						<div class="widget-head-color-box lazur-bg p-sm datos">
							<div class="row">
							<div class="col-md-1"><cfif fila.getClASIFICACION() neq ""><cfoutput>#fila.getClASIFICACION()#.</cfoutput></cfif><cfif fila.getSUBClASIFICACION() neq ""><cfoutput>#fila.getSUBClASIFICACION()#</cfoutput></cfif></div>
							<div class=" text-center col-md-10">
								<cfloop  from="1" to="#arraylen(ruta)#" index="rprod">
									<b><cfif rprod neq 1>/</cfif><cfoutput>#ruta[rprod]# </cfoutput></b>
								</cfloop>
							</div>
							<div class="text-right col-md-1">
								<cfoutput>
										<button class="btn text-right lazur-bg edit<cfoutput>#index#</cfoutput>" onclick="editarFila(#pkformato#,#pkPeriodo#,#pkReporte#,#fila.getPK_FILA()#);"><span class="fa fa-edit fa-lg"></span></button>
								</cfoutput>
							</div>
							</div>
							
						</div>
						<cfset  color = 1>
						<div class="widget-text-box infoGeneral<cfoutput>#index#</cfoutput> datos no-margins">
							<table class="table table-hover no-margins">
	                           <thead>
									<th colspan="2"><label class="control-label">Información General</label></th>
								</thead>
								<tbody>							
									<cfloop  array="#columnas#" index="columna">
									<tr>
										<cfif  NOT (columna.getValidator() EQ "seleccionArchivo" OR  columna.getValidator() EQ "archivoRequerido")>
											<td>
												<cfif columna.getrequerido() eq 'true'><span style="color:red;">*</span> </cfif>
												<cfoutput>#columna.getNOM_COLUMNA()#</cfoutput>:
											</td>
											<td>
												<cftry>
													<cfset value = fila.getCeldabyPKColumna(columna.getpk_columna()).getvalorcelda()>
													<cfif Len(Trim(value)) EQ 0 AND columna.getrequerido() eq 'true'>
														<cfset color = 0>
													</cfif>
													<label class="control-label"><cfoutput>#value#</cfoutput></label>
													<cfcatch>
														<cfif columna.getrequerido() eq 'true'>
															<cfset color = 0>
														</cfif>
													</cfcatch>
												</cftry>
											</td>
										</cfif>
									</cfloop>
									</tr>
								</tbody>
							</table>
							<cfoutput>
								<div class="row">
								<table class="table table-hover no-margins">
                                            					<thead>
																	<th colspan="2">
																		<label class="control-label">Documentos Anexos</label>
																	</th>
																</thead>
																<tbody>
									<cfloop  array="#columnas#" index="columna">
										<tr>
										<cfif  columna.getValidator() EQ "seleccionArchivo" OR  columna.getValidator() EQ "archivoRequerido">
											<div class="col-sm-12">
												<td><cfif columna.getrequerido() eq 'true'><span style="color:red;">*</span> </cfif>
												<cfoutput>#columna.getNOM_COLUMNA()# </cfoutput>:</td>
											</div>
											<div class="col-sm-12">
												<cftry>
													
												<cfif TRIM(fila.getCeldabyPKColumna(columna.getpk_columna()).getvalorcelda()) EQ ''>
													<td><small>	Sin Archivo Adjunto</small></td>
													<cfif columna.getrequerido() eq 'true'>
														<cfset color = 0>
													</cfif>
												<cfelse>
													<td>
														<button class="btn btn-success btn-xs btn-rounded btn-outline btnFile pull-right" onclick="descargaComprobanteConsulta(#pkformato#,#fila.getPK_FILA()#,#columna.getpk_columna()#);"><small>Descargar</small> <span class="fa fa-download"></span></button>
													</td>
												</cfif>
													<cfcatch>
														Dato no disponible
														<cfif columna.getrequerido() eq 'true'>
															<cfset color = 0>
														</cfif>
													</cfcatch>
												</cftry>
											</div>
										</cfif>
										</tr>
									</cfloop>
									</tbody>
									</table>
								</div>
							</cfoutput>

							<div class="text-right checkbox checkbox-primary">
								<input id="checkInv<cfoutput>#fila.getPK_FILA()#</cfoutput>" clas="<cfoutput>#nombre#</cfoutput>" indice="<cfoutput>#index#</cfoutput>" periodo="<cfoutput>#pkPeriodo#</cfoutput>" formato="<cfoutput>#pkFormato#</cfoutput>" reporte="<cfoutput>#pkReporte#</cfoutput>" fila="<cfoutput>#fila.getPK_FILA()#</cfoutput>" cproducto="<cfoutput>#fila.getPKCPRODUCTO()#</cfoutput>" class="selectInvestigacion " type="checkbox" <cfif fila.getSELECCIONADO() EQ 1> checked estado = "1" color="2" <cfelse> color="<cfoutput>#color#</cfoutput>" estado = "0"</cfif> >
								<label for="checkInv<cfoutput>#fila.getPK_FILA()#</cfoutput>">
									<h5>Seleccionar</h5>
								</label>
							</div>
							<!--- <cfif fila.getSELECCIONADO() EQ 1>
								<cfset color = 2>
							</cfif> --->
						</div>
					</div>
					<cfset index = index + 1>
					<!--- <script type="text/javascript">
						valor = {
							index : <cfoutput>#index#</cfoutput>,
							color : <cfoutput>#color#</cfoutput>
						};
						colores.push(valor);
						<cfset index = index + 1>
					</script> --->
				</cfloop>
			</cfif>
		</cfloop>
	</div>
</div>

<form id="downloadComprobanteInv" action="<cfoutput>#event.buildLink('formatosTrimestrales.capturaFT.descargarComprobante')#</cfoutput>" method="get" target="_blank">
	<input type="hidden" id="pkCatFmtInv"		name="pkCatFmt">
	<input type="hidden" id="pkColDownInv"		name="pkColDown">
	<input type="hidden" id="pkFilaDownInv"		name="pkFilaDown">
</form>



<script type="text/javascript">
	clases = ['red','yellow','green'];
	<!---
    * Fecha: Febrero 2018
    * @author: Marco Torres
    * descripcion: abre la vista para editar un producto
    --->
    function editarFila (formato, periodo, reporte,pkfila) {
        $('#formularioLlenado').html('');
        /*Obtiene el estado para la edicion*/
        var estado = $("#checkInv"+pkfila).attr('estado');
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.capturaFT.productosEdicion")#</cfoutput>', {
            formato: formato,
            periodo: periodo,
            reporte: reporte,
            estado: estado
        }, function(data){
            $("#boxesContraparte").show();
            $(".divevaluacionInvr").slideToggle( 1000,'easeOutExpo');
            $('#formularioLlenado').html(data);       
            $("#pkFila").val(pkfila);
            obtenerDatosFila(pkfila);
        });
    }
    
    <!---
    * Fecha: Febrero 2018
    * @author: Marco Torres
    * descripcion: cierra la vista para editar un producto
    --->
    function cierraPanelCelda(){
        $("#boxesContraparte").slideToggle( 1000,'easeOutExpo');
        $(".divevaluacionInvr").show();
    }
    
    <!---
    * Fecha: Febrero 2018
    * @author: Marco Torres
    * descripcion: funcion que se ejecuta en la respuesta del guardado de la edicion de una fila
    --->
    function cargaTabla(){
    	$(".divevaluacionInvr").show();
    	cargaPestanaClave('Invest');
    	cargaPestanaClave('ActDocente');
    }
    <!---
    * Fecha: Marzo 2018
    * @author: Alejandro Rosales
    * descripcion: Carga de pestaña editada
    --->
    function cargaPestanaClave(clave){
    	$.ajax({
            type: "POST",
            url: "/index.cfm/EDI/solicitud/cargaValidacion"+clave,                                                                                                                                           
            }).done(function(data){
                $('#div'+clave).html(data);                                                                     
        });
    }

    

	$(document).ready(function() {
		CuentaInvestigacion();
		ordenar();
		pintaEstado();
		$('body').undelegate('.selectInvestigacion', 'click');
		$('body').on('click', '.selectInvestigacion', function(){
			indice = $(this).attr('indice');
			pkFormato = $(this).attr('formato');
			pkReporte = $(this).attr('reporte');
			pkPeriodo = $(this).attr('periodo'); 
			pkFila = $(this).attr('fila');
			pkEstado = $(this).is(":checked")? 2:0;
			color = $(this).attr('color');
			pkProducto = $(this).attr('cproducto');
			nombre = $(this).attr('clas');
			
			if(color == 0){
				swal({
        			title: 'Aviso',
        			text: "Este producto no se puede seleccionar, ya que falta por capturar campos requeridos. \n ¿Desea capturarlos ahora?",
        			type: "warning",
        			showCancelButton: true,
        			confirmButtonText: "Si",
        			cancelButtonText: "No",
        			closeOnConfirm: true,
        			closeOnCancel: true
      				},
      				function(isConfirm){
        				if (isConfirm) {
          					editarFila(pkFormato,pkPeriodo,pkReporte,pkFila);
        				} else {
        					
        				}
      			});
				return false;
			}
			$.post('<cfoutput>#event.buildLink("EDI.solicitud.addEvaluacionProducto")#</cfoutput>', {
				pkFila: pkFila,
				pkProducto: pkProducto,
				pkEstado:pkEstado
			}, function(data){
				if(data > 0){
					toastr.success('Se ha actualizado la información');
					/*Transicion de color*/
					if(color == 2){
						$('.infoGeneral'+indice).removeClass(clases[2]).addClass(clases[1]);

						$('#checkInv'+pkFila).attr('color','1');
						$('.contProductos').text(Number($('.contProductos').text()) - 1);
						 if(nombre == 'DOCENCIA'){
						 	$('#checkAcadem'+pkFila).attr( "color", '1');
						 	
						 	$('#checkAcadem'+pkFila).prop( "checked", false );
						 	indiceDoc = $('.selectAcadem[fila="'+pkFila+'"]').attr('indice');
						 	$('.infoGeneralDocencia'+indiceDoc).removeClass(clases[2]).addClass(clases[1]);
						 	//infoGeneralDocencia
						 }
						
					}else{
						$('.infoGeneral'+indice).removeClass(clases[1]).addClass(clases[2]);
						//colores[indice-1].color = 2;
						$('#checkInv'+pkFila).attr('color','2');
						 $('.contProductos').text(Number($('.contProductos').text()) + 1);
						 if(nombre == 'DOCENCIA'){
						 	$('#checkAcadem'+pkFila).prop( "checked", true );
						 	$('#checkAcadem'+pkFila).prop( "color", '2'); 	
						 	indiceDoc = $('.selectAcadem[fila="'+pkFila+'"]').attr('indice');
						 	$('.infoGeneralDocencia'+indiceDoc).removeClass(clases[1]).addClass(clases[2]);
							
						 }
					}
				}
				else{
					toastr.error('Error en el servidor, intente más tarde');
					return false;
				}

			});
			CuentaInvestigacion();
		});
	});

	function pintaEstado(){
		var seleccionados = 0;
		$('.selectInvestigacion').each(function(){
			if($(this).attr('color') == '2'){
				seleccionados = seleccionados + 1;
			}
			$('.infoGeneral'+$(this).attr('indice')).addClass(clases[$(this).attr('color')]);
		});
		$('.contProductos').text(seleccionados);
	}
	
	function ordenar(){
	    var numericallyOrderedDivs = $(".investigaBusqueda").sort(function (a, b) {
	        return parseFloat($(a).attr('clasificacion')) - parseFloat($(b).attr('clasificacion'));	        
	    });
	    $("#agrupaciones").html(numericallyOrderedDivs);

	    var tab_attribs = [];
		$('.investigaBusqueda').each(function () {
		  tab_attribs.push( $(this).attr("clasific") );
		  

		});
		uniqueArray = tab_attribs.filter(function(item, pos) {
		    return tab_attribs.indexOf(item) == pos;
		});
		$('#agrupaciones').append('<ul class="sortable-list connectList agile-list ui-sortable" id="agrupaciones2"></ul>')

		for(i= 0; i<=uniqueArray.length; i++){
			$('#agrupaciones2').append('<li class="clasific'+uniqueArray[i]+'"></li>')
			$('.clasific'+uniqueArray[i]).append('<div class="col-sm-12 encabezado" id="Eclasific'+uniqueArray[i]+'"><div class="row"><button class="btn btn-default fa fa-minus minimizar" clasific="'+uniqueArray[i]+'" data-abierto="1"></button><center>  <h4 id="h4'+uniqueArray[i]+'">clasificacion: '+uniqueArray[i]+'</h4></center>.</div></div><div class="col-sm-12 contenido" id="Cclasific'+uniqueArray[i]+'"><br></div>');
			$('.investigaBusqueda').each(function () {
				$('#Cclasific'+uniqueArray[i]).append($(this).attr("clasific") == uniqueArray[i] ? $(this) : '');
				
			});
			$('.clasific'+uniqueArray[i]).append('.');
			$('#h4'+uniqueArray[i]).text(uniqueArray[i]+ ". " + $('#Cclasific'+uniqueArray[i]+' .investigaBusqueda').first().attr('nombreClasif'));
		}
		$('.clasificundefined').remove();
	}

	$('body').undelegate('.minimizar', 'click');
	$('body').on('click', '.minimizar', function(){
		if($(this).data('abierto') == 1){
			$("#Cclasific"+$(this).attr('clasific')).hide();
			$(this).data('abierto', 0).addClass('fa-plus').removeClass('fa-minus');
		}else{
			$("#Cclasific"+$(this).attr('clasific')).show();
			$(this).data('abierto', 1).addClass('fa-minus').removeClass('fa-plus');
		}

	});

	function CuentaInvestigacion(){
		if( $('.selectInvestigacion:checked').length == 0){
			$('#NoCuentaInvestigacion').show();
			$('#CuentaInvestigacion').hide();
		} else{
			$('#NoCuentaInvestigacion').hide();
			$('#CuentaInvestigacion').show();
		}
	}
	


	function descargaComprobanteConsulta(pkformato, pkfila, pkcol){
		$("#pkColDownInv").val(pkcol);
		$("#pkFilaDownInv").val(pkfila);
		$("#pkCatFmtInv").val(pkformato);
		$('#downloadComprobanteInv').submit();
	}

	function busquedaInv(){
		var tex = $('#buscar_inv').val();
		$('.investigaBusqueda').hide();
		$('.investigaBusqueda').each(function(){
			if(tex == '')
				$('.investigaBusqueda').show();
			else if($(this).text().toUpperCase().indexOf(tex.toUpperCase()) != -1){
		    	$(this).show();
		   	}
		});
  	}

</script>