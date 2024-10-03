package it.portaleSTI.DAO;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.ConsegnaDpiDTO;
import it.portaleSTI.DTO.DocumDipendenteFornDTO;
import it.portaleSTI.DTO.DpiAllegatiDTO;
import it.portaleSTI.DTO.DpiDTO;
import it.portaleSTI.DTO.DpiManualeDTO;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.DTO.TipoAccessorioDispositivoDTO;
import it.portaleSTI.DTO.TipoDpiDTO;

public class GestioneDpiDAO {

	public static ArrayList<TipoDpiDTO> getListaTipoDPI(Session session) {
		
		ArrayList<TipoDpiDTO> lista = null;
		
		Query query = session.createQuery("from TipoDpiDTO");
		
		lista = (ArrayList<TipoDpiDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<ConsegnaDpiDTO> getListaConsegneDpi(Session session) {

		ArrayList<ConsegnaDpiDTO> lista = null;
		
		Query query = session.createQuery("from ConsegnaDpiDTO  ");
		
		lista = (ArrayList<ConsegnaDpiDTO>) query.list();
		
		return lista;
	}

	public static ConsegnaDpiDTO getCosegnaFromID(int id_consegna, Session session) {

		ArrayList<ConsegnaDpiDTO> lista = null;
		ConsegnaDpiDTO result = null;
		
		Query query = session.createQuery("from ConsegnaDpiDTO where id =:_id_consegna");
		query.setParameter("_id_consegna", id_consegna);
		
		lista = (ArrayList<ConsegnaDpiDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static TipoDpiDTO getTipoDPIFromId(int id_tipo, Session session) {
		
		ArrayList<TipoDpiDTO> lista = null;
		TipoDpiDTO result = null;
		
		Query query = session.createQuery("from TipoDpiDTO where id =:_id_tipo");
		query.setParameter("_id_tipo", id_tipo);
		
		lista = (ArrayList<TipoDpiDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<ConsegnaDpiDTO> getListaConsegnaRiconsegnaDPI(DocumDipendenteFornDTO lavoratore,int tipo_scheda, Session session) {
	
		ArrayList<ConsegnaDpiDTO> lista = null;
		
		Query query = null;
		
		if(tipo_scheda == 0) {
			query = session.createQuery("from ConsegnaDpiDTO where is_restituzione = 0 and lavoratore.id = :_id_lavoratore and dpi.tipologia = 1");
			query.setParameter("_id_lavoratore", lavoratore.getId());
		}else if(tipo_scheda == 1) {
			query = session.createQuery("from ConsegnaDpiDTO where is_restituzione = 1 and lavoratore.id = :_id_lavoratore  and dpi.tipologia = 1");
			query.setParameter("_id_lavoratore", lavoratore.getId());
		}else if(tipo_scheda == 2) {
			query = session.createQuery("from ConsegnaDpiDTO where dpi.collettivo = 1");
		}else if(tipo_scheda == 3) {
			query = session.createQuery("from ConsegnaDpiDTO where  dpi.tipologia = 2");
		}
	
		
		lista = (ArrayList<ConsegnaDpiDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<DpiDTO> getListaDpi(Session session) {
		ArrayList<DpiDTO> lista = null;
		
		Query query = session.createQuery("from DpiDTO");
		
		lista = (ArrayList<DpiDTO>) query.list();
		
		return lista;
	}

	public static DpiDTO getDpiFormId(int id_dpi, Session session) {
		
		ArrayList<DpiDTO> lista = null;
		DpiDTO result = null;
		
		Query query = session.createQuery("from DpiDTO where id =:_id");
		query.setParameter("_id", id_dpi);
		
		lista = (ArrayList<DpiDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<ConsegnaDpiDTO> getListaEventiFromDPI(int id_dpi, Session session) {

		ArrayList<ConsegnaDpiDTO> lista = null;
		
		Query query = session.createQuery("from ConsegnaDpiDTO where dpi.id = :_id_dpi");
		query.setParameter("_id_dpi", id_dpi);
		
		lista = (ArrayList<ConsegnaDpiDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<DpiDTO> getListaDpiScadenzario(String dateFrom, String dateTo, Session session) throws Exception, ParseException {

		ArrayList<Object[]> res = null;
		ArrayList<DpiDTO> lista = new ArrayList<DpiDTO>();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Query query = session.createQuery("from DpiDTO where assegnato=0 and data_scadenza between :_data_start and :_data_end and disabilitato = 0");
		query.setParameter("_data_start", sdf.parse(dateFrom));
		query.setParameter("_data_end", sdf.parse(dateTo));
		
		lista = (ArrayList<DpiDTO>) query.list();

		query = session.createQuery("select  a.dpi, a.lavoratore from ConsegnaDpiDTO a where a.dpi.data_scadenza between :_data_start and :_data_end and a.dpi.disabilitato = 0");
		query.setParameter("_data_start", sdf.parse(dateFrom));
		query.setParameter("_data_end", sdf.parse(dateTo));
		
		
		res = (ArrayList<Object[]>) query.list();
		
		for (Object[] objects : res) {
			DpiDTO dpi = null;
			
			if(objects[0]!=null) {
				 dpi = (DpiDTO) objects[0];	
			}
			
			
			if(objects[0]!=null && !lista.contains(dpi)) {
				
				if(objects[1]!=null) {
					DocumDipendenteFornDTO lav = (DocumDipendenteFornDTO) objects[1];
					dpi.setNome_lavoratore(lav.getNome() +" "+lav.getCognome());	
				}
				
				lista.add(dpi);
			}
		}
		
		return lista;
	}

	public static DpiManualeDTO getManualeFromId(int id_manuale, Session session) {

		ArrayList<DpiManualeDTO> lista = null;
		DpiManualeDTO result = null;
		
		Query query = session.createQuery("from DpiManualeDTO where id =:_id");
		query.setParameter("_id", id_manuale);
		
		lista = (ArrayList<DpiManualeDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
			
	}

	public static ArrayList<DpiManualeDTO> getListaManuali(Session session) {
		ArrayList<DpiManualeDTO> lista = null;
		
		Query query = session.createQuery("from DpiManualeDTO where disabilitato = 0");
		
		lista = (ArrayList<DpiManualeDTO>) query.list();
		
		return lista;
	}

	public static DpiAllegatiDTO getAllegatoFromID(int id_allegato, Session session) {

		ArrayList<DpiAllegatiDTO> lista = null;
		DpiAllegatiDTO result = null;
		
		Query query = session.createQuery("from DpiAllegatiDTO where id =:_id");
		query.setParameter("_id", id_allegato);
		
		lista = (ArrayList<DpiAllegatiDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<DpiAllegatiDTO> getListaAllegati(int id_manuale, int id_dpi, Session session) {
		
		ArrayList<DpiAllegatiDTO> lista = null;
		

		Query query = null;
		if(id_manuale!=0) {
			query = session.createQuery("from DpiAllegatiDTO where id_manuale =:_id and disabilitato = 0");
			query.setParameter("_id", id_manuale);
		}else {
	
			query = session.createQuery("from DpiAllegatiDTO where id_dpi =:_id and disabilitato = 0");
			query.setParameter("_id", id_dpi);
		}

		
		lista = (ArrayList<DpiAllegatiDTO>) query.list();		
	
		
		return lista;
	}

	public static ArrayList<ConsegnaDpiDTO> getListaConsegneDpiNonRest(Session session) {
		
		ArrayList<ConsegnaDpiDTO> lista = null;
		

		Query query =  session.createQuery("from ConsegnaDpiDTO where riconsegnato = 0 and is_restituzione = 0 and restituzione.id is null");

		
		lista = (ArrayList<ConsegnaDpiDTO>) query.list();		
	
		
		return lista;
	}

	public static ArrayList<TipoAccessorioDispositivoDTO> getListaAccessoriDispositivo(Session session) {
		ArrayList<TipoAccessorioDispositivoDTO> lista = null;
		

		Query query =  session.createQuery("from TipoAccessorioDispositivoDTO");

		
		lista = (ArrayList<TipoAccessorioDispositivoDTO>) query.list();		
	
		
		return lista;
	}


}
