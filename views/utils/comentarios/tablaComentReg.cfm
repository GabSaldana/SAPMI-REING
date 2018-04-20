<cfprocessingdirective pageEncoding="utf-8">

<div class="modal-content">
    <div>
        <div class="mail-box-header">
            <div class="input-group pull-right mail-search">
                <input class="form-control input-sm" name="Buscar" placeholder="Buscar comentario" type="text">
                <div class="input-group-btn">
                    <button type="submit" class="btn btn-sm btn-primary">
                        Buscar
                    </button>
                </div>
            </div>
            <h2 id="titulo">
                Comentarios
            </h2>
            <div class="mail-tools tooltip-demo m-t-md">
                <div class="btn-group pull-right atras" style='display:none;'>
                    <button class="btn btn-white btn-sm" onclick="consultarComentario();"><i class="fa fa-arrow-left"></i></button>
                </div>
            </div>
        </div>
        <div class="space-25"></div>
        <div class="space-25"></div>
        <div class="space-25"></div>
        <div class="space-25"></div>
        
        <div class="mail-box mail-comentarios">
            <table id="tabla_comenReg" class="table table-hover table-mail">
                <tbody>
                    <cfoutput query="prc.coment">
                        <tr class="unread" onclick="contentComent(#COMENT_PK#);">
                            <td>
                                <label class="btn btn-primary btn-xs">
                                    <input type="checkbox" value="#COMENT_PK#">
                                </label>
                            </td>
                            <td class="mail-contact"><a>#NOMBRE# / #NOMBREROL#</a>
                                <cfif #COMENT_PRIOR# eq 1>
                                    <span class="label label-danger pull-right">!</span>
                                </cfif>
                            </td>
                            <td><a>#COMENT_ASUNTO#</a></td>
                            <td class="text-right mail-date">#COMENT_FECHA#</td>
                        </tr>
                    </cfoutput>
                </tbody>
            </table>
        </div>

        <div class="mail-box mail-contenido" style="margin-left: 50px; margin-right: 50px; margin-top: 5px; word-wrap: break-word;"></div>

    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
    </div>
</div>


<script type="text/javascript">

    $(document).ready(function(){
        $("#tabla_comenReg").bootstrapTable();
    });

</script>