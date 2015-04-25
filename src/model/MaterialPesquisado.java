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
public class MaterialPesquisado {

	@Id
	@GeneratedValue
	private Long idMaterialPesquisado;

	@Column(length = 3000)
	private String material;
	
	@Column(length = 300)
	private String link;

	private Date dataAcesso;

	@ManyToOne(targetEntity=Problema.class, cascade=CascadeType.MERGE)
	private Problema problema;

	public Long getIdMaterialPesquisado() {
		return idMaterialPesquisado;
	}

	public void setIdMaterialPesquisado(Long idMaterialPesquisado) {
		this.idMaterialPesquisado = idMaterialPesquisado;
	}

	public String getMaterial() {
		return material;
	}

	public void setMaterial(String material) {
		this.material = material;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public Date getDataAcesso() {
		DataFormato dataFormato = new DataFormato();
		if(this.dataAcesso != null) {
			dataFormato.setTime(dataAcesso.getTime());
			return dataFormato;
		}
		return dataAcesso;
	}

	public void setDataAcesso(Date dataAcesso) {
		this.dataAcesso = dataAcesso;
	}

	public Problema getProblema() {
		return problema;
	}

	public void setProblema(Problema problema) {
		this.problema = problema;
	}

}
