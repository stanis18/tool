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
			<b>Disciplina:</b> ${problema.disciplina.chaveSiga} - ${problema.disciplina.nome}
			<br />
			<br />
			<b>T&iacute;tulo:</b>
				${problema.titulo}
			<br />
			<br />
			<b>Alunos envolvidos no problema:</b><br />
			
				<c:forEach var="aluno" items="${problema.equipe.alunos}">
					${aluno.nome}<br/>
				</c:forEach>

			<br />
			
		<c:if test="${problema.aberto == 0}">
			<div class="aviso">
			<p>
			<img src="images/atention.gif" alt="Atenção" style="vertical-align:-4px;" />&nbsp;
			Ap&oacute;s fechar o problema n&atilde;o ser&aacute; poss&iacute;vel alterar os dados,
			tem certeza que deseja fechar o problema?
			</p>
			</div>
			
			<div style="margin-top:20px;">
				<input type="button" class="button" value="Fechar" onclick="javascript:window.open('professor.fecharProblema.logic?problema.idProblema=${problema.idProblema}','_self');"/> &nbsp;
		</c:if>		
		
		<c:if test="${problema.aberto == 1}">
			<div class="aviso">
			<p>
			<img src="images/atention.gif" alt="Atenção" style="vertical-align:-4px;" />&nbsp;
			Ao abrir o problema ser&aacute; poss&iacute;vel alterar os dados do mesmo,
			tem certeza que deseja abrir o problema?
			</p>
			</div>
			
			<div style="margin-top:20px;">
				<input type="button" class="button" value="Abrir" onclick="javascript:window.open('professor.fecharProblema.logic?problema.idProblema=${problema.idProblema}','_self');"/> &nbsp;
		</c:if>	
			<input type="button" class="button" value="Cancelar" onclick="javascript:window.open('professor.inicio.logic','_self');"/>
			</div>
		</div>		 
		<%@ include file ="../rodape.jsp" %>
	</div>
</body>
</html>
