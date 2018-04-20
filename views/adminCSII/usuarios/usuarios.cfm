<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="usuarios_js.cfm">

<style>
    .select2-container--default .select2-selection--single,
    .select2-container--default .select2-selection--multiple {
        border-color: #e7eaec;
    }
    .select2-container--default.select2-container--focus .select2-selection--single,
    .select2-container--default.select2-container--focus .select2-selection--multiple {
        border-color: #1ab394;
    }
    .select2-container--default .select2-results__option--highlighted[aria-selected] {
        background-color: #1ab394;
    }
    .select2-container--default .select2-search--dropdown .select2-search__field {
        border-color: #e7eaec;
    }
    .select2-dropdown {
        border-color: #e7eaec;
    }
    .select2-dropdown input:focus {
        outline: none;
    }
    .select2-selection {
        outline: none;
    }
    .ui-select-container.ui-select-bootstrap .ui-select-choices-row.active > a {
        background-color: #1ab394;
    }
    .select2-selection{
        border-radius: 1px !important;
        border: 1px solid #e5e6e7 !important;		
        height: 100% !important;
    }
    .select2-container--default .select2-selection--single .select2-selection__rendered {
        color: #444;
        line-height: 1.42857143 !important;
    }.select2-container{
        z-index: 999999;
    }
</style>

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Administración de usuarios</h2>
        <ol class="breadcrumb">
            <cfoutput>
                <li>
                    <a href="#event.buildLink('inicio')#">Inicio</a>
                </li>
                <li class="active">
                    <strong>Administración de usuarios</strong>
                </li>
            </cfoutput>
        </ol>
    </div>
</div>


<button onclick="operacionArchivos();">Mig Arch Eval</button>
<button onclick="archivosHumanos();">Mig Arch Capi</button> 
<button onclick="operacionDisenoRedisenoProgramas();">Mig operacionDisenoRedisenoProgramas</button>   


<div class="wrapper wrapper-content animated fadeIn">
    
    <div class="ibox float-e-margins">
        <div class="ibox-title listaUsuarios">
            <h5>USUARIOS REGISTRADOS</h5>
            <div class="ibox-tools">
            </div>
        </div>
        <div class="ibox-content">
            <div class="lft-btn text-left">
                <button type="button" class="btn btn-primary btn-outline dim btn-crear" data-toggle="modal" href="#mdl-admon-usuario"><span class="glyphicon glyphicon-plus"></span> AGREGAR USUARIO</button>
            </div>
            <div id="usuarios"></div>
        </div>
    </div>

</div>

