<%@ page pageEncoding="ISO-8859-1" %>
<html>

<head>
	<link rel="stylesheet" href="css/internas.css" />
	<title>CenAS: Cenários de Aprendizagem</title>
</head>

<body>

<%@ include file="../cabecalho_disciplinas.jsp"%>

<div id="corpo">
	<%@ include file="cabecalho_local_admin.jsp"%>
<div id="conteudo">
<div id="menu">
	<%@ include file="menu_admin.jsp"%>
</div>
<div id="miolo">

<%@ include file="../erros.jsp" %>

<h1>Rotina de Limpeza</h1>

<p/>

<form name="form" action="admin.rotinaLimpezaBD.logic" method="post" 
onsubmit="return confirma(this)" style="text-align:center; ">
	
		
<table id="dados" style="text-align: left;" class="dados" align="center">
	
	<tr>
		
		<td class="actions" colspan="2">
		<p> &nbsp Esta função se refere a rotina de limpaza do banco de dados.  
		<br/> &nbsp Ao executá-la todos os dados do sistema
		serão apagados e não haverá como recuperá-los. 
		<br/> &nbsp Execute com cautela. </p>
		
		<input type="submit"
			value="Limpar" class="button" /> 
	</tr>
</table>
</form>
</div>



</div>
<%@ include file="../rodape.jsp"%></div>

</body>

</html>
