<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
    
    <head>        
        <link rel="stylesheet" href="css/internas.css" />
		<title>CenAS: Cen&aacute;rios de Aprendizagem</title>
	</head>
       
<body>
        
    <%@ include file ="../cabecalho_disciplinas.jsp" %>
    
    <div id="corpo">
    
    <%@ include file ="cabecalho_local_prof.jsp" %>
           
        <div id="conteudo"><br>
        <h1>Equipe: ${equipe.nome}</h1>
        <br/>
		<br/>
		<b>Componentes:</b>
        <p style="text-align: center;">
            
            <table id="dados" style="text-align: left; width: 730px" class="dados">
                <tr>
                    <td class="title">Tutor/Aluno</td>
                    <td class="title">Nome</td>
                    <td class="title">Login</td>
                    <td class="title">Senha</td>
                </tr>
                <tr>
                    <td class="content3"><b>Tutor</b></td>
                    <td class="content3">${equipe.tutor.nome}</td>
                    <td class="content3">${equipe.tutor.login}</td>
                    <td class="content3">${equipe.tutor.senha}</td>
                </tr>
                <c:forEach var="aluno" items="${equipe.alunos}">
	            	<tr>
                        <td class="content3"><b>Aluno</b></td>
                        <td class="content3">${aluno.nome}</td>
                        <td class="content3">${aluno.login}</td>
                        <td class="content3">${aluno.senha}</td>
                    </tr>
                    <tr>
                    	<td class="title"></td>
                    	<td class="title">Dom&iacute;nio </td>
                    	<td class="title">Dom&iacute;nio Cognitivo </td>
                    	<td class="title">M&eacute;dia </td>
                    </tr>
                    	
                   
                    <c:forEach var="notas" items="${aluno.avaliacoes}">
                    	<tr>
                    		<td class="content3"></td>
                    		<td class="content3">${notas.dominioAcademico}</td>
                    		<td class="content3">${notas.dominioCognitivo}</td>
                    		<td class="content3">${notas.media}</td>
                    	</tr>
                    </c:forEach>
                    
              	</c:forEach>
                <tr>
                    <td class="actions" colspan="4">
                       
                        <p style="text-align: center;"><input type="button" value="Voltar" onclick="javascript:window.open('<%=link %>.inicio.logic','_self');" class="button" /></p>
                    </td>
                </tr>
            </table>
            
            
        </p>
    </div>

        <%@ include file ="../rodape.jsp" %>
        
    </div>
    
    </body>
    
</html>
