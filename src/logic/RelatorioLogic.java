package logic;

import interceptor.AutorizadorAlunoProfessorTutorInterceptor;
import interceptor.DaoInterceptor;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import model.Aluno;
import model.Comentario;
import model.Equipe;
import model.Glossario;
import model.MaterialGrafico;
import model.MaterialPesquisado;
import model.PalavraChave;
import model.Periodo;
import model.PlanoDesenvolvimento;
import model.Problema;
import model.ReferenciaBibliografica;
import model.ReferenciaInicial;
import model.Usuario;

import org.vraptor.annotations.Component;
import org.vraptor.annotations.In;
import org.vraptor.annotations.InterceptedBy;
import org.vraptor.annotations.Out;
import org.vraptor.annotations.Viewless;
import org.vraptor.i18n.FixedMessage;
import org.vraptor.interceptor.MultipartRequestInterceptor;
import org.vraptor.interceptor.UploadedFileInformation;
import org.vraptor.plugin.hibernate.Validate;
import org.vraptor.scope.ScopeType;
import org.vraptor.validator.ValidationErrors;

import dao.DaoFactory;

/**
 * @author RCM
 *
 */
@Component("relatorio")
@InterceptedBy( {MultipartRequestInterceptor.class, DaoInterceptor.class, AutorizadorAlunoProfessorTutorInterceptor.class })
public class RelatorioLogic {

	@In(scope = ScopeType.SESSION, required = true)
	protected Usuario usuario;
	
	private final DaoFactory factory;

	@In(scope = ScopeType.SESSION, required = false)
	@Out(scope = ScopeType.SESSION)
	private Problema problema = new Problema();

	private Glossario glossario;

	private ReferenciaBibliografica referenciaBibliografica;

	private ReferenciaInicial referenciaInicial;

	private PlanoDesenvolvimento planoDesenvolvimento;

	private PalavraChave palavraChave;

	private MaterialPesquisado materialPesquisado;

	private Comentario comentario;
	
	private MaterialGrafico materialGrafico;
	
	@In(required = false)
	private UploadedFileInformation fileInfo;

	@In
    private HttpServletResponse response;
	
	@In(scope = ScopeType.SESSION, required = false)
	@Out(scope = ScopeType.SESSION)
	private Periodo periodo;
	
	private Equipe equipe;
	
	public RelatorioLogic(DaoFactory daoFactory) {
		this.factory = daoFactory;
	}

	// ---------------- CENARIO ----------------------

	public void inicio(Problema problema) {
		Problema prob = this.factory.getDaoProblema().procura(
				problema.getIdProblema());
		this.problema = prob;
		System.out.println(this.problema.getTitulo());
	}

	public void exibirCenario() {

	}

	public void formularioCenario() {
		System.out.println(this.problema.getTitulo());
	}

	public void cadastrarCenarioProblema(Problema problema) {
		this.problema.setCenario(problema.getCenario());
		this.factory.beginTransaction();
		this.factory.getDaoProblema().adiciona(this.problema);
		this.factory.commit();
	}

	// -------------- OBJETIVOS ----------------------

	public void exibirObjetivos() {

	}

	public void formularioObjetivos() {

	}

	public void cadastrarObjetivosProblema(Problema problema) {
		this.problema.setObjetivos(problema.getObjetivos());
		this.factory.beginTransaction();
		this.factory.getDaoProblema().adiciona(this.problema);
		this.factory.commit();
	}

	// -------------- JUSTIFICATIVA ----------------------

	public void exibirJustificativa() {

	}

	public void formularioJustificativa() {

	}

	public void cadastrarJustificativaProblema(Problema problema) {
		this.problema.setJustificativa(problema.getJustificativa());
		this.factory.beginTransaction();
		this.factory.getDaoProblema().adiciona(this.problema);
		this.factory.commit();
	}

	// -------------- RELATORIO ----------------------

	public void exibirRelatorio() {
		this.problema = this.factory.getDaoProblema().procura(this.problema.getIdProblema());
		this.problema.getComentarios();
	}

	public void formularioRelatorio() {

	}

	public void cadastrarRelatorioProblema(Problema problema) {
		this.problema.setDescricao(problema.getDescricao());
		this.factory.beginTransaction();
		this.factory.getDaoProblema().adiciona(this.problema);
		this.factory.commit();
	}

	// -------------- RECOMENDACOES ----------------------

	public void exibirRecomendacoes() {
		this.problema = this.factory.getDaoProblema().procura(this.problema.getIdProblema());
		this.problema.getComentarios();
	}

	public void formularioRecomendacoes() {

	}

	public void cadastrarRecomendacoesProblema(Problema problema) {
		this.problema.setRecomendacoes(problema.getRecomendacoes());
		this.factory.beginTransaction();
		this.factory.getDaoProblema().adiciona(this.problema);
		this.factory.commit();
	}

