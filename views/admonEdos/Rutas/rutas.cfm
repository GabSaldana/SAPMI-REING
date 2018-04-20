<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="rutas_js.cfm">

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Administración de estados</h2>
        <ol class="breadcrumb">
            <cfoutput>
            <li>
                <a href="#event.buildLink('inicio')#">Inicio</a>
            </li>
            <li>
                <a href="#event.buildLink('admonEdos/admonEdos')#">Control de estados</a>
            </li>
            <li class="active">
                <strong>Rutas</strong>
            </li>
            </cfoutput>
        </ol>
    </div>
</div>

<div class="wrapper wrapper-content animated fadeIn">
    <div class="ibox float-e-margins">
        <div class="ibox-title guiaRutRegistradas">
            <h5>ESTADOS REGISTRADOS</h5>
            <input id="inProced" type="hidden" value="<cfoutput>#prc.valor#</cfoutput>">
            <div class="ibox-tools">
            </div>
        </div>
        <div class="ibox-content">
            <div id="tableRutas"></div>
        </div>
    </div>
</div>


<div id="modal-grafo" class="modal small inmodal modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"aria-hidden="true">×</button>
                <h4 class="modal-title">Flujo de validación</h4>
            </div>
            <div class="modal-body">
                <div id="divGrafo"></div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<!--- Guia --->
<ul id="tlyPageGuide" data-tourtitle="Rutas.">
    <!--- <li class="tlypageguide_top" data-tourtarget=".guiaRutRegistradas">
        <div> Rutas <br>
            En esta sección se encuentran las rutas registradas del procedimiento seleccionado.
        </div>
    </li> --->
    <li class="tlypageguide_top" data-tourtarget=".search">
        <div> Búsqueda <br>
            Puede realizar la búsqueda de una ruta.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaRutEstados">
        <div> Estados <br>
            Muestra el detalle de los estados registrados de una ruta.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaRutRelaciones">
        <div> Relaciones <br>
            Muestra el detalle de las relaciones registradas de una ruta.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaRutFlujos">
        <div> Flujos de validación <br>
            Muestra el detalle del flujo de validación de una ruta.
        </div>
    </li>
</ul>