package logic;

import interceptor.AutorizadorProfessorInterceptor;
import interceptor.DaoInterceptor;

import java.util.ArrayList;
import java.util.List;

import model.Aluno;
import model.Disciplina;
import model.Equipe;
import model.Periodo;
import model.Problema;
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

@Component("professor")
@InterceptedBy({DaoInterceptor.class, AutorizadorProfessorInterceptor.class})
public class ProfessorLogic {

	private final DaoFactory factory;
	
	@In(scope = ScopeType.SESSION, required = true)
	@Out(scope = ScopeType.SESSION)
	private Usuario usuario;
	
	@In(scope = ScopeType.SESSION, required = false)
	@Out(scope = ScopeType.SESSION)
	private Periodo periodo;
	
	private List<Disciplina> disciplinas;
	
	private Tutor tutor;
	
	private List<Tutor> tutores;
	
	private List<Aluno> alunos;
	
	private Equipe equipe;
	
	private List<Equipe> equipes;
	
	private Disciplina disciplina;
	
	private Problema problema;
	
	private List<Problema> problemas;
	
	public ProfessorLogic(DaoFactory daoFactory) {
		this.factory = daoFactory;
	}

	//--------- LOGICA DA PRIMEIRA PÁGINA ---------
	public void inicio() {
		this.periodo = this.factory.getDaoPeriodo().carregar();
		this.problemas = this.factory.getDaoProblema().listaTudo();
	}
	
	public void formularioAlterarSenha() {
		
	}
		
	//------------- LOGICA DO TUTOR ---------------
	
	public void listarTutor() {
		this.tutores = this.factory.getDaoTutor().listaTudo();
	}
	
	public void formularioTutor() {
		Professor professor = this.factory.getDaoProfessor().procura(usuario.getId());
		this.disciplinas = professor.getDisciplinas();
	}
	
	@Validate(params = {"tutor"})
	public void cadastrarTutor(Tutor tutor) {
		this.factory.beginTransaction();
		this.factory.getDaoTutor().adiciona(tutor);
		this.factory.commit();
	}
	
	public void validateCadastrarTutor(ValidationErrors erros, Tutor tutor) {
		//TODO
		if (tutor != null) {
			if (tutor.getLogin() != null) {
				if (tutor.getId() == null) {
					if (this.factory.getDaoTutor().recuperarTutorPorLogin(tutor.getLogin()) != null)
						erros.add(new FixedMessage("tutor.login", "Já existe um usuário cadastrado com este Login.", "tutor"));
				} else {
					if (this.factory.getDaoTutor().recuperarTutorPorLogin(tutor.getLogin(), tutor.getId()) != null) {
						erros.add(new FixedMessage("tutor.login", "Já existe um usuário cadastrado com este Login.", "tutor"));
					}
				}
			}
			if(tutor.getCPF() != null) {
				if(tutor.getId() == null) {
					if(this.factory.getDaoTutor().recuperarTutorPorCPF(tutor.getCPF()) != null) {
						erros.add(new FixedMessage("tutor.CPF", "Já existe um usuário cadastrado com este CPF.", "tutor"));
					}
				} else {
					if(this.factory.getDaoTutor().recuperarTutorPorCPF(tutor.getCPF(), tutor.getId()) != null) {
						erros.add(new FixedMessage("tutor.CPF", "Já existe um usuário cadastrado com este CPF.", "tutor"));
					}
				}				
			}
		}
	}
	
	public void confirmarCadastroTutor(Tutor tutor) {
		this.tutor = this.factory.getDaoTutor().recuperarTutorPorLogin(tutor.getLogin());
	}
	
	public void removerTutor(Tutor tutor) {
		this.factory.beginTransaction();
		this.factory.getDaoTutor().remover(tutor.getId());
		this.factory.commit();
	}
	
	public void editarTutor(Tutor tutor) {
		this.tutor = this.factory.getDaoTutor().procura(tutor.getId());
		this.formularioTutor();
	}
	
	//-------------- EQUIPES -----------------
	
	public void formularioEquipe(Disciplina disciplina) {
		if(disciplina != null && disciplina.getId() != null ){	
			disciplina = this.factory.getDaoDisciplina().procura(disciplina.getId());
			this.alunos = this.factory.getDaoAluno().listarAlunosSemEquipeNaDisciplina(disciplina);
			this.tutores = this.factory.getDaoTutor().listarTutoresSemEquipeNaDisciplina(disciplina);
			this.disciplina = new Disciplina();
			this.disciplina.setId(disciplina.getId()); //TODO tentar resolver a gambiarra (kkkkkkk)
		}
		Professor professor = this.factory.getDaoProfessor().procura(usuario.getId());
		this.disciplinas = professor.getDisciplinas();
	}
	
	@Validate(params = {"equipe"})
	public void cadastrarEquipe(Equipe equipe) {
		this.factory.beginTransaction();
		this.factory.getDaoEquipe().adiciona(equipe);
		this.factory.commit();
	}
	
