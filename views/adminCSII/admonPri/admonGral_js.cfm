<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

$(document).ready(function() {
  
});

function consultarS1(Modulo) {
    var modulo = $("#inModulo").val();
    $.post('<cfoutput>#event.buildLink("adminCSII.admonPri.admonPri.desplegarInfo")#</cfoutput>', {modulo :modulo}, function(data){
        $('#recuadros-roles').html(data);
    });
}

function consultarS2(pkModulo){
    var pkModulo = $("#inModulo").val();   
    $.post('<cfoutput>#event.buildLink("adminCSII.admonPri.admonPri.mostrarAccionesRol")#</cfoutput>' , { 
          pkModulo: pkModulo            
        }, function(data){            
            $('#columna-uno').html(data);
            evalCheckbox();
    });
}


function consultarSeccion(){
    consultarS1();   //trae los checks
    consultarS2();
    // countChecked(); 
}

function thrDoc(){
   window.location= '/index.cfm/adminCSII/admonPri/admonPri';
}

function secDoc(){
   window.location= '/index.cfm/adminCSII/admonPri/admonPri/cargarAcciones';
}

    
  
function evalCheckbox(){ 
    $('#recuadros-roles').find("input[type=checkbox]").each(function(){
        var columna = $(this).val();
        if( $(this).prop('checked') ){
            $('#tabla-accion').bootstrapTable('showColumn', columna);
        }else{  
            $('#tabla-accion').bootstrapTable('hideColumn', columna);
        }
    });
}


function agregaAccion(accion,rol){
    alert('Agregar los valores : acc '+accion+'  ,rol '+rol);
    var edo = 2;
	
	
    $.post('<cfoutput>#event.buildLink("adminCSII.admonPri.admonPri.altaAccionRol")#</cfoutput>' , {
            edo:edo, accion: accion, rol: rol
        }, function(data) {

            if(data > 0) {
                consultarS2();
                toastr.success('Asignado correctamente', 'Acción/Rol');
            } else
                toastr.error('Hubo un problema al tratar de la acción al rol.');
        });  
}

function degradarAccion(accion,rol){
    
    var edo = 0;

    $.post('<cfoutput>#event.buildLink("adminCSII.admonPri.admonPri.bajaAccrol")#</cfoutput>' , {
        edo: edo, accion: accion, rol: rol
    }, function(data) {

        if(data > 0) {
            consultarS2();
            toastr.success('Asignado correctamente', 'Acción/Rol');
        } else
            toastr.error('Hubo un problema al tratar de la acción al rol.');
    });  
}






</script>

