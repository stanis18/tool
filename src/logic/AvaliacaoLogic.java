package logic;

import interceptor.AutorizadorProfessorTutorInterceptor;
import interceptor.DaoInterceptor;

import java.util.List;

import model.Aluno;
import model.Avaliacao;
import model.Equipe;
import model.Periodo;
import model.Professor;
import model.Tutor;
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

@Component("avaliacao")
@InterceptedBy({DaoInterceptor.class, AutorizadorProfessorTutorInterceptor.class})
public class AvaliacaoLogic {

	private final DaoFactory factory;
	
/*     */   @In(scope=ScopeType.SESSION, required=true)
/*     */   private Usuario usuario;
/*     */ 
/*     */   @In(scope=ScopeType.SESSION, required=false)
/*     */   @Out(scope=ScopeType.SESSION)
/*     */   private Equipe equipe;
/*     */   private Aluno aluno;
/*     */   private Avaliacao avaliacao;
/*     */ 
/*     */   @In(scope=ScopeType.SESSION, required=false)
/*     */   @Out(scope=ScopeType.SESSION)
/*     */   private Periodo periodo;
/*     */ 
/*     */   public AvaliacaoLogic(DaoFactory daoFactory)
/*     */   {
/*  51 */     this.factory = daoFactory;
/*     */   }
/*     */ 
/*     */   public void avaliarEquipe(Equipe equipe)
/*     */   {
/*  57 */     this.equipe = ((Equipe)this.factory.getDaoEquipe().procura(equipe.getId()));
/*     */   }
/*     */ 
/*     */   @SuppressWarnings("unused")
/*	   */   public void notasEquipe(Equipe equipe) {
/*  61 */     this.equipe = ((Equipe)this.factory.getDaoEquipe().procura(equipe.getId()));
/*  62 */     long i = 7L;
/*  63 */     Aluno teste = this.factory.getDaoAluno().recuperarAlunoPorLogin("aam");
/*     */   }

	public void avaliarAluno(Aluno aluno) { //MÉTODO MODIFICADO - mfpp@cin
		
		this.aluno = ((Aluno)this.factory.getDaoAluno().procura(aluno.getId()));
		
		// CORRINGINDO O PROBLEMA DAS NOTAS QUE SAEM DO LUGAR
		List<Avaliacao> avs = this.aluno.getAvaliacoes();
		if(avs.size() != 7) {
			
			Avaliacao av;
			for(int i = avs.size(); i < 7; i++) {
				av = new Avaliacao();
				av.setAluno(this.aluno);
				av.setDominioAcademico("");
				av.setDominioCognitivo("");
				cadastrarAvaliacao(av);
			}	
		}
		
		this.aluno = ((Aluno)this.factory.getDaoAluno().procura(aluno.getId())); //redundância necessária
	}
	
	public void formularioAvaliacaoAluno(Aluno aluno) {
		
		if (aluno.getId() != null) {
			this.aluno = ((Aluno)this.factory.getDaoAluno().procura(aluno.getId()));

		} else if (this.aluno.getId() != null)
			this.aluno = ((Aluno)this.factory.getDaoAluno().procura(this.aluno.getId()));
	}
 
	@Validate(params={"avaliacao"})
	public String cadastrarAvaliacao(Avaliacao avaliacao) { //MÉTODO MODIFICADO - mfpp@cin
	
		/*
		 * 	CÓDIGOS: 
		 * 	média(-1.0) -> F
		 * 	média(-2.0) -> SEM NOTA
		 * 	média(-3.0) -> ERRO
		 */
		
		try {
			
			String da = avaliacao.getDominioAcademico();
			String dc = avaliacao.getDominioCognitivo();
			
			if(da.equals("") && dc.equals("")) {
				avaliacao.setMedia(Float.valueOf(-2.0F));
	
			} else if(da.equalsIgnoreCase("F") || da.equals("")) {
	
				if(dc.equalsIgnoreCase("F") || dc.equals(""))
					avaliacao.setMedia(Float.valueOf(-1.0F));
				else
					avaliacao.setMedia(Float.valueOf(Float.parseFloat(dc)));
	
			} else if(dc.equalsIgnoreCase("F") || dc.equals("")) {
	
				if(da.equalsIgnoreCase("F") || da.equals(""))
					avaliacao.setMedia(Float.valueOf(-1.0F));
				else
					avaliacao.setMedia(Float.valueOf(Float.parseFloat(da)));
	
			} else
				avaliacao.setMedia(Float.valueOf((Float.parseFloat(da) + Float.parseFloat(dc)) / 2.0F));
	
		} catch(NumberFormatException e) {
	
			avaliacao.setMedia(Float.valueOf(-3.0F));
			System.err.println(String.format("Erro no metodo _cadastrarAvaliacao_ da classe _%s_: DC = %s, DA = %s", this.getClass().getName(), avaliacao.getDominioCognitivo(), avaliacao.getDominioAcademico()));
		}
	
		avaliacao.setAluno((Aluno)this.factory.getDaoAluno().procura(avaliacao.getAluno().getId()));
		this.factory.beginTransaction();
		this.factory.getDaoAvaliacao().adiciona(avaliacao);
		this.factory.commit();
	
		if((this.usuario instanceof Tutor)) return "tutor";
		if((this.usuario instanceof Professor)) return "professor";
		return "invalid";
	}
	
