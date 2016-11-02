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
		
		<%@ include file ="cabecalho_local_prof.jsp" %>

		<div id="conteudo">			
		
		
		<br/><br/>
		<h1>Avaliação da Equipe: ${equipe.nome}</h1> 
		<br/>

			<display:table name="${equipe.alunos}" id="aluno" cellpadding="1" cellspacing="1" style="width:729px">
				<display:column property="nome" title="Aluno" />
				<display:column title="A&ccedil;&otilde;es" style="width: 70px; text-align: center;">
					<a href="avaliacao.avaliarAluno.logic?aluno.id=${aluno.id}"><img src="images/avaliar.png"></a>
				</display:column>
			</display:table>


		</div>
		<%@ include file ="../rodape.jsp" %>
	</div>
</body>
</html>
