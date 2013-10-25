<cfcomponent
output="false"
hint="Eu defini funcao para padronizar chamada das views.">
 
    <cffunction
        name="loadView"
        access="public"
        returntype="Any"
        output="false"
        hint="Retorna um objeto.">
        <cfargument name="objeto" type="any" required="false">

       
        <cfset objeto = arguments.objeto>

        <cfset this = objeto>

        

        <cfif NOT IsDefined("objeto.layout") OR objeto.layout EQ "" >
            <cfset layout = application.layoutFolderContext & '/layout.cfm'>
        <cfelse>
            <cfset layout = #objeto.layout# & ".cfm">
        </cfif>
        
        <cfif NOT IsDefined("objeto.page") OR objeto.page EQ "" >
            <cfset page = 'index.cfm'>
        <cfelse>
            <cfset page = '' & #objeto.page# & ".cfm">
        </cfif>
        
        <cfset this.page = page>
        <cfset this.layout = layout>
         
         
        
     
        <cfreturn this />  


    </cffunction>
 
</cfcomponent>