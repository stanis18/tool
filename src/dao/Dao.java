package dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

public class Dao<T> {
	protected Session session;
	@SuppressWarnings("unchecked")
	protected final Class classe;

	@SuppressWarnings("unchecked")
	Dao(Class classe, Session session){
		this.session = session;
		this.classe = classe;
	}

	public void adiciona(T objeto) {
		this.session.saveOrUpdate(objeto);
	}
	
	public void merge(T objeto) {
		this.session.merge(objeto);
	}
	
	public void update(T objeto) {
		this.session.update(objeto);
	}

	public void remover(T objeto){
		this.session.delete(objeto);
	}
	
	public void remover(Long codigo){
		this.session.delete(this.procura(codigo));
	}

	public void atualiza(T objeto){
		this.session.saveOrUpdate(objeto);
	}

	@SuppressWarnings("unchecked")
	public List<T> listaTudo(){
		return this.session.createCriteria(this.classe).list();
	}

	@SuppressWarnings("unchecked")
	public T procura(Long id){
		return (T) this.session.load(this.classe, id);
	}
	
	public void rebind(T objeto){
		this.session.refresh(objeto);
	}

	protected Session getSession(){
		return this.session;
	}
	
	@SuppressWarnings("unchecked")
	public List<T> consulta(String atributo, String query){
		return this.session.createCriteria(this.classe).add(Restrictions.ilike(atributo, "%" + query + "%")).list();
	}

	
}