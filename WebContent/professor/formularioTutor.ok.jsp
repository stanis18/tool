<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/meutag.tld" prefix="m" %>
<html>
    
    <head>        
        <link rel="stylesheet" href="css/internas.css" />
		<title>CenAS: Cenários de Aprendizagem</title>
    </head>
    
    <body>
        
        <%@ include file ="../cabecalho_disciplinas.jsp" %>
        
        <div id="corpo">
                    
        <%@ include file ="cabecalho_local_prof.jsp" %>            
            
            <div id="conteudo">

				<%@ include file="menuTutor.jsp" %>          
				
				<%@ include file="../erros.jsp" %>

                <div style="display: table">
                
                 <form name="form" action="professor.cadastrarTutor.logic" method="post" onsubmit="return confirma(this)">   
                    <input type="hidden" name="tutor.id" value="${tutor.id}" /> 
					<input type="hidden" name="tutor.senha" value="${tutor.senha}"/> 
					<table id="dados" style="text-align: left; width: 500px" class="dados" >
                        <tr>
                            <td class="title">Nome</td>
                            <td class="content3"><input name="tutor.nome" value="${tutor.nome}"  size="60" /></td>
                        </tr>
                        <tr>
                            <td class="title">CPF:</td>
                            <td class="content3"><input name="tutor.CPF" value="${tutor.CPF}" size="20" /></td>
                        </tr>
                      
                        <tr>
                            <td class="title">Login:</td>
                            <td class="content3"><input name="tutor.login" value="${tutor.login}" size="10"/></td>
                        </tr>
                        <tr>
                            <td class="title">Email:</td>
                            <td class="content3"><input name="tutor.email" value="${tutor.email}" size="30"/></td>
                        </tr>
						<tr>
							<td class="title">Disciplina(s):</td>
							<td class="content3">
								<c:forEach var="disciplina" items="${disciplinas}">
										<input type="checkbox" id="checkBox" name="tutor.disciplinas.id" value="${disciplina.id}"
										<c:if test="${m:contains(tutor.disciplinas, disciplina)}">checked="true"</c:if>/>${disciplina.nome}<br/>
								</c:forEach>			
							</td>
						</tr>	
                        <tr>
                            <td class="actions" colspan="2">
                                <input type="submit" value="Salvar" class="button"  />&nbsp; <!--onclick="confirmBox()"-->
                                <input type="button" value="Cancelar" onclick="javascript:window.open('professor.listarTutor.logic','_self');" class="button" />&nbsp;
                            </td>
                        </tr>


                    </table>
                    
                    </form>
               
                
                
             </div>   
                
            </div>
            <%@ include file ="../rodape.jsp" %>
            
        </div>
        
    </body>
    
</html>
