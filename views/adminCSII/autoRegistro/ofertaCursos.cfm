 <cfprocessingdirective pageEncoding="utf-8">

<div class="row">
    <!--- <div class="col-lg-6">
    	<div class="panel panel-success">
			<div class="panel-heading">
				<h2>CURSOS SICREO</h2>
			</div>
		</div>
		<div class="panel-group" id="accordion1">
			<cfset i = 0> 
			<cfoutput query="prc.sicreo">
	        	<cfset i++>	
			    <div class="panel panel-default">
			        <div class="panel-heading">
			        	<h4 class="panel-title">
			            	<a data-toggle="collapse" data-parent="##accordion1" href="##collapse#pk#">#NOMBRE#</a>
			        	</h4>
			        </div>

			        <cfif #i# EQ 1>
						<div id="collapse#pk#" class="panel-collapse collapse in">
					<cfelse>
						<div id="collapse#pk#" class="panel-collapse collapse">
					</cfif>

				      	<div class="panel-body">
					  		<div class="tabs-container">
					            <ul class="nav nav-tabs">
					                <li class="active"><a data-toggle="tab" href="##tab1-#PK#" aria-expanded="true"> <i class="fa fa-laptop"></i></a></li>
					                <li><a data-toggle="tab" href="##tab2-#PK#" aria-expanded="false"><i class="fa fa-desktop"></i></a></li>
					                <li><a data-toggle="tab" href="##tab3-#PK#" aria-expanded="false"><i class="fa fa-sign-in"></i></a></li>
					            </ul>
					            <div class="tab-content">
					                <div id="tab1-#PK#" class="tab-pane active">
					                    <div class="panel-body"> #DESCRIPCION# </div>
					                </div>
					                <div id="tab2-#PK#" class="tab-pane">
					                    <div class="panel-body"> #OBJETIVO# </div>
					                </div>
					                <div id="tab3-#PK#" class="tab-pane">
					                    <div class="panel-body">
					                    	<a class="btn btn-primary btn-rounded btn-block" onclick="regitraParticipante();"><i class="fa fa-sign-in"></i> Registrate</a>
					                    </div>
					                </div>
					            </div>
					        </div>
				      	</div>
				    </div>
			    </div>
			</cfoutput>
		</div>
    </div> --->

    <div class="col-lg-12">
    	<div class="panel panel-success">
			<div class="panel-heading">
				<h2>CURSOS SISEMEC</h2>
			</div>
		</div>
		<div class="panel-group" id="accordion2">
			<cfset i = 0> 
			<cfset PKs = 0> 
			<cfoutput query="prc.sisemec">
	        	<cfset i++>	
			    <div class="panel panel-default">
			        <div class="panel-heading">
			        	<h4 class="panel-title">
			            	<a data-toggle="collapse" data-parent="##accordion2" href="##collapse#pk#">#NOMBRE#</a>
			        	</h4>
			        </div>

			        <cfif #i# EQ 1>
						<div id="collapse#pk#" class="panel-collapse collapse in">
					<cfelse>
						<div id="collapse#pk#" class="panel-collapse collapse">
					</cfif>

				      	<div class="panel-body">
					  		<div class="tabs-container">
					            <ul class="nav nav-tabs">
					                <li class="active"><a data-toggle="tab" href="##tab1-#PK#" aria-expanded="true"> Descripci&oacute;n</a></li>
					                <li><a data-toggle="tab" href="##tab2-#PK#" aria-expanded="false"> Objetivo General</a></li>
					                <li><a data-toggle="tab" href="##tab3-#PK#" aria-expanded="false"> Datos del Curso</a></li>
					                <li><a data-toggle="tab" href="##tab4-#PK#" aria-expanded="false"> Registro</a></li>
					            </ul>
					            <div class="tab-content">
					                <div id="tab1-#PK#" class="tab-pane active">
					                    <div class="panel-body"> #DESCRIPCION# </div>
					                </div>
					                <div id="tab2-#PK#" class="tab-pane">
					                    <div class="panel-body"> #OBJETIVO# </div>
					                </div>
					                <div id="tab3-#PK#" class="tab-pane">
					                    <div class="panel-body">
					                        <div id="days_#PK#" style="display: none;" class="font-bold">#DIAS#</div>

											<div class="row">
				                                <div class="col-md-4 col-md-offset-3">
				                                    <div id="calendar_#PK#"></div>
				                                </div>
				                                <div class="col-md-5" style="padding-top: 40px;">

													<div class="row">
						                                <div class="col-md-12">
						                                	<h2> Costo IPN: $ #INTERNO#</h2>
						                                </div>
						                            </div>
						                            <div class="row">
						                                <div class="col-md-12">
						                                	<h2> Costo Externo: $ #EXTERNO#</h2>
						                                </div>
						                            </div>

				                                </div>
				                            </div>
											
					                    </div>
					                </div>
					                <div id="tab4-#PK#" class="tab-pane">
					                    <div class="panel-body">
					                        <a class="btn btn-primary btn-rounded btn-block" onclick="regitraParticipante();"><i class="fa fa-sign-in"></i> Registrate</a>
					                    </div>
					                </div>
					            </div>
					        </div>
				      	</div>
				    </div>
			    </div>
			    <cfset PKs = PKs & ',' & pk> 
			    
			</cfoutput>
			<cfoutput>
			<div id="PKs" style="display: none;">#PKs#</div>
			</cfoutput>
		</div>
    </div>

</div>

<script type="text/javascript">
	$(document).ready(function() {
 		<!---
        * Fecha : Agosto de 2017
        * Autor : JLGC
        * Comentario: Pinta calendario con las fechas seleccionadas del Curso
        --->
		var aRegs = $("#PKs").text().split(",");

		<!--- BARREMOS LOS REGISTROS FECHA DEL CURSO--->
		for (var x = 1; x < aRegs.length; x++) {
		    var aFechas = $("#days_" + aRegs[x]).text().split(",");
				
			$("#calendar_" + aRegs[x]).datepicker({
				language:           "es",
	            todayHighlight:     true,
	            daysOfWeekDisabled: "0,1,2,3,4,5,6",
	            startView:          1
			});

			$("#calendar_" + aRegs[x]).datepicker("setDates", aFechas);
		}
	});
</script> 