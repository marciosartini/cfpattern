<cfcomponent displayname="Dados" output="false">


	<cffunction name="init" access="public" output="false" returntype="controllerPedidos">
		<cfreturn this />
	</Cffunction>
	
	<cffunction name="edita" access="public" output="false" returntype="any">
		<cfset this.acao = "Voce acessou o controller para edicao"> 
		<cfreturn this />
	</Cffunction>


	 


</cfcomponent>