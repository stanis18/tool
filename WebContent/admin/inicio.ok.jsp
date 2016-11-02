
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


<body>

<script language="JavaScript">
		    function confirma() {
		        return (confirm("Você deseja mesmo excluir este aluno?")) ;
		    }
</script>

<%@ include file="../cabecalho_disciplinas.jsp"%>

<div id="corpo"><%@ include file="cabecalho_local_admin.jsp"%>
<div id="conteudo">
<div id="menu"><%@ include file="menu_admin.jsp"%>
</div>

<div id="miolo">

<h1>Modo Administrador</h1>

<div style="margin: 25px;">
<display:table id="aluno"
	name="${alunos}" requestURI="admin.inicio.logic" style="width: 500px"
	cellpadding="1" cellspacing="1">
	<display:column property="nome" sortable="true" />
		<display:column property="CPF" style="width: 90px" />
		<display:column property="login" style="width: 40px" />
		<%--   <display:column title="Senha" property="senha" style="width: 60px; color: c7dbff;" /> --%>
  
	<display:column title="A&ccedil;&otilde;es"
		style="width: 70px; text-align: center">
		<a href="admin.editarAluno.logic?aluno.id=${aluno.id}"><img
			src="images/editar.gif" /></a>
		<a
		    <c:if test="${not empty aluno.equipe}">href="admin.alunoDependencia.logic?aluno.id=${aluno.id}" </c:if> 
			<c:if test="${empty aluno.equipe}">href="#" target="_self" onclick="conf('admin.removerAluno.logic?aluno.id=${aluno.id}', '${aluno.nome}');" </c:if>>
			<img src="images/remover.gif" />
		</a>
	</display:column>
</display:table></div>

<br>

</div>


</div>

<%@ include file="../rodape.jsp"%></div>

</body>
</html>
