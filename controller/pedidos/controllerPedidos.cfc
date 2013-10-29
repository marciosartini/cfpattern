<cfcomponent displayname="Dados" output="false">


	<cffunction name="init" access="public" output="false" returntype="controllerPedidos">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="edita" access="public" output="false" returntype="any">
		<cfset this.acao = "Voce acessou o controller para edicao"> 
		<cfreturn this />
	</cffunction> 
	
	<cffunction name="relatorio" access="public" output="false" returtype="any">
		<cfset this.titulo = "Relatório de Pedidos">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="salva" access="public" output="false" returtype="any">
		<cfset this.titulo = "Salva Pedidos">
		<cfreturn this />
	</cffunction>
	 


</cfcomponent>