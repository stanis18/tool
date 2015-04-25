<%@ page pageEncoding="ISO-8859-1" %>

<html>
<head>
<link rel="stylesheet" href="css/internas.css" />

<title>CenAS: Cenários de Aprendizagem</title>

<SCRIPT LANGUAGE="JavaScript">
	function checaPeriodo(str){
	          
		var dot=".";
		var lstr=str.length;
		var ldot=str.indexOf(dot);
		
		if(lstr < 6){
	          return (false);
		}
		if(ldot != (lstr - 2)){
	          return (false);
		}
	       if(  isNaN(str.substring(0, ldot)) ||  isNaN(str.substring(lstr -1, lstr ))){
			return (false);
		}
		return (true);
	}
	          
	function confirma(form) {
		if(checaPeriodo(form.periodo.value)){
			if (confirm("Você deseja mesmo atualizar o período?")) {
				return true;
			}else{
				return false;
			}
		}
		else{
			alert("Digite um valor de período válido!");
			return false;
		}
	}         
	</SCRIPT>

</head>
<body>

<%@ include file="../cabecalho_disciplinas.jsp"%>

<div id="corpo"><%@ include file="cabecalho_local_admin.jsp"%>

<div id="conteudo"><script type="text/javascript"
	src="js/menu_admin.js"></script>

<div id="menu"><%@ include file="menu_admin.jsp"%>
</div>


<div id="miolo">
<h1>Setar Período</h1>

<div style="margin: 25px;">

<form name="form" action="admin.cadastrarNovoPeriodo.logic"
	method="post" donsubmit="return confirma(this)">
<table id="dados" style="text-align: left;" class="dados">
	<tr>
		<td class="title"><b>Período:</td>
		<td class="content3"><input size="7" name="periodo.periodo"
			type="text" value="${periodo.periodo}" /> (Ex: "2009.1")</td>
	<tr>
		<td class="actions" colspan="2"><input type="hidden"
			name="periodo.idPeriodo" value="${periodo.idPeriodo}"> <input
			type="submit" value="Salvar" class="button" />&nbsp; <input
			type="button" value="Cancelar" onclick="admin.inicio.logic"
			class="button" />&nbsp;</td>
	</tr>
</table>
</div>
<br>


</div>
</div>

<%@ include file="../rodape.jsp"%></div>
</body>
</html>
