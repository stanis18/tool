package model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import org.hibernate.validator.NotEmpty;

@Entity
public class Aluno extends Usuario {

	private int periodo;
	
	@OneToMany(
			fetch=FetchType.LAZY, 
			cascade = CascadeType.ALL, 
			targetEntity = Avaliacao.class,
			mappedBy = "aluno")
	private List<Avaliacao> avaliacoes;

	@ManyToMany(
			fetch=FetchType.LAZY,
			targetEntity = Disciplina.class,
			cascade = {CascadeType.PERSIST,CascadeType.MERGE})
	@JoinTable(
			name = "aluno_disciplina",
			joinColumns = @JoinColumn (name = "id_aluno"),
			inverseJoinColumns = @JoinColumn (name = "id_disciplina")
	)
	@NotEmpty (message = "O aluno deve estar vinculado a algum módulo")
	private List<Disciplina> disciplinas;
	
	@ManyToMany(
			fetch=FetchType.LAZY,
			targetEntity = Equipe.class,
			cascade = {CascadeType.REFRESH, CascadeType.PERSIST, CascadeType.MERGE},
			mappedBy = "alunos")
	List<Equipe> equipe;
	
	public int getPeriodo() {
		return periodo;
	}

	public void setPeriodo(int periodo) {
		this.periodo = periodo;
	}

	public List<Avaliacao> getAvaliacoes() {
		return avaliacoes;
	}

	public void setAvaliacoes(List<Avaliacao> avaliacoes) {
		this.avaliacoes = avaliacoes;
	}

	public List<Disciplina> getDisciplinas() {
		return disciplinas;
	}

	public void setDisciplinas(List<Disciplina> disciplinas) {
		this.disciplinas = disciplinas;
	}

	public List<Equipe> getEquipe() {
		return equipe;
	}

	public void setEquipe(List<Equipe> equipe) {
		this.equipe = equipe;
	}
	
	

	
}
