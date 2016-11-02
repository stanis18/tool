<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/meutag.tld" prefix="m" %>

<html>

<head>
	<link rel="stylesheet" href="css/internas.css" />
	<title>CenAS: Cenários de Aprendizagem</title>
</head>

<body>

<%@ include file="../cabecalho_disciplinas.jsp"%>

<div id="corpo"><%@ include file="cabecalho_local_admin.jsp"%>

<div id="conteudo">
<div id="menu"><%@ include file="menu_admin.jsp"%>
</div>
<div id="miolo" align="center">

<%@ include file="../erros.jsp" %>

<h1>Aluno</h1>
<p style="text-align: center;">
<form name="form" action="admin.cadastrarAluno.logic" method="post"
	onsubmit="return confirma(this)" style="text-align:center; ">

    <input type="hidden" name="aluno.id" value="${aluno.id}" /> 

    <input type="hidden" name="aluno.senha" value="${aluno.senha}" />

<table id="dados" style="text-align: left;" class="dados" align="center">
	<tr>
		<td class="title">Nome</td>
		<td class="content3"><input name="aluno.nome"
			value="${aluno.nome}" size="60" /></td>
	</tr>
	<tr>
		<td class="title">CPF:</td>
		<td class="content3"><input name="aluno.CPF" value="${aluno.CPF}"
			size="20" /></td>
	</tr>

	<tr>
		<td class="title">Login:</td>
		<td class="content3"><input name="aluno.login"
			value="${aluno.login}" size="10" /></td>
	</tr>
	<tr>
		<td class="title">Per&iacute;odo:</td>
		<td class="content3"><input name="aluno.periodo"
			value="${aluno.periodo}" size="5" /></td>
	</tr>
	<tr>
		<td class="title">Email:</td>
		<td class="content3"><input size="30" name="aluno.email"
			value="${aluno.email}" /></td>
	</tr>
	<tr>
		<td class="title">Disciplina(s):</td>
		<td class="content3">
			
			<c:forEach var="disciplina" items="${disciplinas}">
					<input type="checkbox" id="checkBox" name="aluno.disciplinas.id" value="${disciplina.id}"
					<c:if test="${m:contains(aluno.disciplinas, disciplina)}">checked="true"</c:if>/>${disciplina.nome}<br/>
			</c:forEach>
			
		</td>
	</tr>	
	<tr>
		<td class="actions" colspan="2"><input type="submit"
			value="Salvar" class="button" />&nbsp; <!--onclick="confirmBox()"-->
		<input type="button" value="Cancelar" onClick="javascript:window.open('admin.inicio.logic','_self');" 
			class="button" /></td>
	</tr>
</table>

</form>
</p>


</div>

</div>
<%@ include file="../rodape.jsp"%></div>

</body>

</html>
