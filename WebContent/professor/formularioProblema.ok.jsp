<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
	<title>CenAS: Cenários de Aprendizagem</title>
	<link rel="stylesheet" href="css/internas.css" />

</head>


<body>

	<%@ include file ="../cabecalho_disciplinas.jsp" %>
 	
	<div id="corpo">
 	
 	<%@ include file ="cabecalho_local_prof.jsp" %>
	
		<div id="conteudo">
		<form action="professor.cadastrarProblema.logic" method="post" name="form">
			
			<input type="hidden" name="problema.idProblema" value="${problema.idProblema}" />
			
			<%@ include file="../erros.jsp" %>
			
			<br/>
			
			<c:if test="${empty equipes}">
				<div class="aviso">
					<p>
						<img src="images/atention.gif" alt="Atenção" style="vertical-align:-4px;" />&nbsp;
						Não há equipes disponíveis para cadastrar um novo problema. 
						<br/>
						<span style="padding-left: 24px">Adicione uma nova equipe antes.</span>
					</p>
				</div>
			</c:if>
			
			
			<c:if test="${not empty equipes}">
			<b>Equipe:</b>
			<br />
			
				<select name="problema.equipe.id" id="equipe">
					<c:forEach var="equipe" items="${equipes}">
						<option value="${equipe.id}" <c:if test="${equipe.id == problema.equipe.id}"> selected="true" </c:if>> ${equipe.nome} - ${equipe.disciplina.nome} </option>
					</c:forEach>
				</select>
				
				<br />
				<p/>
				<b>T&iacute;tulo: </b>
				<br />
				<input type="text" size="126" name="problema.titulo"/>
				<br />
				<br />
				
				<div style="margin-top:20px;">
					<input type="submit" value="Cadastrar" class="button"/>
					<input type="button" class="button" value="Cancelar" onclick="javascript:window.open('professor.inicio.logic','_self');"/>
				</div>
			</c:if>
			
			
		</form>
	</div>		 
	<%@ include file ="../rodape.jsp" %>
	</div>
</body>
</html>
