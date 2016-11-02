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

			<b>Equipe:</b>
			<br />
			
				<input type="hidden" name="problema.equipe.id" value="${problema.equipe.id}"/>
				
				<input type="text" name="problema.equipe.nome" value="${problema.equipe.nome}" disabled="disabled"/>
				
				<br />
				<p/>
				<b>T&iacute;tulo: </b>
				<br />
				<input type="text" style="width: 100%;" name="problema.titulo" value="${problema.titulo}"/>
				<br />
				<br />
				
				<div style="margin-top:20px;">
					<input type="submit" value="Cadastrar" class="button"/>
					<input type="button" class="button" value="Cancelar" onclick="javascript:window.open('professor.inicio.logic','_self');"/>
				</div>
			</div>		 
		</form>
		<%@ include file ="../rodape.jsp" %>
	</div>
</body>
</html>
