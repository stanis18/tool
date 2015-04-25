/*     */ package logic;
/*     */ 
/*     */ import interceptor.AutorizadorAdministradorInterceptor;
import interceptor.DaoInterceptor;

import java.util.List;

import model.Aluno;
import model.Disciplina;
import model.Periodo;
import model.Professor;
import model.Usuario;

import org.vraptor.annotations.Component;
import org.vraptor.annotations.In;
import org.vraptor.annotations.InterceptedBy;
import org.vraptor.annotations.Out;
import org.vraptor.i18n.FixedMessage;
import org.vraptor.plugin.hibernate.Validate;
import org.vraptor.scope.ScopeType;
import org.vraptor.validator.ValidationErrors;

import dao.DaoFactory;
/*     */ 
/*     */ @Component("admin")
/*     */ @InterceptedBy({DaoInterceptor.class, AutorizadorAdministradorInterceptor.class})
/*     */ public class AdminLogic
/*     */ {
/*     */ 
/*     */   @In(scope=ScopeType.SESSION, required=true)
/*     */   private Usuario usuario;
/*     */   private final DaoFactory factory;
/*     */   Aluno aluno;
/*     */   List<Aluno> alunos;
/*     */   Professor professor;
/*     */   List<Professor> professores;
/*     */   Disciplina disciplina;
/*     */   List<Disciplina> disciplinas;
/*     */ 
/*     */   @In(scope=ScopeType.SESSION, required=false)
/*     */   @Out(scope=ScopeType.SESSION)
/*     */   private Periodo periodo;
/*     */ 
/*     */   public AdminLogic(DaoFactory factory)
/*     */   {
/*  56 */     this.factory = factory;
/*     */   }
/*     */ 
/*     */   public void inicio()
/*     */   {
/*  62 */     this.alunos = this.factory.getDaoAluno().listarAlunoEmOrdemAlfabetica();
/*  63 */     this.periodo = this.factory.getDaoPeriodo().carregar();
/*     */   }
/*     */ 
/*     */   public void formularioAlterarSenha()
/*     */   {
/*     */   }
/*     */ 
/*     */   public void mudarSenha(Usuario usuario)
/*     */   {
/*  72 */     Usuario user = this.usuario;
/*     */ 
/*  74 */     user.setSenha(usuario.getSenha());
/*     */ 
/*  76 */     this.factory.beginTransaction();
/*  77 */     this.factory.getDaoUsuario().adiciona(user);
/*  78 */     this.factory.commit();
/*     */   }
/*     */ 
/*     */   public void formularioAluno()
/*     */   {
/*  84 */     this.disciplinas = this.factory.getDaoDisciplina().listaTudo();
/*     */   }
/*     */   @Validate(params={"aluno"})
/*     */   public void cadastrarAluno(Aluno aluno) {
/*  89 */     this.factory.beginTransaction();
/*  90 */     this.factory.getDaoAluno().adiciona(aluno);
/*  91 */     this.factory.commit();
/*     */   }
/*     */ 
/*     */   public void validateCadastrarAluno(ValidationErrors erros, Aluno aluno)
/*     */   {
/*  96 */     this.aluno = aluno;
/*     */ 
/*  98 */     if (aluno != null) {
/*  99 */       if (aluno.getLogin() != null) {
/* 100 */         if (aluno.getId() == null) {
/* 101 */           if (this.factory.getDaoAluno().recuperarAlunoPorLogin(aluno.getLogin()) != null)
/* 102 */             erros.add(new FixedMessage("aluno.login", "Já existe um aluno cadastrado com este Login.", "aluno"));
/*     */         }
/* 104 */         else if (this.factory.getDaoAluno().recuperarAlunoPorLogin(aluno.getLogin(), aluno.getId()) != null) {
/* 105 */           erros.add(new FixedMessage("aluno.login", "Já existe um aluno cadastrado com este Login.", "aluno"));
/*     */         }
/*     */       }
/*     */ 
/* 109 */       if (aluno.getCPF() != null)
/* 110 */         if (aluno.getId() == null) {
/* 111 */           if (this.factory.getDaoAluno().recuperarAlunoPorCPF(aluno.getCPF()) != null) {
/* 112 */             erros.add(new FixedMessage("aluno.CPF", "Já existe um aluno cadastrado com este CPF.", "aluno"));
/*     */           }
/*     */         }
/* 115 */         else if (this.factory.getDaoAluno().recuperarAlunoPorCPF(aluno.getCPF(), aluno.getId()) != null)
/* 116 */           erros.add(new FixedMessage("aluno.CPF", "Já existe um aluno cadastrado com este CPF.", "aluno"));
/*     */     }
/*     */   }
/*     */ 
/*     */   public void alunoDependencia(Aluno aluno)
/*     */   {
/* 124 */     this.factory.beginTransaction();
/* 125 */     this.aluno = ((Aluno)this.factory.getDaoAluno().procura(aluno.getId()));
/* 126 */     this.factory.commit();
/*     */   }
/*     */ 
/*     */   public void removerAluno(Aluno aluno) {
/* 130 */     this.factory.beginTransaction();
/* 131 */     this.factory.getDaoAluno().remover(aluno.getId());
/* 132 */     this.factory.commit();
/*     */   }
/*     */ 
/*     */   public void editarAluno(Aluno aluno) {
/* 136 */     this.aluno = ((Aluno)this.factory.getDaoAluno().procura(aluno.getId()));
/* 137 */     formularioAluno();
/*     */   }
/*     */ 
/*     */   public void confirmarCadastroAluno(Aluno aluno) {
/* 141 */     this.aluno = this.factory.getDaoAluno().recuperarAlunoPorLogin(aluno.getLogin());
/*     */   }
/*     */ 
/*     */   public void formularioProfessor()
/*     */   {
/* 147 */     this.disciplinas = this.factory.getDaoDisciplina().listaTudo();
/*     */   }
/*     */   @Validate(params={"professor"})
/*     */   public void cadastrarProfessor(Professor professor) {
/* 152 */     this.factory.beginTransaction();
/* 153 */     this.factory.getDaoProfessor().adiciona(professor);
/* 154 */     this.factory.commit();
/*     */   }
/*     */ 
/*     */   public void validateCadastrarProfessor(ValidationErrors erros, Professor professor)
/*     */   {
/* 159 */     this.professor = professor;
/*     */ 
/* 161 */     if (professor != null) {
/* 162 */       if (professor.getLogin() != null) {
/* 163 */         if (professor.getId() == null) {
/* 164 */           if (this.factory.getDaoProfessor().recuperarProfessorPorLogin(professor.getLogin()) != null)
/* 165 */             erros.add(new FixedMessage("professor.login", "Já existe um usuário cadastrado com este Login.", "professor"));
/*     */         }
/* 167 */         else if (this.factory.getDaoProfessor().recuperarProfessorPorLogin(professor.getLogin(), professor.getId()) != null) {
/* 168 */           erros.add(new FixedMessage("professor.login", "Já existe um usuário cadastrado com este Login.", "professor"));
/*     */         }
/*     */       }
/*     */ 
/* 172 */       if (professor.getCPF() != null)
/* 173 */         if (professor.getId() == null) {
/* 174 */           if (this.factory.getDaoProfessor().recuperarProfessorPorCPF(professor.getCPF()) != null) {
/* 175 */             erros.add(new FixedMessage("professor.CPF", "Já existe um usuário cadastrado com este CPF.", "professor"));
/*     */           }
/*     */         }
/* 178 */         else if (this.factory.getDaoProfessor().recuperarProfessorPorCPF(professor.getCPF(), professor.getId()) != null)
/* 179 */           erros.add(new FixedMessage("professor.CPF", "Já existe um usuário cadastrado com este CPF.", "professor"));
/*     */     }
/*     */   }
/*     */ 
/*     */   public void removerProfessor(Professor professor)
/*     */   {
/* 187 */     this.factory.beginTransaction();
/* 188 */     this.factory.getDaoProfessor().remover(professor.getId());
/* 189 */     this.factory.commit();
/*     */   }
/*     */ 
/*     */   public void editarProfessor(Professor professor) {
/* 193 */     this.professor = ((Professor)this.factory.getDaoProfessor().procura(professor.getId()));
/* 194 */     formularioProfessor();
/*     */   }
/*     */ 
/*     */   public void confirmarCadastroProfessor(Professor professor) {
/* 198 */     this.professor = this.factory.getDaoProfessor().recuperarProfessorPorLogin(professor.getLogin());
/*     */   }
/*     */ 
/*     */   public void listarProfessores() {
/* 202 */     this.professores = this.factory.getDaoProfessor().listaTudo();
/*     */   }
/*     */ 
/*     */   public void formularioDisciplina()
/*     */   {
/*     */   }
/*     */ 

			public void formularioBD(){
			}

/*     */   @Validate(params={"disciplina"})
/*     */   public void cadastrarDisciplina(Disciplina disciplina)
/*     */   {
/* 213 */     this.factory.beginTransaction();
/* 214 */     this.factory.getDaoDisciplina().adiciona(disciplina);
/* 215 */     this.factory.commit();
/*     */   }

public void rotinaLimpezaBD(){
	this.factory.beginTransaction();
//	this.factory.getDaoDisciplina().limparBanco();
	this.factory.commit();
}

public void validateRotinaLimpezaBD(){
	
}




/*     */   public void validateCadastrarDisciplina(ValidationErrors erros, Disciplina disciplina) {
/* 219 */     this.disciplina = disciplina;
/*     */   }
/*     */ 
/*     */   public void editarDisciplina(Disciplina disciplina) {
/* 223 */     this.disciplina = ((Disciplina)this.factory.getDaoDisciplina().procura(disciplina.getId()));
/*     */   }
/*     */ 
/*     */   public void listarDisciplinas() {
/* 227 */     this.disciplinas = this.factory.getDaoDisciplina().listaTudo();
/*     */   }
/*     */ 
/*     */   public void removerDisciplina(Disciplina disciplina) {
/* 231 */     this.factory.beginTransaction();
/* 232 */     this.factory.getDaoDisciplina().remover(disciplina.getId());
/* 233 */     this.factory.commit();
/*     */   }
/*     */ 
/*     */   public void setarPeriodo()
/*     */   {
/* 239 */     this.periodo = this.factory.getDaoPeriodo().carregar();
/*     */   }
/*     */ 
/*     */   public void cadastrarNovoPeriodo(Periodo periodo) {
/* 243 */     this.factory.beginTransaction();
/* 244 */     this.factory.getDaoPeriodo().adiciona(periodo);
/* 245 */     this.factory.commit();
/*     */   }
/*     */ 
/*     */   public Aluno getAluno()
/*     */   {
/* 251 */     return this.aluno;
/*     */   }
/*     */ 
/*     */   public void setAluno(Aluno aluno) {
/* 255 */     this.aluno = aluno;
/*     */   }
/*     */ 
/*     */   public List<Aluno> getAlunos() {
/* 259 */     return this.alunos;
/*     */   }
/*     */ 
/*     */   public void setAlunos(List<Aluno> alunos) {
/* 263 */     this.alunos = alunos;
/*     */   }
/*     */ 
/*     */   public Disciplina getDisciplina() {
/* 267 */     return this.disciplina;
/*     */   }
/*     */ 
/*     */   public void setDisciplina(Disciplina disciplina) {
/* 271 */     this.disciplina = disciplina;
/*     */   }
/*     */ 
/*     */   public List<Disciplina> getDisciplinas() {
/* 275 */     return this.disciplinas;
/*     */   }
/*     */ 
/*     */   public void setDisciplinas(List<Disciplina> disciplinas) {
/* 279 */     this.disciplinas = disciplinas;
/*     */   }
/*     */ 
/*     */   public Periodo getPeriodo() {
/* 283 */     return this.periodo;
/*     */   }
/*     */ 
/*     */   public void setPeriodo(Periodo periodo) {
/* 287 */     this.periodo = periodo;
/*     */   }
/*     */ 
/*     */   public Usuario getUsuario() {
/* 291 */     return this.usuario;
/*     */   }
/*     */ 
/*     */   public void setUsuario(Usuario usuario) {
/* 295 */     this.usuario = usuario;
/*     */   }
/*     */ 
/*     */   public Professor getProfessor() {
/* 299 */     return this.professor;
/*     */   }
/*     */ 
/*     */   public void setProfessor(Professor professor) {
/* 303 */     this.professor = professor;
/*     */   }
/*     */ 
/*     */   public List<Professor> getProfessores() {
/* 307 */     return this.professores;
/*     */   }
/*     */ 
/*     */   public void setProfessores(List<Professor> professores) {
/* 311 */     this.professores = professores;
/*     */   }
/*     */ }

/* Location:           C:\workspaces\workspace-lika\Cenas4\ImportedClasses\
 * Qualified Name:     logic.AdminLogic
 * JD-Core Version:    0.6.0
 */