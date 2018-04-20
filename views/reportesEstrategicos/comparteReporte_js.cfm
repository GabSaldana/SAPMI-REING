<cfprocessingdirective pageEncoding="utf-8"> 
<script >
    <!---
        * Descripcion: LLenar tabla de usuarios para compartir
        * Fecha:       16 de febrero de 2017
        * @author      Jonathan Martinez
        * Descripcion Modificacion: Asignacion de privilegio
        * Modificacion: 09 de marzo de 2017
        * @author      Alejandro Rosales
    --->
    <!--- Inicializacion de variables --->
    var data = [];
    var share= [];
    var cont=1;
    <!--- Inicia Cuerpo del Script --->
    <cfif isDefined('prc.shareuser_g.recordCount') >
    <cfset cont=1>
       <cfloop index='i' from='1' to='#prc.shareuser_g.recordCount#'>
            <cfoutput>
                <cfset val=0>
                <cfset relacion = -1>
                <cfif prc.shareuser_g.PK_USUARIO[i] EQ prc.shareuser_s.PK_USUARIO[cont]>
                     <cfif prc.shareuser_s.PRIVILEGIO[cont] EQ 0>
                       <cfset val=1>
                    <cfelse>
                        <cfset val=2>
                   </cfif>
                    <cfset relacion = prc.shareuser_s.PK_RELACION[cont]>        
                   share.push(#i-1#);
                   #cont++#;      
                </cfif> 
                    data.push({
                        id: "#prc.shareuser_g.PK_USUARIO[i]#",
                        nombre: "#prc.shareuser_g.NOMBRE[i]#",
                        apPaterno: "#prc.shareuser_g.PATERNO[i]#",
                        apMaterno: "#prc.shareuser_g.MATERNO[i]#",
                        rol: "#prc.shareuser_g.ROL[i]#",
                        dependencia: "#prc.shareuser_g.DEPEN[i]#",  
                        relacion: #relacion#,
                        data: "#val#"      
                    });
            </cfoutput>
        </cfloop>
    </cfif>

    $(document).ready(function() {    
        $('#tabla_share_User').bootstrapTable(); 
        $('#tabla_share_User').bootstrapTable('hideColumn', 'id');
        $('#tabla_share_User').bootstrapTable('hideColumn', 'data');
        $('#tabla_share_User').bootstrapTable('load', data);
        var totalR = $('#tabla_share_User').bootstrapTable('getOptions').totalRows;
        if(totalR == share.length){
            $(".compartirTodos").prop('checked', true);
        }
        var s = $('#tabla_share_User').bootstrapTable('getData');
        var countData = 0;
        var totalRel = 0;
        for (var i = s.length - 1; i >= 0; i--) {
            if(s[i].data == 1){
                countData ++;
            }
            if(s[i].relacion != -1){
                totalRel ++;
            }
        }
        if(countData == totalRel){
            $(".privilegioTodos").prop('checked', true);
        }

    });


    function cambiarTodosPrivilegios(idRelaciones, valor){
        $.post('/index.cfm/reportesEstrategicos/consultaVistaMat/setTodosPrivilegios', {
            idRelaciones: idRelaciones,
            state: valor
        }, function(data){
                toastr.success('Se cambiaron los privilegios correctamente','Reporte estrat&eacute;gico');
                getShareUser(); 
        }
    ) .fail(function() {
        console.log("Error.");
        toastr.error('Hubo un problema cambiando los privilegios de las relaciones','Reporte estrat&eacute;gico');
    }); 
    }
    function privilegioCheck(){
        var ids = [];
        var s = $('#tabla_share_User').bootstrapTable('getData');
        for (var i = s.length - 1; i >= 0; i--) {
            if(s[i].relacion != -1){
               ids.push(s[i].relacion);
            }
        }
        if($("#privilegioTodos").is(':checked')){
            cambiarTodosPrivilegios(JSON.stringify(ids),0);
        }else{
            cambiarTodosPrivilegios(JSON.stringify(ids),1);
        
        }   
    }
    
    function changeDataView(state,newState,indexA,pkRelacion){
         if(state == 1){
            $("#Btn"+indexA).attr("onClick", "changeState(2,1,"+indexA+","+pkRelacion+");");
            $('#tabla_share_User').bootstrapTable('updateRow', {index: indexA, row: {
                data:newState
            }});
            $("#Btn"+indexA).switchClass("fa-unlock","fa-lock");
            
        }
        else if(state == 2){
            inv  = 1;
            $("#Btn"+indexA).attr("onClick", "changeState(1,2,"+indexA+","+pkRelacion+");");
            $('#tabla_share_User').bootstrapTable('updateRow', {index: indexA, row: {

                data:newState
            }});
            $("#Btn"+indexA).switchClass("fa-lock","fa-unlock"); 
        }
    }
    
    function changeState(state,newState,indexA,pkRelacion){
        $.post('/index.cfm/reportesEstrategicos/consultaVistaMat/setPrivilegio', {
            idRelacion: pkRelacion,
            state: (newState-1)
        }, function(data){
            if(data > 0){
                toastr.success('Se cambio el privilegio correctamente','Reporte estrat&eacute;gico');
                changeDataView(state,newState,indexA,pkRelacion);
            } 
        }
    ) .fail(function() {
        console.log("Error.");
        toastr.error('Hubo un problema cambiando el privilegio','Reporte estrat&eacute;gico');
    });     
    }
    function putDatos(value, row, index) {
    if(row.data == 1)
    {
        var cad = "<button class=\"btn btn-danger ml5  fa fa-unlock bt-seleccionAccion\" data-tooltip=\"tooltip\" id=\"Btn"+index+"\" onClick=\"changeState(1,2,"+index+","+row.relacion+");\" > </button>";
                return [
                    cad
                
                ].join('');
    }
    else if(row.data == 2){
     var cad = "<button class=\"btn btn-danger ml5  fa fa-lock bt-seleccionAccion\" data-tooltip=\"tooltip\" id=\"Btn"+index+"\"  onClick=\"changeState(2,1,"+index+","+row.relacion+");\"> </button>";
                return [
                    cad
                
                ].join('');   
    }

    }

    function getShareUser(){
        $.post('consultaVistaMat/getShareUser',{
            idReporte : num_reporte
        }, function(data){
            $('#table-share').html( data );
        });
    } 
    function activarRelacion(id, indice, band){
        $.ajax({
            url: '/index.cfm/reportesEstrategicos/consultaVistaMat/altaShare',
            type: 'POST',
            data: {     idReporte : num_reporte,
                        usuario: id},
            success: function(data) {
                $('#tabla_share_User').bootstrapTable('updateRow', 
                    {index: indice, row: { relacion:data } } );
                if(band)
                    toastr.success('Se cambio la relacion del reporte','Reporte estrat&eacute;gico');
                $.ajax( {
                    url: '/index.cfm/reportesEstrategicos/consultaVistaMat/getEstadoPrivilegio',
                    type: 'POST',
                    data: { idrelacion : data},
                    success: function(resultado) {
                         $('#tabla_share_User').bootstrapTable('updateRow', {index: indice, row: {
                            data:(Number(resultado)+1)
                        }});
                    }
            });
          }
     });

    }
    function desactivarRelacion(id, indice, band){
        $.post('/index.cfm/reportesEstrategicos/consultaVistaMat/bajaShare', {
                idReporte : num_reporte,
                usuario: id
            },function(data){
            $('#tabla_share_User').bootstrapTable('updateRow', {index: indice, row: {
                relacion:-1
                }});
             $('#tabla_share_User').bootstrapTable('updateRow', {index: indice, row: {
                data:0
                }});
              if(band)
                toastr.success('Se cambio la relacion del reporte','Reporte estrat&eacute;gico');         
        });
    }

    function cambiarRelacion(id){
        var indice = $('#check'+id).attr('indice');
        if ($('#check'+id).is(':checked')) {

            activarRelacion(id, indice, true);
        }
        else{
            desactivarRelacion(id, indice, true);   
        }
    }
    function compartirCheck(){
        var relaciones = []; 
        for (var i = data.length - 1; i >= 0; i--) {
            relaciones.push(data[i].id);
        }
        if($("#compartirTodos").is(':checked')){
            $.post('/index.cfm/reportesEstrategicos/consultaVistaMat/altaTodosShare', {
                    idReporte : num_reporte,
                    idUsuarios: JSON.stringify(relaciones)
                },function(data){
                    getShareUser();
                    toastr.success('Se activaron las relaciones de los reportes','Reporte estrat&eacute;gico');         
            });
        }else{
            $.post('/index.cfm/reportesEstrategicos/consultaVistaMat/bajaTodosShare', {
                    idReporte : num_reporte,
                    idUsuarios: JSON.stringify(relaciones)
                },function(data){
                    getShareUser();
                    toastr.success('Se activaron las relaciones de los reportes','Reporte estrat&eacute;gico');         
            });
        }

    }
    function checkRelacion(value, row, index){
        var cad = '';
        if(row.relacion != -1)
            cad = '<input id="check'+row.id+'" indice="'+index+'" class="check'+row.id+'" type="checkbox" onChange="cambiarRelacion('+row.id+');" checked></input>';
        else
            cad = '<input id="check'+row.id+'" indice="'+index+'" class="check'+row.id+'" type="checkbox" onChange="cambiarRelacion('+row.id+');"></input>';
        return [cad].join('');
    }
</script>
