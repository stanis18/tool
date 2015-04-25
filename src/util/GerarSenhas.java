/**
  * Projeto Intramed
  *
  * Created on 01/09/2004
  * 
  * TIS - Nutes
  * 
  * ----------------------------------------
  * 
  * @version 3.0
  * 
  * @author: Francielle
  *
  * @modified: 01/09/2004  
  * 
  * ----------------------------------------
  * 
  * @version 4.0
  * 
  * @author: Thiago Pachêco Andrade Pereira 
  * 
  * @modified: 12/04/2007
  * 
  * ----------------------------------------
  * 
  */
package util;



// TODO: Auto-generated Javadoc
/**
 * Classe auxiliar para gerar senhas.
 */
public class GerarSenhas {

	/**
	 * Método auxiliar que gera um array de senhas aleatorias.
	 * 
	 * @param nome Nome do usuario pra o qual vai ser criado a senha, a partir do nome a senha é gerada.
	 * 
	 * @return Array onde a posição [1] dele é uma senha aleatória.
	 */
	
	
	
	public String[] gereSenha(String nome){
		int numero;
		String senha = ""; 
	    String[] retorno = new String[2];
	    char[] alfabeto = {'a','b','c','d','e', 'f', 'g','h','i','j','k', 'l',
	    					'm','n','o','p','q','r','s','t','u','v','w','x','y','z'};
	    for(int i = 0; i < 4; i++){
		    numero = 1 + (int) (Math.random() * 1000);
		    //System.out.println(numero);
		    if(i % 2 == 0){
		    	numero = numero % 26;
		    	senha += alfabeto[numero];
		    }else{
		        numero = numero % 10;
		        senha += numero;
		    }
		}
	    retorno[0] = nome;
    	retorno[1] = senha;
  
	    return retorno;
	}
	
	

	/**
	 * Retorna um senha aleatoria.
	 * 
	 * @param nome Nome do usuario pra o qual vai ser criado a senha, a partir do nome a senha é gerada. 
	 * 
	 * @return Senha aleatória.
	 */
	public static String retornaSenha(String nome) {
		GerarSenhas g = new GerarSenhas();
		
		
		String[] retorno = g.gereSenha(nome);
		
		
		
                return retorno[1];
			
	}
}
