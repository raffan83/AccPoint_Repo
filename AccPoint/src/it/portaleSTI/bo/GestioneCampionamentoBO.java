package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneCampionamentoDAO;
import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DTO.ArticoloMilestoneDTO;

import it.portaleSTI.DTO.PlayloadCampionamentoDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DatasetCampionamentoDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.PrenotazioneAccessorioDTO;
import it.portaleSTI.DTO.PrenotazioniDotazioneDTO;
import it.portaleSTI.DTO.TipoCampionamentoDTO;


import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import org.hibernate.Session;

public class GestioneCampionamentoBO {

	
	public static ArrayList<ArticoloMilestoneDTO> getListaArticoli(CompanyDTO company, Session session) throws Exception
	{
		return GestioneCampionamentoDAO.getListaArticoli(company);
	}


	public static ArticoloMilestoneDTO getArticoloById(String idArticolo,
			ArrayList<ArticoloMilestoneDTO> listaArticoli) {

		ArticoloMilestoneDTO articolo = null;
		for (ArticoloMilestoneDTO articoloMilestoneDTO : listaArticoli) {
			
			if(articoloMilestoneDTO.getID_ANAART().equals(idArticolo)) {
				articolo = articoloMilestoneDTO;
			}
			
		}
		
		return articolo;
	}


	public static void saveIntervento(InterventoCampionamentoDTO intervento, Session session) throws Exception {
		 GestioneCampionamentoDAO.saveIntervento(intervento,session);
	}


	public static List<InterventoCampionamentoDTO> getListaInterventi(String idCommessa, Session session) {
		return GestioneCampionamentoDAO.getListaInterventi(idCommessa,session);

	}


	public static ArrayList<TipoCampionamentoDTO> getListaTipoCampionamento(Session session) {
		// TODO Auto-generated method stub
		return GestioneCampionamentoDAO.getListaTipoCampionamento(session);
	}


	public static InterventoCampionamentoDTO getIntervento(String idIntervento) {
		// TODO Auto-generated method stub
		return GestioneCampionamentoDAO.getIntervento(idIntervento);
	}


	public static ArrayList<PrenotazioniDotazioneDTO> getListaPrenotazioniDotazione(String idIntervento, Session session) {
 		return GestioneCampionamentoDAO.getListaPrenotazioniDotazione(idIntervento,session);
	}


	public static ArrayList<PrenotazioneAccessorioDTO> getListaPrenotazioniAccessori(String idIntervento, Session session) {
		return GestioneCampionamentoDAO.getListaPrenotazioniAccessori(idIntervento,session);
	}


	public static ArrayList<DatasetCampionamentoDTO> getListaDataset(int idTipoCampionamento) {

		return GestioneCampionamentoDAO.getListaDataset(idTipoCampionamento);
	}


	public static LinkedHashMap<Integer, ArrayList<PlayloadCampionamentoDTO>> getListaPayload(int idCampionamento, Session session) {
		
		ArrayList<PlayloadCampionamentoDTO> lista = GestioneCampionamentoDAO.getListaPayload(idCampionamento,session);

		LinkedHashMap<Integer, ArrayList<PlayloadCampionamentoDTO>> hashPlayload = new LinkedHashMap<Integer, ArrayList<PlayloadCampionamentoDTO>>();
		for (PlayloadCampionamentoDTO playloadCampionamentoDTO : lista) {
			if(hashPlayload.containsKey(playloadCampionamentoDTO.getId_punto())) {
				ArrayList<PlayloadCampionamentoDTO> listaPlay = hashPlayload.get(playloadCampionamentoDTO.getId_punto());
				listaPlay.add(playloadCampionamentoDTO);
				hashPlayload.put(playloadCampionamentoDTO.getId_punto(), listaPlay);
			}else {
				ArrayList<PlayloadCampionamentoDTO> listaPlay = new ArrayList<PlayloadCampionamentoDTO>();
				listaPlay.add(playloadCampionamentoDTO);
				hashPlayload.put(playloadCampionamentoDTO.getId_punto(), listaPlay);
			}
		}

		return hashPlayload;
	}


	public static void updateIntervento(InterventoCampionamentoDTO intervento,Session session)throws Exception{
		
		session.update(intervento);
		
	}


	public static void deleteOldPlayLoad(InterventoCampionamentoDTO intervento,Session session) {
		
		GestioneCampionamentoDAO.deleteOldPlayLoad(intervento,session);
		
	}


	public static Boolean checkPrenotazioneDotazioneInRange(String idDotazione, Date dataInizio, Date dataFine, Session session) {
		
		ArrayList<PrenotazioniDotazioneDTO> prenotazioni = GestioneCampionamentoDAO.getListaPrenotazioniDotazioneRange(idDotazione, dataInizio, session);
	    if(prenotazioni.size()>0) {
	    		return false;
	    }
	    
		Calendar cal = Calendar.getInstance();
		cal.setTime(dataInizio);
		while (cal.getTime().before(dataFine)) {
		    cal.add(Calendar.DATE, 1);
		    ArrayList<PrenotazioniDotazioneDTO> prenotazioniArr = GestioneCampionamentoDAO.getListaPrenotazioniDotazioneRange(idDotazione, cal.getTime(), session);
		    if(prenotazioniArr.size()>0) {
	    			return false;
		    }
		}

		return true;
		
	}
	
}
