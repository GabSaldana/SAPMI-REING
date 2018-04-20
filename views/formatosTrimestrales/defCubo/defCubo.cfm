<cfprocessingdirective pageEncoding="utf-8">
<link rel="stylesheet" type="text/css" href="/views/formatosTrimestrales/formatosTrimestrales.css"/>
<cfinclude template="defCubo_js.cfm">

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Clasificación de formatos y definición del cubo</h2>
        <ol class="breadcrumb">
            <cfoutput>
                <li>
                    <a href="#event.buildLink('inicio')#">Inicio</a>
                </li>
                <li class="active">
                    <strong>Clasificación de formatos</strong>
                </li>
            </cfoutput>
        </ol>
    </div>
</div>


<div id="box-general" class="wrapper wrapper-content animated fadeIn">
    <div class="ibox float-e-margins">
        <div class="ibox-title">
            <h5>Clasificación de formatos</h5>
        </div>
        <input type="hidden" id="pkFormato">
        <input type="hidden" id="pkCubo">
        <div class="ibox-content">
            <div class="lft-btn text-left">
                <button type="button" class="btn btn-primary btn-outline dim" onclick="agregaClasificacion();"><span class="fa fa-plus"></span> AGREGAR CLASIFICACIÓN</button>
            </div>
            <br><br>
            <div id="tablaFormatos"></div>
        </div>
    </div>
</div>


<div id="bx-addClasificacion" class="wrapper wrapper-content animated fadeIn">
    <div class="ibox float-e-margins">
        <div class="ibox-title">
            <h5>Agregar clasificación</h5>
            <i id="btn-cerrarTablaFormato" class="btn btn-sm pull-right" onclick="muestraFotmatos();" title="Cerrar"><i class="fa fa-times"></i></i>
            <br>
        </div>
        <div class="ibox-content">
            <label class="control-label">Formato</label>
            <div class="input-group">
                <span class="input-group-addon">
                    <span class="fa fa-tag"></span>
                </span>
                <select id="fmtClasif" class="form-control">     
                    <option value="0" selected="selected">Seleccione un formato</option>
                    <cfset total_records = prc.formato.recordcount/>
                    <cfloop index="x" from="1" to="#total_records#">
                        <cfoutput><option value="#prc.formato.PK[x]#" >#prc.formato.NOMBRE[x]#</option></cfoutput>
                    </cfloop>
                </select>
            </div>
            <br>
            <label class="control-label">Cubo</label>
            <div class="input-group">
                <span class="input-group-addon">
                    <span class="fa fa-tag"></span>
                </span>
                <select id="cubeClasif" class="form-control">     
                    <option value="0" selected="selected">Seleccione un cubo</option>
                    <cfset total_records = prc.cubos.recordcount/>
                    <cfloop index="x" from="1" to="#total_records#">
                        <cfoutput><option value="#prc.cubos.PKCUBO[x]#" >#prc.cubos.NOMBRECUBO[x]# - #prc.cubos.PREFCUBO[x]#</option></cfoutput>
                    </cfloop>
                </select>
            </div>
            <br><br>
            <div align="center">
                <button type="button" class="btn btn-primary btn-outline dim" data-toggle="modal" href="#AddCubeClasif"><span class="fa fa-plus"></span> Agregar cubo</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <button type="button" class="btn btn-primary btn-outline dim" onclick="addClasif();"><span class="fa fa-plus"></span> Agregar clasificación</button>
            </div>
        </div>
    </div>
</div>


<div id="box-formatosRegistrados">
    <input type="hidden" id="pksColumnas">
    <input type="hidden" id="columnaActualizar">
    <div id="definicion"> </div>

    <div class="panel panel-primary">
        <div class="panel-heading">Encabezado del formato: <strong></strong>
			<i class="btn btn-primary btn-xs pull-right AnalisisA" onclick="AnalisisAutomatico();" title="Análisis automático" style="font-size: 20px;"><i class="fa fa-file-text-o"></i></i>		<!--- A.B.J.M. Botón para el analisis automatico --->
			<br><br>
		</div>
        <div class="panel-body">
            <div id="encabezado"> </div>
        </div>
    </div>

    <div id="box-clasificacion">
        <div id="clasificaciones"> </div>
    </div>
</div>


