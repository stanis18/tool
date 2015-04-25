package dao;

import org.hibernate.Query;
import org.hibernate.Session;

import model.Periodo;

public class DaoPeriodo extends Dao<Periodo> {

	public DaoPeriodo(Session session) {
		super(Periodo.class, session);
	}

	public Periodo carregar() {
		
		String hql = "from Periodo p where p.idPeriodo = :periodo";
		Query query = session.createQuery(hql);
		query.setLong("periodo", 1);
		return (Periodo) query.uniqueResult();
	}
	
}
