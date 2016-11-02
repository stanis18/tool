<%@ page pageEncoding="ISO-8859-1" %>
<html>

<head>
<title>CenAS: Cenários de Aprendizagem</title>
<link rel="stylesheet" href="internas.css" />

</head>


<body>

<%@ include file="../cabecalho_disciplinas.jsp"%>
<div id="corpo"><%@ include file="cabecalho_local_admin.jsp"%>

<div id="conteudo">

<div id="menu"><%@ include file="menu_admin.jsp"%>
</div>

<div id="miolo">
<h1>Limpar Banco</h1>
<p style="text-align: center;"><span style="font-weight: bold;">O Banco de Dados foi limpo com Sucesso!</span> <br>
<br>
O Banco de Dados nesse momento encontra-se sem alunos, problemas e tutores.
<br>

<br>
<input class="button" value="Voltar"
	onclick="javascript:window.open('admin.inicio.logic', '_self');"
	type="button"> <br>


</p>


</div>




</div>
<%@ include file="../rodape.jsp"%></div>

</body>
</html>
