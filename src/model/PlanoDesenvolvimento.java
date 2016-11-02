package model;

import java.text.SimpleDateFormat;
import java.util.Date;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import org.hibernate.validator.NotEmpty;

import util.DataFormato;

/**
 * @author RCM
 *
 */
@Entity
public class PlanoDesenvolvimento {
	
	@Id
	@GeneratedValue
	private Long idPlanoDesenvolvimento;
	
	@NotEmpty
	@Column(length = 2000)
	private String atividade;
	
	@Column(length = 500)
	private String localizacao;
	
	private Date dataPrevista;

	@ManyToOne(targetEntity=Problema.class, cascade=CascadeType.MERGE)
	private Problema problema;

	public Long getIdPlanoDesenvolvimento() {
		return idPlanoDesenvolvimento;
	}

	public void setIdPlanoDesenvolvimento(Long idPlanoDesenvolvimento) {
		this.idPlanoDesenvolvimento = idPlanoDesenvolvimento;
	}

	public String getAtividade() {
		return atividade;
	}

	public void setAtividade(String atividade) {
		this.atividade = atividade;
	}

	public String getLocalizacao() {
		return localizacao;
	}

	public void setLocalizacao(String localizacao) {
		this.localizacao = localizacao;
	}

	public Date getDataPrevista() {
		DataFormato dataFormato = new DataFormato();
		if(this.dataPrevista != null) {
			dataFormato.setTime(this.dataPrevista.getTime());
			return dataFormato;
		}
		return dataPrevista;
	}

	public void setDataPrevista(Date dataPrevista) {
		this.dataPrevista = dataPrevista;
	}

	public Problema getProblema() {
		return problema;
	}

	public void setProblema(Problema problema) {
		this.problema = problema;
	}
	
	public String getDataPrevistaFormatada(){
		if(this.dataPrevista == null) {
			SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
			return format.format(new Date());
		}else{
			SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
			return format.format(this.dataPrevista);
		}
	}
	
}
