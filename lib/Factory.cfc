<cfcomponent output="false" displayname="factory">

	<cffunction name="init" access="public" output="false" returntype="factory">
        <cfset variables.instance  = structNew() />
        <cfreturn this />
    </cffunction>

    <cffunction name="getInstance" access="public" output="false" returntype="any">
	        <cfargument name="name" type="string" required="true" />
	      

            <!--- Verifica se a instancia já foi carregada, caso contrário cria a instancia do objeto --->
            <cfif not StructKeyExists(variables.instance, arguments.name)>
                <cfset variables.instance[ arguments.name ] = createInstance( arguments.name )>
            </cfif>
            <cfreturn variables.instance[arguments.name] />
    </cffunction>


    <cffunction name="createInstance" access="private" output="false" returntype="any">
        <cfargument name="name" type="string" required="true" />
		
		<!--- Tratamento de classe controller --->		
		<cfif findnocase('controller', arguments.name)>
		    <cfswitch expression="#arguments.name#">
				 <cfcase value= "controllerPedidos"> 
	                <cfreturn CreateObject( "component", "#application.folderContext#..controller.#application.calledController#.#arguments.name#" ) />
	                <cfbreak>
	            </cfcase>
        	</cfswitch>
		<cfelse>
			<cfswitch expression="#arguments.name#">
	            <cfcase value="UDF"> 
	                <cfreturn CreateObject( "component", "#application.folderContext#.UDF" ) />
	                <cfbreak>
	            </cfcase>
	        </cfswitch>
		</cfif>
    
    </cffunction>

    <cffunction name="listInstance" access="public" output="false" returntype="any">
            <cfreturn variables.instance />
    </cffunction>

</cfcomponent>