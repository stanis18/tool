package dao;

import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import model.Disciplina;

public class DaoDisciplina extends Dao<Disciplina>{

	public DaoDisciplina(Session session) {
		super(Disciplina.class, session);
	}
	
	public Disciplina procurarPorChaveSiga(String chaveSiga) {
		return (Disciplina) this.session.createCriteria(this.classe)
			.add(Restrictions.eq("chaveSiga", chaveSiga)).uniqueResult();
	}
	
}
