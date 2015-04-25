package dao;

import org.hibernate.Session;

import model.Problema;

public class DaoProblema extends Dao<Problema> {

	public DaoProblema(Session session) {
		super(Problema.class, session);
	}


}
