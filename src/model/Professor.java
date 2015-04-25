package model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

@Entity
public class Professor extends Usuario{

	@ManyToMany(
			targetEntity = Disciplina.class,
			cascade = {CascadeType.PERSIST,CascadeType.MERGE})
	@JoinTable(
			name = "professor_disciplina",
			joinColumns = @JoinColumn (name = "id_professor"),
			inverseJoinColumns = @JoinColumn (name = "id_disciplina")
	)
	List<Disciplina> disciplinas;

	public List<Disciplina> getDisciplinas() {
		return disciplinas;
	}

	public void setDisciplinas(List<Disciplina> disciplinas) {
		this.disciplinas = disciplinas;
	}
		
}
