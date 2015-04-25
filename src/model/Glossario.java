package model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Glossario {

	@Id
	@GeneratedValue
	private Long idGlossario;
	
	@Column(length = 2000)
	private String descricao;
	
	@Column(length = 300)
	private String termo;
	
	@ManyToOne(targetEntity=Problema.class, cascade=CascadeType.MERGE)
	private Problema problema;

	public Long getIdGlossario() {
		return idGlossario;
	}

	public void setIdGlossario(Long idGlossario) {
		this.idGlossario = idGlossario;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String getTermo() {
		return termo;
	}

	public void setTermo(String termo) {
		this.termo = termo;
	}

	public Problema getProblema() {
		return problema;
	}

	public void setProblema(Problema problema) {
		this.problema = problema;
	}
	
	
}