<!--- Modal (AGREGAR/EDITAR)--->
<div id="mdl-admon-usuario" class="modal inmodal fade modaltext" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
                <form id="validaUsuario" class="form-horizontal" role="form" onsubmit="return false;">
                        <h3> Datos personales</h3>
                        <div>
                            <label class="control-label">Nombre</label>
                            <div class="input-group">                           
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>                     
                                <input type="text" id="inNombre" name="inNombre" class="form-control" placeholder="Ingresar nombre"  />
                            </div>                    
                        </div>
                        <div>
                            <label class="control-label">Apellido Paterno</label>
                            <div class="input-group">   
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>                                                 
                                <input type="text" id="inPaterno" name="inPaterno" class="form-control" placeholder="Ingresar apellido paterno" />
                            </div>                    
                        </div>
                        <div>
                            <label class="control-label">Apellido Materno</label>
                            <div class="input-group">  
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>                                                 
                                <input type="text" id="inMaterno" name="inMaterno" class="form-control" placeholder="Ingresar apellido materno" />
                            </div>                   
                        </div>
                        <div>
                            <label class="control-label">Género</label><br>
                            <div class="radio radio-primary radio-inline">
                                <input type="radio" id="opcM" value="1" name="inGenero" checked="checked"><label for="opcM"><i class="fa fa-lg fa-male"></i> Masculino</label>
                            </div>
                            <div class="radio radio-primary radio-inline">
                                <input type="radio" id="opcF" value="2" name="inGenero"><label for="opcF"><i class="fa fa-lg fa-female"></i> Femenino</label>
                            </div>
                        </div>
                        <hr>
                        <h3> Datos institucionales</h3>
                        <div class="row">
                            <div class="col-sm-8">
                                <label style="text-align:right;" class="control-label">Unidad Responsable</label>  
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-tags"></span>
                                    </span>                     
                                    <select id="inUr" name="inUr" class="form-control" style="width: 100%">     
                                        <option value="" selected="selected" disabled>Seleccionar UR</option>                                                                      
                                    </select>
                                </div>                     
                            </div>
                            <div class="col-sm-4">
                                <label style="text-align:right;" class="control-label">Acrónimo</label>  
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-tags"></span>
                                    </span>                     
                                    <select id="inAcr" name="inAcr" class="form-control" style="width: 100%">     
                                        <option value="" selected="selected">Seleccionar acrónimo</option>
                                        <cfset total_records = Request.acron.recordcount/>
                                        <cfloop index="x" from="1" to="#total_records#">
                                            <cfoutput><option value="#Request.acron.PK[x]#" >#Request.acron.ACRONIM[x]#</option></cfoutput>    
                                        </cfloop>               
                                    </select>
                                </div>                     
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <label class="control-label">Teléfono</label>
                                <div class="input-group">   
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-earphone"></span>
                                    </span>                                                                         
                                    <input type="text" name="inTel" class="form-control" id="inTel" placeholder="Ingresar teléfono"  />
                                </div>                     
                            </div>
                            <div class="col-sm-6">
                                <label class="control-label">Extensión</label>
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-option-horizontal"></span>
                                    </span>                        
                                    <input type="text" id="inExt" name="inExt" class="form-control" maxlength="5" placeholder="Ingresar extensión"  />
                                </div>                     
                            </div>
                        </div>
                        <div>
                          <label class="control-label">Correo Electrónico</label>
                          <div class="input-group">
                             <span class="input-group-addon">
                                <span class="glyphicon glyphicon-envelope"></span>
                             </span>
                             <input type="email" name="inEmail" class="form-control"  id="inEmail" placeholder="Ingresar correo electrónico" />
                          </div>
                        </div>
                        <hr>
                        <h3> Cuenta de usuario</h3>
                        <div class="row">
                            <div class="col-sm-6">
                                    <label style="text-align:right;" class="control-label">Rol</label>  
                                    <div class="input-group ">                           
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-tags"></span>
                                        </span>                     
                                        <select id="inRol" name="inRol" class="form-control" style="width: 100%">
                                            <option value="" selected="selected">Seleccionar rol</option>
                                            <cfset total_records = Request.rol.recordcount/>
                                            <cfloop index="x" from="1" to="#total_records#">
                                            	<cfif Session.cbstorage.usuario.ROL NEQ application.SIIIP_CTES.ADMSIS>
                                            		<cfif NOT arrayFind(application.SIIIP_CTES.FILTRO_ROLES, Request.rol.CVE[x])>
                                            			<cfoutput><option value="#Request.rol.CVE[x]#" >#Request.rol.ROL[x]#</option></cfoutput>    
                                            		</cfif>                                            		
                                          		<cfelse>
                                          			<cfoutput><option value="#Request.rol.CVE[x]#" >#Request.rol.ROL[x]#</option></cfoutput>
                                            	</cfif>                                            		
                                            </cfloop>
                                        </select>
                                    </div>
                            </div>

                            <div class="col-sm-6">
                                    <label class="control-label">Nombre de usuario</label>
                                    <div class="input-group">                           
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-user"></span>
                                        </span>
                                        <span class="input-group-addon" id="inPref" style="width:52px"></span>
                                        <input class="form-control" style="text-transform:uppercase;" type="text" id="inUser" name="inUser">
                                        
                                    </div>
                                        <p class="text-small" <!--- style="margin-left: 40px;" --->>Nombre de usuario sugerido por el sistema.</p>
                            </div>
                        </div>
                        
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cancelar</button>
                <button type="button" class="btn btn-success btn-lg pull-right" id="btn-admon-usr"></button>
            </div>
        </div>
    </div>
</div>

<!-- ELIMINAR/VALIDAR/CANCELAR USUARIOS -->
<div class="modal inmodal fade modaltext" id="mdl-estado-usuario" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog <!--- modal-sm --->">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Eliminar usuario</h4>
            </div>
            <div class="modal-body"></div>

            <div class="modal-footer ">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> No</button>
                <button class="btn btn-success btn-lg pull-right" id="btn-estado-usr"><span class="fa fa-check"></span> Sí</button>           
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var obj = <cfoutput>#Request.ur#</cfoutput>,
    keys = Object.keys(obj),
    len = keys.length;
    keys.sort();       
    for(i in keys){
        var clasif = document.createElement("optgroup");
        clasif.label = keys[i];        
        $.each(obj[keys[i]], function(index, val) {
            var dependencia = document.createElement("option");
            dependencia.value = val.CLAVE;
            dependencia.text = val.NOMBRE;
            clasif.append(dependencia);            
        });
        $('#inUr').append(clasif);
    }        
</script>