	// -------------- CONCLUSAO E AVALIACAO ----------------------

	public void exibirConclusaoAvaliacao() {
		this.problema = this.factory.getDaoProblema().procura(this.problema.getIdProblema());
		this.problema.getComentarios();
	}

	public void formularioConclusaoAvaliacao() {

	}

	public void cadastrarConclusaoAvaliacaoProblema(Problema problema) {
		this.problema.setConclusaoAvaliacao(problema.getConclusaoAvaliacao());
		this.factory.beginTransaction();
		this.factory.getDaoProblema().adiciona(this.problema);
		this.factory.commit();
	}

	// -------------- CONCLUSAO E AVALIACAO ----------------------

	public void exibirResumo() {
		this.problema = this.factory.getDaoProblema().procura(this.problema.getIdProblema());
		this.problema.getComentarios();
	}

	public void formularioResumo() {

	}

	public void cadastrarResumoProblema(Problema problema) {
		this.problema.setResumo(problema.getResumo());
		this.factory.beginTransaction();
		this.factory.getDaoProblema().adiciona(this.problema);
		this.factory.commit();
	}

	// -------------- GLOSSARIO ----------------------

	public void exibirGlossario() {
		this.problema = this.factory.getDaoProblema().procura(
				this.problema.getIdProblema());
		this.problema.getGlossarios();
	}

	public void formularioGlossario() {
	}

	public void editarGlossario(Glossario glossario) {
		this.glossario = this.factory.getDaoGlossario().procura(
				glossario.getIdGlossario());
	}

	public void removerGlossario(Glossario glossario) {
		this.factory.beginTransaction();
		this.factory.getDaoGlossario().remover(glossario.getIdGlossario());
		this.factory.commit();
	}

	public void cadastrarGlossarioProblema(Glossario glossario) {

		this.factory.beginTransaction();
		this.factory.getDaoGlossario().adiciona(glossario);
		this.factory.commit();
	}

	// -------------- REFERENCIAS BIBLIOGRAFICAS ----------------------

	public void exibirReferenciasBibliograficas() {
		this.problema = this.factory.getDaoProblema().procura(
				this.problema.getIdProblema());
		this.problema.getReferenciasBibliografica();
	}

	public void formularioReferenciasBibliograficas() {
	}

	public void editarReferenciasBibliograficas(
			ReferenciaBibliografica referenciaBibliografica) {
		this.referenciaBibliografica = this.factory
				.getDaoReferenciaBibliografica().procura(
						referenciaBibliografica.getId());
	}

	public void removerReferenciasBibliograficas(
			ReferenciaBibliografica referenciaBibliografica) {
		this.factory.beginTransaction();
		this.factory.getDaoReferenciaBibliografica().remover(
				referenciaBibliografica.getId());
		this.factory.commit();
	}

	public void cadastrarReferenciasBibliograficasProblema(
			ReferenciaBibliografica referenciaBibliografica) {
		this.factory.beginTransaction();
		this.factory.getDaoReferenciaBibliografica().adiciona(
				referenciaBibliografica);
		this.factory.commit();
	}

	// -------------- REFERENCIAS INICIAIS ----------------------

	public void exibirReferenciasIniciais() {
		this.problema = this.factory.getDaoProblema().procura(
				this.problema.getIdProblema());
		this.problema.getReferenciasInicial();
	}

	public void formularioReferenciasIniciais() {

	}

	public void editarReferenciasIniciais(ReferenciaInicial referenciaInicial) {
		this.referenciaInicial = this.factory.getDaoReferenciaInicial()
				.procura(referenciaInicial.getId());
	}

	public void removerReferenciasIniciais(ReferenciaInicial referenciaInicial) {
		this.factory.beginTransaction();
		this.factory.getDaoReferenciaInicial().remover(
				referenciaInicial.getId());
		this.factory.commit();
	}

	public void cadastrarReferenciasIniciaisProblema(
			ReferenciaInicial referenciaInicial) {
		this.factory.beginTransaction();
		this.factory.getDaoReferenciaInicial().adiciona(referenciaInicial);
		this.factory.commit();
	}

	// -------------- REFERENCIAS INICIAIS ----------------------

	public void exibirPlanoDesenvolvimento() {
		this.problema = this.factory.getDaoProblema().procura(
				this.problema.getIdProblema());
		this.problema.getPlanosDesenvolvimento();
	}

	public void formularioPlanoDesenvolvimento() {

	}

	public void editarPlanoDesenvolvimento(
			PlanoDesenvolvimento planoDesenvolvimento) {
		this.planoDesenvolvimento = this.factory.getDaoPlanoDesenvolvimento()
				.procura(planoDesenvolvimento.getIdPlanoDesenvolvimento());
	}

