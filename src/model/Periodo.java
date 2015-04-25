package model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import org.hibernate.validator.NotEmpty;

@Entity
public class Periodo {	
	
	@Id
	@GeneratedValue
	private Long idPeriodo;
	
	@NotEmpty (message = "O periodo deve ser informado.")
	private String periodo;

	private boolean atual;
	
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "periodo", targetEntity = Problema.class, fetch = FetchType.LAZY)
	private List<Problema> problemas;

	public Long getIdPeriodo() {
		return idPeriodo;
	}

	public void setIdPeriodo(Long idPeriodo) {
		this.idPeriodo = idPeriodo;
	}

	public String getPeriodo() {
		return periodo;
	}

	public void setPeriodo(String periodo) {
		this.periodo = periodo;
	}

	public boolean isAtual() {
		return atual;
	}

	public void setAtual(boolean atual) {
		this.atual = atual;
	}

	public List<Problema> getProblemas() {
		return problemas;
	}

	public void setProblemas(List<Problema> problemas) {
		this.problemas = problemas;
	}


		
}
