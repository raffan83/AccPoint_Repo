package it.portaleSTI.bo;

import java.io.File;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletContext;

import it.portaleSTI.DAO.GestioneCampionamentoDAO;
import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.SQLLiteDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoCampioneDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.PlayloadCampionamentoDTO;
import it.portaleSTI.DTO.RelazioneCampionamentoDTO;
import it.portaleSTI.DTO.RapportoCampionamentoDTO;
import it.portaleSTI.DTO.TipologiaCampionamentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;

import org.apache.pdfbox.io.MemoryUsageSetting;
import org.apache.pdfbox.multipdf.PDFMergerUtility;
import org.hibernate.Session;

public class GestioneInterventoCampionamentoBO {

 	public static ObjSavePackDTO saveDataDB(ObjSavePackDTO esito,InterventoCampionamentoDTO intervento, Session session, UtenteDTO utente, ServletContext context) throws Exception {

		try {
			
			String nomeDB=esito.getPackNameAssigned().getPath();
			
			Connection con =SQLLiteDAO.getConnection(nomeDB);
			
			GestioneCampionamentoBO.deleteOldPlayLoad(intervento,session);
			
			ArrayList<PlayloadCampionamentoDTO> listaPlay=SQLLiteDAO.getListaPlayLoad(con,intervento);

			intervento.setDataChiusura(SQLLiteDAO.getDataChiusura(con));
			
			esito.setEsito(1);
			
			for (int i = 0; i < listaPlay.size(); i++) 
			{
				session.save(listaPlay.get(i));
			}
			
			
			new CreateSchedaCampionamento(intervento,session,context);			
			
			intervento.setStatoUpload("S");
			intervento.setDataUpload(new Date());
			intervento.setUserUpload(utente);
			GestioneCampionamentoBO.updateIntervento(intervento,session);
		
		} 
		catch (Exception e) 
		
		{
			esito.setEsito(0);
			esito.setErrorMsg("Errore Connessione DB: "+e.getMessage());
			e.printStackTrace();
			throw e;
		}

		return esito;
	}
 	public static InterventoCampionamentoDTO getIntervento(String idIntervento) {

		return GestioneCampionamentoDAO.getIntervento(idIntervento);

	}
	public static ArrayList<TipologiaCampionamentoDTO> getListaTipologieCampionamento() {
		// TODO Auto-generated method stub
		return null;
	}
	public static RelazioneCampionamentoDTO getTipoRelazione(int id_matrice, int id_tipologia_campionamento) {
		
		return GestioneCampionamentoDAO.getRelazione(id_matrice,id_tipologia_campionamento);
	}
	
	

}
