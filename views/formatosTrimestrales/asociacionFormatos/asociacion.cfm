<cfprocessingdirective pageEncoding="utf-8">
<link rel="stylesheet" type="text/css" href="/views/formatosTrimestrales/formatosTrimestrales.css"/>
<cfinclude template="asociacion_js.cfm">

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Reportes concentrados</h2>
        <ol class="breadcrumb">
            <cfoutput>
                <li>
                    <a href="#event.buildLink('inicio')#">Inicio</a>
                </li>
                <li class="active">
                    <strong>Reportes concentrados</strong>
                </li>
            </cfoutput>
        </ol>
    </div>
</div>

<input type="hidden" id="arrayFormatos" value="">
<input type="hidden" id="columnaOrigen" value="">

<div class="wrapper wrapper-content">

    <div id="box-asociaciones">
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>Asociaciones registradas</h5>
                <div class="ibox-tools">
                </div>
            </div>
            <div class="ibox-content">
                <div class="lft-btn text-left">
                    <button type="button" class="btn btn-primary btn-outline dim" onclick="showDragDrop();"><span class="glyphicon glyphicon-plus"></span> Agregar asociación</button>
                </div>
                <div id="asociaciones"> </div>
            </div>
        </div>
    </div>

    <div id="box-formatosRegistrados">
        <div class="ibox float-e-margins">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    Asociacion de formatos <strong><span id="displayNombre"></span></strong>
                    <i id="btn-cerrarTablaFormato" class="btn btn-primary btn-xs pull-right" onclick="cierraDragDrop()" title="Cerrar" style="font-size: 20px;"><i class="fa fa-times"></i> </i><br><br>
                </div>

                <div class="ibox-content">
                    <div id="dragDrop"> </div>
                </div>
            </div>
        </div>
    </div>

    <div id="box-asociaColumnas">
        <div id="tabla"> </div>
    </div>

</div>
