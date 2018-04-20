
<cfcomponent>

    <cffunction name="sendMail"  access="public" hint="realiza el envio del correo">
        <cfargument name="mail" required="true" type="any" hint="Objeto MailMessage que contiene la informacion del correo a enviar">
        <cfscript>
            if(mail.bcc neq ''){
                copia = mail.bcc;
            }else{
                copia = '';
            }
            </cfscript>
        <cftry>
           <cfmail server="smtp.ipn.mx" type="html" from="#mail.from#" to="#mail.to#" cc="#mail.cc#" bcc="#copia#" subject="#mail.subject#" failto="siiis@ipn.mx" >
                #mail.content#    
            </cfmail>
            <cfreturn 1>
            <cfcatch>
                <cfreturn 0>
            </cfcatch>
        </cftry>
    </cffunction>

    <cffunction name="queryToArray" returntype="array" output="No" access="remote"> 
        <cfargument name="q" required="Yes" type="query">
         <cfset var aTmp = arraynew(1)> 
        <cfif q.recordcount> 
          <cfloop query="q"> 
            <cfset stTmp = structNew()> 
            <cfloop list="#q.columnlist#" index="col"> 
              <cfset stTmp[col] = q[col][currentRow]> 
            </cfloop> 
            <cfset arrayAppend(aTmp,stTmp)> 
          </cfloop>
        </cfif> 
        <cfreturn aTmp> 
    </cffunction>

</cfcomponent>