package it.portaleSTI.DAO;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class SessionFacotryDAO {
	private static SessionFactory sessionFactory;
	
	public static SessionFactory get() throws Exception {
//		Otteniamo una SessionFactory per la nostra applicazione
		sessionFactory = new Configuration().configure().buildSessionFactory();
		return sessionFactory;
	}
	public static void shutDown(SessionFactory sf) throws Exception {
		if ( sf != null ) 
		{
			sf.close();
		}
	}

}
