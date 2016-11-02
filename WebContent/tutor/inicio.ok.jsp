<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

	<title>CenAS: Cenários de Aprendizagem</title>
	<link rel="stylesheet" href="css/internas.css" />
	<link rel="stylesheet" href="css/displaytag.css"/>

</head>

<body>
        <%@ include file ="../cabecalho_disciplinas.jsp" %>
 	<div id="corpo"> 
		

		<div id="conteudo">			
			<br/><br/>
			<h1>Equipes</h1> 
			<br/>
			<display:table name="${equipes}" id="equipe" cellpadding="1" cellspacing="1">
				<display:column property="disciplina.nome" title="Disciplina" style="width: 200px"/>
				<display:column property="nome" title="Equipe" style="width: 180px"/>
				<display:column title="Problema" style="width:290px">
					<a href="relatorio.inicio.logic?problema.idProblema=${equipe.problema.idProblema}">${equipe.problema.titulo}</a>
				</display:column>
				<display:column title="A&ccedil;&otilde;es" style="width:90px">
					<a href="avaliacao.notasEquipe.logic?equipe.id=${equipe.id}"><img src="images/avaliar.png"/></a>
					<a href="avaliacao.detalharEquipe.logic?equipe.id=${equipe.id}"><img src="images/lista.png"/></a>
				</display:column>
			</display:table>


		</div>
		<%@ include file ="../rodape.jsp" %>
	</div>
</body>
</html>
