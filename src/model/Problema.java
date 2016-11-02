package model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.OrderBy;

import org.hibernate.validator.NotEmpty;

@Entity
public class Problema implements Serializable{
	
	@Id
	@GeneratedValue
	private Long idProblema;

	@Column(length = 500)
	@NotEmpty(message = "� necess�rio que um titulo seja fornecido antes de cadastrar o problema.")
	private String titulo;

	@Column(length = 20000)
	private String cenario;

	@Column(length = 20000)
	private String objetivos;

	@Column(length = 20000)
	private String justificativa;

	@Column(length = 20000)
	private String conclusaoAvaliacao;

	@Column(length = 20000)
	private String recomendacoes;

	@Column(length = 120000)
	private String descricao;

	@Column(length = 60000)
	private String resumo;
	
	private int aberto;
	
	@OneToOne(targetEntity = Equipe.class)
	private Equipe equipe;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "problema", targetEntity = Comentario.class, fetch = FetchType.LAZY)
	@OrderBy("dataComentario DESC")
	private List<Comentario> comentarios;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "problema", targetEntity = Glossario.class, fetch = FetchType.LAZY)
	private List<Glossario> glossarios;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "problema", targetEntity = ReferenciaInicial.class, fetch = FetchType.LAZY)
	private List<ReferenciaInicial> referenciasInicial;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "problema", targetEntity = ReferenciaBibliografica.class, fetch = FetchType.LAZY)
	private List<ReferenciaBibliografica> referenciasBibliografica;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "problema", targetEntity = MaterialGrafico.class, fetch = FetchType.LAZY)
	private List<MaterialGrafico> materiaisGrafico;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "problema", targetEntity = MaterialPesquisado.class, fetch = FetchType.LAZY)
	private List<MaterialPesquisado> materiaisPesquisado;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "problema", targetEntity = PlanoDesenvolvimento.class, fetch = FetchType.LAZY)
	@OrderBy("dataPrevista ASC")
	private List<PlanoDesenvolvimento> planosDesenvolvimento;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "problema", targetEntity = PalavraChave.class, fetch = FetchType.LAZY)
	private List<PalavraChave> palavrasChave;

	@ManyToOne(targetEntity = Disciplina.class, cascade = CascadeType.MERGE)
	private Disciplina disciplina;

	@ManyToOne(targetEntity = Periodo.class, cascade = CascadeType.MERGE)
	private Periodo periodo;

	public Long getIdProblema() {
		return idProblema;
	}

	public void setIdProblema(Long idProblema) {
		this.idProblema = idProblema;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getCenario() {
		return cenario;
	}

	public void setCenario(String cenario) {
		this.cenario = cenario;
	}

	public String getObjetivos() {
		return objetivos;
	}

	public void setObjetivos(String objetivos) {
		this.objetivos = objetivos;
	}

	public String getJustificativa() {
		return justificativa;
	}

	public void setJustificativa(String justificativa) {
		this.justificativa = justificativa;
	}

	public String getConclusaoAvaliacao() {
		return conclusaoAvaliacao;
	}

	public void setConclusaoAvaliacao(String conclusaoAvaliacao) {
		this.conclusaoAvaliacao = conclusaoAvaliacao;
	}

	public String getRecomendacoes() {
		return recomendacoes;
	}

	public void setRecomendacoes(String recomendacoes) {
		this.recomendacoes = recomendacoes;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public int getAberto() {
		return aberto;
	}

	public void setAberto(int aberto) {
		this.aberto = aberto;
	}

	public Equipe getEquipe() {
		return equipe;
	}

	public void setEquipe(Equipe equipe) {
		this.equipe = equipe;
	}

	public List<Comentario> getComentarios() {
		return comentarios;
	}

	public void setComentarios(List<Comentario> comentarios) {
		this.comentarios = comentarios;
	}

	public List<Glossario> getGlossarios() {
		return glossarios;
	}

	public void setGlossarios(List<Glossario> glossarios) {
		this.glossarios = glossarios;
	}

	public List<ReferenciaInicial> getReferenciasInicial() {
		return referenciasInicial;
	}

	public void setReferenciasInicial(List<ReferenciaInicial> referenciasInicial) {
		this.referenciasInicial = referenciasInicial;
	}

	public List<ReferenciaBibliografica> getReferenciasBibliografica() {
		return referenciasBibliografica;
	}

	public void setReferenciasBibliografica(
			List<ReferenciaBibliografica> referenciasBibliografica) {
		this.referenciasBibliografica = referenciasBibliografica;
	}

	public List<MaterialGrafico> getMateriaisGrafico() {
		return materiaisGrafico;
	}

	public void setMateriaisGrafico(List<MaterialGrafico> materiaisGrafico) {
		this.materiaisGrafico = materiaisGrafico;
	}

	public List<MaterialPesquisado> getMateriaisPesquisado() {
		return materiaisPesquisado;
	}

	public void setMateriaisPesquisado(List<MaterialPesquisado> materiaisPesquisado) {
		this.materiaisPesquisado = materiaisPesquisado;
	}

	public List<PlanoDesenvolvimento> getPlanosDesenvolvimento() {
		return planosDesenvolvimento;
	}

	public void setPlanosDesenvolvimento(
			List<PlanoDesenvolvimento> planosDesenvolvimento) {
		this.planosDesenvolvimento = planosDesenvolvimento;
	}

	public List<PalavraChave> getPalavrasChave() {
		return palavrasChave;
	}

	public void setPalavrasChave(List<PalavraChave> palavrasChave) {
		this.palavrasChave = palavrasChave;
	}

	public Disciplina getDisciplina() {
		return disciplina;
	}

	public void setDisciplina(Disciplina disciplina) {
		this.disciplina = disciplina;
	}

	public Periodo getPeriodo() {
		return periodo;
	}

	public void setPeriodo(Periodo periodo) {
		this.periodo = periodo;
	}

	public String getResumo() {
		return resumo;
	}

	public void setResumo(String resumo) {
		this.resumo = resumo;
	}
	
}
