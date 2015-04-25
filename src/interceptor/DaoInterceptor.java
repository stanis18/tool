package interceptor;

import org.vraptor.Interceptor;
import org.vraptor.LogicException;
import org.vraptor.LogicFlow;
import org.vraptor.annotations.Out;
import org.vraptor.view.ViewException;

import dao.DaoFactory;

public class DaoInterceptor implements Interceptor {

	private final DaoFactory factory;

	public DaoInterceptor(){
		super();
		this.factory = new DaoFactory();
	}
	
	public void intercept(LogicFlow flow) throws LogicException, ViewException {
		// executa a logica
		flow.execute();
		// se sobrou transacao sem comitar, faz rollback
		if (this.factory.hasTransaction()) {
			this.factory.rollback();
		}
		this.factory.close();
	}

	@Out(key = "dao.DaoFactory")
	public DaoFactory getFactory() {
		return this.factory;
	}
}