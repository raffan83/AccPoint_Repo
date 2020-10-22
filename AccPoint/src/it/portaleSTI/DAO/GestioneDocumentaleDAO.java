package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.DocumCommittenteDTO;
import it.portaleSTI.DTO.DocumDipendenteFornDTO;
import it.portaleSTI.DTO.DocumFornitoreDTO;
import it.portaleSTI.DTO.DocumReferenteFornDTO;
import it.portaleSTI.DTO.DocumTLDocumentoDTO;

public class GestioneDocumentaleDAO {

	public static ArrayList<DocumCommittenteDTO> getListaCommittenti(Session session) {
		
		ArrayList<DocumCommittenteDTO> lista = null;
		
		Query query = session.createQuery("from DocumCommittenteDTO");
		
		lista = (ArrayList<DocumCommittenteDTO>) query.list();
		
		return lista;
	}

	public static DocumCommittenteDTO getCommittenteFromID(int id_committente, Session session) {
		ArrayList<DocumCommittenteDTO> lista = null;
		DocumCommittenteDTO result = null;
		
		Query query = session.createQuery("from DocumCommittenteDTO where id=:_id");
		query.setParameter("_id", id_committente);
		
		lista = (ArrayList<DocumCommittenteDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<DocumFornitoreDTO> getListaDocumFornitori(Session session) {

		ArrayList<DocumFornitoreDTO> lista = null;
		
		Query query = session.createQuery("from DocumFornitoreDTO");
		
		lista = (ArrayList<DocumFornitoreDTO>) query.list();
		
		return lista;
	}

	public static DocumFornitoreDTO getFornitoreFromId(int id_fornitore, Session session) {
		
		ArrayList<DocumFornitoreDTO> lista = null;
		DocumFornitoreDTO result = null;
		
		Query query = session.createQuery("from DocumFornitoreDTO where id=:_id");
		query.setParameter("_id", id_fornitore);
		
		lista = (ArrayList<DocumFornitoreDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<DocumReferenteFornDTO> getListaReferenti(Session session) {

		ArrayList<DocumReferenteFornDTO> lista = null;
		
		Query query = session.createQuery("from DocumReferenteFornDTO");
		
		lista = (ArrayList<DocumReferenteFornDTO>) query.list();
		
		return lista;
	}

	public static DocumReferenteFornDTO getReferenteFromId(int id_referente, Session session) {

		ArrayList<DocumReferenteFornDTO> lista = null;
		DocumReferenteFornDTO result = null;
		
		Query query = session.createQuery("from DocumReferenteFornDTO where id=:_id");
		query.setParameter("_id", id_referente);
		
		lista = (ArrayList<DocumReferenteFornDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<DocumDipendenteFornDTO> getListaDipendenti(Session session) {
	
		ArrayList<DocumDipendenteFornDTO> lista = null;
		
		Query query = session.createQuery("from DocumDipendenteFornDTO");
		
		lista = (ArrayList<DocumDipendenteFornDTO>) query.list();
		
		return lista;
	}
	
	public static DocumDipendenteFornDTO getDipendenteFromId(int id_dipendente, Session session) {

		ArrayList<DocumDipendenteFornDTO> lista = null;
		DocumDipendenteFornDTO result = null;
		
		Query query = session.createQuery("from DocumDipendenteFornDTO where id=:_id");
		query.setParameter("_id", id_dipendente);
		
		lista = (ArrayList<DocumDipendenteFornDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<DocumTLDocumentoDTO> getListaDocumenti(Session session) {

		ArrayList<DocumTLDocumentoDTO> lista = null;
		
		Query query = session.createQuery("from DocumTLDocumentoDTO where disabilitato = 0");
		
		lista = (ArrayList<DocumTLDocumentoDTO>) query.list();
		
		return lista;
	}

	public static DocumTLDocumentoDTO getDocumentoFromId(int id_documento, Session session) {
		
		ArrayList<DocumTLDocumentoDTO> lista = null;
		DocumTLDocumentoDTO result = null;
		
		Query query = session.createQuery("from DocumTLDocumentoDTO where id=:_id");
		query.setParameter("_id", id_documento);
		
		lista = (ArrayList<DocumTLDocumentoDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

}
