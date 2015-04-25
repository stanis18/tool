package util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import model.Avaliacao;
import model.Comentario;
import model.Professor;
import model.Tutor;
import model.Usuario;

public class TagLibrary {
	@SuppressWarnings("unchecked")
	public static boolean contains(Collection options, Object option) {
		boolean retorno = options == null ? false : (option == null) ? false
				: options.contains(option);
		return retorno;
	}
	
	public static boolean ehIgual(String texto, String texto2) {
		return texto.equals(texto2);
	}
	
	@SuppressWarnings("unchecked")
	public static boolean podeAvaliar(Collection avaliacoes) {
		boolean retorno = (avaliacoes.size() < 7);
		return retorno;
	}
	
	@SuppressWarnings("unchecked")
	public static boolean podeInserirPalavra(Collection palavras) {
		return (palavras.size() < 5);
	}

	@SuppressWarnings("unchecked")
	public static float media(Collection avaliacoes) {
		float soma = 0;
		int i = 0;
		for (Object object : avaliacoes) {
			float media = ((Avaliacao) object).getMedia();
			if(media != -1){
				soma += media;
				i++;				
			}
		}
		return (soma / i);
	}
	
	@SuppressWarnings("unchecked")
	public static String mediaAsString(Collection avaliacoes) {
		float soma = 0;
		int i = 0;
		for (Object object : avaliacoes) {
			float media = ((Avaliacao) object).getMedia();
			if(media != -1){
				soma += media;
				i++;				
			}
		}
		return String.valueOf((soma / i));
	}

	public static boolean temPermicaoParaEditar(Usuario usuario) {
		return ( (usuario instanceof Professor) || (usuario instanceof Tutor) );
	}
	
	public static List<Comentario> listarComentario(Collection<Comentario> comentarios, int secao) {
		List<Comentario> retorno = new ArrayList<Comentario>();
		for (Comentario comentario : comentarios) {
			if(comentario.getIdentificadorSecao() == secao) {
				retorno.add(comentario);
			}
		}
		return retorno;
	}
}