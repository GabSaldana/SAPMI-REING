<!---
* =========================================================================
* IPN - CSII
* Sistema:	EVALUACION 
* Modulo:	Edicion de Plantillas para los Formatos Trimestrales  con Columna de Tipo Catalago
* Fecha:    
* Descripcion:	
* Autor: 
* =========================================================================
--->

<script language="javascript" src="/includes/js/plugins/steps/jquery.steps.min.js"></script>

<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="nuevoReporte_js.cfm">

<style>
.wizard .content {
    min-height: 100px;
}
.wizard .content > .body {
    width: 100%;
    height: auto;
    padding: 15px;
    position: relative;
	background-color:#f3f3f4;
}
</style>

<input type="hidden" id="in-formatos" name="formatos" value="0"> 	
</br>

<div class="container" >
	<div class="row">
		<div id="st-nvo-rep">
		    <h3>Información General</h3>
			<div class="ibox">
	            <div class="ibox-title">
		       	</div>
            	<div class="ibox-content">
            		<div id="divInfoGral" >
			       	</div>
				</div>
			</div>
			<h3>Estructura del Formato (Encabezado)</h3>
			<div class="ibox">
	            <div class="ibox-title">
		       	</div>
            	<div class="ibox-content">
			        <div id="tablaConfig"  >
				    </div>
				</div>
				</div>
		    <h3>Configuración de Columnas</h3>
	    	<div class="ibox">
	            <div class="ibox-title">
		       	</div>
            	<div class="ibox-content">
            		
					<div id="vistaPreviaPanel" class="panel panel-success">
			            <div class="panel-heading"  style="overflow:hidden">
			            	<strong>
			                Vista Previa
							</strong>
			                <br>Seleccione una columna para configuración (solo el último nivel del encabezado)
			            </div>
			            <div class="panel-body">
			            
			            	<div id="tabla">
							</div>
						</div>
			        </div>
			       
			       
			       <div id="cont-columna" class="" style="display:none" >
						<div id="columnaPanel" class="panel panel-warning">
				            <div class="panel-heading">
				                Administración de configuración de la columna "Seleccionada"
				           </div>
				            <div class="panel-body">
				           		<div id="confColumna">
								</div>
							</div>
				        </div>
					</div>
				</div>
			</div>
			 <h3>Configuraciónes Generales</h3>
	    	<div class="ibox">
	            <div class="ibox-title">
		       	</div>
            	<div class="ibox-content">
            		<div id="divConfigGral">
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<ul id="tlyPageGuide" data-tourtitle="Configuración de formatos">
	
	<!--- -----------------(1. Información general "Parte 1")----------- -------------------------------- --->
	<li class="tlypageguide_left" data-tourtarget=".nombreFormato">
			<div>Formato<br>
			Escriba el nombre que llevará el reporte.</div>
		</li>
	<li class="tlypageguide_left" data-tourtarget="#claveFormato">
			<div>Clave<br>
			La clave que cada formato posee.Los identificadores "SGE-EV-" serán incluidos de forma automática</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#vigenciaFormato">
			<div>Vigencia<br>
			Para asignar la fecha de vigencia del formato utilice el botón <i class="glyphicon glyphicon-calendar"></i></div>
		</li>
		<li class="tlypageguide_left" data-tourtarget=".clasificacionFormato">
			<div>Clasificación<br>
			Seleccione la clasificación de la UR a la que pertenece el reporte.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget=".areaFormato">
			<div>Información general - Area<br>
			Seleccione el área que coordinará la captura de información del formato.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget=".instruccionFormato">
			<div>Información general - Instrucciones<br>
			En este recuadro se deben incluir las instrucciones de llenado del formato, estas instrucciones estarán a disposición de los usuarios que consulten el reporte, durante las captura de información.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#guiaInsercionFilas">
			<div>Configuraciones generales - Inserción de filas<br>
			Permite configurar la inserción de filas al final del formato al momento de la captura.</div>
		</li>
		<li class="tlypageguide_right" data-tourtarget="#guiaTotalFinal">
			<div>Configuraciones generales - Inserción total final<br>
			Permite configurar la inserción de la última fila con el total final.</div>
		</li>
		
		-----------------(2. Estructura del formato (Encabezado)"Parte 2")---------------------------
		<li class="tlypageguide_top" data-tourtarget="#modFila">
			<div>Filas del encabezado<br>
			El botón <i class="fa fa-plus"></i> añade una nueva fila en la parte inferior del encabezado.<br>
			El botón <i class="fa fa-minus"></i> elimina la fila inferior del encabezado..</div>
		</li>
		<li class="tlypageguide_top" data-tourtarget="#modColumna">
			<div>Columnas del encabezado<br>
			El botón <i class="fa fa-plus"></i> añade una nueva columna en el costado derecho del encabezado.<br>
			El botón <i class="fa fa-minus"></i> elimina la columna del extremo derecho del encabezado..</div>
		</li>
		<li class="tlypageguide_top" data-tourtarget="#conbinarCelda">
			<div>Combinar celdas<br>
			El botón <i class="fa fa-exchange"></i> combinará las celdas seleccionadas.<br>
			El botón <i class="fa fa-arrows"></i> separará la celda seleccionada.</div>
		</li>	
		<li class="tlypageguide_top" data-tourtarget=".guardarDatos">
			<div>Guardar información<br>
			Al seleccionar el botón <i class="glyphicon glyphicon-floppy-disk"></i> se guardará la información capturada del encabezado del formato de reporte.</div>
		</li>

		-------------------(3. Configuración de Columnas "Parte 3")--------------------------------
		<li class="tlypageguide_left" data-tourtarget="#vistaPreviaPanel">
			<div>Vista previa<br>
			Vista previa del formato de reporte, para acceder a la configuración de la columna seleccione la celda color azul del encabezado.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#guiaColumna">
			<div>Configuración de la columna - Nombre<br>
			Título de la celda inferior del encabezado.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#guiaTipo">
			<div>Configuración de la columna - Tipo de dato<br>
			Seleccione un tipo de dato para la columna, durante el proceso de captura, las celdas de la columna aceptarán el tipo de datos seleccionado.</div>
		</li>
		<li class="tlypageguide_top" data-tourtarget="#verSumandos">
			<div>Guardar información<br>
			Al seleccionar el botón <i class=" fa fa-plus"></i> se desplegará una ventana para seleccionar las columnas de las que procede la suma para obtener el “Total”.</div>
		</li>
		<li class="tlypageguide_top" data-tourtarget="#catalogo">
			<div>Guardar información<br>
			Al seleccionar el botón <i class="fa fa-search"></i>se desplegará una ventana para seleccionar el catálogo de datos que se desea integrar en la columna.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#guiaAyuda">
			<div>Configuración de la columna - Ayuda<br>
			En este recuadro es posible incluir instrucciones de llenado de la columna, así como cualquier descripción que facilita su llenado, este texto de ayuda será incluido en los datos del formato de reporte de forma que los usuarios que intervengan en él puedan visualizarlo. </div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#guiaBloquearCaptura">
			<div>Configuración de la columna - Bloquear para captura<br>
			Al activar esta opción, la columna seleccionada no permitirá ingresar ningún dato.Esta función es especialmente útil para crear formatos con un tamaño de datos definido y no permitir que se modifique el número de registros de un reporte.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#guiaReferencia">
			<div>Configuración de la columna - Columna referencia<br>
			Al activar esta opción se estará señalando que la columna será sustituida en el reporte acumulado.</div>
		</li>		
		<li class="tlypageguide_left" data-tourtarget="#guiaCalcularTotales">
			<div>Configuración de la columna - Calcular Subtotales<br>
			Al activar esta opción la columna seleccionada será asignada como una columna subtotal que de acuerdo a la agrupación de sus valores presentará una sumatoria de subtotales en el reporte, esta característica es única por lo que sólo puede asignarse una columna de tipo subtotal en el reporte.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#guiaTotal">
			<div>Configuración de la columna -Asignar columna Total final<br>
			Al activar esta opción la columna seleccionada contendrá la sumatoria de todas las columnas de tipo total dentro del reporte, de forma que en cada celda de la columna se encuentre un total de totales del reporte. </div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#guiaMostrarSuma">
			<div>Configuración de la columna - Suma por secciones<br>
			Al seleccionar esta opción se abrirá una ventana para seleccionar la dupla de plantillas asociadas a la columna.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#guiaCopiarColumna">
			<div>Configuración de la columna - Copiar columna<br>
			Al activar esta opción la información que contiene la columna se mantendrá para cada formato de cada trimestre.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#guiaPreviosTrimestres">
			<div>Configuración de la columna - Seleccionar columna Origen<br>
			Al seleccionar esta opción se abrirá una ventana para seleccionar la columna copiable del trimestre previo del cual se transferirá la información a la columna.</div>
		</li>

		-------------------(4. Configuraciones Generales "Parte 4")--------------------------------
		<li class="tlypageguide_right" data-tourtarget="#guiaInsercionFilas">
			<div>Configuraciones generales - Inserción de filas<br>
			Al activar esta opción se bloqueará la posibilidad de agregar más filas al reporte durante el proceso de captura, respetando el número actual de filas al momento de activar la opción.</div>
		</li>
		<li class="tlypageguide_right" data-tourtarget="#guiaTotalFinal">
			<div>Configuraciones generales - Inserción de fila total final<br>
			Al activar la opción se añadirá al final del formato de reporte una fila con los totales cuya sumatoria sea el total del contenido de las columnas de tipo numérico que integran el formato de reporte.</div>
		</li>
		<li class="tlypageguide_right" data-tourtarget="#guiaAcumulado">
			<div>Configuraciones generales - Generar reporte acumulado<br>
			Al activar esta opción el formato de reporte será incluido en la generación de reportes acumulados.</div>
		</li>
		
</ul>
