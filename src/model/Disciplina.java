package model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import org.hibernate.validator.NotEmpty;

@Entity
@Table(uniqueConstraints = { @UniqueConstraint(columnNames = { "chaveSiga" }) })
public class Disciplina {

	@Id
	@GeneratedValue
	private Long id;

	@Column(length = 10)
	@NotEmpty(message = "O campo \"Chave Siga\" deve ser preenchido")
	private String chaveSiga;

	@Column(length = 100)
	@NotEmpty(message = "O campo \"Nome\" deve ser preenchido")
	private String nome;

	@Column(length = 100)
	private String departamento;

	private Integer chTeorica;

	private Integer chPratica;

	private Integer credito;

	@Column(length = 2000)
	private String avaliacao;

	@Column(length = 2000)
	private String objetivo;

	@ManyToMany(fetch = FetchType.LAZY, targetEntity = Professor.class, cascade = {
			CascadeType.MERGE, CascadeType.PERSIST }, mappedBy = "disciplinas")
	private List<Professor> professores;

	@ManyToMany(fetch = FetchType.LAZY, targetEntity = Tutor.class, cascade = {
			CascadeType.MERGE, CascadeType.PERSIST }, mappedBy = "disciplinas")
	private List<Tutor> tutores;

	@ManyToMany(fetch = FetchType.LAZY, cascade = { CascadeType.PERSIST,
			CascadeType.MERGE }, targetEntity = Aluno.class, mappedBy = "disciplinas")
	private List<Aluno> alunos;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "disciplina", targetEntity = Problema.class, fetch = FetchType.LAZY)
	private List<Problema> problemas;
	
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "disciplina", targetEntity = Equipe.class, fetch = FetchType.LAZY)
	private List<Equipe> equipes;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getChaveSiga() {
		return chaveSiga;
	}

	public void setChaveSiga(String chaveSiga) {
		this.chaveSiga = chaveSiga;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getDepartamento() {
		return departamento;
	}

	public void setDepartamento(String departamento) {
		this.departamento = departamento;
	}

	public Integer getChTeorica() {
		return chTeorica;
	}

	public void setChTeorica(Integer chTeorica) {
		this.chTeorica = chTeorica;
	}

	public Integer getChPratica() {
		return chPratica;
	}

	public void setChPratica(Integer chPratica) {
		this.chPratica = chPratica;
	}

	public Integer getCredito() {
		return credito;
	}

	public void setCredito(Integer credito) {
		this.credito = credito;
	}

	public String getAvaliacao() {
		return avaliacao;
	}

	public void setAvaliacao(String avaliacao) {
		this.avaliacao = avaliacao;
	}

	public String getObjetivo() {
		return objetivo;
	}

	public void setObjetivo(String objetivo) {
		this.objetivo = objetivo;
	}

	public List<Professor> getProfessores() {
		return professores;
	}

	public void setProfessores(List<Professor> professores) {
		this.professores = professores;
	}

	public List<Tutor> getTutores() {
		return tutores;
	}

	public void setTutores(List<Tutor> tutores) {
		this.tutores = tutores;
	}

	public List<Aluno> getAlunos() {
		return alunos;
	}

	public void setAlunos(List<Aluno> alunos) {
		this.alunos = alunos;
	}

	public List<Problema> getProblemas() {
		return problemas;
	}

	public void setProblemas(List<Problema> problemas) {
		this.problemas = problemas;
	}

	public List<Equipe> getEquipes() {
		return equipes;
	}

	public void setEquipes(List<Equipe> equipes) {
		this.equipes = equipes;
	}

	
	
}
