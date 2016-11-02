<%@ page pageEncoding="ISO-8859-1" %>
<html>
	
	<head>
		<title>CenAS: Cenários de Aprendizagem</title>
		<link rel="stylesheet" href="css/internas.css" />
		<script src="js/tiny_mce/tiny_mce.js" type="text/javascript"></script>
        <script type="text/javascript">
               
                tinyMCE.init({
                    // General options
                    mode : "textareas",
                    theme : "advanced",
                    language : "pt",
                    plugins : "pagebreak,style,layer,table,advhr,advlink,iespell,insertdatetime,contextmenu,paste,directionality,noneditable,xhtmlxtras,template,inlinepopups",
                    // Theme options
                    theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,fontselect",
                    theme_advanced_buttons2 : "bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,forecolor,fontsizeselect",
                    theme_advanced_toolbar_location : "top",
                    theme_advanced_toolbar_align : "center",
                    theme_advanced_statusbar_location : "bottom",
                    
                    theme_advanced_resizing : true,
                    theme_advanced_path : false,

                    // Example word content CSS (should be your site CSS) this one removes paragraph margins
                    content_css : "css/word.css",

                    // Drop lists for link/image/media/template dialogs
                    template_external_list_url : "lists/template_list.js",
                    external_link_list_url : "lists/link_list.js",
                    external_image_list_url : "lists/image_list.js",
                    media_external_list_url : "lists/media_list.js",

                    // Replace values for the template plugin
                    template_replace_values : {
                        username : "Some User",
                        staffid : "991234"
                    }
                });
            
        </script>
		
	</head>

	<body>
	
	<%@ include file ="../cabecalho.jsp" %>
		<form name="novoGlossario" action="relatorio.cadastrarGlossarioProblema.logic" method="post">
		<div id="corpo">
			<%@ include file ="local.jsp" %>
			<div id="conteudo">
	  		       
				<div id="menu">
					<%@ include file="menu.jsp" %>
				</div>
				<div id="miolo">
					<h1>Problema: ${problema.titulo}</h1>

					<h4>Desenvolvimento | Gloss&aacute;rio</h4>
					
					<div style="margin:25px;">
						
						<input type="hidden" name="glossario.problema.idProblema" value="${problema.idProblema}">
						<input type="hidden" name="glossario.idGlossario" value="${glossario.idGlossario}">

						<table class="dados">
							<tr>
								<td class="title">Termo</td>
								<td class="content3">
								    <input type="text" size="74" name="glossario.termo" value="${glossario.termo}" /></td>
							</tr>
							<tr>
								<td class="title">Significado</td>
								<td class="content3">
									<textarea cols="73" rows="18" name="glossario.descricao">${glossario.descricao}</textarea>
								</td>
							</tr>
							<tr>
								<td class="actions" colspan="2">
									<input type="submit" value="Salvar" class="button" name="salvar">&nbsp;
									<input type="button" value="Cancelar" onclick="javascript:window.open('relatorio.exibirGlossario.logic','_self');" class="button" />&nbsp;
								</td>
							</tr>											
						</table>
					</div>
				</div>		    
			</div>		
			</form>
			<%@ include file ="../rodape.jsp" %>
		</div>
	</body>
</html>
