<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/meutag.tld" prefix="comparar"%>
<html>
	
	<head>
	
		<title>CenAS: Cenários de Aprendizagem</title>
		<link rel="stylesheet" href="css/internas.css" />
	
		<script LANGUAGE="JavaScript">
	
			function insertOption(){
		        var select1 = document.getElementById("select1");
		        var select2 = document.getElementById("select2");
		        
		        var i = 0;
		        while(select1.selectedIndex >= 0){
		            var novo_option = document.createElement('option');
		            novo_option.text = select1.options[select1.selectedIndex].text;
		            novo_option.value = select1.options[select1.selectedIndex].value;
		           
		            try{
		                select2.add(novo_option, null); // standards compliant
		                select1.remove(select1.selectedIndex);
		            }
		            catch(ex){
		                select2.add(novo_option); // IE only
		                select1.remove(select1.selectedIndex);
		            }
		        
		        }
		            
		    }
		
			function removeOption(){
		        var select1 = document.getElementById("select2");
		        var select2 = document.getElementById("select1");
		        
		        var i = 0;
		        while(select1.selectedIndex >= 0){
		            var novo_option = document.createElement('option');
		            novo_option.text = select1.options[select1.selectedIndex].text;
		            novo_option.value = select1.options[select1.selectedIndex].value;
		           
		            try{
		                select2.add(novo_option, null); // standards compliant
		                select1.remove(select1.selectedIndex);
		            }
		            catch(ex){
		                select2.add(novo_option); // IE only
		                select1.remove(select1.selectedIndex);
		            }
		
		       }
		            
		    }
			
			function insertAllOption(){
				
		        var select1 = document.getElementById("select1");
		        var select2 = document.getElementById("select2");
		
		        for(var i = 0; i < select1.options.length; i++ )   {
		  	    	select1.options[i].selected = true;
		  	  	}
		        
		        var i = 0;
		        while(select1.length >= 0){
		            var novo_option = document.createElement('option');
		            novo_option.text = select1.options[select1.selectedIndex].text;
		            novo_option.value = select1.options[select1.selectedIndex].value;
		           
		            try{
		                select2.add(novo_option, null); // standards compliant
		                select1.remove(select1.selectedIndex);
		            }
		            catch(ex){
		                select2.add(novo_option); // IE only
		                select1.remove(select1.selectedIndex);
		            }  
		        }
		            
		    }
		
			function removeAllOption(){
		        var select1 = document.getElementById("select2");
		        var select2 = document.getElementById("select1");
		
		        for(var i = 0; i < select1.options.length; i++ )   {
		  	    	select1.options[i].selected = true;
		  	  	}
		        
		        var i = 0;
		        while(select1.length >= 0){
		            var novo_option = document.createElement('option');
		            novo_option.text = select1.options[select1.selectedIndex].text;
		            novo_option.value = select1.options[select1.selectedIndex].value;
		           
		            try{
		                select2.add(novo_option, null); // standards compliant
		                select1.remove(select1.selectedIndex);
		            }
		            catch(ex){
		                select2.add(novo_option); // IE only
		                select1.remove(select1.selectedIndex);
		            }  
		        }
			}
		
			// Garante que todos alunos serão cadastrados no problema
			function selecionarTodos() {
			  var select2 = document.getElementById("select2");
		      for( var i = 0; i < select2.options.length; i++ )   {
			    select2.options[i].selected = true;
			  }
			  return;
			}
			
			function alterarCampos(idw){
				if(idw != null && idw != ""){
					window.location= "professor.formularioEquipe.logic?disciplina.id=" + idw;
				}
			}
		
		</script>
	
	</head>
	
	<body>
	
	<form name="form1" method="post" action="professor.cadastrarEquipe.logic">
		
		<%@ include file="../cabecalho_disciplinas.jsp"%>
		
		<div id="corpo">
			
			<%@ include file ="cabecalho_local_prof.jsp" %>
					
			<div id="conteudo">
			
			<%
				String d2 = request.getParameter("disciplina.id");		
			%>

			<%@ include file="../erros.jsp" %>	

				<p>

					<b>Disciplina:</b> 
						<select name="equipe.disciplina.id" id="disciplinaf" onchange="alterarCampos(this.value);">
							<option value="" ></option>
							<c:forEach var="disc" items="${disciplinas}">
								<option value="${disc.id}"   <c:if test="${disc.id == disciplina.id}">selected="selected"</c:if>>
									${disc.chaveSiga} - ${disc.nome}
								</option>
							</c:forEach>
						</select>
				</p>
				<b>Nome da equipe:</b> <br />
				
				<input style="width: 100%;" type="text" name="equipe.nome" value="${equipe.nome}" /> 
			
				<br/>
				
				<br/>
				
				<b>Per&iacute;odo:</b> <br />
				<input size="7" name="equipe.periodo" type="text" <c:if test="${empty equipe.periodo}"> value="${periodo.periodo}" </c:if> <c:if test="${not empty equipe.periodo}"> value="${equipe.periodo}" </c:if> /> (Ex: "2009.1") <br />
				
					<br/>
					
					<b>Tutores dispon&iacute;veis:</b> 
					
					<br/>
					
					<select name="equipe.tutor.id" id="tutor" >
						<c:forEach var="tut" items="${tutores}">
							<option value="${tut.id}" <c:if test="${equipe.tutor.id == tut.id}">selected="true"</c:if>>${tut.nome}</option>
						</c:forEach>		
					</select> 
				
					<br/>
					
					<br/>
				
				<table summary="" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<b>Alunos dispon&iacute;veis:</b><br />
							
							<select multiple style="height:200px; width: 100px;" name="listLeft" id="select1">
								<c:if test="${not empty alunos}">
									<c:forEach var="aluno" items="${alunos}">
										<option value="${aluno.id}">${aluno.nome}</option>
									</c:forEach>
								</c:if>
							</select>
						</td>
							
							<td class="buttons">&nbsp; <input type="button" value="Adicionar" class="nov_pro_but" onclick="insertOption()" />
							&nbsp; <br /> &nbsp; 
							<input type="button" value="Remover" class="nov_pro_but"	onclick="removeOption()" />
							&nbsp; <br /> &nbsp; 
							<input type="button" value="Adicionar Todos" class="nov_pro_but" onclick="insertAllOption()" />
							&nbsp; <br /> &nbsp; 
							<input type="button" value="Remover Todos" class="nov_pro_but" onclick="removeAllOption()" />
							&nbsp;
						
						</td>
			
						<td>

							<b>Alunos envolvidos no problema:</b>
						
							<br />
			
							<select multiple="multiple" style="width:250px; height:200px;" name="equipe.alunos.id" id="select2">
								<c:if test="${not empty equipe.alunos}">
									<c:forEach var="aluno" items="${equipe.alunos}">
										<option value="${aluno.id}">${aluno.nome}</option>
									</c:forEach>
								</c:if>
							</select>
							
						</td>

					</tr>

				</table>

				<div style="margin-top:20px;">

					<input type="submit" class="button" value="Salvar" onclick="selecionarTodos()" /> &nbsp; 

				</div>

			</div>

			<%@ include file="../rodape.jsp"%>

		</div>

	</form>
	
	</body>

</html>