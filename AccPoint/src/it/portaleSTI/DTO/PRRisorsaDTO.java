package it.portaleSTI.DTO;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import org.hibernate.Session;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.action.ContextListener;
import it.portaleSTI.bo.GestioneCertificatoBO;
import it.portaleSTI.bo.GestioneUtenteBO;

public class PRRisorsaDTO {
	
	private int id;
	private UtenteDTO utente;
	private ForPartecipanteDTO partecipante;
	Set<PRRequisitoRisorsaDTO> listaRequisiti = new HashSet<PRRequisitoRisorsaDTO>();
	private int disabilitato;
	private boolean isPreposto;
	
	
	

	public Set<PRRequisitoRisorsaDTO> getListaRequisiti() {
		return listaRequisiti;
	}


	public int getDisabilitato() {
		return disabilitato;
	}




	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}




	public void setListaRequisiti(Set<PRRequisitoRisorsaDTO> listaRequisiti) {
		this.listaRequisiti = listaRequisiti;
	}




	public int getId() {
		return id;
	}




	public void setId(int id) {
		this.id = id;
	}




	public UtenteDTO getUtente() {
		return utente;
	}




	public void setUtente(UtenteDTO utente) {
		this.utente = utente;
	}




	public ForPartecipanteDTO getPartecipante() {
		return partecipante;
	}




	public void setPartecipante(ForPartecipanteDTO partecipante) {
		this.partecipante = partecipante;
	}




	public boolean isPreposto() {
		return isPreposto;
	}


	public void setPreposto(boolean isPreposto) {
		this.isPreposto = isPreposto;
	}


	public PRRisorsaDTO() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) throws Exception {
		
		new ContextListener().configCostantApplication();
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		PRRisorsaDTO entity = (PRRisorsaDTO) session.get(PRRisorsaDTO.class, 1);
		
		Iterator it = entity.getListaRequisiti().iterator();
		
		while(it.hasNext()) {
			PRRequisitoRisorsaDTO requisito = (PRRequisitoRisorsaDTO) it.next();
		    System.out.println(requisito); 
		}

	}
}
