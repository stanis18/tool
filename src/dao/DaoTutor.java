package dao;

import java.util.List;

import model.Disciplina;
import model.Tutor;

import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import util.GerarSenhas;

public class DaoTutor extends Dao<Tutor> {

	public DaoTutor(Session session) {
		super(Tutor.class, session);
	}
	
	public Tutor recuperarTutorPorLogin(String login) {
		return (Tutor) this.session.createCriteria(Tutor.class)
					.add(Restrictions.like("login", login)).uniqueResult();		
	}
	
	public Tutor recuperarTutorPorCPF(String cpf) {
		return (Tutor) this.session.createCriteria(Tutor.class)
					.add(Restrictions.like("CPF", cpf)).uniqueResult();		
	}
	
	public Tutor recuperarTutorPorLogin(String login, Long id) {
		return (Tutor) this.session.createCriteria(Tutor.class)
					.add(Restrictions.and(Restrictions.like("login", login), Restrictions.not(Restrictions.eq("id", id)))).uniqueResult();		
	}
	
	public Tutor recuperarTutorPorCPF(String cpf, Long id) {
		return (Tutor) this.session.createCriteria(Tutor.class)
			.add(Restrictions.and(Restrictions.like("CPF", cpf), Restrictions.not(Restrictions.eq("id", id)))).uniqueResult();		
	}
	
	@SuppressWarnings("unchecked")
	public List<Tutor> listarTutoresSemEquipeNaDisciplina(Disciplina disciplina) {
		String sql = "SELECT t.id as id, us.CPF as CPF, us.nome as nome, us.login as login, us.senha as senha, us.email as email FROM Tutor t join Usuario us on (t.id = us.id) where t.id not in (select e.tutor_id from Equipe e where e.disciplina_id = ?) and t.id in (select td.id_tutor from tutor_disciplina td where td.id_disciplina = ?)";
		List<Tutor> tutores = (List<Tutor>) this.session.createSQLQuery(sql).addEntity(Tutor.class).setLong(0, disciplina.getId()).setLong(1, disciplina.getId()).list();
		return tutores;
	}
	
	@Override
	public void adiciona(Tutor tutor) {
		if(tutor.getSenha() == null || tutor.getSenha().equals("")) {
			tutor.setSenha(GerarSenhas.retornaSenha(tutor.getNome()));
		}
		super.adiciona(tutor);
	}
	
}
