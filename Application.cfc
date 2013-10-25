 <cfcomponent displayname="Pattern" output="true">
     
            <cfset This.sessionmanagement = true />
            <cfset This.clientmanagement= true />

          
            
            <!---MARCIO SARTINI :: Configurei o idiome abaixo  --->
            <cfset locale = "Portuguese (Brazilian)">

            <cfset oldlocale = SetLocale(locale)> 
			<cffunction name="OnApplicationStart" access="public" returntype="boolean" output="false" >
			 	<cfset application.pathApplication = #CGI.HTTP_HOST# & "cfpattern/cms/">
                
				<cfset application.pathContext = "#getTemplatepath()#" />

                <cfset application.Appfile = "#getPageContext().getFusionContext().getPagePath()#">
                <cfset application.AppPath = "#getDirectoryFromPath(application.Appfile)#">

                <cfset rootPartial = listToArray(application.AppPath, "/")>
                <cfset elementOfArray = ArrayLen(rootPartial)>
                <cfset application.folderContext = rootPartial[elementOfArray]>

                <!--- Contexto da pasta da aplicacao --->
                <cfset application.rootApplicationContext =  "/" & application.folderContext>
				
                <cfreturn true /> 
			
			
			</cffunction>
			
			<cffunction name="onRequestStart" access="public" output="false" hint="Executa sempre que uma requisição é feita.">
               

				<!--- reset app --->
                <cfset application.pathContext = "#getTemplatepath()#" />
                <cfset application.pathContext = ListToArray(application.pathContext, "/")>
                <cfset application.fileCalledContext = ArrayFind(application.pathContext, application.folderContext)>  


                <cfset step = 1>
                <cfset calledContext = "">
                <cfset sep = "">
                <cfloop array="#application.pathContext#" index="folder">
                    <cfset step = step+1>
                    <cfif step GT application.fileCalledContext AND findNoCase(".cfm",folder) EQ 0>
                        <cfset calledContext = calledContext & sep & folder>
                        <cfset sep = "/">
                    </cfif>
                </cfloop>
                <!--- Recuperar o contexto do controller --->
                <cfset application.calledContext =  "/" & calledContext>
                <cfset arrayCalledContext = listToArray(application.calledContext, "/")>
                <cfset lenObjFolderContext =  arrayLen(arrayCalledContext)>
                <cfset application.objetoFolderContext = arrayCalledContext[lenObjFolderContext]>
                <cfset application.viewFolderContext = "/" & application.folderContext & "/views/" & application.objetoFolderContext>
                <cfset application.layoutFolderContext = "/" & application.folderContext & "/layout/">


				<cfif StructKeyExists(url, 'reset')>
					   <cfset onApplicationStart() /> 
					   <cfset structClear(session) />
				</cfif>
				<cfreturn true />	
			</cffunction>





<cffunction
name="onRequest"
access="public"
returntype="void"
output="true"
hint="I execute the page template.">
 
<!--- Define arguments. --->
<cfargument
name="template"
type="string"
required="true"
hint="I am the template that the user requested."
/>
 
<!---
Include the index page no matter what. This way, we
can have a front-controller based application no
matter what URL was requested.
--->
 
<cfset fileContext = ListLast(getTemplatepath(), "/")>
 
 
 
<cfinclude template="/#application.folderContext#/controller/#application.objetoFolderContext#/#fileContext#" />
 
<!--- Return out. --->
<cfreturn />
</cffunction>
 
 
<cffunction
name="onMissingTemplate"
access="public"
returntype="boolean"
output="true"
hint="I execute when a non-existing CFM page was requested.">
 
<!--- Define arguments. --->
<cfargument
name="template"
type="string"
required="true"
hint="I am the template that the user requested."
/>
 
<!---
Execute the request initialization and processing.
These will not be executed implicity for non-
existing CFM templates.
--->
<cfset this.onRequestStart( arguments.template ) />
<cfset this.onRequest( arguments.template ) />
 
<!---
If we've made it this far, everything executed
normally. Return true to signal to ColdFusion
that the event processed successfully (and that
the request is complete).
--->
<cfreturn true />
</cffunction>
 
 
<cffunction
name="onError"
access="public"
returntype="void"
output="true"
hint="I execute when an uncaught error has occurred.">
 
<!--- Define arguments. --->
<cfargument
name="exception"
type="any"
required="true"
hint="I am the uncaught exception object."
/>
 
<cfargument
name="event"
type="string"
required="false"
default=""
hint="I am the event in which the error occurred."
/>
 
<!--- Output the exception. --->
<h1>
Error:
</h1>
<cfdump var="#arguments.exception#" />
<cfabort />
 
<!--- Return out. --->
<cfreturn />
</cffunction>





  
 
    <cfset structAppend(
        url,
        createObject( "component", "UDF" )
    ) />


</cfcomponent>