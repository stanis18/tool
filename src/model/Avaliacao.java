package model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import org.hibernate.validator.NotEmpty;

@Entity
public class Avaliacao {
	
	@Id
	@GeneratedValue
	private Long idAvaliacao;
	@Column(length = 5)
	@NotEmpty(message = "A nota do Domínio Afetivo não pode ser vazia")
	private String dominioAcademico;
	@Column(length = 5)
	@NotEmpty(message = "A nota do Domínio Cognitivo não pode ser vazia")
	private String dominioCognitivo;
	
	private Float media;
	
	@ManyToOne(cascade={CascadeType.MERGE, CascadeType.PERSIST}, targetEntity = Aluno.class)
	private Aluno aluno;

	public Long getIdAvaliacao() {
		return idAvaliacao;
	}

	public void setIdAvaliacao(Long idAvaliacao) {
		this.idAvaliacao = idAvaliacao;
	}

	public String getDominioAcademico() {
		return dominioAcademico;
	}

	public void setDominioAcademico(String dominioAcademico) {
		this.dominioAcademico = dominioAcademico;
	}

	public String getDominioCognitivo() {
		return dominioCognitivo;
	}

	public void setDominioCognitivo(String dominioCognitivo) {
		this.dominioCognitivo = dominioCognitivo;
	}

	public Float getMedia() {
		return media;
	}

	public void setMedia(Float media) {
		this.media = media;
	}

	public Aluno getAluno() {
		return aluno;
	}

	public void setAluno(Aluno aluno) {
		this.aluno = aluno;
	}	
}
