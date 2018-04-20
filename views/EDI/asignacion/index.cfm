<!---
* =========================================================================
* IPN - CSII
* Sistema:      SIIP
* Modulo:       Asignación investigador - evaluador
* Fecha:        Enero de 2018
* Descripcion:  Index de la asignación investigador - evaluador
* Autor:        Roberto Cadena
* =========================================================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="index_js.cfm"> 
<style type="text/css">
    .content{
        height: 75vh !important;
        overflow: auto !important;
    }
    .tabcontrol > .content > .body {
        width: 100%;
    }
</style>

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Asignación Investigador - Evaluador</h2>
        <ol class="breadcrumb">
            <cfoutput>
            <li>
                <a href="#event.buildLink('inicio')#">Inicio</a>
            </li>
            <li class="active">
                <strong>Asignación Investigador - Evaluador</strong>
            </li>
            </cfoutput>
        </ol>
    </div>
</div>

<div class="wrapper wrapper-content animated fadeIn">

<div class="tabs-container">
    <ul class="nav nav-tabs">
        <li class="active"><a data-toggle="tab" href="#tab-comiteEvaluador" aria-expanded="true"> Administración de Evaluadores</a></li>
        <li class="" onclick="asigInvestigadores();"><a data-toggle="tab" href="#tab-asigInvestigadores" aria-expanded="false"> Asignación de Investigadores</a></li>
        <li class="" onclick="asigEvaluadores();"><a data-toggle="tab" href="#tab-asigEvaluadores" aria-expanded="false"> Asignación de Evaluadores</a></li>
    </ul>
    <div class="tab-content">
        <div id="tab-comiteEvaluador" class="tab-pane active">
            <div class="panel-body">
                <div class="col-md-12" id="comiteEvaluador"></div>
            </div>
        </div>
        <div id="tab-asigInvestigadores" class="tab-pane">
            <div class="panel-body">
                    <div class="col-md-12" id="asigInvestigadores"></div>
            </div>
        </div>
        <div id="tab-asigEvaluadores" class="tab-pane">
            <div class="panel-body">
                    <div class="col-md-12" id="asigEvaluadores"></div>
            </div>
        </div>
    </div>
</div>

<div id="modal-asigEvaluadores" class="modal inmodal fade modaltext" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg">
        <div id="modal-asigEvaluadoresContent" class="modal-content">
        </div>
    </div>
</div>