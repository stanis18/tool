package dao;

import java.util.List;

import model.Disciplina;
import model.Equipe;

import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

public class DaoEquipe extends Dao<Equipe> {

	public DaoEquipe(Session session) {
		super(Equipe.class, session);
	}
	
	public Equipe buscarEquipe(String nome) {
		return (Equipe) this.session.createCriteria(Equipe.class).add(Restrictions.like("nome", nome)).uniqueResult();
	}
	
	@SuppressWarnings("unchecked")
	public List<Equipe> listarEquipeSemProblemas() {
		String sql = "SELECT e.id, e.periodo, e.nome, e.disciplina_id, e.tutor_id FROM Equipe e where id not in (select equipe_id from Problema)";
		return this.session.createSQLQuery(sql).addEntity(Equipe.class).list();
	}

	@SuppressWarnings("unchecked")
	public List<Equipe> equipesDasDisciplinas(List<Disciplina> disciplinas) {
		return this.session.createCriteria(Equipe.class).add(Restrictions.in("disciplina", disciplinas)).list();
	}
	
}