<div id="box-vista-cubo">
    <div class="ibox float-e-margins">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <strong>Construcción del cubo</strong>
                <!--- <i class="btn btn-primary btn-xs pull-right replica" onclick="replicaClasificacion();" title="Replicar clasificacion" style="font-size: 20px;"><i class="fa fa-copy"></i></i> --->
                <i class="btn btn-primary btn-xs pull-right creaVista" onclick="replicaClasificacion();" title="Replicar clasificacion y generar vista" style="font-size: 20px;"><i class="fa fa-cube"></i></i>
                <i class="btn btn-primary btn-xs pull-right preview" onclick="getPreview();" title="Vista previa" style="font-size: 20px;"><i class="fa fa-search"></i></i>
                <br><br>
            </div>
            <div class="ibox-content">
                <div id="constCubo"> </div>
            </div>
        </div>
    </div>
    <br><br><br><br><br>
</div>


<div class="modal animated fadeIn" id="mdl-Add-cubo" tabindex="-1" role="dialog" aria-hidden="true" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Nuevo cubo</h4>
            </div>
            <div class="modal-body">
                <div>
                    <label class="control-label">Nombre del cubo</label>
                    <div class="input-group">   
                        <span class="input-group-addon">
                            <span class="fa fa-tag"></span>
                        </span>
                        <input type="text" id="nombreCubo" class="form-control" placeholder="Ingresar nombre del cubo" />
                    </div>
                    <br>               
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cerrar</button>
                <button class="btn btn-success btn-lg pull-right" onclick="guardaCubo();"><span class="fa fa-check"></span> Guardar</button>
            </div>
        </div>
    </div>
</div>


<div class="modal animated fadeIn" id="AddCubeClasif" tabindex="-1" role="dialog" aria-hidden="true" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Nuevo cubo</h4>
            </div>
            <div class="modal-body">
                <div>
                    <label class="control-label">Nombre del cubo</label>
                    <div class="input-group">   
                        <span class="input-group-addon">
                            <span class="fa fa-tag"></span>
                        </span>
                        <input  id="nameCube" class="form-control" placeholder="Ingresar nombre del cubo" onkeyup="this.value=this.value.replace(' ', '_')" maxlength="27"/>
				 </div>                   
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cerrar</button>
                <button class="btn btn-success btn-lg pull-right" onclick="saveCube();"><span class="fa fa-check"></span> Guardar</button>
            </div>
        </div>
    </div>
</div>


<div class="modal animated fadeIn" id="mdl-cubos-reg" tabindex="-1" role="dialog" aria-hidden="true" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Cubos registrados</h4>
            </div>
            <div class="modal-body"> </div>
        </div>
    </div>
</div>


<div class="modal animated fadeIn" id="mdl-Add-Clasificacion" tabindex="-1" role="dialog" aria-hidden="true" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Nueva clasificación</h4>
            </div>
            <div class="modal-body">
                <label class="control-label">Formato</label>
                <div class="input-group">
                    <span class="input-group-addon">
                        <span class="fa fa-tag"></span>
                    </span>
                    <select id="inDimension" class="form-control">     
                        <option value="0" selected="selected">Seleccione un formato</option>
                        <cfset total_records = prc.formato.recordcount/>
                        <cfloop index="x" from="1" to="#total_records#">
                            <cfoutput><option value="#prc.formato.PK[x]#" >#prc.formato.NOMBRE[x]#</option></cfoutput>
                        </cfloop>
                    </select>
                </div>
                <br>
                <label class="control-label">Cubo</label>
                <div class="input-group">
                    <span class="input-group-addon">
                        <span class="fa fa-tag"></span>
                    </span>
                    <select id="inDimension" class="form-control">     
                        <option value="0" selected="selected">Seleccione un cubo</option>
                        <cfset total_records = prc.cubos.recordcount/>
                        <cfloop index="x" from="1" to="#total_records#">
                            <cfoutput><option value="#prc.cubos.PKCUBO[x]#" >#prc.cubos.NOMBRECUBO[x]# - #prc.cubos.PREFCUBO[x]#</option></cfoutput>
                        </cfloop>
                    </select>
                    <span class="input-group-addon">
                        <a data-toggle="modal" href="#mdl-Add-cubo"><span class="fa fa-plus"></span></a>
                    </span>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cerrar</button>
                <button class="btn btn-success btn-lg pull-right" onclick="guardaClasificacion();"><span class="fa fa-check"></span> Guardar</button>
            </div>
        </div>
    </div>
</div>


