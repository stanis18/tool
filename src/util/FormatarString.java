package util;

import java.util.Collection;

import org.jsoup.Jsoup;

import model.Aluno;
import model.PalavraChave;

public class FormatarString {
	
	public static java.lang.String formatarString(java.lang.String texto) {
		return texto.replace("\n", "<br/>"); 
	}
	
	@SuppressWarnings("unchecked")
	public static String listarNomes(Collection alunos) {
		String retorno = "";
		
		for (Object object : alunos) {
			retorno +=	((Aluno) object).getNome() + ", ";
		}
		
		return retorno.substring(0, retorno.length() - 2);
	}
	
	@SuppressWarnings("unchecked")
	public static String listarPalavras(Collection palavras) {
		String retorno = "";
		
		for (Object object : palavras) {
			retorno +=	((PalavraChave) object).getPalavra() + ", ";
		}
		
		return retorno.substring(0, retorno.length() - 2);
	}
	
	@SuppressWarnings("unchecked")
	public static String retirarTags(String legenda) {
		
		return Jsoup.parse(legenda).text();
	}
}
