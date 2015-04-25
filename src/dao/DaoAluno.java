package dao;

import java.util.ArrayList;
import java.util.List;

import model.Aluno;
import model.Disciplina;

import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import util.GerarSenhas;

public class DaoAluno extends Dao<Aluno> {

	DaoAluno( Session session) {
		super(Aluno.class, session);
	}

	@Override
	public void adiciona(Aluno aluno) {
		if(aluno.getSenha() == null || aluno.getSenha().equals("")) {
			aluno.setSenha(GerarSenhas.retornaSenha(aluno.getNome()));
		}
		super.adiciona(aluno);
	}
	
	public Aluno recuperarAlunoPorLogin(String login) {
		return (Aluno) this.session.createCriteria(Aluno.class).add(Restrictions.like("login", login)).uniqueResult();
	}

	public Aluno recuperarAlunoPorLogin(String login, Long id) {
		return (Aluno) this.session.createCriteria(Aluno.class).add(Restrictions.and(Restrictions.eq("login", login), Restrictions.not(Restrictions.eq("id", id)))).uniqueResult();
	}
	
	public Aluno recuperarAlunoPorCPF(String cpf) {
		return (Aluno) this.session.createCriteria(Aluno.class).add(Restrictions.like("CPF", cpf)).uniqueResult();
	}
	
	public Aluno recuperarAlunoPorCPF(String cpf, Long id) {
		return (Aluno) this.session.createCriteria(Aluno.class).add(Restrictions.and(Restrictions.like("CPF", cpf), Restrictions.not(Restrictions.eq("id", id)))).uniqueResult();
	}
	
	@SuppressWarnings("unchecked")
	public List<Aluno> listarAlunoEmOrdemAlfabetica() {
		return (List<Aluno>) this.session.createCriteria(Aluno.class).addOrder(Order.asc("nome")).list();
	}
		
	@SuppressWarnings("unchecked")
	public List<Aluno> listarAlunosSemEquipeNaDisciplina(Disciplina disciplina) {
		String sql = "SELECT al.id as id, us.CPF as CPF, al.periodo as periodo, us.nome as nome, us.login as login, us.senha as senha, us.email as email FROM Aluno al join Usuario us on (al.id = us.id) where al.id not in (select ae.id_aluno from aluno_equipe ae, Equipe eq where ae.id_equipe = eq.id and eq.disciplina_id = ?) and al.id in (select ad.id_aluno from aluno_disciplina ad where ad.id_disciplina = ?);";
		ArrayList<Aluno> alunos = (ArrayList<Aluno>) this.session.createSQLQuery(sql).addEntity(Aluno.class).setLong(0, disciplina.getId()).setLong(1, disciplina.getId()).list();
		return alunos;
	}
	
	public void remover(Long codigo){
		this.session.createSQLQuery("delete from aluno_equipe where id_aluno = " + codigo).executeUpdate();
		this.session.delete(this.procura(codigo));
	}
}
