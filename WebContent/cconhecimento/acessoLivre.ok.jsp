<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/formatarString.tld" prefix="fs"%>
<html>

<head>

	<title>CenAS: Cenários de Aprendizagem</title>
	<link rel="stylesheet" href="css/internas.css" />
	<link rel="stylesheet" href="css/displaytag.css"/>

</head>

<body>
    <%@ include file ="../cabecalho2.jsp" %>
 	<div id="corpo"> 
		
		<div id="conteudo">			
			<br/>
			
			<h1>Acesso Livre</h1>
			
			<br/><br/>
			
			<display:table id="problema" name="${problemas}" requestURI="cconhecimento.acessoLivre.logic" cellpadding="1" cellspacing="1" style="width: 730px">
				<display:column title="Período">
					${problema.periodo.periodo }
				</display:column>
				<display:column title="Disciplina">
					${problema.disciplina.nome }
				</display:column>
				<display:column title="Título" sortable="true"> 
					<a href="cconhecimento.relatorio.logic?problema.idProblema=${problema.idProblema}">${problema.titulo}</a>
				</display:column>
			</display:table>
			
			<br/>
			
			<input class="button" type="button" title="Voltar" value="Voltar" onclick="javascript:window.open('index.jsp', '_self');"/>
		</div>
		<%@ include file ="../rodape.jsp" %>
	</div>
</body>
</html>
