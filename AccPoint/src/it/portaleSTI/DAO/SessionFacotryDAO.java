package it.portaleSTI.DAO;

import java.util.Properties;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import it.portaleSTI.Util.Costanti;
import it.portaleSTI.action.ContextListener;

public class SessionFacotryDAO {
	/*private static SessionFactory sessionFactory;
	
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
	}*/

	 private static final SessionFactory sessionFactory = buildSessionFactory();

	    private static SessionFactory buildSessionFactory() {
	    	SessionFactory sessionFactory=null;
	    	try {
	            // Create the SessionFactory from hibernate.cfg.xml
	        	Configuration configuration = new Configuration();
	        	configuration.setProperty("hibernate.connection.url",Costanti.CON_STR_MYSQL );
	        	
	        	configuration.setProperty("hibernate.connection.password",Costanti.CON_STR_MYSQL_PASS);
	        	configuration.setProperty("hibernate.connection.username",Costanti.CON_STR_MYSQL_USR);
	        	
	        	configuration.configure();
	        	
	        	 sessionFactory =configuration.buildSessionFactory();
	           
	        }
	        catch (Throwable ex) {
	            // Make sure you log the exception, as it might be swallowed
	            System.err.println("Initial SessionFactory creation failed." + ex);
	            throw new ExceptionInInitializerError(ex);
	        }
	        
	        return sessionFactory;
	    }

	    public static SessionFactory get() {
	        return sessionFactory;
	    }
	    
	    public static void shutDown(SessionFactory sf) throws Exception {
			if ( sf != null ) 
			{
				sf.close();
			}
	    }
}
