<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">
$('.selectpicker').selectpicker();

$(document).ready(function(){
	consultarListaGestionEvaluadores();
});

function consultarListaGestionEvaluadores(){
	if($('#inProceso').val() != 0 && $('#inProceso').val() != '' && $('#inProceso').val() != NaN && $('#inProceso').val() != null && $('#inProceso').val() != undefined)
		$.post('<cfoutput>#event.buildLink("EDI.asignacionEvaluadores.getEvaluadores")#</cfoutput>',{
			proceso: $('#inProceso').val()
		}, function(data){
		    $('#listaGestionEvaluadores').html(data);
		});
}

$('body').off('#inProceso', 'change');
$('body').on('change', '#inProceso', function(){
		if($('#inProceso').val() != 0 && $('#inProceso').val() != '' && $('#inProceso').val() != NaN && $('#inProceso').val() != null && $('#inProceso').val() != undefined)
	    $.post('<cfoutput>#event.buildLink("EDI.asignacionEvaluadores.getEvaluadores")#</cfoutput>',{
	    	proceso: $('#inProceso').val()
	    }, function(data){
	        $('#listaGestionEvaluadores').html(data);
	    });
});

    /* SELECT 2 */
    $('select2').select2({
        containerCssClass: 'form-control'
    }).on('change',function(event){
        if($(this).val() !== '-1'){    		
            $(this).closest('.form-group').removeClass('has-error');
            $(this).parent().find('label[id$="-error"]').hide();
    }
    });
    var obj = <cfoutput>#Request.ur#</cfoutput>,
    keys = Object.keys(obj),
    len = keys.length;
    keys.sort();       
    for(i in keys){
        var clasif = document.createElement("optgroup");
        clasif.label = keys[i];        
        $.each(obj[keys[i]], function(index, val) {
            var dependencia = document.createElement("option");
            dependencia.value = val.PK;
            dependencia.text = val.NOMBRE;
            clasif.append(dependencia);            
        });
        $('#inUr').append(clasif);
    }

    <!---
    * Descripcion: Formar nombre de usuario
    * Fecha: 09 de agosto de 2016
    * @author: Alejandro tovar
    * --->
    $("#inRol").change(function(){
        if( $("#inRol").val() == "" ){
            $("#inPref").text("");
        }else{
            $.post('<cfoutput>#event.buildLink("adminCSII.usuarios.usuarios.getClaveRol")#</cfoutput>', {
                rol: $("#inRol").val()
                },function(data){      
                    if(data){
                        $("#inPref").text(data.DATA.CLAVE[0]);
                        var posPref = $("#inEmail").val().indexOf('@');
                        var prefijo = $("#inEmail").val().substr(0,posPref);
                        $("#inUser").val(prefijo.toUpperCase());
                    }
            }); 
        }
    });

    <!---
    * Descripcion: Formar nombre de usuario al cambiar el campo Email
    * Fecha: 12 de agosto de 2016
    * @author: Alejandro tovar
    * --->
    $("#inEmail").keyup(function(){
        var posPref = $("#inEmail").val().indexOf('@');
        var prefijo = $("#inEmail").val().substr(0,posPref);
        $("#inUser").val(prefijo.toUpperCase());
    });



    <!---
    * Descripcion: Agrega un usuario
    * Fecha: 08 de agosto de 2016
    * @author: Yareli Andrade
    * --->
    $(document).on("click", "#btn-agregar", function() {
        if($("#validaUsuario").valid()){
            var ur = $("#inUr").val();
            var nombre = $("#inNombre").val();
            var paterno = $("#inPaterno").val();
            var materno = $("#inMaterno").val();
            var genero = $("input[name=inGenero]:checked").val();  
            var acronimo    = $("#inAcr").val();      
            var email = $("#inEmail").val();
            var tel = $("#inTel").val();
            var ext = $("#inExt").val();
            var rol = $("#inRol").val();
            var usr = $("#inPref").text().concat($("#inUser").val());
            $.post('<cfoutput>#event.buildLink("adminCSII.usuarios.usuarios.agregarUsuario")#</cfoutput>', { nombre: nombre, apaterno: paterno, amaterno: materno, acronimo: acronimo, ur: ur, genero: genero, email: email, tel: tel, ext: ext, rol: rol, usr: usr}, function(data){      
                if(data > 0){
                    $('#mdl-admon-usuario').modal('hide');
                    toastr.success('Registrado exitosamente','Usuario');
					consultarListaGestionEvaluadores();
                }
                else
                    toastr.error('Hubo un problema al tratar de guardar el registro.');
            });
        }
    });

</script>