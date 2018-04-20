<cfprocessingdirective pageEncoding="utf-8">

<script>

	$(document).ready(function() {

		$('.btn-autoevaluacion').click(function(event) {
			$.ajax({
				url: '<cfoutput>#event.buildLink("EDI.solicitud.autoevaluacion")#</cfoutput>',
				type: 'POST',					
			}).done(function(data) {				
				$('#divAutoevaluacion').html(data);
				$('#elemSolicitudes').hide('slow',function(){
					$('#panelAutoEvaluacion').show("slow");
				});        
			});
		});

		$('.cierraAutoevaluacion').click(function(event) {
			$('#panelAutoEvaluacion').hide("slow");
      $('#elemSolicitudes').show("slow");		
		});

		$("#mdlMovs").modal();

         $('.bt-GetResumen').click(function(){
         	$.post('<cfoutput>#event.buildLink("EDI.solicitud.getResumen")#</cfoutput>', {
         		pkPersona: <cfoutput>#prc.pkPersona#</cfoutput>,
				pkmovimiento:$(this).parent().attr('val-pkMov')
			}, function(data){
				$('#divRequisitos').html(data);
				$('#modal-requisito').modal('show');
			});
         });
         
         
         $('.bt-solicitud').click(function(){
         	var pkMovimiento=$(this).parent().attr('val-pkMov');
         	swal({
				title:              "¿Desea Aplicar para esta Solicitud?",
				type:               "warning",
				confirmButtonText:  "Aceptar",
				cancelButtonText:   "Cerrar",
				showCancelButton:   true,
				closeOnConfirm:     true,
			}, function () {
				$.post('<cfoutput>#event.buildLink("EDI.solicitud.getFlujoSolicitud")#</cfoutput>', {
	         		pkPersona: <cfoutput>#prc.pkPersona#</cfoutput>,
					pkmovimiento:pkMovimiento
				}, function(data){
					abrecierraSolicitud();
					$('#divSolicitud').html(data);
				});
			});
         });
         $('body').on('click', '.cierraSolicitud', function(){
			abrecierraSolicitud();
		});

        $('.bt-comite').click(function(){
            swal({
                title:              "¿Desea crear una nueva solicitud al comite?",
                type:               "warning",
                confirmButtonText:  "Aceptar",
                cancelButtonText:   "Cerrar",
                showCancelButton:   true,
                closeOnConfirm:     true,
            }, function () {
                $.post('<cfoutput>#event.buildLink("EDI.solicitud.getFlujoComite")#</cfoutput>', {
                }, function(data){
                    abrecierraComite();
                    $('#divComite').html(data);
                });
            });
         });
         $('body').on('click', '.cierraComite', function(){
            abrecierraComite();
        }); 

        $('.bt-inconformidad').click(function(){
            swal({
                title:              "¿Desea aplicar al recurso de inconformidad?",
                type:               "warning",
                confirmButtonText:  "Aceptar",
                cancelButtonText:   "Cerrar",
                showCancelButton:   true,
                closeOnConfirm:     true,
            }, function () {
                $.post('<cfoutput>#event.buildLink("EDI.solicitud.cargaProductosSeleccionados")#</cfoutput>', {
                    pkUsuario: <cfoutput>#Session.cbstorage.usuario.PK#</cfoutput>,
                    pkPersona: <cfoutput>#prc.pkPersona#</cfoutput>
                }, function(data){
                    $('#panelInconformidad').toggle("slow");
                    $('#elemSolicitudes').toggle("slow");
                    $('#divInconformidad').html(data);
                });
            });
         });
         $('body').on('click', '.cierraInconformidad', function(){
            abrecierraInconformidad();
        }); 
	});

	$('body').undelegate('.getCartaRelacionLaboral', 'click');
	$('body').on('click', '.getCartaRelacionLaboral', function(){
		<cfoutput>pkPersona = #prc.pkPersona#;</cfoutput>
    	$("#agregarDocto").html('<object data="/index.cfm/EDI/solicitud/getCartaRelacionLaboral?pkPersona='+pkPersona+'&pkMovimiento='+$(this).attr('pkMovimiento')+'" type="application/pdf" width="100%" height="100%"></object>');
    	 mostrarVisor();
    	 if(navigator.userAgent.toLowerCase().indexOf('firefox') > -1){
			window.open("/index.cfm/EDI/solicitud/getCartaRelacionLaboral?pkPersona="+pkPersona+"&pkMovimiento="+$(this).attr('pkMovimiento'));
			cerrarVisor();
		}
	});

	$('body').undelegate('.getReporteResultados', 'click');
	$('body').on('click', '.getReporteResultados', function(){
    	$("#agregarDocto").html('<object data="/index.cfm/EDI/solicitud/getReporteResultados?pkMovimiento='+$(this).attr('pkMovimiento')+'" type="application/pdf" width="100%" height="100%"></object>');
    	 mostrarVisor();
    	 if(navigator.userAgent.toLowerCase().indexOf('firefox') > -1){
			window.open("/index.cfm/EDI/solicitud/getReporteResultados?pkMovimiento="+$(this).attr('pkMovimiento'));
			cerrarVisor();
		}
	});

	function abrecierraSolicitud(){
		$('#panelSolicitud').toggle("slow");
		$('#elemSolicitudes').toggle("slow");
	}
	
	function abrecierraComite(){
        $('#panelComite').toggle("slow");
        $('#elemSolicitudes').toggle("slow");
    }

	function abrecierraInconformidad(){
		swal({
			title:             "&iquest;Salir sin aplicar al recurso de inconformidad?",
			type:              "warning",
			confirmButtonText: "Aceptar",
			cancelButtonText:  "Cancelar",
			showCancelButton:  true,
			closeOnConfirm:    true,
			html:              true
		}, function () {
			$('#panelInconformidad').toggle("slow");
			$('#elemSolicitudes').toggle("slow");
		});
	}

		<!---
    * Fecha : Noviembre de 2017
    * Autor : Marco Torres
    * Comentario: Funcin cambia el estado de la solicitud.
    --->
    function cambiarEstado(accion,pksolicitud) {
    	$.post('<cfoutput>#event.buildLink("EDI.solicitud.cambiarEstado")#</cfoutput>', {
            pkRegistro:    pksolicitud,
            accion:        accion,
            asunto:        '',
            comentario:    '',
            prioridad:     0,
            destinatarios: JSON.stringify([{'vacio':0}]),
            tipoComent:    '<cfoutput>#application.SIIIP_CTES.TIPOCOMENTARIO.CONVENIO#</cfoutput>'
        }, function(data){
            if (data.EXITO){
                toastr.success("exitosamente", "Acción ejecutada");
				location.reload();
            } else if (data.FALLO)
                toastr.error("El registro ya había sido modificado.", "El estado actual es: " + data.MENSAJE);
            else
                toastr.error(data.MENSAJE, "Acción ejecutada erróneamente");
        });
    }

    function cargarDocumento(data){
		var str;
		var patt = /^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{4}|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)$/; //Patron para comprobar que la cadena sea base64
		$('#agregarDocto').html('');
		if(data.match(patt)){ //Si la cadena es base64 insertarla en un objeto 
			str = '<object data="data:application/pdf;base64,'+data+'" type="application/pdf" width="100%" height="100%"></object>';        
		}else{ //Si no, mostrar el error
		 	str = '<div style="display: table; background:#eee; width:100%; height: 100%; overflow: hidden;"><div style="display: table-cell; text-align: center; vertical-align: middle;"><div><span class="fa-stack fa-5x" style=""><i class="fa fa-file-o fa-stack-2x"></i><span class="fa-stack" style="top: 35px;left: -35px;"><i class="fa fa-circle fa-stack-2x text-danger"></i><i class="fa fa-exclamation fa-stack-1x" style="color: #fff;"></i></span></span><h1 style="font-size: 20px;padding-top:20px;">No se ha podido cargar el documento</h1></div></div></div>';
		}
		$("#agregarDocto").html(str);
		mostrarVisor();
  }
    
	function mostrarVisor(){
	    $('.visorDocumentos').remove();
	    $("#contenedorVisorDocumentos").dialog({
	    	height: $(window).height()*0.85,
	    	width : $(window).width()*0.50,
	    	classes:{
	    		"ui-dialog": "visorDocumentos"
	    },
			show: true,
			hide: true,
			minHeight: $(window).height()*0.55,
			minWidth: $(window).width()*0.20,
			close: function(){
				$("#contenedorVisorDocumentos").dialog('option','position',{
					my: "center", 
					at: "center", 
					of: window
				});
				$('#contenedorVisorDocumentos').dialog('destroy');
			}
		});

	    var draggableArguments={      
	    	appendTo: 'body',
	    	containment:'window',
	    	scroll: false                   
	    };

	    $('.ui-dialog').draggable(draggableArguments);

		var html =  '<div class="btn-group pull-right">'+
	    '<span id="visorDocumentos-size" class="btn btn-success btn-sm">'+
	    '<span class="fa fa-window-maximize"></span>'+
	    '</span>'+
	    '<span class="btn btn-danger btn-sm" onclick="cerrarVisor();">'+
	    '<span class="fa fa-times"></span>'+
	    '</span>'+
	    '</div>';

	    $('.visorDocumentos .ui-dialog-titlebar').html(html);       

	    $('#visorDocumentos-size').one('click', maximizarVisor);
	}

	function cerrarVisor(){
	    $("#contenedorVisorDocumentos").dialog('close');        
	}

	function maximizarVisor(){
	    $("#contenedorVisorDocumentos").dialog('option','position',{
	    	my: "center", 
	    	at: "center", 
	    	of: window
	    });

	    $("#contenedorVisorDocumentos").dialog("option","height",$(window).height());
	    $("#contenedorVisorDocumentos").dialog("option","width",$(window).width());
	    $('#visorDocumentos-size').html('<span class="fa fa-window-restore"></span>');      
	    $('#visorDocumentos-size').one('click', restaurarVisor);
	}

	function restaurarVisor(){
	    $("#contenedorVisorDocumentos").dialog('option','position',{
	    	my: "center", 
	    	at: "center", 
	    	of: window
	    });
	    $("#contenedorVisorDocumentos").dialog("option","height",$(window).height()*0.85);
	    $("#contenedorVisorDocumentos").dialog("option","width",$(window).width()*0.50);                
	    $('#visorDocumentos-size').html('<span class="fa fa-window-maximize"></span>');     
	    $('#visorDocumentos-size').one('click', maximizarVisor);
    }

</script>