/*    */ package logic;
/*    */ 
/*    */ import interceptor.AutorizadorAlunoInterceptor;
import interceptor.DaoInterceptor;

import java.util.List;

import model.Aluno;
import model.Equipe;
import model.Periodo;
import model.Usuario;

import org.vraptor.annotations.Component;
import org.vraptor.annotations.In;
import org.vraptor.annotations.InterceptedBy;
import org.vraptor.annotations.Out;
import org.vraptor.scope.ScopeType;

import dao.DaoFactory;
/*    */ 
/*    */ @Component("aluno")
/*    */ @InterceptedBy({DaoInterceptor.class, AutorizadorAlunoInterceptor.class})
/*    */ public class AlunoLogic
/*    */ {
/*    */   private final DaoFactory factory;
/*    */ 
/*    */   @In(scope=ScopeType.SESSION, required=true)
/*    */   private Usuario usuario;
/*    */   private Aluno aluno;
/*    */   private List<Equipe> equipes;
/*    */ 
/*    */   @In(scope=ScopeType.SESSION, required=false)
/*    */   @Out(scope=ScopeType.SESSION)
/*    */   private Periodo periodo;
/*    */ 
/*    */   public AlunoLogic(DaoFactory daoFactory)
/*    */   {
/* 39 */     this.factory = daoFactory;
/*    */   }
/*    */ 
/*    */   public void inicio() {
/* 43 */     this.aluno = ((Aluno)this.factory.getDaoAluno().procura(this.usuario.getId()));
/* 44 */     this.equipes = this.aluno.getEquipe();
/*    */   }
/*    */ 
/*    */   public void formularioAlterarSenha()
/*    */   {
/*    */   }
/*    */ 
/*    */   public void mudarSenha(Aluno aluno) {
/* 52 */     Aluno alunoTemporario = (Aluno)this.usuario;
/* 53 */     alunoTemporario.setSenha(aluno.getSenha());
/* 54 */     this.factory.beginTransaction();
/* 55 */     this.factory.getDaoAluno().adiciona(alunoTemporario);
/* 56 */     this.factory.commit();
/*    */   }
/*    */ 
/*    */   public Usuario getUsuario()
/*    */   {
/* 64 */     return this.usuario;
/*    */   }
/*    */ 
/*    */   public void setUsuario(Usuario usuario) {
/* 68 */     this.usuario = usuario;
/*    */   }
/*    */ 
/*    */   public DaoFactory getFactory() {
/* 72 */     return this.factory;
/*    */   }
/*    */ 
/*    */   public Aluno getAluno() {
/* 76 */     return this.aluno;
/*    */   }
/*    */ 
/*    */   public void setAluno(Aluno aluno) {
/* 80 */     this.aluno = aluno;
/*    */   }
/*    */ 
/*    */   public List<Equipe> getEquipes() {
/* 84 */     return this.equipes;
/*    */   }
/*    */ 
/*    */   public void setEquipes(List<Equipe> equipes) {
/* 88 */     this.equipes = equipes;
/*    */   }
/*    */ 
/*    */   public Periodo getPeriodo() {
/* 92 */     return this.periodo;
/*    */   }
/*    */ 
/*    */   public void setPeriodo(Periodo periodo) {
/* 96 */     this.periodo = periodo;
/*    */   }
/*    */ }

/* Location:           C:\workspaces\workspace-lika\Cenas4\ImportedClasses\
 * Qualified Name:     logic.AlunoLogic
 * JD-Core Version:    0.6.0
 */