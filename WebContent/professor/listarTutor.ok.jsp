<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
       
<html>
<head>

	<title>CenAS: Cenários de Aprendizagem</title>
	<link rel="stylesheet" href="css/internas.css" />
	<link rel="stylesheet" href="css/displaytag.css" />
	<script src="js/confirm.js"></script>
</head>


<body>
        <%@ include file ="../cabecalho_disciplinas.jsp" %>
        
        <div id="corpo">
            
	<%//String endereco = "Configurar Tutor"; %>
	<%@ include file ="cabecalho_local_prof.jsp" %>

<div id="conteudo">
         
<%@ include file="menuTutor.jsp" %>

<div>



<c:if test=""></c:if>
<div >

<display:table id="tutor" name="${tutores}" requestURI="professor.listarTutor.logic" cellpadding="1" cellspacing="1">
	<display:column title="Disciplinas" sortable="true" style="width: 180px; ">
		<c:forEach var="disciplina" items="${tutor.disciplinas}">
			${disciplina.nome}
		</c:forEach>
	</display:column>
	<display:column property="nome" sortable="true" style="width: 300px; "/>
	<display:column property="CPF" sortable="true" style="width: 100px;"/>
	<display:column title="A&ccedil;&otilde;es"	style="width: 100px; text-align: center;">
		<a href="professor.editarTutor.logic?tutor.id=${tutor.id}"><img
			src="images/editar.gif" /></a>
		<a href="#"  target="_self" onclick="conf('professor.removerTutor.logic?tutor.id=${tutor.id}', '${tutor.nome}');">
		<img src="images/remover.gif" /></a>
	</display:column>
</display:table>
    
      
      

</div>

</div>


</div>



<%@ include file ="../rodape.jsp" %>

</div>

</body>
</html>
