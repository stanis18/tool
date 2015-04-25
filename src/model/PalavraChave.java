package model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import org.hibernate.validator.NotEmpty;

@Entity
public class PalavraChave {
	
	@Id
	@GeneratedValue
	private Long idPalavraChave;
	
	@NotEmpty
	@Column(length = 200)
	private String palavra;
	
	@ManyToOne(targetEntity=Problema.class, cascade=CascadeType.MERGE)
	private Problema problema;

	public Long getIdPalavraChave() {
		return idPalavraChave;
	}

	public void setIdPalavraChave(Long idPalavraChave) {
		this.idPalavraChave = idPalavraChave;
	}

	public String getPalavra() {
		return palavra;
	}

	public void setPalavra(String palavra) {
		this.palavra = palavra;
	}

	public Problema getProblema() {
		return problema;
	}

	public void setProblema(Problema problema) {
		this.problema = problema;
	}

}
