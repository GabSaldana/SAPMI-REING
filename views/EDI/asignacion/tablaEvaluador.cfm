<cfprocessingdirective pageEncoding="utf-8">
<div class="row">
	<div class="col-md-12">
		<div id="toolbarEvaluador">
			<button id="agregarEvaluador" type="button" class="btn btn-w-m btn-success" data-toggle="modal" href="#mdl-admon-usuario">
	            <i class="fa fa-plus"></i> Agregar Evaluador
	        </button>
	    </div>
		<table id="listaGestionEval" class="table table-striped table-responsive" data-pagination="true" data-page-size="15" data-search="true" data-toolbar="#toolbarEvaluador" data-search-accent-neutralise="true">
			<thead>
				<tr>
					<th data-valign="middle" data-sortable='true' class="col-md-3 text-center" data-field="nombre"><h4>Nombre</h4></th>
					<th data-valign="middle" data-sortable='true' class="col-md-3 text-center" data-field="dep"	><h4>Dependencia</h4></th>
	
					<th class="col-md-2 text-center"  data-field="evalSIP"> Evaluador SIP
						<div class="checkbox checkbox-primary">
							<input id="evalSelectAllSIP" class="styled selectAll" pkTipoEval="1" type="checkbox">
							<label for="evalSelectAllSIP"></label>	
						</div> 
					</th>
					<th class="col-md-2 text-center"	data-field="evalCE" >Evaluador CE
						<div class="checkbox checkbox-primary">
							<input id="evalSelectAllCE" class="styled selectAll" pkTipoEval="2" type="checkbox">
							<label for="evalSelectAllCE"></label>
						</div>
					</th>
					<th class="col-md-2 text-center"	data-field="evalCA" >Evaluador CA
						<div class="checkbox checkbox-primary">
							<input id="evalSelectAllCA" class="styled selectAll" pkTipoEval="3" type="checkbox">
							<label for="evalSelectAllCA"></label>
						</div>
					</th>
				</tr>
			</thead>
		</table>
	</div>
</div>

<script>
	var data = [];
	<cfif isDefined('prc.evaluadores.recordCount')>
		<cfloop index='i' from='1' to='#prc.evaluadores.recordCount#'>
			<cfoutput>
				data.push({
					nombre:		'#prc.evaluadores.NOMBRE[i]# #prc.evaluadores.PATERNO[i]# #prc.evaluadores.MATERNO[i]#',
					dep:		'#prc.evaluadores.DEPENDENCIA[i]#',
					evalSIP:	'<div class="checkbox checkbox-primary"><input id="evalSIP#prc.evaluadores.PKUSUARIO[i]#" class="styled setGestion" type="checkbox" #prc.evaluadores.EVALSIP[i]# pkTipoEval="1" pkUsuario="#prc.evaluadores.PKUSUARIO[i]#"><label for="evalSIP#prc.evaluadores.PKUSUARIO[i]#"></label></div>',
					evalCE:		'<div class="checkbox checkbox-primary"><input id="evalCE#prc.evaluadores.PKUSUARIO[i]#" class="styled setGestion" type="checkbox" #prc.evaluadores.EVALCE[i]# pkTipoEval="2" pkUsuario="#prc.evaluadores.PKUSUARIO[i]#"><label for="evalCE#prc.evaluadores.PKUSUARIO[i]#"></label></div>',
					evalCA:		'<div class="checkbox checkbox-primary"><input id="evalCA#prc.evaluadores.PKUSUARIO[i]#" class="styled setGestion" type="checkbox" #prc.evaluadores.EVALCA[i]# pkTipoEval="3" pkUsuario="#prc.evaluadores.PKUSUARIO[i]#"><label for="evalCA#prc.evaluadores.PKUSUARIO[i]#"></label></div>'
				});
			</cfoutput>
		</cfloop>
	</cfif>

	$(document).ready(function() {
		$("#listaGestionEval").bootstrapTable();
		$('#listaGestionEval').bootstrapTable('load', data);
	});

	$('body').off("click", '.selectAll',);
	$('body').on('click', '.selectAll', function(){
		$('.setGestion[pkTipoEval='+$(this).attr('pkTipoEval')+']').prop('checked', $(this).is(':checked')).change();
	});

	$('body').off("change", '.setGestion',);
	$('body').on('change', '.setGestion', function(){
		var pkCheck		= $(this).attr('id');
		var pkUsuario	= $(this).attr('pkUsuario');
		var pkTipoEval	= $(this).attr('pkTipoEval');
		var estado		= $(this).is(':checked') == true ? 2 : 0;
		var pkProceso	= $('#inProceso').val();
		$.post('<cfoutput>#event.buildLink("EDI.asignacionEvaluadores.setTipoEvaluador")#</cfoutput>',{
			pkUsuario:	pkUsuario,
			pkTipoEval:	pkTipoEval,
			pkProceso:	pkProceso,
			estado:		estado
		}, function(data){
			if(data != 0){
				toastr.success('Registro actualizado correctamente.');
			} else{
				toastr.error('Problemas al actualizar el registro.');
				$('#'+pkCheck).prop('checked', estado == 0 ? true: false);
			}
		});
	});
</script>