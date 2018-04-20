<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Reportes Estrategicos
* Sub modulo: Relación de Reportes
* Fecha 3 de Abril de 2017
* Descripcion:
* Vista correspondiente a la relacion de un reportes
* Autor:Jonathan Martinez
* ================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="relacionaReporte_js.cfm">

<!---Inicia Cuerpo de la vista--->
<div class="panel panel-warning"> 
    <div class="panel-heading"> 
        <i class="fa fa-info-circle"></i> Seleccione el reporte con el que se desea relacionar
    </div>
</div>
<div class="col-sm-5">
    <div class="input-group">
       <span class="input-group-btn"><button type="button" class="btn btn-warning ""><i class="fa fa-book"></i></button></span>
       <div class="form-group">
       <select class="form-control " id="reportes" name="reportes" onchange="Cargartable()">
       <option value="0"  id="0">Seleccione un Reporte</option>
       <cfif isDefined('prc.reportes')>
            <cfloop index='i' from='1' to='#prc.reportes.recordCount#'>
                <cfoutput>
                    <option value="#i#" id="#prc.reportes.IDREP[i]#">#prc.reportes.DES[i]#</option>
                </cfoutput>
            </cfloop>
       </cfif>
       </select> 
       </div>
    </div>
</div>
<br><br><br>
<table id="table_report" class="table table-inverse table-responsive" data-unique-id="id">
   <thead>
       <tr>
           <th class="text-center" data-field="id">#</th>
           <th class="text-center col-xs-3" data-field="nombre" data-sortable="true"><i class="fa fa-pencil-square"></i> Nombre</th>
           <th class="text-center col-xs-3" data-field="desc" data-sortable="true"><i class="fa fa-newspaper-o"></i> Descripcion</th>
           <th class="text-center col-xs-3" data-field="filas" data-sortable="true"><i class="fa fa-arrows-h"></i> Filas</th>
           <th class="text-center col-xs-3" data-field="columnas" data-sortable="true"><i class="fa fa-arrows-v"></i> Columnas</th>
           <th class="text-center col-xs-1" data-field="fecha" data-sortable="true"><i class="fa fa-clock-o"></i> Fecha de última <br> modificación</th>
       </tr>
   </thead>
</table>
