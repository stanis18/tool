package dao;

import model.Professor;

import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import util.GerarSenhas;

public class DaoProfessor extends Dao<Professor> {

	public DaoProfessor(Session session) {
		super(Professor.class, session);
	}

	public Professor recuperarProfessorPorLogin(String login) {
		return (Professor) this.session.createCriteria(Professor.class).add(Restrictions.like("login", login)).uniqueResult();		
	}

	public Professor recuperarProfessorPorCPF(String CPF) {
		return (Professor) this.session.createCriteria(Professor.class).add(Restrictions.like("CPF", CPF)).uniqueResult();		
	}
	
	public Professor recuperarProfessorPorLogin(String login, Long id) {
		return (Professor) this.session.createCriteria(Professor.class).add(Restrictions.and(Restrictions.eq("login", login), Restrictions.not(Restrictions.eq("id", id)))).uniqueResult();		
	}

	public Professor recuperarProfessorPorCPF(String CPF, Long id) {
		return (Professor) this.session.createCriteria(Professor.class).add(Restrictions.and(Restrictions.eq("CPF", CPF), Restrictions.not(Restrictions.eq("id", id)))).uniqueResult();		
	}
	
	
	@Override
	public void adiciona(Professor professor) {
		if(professor.getSenha() == null || professor.getSenha().equals("")) {
			professor.setSenha(GerarSenhas.retornaSenha(professor.getNome()));
		}
		super.adiciona(professor);
	}
	
}
