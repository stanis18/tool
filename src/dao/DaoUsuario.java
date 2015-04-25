package dao;

import model.Usuario;

import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

public class DaoUsuario extends Dao<Usuario> {

	DaoUsuario( Session session) {
		super(Usuario.class, session);
	}

	public Usuario existeUnico(Usuario u) {
		return (Usuario) session.createCriteria(Usuario.class).add(Restrictions.and(Restrictions.eq("login", u.getLogin()), Restrictions.eq("senha", u.getSenha()))).uniqueResult();
	}
	
	public Usuario recuperarUsuarioPorLogin(String login) {
		return (Usuario) this.session.createCriteria(Usuario.class)
					.add(Restrictions.like("login", login)).uniqueResult();		
	}
	
}
