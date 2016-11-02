package dao;

import model.MaterialGrafico;

import org.hibernate.SQLQuery;
import org.hibernate.Session;

public class DaoMaterialGrafico extends Dao<MaterialGrafico> {

	DaoMaterialGrafico( Session session) {
		super(MaterialGrafico.class, session);
	}

	
	public int atualizaLegenda(Long idMaterialGrafico, String legenda){
		String sql = "UPDATE MaterialGrafico SET legenda = '"+legenda+"' where IdMaterialGrafico = "+idMaterialGrafico;
		SQLQuery query = session.createSQLQuery(sql);
		
		return query.executeUpdate();
	}
}
