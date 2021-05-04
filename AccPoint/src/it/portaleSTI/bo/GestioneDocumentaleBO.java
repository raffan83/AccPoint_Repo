package it.portaleSTI.bo;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneDocumentaleDAO;
import it.portaleSTI.DTO.DocumCommittenteDTO;
import it.portaleSTI.DTO.DocumDipendenteFornDTO;
import it.portaleSTI.DTO.DocumEmailDTO;
import it.portaleSTI.DTO.DocumFornitoreDTO;
import it.portaleSTI.DTO.DocumReferenteFornDTO;
import it.portaleSTI.DTO.DocumTLDocumentoDTO;
import it.portaleSTI.DTO.DocumTipoDocumentoDTO;

public class GestioneDocumentaleBO {

	public static ArrayList<DocumCommittenteDTO> getListaCommittenti(Session session) {
		
		return GestioneDocumentaleDAO.getListaCommittenti(session);
	}

	public static DocumCommittenteDTO getCommittenteFromID(int id_committente, Session session) {
		
		return GestioneDocumentaleDAO.getCommittenteFromID(id_committente, session);
	}

	public static ArrayList<DocumFornitoreDTO> getListaDocumFornitori(Session session) {

		return GestioneDocumentaleDAO.getListaDocumFornitori(session);
	}

	public static DocumFornitoreDTO getFornitoreFromId(int id_fornitore, Session session) {
		
		return GestioneDocumentaleDAO.getFornitoreFromId(id_fornitore, session);
	}

	public static ArrayList<DocumReferenteFornDTO> getListaReferenti(int id_fornitore,int id_committente,Session session) {
		
		return GestioneDocumentaleDAO.getListaReferenti(id_fornitore, id_committente, session);
	}

	public static DocumReferenteFornDTO getReferenteFromId(int id_referente, Session session) {
	
		return GestioneDocumentaleDAO.getReferenteFromId(id_referente, session);
	}

	public static ArrayList<DocumDipendenteFornDTO> getListaDipendenti(int id_committente, int id_fornitore,Session session) {
		
		return GestioneDocumentaleDAO.getListaDipendenti(id_committente, id_fornitore,session);
	}

	public static DocumDipendenteFornDTO getDipendenteFromId(int id_dipendente, Session session) {
		
		return GestioneDocumentaleDAO.getDipendenteFromId(id_dipendente, session);
	}

	public static ArrayList<DocumTLDocumentoDTO> getListaDocumenti(String data_scadenza, int id_fornitore,int id_committente, Session session) throws ParseException, Exception {
		
		return GestioneDocumentaleDAO.getListaDocumenti(data_scadenza,id_fornitore,id_committente, session);
	}
	
	public static ArrayList<DocumTLDocumentoDTO> getListaDocumentiDaApprovare(String data_scadenza, int id_fornitore, Session session) throws Exception, ParseException {
		
		return GestioneDocumentaleDAO.getListaDocumentiDaApprovare(data_scadenza,id_fornitore, session);
	}

	public static DocumTLDocumentoDTO getDocumentoFromId(int id_documento, Session session) {
		
		return GestioneDocumentaleDAO.getDocumentoFromId(id_documento, session);
	}

	public static HashMap<String, Integer> getDocumentiScadenza(int id_fornitore, int id_committente, Session session) {
		
		return GestioneDocumentaleDAO.getDocumentiScadenza(id_fornitore,id_committente, session);
	}

	public static ArrayList<DocumEmailDTO> getStoricoEmail(int id_documento, Session session) {
	
		return GestioneDocumentaleDAO.getStoricoEmail(id_documento, session);
	}

	public static ArrayList<DocumTLDocumentoDTO> getListaDocumentiDaAssociare(int id_committente, int id_fornitore, Session session) {
		
		return GestioneDocumentaleDAO.getListaDocumentiDaAssociare(id_committente, id_fornitore, session);
	}

	public static ArrayList<DocumTLDocumentoDTO> getDocumentiObsoleti(Session session) {
	
		return GestioneDocumentaleDAO.getDocumentiObsoleti(session);
	}

	public static DocumCommittenteDTO getCommittenteFromIDClienteSede(int idCliente, int idSede, Session session) {
		
		return GestioneDocumentaleDAO.getCommittenteFromIDClienteSede(idCliente, idSede, session);
	}

	public static ArrayList<DocumTipoDocumentoDTO> getListaTipoDocumento(Session session) {
		
		return GestioneDocumentaleDAO.getListaTipoDocumento(session);
	}

	public static DocumTipoDocumentoDTO getTipoDocumentoFromId(int id_tipo, Session session) {

		return GestioneDocumentaleDAO.getTipoDocumentoFromId(id_tipo, session);
	}

	public static ArrayList<DocumTLDocumentoDTO> getListaDocumentiScadenzario(String dateFrom, String dateTo, int fornitore,int committente, Session session) throws Exception, Exception {

		return GestioneDocumentaleDAO.getListaDocumentiScadenzario(dateFrom, dateTo, fornitore, committente, session);
	}


}
