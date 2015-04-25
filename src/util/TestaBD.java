package util;

import model.Periodo;
import model.Tutor;
import model.Usuario;
import dao.DaoFactory;

public class TestaBD {

	public static void main(String[] args) {
		DaoFactory dao = new DaoFactory();
		dao.beginTransaction();
		
		Usuario admin = new Usuario();
		admin.setCPF("123456789");
		admin.setNome("Administrador");
		admin.setLogin("admin");
		admin.setSenha("12");
		admin.setEmail("admin_mcc@gmail.com");
		
		dao.getDaoUsuario().adiciona(admin);
		
		/*Aluno aluno = new Aluno();
		aluno.setCPF("12345678");
		aluno.setNome("Rodrigo Mateus");
		aluno.setLogin("rcm");
		aluno.setSenha("12");
		aluno.setEmail("rcmateus@aaa.com");*/
		//dao.getDaoAluno().adiciona(aluno);

		
		/*Professor professor = new Professor();
		
		professor.setCPF("12856738");
		professor.setNome("Professor");
		professor.setLogin("prof");
		professor.setSenha("prof");
		professor.setEmail("rcmateus@teste.com");
		*/
		//dao.getDaoProfessor().adiciona(professor);
		dao.commit();
				
		Periodo periodo = new Periodo();
		
		periodo.setPeriodo("2009.1");
		
		dao.beginTransaction();
		dao.getDaoPeriodo().adiciona(periodo);
		dao.commit();
		
		
		Tutor tutor = new Tutor();
		tutor.setCPF("122.222.222-21");
		tutor.setEmail("tutor@ufpe.br");
		tutor.setLogin("tutor");
		tutor.setSenha("12");
		tutor.setNome("Tutor Teste");
		dao.beginTransaction();
		dao.getDaoTutor().adiciona(tutor);
		dao.commit();
		
		dao.close();
	}
	
}
