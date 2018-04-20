<script type="text/javascript">
    
$('[data-toggle="tooltip"]').tooltip();
$('.selectpicker').selectpicker();
<cfset max = #prc.estados.recordCount#>
$(".ionRangeSlider").ionRangeSlider({
    hide_min_max: true,
    keyboard: true,
    min: <cfoutput>#PRC.estados.NUMEDO[1]#</cfoutput>,
    max: <cfoutput>#PRC.estados.NUMEDO[max]#</cfoutput>,
    from: <cfoutput>#PRC.estados.NUMEDO[1]#</cfoutput>,
    to: <cfoutput>#PRC.estados.NUMEDO[max]#</cfoutput>,
    type: 'double',
    step: 1,
    prefix: "edo ",
    grid: true
});

//Cambia de color las acciones respecto al tipo de operación
$('body').on('click', '.prenderAccion', function(){
    edgess.update([{color:{color:'#7F2554', highlight:{background:'#68DCFF', border:'#000'}}}]);
    var operacion = ($(this).attr('pos-operacion') + $(this).attr('pre-operacion')).split('][', ).toString();
    operacion = JSON.parse(operacion.replace("[,", "[").replace(",]", "]"));
    var pos = JSON.parse($(this).attr('pos-operacion'));
    var pre = JSON.parse($(this).attr('pre-operacion'));

    if(pre != '')
        for (var i = 0; i < pre.length; i++) 
            edgess.update([{id:pre[i], color:{color:'red', highlight:'red'}}]);

    if(pos != '')
        for (var i = 0; i < pos.length; i++) 
            edgess.update([{id:pos[i], color:{color:'green', highlight:'green'}}]);
    network.selectEdges(operacion);

    setTimeout(function(){
       for (var i = 0; i < operacion.length; i++) 
            edgess.update([{id:operacion[i], color:{color:'#7F2554', highlight:{background:'#68DCFF', border:'#000'}}}]);
        network.selectEdges([]);
    },2000);
});

//Muestra el grafo con filtros
$('body').on('change', '.buscador', function(){
    roles = ($('#roles').val() == null ? '0' : $('#roles').val()).toString();
    acciones = ($('#acciones').val() == null ? '0' : $('#acciones').val()).toString();
    estados = ($('#estados').val().toString().split(';')).toString();
    $.post('<cfoutput>#event.buildLink("adminCSII.admonEdos.admonEdos.getDatoGrafoFiltros")#</cfoutput>',{
        pkRuta: $('#Ruta').val(),
        roles: roles,
        acciones: acciones,
        estados: estados
    }, function(data){
        if(data)
            $('#mynetwork').html(data);
    });
});

</script>

<cfoutput><input type="hidden" id="Ruta" value="#prc.ruta#"></cfoutput>

<div class="col-md-3">
    <div class="tabs-container">
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true">Operaciones</a></li>
            <li class=""><a data-toggle="tab" href="#tab-2" aria-expanded="false">Filtros</a></li>
        </ul>
        <div class="tab-content">
            <div id="tab-1" class="tab-pane active">
                <div class="panel-body">
                    <div class="row">
                        <cfloop index = "i" from="1" to="#arrayLen(prc.operaciones)#"> 
                            <cfoutput>
                                <label class="prenderAccion" 
                                    <cfset pre = ""><cfset pos = "">
                                    <cfloop index = "j" from="1" to="#arrayLen(prc.operaciones[i][2])#">
                                        <cfif  #prc.operaciones[i][2][j]# eq  1><cfif pre eq ''><cfset pre = pre & #prc.operaciones[i][4][j]#><cfelse><cfset pre = pre & ", " & #prc.operaciones[i][4][j]#></cfif></cfif>
                                        <cfif  #prc.operaciones[i][2][j]# eq  2><cfif pos eq ''><cfset pos = pos & #prc.operaciones[i][4][j]#><cfelse><cfset pos = pos & ", " & #prc.operaciones[i][4][j]#></cfif></cfif>
                                </cfloop>
                                pre-operacion = "[#pre#]" pos-operacion = "[#pos#]" id="operacion#i#" 
                                 data-toggle="tooltip" title = #prc.operaciones[i][1][3]#
                                ><h5>#prc.operaciones[i][1][2]#</h5></label><br>
                            </cfoutput> 
                        </cfloop>
                    </div>
                    <div class="row">
                        <img src="/includes/img/operaciones/operaciones.png">
                    </div>
                </div>
            </div>
            <div id="tab-2" class="tab-pane">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-12">
                            <h4>Roles</h4>
                        </div>
                        <div class="col-md-12">
                            <select class="selectpicker buscador" multiple data-live-search="true" data-style="btn-success btn-outline" id="roles" title="Seleccionar roles...">
                                 <cfloop index='i' from='1' to='#prc.roles.recordCount#'>
                                    <cfoutput>
                                        <option value="#prc.roles.pk[i]#">#prc.roles.NOMROL[i]#</option>
                                    </cfoutput>
                                 </cfloop>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <h4>Acciones</h4>
                        </div>
                        <div class="col-md-12">
                            <select class="selectpicker buscador" multiple data-live-search="true" data-style="btn-success btn-outline" id="acciones" title="Seleccionar acciones...">
                                 <cfloop index='i' from='1' to='#prc.acciones.recordCount#'>
                                    <cfoutput>
                                        <option value="#prc.acciones.pk[i]#">#prc.acciones.NOMACCION[i]#</option>
                                    </cfoutput>
                                 </cfloop>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <h4>Rango de estados</h4>
                        </div>
                        <div class="col-md-12">
                            <input class="ionRangeSlider buscador" type="text" id="estados" name="rangoEdos">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>        
</div>