package model;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class MaterialGrafico {
	
	@Id
	@GeneratedValue
	private Long IdMaterialGrafico;
	
	private String legenda;
	
	private byte[] imagem;

	@ManyToOne(targetEntity=Problema.class, cascade=CascadeType.MERGE)
	private Problema problema;

	public Long getIdMaterialGrafico() {
		return IdMaterialGrafico;
	}

	public void setIdMaterialGrafico(Long idMaterialGrafico) {
		IdMaterialGrafico = idMaterialGrafico;
	}

	public String getLegenda() {
		return legenda;
	}

	public void setLegenda(String legenda) {
		this.legenda = legenda;
	}

	public byte[] getImagem() {
		return imagem;
	}

	public void setImagem(byte[] imagem) {
		this.imagem = imagem;
	}

	public Problema getProblema() {
		return problema;
	}

	public void setProblema(Problema problema) {
		this.problema = problema;
	}	

}
