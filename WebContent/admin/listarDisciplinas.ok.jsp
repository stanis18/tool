<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>

<title>CenAS: Cenários de Aprendizagem</title>
<link href="css/internas.css" rel="stylesheet" />
<link href="css/displaytag.css" rel="stylesheet" />
<script src="js/confirm.js">
</script>
</head>

<body id="teste">

<%@ include file="../cabecalho_disciplinas.jsp"%>

<div id="corpo"><%@ include file="cabecalho_local_admin.jsp"%>

<div id="conteudo">
<div id="menu"><%@ include file="menu_admin.jsp"%>
</div>

<div id="miolo">

<h1>Modo Administrador</h1>

<div style="margin: 25px;">
<display:table id="disciplina"
	name="${disciplinas}" requestURI="admin.listarDisciplinas.logic"
	style="width: 500px" cellpadding="1" cellspacing="1">
	<display:column property="nome" sortable="true"/>
	<display:column property="chaveSiga" style="width: 100px" />
	<display:column title="A&ccedil;&otilde;es"	style="width: 100px; text-align: center;">
		<a href="admin.editarDisciplina.logic?disciplina.id=${disciplina.id}"><img
			src="images/editar.gif" /></a>
		<a href="#"  target="_self" onclick="conf('admin.removerDisciplina.logic?disciplina.id=${disciplina.id}', '${disciplina.nome}');">
        <img src="images/remover.gif"/></a>
	</display:column>
</display:table></div>

<br>

</div>


</div>

<%@ include file="../rodape.jsp"%></div>

</body>
</html>
