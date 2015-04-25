package logic;

import interceptor.AutorizadorTutorInterceptor;
import interceptor.DaoInterceptor;

import java.util.List;

import model.Aluno;
import model.Avaliacao;
import model.Equipe;
import model.Periodo;
import model.Tutor;
import model.Usuario;

import org.vraptor.annotations.Component;
import org.vraptor.annotations.In;
import org.vraptor.annotations.InterceptedBy;
import org.vraptor.annotations.Out;
import org.vraptor.scope.ScopeType;

import dao.DaoFactory;

@Component("tutor")
@InterceptedBy({DaoInterceptor.class, AutorizadorTutorInterceptor.class})
public class TutorLogic {

	private final DaoFactory factory;
	
	@In(scope = ScopeType.SESSION, required = true)
	private Usuario usuario;
	
	private Tutor tutor;
	
	@In(scope = ScopeType.SESSION, required = false)
	@Out(scope = ScopeType.SESSION)
	private Periodo periodo;
	
	private List<Aluno> alunos;
	
	private List<Equipe> equipes;
	
	private List<Avaliacao> avaliacoes;
	
	public TutorLogic(DaoFactory daoFactory) {
		this.factory = daoFactory;
	}
	
	//---- LÓGICA DO INÍCIO E MODIFICAÇÃO DE SENHA ----

	public void inicio() {
		this.tutor = this.factory.getDaoTutor().procura(this.usuario.getId());
		this.equipes = this.tutor.getEquipe();
	}
	
	public void formularioAlterarSenha() {
		
	}

	public void mudarSenha(Tutor tutor) {
		Tutor tutorTemporario = (Tutor) this.usuario;
		tutorTemporario.setSenha(tutor.getSenha());
		
		this.factory.beginTransaction();
		this.factory.getDaoTutor().adiciona(tutorTemporario);
		this.factory.commit();
	}
	
	
	
	//----------- GETTERS AND SETTERS -------------
	
	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	public DaoFactory getFactory() {
		return factory;
	}

	public Tutor getTutor() {
		return tutor;
	}

	public void setTutor(Tutor tutor) {
		this.tutor = tutor;
	}

	public List<Equipe> getEquipes() {
		return equipes;
	}

	public void setEquipes(List<Equipe> equipes) {
		this.equipes = equipes;
	}

	public List<Avaliacao> getAvaliacoes() {
		return avaliacoes;
	}

	public void setAvaliacoes(List<Avaliacao> avaliacoes) {
		this.avaliacoes = avaliacoes;
	}

	public List<Aluno> getAlunos() {
		return alunos;
	}

	public void setAlunos(List<Aluno> alunos) {
		this.alunos = alunos;
	}

	public Periodo getPeriodo() {
		return periodo;
	}

	public void setPeriodo(Periodo periodo) {
		this.periodo = periodo;
	}
	
	
}
