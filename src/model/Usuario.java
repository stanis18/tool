package model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import org.hibernate.validator.Email;
import org.hibernate.validator.NotEmpty;

@Entity
@Table(uniqueConstraints={
		@UniqueConstraint(columnNames="CPF"),
		@UniqueConstraint(columnNames="login")})
@Inheritance(strategy=InheritanceType.JOINED)
public class Usuario {
	
	@Id
	@GeneratedValue
	private Long id;
	
	@Column(length = 15)
	@NotEmpty(message = "O campo \"CPF\" deve ser preenchido.")
	private String CPF;
	
	@Column(length = 50)
	@NotEmpty(message = "O campo \"Login\" deve ser preenchido.")
	private String login;
	
	@Column(length = 20)
	private String senha;
	
	@Column (length = 200)
	@NotEmpty(message = "O campo \"Nome\" deve ser preenchido.")
	private String nome;
	
	@Column (length = 100)
	@NotEmpty(message = "O campo de \"E-mail\" deve ser preenchido.")
	@Email(message = "Insira um e-mail válido no campo de e-mail.")
	private String email;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCPF() {
		return CPF;
	}

	public void setCPF(String cpf) {
		CPF = cpf;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}	
	
}
