<%@ page pageEncoding="ISO-8859-1" %>
<html>

	<head>
		<title>CenAS: Cenários de Aprendizagem</title>
		<link rel="stylesheet" href="internas.css" />
	</head>
	
	<meta name="description" lang="pt-br"
		content="Sistema eletrônico de segunda opinião em saúde" />
	<meta name="keywords" lang="pt-br"
		content="saúde, health, segunda opinião, medicina" />
	<meta name="robots" content="ALL" />
	<meta name="rating" content="General" />
	<meta name="author" lang="pt-br" content="José Pirauá" />
	<meta name="generator" content="AceHTML 5 Freeware" />
	<meta name="language" content="pt-br" />
	<link rel="author" href="josepiraua@hotmail.com" />
	<link rel="stylesheet" href="css/internas.css" />
	
	<body>
	
		<%@ include file="../cabecalho_disciplinas.jsp"%>
		<div id="corpo">
			<%@ include file="cabecalho_local_admin.jsp"%>
			
			<div id="conteudo">
			
			<div id="menu">
				<%@ include file="menu_admin.jsp"%>
			</div>
			
			<div id="miolo">
				<h1>Remover Aluno</h1>
				<p style="margin: 10 10 10 10">
					<span style="font-weight: bold;">O(A) aluno(a) ${aluno.nome} está viculado a(s) seguinte(s) equipe(s):</span> <br>
					<br>
					<c:forEach var="equipe" items="${aluno.equipe}">
						- ${equipe.nome} <br>
					</c:forEach>
					<br>
						<span style="margin-left: 10; color: red;">Você deseja remover o aluno mesmo assim?</span>
					<br>
					<br>
					
					<input class="button" value="Confirmar"
						onclick="javascript:window.open('admin.removerAluno.logic?aluno.id=${aluno.id}', '_self');"
						type="button" style="margin-left: 10"/> 
					&nbsp;
					<input class="button" value="Cancelar"
						onclick="javascript:window.open('admin.inicio.logic', '_self');"
						type="button"/> 
				<br>
				</p>
			
			</div>
			
			</div>
			<%@ include file="../rodape.jsp"%>
		</div>
		
	</body>
</html>
