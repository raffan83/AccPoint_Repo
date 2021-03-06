package it.portaleSTI.bo;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneCampionamentoDAO;
import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.GestioneMagazzinoDAO;
import it.portaleSTI.DAO.SQLLiteDAO;
import it.portaleSTI.DTO.ArticoloMilestoneDTO;

import it.portaleSTI.DTO.PlayloadCampionamentoDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DatasetCampionamentoDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.LogMagazzinoDTO;
import it.portaleSTI.DTO.PrenotazioneAccessorioDTO;
import it.portaleSTI.DTO.PrenotazioniDotazioneDTO;
import it.portaleSTI.DTO.RapportoCampionamentoDTO;
import it.portaleSTI.DTO.TipoAnalisiDTO;
import it.portaleSTI.DTO.TipoMatriceDTO;
import it.portaleSTI.DTO.TipologiaCampionamentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;

import java.io.File;
import java.sql.Connection;
import java.text.SimpleDateFormat;
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


	public static ArrayList<TipoMatriceDTO> getListaTipoMatrice(Session session) {
		// TODO Auto-generated method stub
		return GestioneCampionamentoDAO.getListaTipoMatrice(session);
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


	public static ArrayList<DatasetCampionamentoDTO> getListaDataset(int idTipoCampionamento,int tipo_analisi) {

		return GestioneCampionamentoDAO.getListaDataset(idTipoCampionamento,tipo_analisi);
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


	public static Boolean checkPrenotazioneDotazioneInRange(String idDotazione, Date dataInizio, Date dataFine, UtenteDTO user, Session session) {
		
		ArrayList<PrenotazioniDotazioneDTO> prenotazioni = GestioneCampionamentoDAO.getListaPrenotazioniDotazioneRange(idDotazione, dataInizio, user, session);
	    if(prenotazioni.size()>0) {
	    		return false;
	    }
	    
		Calendar cal = Calendar.getInstance();
		cal.setTime(dataInizio);
		while (cal.getTime().before(dataFine)) {
		    cal.add(Calendar.DATE, 1);
		    ArrayList<PrenotazioniDotazioneDTO> prenotazioniArr = GestioneCampionamentoDAO.getListaPrenotazioniDotazioneRange(idDotazione, cal.getTime(), user, session);
		    if(prenotazioniArr.size()>0) {
	    			return false;
		    }
		}

		return true;
		
	}


	public static ArrayList<TipologiaCampionamentoDTO> getListaTipologieCampionamento(Session session) {
		// TODO Auto-generated method stub
		return GestioneCampionamentoDAO.getListaTipologieCampionamento(session);
	}
	
	public static String creaPacchettoCampionamento(int id_ANAGEN,int k2_ANAGEN_INDR, CompanyDTO cmp, String id_ANAGEN_NOME,Session session, InterventoCampionamentoDTO intervento) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("ddMMYYYYhhmmss");

		String timeStamp=sdf.format(new Date());
		String tipoMatrice=intervento.getTipoMatrice().getCodice().substring(0,2);
		String tipoCampionamento=intervento.getTipologiaCampionamento().getDescrizione().substring(0,2);
		String tipoAnalisi=intervento.getTipoAnalisi().getDescrizione().substring(0,2);
		
		String nomeFile="CAMP"+cmp.getId()+""+timeStamp+"_"+tipoMatrice+"_"+tipoCampionamento+"_"+tipoAnalisi;
		
		File directory= new File(Costanti.PATH_FOLDER+nomeFile);

		if(!directory.exists())
		{
			directory.mkdir();

		}
		
		Connection con = SQLLiteDAO.getConnection(directory.getPath(),nomeFile);
		
		SQLLiteDAO.cerateDBCampionamento(con);
	
		
		DirectMySqlDAO.insertGeneralCMP(con,intervento.getID_COMMESSA(),id_ANAGEN_NOME,intervento.getTipoMatrice().getDescrizione(),intervento.getTipologiaCampionamento().getDescrizione(),intervento.getTipoAnalisi().getDescrizione());
		
		DirectMySqlDAO.insertDataSet(con,intervento.getTipoMatrice().getId(),intervento.getTipoAnalisi().getId());
		
		
		
		return nomeFile;
	}

	
	
	public static void save(LogMagazzinoDTO logMagazzino, Session session) throws Exception {
		GestioneCampionamentoDAO.save(logMagazzino,session);
		
	}
	

	public static ArrayList<TipoAnalisiDTO> getListaTipoAnalisi(Session session) {
		return GestioneCampionamentoDAO.getListaTipoAnalisi(session);
	}


	public static TipoMatriceDTO getTipoMatriceById(String selectTipoMatrice, Session session) {
		// TODO Auto-generated method stub
		return GestioneCampionamentoDAO.getTipoMatriceById(selectTipoMatrice, session);
	}


	public static TipologiaCampionamentoDTO getTipologiaCampionamentoById(String selectTipologiaCampionamento,
			Session session) {
		// TODO Auto-generated method stub
		return GestioneCampionamentoDAO.getTipologiaCampionamentoById(selectTipologiaCampionamento, session);
	}


	public static TipoAnalisiDTO getTipoAnalisiById(String selectTipoAnalisi, Session session) {
		// TODO Auto-generated method stub
		return GestioneCampionamentoDAO.getTipoAnalisiById(selectTipoAnalisi, session);
	}
	
	public static ArrayList<RapportoCampionamentoDTO> getListaRelazioni(String id_commessa, Session session) {
		
		return GestioneCampionamentoDAO.getListaRelazioni(id_commessa,session);
	}


	public static RapportoCampionamentoDTO getRapportoById(String idRelazione, Session session) {
		// TODO Auto-generated method stub
		return GestioneCampionamentoDAO.getRapportoById(idRelazione,session);
	}
	
}
