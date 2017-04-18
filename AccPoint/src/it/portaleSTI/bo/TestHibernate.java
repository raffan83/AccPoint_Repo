package it.portaleSTI.bo;

import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.StatoInterventoDTO;
import it.portaleSTI.DTO.UtenteDTO;

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
		InterventoDTO intervento = new InterventoDTO();
		
		StatoInterventoDTO stato = new StatoInterventoDTO();
		stato.setId(1);
		intervento.setStatoIntervento(stato);
		
		intervento.setPressoDestinatario(0);
		
		CompanyDTO company = new CompanyDTO();
		company.setId(4132);
		intervento.setCompany(company);
		
		//UtenteDTO utente= new  UtenteDTO(); 
		//utente.setId(1);
		UtenteDTO utente = new UtenteDTO();

		utente.setId(1);
		intervento.setUser(utente);
		
		intervento.setId_cliente(1);
		intervento.setIdSede(1);
		
		intervento.setIdCommessa("201700001");
		

		
		session.save(intervento);
		session.getTransaction().commit();
		session.close();
//		visualizziamo gli eventi memorizzati su db
	/*	session = sessionFactory.openSession();
		session.beginTransaction();
		
		List<UtenteDTO> result = session.createQuery( "from users" ).list();
		
		for ( UtenteDTO event : result ) {
			System.out.println( "Event (" + event.getNominativo());
		}
		session.getTransaction().commit();
		session.close();*/
	}
	
	public static void main (String arg[]) throws Exception{
		TestHibernate test= new TestHibernate();
		test.setUp();
		test.testBasicUsage();
		test.shutDown();
	}
}
