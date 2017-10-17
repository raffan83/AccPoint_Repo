package it.portaleSTI.bo;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;

import it.portaleSTI.DAO.SQLLiteDAO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.PlayloadCampionamentoDTO;
import it.portaleSTI.DTO.UtenteDTO;

import org.hibernate.Session;

public class GestioneInterventoCampionamentoBO {

	public static ObjSavePackDTO saveDataDB(ObjSavePackDTO esito,InterventoCampionamentoDTO intervento, Session session, UtenteDTO utente) throws Exception {

		try {
			
			String nomeDB=esito.getPackNameAssigned().getPath();
			
			Connection con =SQLLiteDAO.getConnection(nomeDB);
			
			GestioneCampionamentoBO.deleteOldPlayLoad(intervento,session);
			
			ArrayList<PlayloadCampionamentoDTO> listaPlay=SQLLiteDAO.getListaPlayLoad(con,intervento);

			esito.setEsito(1);
			
			for (int i = 0; i < listaPlay.size(); i++) 
			{
				session.save(listaPlay.get(i));
			}
			
			new CreateSchedaCampionamento(intervento,session);
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

}
