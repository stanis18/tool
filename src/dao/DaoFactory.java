package dao;

import model.Avaliacao;
import model.Comentario;
import model.Glossario;
import model.MaterialGrafico;
import model.MaterialPesquisado;
import model.PalavraChave;
import model.PlanoDesenvolvimento;
import model.ReferenciaBibliografica;
import model.ReferenciaInicial;

import org.hibernate.Session;
import org.hibernate.Transaction;

import util.HibernateUtil;

public class DaoFactory {

	private final Session session;
	private Transaction transaction;
	
	public DaoFactory() {
		this.session = HibernateUtil.getSession();
	}
	
	public Session getSession() {
		return this.session;
	}
	
	public void beginTransaction() {
		this.transaction = this.session.beginTransaction();
	}

	public void commit() {
		this.transaction.commit();
		this.transaction = null;
	}

	public boolean hasTransaction() {
		return this.transaction != null;
	}

	public void rollback() {
		this.transaction.rollback();
		this.transaction = null;
	}

	public void close() {
		this.session.close();
	}
	
	public Transaction getTransaction() {
		return transaction;
	}

	public void setTransaction(Transaction transaction) {
		this.transaction = transaction;
	}

	public DaoDisciplina getDaoDisciplina() {
		return new DaoDisciplina(this.session);
	}
	
	public DaoPeriodo getDaoPeriodo() {
		return new DaoPeriodo(this.session);
	}
	
	public DaoEquipe getDaoEquipe() {
		return new DaoEquipe(this.session);
	}

	public DaoProblema getDaoProblema() {
		return new DaoProblema(this.session);
	}
	
	public Dao<Glossario> getDaoGlossario() {
		return new Dao<Glossario>(Glossario.class, this.session);
	}
	
	public Dao<ReferenciaBibliografica> getDaoReferenciaBibliografica() {
		return new Dao<ReferenciaBibliografica>(ReferenciaBibliografica.class, this.session);
	}
	
	public Dao<ReferenciaInicial> getDaoReferenciaInicial() {
		return new Dao<ReferenciaInicial>(ReferenciaInicial.class, this.session);
	}
	
	public Dao<PlanoDesenvolvimento> getDaoPlanoDesenvolvimento() {
		return new Dao<PlanoDesenvolvimento>(PlanoDesenvolvimento.class, this.session);
	}
	
	public Dao<MaterialPesquisado> getDaoMaterialPesquisado() {
		return new Dao<MaterialPesquisado>(MaterialPesquisado.class, this.session);
	}
	
	public Dao<Comentario> getDaoComentario() {
		return new Dao<Comentario>(Comentario.class, this.session);
	}
	
	public Dao<MaterialGrafico> getDaoMaterialGrafico() {
		return new Dao<MaterialGrafico>(MaterialGrafico.class, this.session);
	}

	public Dao<Avaliacao> getDaoAvaliacao() {
		return new Dao<Avaliacao>(Avaliacao.class, this.session);
	}
	
	public Dao<PalavraChave> getDaoPalavraChave() {
		return new Dao<PalavraChave>(PalavraChave.class, this.session);
	}

	// DAOs DE USUÁRIOS
	
	public DaoProfessor getDaoProfessor() {
		return new DaoProfessor(this.session);
	}
	
	public DaoAluno getDaoAluno() {
		return new DaoAluno(this.session);
	}
	
	public DaoUsuario getDaoUsuario() {
		return new DaoUsuario(this.session);
	}
	
	public DaoTutor getDaoTutor() {
		return new DaoTutor(this.session);
	}


}
