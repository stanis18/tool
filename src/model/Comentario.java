package model;

import java.sql.Timestamp;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Comentario {

	@Id
	@GeneratedValue
	private Long idComentario;

	@Column(length = 2000)
	private String descricao;

	private Timestamp dataComentario;
	
	/*
	 * Relatorio 1
	 * Recomendacoes 2
	 * Conclusoes 3
	 * Resumo 4
	 */
	private int identificadorSecao;

	@ManyToOne(targetEntity=Problema.class, cascade=CascadeType.MERGE)
	private Problema problema;

	public Long getIdComentario() {
		return idComentario;
	}

	public void setIdComentario(Long idComentario) {
		this.idComentario = idComentario;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	@SuppressWarnings("deprecation")
	public String getDataComentario() {
		return dataComentario.toLocaleString();
	}

	public void setDataComentario(Timestamp dataComentario) {
		this.dataComentario = dataComentario;
	}

	public Problema getProblema() {
		return problema;
	}

	public void setProblema(Problema problema) {
		this.problema = problema;
	}

	public int getIdentificadorSecao() {
		return identificadorSecao;
	}

	public void setIdentificadorSecao(int identificadorSecao) {
		this.identificadorSecao = identificadorSecao;
	}
			
}