	public void validateCadastrarAvaliacao(ValidationErrors errors, Avaliacao avaliacao) {
		
		this.aluno = avaliacao.getAluno();
	
		if ((avaliacao.getDominioAcademico() != "") && (!avaliacao.getDominioAcademico().equalsIgnoreCase("F"))) {
			Float f = Float.valueOf(Float.parseFloat(avaliacao.getDominioAcademico()));
			if ((f.floatValue() < 0.0F) || (f.floatValue() > 10.0F)) {
				errors.add(new FixedMessage("", "Insira valores entre 0 e 10", ""));
				return;
			} else {
				avaliacao.setDominioAcademico(String.valueOf(Math.round(10.0F*Float.parseFloat(avaliacao.getDominioAcademico()))/10.0F));
			}
		}
		if ((avaliacao.getDominioCognitivo() != "") && (!avaliacao.getDominioCognitivo().equalsIgnoreCase("F"))) {
			Float f = Float.valueOf(Float.parseFloat(avaliacao.getDominioCognitivo()));
			if ((f.floatValue() < 0.0F) || (f.floatValue() > 10.0F)) {
				errors.add(new FixedMessage("", "Insira valores entre 0 e 10", ""));
				return;
			} else {
				avaliacao.setDominioCognitivo(String.valueOf(Math.round(10.0F*Float.parseFloat(avaliacao.getDominioCognitivo()))/10.0F));
			}
		}
	}
	
	public void editarAvaliacao(Avaliacao avaliacao) {
		
		this.avaliacao = ((Avaliacao)this.factory.getDaoAvaliacao().procura(avaliacao.getIdAvaliacao()));
		formularioAvaliacaoAluno(this.avaliacao.getAluno());
	}
	
	public String removerAvaliacao(Avaliacao avaliacao) {
		
		this.avaliacao = ((Avaliacao)this.factory.getDaoAvaliacao().procura(avaliacao.getIdAvaliacao()));
		formularioAvaliacaoAluno(this.avaliacao.getAluno());
		
		this.avaliacao.setDominioAcademico("");
		this.avaliacao.setDominioCognitivo("");
		
		return cadastrarAvaliacao(this.avaliacao);
	}
	
	public void detalharEquipe(Equipe equipe) {
		this.equipe = ((Equipe)this.factory.getDaoEquipe().procura(equipe.getId()));
	}
	
	public void notas() {
		this.equipe = ((Equipe)this.factory.getDaoEquipe().procura(this.equipe.getId()));
	}
	
	public Usuario getUsuario() {
		return this.usuario;
	}
	
	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	
	public DaoFactory getFactory() {
		return this.factory;
	}
	
	public Equipe getEquipe() {
		return this.equipe;
	}
	
	public void setEquipe(Equipe equipe) {
		this.equipe = equipe;
	}
	
	public Aluno getAluno() {
		return this.aluno;
	}
	
	public void setAluno(Aluno aluno) {
		this.aluno = aluno;
	}
	
	public Avaliacao getAvaliacao() {
		return this.avaliacao;
	}
	
	public void setAvaliacao(Avaliacao avaliacao) {
		this.avaliacao = avaliacao;
	}
	
	public Periodo getPeriodo() {
		return this.periodo;
	}
	
	public void setPeriodo(Periodo periodo) {
		this.periodo = periodo;
	}
}