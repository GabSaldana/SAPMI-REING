<cfprocessingdirective pageEncoding="utf-8">

    <div class="col-lg-10 animated fadeInRight"> 
        <div class="mail-box-header">
            <div class="input-group pull-right mail-search">
                <input class="form-control input-sm" name="search" placeholder="Buscar comentario" type="text">
                <div class="input-group-btn">
                    <button type="submit" class="btn btn-sm btn-primary">Buscar</button>
                </div>
            </div>
            <h2> Comentarios (<cfoutput>#prc.noVistos.REL_NOVISTO#</cfoutput>) </h2>
            <div class="mail-tools tooltip-demo m-t-md">
                <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-primary">
                        <input type="radio" name="filtro" value="0" onchange="consultarComentarios();"><span class="fa fa-eye-slash"></span>
                    </label>
                    <label class="btn btn-primary">
                        <input type="radio" name="filtro" value="2" onchange="consultarComentarios();" id="inTodos"><span class="fa fa-bullseye"></span>
                    </label>
                    <label class="btn btn-primary ml5">
                        <input type="radio" name="filtro" value="1" onchange="consultarComentarios();"><span class="fa fa-eye ml5"></span>
                    </label>
                    <label class="btn btn-primary ml5">
                        <input type="checkbox" id="filtImportant" onchange="soloImportantes();"> <span class="fa fa-exclamation ml5">
                    </label>
                </div>
            </div>
        </div>

        <div class="mail-box">
            <table id="tabla_comentarios" class="table table-hover table-mail">
                <tbody>
                    <cfoutput query="prc.comentUsu">
                        <cfif #REL_VISTO# EQ 0>
                            <tr class="unread" onclick="comentByUsuarioUnread(#COMENT_PK#, #REL_PK#);">
                        <cfelse>
                            <tr class="read" onclick="comentByUsuarioRead(#COMENT_PK#);">
                        </cfif>
                            <td align="center">
                                <label class="btn btn-primary btn-xs">
                                    <input type="checkbox" value="#COMENT_PK#">
                                </label>
                            </td>
                            <td class="mail-contact"> <a>#NOMBRE# / #NOMBREROL#</a>
                                <cfif #COMENT_PRIOR# eq 1>
                                    <span class="label label-danger pull-right importante">!</span>
                                <cfelse>
                                    <span class="pull-right normal"></span>
                                </cfif>
                            </td>
                            <td><a>#EDO_NOMBRE#</a></td>
                            <td class="text-right mail-date">#COMENT_FECHA#</td>
                        </tr>
                    </cfoutput>
                </tbody>
            </table>
        </div>
        <div id="subject" class="hide"><h2> Comentarios </h2></div>
        <div class="mail-content" style="margin-left: 40px; margin-right: 40px; margin-top: 50px; word-wrap: break-word;"> </div>
    </div>


<script type="text/javascript">

    $(document).ready(function(){
        $("#tabla_comentarios").bootstrapTable();
    });

</script>