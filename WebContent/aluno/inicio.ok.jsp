<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<html>

<head>

	<title>CenAS: Cenários de Aprendizagem</title>
	<link rel="stylesheet" href="css/internas.css" />
	<link rel="stylesheet" href="css/displaytag.css"/>
</head>

<body>
        <%@ include file ="../cabecalho_disciplinas.jsp" %>
 	<div id="corpo"> 
		
		<p style="margin-left: 5px;"><b>Aluno(a):</b> ${usuario.nome} | ${periodo.periodo}</p>	
		<div id="conteudo">			
		<br/>
			<display:table name="${equipes}" id="equipe" cellpadding="1" cellspacing="1">
				<display:column property="disciplina.nome" title="Disciplina" style="width: 300px"/>
				<display:column title="Problema" style="width:400px">
					<a href="relatorio.inicio.logic?problema.idProblema=${equipe.problema.idProblema}">${equipe.problema.titulo}</a>
				</display:column>
			</display:table>


		</div>
		<%@ include file ="../rodape.jsp" %>
	</div>
</body>
</html>
