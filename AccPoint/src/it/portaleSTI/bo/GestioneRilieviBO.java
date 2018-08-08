package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneRilieviDAO;
import it.portaleSTI.DTO.RilImprontaDTO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.RilPuntoQuotaDTO;
import it.portaleSTI.DTO.RilQuotaDTO;
import it.portaleSTI.DTO.RilQuotaFunzionaleDTO;
import it.portaleSTI.DTO.RilSimboloDTO;
import it.portaleSTI.DTO.RilTipoRilievoDTO;

public class GestioneRilieviBO {

	public static ArrayList<RilMisuraRilievoDTO> getListaRilievi() {
		
		return GestioneRilieviDAO.getListaRilievi();
	}

	public static ArrayList<RilTipoRilievoDTO> getListaTipoRilievo() {
		
		return GestioneRilieviDAO.getListaTipoRilievo();
	}

	public static void saveRilievo(RilMisuraRilievoDTO misura_rilievo, Session session) {
		
		GestioneRilieviDAO.saveRilievo(misura_rilievo, session);
		
	}

	public static void update(RilMisuraRilievoDTO misura_rilievo, Session session) {

		GestioneRilieviDAO.updateRilievo(misura_rilievo, session);
	}

	public static RilMisuraRilievoDTO getMisuraRilieviFromId(int id_misura, Session session) {

		return GestioneRilieviDAO.getMisuraRilievoFromId(id_misura, session);
	}

	public static ArrayList<RilImprontaDTO> getListaImprontePerMisura(int id_misura) {
		
		return GestioneRilieviDAO.getListaImprontePerMisura(id_misura);
	}

	public static ArrayList<RilSimboloDTO> getListaSimboli() {
		
		return GestioneRilieviDAO.getListaSimboli();
	}

	public static ArrayList<RilQuotaFunzionaleDTO> getListaQuoteFunzionali() {
	
		return GestioneRilieviDAO.getListaQuoteFunzionali();
	}

	public static ArrayList<RilQuotaDTO> getQuoteFromImpronta(int id_impronta) {
		
		return GestioneRilieviDAO.getQuoteFromImpronta(id_impronta);
	}

	public static ArrayList<RilPuntoQuotaDTO> getPuntoQuotiFromQuota(int id_quota) {

		return GestioneRilieviDAO.getPuntoQuotiFromQuota(id_quota);
	}

	public static RilImprontaDTO getImprontaById(int id_impronta) {
		
		return GestioneRilieviDAO.getimprontaById(id_impronta);
	}
	
	

}