<ul id="tlyPageGuide" data-tourtitle="Clasificacion de encabezado">

    <!-- Botón para validar cubo -->
    <li class="tlypageguide_left" data-tourtarget=".valid">
        Botón que indica que el cubo ha sido validado.
    </li>
    <li class="tlypageguide_left" data-tourtarget=".unValid">
        Botón que permite validar el cubo.
    </li>


    <!-- Contenedor de la definicion del cubo -->
    <li class="tlypageguide_top" data-tourtarget="#addDimensiones .panel">
        Las dimensiones son aquellos datos que nos permiten filtrar, agrupar o seccionar la información (ejemplos de dimension: sexo, nivel educativo, tipo de personal, etc.)
        En esta sección se muestran las dimensiones asociadas al cubo, y además podrá asociar y agregar dimensiones al cubo.
    </li>
	<li class="tlypageguide_left" data-tourtarget=".delDim">
        Con este botón podrá eliminar una dimensión del cubo.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#asociaDimen">
        De clic aqui para asociar al cubo una dimensión previamente creada.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#agregaDimen">
        De clic  para crear una dimensión, la dimensión creada se asocia automaticamente al cubo actual.<br>
		<strong>Las dimensiones son elementos que pueden pertenecer a varios cubos, por favor verifique que la dimension no halla sido creada previamente</strong>
    </li>
    <li class="tlypageguide_top" data-tourtarget="#addColumns .panel">
        En esta sección podrá agregar una columna a una dimensión seleccionada.
    </li>
    <li class="tlypageguide_left" data-tourtarget=".delCol">
        Con este botón podrá eliminar una columna de la dimensión seleccionada.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#agregaColna">
        Botón que agrega una columna a la dimensión seleccionada.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#addHechos .panel">
        Las métricas son las variables que se pretenden medir en  el reporte (numero de becas, monto de becas, numero de programas académicos, etc.)
		<br>En esta sección podrá agregar metricas al cubo.
    </li>
    <li class="tlypageguide_left" data-tourtarget=".delHec">
        Con este botón podrá eliminar una métrica del cubo.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#agregaHecho">
        Botón que agrega una métrica, y automaticamente la asocia al cubo actual.
    </li>


    <!-- Contenedor del encabezado -->
	<li class="tlypageguide_left" data-tourtarget=".AnalisisA">
        Botón que realiza un análisis automático de la clasificación del encabezado.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#encabezado">
        <strong>Las columnas seleccionadas se muestran en color VERDE, las columnas deseleccionadas se muestran en color AZUL, y las columnas analizadas se muestran en color AMARILLO.</strong>
        <br>
        <ul type="square">
            <li>
                De un click sobre la columna que quiera seleccionar para poder asociarla, ya sea con una métrica o una dimension (revise la sección Clasificación de columnas).
            </li>
            <li>
                Deseleccione las columnas que no quiera asociar dando un click sobre ella.
            </li>
        </ul>
    </li>
	<li class="tlypageguide_left" data-tourtarget="#deseleccionar">
        Botón que deselecciona dos o más columnas seleccionadas.
    </li>
	
	<!-- Contenedor de las indicaciones -->
	<li class="tlypageguide_top" data-tourtarget=".pan-indicaciones">
        Contenedor que informa la clasificación de los colores de los paneles.
    </li>
	
    <!-- Contenedor de las dimensiones -->
    <li class="tlypageguide_top" data-tourtarget=".cont-dimensiones">
        En esta sección podrá realizar la clasificación de las columnas en sus respectivas dimensiones.
		<br>
		Las dimesiones pueden estar en dos formas 
		<ul>
			<li>
			Desagregada en el encabezado (elementos de una dimensión): 
				<ul>
				<li>
					Comúnmente serán las celdas  de ultimo nivel del encabezado clasificadas también como métricas 
				</li>
				<li>
					Las celdas de encabezado ubicadas en las filas superiores
				</li>
				<li>
					Varias columnas pueden pertenecer a una misma dimensión
				</li>
				</ul>
			</li>
			<li>
			Explicita en el reporte (Atributos de una dimensión): 
				<ul>
					<li>
						Normalmente son las columnas de  tipo catalogo y las de tipo texto, donde el titulo de la columna es el nombre de la dimensión y los elementos del reporte son los elementos de la dimensión 
					</li>
					<li>
						Solo una columna puede formar parte de una dimensión 
					</li>
				</ul>
			</li>
		</ul>
    </li>
    <li class="tlypageguide_top" data-tourtarget="#inDimension">
        Nombre de la dimensión.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#inColDim">
        Atributo asociado a la dimensión.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#inClasificacion">
        Clasificación de los elementos asociados a la dimensión.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#asociaDimension">
        Botón que ejecuta la asociación entre las columnas seleccionadas y la dimensión.
    </li>


    <!-- Contenedor de los hecho -->
    <li class="tlypageguide_top" data-tourtarget=".cnt-hechos">
        En esta sección podrá elegir una métrica para asociar con una columna.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#inHecho">
        Nombre de la métrica.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#asociaHecho">
        Botón que ejecuta la asociación entre las columnas seleccionadas y la métrica.
    </li>


    <!-- Contenedor de los hecho -->
    <li class="tlypageguide_top" data-tourtarget=".cont-agregaciones">
        En esta seccion se encuentra el listado de las dimensiones y de las métricas disponibles, además podra agregar nuevos elementos respectivamente.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#inDimensionAdd">
        Nombre de las dimensíones disponibles.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#addDim">
        Con este botón puede agregar nuevas dimensiones.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#inColDimAdd">
        Columnas asociadas a la dimensión seleccionada.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#addCol">
        Con este botón puede agregar nuevas columnas, que estaran asociadas a la dimensión seleccionada.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#inHechoAdd">
        Nombre de las métricas disponibles en este cubo unicamente.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#addHec">
        Con este botón puede agregar nuevas métricas, que estaran disponibles solamente en este cubo.
    </li>


    <!-- Contenedor de la actualizacion de dimensiones -->
    <li class="tlypageguide_top" data-tourtarget=".cont-actualizar">
        En esta sección podrá actualizar la asociación entre la última columna seleccionada y una dimensión.
		<br>
		Las dimesiones pueden estar en dos formas 
		<ul>
			<li>
			Desagregada en el encabezado (elementos de una dimensión): 
				<ul>
				<li>
					Comúnmente serán las celdas  de ultimo nivel del encabezado clasificadas también como métricas 
				</li>
				<li>
					Las celdas de encabezado ubicadas en las filas superiores
				</li>
				<li>
					Varias columnas pueden pertenecer a una misma dimensión
				</li>
				</ul>
			</li>
			<li>
			Explicita en el reporte (Atributos de una dimensión): 
				<ul>
					<li>
						Normalmente son las columnas de  tipo catalogo y las de tipo texto, donde el titulo de la columna es el nombre de la dimensión y los elementos del reporte son los elementos de la dimensión 
					</li>
					<li>
						Solo una columna puede formar parte de una dimensión 
					</li>
				</ul>
			</li>
		</ul>

		
    </li>
	<li class="tlypageguide_top" data-tourtarget="#inDimensionUpdate">
        Nombre de la dimensión.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#inColDimUpdate">
       Atributo asociado a la dimensión.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#inClasificacionUpdate">
        Clasificación de los elementos asociados a la dimensión.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#actualizaDimen">
        Botón que actualiza la asociación entre la última columna seleccionada y la dimensión.
    </li>
	 <li class="tlypageguide_top" data-tourtarget="#desasociarDimen">
        Botón que desasocia la última columna seleccionada y la dimensión.
    </li>


    <!-- Contenedor de la actualizacion del hecho -->
    <li class="tlypageguide_top" data-tourtarget=".cont-actHecho">
        En esta sección podrá actualizar la asociación correspondiente entre la última columna seleccionada y una métrica.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#inHechoUpdate">
        Nombre de la métrica.
    </li>
    <li class="tlypageguide_top" data-tourtarget="#actualizaHecho">
        Botón que actualiza la asociación entre la última columna seleccionada y la métrica.
    </li>
	 <li class="tlypageguide_top" data-tourtarget="#desasociarHecho">
        Botón que desasocia la última columna seleccionada y la métrica.
    </li>
	

    <!-- Contenedor de la actualizacion del hecho -->
    <li class="tlypageguide_left" data-tourtarget=".preview">
        Obtiene la vista previa de los datos correspondientes al cubo.
    </li>
    <li class="tlypageguide_top" data-tourtarget=".creaVista">
        Crea una vista en la base de datos con los datos correspondientes al cubo, y muestra una consulta de la misma.
    </li>
    <li class="tlypageguide_bottom" data-tourtarget=".replica">
        Botón que replica de la clasificación actual a los formatos asociados, en caso de ser un formato contenedor.
    </li>

</ul>


