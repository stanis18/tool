package model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

/**
 * @author RCM
 *
 */
@Entity
public class Tutor extends Usuario {

	@ManyToMany(
			cascade = {CascadeType.PERSIST, CascadeType.MERGE},
			targetEntity = Disciplina.class,
			fetch = FetchType.LAZY
	)
	@JoinTable(
			name = "tutor_disciplina",
			joinColumns = @JoinColumn (name = "id_tutor"),
			inverseJoinColumns = @JoinColumn (name = "id_disciplina")
	)
	List<Disciplina> disciplinas;
	
	@OneToMany(
			fetch = FetchType.LAZY,
			targetEntity = Equipe.class,
			cascade = {CascadeType.MERGE, CascadeType.PERSIST},
			mappedBy = "tutor")
	List<Equipe> equipe;

	public List<Disciplina> getDisciplinas() {
		return disciplinas;
	}

	public void setDisciplinas(List<Disciplina> disciplinas) {
		this.disciplinas = disciplinas;
	}

	public List<Equipe> getEquipe() {
		return equipe;
	}

	public void setEquipe(List<Equipe> equipe) {
		this.equipe = equipe;
	}
	
}
