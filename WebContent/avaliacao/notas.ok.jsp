<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="/WEB-INF/formatarString.tld" prefix="fs"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/meutag.tld" prefix="mt" %>
<html>

<head>
	<title>CenAS: Cenários de Aprendizagem</title>
	
	<link rel="stylesheet" media="screen" href="css/relatorio.css" />
	<link rel="stylesheet" media="print" href="css/relatorio2.css" />	
	<link rel="stylesheet" href="css/internas.css" />
	
	<script language="Javascript" type="text/javascript">
		function Data() {
			var hoje = new Date();
			var dia = hoje.getDate();
			var mes = hoje.getMonth() + 1;
			var ano = hoje.getYear();

			if(ano < 2009) ano = ano + 1900;
			
			return ( dia + '/' + mes + '/' + ano);
		}
	</script>
</head>
<body>
<div align="center">
<div id="content" align="center">
	<div id="imprimir">
		<p>
			<input type="button" class="button" value="Imprimir" onclick="window.print()" />&nbsp;
			<input type="button" class="button" value="Fechar" onclick="window.close()" />
		</p>
	</div>
	<div id="data">Data: <script language="javascript" type="text/javascript"> document.write(Data()); </script></div>
	
	<h1>Equipe: ${equipe.nome}</h1>
        <br/>
		<br/>
		<b>Componentes:</b>
          <p/>
          <table width="100%" border="1" cellspacing="0" cellpadding="0" align="center">
		  
		    Nome do Tutor: ${equipe.tutor.nome}
		  
		  <tr>
		    <td rowspan="2" align="center" width="120" class="content31">Nome dos Alunos</td>
		    <td colspan="2" align="center" class="content32">Dia 1</td>
		    <td colspan="2" align="center" class="content32">Dia 2</td>
		    <td colspan="2" align="center" class="content32">Dia 3</td>
		    <td colspan="2" align="center" class="content32">Dia 4</td>
		    <td colspan="2" align="center" class="content32">Dia 5</td>
		    <td colspan="2" align="center" class="content32">Dia 6</td>
		    <td colspan="2" align="center" class="content32">Dia 7</td>
		    <td rowspan="2" align="center" width="40" class="content31">Média</td>
		    
		  </tr>
		  <tr>
		    <td align="center" class="content33">DA</td>
		    <td align="center" class="content33">DC</td>
		    <td align="center" class="content33">DA</td>
		    <td align="center" class="content33">DC</td>
		    <td align="center" class="content33">DA</td>
		    <td align="center" class="content33">DC</td>
		    <td align="center" class="content33">DA</td>
		    <td align="center" class="content33">DC</td>
		    <td align="center" class="content33">DA</td>
		    <td align="center" class="content33">DC</td>
		    <td align="center" class="content33">DA</td>
		    <td align="center" class="content33">DC</td>
		    <td align="center" class="content33">DA</td>
		    <td align="center" class="content33">DC</td>
		  </tr>
		  <c:forEach var="aluno" items="${equipe.alunos}">
			  <tr>
			    <td class="content31"><span title="${aluno.nome}">${aluno.nome}</span></td>
			    <td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[0].dominioAcademico}">${aluno.avaliacoes[0].dominioAcademico}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[0].dominioAcademico}">&nbsp;</c:if>
			    </td>
			    <td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[0].dominioCognitivo}">${aluno.avaliacoes[0].dominioCognitivo}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[0].dominioCognitivo}">&nbsp;</c:if>
			    </td>
			    <td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[1].dominioAcademico}">${aluno.avaliacoes[1].dominioAcademico}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[1].dominioAcademico}">&nbsp;</c:if>
			    </td>
			    <td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[1].dominioCognitivo}">${aluno.avaliacoes[1].dominioCognitivo}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[1].dominioCognitivo}">&nbsp;</c:if>
			    </td>
			    <td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[2].dominioAcademico}">${aluno.avaliacoes[2].dominioAcademico}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[2].dominioAcademico}">&nbsp;</c:if>
			    </td>
			    <td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[2].dominioCognitivo}">${aluno.avaliacoes[2].dominioCognitivo}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[2].dominioCognitivo}">&nbsp;</c:if>
			    </td>
			    <td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[3].dominioAcademico}">${aluno.avaliacoes[3].dominioAcademico}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[3].dominioAcademico}">&nbsp;</c:if>
			    </td>
			    <td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[3].dominioCognitivo}">${aluno.avaliacoes[3].dominioCognitivo}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[3].dominioCognitivo}">&nbsp;</c:if>
			    </td>
			    <td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[4].dominioAcademico}">${aluno.avaliacoes[4].dominioAcademico}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[4].dominioAcademico}">&nbsp;</c:if>
			    </td>
			    <td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[4].dominioCognitivo}">${aluno.avaliacoes[4].dominioCognitivo}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[4].dominioCognitivo}">&nbsp;</c:if>
			    </td>
    			<td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[5].dominioAcademico}">${aluno.avaliacoes[5].dominioAcademico}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[5].dominioAcademico}">&nbsp;</c:if>
			    </td>
			    <td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[5].dominioCognitivo}">${aluno.avaliacoes[5].dominioCognitivo}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[5].dominioCognitivo}">&nbsp;</c:if>
			    </td>
				<td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[6].dominioAcademico}">${aluno.avaliacoes[6].dominioAcademico}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[6].dominioAcademico}">&nbsp;</c:if>
			    </td>
			    <td class="content33">
			    	<c:if test="${not empty aluno.avaliacoes[6].dominioCognitivo}">${aluno.avaliacoes[6].dominioCognitivo}</c:if>
			    	<c:if test="${empty aluno.avaliacoes[6].dominioCognitivo}">&nbsp;</c:if>
			    </td>
				 <td class="content33"><c:if test="${not empty aluno.avaliacoes}">${mt:mediaAsString(aluno.avaliacoes)}</c:if>&nbsp;</td>
			    
			  </tr>
		  </c:forEach>
		</table>
</div>

</div>
</body>