	public void removerPlanoDesenvolvimento(
			PlanoDesenvolvimento planoDesenvolvimento) {
		this.factory.beginTransaction();
		this.factory.getDaoPlanoDesenvolvimento().remover(
				planoDesenvolvimento.getIdPlanoDesenvolvimento());
		this.factory.commit();
	}

	public void cadastrarPlanoDesenvolvimentoProblema(
			PlanoDesenvolvimento planoDesenvolvimento) {
		this.factory.beginTransaction();
		this.factory.getDaoPlanoDesenvolvimento()
				.adiciona(planoDesenvolvimento);
		this.factory.commit();
	}

	// --------------------- RELATORIO ----------------------
	
	public void relatorio() {
		this.problema = this.factory.getDaoProblema().procura(this.problema.getIdProblema());
		this.equipe = this.factory.getDaoEquipe().procura(this.problema.getEquipe().getId());

		for (Aluno aluno : equipe.getAlunos()) {
			System.out.println(aluno.getNome());
		}
		
	}
	
	// ---------------- MATERIAL PESQUISADO -----------------

	public void exibirMaterialPesquisado() {
		this.problema = this.factory.getDaoProblema().procura(
				this.problema.getIdProblema());
		this.problema.getMateriaisPesquisado();
	}

	public void formularioMaterialPesquisado() {

	}

	public void editarMaterialPesquisado(MaterialPesquisado materialPesquisado) {
		this.materialPesquisado = this.factory.getDaoMaterialPesquisado()
				.procura(materialPesquisado.getIdMaterialPesquisado());
	}

	public void removerMaterialPesquisado(MaterialPesquisado materialPesquisado) {
		this.factory.beginTransaction();
		this.factory.getDaoMaterialPesquisado().adiciona(materialPesquisado);
		this.factory.commit();
	}

	public void cadastrarMaterialPesquisadoProblema(
			MaterialPesquisado materialPesquisado) {
		this.factory.beginTransaction();
		this.factory.getDaoMaterialPesquisado().adiciona(materialPesquisado);
		this.factory.commit();
	}

	// ---------------- COMENTARIO -----------------

	public void exibirComentario() {
		this.problema = this.factory.getDaoProblema().procura(
				this.problema.getIdProblema());
		this.problema.getComentarios();
	}

	public void formularioComentario() {

	}

	public void editarComentario(Comentario comentario) {
		this.comentario = this.factory.getDaoComentario().procura(comentario.getIdComentario());
	}

	public void removerComentario(Comentario comentario) {
		this.factory.beginTransaction();
		this.factory.getDaoComentario().adiciona(comentario);
		this.factory.commit();
	}

	public void cadastrarComentarioProblema(Comentario comentario) {
		comentario.setDataComentario(new Timestamp(System.currentTimeMillis()));
		
		this.factory.beginTransaction();
		this.factory.getDaoComentario().adiciona(comentario);
		this.factory.commit();
	}
	
	// ---------------- COMENTARIO -----------------

	public void exibirPalavraChave() {
		this.problema = this.factory.getDaoProblema().procura(
				this.problema.getIdProblema());
		this.problema.getPalavrasChave();
	}

	public void formularioPalavraChave() {

	}

	public void editarPalavraChave(PalavraChave palavraChave) {
		this.palavraChave = this.factory.getDaoPalavraChave().procura(palavraChave.getIdPalavraChave());
	}

	public void removerPalavraChave(PalavraChave palavraChave) {
		this.factory.beginTransaction();
		this.factory.getDaoPalavraChave().remover(palavraChave.getIdPalavraChave());
		this.factory.commit();
	}

	public void cadastrarPalavraChaveProblema(PalavraChave palavraChave) {
		this.factory.beginTransaction();
		this.factory.getDaoPalavraChave().adiciona(palavraChave);
		this.factory.commit();
	}
	
	
	// ---------------- MATERIAL GRAFICO -----------------

	public void exibirMaterialGrafico() {
		this.problema = this.factory.getDaoProblema().procura(
				this.problema.getIdProblema());
		this.problema.getMateriaisGrafico();
	}

	public void formularioMaterialGrafico() {

	}

	public void editarMaterialGrafico(MaterialGrafico materialGrafico) {
		this.materialGrafico = this.factory.getDaoMaterialGrafico()
				.procura(materialGrafico.getIdMaterialGrafico());
	}

	public void removerMaterialGrafico(MaterialGrafico materialGrafico) {
		this.factory.beginTransaction();
		this.factory.getDaoMaterialGrafico().adiciona(materialGrafico);
		this.factory.commit();
	}

