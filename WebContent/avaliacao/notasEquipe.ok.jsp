<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="/WEB-INF/meutag.tld" prefix="mt" %>
<html>
    
    <head>        
        <link rel="stylesheet" href="css/internas.css" />
		<title>CenAS: Cenários de Aprendizagem</title>
		<script type="text/javascript" language="javascript">
		
			function notas() {
				window.open('avaliacao.notas.logic','notas','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=1050,height=600');
			}
		
		</script>
	</head>
       
<body>
        
    <%@ include file ="../cabecalho_disciplinas.jsp" %>
    
    <div id="corpo">
    
    <%@ include file ="cabecalho_local_prof.jsp" %>
           
        <br>
        <h1>Equipe: ${equipe.nome}</h1>
        <br/>
		<br/>
		<b>Componentes:</b>
          <p/>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
		  <tr style="background-color: #142a53; color: #FFFFFF; height: 28px;">
		    Nome do Tutor: ${equipe.tutor.nome}
		  </tr>
		  <tr>
		    <td rowspan="2" align="center" width="40" class="content31">Login dos Alunos</td>
		    <td colspan="2" align="center" class="content32">Dia 1</td>
		    <td colspan="2" align="center" class="content32">Dia 2</td>
		    <td colspan="2" align="center" class="content32">Dia 3</td>
		    <td colspan="2" align="center" class="content32">Dia 4</td>
		    <td colspan="2" align="center" class="content32">Dia 5</td>
		    <td colspan="2" align="center" class="content32">Dia 6</td>
		    <td colspan="2" align="center" class="content32">Dia 7</td>
		    <td rowspan="2" align="center" width="40" class="content31">Média</td>
		    <td rowspan="2" align="center" class="content31">Ação</td>
		  </tr>
		  <tr>
		    <td align="center" class="content33">DA</td>
		    <td align="center" class="content3">DC</td>
		    <td align="center" class="content33">DA</td>
		    <td align="center" class="content3">DC</td>
		    <td align="center" class="content33">DA</td>
		    <td align="center" class="content3">DC</td>
		    <td align="center" class="content33">DA</td>
		    <td align="center" class="content3">DC</td>
		    <td align="center" class="content33">DA</td>
		    <td align="center" class="content3">DC</td>
		    <td align="center" class="content33">DA</td>
		    <td align="center" class="content3">DC</td>
		    <td align="center" class="content33">DA</td>
		    <td align="center" class="content3">DC</td>
		  </tr>
		  <c:forEach var="aluno" items="${equipe.alunos}">
			  <tr>
			    <td class="content31"><span title="${aluno.nome}">${aluno.login}</span></td>
			    <td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[0].dominioAcademico}">${aluno.avaliacoes[0].dominioAcademico}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[0].dominioAcademico}">&nbsp;</c:if>
			    </td>
			    <td class="content3">
			    	<c:if test="${not empty aluno.avaliacoes[0].dominioCognitivo}">${aluno.avaliacoes[0].dominioCognitivo}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[0].dominioCognitivo}">&nbsp;</c:if>
			    </td>
			    <td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[1].dominioAcademico}">${aluno.avaliacoes[1].dominioAcademico}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[1].dominioAcademico}">&nbsp;</c:if>
			    </td>
			    <td class="content3">
			    	<c:if test="${not empty aluno.avaliacoes[1].dominioCognitivo}">${aluno.avaliacoes[1].dominioCognitivo}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[1].dominioCognitivo}">&nbsp;</c:if>
			    </td>
			    <td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[2].dominioAcademico}">${aluno.avaliacoes[2].dominioAcademico}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[2].dominioAcademico}">&nbsp;</c:if>
			    </td>
			    <td class="content3">
			    	<c:if test="${not empty aluno.avaliacoes[2].dominioCognitivo}">${aluno.avaliacoes[2].dominioCognitivo}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[2].dominioCognitivo}">&nbsp;</c:if>
			    </td>
			    <td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[3].dominioAcademico}">${aluno.avaliacoes[3].dominioAcademico}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[3].dominioAcademico}">&nbsp;</c:if>
			    </td>
			    <td class="content3">
			    	<c:if test="${not empty aluno.avaliacoes[3].dominioCognitivo}">${aluno.avaliacoes[3].dominioCognitivo}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[3].dominioCognitivo}">&nbsp;</c:if>
			    </td>
			    <td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[4].dominioAcademico}">${aluno.avaliacoes[4].dominioAcademico}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[4].dominioAcademico}">&nbsp;</c:if>
			    </td>
			    <td class="content3">
			    	<c:if test="${not empty aluno.avaliacoes[4].dominioCognitivo}">${aluno.avaliacoes[4].dominioCognitivo}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[4].dominioCognitivo}">&nbsp;</c:if>
			    </td>
    			<td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[5].dominioAcademico}">${aluno.avaliacoes[5].dominioAcademico}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[5].dominioAcademico}">&nbsp;</c:if>
			    </td>
			    <td class="content3">
			    	<c:if test="${not empty aluno.avaliacoes[5].dominioCognitivo}">${aluno.avaliacoes[5].dominioCognitivo}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[5].dominioCognitivo}">&nbsp;</c:if>
			    </td>
				<td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[6].dominioAcademico}">${aluno.avaliacoes[6].dominioAcademico}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[6].dominioAcademico}">&nbsp;</c:if>
			    </td>
			    <td class="content3">
			    	<c:if test="${not empty aluno.avaliacoes[6].dominioCognitivo}">${aluno.avaliacoes[6].dominioCognitivo}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[6].dominioCognitivo}">&nbsp;</c:if>
			    </td>
				 <td class="content33"><c:if test="${not empty aluno.avaliacoes}">${mt:mediaAsString(aluno.avaliacoes)}</c:if>&nbsp;</td>
			    <td class="content33"><a href="avaliacao.avaliarAluno.logic?aluno.id=${aluno.id}"><img src="images/nota.png" title="Dar nota" style="text-align: right;"/></a></td>
			  </tr>
		  </c:forEach>
		</table>
        <p align="left">
        DOMINIO AFETIVO (DA): relações interpessoais, cuidados pessoais, pontualidade.<br>
		DOMÍNIO COGNITIVO (DC): conhecimento teórico, integração teórico-prática<br>
		<br>
		<br>Para cada aluno colocar uma nota (0 a 10) em relação a cada ítem
         </p>
		<p align="right">
		<input type="button" value="Impressão da Tabela de Notas" class="button" onclick="javascript:notas(); " />
		<input type="button" value="Voltar" class="button" onclick="javascript:history.back();" style="margin: 10 0 0 20">
		</p>
        <%@ include file ="../rodape.jsp" %>
        
    </div>
    
    </body>
    
</html>
