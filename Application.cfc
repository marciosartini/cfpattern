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
				
				<!--- Contexto atŽ a pasta antes da aplicacao, normalmente atŽ wwwroot, mas n‹o necessariamente --->
				<cfset elementDelete = ListFind(#application.AppPath#, #application.folderContext#, "/")>
				<cfset application.pathUntilFolderContext = ListDeleteAt(application.AppPath, elementDelete, "/")>

                <!--- Contexto da pasta da aplicacao --->
                <cfset application.rootApplicationContext =  "/" & application.folderContext>
				
                <cfreturn true /> 
			
			
			</cffunction>
			
			<cffunction name="onRequestStart" access="public" output="false" hint="Executa sempre que uma requisiÃ§Ã£o Ã© feita.">
               

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
			 

				
				 
				<cfif lenObjFolderContext EQ 1>
					<cfset application.objetoFolderContext = "">
				<cfelse>
					<cfset application.objetoFolderContext = arrayCalledContext[lenObjFolderContext]>
				</cfif>
                 
              
				
				<cfif ListLen(application.calledContext, "/") GT 1> 
					<cfset application.calledController = ListGetAt(application.calledContext, 2, "/")>
				<cfelse>
					<cfset application.calledController = "">	
		  		</cfif>
		  		
		  		
		  		<!--- 
		  			Detecta o mŽtodo escolhido pelo usuario, se for informado, ex: /app/usuario/edita/usuario.cfm
		  			*app = contexto
		  			*usuario = pasta do controle
		  			*edita = o mŽtodo informado pelo usuario
		  			*usuario.cfm = arquivo do controle
		  		 --->
		  		<cfif ListLen(application.calledContext, "/") GT 2> 
					<cfset application.methodController = ListGetAt(application.calledContext, 3, "/")>
					<cfset isMethod = FindNoCase(".cfm", application.methodController)>
					<cfif isMethod>
						<cfset application.methodController = "">	
					</cfif>
				<cfelse>
					<cfset application.methodController = "">	
		  		</cfif>
		  		
		  		
		  		
 
  				<cfset application.viewFolderContext = "/" & application.folderContext & "/views/" & application.calledController>
                <cfset application.layoutFolderContext = "/" & application.folderContext & "/layout/">

				<cfif StructKeyExists(url, 'reset')>
					   <cfset onApplicationStart() /> 
					   <cfset structClear(session) />
				</cfif>
			

				<cfreturn true />	
			</cffunction>





		<cffunction name="onRequest" access="public" returntype="void" output="true" hint="I execute the page template.">
	 

			<!--- Define arguments. --->
			<cfargument name="template" type="string" required="true" hint="I am the template that the user requested." />
			 
			<!---
			Include the index page no matter what. This way, we
			can have a front-controller based application no
			matter what URL was requested.
			--->
			
	


			<cfset fileContext = ListLast(getTemplatepath(), "/")>
			
			<cfset thisPath = ExpandPath("*.*")>
			<cfset thisDirectory = GetDirectoryFromPath("/#application.pathUntilFolderContext#/#application.folderContext#/controller/#application.calledController#")>
			
			<cfset pathController = "#application.pathUntilFolderContext#/#application.folderContext#/controller/#application.calledController#">
			 
			
		    	
 


			<!--- Verifica se existe o controller chamado --->
			<cfif DirectoryExists("/#application.pathUntilFolderContext#/#application.folderContext#/controller/#application.calledController#")>
			 	<cfif FileExists("#pathController#/#fileContext#")>
					<cfinclude template="/#application.folderContext#/controller/#application.calledController#/#fileContext#" /> 
				<cfelse>
					<cfif FileExists("#pathController#/index.cfm")>
						<cfinclude template="/#application.folderContext#/controller/#application.calledController#/index.cfm" />
					<cfelse>
			 
						<cfoutput>#application.calledContext# </cfoutput>	 
						<cfset pos = ListFindNoCase(getTemplatepath(), application.folderContext, '/')>
						<cfset pos = ListGetAt(getTemplatepath(), pos, '/')>
					<!--- 	<cfoutput>#ListRest(temp)#</cfoutput> --->
					
						<cfinclude template="#application.calledContext#/index.cfm" />
					</cfif>
				</cfif>
			<cfelse>
				<cfinclude template="#application.calledContext#/index.cfm" />		  	
			</cfif>
			 
			
		 
			 
			<!--- Return out. --->
			<cfreturn />
		</cffunction>
 
 
		<cffunction name="onMissingTemplate" access="public" returntype="boolean" output="true" hint="I execute when a non-existing CFM page was requested.">
		 
			<!--- Define arguments. --->
			<cfargument name="template" type="string" required="true" hint="I am the template that the user requested." />
			

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
 
 
		<cffunction name="onError" access="public" returntype="void" output="true" hint="I execute when an uncaught error has occurred.">
		 
			<!--- Define arguments. --->
			<cfargument name="exception" type="any" required="true" hint="I am the uncaught exception object." />
			 
			<cfargument name="event" type="string" required="false" default="" hint="I am the event in which the error occurred." />
			 
			<!--- Output the exception. --->
			<h1>
			Error:
			</h1>
			<cfdump var="#arguments.exception#" />
			<cfabort />
		 
			<!--- Return out. --->
			<cfreturn />
		</cffunction>





  
 		<!--- Adiciona o funcao UDF na applicacao --->
	    <cfset structAppend(
	        url,
	        createObject( "component", "UDF" )
	    ) />


</cfcomponent>