<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Sub modulo:  Convenios
* Fecha:       22 de mayo de 2017
* Descripcion: Tabla que contiene la informacion enlistada de los convenios 
* Autor:       Jose Luis Granados Chavez
* ================================
---->

<cfprocessingdirective pageEncoding="utf-8">

<table id="tabla_acciones" class="table table-responsive" data-pagination="true" data-page-size="10" data-search-accent-neutralise="true" data-search="true">
    <thead class="tablaEncabezado">
        <!--- <th class="text-ceter" dta-formatter="getIndex">#</th> --->
        <th data-sortable="true">Número de folio</th>
        <th data-sortable="true">Vigencia</th>
        <th data-sortable="true">Tiempo activo</th>
        <th data-sortable="true">Monto total</th>
        <th data-sortable="true">Tipo</th>
        <th data-sortable="true">Estado</th>
        <th class="text-center">Acciones</th>
    </thead>
    <tbody style="background-color: white;">
        <cfset i = 0>
        <cfoutput query="prc.tablaConvenios">
            <cfset i++>
                <tr>
                    <!--- <td>#i#</td> --->
                    <td><strong>#REGISTRO#</strong></td>
                    <td class="text-center">#CONFECHAVIGINI# al #CONFECHAVIGFIN#</td>
                    <td class="text-center">#fix((TIEMPOACTIVO/60)/24)# días, #fix((TIEMPOACTIVO/60)%24)# horas, #fix((TIEMPOACTIVO%60)%24)# min.</td>
                    <td class="text-right">#CONMONTOTOTAL#</td>
                    <td class="text-center">#NOMBRETIPO#</td>
                    <td class="text-center">
                        <span class="fa-stack color#NUMEDO#" style="font-size:15px;" data-toggle="tooltip" data-placement="top" data-original-title="#NOMBREESTADO#">
                            <i class="fa fa-circle-o fa-stack-2x olor#NUMEDO#"></i>
                            <strong class="fa-stack-1x color#NUMEDO# guiaEstado">#NUMEDO#</strong>
                        </span>
                    </td>
                    <td class="text-center">
                        <!--- INI BOTONERA ACCIONES --->
                        <cfif listFind(prc.tablaConvenios.ACCIONESCVE,'busqueda.validar','$')>
                            <button type="button" class="btn btn-convenio btn-circle guiaBtnValidar" onclick="CambiaEstadoConvenioValidar(#PK#, '#REGISTRO#', #FKTIPO#);" data-toggle="tooltip" data-placement="top" data-original-title="Validar convenio">
                                <i class="fa fa-unlock-alt" aria-hidden="true"></i>
                            </button>
                        </cfif>
                        <cfif listFind(prc.tablaConvenios.ACCIONESCVE,'busqueda.rechazar','$') and prc.tablaConvenios.NUMEDO neq 1>
                            <button type="button" class="btn btn-convenio btn-circle guiaBtnRechazar" onclick="CambiaEstadoConvenioRechazar(#PK#, '#REGISTRO#');" data-toggle="tooltip" data-placement="top" data-original-title="Rechazar convenio">
                                <i class="fa fa-share icon-flipped" aria-hidden="true"></i>
                            </button>
                        </cfif>
                        <cfif ArrayContains(Session.cbstorage.grant,'busqueda.editar') and prc.tablaConvenios.NUMEDO eq 1>
                            <button type="button" class="btn btn-convenio btn-circle guiaBtnBorrar" onclick="CambiaEstadoConvenioEliminar(#PK#, '#REGISTRO#');" data-toggle="tooltip" data-placement="top" data-original-title="Borrar convenio">
                                <i class="fa fa-trash" aria-hidden="true"></i>
                            </button>
                            <button type="button" class="btn btn-convenio btn-circle guiaBtnEditar" onclick="EditarConvenio(#PK#, #FKTIPO#);" data-toggle="tooltip" data-placement="top" data-original-title="Editar convenio">
                                <i class="fa fa-pencil" aria-hidden="true"></i>
                            </button>
                        </cfif>
                        <cfif listFind(prc.tablaConvenios.ACCIONESCVE,'busqueda.validar','$')>
                            <button type="button" class="btn btn-convenio btn-circle guiaBtnConsultar" onclick="ConsultaConvenio(#PK#, #FKTIPO#, true, #prc.tablaConvenios.NUMEDO#, '#ArrayContains(Session.cbstorage.grant,'busqueda.editar')#');" data-toggle="tooltip" data-placement="top" data-original-title="Consultar convenio">
                                <i class="fa fa-search" aria-hidden="true"></i>
                            </button>
                        <cfelse>
                            <button type="button" class="btn btn-convenio btn-circle guiaBtnConsultar" onclick="ConsultaConvenio(#PK#, #FKTIPO#, false, #prc.tablaConvenios.NUMEDO#, '#ArrayContains(Session.cbstorage.grant,'busqueda.editar')#');" data-toggle="tooltip" data-placement="top" data-original-title="Consultar convenio">
                                <i class="fa fa-search" aria-hidden="true"></i>
                            </button>
                        </cfif>
                        <!--- FIN BOTONERA ACCIONES --->
                    </td>
                </tr>
        </cfoutput>
    </tbody>
</table>

<script type="text/javascript">
    <!----
    * Descripcion:    Activa los tooltips en la tabla_acciones
    * Fecha creacion: 22 de mayo de 2017
    * @author:        José Luis Granados Chávez
    ---->
    $(document).ready(function(){
        $("#tabla_acciones").bootstrapTable();
        $('[data-toggle="tooltip"]').tooltip(); 
    });

    <!---- Crea el valor indice de la tabla ---->
    function getIndex(value, row, index) {
        return index+1;
    }
 </script>