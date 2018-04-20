<!-----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Administracion de estado de los investigadores
* Sub modulo:  -
* Fecha:       11 de diciembre de 2017
* Descripcion: Vista con la informacion de los investigadores a cambiar de estado
* Autor:       JLGC    
* ================================
----->

<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="V_Investigador_js.cfm">

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Listado de investigadores</h2>
        <ol class="breadcrumb">
            <cfoutput>
            <li>
                <a href="#event.buildLink('inicio')#">Inicio</a>
            </li>
            <li class="active">
                <strong>Edición del estado del investigador</strong>
            </li>
            </cfoutput>
        </ol>
    </div>
</div>

<div class="wrapper wrapper-content animated fadeIn">
    
    <div class="ibox float-e-margins">
        <div class="ibox-title">
            <h5>Investigadores</h5>
            <div class="ibox-tools">
            </div>
        </div>
        <div class="ibox-content">
            <div id="contenidoTablaInvestigadores"></div>
        </div>
    </div>

</div>