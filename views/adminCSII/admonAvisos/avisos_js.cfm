<cfprocessingdirective pageEncoding="utf-8">

<script type="text/javascript">

    <!---
    * Descripcion: Obtiene lista de avisos
    * Fecha: 18/Enero/2018
    * @author: Alejandro Tovar
    * --->    
    function consultarAvisos(){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonAvisos.avisos.getAvisos")#</cfoutput>', function(data){
            $('#listadoAvisos').html( data );
        });
    }


    <!---
    * Descripcion: Obtiene lista de roles por vertiente
    * Fecha: 18/Enero/2018
    * @author: Alejandro Tovar
    * --->  
    function getRoles() {
        $.ajax({
            type:"POST",
            async:false,
            url:"<cfoutput>#event.buildLink("adminCSII.admonAvisos.avisos.getRolesByVertiente")#</cfoutput>",
            data:{
                pkVert: $("#inVert").val()
            },
            success:function(data){
                if (data.ROWCOUNT > 0){
                    $(".rolesVert").empty();
                    var list = $(".rolesVert").append('<ol type="none"></ol>').find('ol');
                    for (var i = 0; i < data.ROWCOUNT; i++){
                        list.append("<li><div class='checkbox checkbox-primary'><input id='"+data.DATA.PK[i]+"' name='destinatarios' type='checkbox' value=" + data.DATA.PK[i] + "><label for='radio"+i+"'>" + data.DATA.ROL[i] + "</label></div></li>");
                    }
                }
            }
        });
    }    


    <!---
    * Descripcion: Guarda el registro del aviso
    * Fecha: 18/Enero/2018
    * @author: Alejandro Tovar
    * --->  
    function guardarAviso() {
        var checkRol = new Array();

        $('input[name="destinatarios"]:checked').each(function() {
            checkRol.push($(this).val());
        });


        $.post('<cfoutput>#event.buildLink("adminCSII.admonAvisos.avisos.guardaAviso")#</cfoutput>', {
            nombre:  $("#nombre").val(),
            mensaje: $("#mnsj").val(),
            fecIni:  $("#fecIni").val(),
            fecFin:  $("#fecFin").val(),
            redir:   $("#redir").val(),
            vert:    $("#inVert").val(),
            pkRoles: JSON.stringify(checkRol)
            }, function(data){

                if (data > 0){
                    consultarAvisos();
                    toastr.success('Aviso guardado exitosamente', '');
                    limpiarCampos();
                    $("#mdl-admon-avisos").modal('hide');

                }else {
                    toastr.error('Error al guardar aviso', '');
                }

            }   
        );
    }


    <!---
    * Descripcion: Limpia los campos del formulario
    * Fecha: 18/Enero/2018
    * @author: Alejandro Tovar
    * ---> 
    function limpiarCampos(){
        $("#nombre").val('');
        $("#mnsj").val('');
        $("#fecIni").val('');
        $("#fecFin").val('');
        $("#redir").val('');
        $("#inVert").val(-1);
        $(".rolesVert").empty();
    }


    <!---
    * Descripcion: edita el registro de un aviso
    * Fecha: 18/Enero/2018
    * @author: Alejandro Tovar
    * ---> 
    function editarAviso(pkAviso) {
        $.post('<cfoutput>#event.buildLink("adminCSII.admonAvisos.avisos.getAvisoByPk")#</cfoutput>', {
            pkAviso: pkAviso
            }, function(data){
                if (data.ROWCOUNT > 0){
                    $(".btn-cambio").attr('onclick', 'actualizarAviso();');
                    $(".btn-cambio").html('Actualizar');
                    $("#mdl-admon-avisos").modal('show');
                    $("#pkAvisoEditar").val(data.DATA.PK_AVISO[0]);
                    $("#nombre").val(data.DATA.NOMBRE_AVISO[0]);
                    $("#mnsj").val(data.DATA.NOMBRE_DESC[0]);
                    $("#fecIni").val(data.DATA.FECHA_INICIO[0]);
                    $("#fecFin").val(data.DATA.FECHA_FIN[0]);
                    $("#redir").val(data.DATA.REDIRECCION[0]);
                    $("#inVert").val(data.DATA.VERTIENTE[0]);
                    getRoles();

                    var roles = (data.DATA.ROLES[0]).split(', ');
                    for (var i = 0; i < roles.length; i++){
                        $("#"+roles[i]+"").attr("checked", "checked");
                    }
                }
            }   
        );
    }


    <!---
    * Descripcion: Actualiza el registro del aviso
    * Fecha: 18/Enero/2018
    * @author: Alejandro Tovar
    * --->  
    function actualizarAviso() {
        var checkRol = new Array();

        $('input[name="destinatarios"]:checked').each(function() {
            checkRol.push($(this).val());
        });

        $.post('<cfoutput>#event.buildLink("adminCSII.admonAvisos.avisos.editarAviso")#</cfoutput>', {
            pkAviso: $("#pkAvisoEditar").val(),
            nombre:  $("#nombre").val(),
            mensaje: $("#mnsj").val(),
            fecIni:  $("#fecIni").val(),
            fecFin:  $("#fecFin").val(),
            redir:   $("#redir").val(),
            vert:    $("#inVert").val(),
            pkRoles: JSON.stringify(checkRol)
            }, function(data){
                if (data > 0){
                    consultarAvisos();
                    toastr.success('Aviso guardado exitosamente', '');
                    limpiarCampos();
                    $("#mdl-admon-avisos").modal('hide');
                }else {
                    toastr.error('Error al guardar aviso', '');
                }
            }   
        );
    }


    <!---
    * Descripcion: Obtiene lista de avisos
    * Fecha: 19/Enero/2018
    * @author: Alejandro Tovar
    * --->  
    function eliminarAviso(pkAviso) {

        $.post('<cfoutput>#event.buildLink("adminCSII.admonAvisos.avisos.cambiaEdoAviso")#</cfoutput>', {
            pkAviso: pkAviso,
            }, function(data){

                if (data > 0){
                    consultarAvisos();
                    toastr.success('Aviso eliminado correctamente', '');
                }else {
                    toastr.error('Error al eliminar aviso', '');
                }

            }   
        );
    }


    <!---
    * Descripcion: Abre modal para capturar avisos
    * Fecha: 19/Enero/2018
    * @author: Alejandro Tovar
    * --->  
    function abreModal() {
        $("#mdl-admon-avisos").modal('show');
        $("#pkAvisoEditar").val('');
        $(".btn-cambio").attr('onclick', 'guardarAviso();');
        $(".btn-cambio").html('Guardar');
    }


    $(document).ready(function() {

        consultarAvisos();

        $('.date').datepicker({
            format: 'dd/mm/yyyy',
            language: 'es',
            calendarWeeks: true,
            autoclose: true,
            startDate: '01/01/2015',
            todayHighlight: true
        });

        toastr.options = {
            "closeButton": true,
            "debug": false,
            "progressBar": true,
            "preventDuplicates": false,
            "newestOnTop": true,
            "positionClass": "toast-top-right",
            "onclick": null,
            "showDuration": "400",
            "hideDuration": "1000",
            "timeOut": "5000",
            "extendedTimeOut": "2000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        };
    });


</script>