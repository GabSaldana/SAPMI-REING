<!---
* ================================
* IPN � CSII
* Sistema: SII
* Modulo: Tablas Dinamicas
* Sub modulo: Administrador de Tablas
* Fecha 23 de Marzo  de 2017
* Descripcion:
* Script correspondiente a la vista del administrador de tablas asociadas a un conjunto
* Autor:Jonathan Martinez
* ================================
--->
 <cfprocessingdirective pageEncoding="utf-8">
 <cfoutput>
	 <script type="text/javascript">
	 var tablas = [];
	 var tablasC = [];
	 <!---Buscador--->
	 <cfif isDefined('prc.tablas') >
		 <cfloop array="#prc.tablas#" index="rep">
			 <cfoutput>
				 tablas.push({
		             id: "#rep['tabla'].IDTAB#",
		             nombre: "#rep['tabla'].NOMBRE#",
		             descripcion: "#rep['tabla'].DESCRIPCION#",
		         });
			 </cfoutput>
		 </cfloop>
	 </cfif>
	 <cfif isDefined('prc.tablasC') >
		 <cfloop array="#prc.tablasC#" index="rep">
			 <cfoutput>
				 tablasC.push({
		             id: "#rep['tabla'].IDTAB#",
		             nombre: "#rep['tabla'].NOMBRE#",
		             descripcion: "#rep['tabla'].DESCRIPCION#",
		         });
			 </cfoutput>
		 </cfloop>
	 </cfif>
	 $(document).ready(function() {
		 <!---Define la configuracion  para el plugin toastr encargado de las alertas para el usuario--->
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
		     "timeOut": "4000",
		     "extendedTimeOut": "2000",
		     "showEasing": "swing",
		     "hideEasing": "linear",
		     "showMethod": "fadeIn",
		     "hideMethod": "fadeOut"
		 };
		 <!---Agrega al funcionalidad asociada con el evento de click para el elemento encargado de eliminar una Tabla--->
		 $("##contenido").on("click","[data-tab-id] .el-eliminar",
			 function (){
				 var elemento=$(this).closest("[data-tab-id]");
				 var id=elemento.attr("data-tab-id");
				 $.post('#event.buildLink("tablasDinamicas.administradorTablas.eliminarTabla")#',
				     {idTab:id},
				 function(data){
					 if (data > 0){
					     var padre=elemento.parent();
					     padre.addClass("animated fadeOutUp");
					     toastr.success('Eliminada exitosamente','Tabla');
					     padre.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',
							 function(e) {
								 padre.remove();
					         }
						 );
					 }
				 });
			 }
		 );
		 $("##contenido").on("click","[data-tab-id] .el-eliminar-compartido",
			 function (){
				 var elemento=$(this).closest("[data-tab-id]");
				 var id=elemento.attr("data-tab-id");
				 $.post('#event.buildLink("tablasDinamicas.administradorTablas.eliminarTablaC")#',
				     {idTab:id},
				 function(data){
					 if (data > 0){
					     var padre=elemento.parent();
					     padre.addClass("animated fadeOutUp");
					     toastr.success('Eliminada exitosamente','Tabla');
					     padre.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',
							 function(e) {
								 padre.remove();
					         }
						 );
					 }
				 }
				 );
			 }
		 );
		 $("##contenido").on("click",".el-copiar-rep",
			 function (){
				 var elemento=$(this).closest("[data-tab-id]");
				 var id=elemento.attr("data-tab-id");
				 $.post('#event.buildLink("tablasDinamicas.administradorTablas.copiarTabla")#',
				     {idTab:id,idCon:$("[data-con-id]").attr("data-con-id")},
				 function(data){
					 $("##tablas").after( data );
				         toastr.success('Copiada exitosamente','Tabla');
				 });
			 }
		 );
		 $("##contenido").on("click",".el-publicar",
			 function (){
				 var elemento=$(this).closest("[data-tab-id]");
				 var id=elemento.attr("data-tab-id");
				 $.post('#event.buildLink("tablasDinamicas.administradorTablas.obtenerUsuariosAutorizados")#',
				     {idCon:$("[data-con-id]").attr("data-con-id"),idTab:id},
				 function(data){
					 $('##listaUsuarios').modal('toggle');
					 $("##listaUsuarios .modal-body").attr("data-rep-id",id);
	                 $("##listaUsuarios .modal-body").html( data );
				 });
			 }
		 );
		 $("##btnCompartir").click(
			 function(event){
			     var idUsr = "";
				 var listaUsuarios = $('##tabla_share_User').bootstrapTable('getSelections');
				 for(var i=0; i < listaUsuarios.length; i++){
					 if(i == (listaUsuarios.length-1))
					 	 idUsr=idUsr+listaUsuarios[i].id;
					 else
					 	 idUsr=idUsr+listaUsuarios[i].id+",";
				 }
				 $.post('#event.buildLink("tablasDinamicas.administradorTablas.compartirTabla")#',
				     {idTab:$("##listaUsuarios .modal-body").attr("data-rep-id"),usuarios:idUsr},
				 function(data){           
				     if(data===true){
				         $('##listaUsuarios').modal('toggle');
	               		 $("##listaUsuarios .modal-body").html( data );
	               		 toastr.success('Compartida exitosamente','Tabla');
				     }
				 });
		     }
		 );
		 <!---
			 *Fecha :23 de Marzo de 2017
			 *Descripcion: Funciones para implementar el buscador
			 *@author: Jonathan Martinez
	 	 --->
		 $("##BuscarTablas").keyup(
			 function(event){
				 for(var i=0 ; i < tablas.length ; i++){
					 var titulo = tablas[i].nombre.toLowerCase();
					 if(titulo.indexOf(this.value.toLowerCase()) != -1)
						 $("##"+tablas[i].id+"").css("display","block");
					 else
						 $("##"+tablas[i].id+"").css("display","none");
				 }
			 }
		 );
		 $("##BuscarTablasC").keyup(
			 function(event){
				 for(var i=0 ; i < tablasC.length ; i++){
					 var titulo = tablasC[i].nombre.toLowerCase();
					 if(titulo.indexOf(this.value.toLowerCase()) != -1)
						 $("##"+tablasC[i].id+"").css("display","block");
					 else
						 $("##"+tablasC[i].id+"").css("display","none");
				 }
			 }
		 );
	 });
	 </script>
 </cfoutput>