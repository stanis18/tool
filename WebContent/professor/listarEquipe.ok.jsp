<%@page pageEncoding="iso-8859-1"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>

<head>
    
	<title>CenAS: Cenários de Aprendizagem</title>
    <link href="css/internas.css" rel="stylesheet">
	<link href="css/displaytag.css" rel="stylesheet">
	<script src="js/confirm.js"></script>
</head>


<body>
       
    <%@ include file ="../cabecalho_disciplinas.jsp" %>
    
    <div id="corpo">

        <%@ include file ="cabecalho_local_prof.jsp" %>
        
        <div id="conteudo">
            
            <input class="button" onclick="javascript:window.location.href = 'professor.formularioEquipe.logic';" value="Nova equipe" type="button">
            <br/>
            
            <br/>      
			<b>Equipes:</b>
			<br/>
            
            <br/>
	
			<display:table id="equipe" name="${equipes}" requestURI="professor.listarEquipe.logic" cellpadding="1" cellspacing="1">
				<display:column property="disciplina.nome" title="Disciplinas" sortable="true" style="width: 400px"/>
				<display:column property="nome" sortable="true" style="width: 200px;"/>
				<display:column title="A&ccedil;&otilde;es"	style="width: 150px; text-align: center;">
					<a href="professor.editarEquipe.logic?equipe.id=${equipe.id}"><img
						src="images/editar.gif" /></a>
					<a href="#"  target="_self" onclick="conf('professor.removerEquipe.logic?equipe.id=${equipe.id}', '${equipe.nome}');">
					<img src="images/remover.gif" /></a>
					<a href="avaliacao.detalharEquipe.logic?equipe.id=${equipe.id}"><img
						src="images/lista.png" /></a>
				</display:column>
			</display:table>

        </div>
        
        <%@ include file ="../rodape.jsp" %>   
        
    </div>
    
    
</body>
</html>
