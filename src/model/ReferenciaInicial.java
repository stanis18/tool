package model;

import java.util.Date;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import util.DataFormato;

@Entity
public class ReferenciaInicial {
	
	@Id
	@GeneratedValue
	private Long id;
	
	@Column(length = 300)
	private String titulo;
	
	@Column(length = 2000)
	private String descricao;
	
	@Column(length = 300)
	private String url;
	
	private Date dataAcesso;
	
	private String editora;
	
	private String edicao;
	
	private String ano;
	
	private String autor;
	
	@ManyToOne(targetEntity=Problema.class, cascade=CascadeType.MERGE)
	private Problema problema;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public DataFormato getDataAcesso() {
		DataFormato dataFormato = new DataFormato();
		if(dataAcesso != null) {
			dataFormato.setTime(this.dataAcesso.getTime());
			return dataFormato;
		}
		return null;
	}

	public void setDataAcesso(Date dataAcesso) {
		this.dataAcesso = dataAcesso;
	}

	public String getEditora() {
		return editora;
	}

	public void setEditora(String editora) {
		this.editora = editora;
	}

	public String getEdicao() {
		return edicao;
	}

	public void setEdicao(String edicao) {
		this.edicao = edicao;
	}

	public String getAno() {
		return ano;
	}

	public void setAno(String ano) {
		this.ano = ano;
	}

	public String getAutor() {
		return autor;
	}

	public void setAutor(String autor) {
		this.autor = autor;
	}

	public Problema getProblema() {
		return problema;
	}

	public void setProblema(Problema problema) {
		this.problema = problema;
	}
		
}