	@Validate(params="materialGrafico")
	public void cadastrarMaterialGraficoProblema(
			MaterialGrafico materialGrafico) throws IOException {
		File fileUpload = this.fileInfo.getFile();
		
		
		materialGrafico.setImagem(getBytesFromFile(fileUpload));
		
		this.factory.beginTransaction();
		this.factory.getDaoMaterialGrafico().adiciona(materialGrafico);
		this.factory.commit();
	}
	
	public void validateCadastrarMaterialGraficoProblema(ValidationErrors errors, MaterialGrafico materialGrafico){
		File fileUpload = this.fileInfo.getFile();
		long tamanhoArquivo  = fileUpload.length();
		if(tamanhoArquivo > 500000){
			errors.add(new FixedMessage("","O tamanho da imagem não pode ultrapassar 500KB", ""));
		}
		
	}
	
	@Viewless
	public void mostraImagem(MaterialGrafico materialGrafico)
			throws IOException {

		byte[] imagem = null;

		MaterialGrafico material = this.factory.getDaoMaterialGrafico()
				.procura(materialGrafico.getIdMaterialGrafico());

		imagem = material.getImagem();

		response.setContentType("image/bmp");
		response.setHeader("Content-Disposition", "filename=xxx.jpg");
		response.setContentLength(imagem.length);
		ServletOutputStream ouputStream = response.getOutputStream();
		ouputStream.write(imagem, 0, imagem.length);
		ouputStream.flush();
		ouputStream.close();
	} 

	
	// GETTERS e SETTERS

	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	public Problema getProblema() {
		return problema;
	}

	public void setProblema(Problema problema) {
		this.problema = problema;
	}

	public DaoFactory getFactory() {
		return factory;
	}

	public Glossario getGlossario() {
		return glossario;
	}

	public void setGlossario(Glossario glossario) {
		this.glossario = glossario;
	}

	public ReferenciaBibliografica getReferenciaBibliografica() {
		return referenciaBibliografica;
	}

	public void setReferenciaBibliografica(
			ReferenciaBibliografica referenciaBibliografica) {
		this.referenciaBibliografica = referenciaBibliografica;
	}

	public ReferenciaInicial getReferenciaInicial() {
		return referenciaInicial;
	}

	public void setReferenciaInicial(ReferenciaInicial referenciaInicial) {
		this.referenciaInicial = referenciaInicial;
	}

	public PlanoDesenvolvimento getPlanoDesenvolvimento() {
		return planoDesenvolvimento;
	}

	public void setPlanoDesenvolvimento(
			PlanoDesenvolvimento planoDesenvolvimento) {
		this.planoDesenvolvimento = planoDesenvolvimento;
	}

	public PalavraChave getPalavraChave() {
		return palavraChave;
	}

	public void setPalavraChave(PalavraChave palavraChave) {
		this.palavraChave = palavraChave;
	}

	public MaterialPesquisado getMaterialPesquisado() {
		return materialPesquisado;
	}

	public void setMaterialPesquisado(MaterialPesquisado materialPesquisado) {
		this.materialPesquisado = materialPesquisado;
	}

	public Comentario getComentario() {
		return comentario;
	}

	public void setComentario(Comentario comentario) {
		this.comentario = comentario;
	}
	
	public MaterialGrafico getMaterialGrafico() {
		return materialGrafico;
	}

	public void setMaterialGrafico(MaterialGrafico materialGrafico) {
		this.materialGrafico = materialGrafico;
	}

	public UploadedFileInformation getFileInfo() {
		return fileInfo;
	}

	public void setFileInfo(UploadedFileInformation fileInfo) {
		this.fileInfo = fileInfo;
	}
	
	public Periodo getPeriodo() {
		return periodo;
	}

	public void setPeriodo(Periodo periodo) {
		this.periodo = periodo;
	}

	public Equipe getEquipe() {
		return equipe;
	}

	public void setEquipe(Equipe equipe) {
		this.equipe = equipe;
	}

	static byte[] getBytesFromFile(File file) throws IOException {
        InputStream is = new FileInputStream(file);
        // Get the size of the file
        long length = file.length();
       
        /*
         * You cannot create an array using a long type. It needs to be an int
         * type. Before converting to an int type, check to ensure that file is
         * not loarger than Integer.MAX_VALUE;
         */
        if (length > Integer.MAX_VALUE) {
            return null;
        }

        // Create the byte array to hold the data
        byte[] bytes = new byte[(int) length];

        // Read in the bytes
        int offset = 0;
        int numRead = 0;
        while ((offset < bytes.length)&& ((numRead = is.read(bytes, offset, bytes.length - offset)) >= 0)) {
            offset += numRead;
        }

        // Ensure all the bytes have been read in
        if (offset < bytes.length) {
            throw new IOException("Could not completely read file "
                    + file.getName());
        }

        is.close();
        return bytes;
    }
	
}
