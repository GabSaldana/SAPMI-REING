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
	 <!---Buscador--->
	 <cfif isDefined('prc.reportes') >
		 <cfloop array="#prc.reportes#" index="rep">
			 <cfoutput>
				 tablas.push({
		             id: "#rep['tabla'].IDTAB#",
		             nombre: "#rep['tabla'].NOMBRE#",
		             descripcion: "#rep['tabla'].DESCRIPCION#"
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
		  <!---
			 *Fecha :19 de Septiembre de 2017
			 *Descripcion: Vista
			 *@author: Alejandro Rosales
	 	 --->$(".reporteConsulta").on("click",function(){
		 	var idRep=$(this).attr("data-tab-id");
		 	var idCon=$(this).attr("data-tab-con");
		 	window.location = "/index.cfm/reportes/administradorReportes/explorarReporte?idRep="+idRep+"&idCon="+idCon;
		 });
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
<style >
	
.reporteConsulta
{
    cursor: pointer;
}

.border-reporte{
	border-radius: 25px;
}

.el-descripcion-reporte{

	padding: 18px;
    padding-top: 10px;
    position: relative;
    border-top-style: solid;
    border-top-width: 1px;
    border-top-color: #FFFFFF;
    height: 135px;
	/*background-color:	rgba(127, 37, 84,0.8);*/
	background-color:	rgba(127, 37, 84,1);
   /*border-radius: 5px;*/
}

.reporteConsulta:hover .el-nombre-rep{

	 color: #E0E0E0;
}
.reporteConsulta:hover .el-cont-desc-reporte{

	 color: #E0E0E0;
}

.reporteConsulta:hover .el-descripcion-reporte{

	background-color:	rgba(127, 37, 84,0.8);

}

.reporteConsulta:hover img{
	opacity: 0.8;
}
.el-cont-desc-reporte{
	overflow:auto;
	height:45px;
	color: #FFFFFF;

}
p {
    word-wrap: break-word;
}

.el-nombre-rep{
	font-size: 19px;
    font-weight: 500;
    color: #FFFFFF;
    display: block;
    margin: 2px 0 5px 0;
    max-height: 70px;
    overflow: auto;
}
.el-descripcion-reporte:hover {
	opacity: 1;
	-webkit-transition: .3s ease-in-out;
	transition: .3s ease-in-out;
}
.el-vista-previa-reporte{
	text-align: center;
    height: 150px;
    background-color: #f8f8f9;
    color: #bebec3;
    overflow: hidden;
}

.el-vista-previa-reporte img{   
    height: 80%;
    top: 2%;
    position: relative;
    opacity: 0.8;
    border-radius: 5px
}
</style>