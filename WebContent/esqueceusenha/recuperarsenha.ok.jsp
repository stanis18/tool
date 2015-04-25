<?xml version="1.0" encoding="iso-8859-1"?>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<title>CenAS: Cenários de Aprendizagem</title>
<link rel="stylesheet" href="css/index.css" />
<link rel="shortcut icon" href="images/icone.png" />
<link rel="shortcut icon" href="../images/icone.png" />

</head>
<body>

<div id="topo"><img src="images/topoFonteRodrigo2BorboletasAlinhadas.png" width="778" height="107"
	alt="Intarmed - Curso Médico Online" style="margin: 1px;" /></div>
<div id="branco">
<br/>
<fieldset>
<legend><h3><p style="color: black">Recuperando sua Senha</p></h3></legend>
<br/>
<table width="720px">
<td>
<%@ include file="../erros/erros.jsp" %>
<form name="esqueceusenha" action="esqueceusenha.recupera.logic" method="post">		
			
			<p style="font-size: 13px;">Digite seu login:</p>
			<input type="text" name="usuario.login" size="14"/>		
			<input type="submit" value="Recuperar" class="button" name="recuperar">
			<input type="button" value="Voltar" class="button" onclick="javascript:history.back();" style="margin: 10 0 0 20">
		
</form>
</td>
<td align="right">
<p style="color: red;">* Sua senha será enviada para o e-mail relacionado com o respectivo login.</p>
</td>
</table>
</fieldset>
<br/>
<br/>

<%@ include file="../rodape.jsp"%></div>
</body>
</html>
