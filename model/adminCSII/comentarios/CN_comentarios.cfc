<cfcomponent>
    <cfproperty name="DAO" inject="adminCSII.comentarios.DAO_comentarios">


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene los comentarios dirigidos al usuario.
    ---> 
    <cffunction name="getComentariosByUsuario" hint="Obtiene los comentarios dirigidos al usuario.">
        <cfargument name="pkUsuario"    type="numeric" required="yes" hint="pk del usuario">
        <cfargument name="filtro"       type="numeric" required="yes" hint="valor del filtro">
        <cfargument name="pkTipoComent" type="numeric" required="yes" hint="pk del tipo de comentario">
        <cfscript>
            return DAO.getComentariosByUsuario(pkUsuario, filtro, pkTipoComent);
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que registra un comentario al realizar una accion.
    --->
    <cffunction name="registraComentario" hint="registra un comentario">
        <cfargument name="asunto"        type="string"  required="no"  hint="asunto">
        <cfargument name="comentario"    type="string"  required="no"  hint="comentario">
        <cfargument name="prioridad"     type="numeric" required="yes" hint="prioridad del comentario">
        <cfargument name="estado"        type="numeric" required="no"  hint="Estado del registro en que se hiso el comentario">
        <cfargument name="pkRegistro"    type="numeric" required="yes" hint="Registro al que pertenece el comentario">
        <cfargument name="destinatarios" type="array"   required="yes" hint="arreglo de destinatarios">
        <cfargument name="tipoComent"    type="numeric" required="yes" hint="prioridad del comentario">
        <cfscript>
            //REGISTRA UN COMENTARIO EN LA TABLA COMTCOMENTARIO
            pkComent = dao.registraComentario(asunto, comentario, prioridad, estado, Session.cbstorage.usuario.PK, tipoComent, pkRegistro);

            //REGISTRA UNA RELACION ENTRE USUARIOS Y COMENTARIOS EN LA TABLA COMRCOMENTUSUARIO
            if (ArrayLen(destinatarios) GT 0){
                for (var i = 1; i LE ArrayLen(destinatarios); i = i+1) {
                    dao.regitraRelacionComent(pkComent, destinatarios[i]);
                }
            }

            return pkComent;
        </cfscript>
    </cffunction>    


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene los comentarios hechos sobre un registro.
    ---> 
    <cffunction name="getComentariosReg" hint="registra un comentario">
        <cfargument name="pkRegistro"   type="numeric" required="yes" hint="Registro al que pertenece el comentario">
        <cfargument name="pkTipoComent" type="numeric" required="yes" hint="Pk del tipo del comentario">
        <cfscript>
            return dao.getComentariosReg(pkRegistro, pkTipoComent);
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene el contenido de un comentario en especifico.
    --->
    <cffunction name="getContenidoComent" hint="Obtiene comentarios de un registro">
        <cfargument name="pkComent" type="numeric" required="yes" hint="pk de tabla COMTCOMENTARIO">
        <cfscript>
            return dao.getContenidoComent(pkComent);
        </cfscript>
    </cffunction> 


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Funcion que establece un comentario como visto.
    --->
    <cffunction name="setVisto" hint="Establece comentario como visto">
        <cfargument name="pkComentRel" type="numeric" required="yes" hint="pk de tabla COMTCOMENTARIO">
        <cfscript>
            return dao.setVisto(pkComentRel);
        </cfscript>
    </cffunction> 


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Funcion que obtiene la cantidad de comentarios no vistos.
    --->
    <cffunction name="getComentariosNoVistos" hint="Establece comentario como visto">
        <cfargument name="pkUsuario" type="numeric" required="yes" hint="pk del usuario">
        <cfscript>
            return dao.getComentariosNoVistos(pkUsuario);
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene los usuarios para enviar comentario.
    --->
    <cffunction name="getUsuComentario" hint="Usuarios que pueden recibir un comentario">
        <cfargument name="pkElemento" hint="Clave del elemento que se quiere comentar">
        <cfargument name="tipoElemento" hint="Tipo de elemento (Convenio o Documento)">
        <cfscript>
            return dao.getUsuComentario(pkElemento,tipoElemento);
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene el asunto del tipo de comentario.
    --->
    <cffunction name="asuntoComentario" hint="obtiene el asunto del comentario">
        <cfargument name="pkTipoComent" type="numeric" required="yes" hint="pk tipo de comentario">
        <cfscript>
            return dao.asuntoComentario(pkTipoComent);
        </cfscript>
    </cffunction>



</cfcomponent>