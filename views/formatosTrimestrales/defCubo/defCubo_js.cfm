﻿﻿<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

    $(document).ready(function() {

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

        $("#bx-addClasificacion").hide();
        $('#box-formatosRegistrados').hide();
        $('#box-clasificacion').hide();
        $('#box-vista-cubo').hide();
        getClasificaciones();
    });


    <!---
    * Fecha: Junio 2017
    * Autor: Ana Belem Juarez Mendez
    * Descripcion: Valida que el tamaño de algunos input sea a lo sumo de 27. 
    * --->
	function validarInput(texto) {
	var tamanio;
	var letra;
	var contenido = "";
	var expreg;	
		for (var i=0;i<texto.val().length;i++){ 
			letra = texto.val().charAt(i);
			if ((letra==" ")||(letra=='\n')){
				contenido = contenido.concat("_");
			} else{
				contenido = contenido.concat(texto.val().charAt(i));
			}
		}
		texto.val(contenido);	
		contenido = texto.val();
  		expreg = /^[a-zA-Z\d_]*$/;  			
  		if(expreg.test(contenido)){
			tamanio = texto.val().length;	
			if ( tamanio == 0 ) {
				alert('Inserta un nombre');
  				return false;
			} else if(tamanio > 27){
				alert('El número de letras debe ser menor 28');
  				<!--- $(texto).after("<p style='color:red'>El número de caracteres debe ser mayor a 0 y menor o igual a 27</p>"); --->
  				return false;
			} else {				
				return true; 	
			}
  		} else{
  			alert("El texto no acepta caracteres especiales ('^}{*+?¿=><)");
  			return false;
  		}
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Obtiene la tabla de los formatos validados
    * --->
    function getClasificaciones(){
        $('.skin-4').removeAttr('style');
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.getClasificaciones")#</cfoutput>',{
            },
            function(data){
                $('#tablaFormatos').html(data);
            }
        );
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Obtiene la tabla de los formatos validados
    * --->
    function verifClasif(pkFormato){
        $("#pkFormato").val(pkFormato);
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.existeClasificacion")#</cfoutput>',{
                pkFormato: pkFormato
            },
            function(data){
                // data == 0 ? $("#mdl-Add-cubo").modal() : getPkCubo();
                getPkCubo();
            }
        );
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Obtiene la pk del cubo.
    * --->
    function getPkCubo(){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.getPkCubo")#</cfoutput>',{
                pkFormato: $("#pkFormato").val()
            },
            function(data){
                if (data.ROWCOUNT > 1){
                    getTablaCubos($("#pkFormato").val());
                }else if (data.ROWCOUNT == 1){
                    getEncabezado(data.DATA.PKCUBO[0]);
                }
            }
        );
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Obtiene la tabla de cubos asociados a un formato.
    * --->
    function getTablaCubos(pkFormato){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.getTablaCubos")#</cfoutput>',{
                pkFormato: pkFormato
            },
            function(data){
                $("#mdl-cubos-reg").modal();
                $("#mdl-cubos-reg .modal-body").html(data);
            }
        );
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Oculta todas las secciones, menos la tabla de los formatos
    * --->
    function getEncabezado(pkCubo){
        $('.skin-4').removeAttr('style');
        $("#mdl-cubos-reg").modal('hide');
        $("#pkCubo").val(pkCubo);
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.cargaEncabezado")#</cfoutput>',{
                formato: $("#pkFormato").val()
            },
            function(data){
                $('#box-general').hide();
                $('#box-formatosRegistrados').show();
                $('#box-vista-cubo').show();
                $('#encabezado').html(data);
                obtenerDefinicion(pkCubo);
                obtenerOpciones(pkCubo);
            }
        );
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Guarda el nombre del cubo
	* -------------------------------
    * Descripcion de la modificacion: Modificación para generar automáticamente el prefijo del cubo.
    * Fecha de la modificacion: 23/05/2017
    * Autor de la modificacion: Ana Belem Juarez Mendez
	* -------------------------------
    * --->
    function guardaCubo(){
    	var prefCubo = $("#nombreCubo").val().substring(0, 3);
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.guardaCubo")#</cfoutput>',{
                nombreCubo:  $("#nombreCubo").val(),
                prefijoCubo: prefCubo,
                pkFormato:   $("#pkFormato").val()
            },
            function(data){
                if (data > 0){
                    toastr.success('Guardado exitosamente', 'Cubo');
                    $("#mdl-Add-cubo").modal('hide');
                    getEncabezado(data);
                }
            }
        );
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Oculta todas las secciones, menos la tabla de los formatos
    * --->
    function muestraFotmatos(){
        $('#box-general').show();
        $('#box-formatosRegistrados').hide();
        $('#box-clasificacion').hide();
        $("#bx-addClasificacion").hide();
        $('#box-vista-cubo').hide();
        $('#constCubo').empty();
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Obtiene la vista para agregar hechos y dimensiones.
    * --->
    function obtenerOpciones(pkCubo){
        $('#box-clasificacion').show();
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.getOpcionesClasificacion")#</cfoutput>',{
                pkCubo: pkCubo
            },
            function(data){
                $('#clasificaciones').html(data);
            }
        );
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Obtiene la definicion del cubo (dimensiones y hechos).
    * --->
    function obtenerDefinicion(pkCubo){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.getDefinicionCubo")#</cfoutput>',{
                pkCubo: pkCubo
            },
            function(data){
                $('#definicion').html(data);
            }
        );
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Guarda el nombre de la dimension.
	* -------------------------------
    * Descripcion de la modificacion: Modificación para crear la columna NOMBRE para cada dimension generada.
	*								  Además se modificó "$('#addDimensiones .list-group').append" para que 
	*									se pueda visualizar la columna creada. 
	*								  Modificación para generar automáticamente el prefijo de la dimensión.
    * Fecha de la modificacion: 23/05/2017
    * Autor de la modificacion: Ana Belem Juarez Mendez
	* -------------------------------
    * --->
    function guardaDimension(){   
     if(validarInput($("#nombreDimen"))){
     	var prefijoDim =  $("#nombreDimen").val().substring(0,3);
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.guardaDimension")#</cfoutput>',{
                nombreDimen:    $("#nombreDimen").val(),
                prefijoDimen:   prefijoDim
            },
            function(data){
                if (data > 0){
                    toastr.success('guardada exitosamente', 'Dimensión');
					guardaColumna("NOMBRE", "VARCHAR2", "", data);
                    $('#addDimensiones .list-group').append('<a id="'+data+'" name="'+$("#nombreDimen").val()+'" onclick="getcolumasDimensionAdd(this);"><div class="list-group-item clearfix"><span>'+ $("#nombreDimen").val() +'</span><span class="pull-right"><button class="btn btn-xs btn-danger borrar delDim" onclick="verificarAsociacionDimension('+ data +');"><span class="fa fa-trash"></span></button></span></div></a>');                  
                    $('#inDimension').append('<option value="' + data + '" >'+ $("#nombreDimen").val() +'</option>');
                    $('#inDimensionUpdate').append('<option value="' + data + '" >'+ $("#nombreDimen").val() +'</option>');
                    getcolumasDimension();
                    getcolumasDimensionUpdate();
                    getcolumasDimensionAdd();
                    $("#mdl-Add-dimen").modal('hide');                  
                    asociaDimCub(data);               
                }
            }
        );	
     } 	  	
    }

	<!---
    * Fecha: Mayo 2017
    * Autor: Ana Belem Juarez Mendez
    * Descripcion: Guarda columna asociada a una dimensión.
    * --->
    function guardaColumna(nombreColum, tipoColum, desColum, pkDim){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.guardaColDim")#</cfoutput>',{
                nombreCol: nombreColum,
                tipoCol:   tipoColum,
                descrCol:  desColum,
                pkDimens:  pkDim
            },
            function(data){
                if (data > 0){
                    toastr.success('guardada exitosamente.', 'Columna');	
                }
                else{
                	toastr.success('Error al guardar la columna.', 'Columna');	
                }
            }
        );
    }
	

    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Asocia una dimension creada.
    * --->
    function asociaDimCub(pkDimension){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.asociaDimensionCubo")#</cfoutput>',{
                pkDimension: pkDimension,
                pkCubo: $("#pkCubo").val()
            },
            function(data){
                if(data > 0){
                    toastr.success('asociada exitosamente', 'Dimensión');
                }
            }
        );
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Establece como creado el registro del cubo.
    * --->
    function validaCubo(){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.validaCubo")#</cfoutput>',{
                pkCubo: $("#pkCubo").val()
            },
            function(data){
                toastr.success('Cubo validado exitosamente');
                obtenerDefinicion($("#pkCubo").val());
            }
        );
    }


    <!---
    * Fecha: Abril 2017
    * Autor: Alejandro Tovar
    * Descripcion: Muestra la seccion para agregar clasificaciones.
    * --->
    function agregaClasificacion(){
        $("#box-general").hide();
        $("#bx-addClasificacion").show();
    }


    <!---
    * Fecha: Abril 2017
    * Autor: Alejandro Tovar
    * Descripcion: Agrega una clasificacion.
    * --->
    function addClasif(){
        if( ($("#fmtClasif").val() != 0) && ($("#cubeClasif").val() != 0) ){
            $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.asociaFormatoCubo")#</cfoutput>',{
                    pkFormato: $("#fmtClasif").val(),
                    pkCubo:    $("#cubeClasif").val()
                },
                function(data){
                    if(data >= 0){
                    	if (data>0)
                        	toastr.success('', 'Clasificación agregada exitosamente.');
                        else
                        	toastr.warning('', 'La clasificación ya había sido agregada.');	
                        $("#box-general").show();
                        $("#bx-addClasificacion").hide();
                        $("#fmtClasif").val('0');
                        $("#cubeClasif").val('0');
                        getClasificaciones();
                    } 
                }
            );
        }
    }


    <!---
    * Fecha: Abril 2017
    * Autor: Alejandro Tovar
    * Descripcion: Guarda el nombre del cubo
	* -------------------------------
    * Descripcion de la modificacion: Modificación para generar automáticamente el prefijo del cubo.
    * Fecha de la modificacion: 23/05/2017
    * Autor de la modificacion: Ana Belem Juarez Mendez
	* -------------------------------
    * --->
    function saveCube(){
        if( validarInput($("#nameCube")) ){     
        		var prefCube = $("#nameCube").val().substring(0, 3);
                $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.saveCube")#</cfoutput>',{
                        nombreCubo:  $("#nameCube").val(),
                        prefijoCubo: prefCube
                    },
                    function(data){
                        if (data > 0){
                            toastr.success('Guardado exitosamente', 'Cubo');
                            $("#cubeClasif").append($("<option></option>").attr("value",data).attr("selected",'selected').text($("#nameCube").val()));
                            $("#nameCube").val('');
                            $("#AddCubeClasif").modal('hide');
                        }
                    }
                );              
        }
    }

	
