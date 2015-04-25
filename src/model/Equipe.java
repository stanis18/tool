package model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import org.hibernate.validator.NotEmpty;

@Entity
public class Equipe {

	@Id
	@GeneratedValue
	private Long id;

	@NotEmpty(message = "Indique qual o períod que a equipe pertence.")
	private String periodo;

	@NotEmpty(message = "É impossível registrar uma equipe sem nome.")
	private String nome;
	
	@OneToOne(targetEntity = Problema.class, mappedBy="equipe")
	private Problema problema;
	
	@ManyToMany(
			cascade = {CascadeType.PERSIST, CascadeType.MERGE},
			targetEntity = Aluno.class,
			fetch = FetchType.LAZY
	)
	@JoinTable(
			name = "aluno_equipe",
			joinColumns = @JoinColumn (name = "id_equipe"),
			inverseJoinColumns = @JoinColumn (name = "id_aluno")
	)
	private List<Aluno> alunos;

	@ManyToOne(
			cascade = {CascadeType.PERSIST, CascadeType.MERGE},
			targetEntity = Tutor.class,
			fetch = FetchType.LAZY
	)
	private Tutor tutor;

	@ManyToOne(
			cascade = {CascadeType.PERSIST, CascadeType.MERGE},
			targetEntity = Disciplina.class,
			fetch = FetchType.LAZY
	)
	private Disciplina disciplina;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getPeriodo() {
		return periodo;
	}

	public void setPeriodo(String periodo) {
		this.periodo = periodo;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public Problema getProblema() {
		return problema;
	}

	public void setProblema(Problema problema) {
		this.problema = problema;
	}

	public List<Aluno> getAlunos() {
		return alunos;
	}

	public void setAlunos(List<Aluno> alunos) {
		this.alunos = alunos;
	}

	public Tutor getTutor() {
		return tutor;
	}

	public void setTutor(Tutor tutor) {
		this.tutor = tutor;
	}

	public Disciplina getDisciplina() {
		return disciplina;
	}

	public void setDisciplina(Disciplina disciplina) {
		this.disciplina = disciplina;
	}
	
}
