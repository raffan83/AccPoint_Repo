package it.portaleSTI.bo;

import it.portaleSTI.DTO.UtenteDTO;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 * Test Hibernate API
 *
 * @author AppuntiSoftware.it
 */
public class TestHibernate{
	private SessionFactory sessionFactory;
	protected void setUp() throws Exception {
//		Otteniamo una SessionFactory per la nostra applicazione
		sessionFactory = new Configuration().configure().buildSessionFactory();
		
	}
	protected void shutDown() throws Exception {
		if ( sessionFactory != null ) {
			sessionFactory.close();
		}
	}
	public void testBasicUsage() {
//		creiamo ed inseriamo degli eventi
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		//session.save( new UtenteDTO(2,"Test","Test","test","AT"));
		session.getTransaction().commit();
		session.close();
//		visualizziamo gli eventi memorizzati su db
		session = sessionFactory.openSession();
		session.beginTransaction();
		
		List<UtenteDTO> result = session.createQuery( "from users" ).list();
		
		for ( UtenteDTO event : result ) {
			System.out.println( "Event (" + event.getNominativo());
		}
		session.getTransaction().commit();
		session.close();
	}
	
	public static void main (String arg[]) throws Exception{
		TestHibernate test= new TestHibernate();
		test.setUp();
		test.testBasicUsage();
		test.shutDown();
	}
}