<!---
    * Fecha: Abril 2017
    * Autor: Ana Belem Juárez
    * Descripcion: Realiza un pre analisis del encabezado del formato. 
				   El pre analisis es respecto a su cubo correspondiente.
    * --->
	function AnalisisAutomatico(){
		 $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.getAnalisisAutomatico")#</cfoutput>', {
			 pkCubo:    $("#pkCubo").val(),    
             pkFormato: $("#pkFormato").val() 
		},
		function(data){		
			if (data == 0){
				 toastr.error('Error al realizar el análisis automático.', 'Análisis automático');
			}	
			else if(data==1){
				 toastr.info('El análisis automático de este formato ya se ha realizado antes.', 'Análisis automático');
			}
			else{
			 toastr.success('Análisis automático exitoso.', 'Análisis automático');    
             var res =  data.split(",");
             var res1;
             for(var i in res){
             	res1 = res[i].replace(" ","");
             	if (res1.length != 0)
             	{
             		document.getElementById(res1).setAttribute("class","amarillo");
             		document.getElementById(res1).setAttribute("panal","1");
             	}
             	
             }                                         
              obtenerDefinicion($("#pkCubo").val());
               obtenerOpciones($("#pkCubo").val());  
			}
		}
		);	
	}


    <!---
    * Fecha: Abril 2017
    * Autor: Alejandro Tovar
    * Descripcion: Obtiene la vista previa de los datos del cubo.
    * --->
    function getPreview(){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.getPreview")#</cfoutput>',{
                pkCubo:    $("#pkCubo").val(),    
                pkFormato: $("#pkFormato").val()                
            },
            function(data){
                $('#constCubo').html(data);
            }
        );
    }


    <!---
    * Fecha: Abril 2017
    * Autor: Alejandro Tovar
    * Descripcion: Crea la vista en la base de datos, y regresa una vista previa de la misma.
    * --->
    function createView(){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.creaVistaBD")#</cfoutput>',{
                pkCubo:    $("#pkCubo").val(),
            },
            function(data){
                if(data.includes("V_EXTRACCION")){
                    toastr.success('Creada exitosamente', 'Vista');
                    getPreview();
                    cargaMetadatos();                  
                }else{
                    toastr.error('al generar vista', 'Error');
                }
            }
        );
    }


    <!---
    * Fecha: Abril 2017
    * Autor: Alejandro Tovar
    * Descripcion: Replica la clasificacion del encabezado, en caso de ser formato contenedor.
	* -------------------------------
    * Descripcion de la modificacion: Modificación para generar la vista general despues de realizar la replica.
    * Fecha de la modificacion: 23/05/2017
    * Autor de la modificacion: Ana Belem Juarez Mendez
	* -------------------------------
    * --->
    function replicaClasificacion(){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.replicaClasificacion")#</cfoutput>',{ 
                pkFormato: $("#pkFormato").val(),
                pkCubo:    $("#pkCubo").val()
            },
            function(data){          
                if(data > 0){
                    toastr.success('replicada exitosamente', 'Clasificación');
                    muestraFotmatos();
                    getClasificaciones();
                    createView();
                }else if(data == 0){
                    toastr.warning('', 'El formato seleccionado no es contenedor o no tiene formatos asociados');
                    createView();
                } else if(data == -1){
                    toastr.warning('', 'La replica del formato seleccionado ya fue realizada');
                    createView();
                }else{
                	toastr.error('Error al realizar la replica', 'Clasificación');	
                }
                
                
            }
        );
    }


    <!---
    * Fecha: Abril 2017
    * Autor: Alejandro Tovar
    * Descripcion: Hace la carga de metadatos.
	* -------------------------------
    * Descripcion de la modificacion: Modificación para indicar si los metadatos del cubo ya fueron cargados.
    * Fecha de la modificacion: 24/05/2017
    * Autor de la modificacion: Ana Belem Juarez Mendez
	* -------------------------------
    * --->
    function cargaMetadatos(){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.cargaMetadatos")#</cfoutput>',{
                pkCubo: $("#pkCubo").val()
            },
            function(data){
                if (data == 1){
                    toastr.success('cargados exitosamente', 'Metadatos');
                }else if (data == 2){
                	toastr.warning('Los metadatos de este cubo ya fueron cargados', 'Metadatos');
                }else{
                    toastr.error('al cargar metadatos', 'Error');
                }
            }
        );
    }


</script>