	public void validateCadastrarEquipe(ValidationErrors erros, Equipe equipe) {
		if(equipe != null) {
			if(equipe.getAlunos() == null || equipe.getAlunos().size() == 0) {
				erros.add(new FixedMessage("equipe.alunos", "Não é possível registrar uma equipe sem alunos.", "equipe"));
			} 
			if(equipe.getTutor() == null || equipe.getTutor().getId() == null) {
				erros.add(new FixedMessage("equipe.tutor", "Não é possível registrar uma equipe sem um tutor responsável.", "equipe"));
			}
			if(equipe.getDisciplina() == null || equipe.getDisciplina().getId() == null) {
				erros.add(new FixedMessage("equipe.disciplina", "Não é possível registrar uma equipe sem uma disciplina.", "equipe"));
			}
		}
	}
	
	public void listarEquipe() {
		Professor professor = this.factory.getDaoProfessor().procura(usuario.getId());
		this.equipes = this.factory.getDaoEquipe().equipesDasDisciplinas(professor.getDisciplinas());
	}
	
	public void editarEquipe(Equipe equipe) {
		this.equipe = this.factory.getDaoEquipe().procura(equipe.getId());
		this.formularioEquipe(this.equipe.getDisciplina());
		if(tutores != null) {
			this.tutores.add(this.equipe.getTutor());
		}
		else  {
			this.tutores = new ArrayList<Tutor>();
			this.tutores.add(this.equipe.getTutor());
		}
	}
	
	public void removerEquipe(Equipe equipe) {
		this.factory.beginTransaction();
		this.factory.getDaoEquipe().remover(equipe.getId());
		this.factory.commit();
	}
	
	public void detalharEquipe(Equipe equipe) {
		this.equipe = this.factory.getDaoEquipe().procura(equipe.getId());
	}
	
	public void mudarSenha(Professor professor) {
		Professor prof = (Professor) this.usuario;
		prof.setSenha(professor.getSenha());
		this.factory.beginTransaction();
		this.factory.getDaoProfessor().adiciona(prof);
		this.factory.commit();
	}
	
	//-------------- PROBLEMA ----------------
	
	public void formularioProblema() {
		this.problema = null;
		this.equipes = this.factory.getDaoEquipe().listarEquipeSemProblemas();
	}
	
	@Validate(params = {"problema"})
	public void cadastrarProblema(Problema problema) {
		this.factory.beginTransaction();
		if (problema.getIdProblema() != null) {
			Problema temp = this.factory.getDaoProblema().procura(problema.getIdProblema());
			temp.setTitulo(problema.getTitulo());
			this.factory.getDaoProblema().adiciona(temp);
		} else {
			problema.setPeriodo(this.factory.getDaoPeriodo().carregar());
			Equipe temp = this.factory.getDaoEquipe().procura(
					problema.getEquipe().getId());
			problema.setDisciplina(temp.getDisciplina());
			this.factory.getDaoProblema().adiciona(problema);
		}
		this.factory.commit();
	}
 	
	public void validateCadastrarProblema(ValidationErrors erros, Problema problema) {
		if(problema.getEquipe() == null) {
			erros.add(new FixedMessage("problema.equipe", "Um problema deve estar associado a uma equipe.", "problema"));
		}
	}
	
	public void editarProblema(Problema problema) {
		this.problema = this.factory.getDaoProblema().procura(problema.getIdProblema());
	}
	
	public void removerProblema(Problema problema) {
		this.factory.beginTransaction();
		this.factory.getDaoProblema().remover(problema.getIdProblema());
		this.factory.commit();
	}
	
	public void formularioFecharProblema(Problema problema) {
		this.problema = this.factory.getDaoProblema().procura(problema.getIdProblema());
		this.problema.getEquipe();
	}
	
	public void fecharProblema(Problema problema) {
		
		Problema temp = this.factory.getDaoProblema().procura(problema.getIdProblema());
		
		int aberto = (temp.getAberto() == 0) ? 1 : 0;
		
		temp.setAberto(aberto);
	
		this.factory.beginTransaction();
		this.factory.getDaoProblema().adiciona(temp);
		this.factory.commit();
	}
	
	
	//--------- GETTERS e SETTERS ------------
	
	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	public Periodo getPeriodo() {
		return periodo;
	}

	public void setPeriodo(Periodo periodo) {
		this.periodo = periodo;
	}

	public List<Disciplina> getDisciplinas() {
		return disciplinas;
	}

	public void setDisciplinas(List<Disciplina> disciplinas) {
		this.disciplinas = disciplinas;
	}

	public Tutor getTutor() {
		return tutor;
	}

	public void setTutor(Tutor tutor) {
		this.tutor = tutor;
	}

	public List<Tutor> getTutores() {
		return tutores;
	}

	public void setTutores(List<Tutor> tutores) {
		this.tutores = tutores;
	}

	public List<Aluno> getAlunos() {
		return alunos;
	}

	public void setAlunos(List<Aluno> alunos) {
		this.alunos = alunos;
	}

	public Equipe getEquipe() {
		return equipe;
	}

	public void setEquipe(Equipe equipe) {
		this.equipe = equipe;
	}

	public List<Equipe> getEquipes() {
		return equipes;
	}

	public void setEquipes(List<Equipe> equipes) {
		this.equipes = equipes;
	}

	public Disciplina getDisciplina() {
		return disciplina;
	}

	public void setDisciplina(Disciplina disciplina) {
		this.disciplina = disciplina;
	}

	public Problema getProblema() {
		return problema;
	}

	public void setProblema(Problema problema) {
		this.problema = problema;
	}

	public List<Problema> getProblemas() {
		return problemas;
	}

	public void setProblemas(List<Problema> problemas) {
		this.problemas = problemas;
	}
	
	
}
