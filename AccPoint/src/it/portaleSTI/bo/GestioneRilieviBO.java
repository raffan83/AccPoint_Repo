package it.portaleSTI.bo;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneRilieviDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.RilParticolareDTO;
import it.portaleSTI.DTO.RilAllegatiDTO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.RilPuntoQuotaDTO;
import it.portaleSTI.DTO.RilQuotaDTO;
import it.portaleSTI.DTO.RilQuotaFunzionaleDTO;
import it.portaleSTI.DTO.RilSimboloDTO;
import it.portaleSTI.DTO.RilTipoRilievoDTO;
import it.portaleSTI.DTO.SchedaConsegnaRilieviDTO;

public class GestioneRilieviBO {

	public static ArrayList<RilMisuraRilievoDTO> getListaRilievi() {
		
		return GestioneRilieviDAO.getListaRilievi();
	}

	public static ArrayList<RilTipoRilievoDTO> getListaTipoRilievo(Session session) {
		
		return GestioneRilieviDAO.getListaTipoRilievo(session);
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

	public static ArrayList<RilParticolareDTO> getListaParticolariPerMisura(int id_misura, Session session) {
		
		return GestioneRilieviDAO.getListaParticolariPerMisura(id_misura, session);
	}

	public static ArrayList<RilParticolareDTO> getListaImprontePerMisura(int id_misura, Session session) {
		
		return GestioneRilieviDAO.getListaImprontePerMisura(id_misura, session);
	}
	
	public static ArrayList<RilSimboloDTO> getListaSimboli(Session session) {
		
		return GestioneRilieviDAO.getListaSimboli(session);
	}

	public static ArrayList<RilQuotaFunzionaleDTO> getListaQuoteFunzionali(Session session) {
	
		return GestioneRilieviDAO.getListaQuoteFunzionali(session);
	}

	public static ArrayList<RilQuotaDTO> getQuoteFromImpronta(int id_impronta, Session session) {
		
		return GestioneRilieviDAO.getQuoteFromImpronta(id_impronta, session);
	}

	public static ArrayList<RilPuntoQuotaDTO> getPuntoQuotiFromQuota(int id_quota, Session session) {

		return GestioneRilieviDAO.getPuntoQuotiFromQuota(id_quota, session);
	}

	public static RilParticolareDTO getImprontaById(int id_impronta, Session session) {
		
		return GestioneRilieviDAO.getimprontaById(id_impronta, session);
	}
	
	
	public static BigDecimal[] getTolleranze(String lettera,int indiceTabellaTol,BigDecimal d)  {

		BigDecimal[] toRetun=null;
		
		try 
		{
			// setp 1 recupero valore IT da tabella normalizzata [ril_gradi_tolleranza]

			BigDecimal IT= GestioneRilieviDAO.getGradoTolleranza(d,indiceTabellaTol);

				
			if(Character.isUpperCase( lettera.charAt(0))) 
			{
				/* FORO */ 
				
				toRetun= new BigDecimal[2];
				BigDecimal tolleranzeForo=null;
				BigDecimal es=null;
				BigDecimal ei=null;

				String nomeColonna=getColumnNameForo(lettera,indiceTabellaTol);
				
				if(lettera.equals("A")||lettera.equals("B")||lettera.equals("C")||lettera.equals("CD")||
						lettera.equals("D")||lettera.equals("E")||lettera.equals("EF")||lettera.equals("F")||
						lettera.equals("FG")||lettera.equals("G")||lettera.equals("H"))
				{
					tolleranzeForo=GestioneRilieviDAO.getTolleranzeForo(lettera,indiceTabellaTol,d,nomeColonna);	
					ei=tolleranzeForo;
					es =ei.add(IT);
				}
				else if(lettera.equals("JS"))
				{
					es=IT.divide(new BigDecimal("2"),RoundingMode.HALF_UP);
					ei=IT.divide(new BigDecimal("2"),RoundingMode.HALF_UP).multiply(new BigDecimal("-1"));
				}
				else if(lettera.equals("P") || lettera.equals("ZC") && indiceTabellaTol > 6)
				{
					BigDecimal IT_1=GestioneRilieviDAO.getGradoTolleranza(d, indiceTabellaTol-1);
					BigDecimal delta=IT.subtract(IT_1);
					
					
					tolleranzeForo=GestioneRilieviDAO.getTolleranzeForo(lettera,indiceTabellaTol,d,nomeColonna);

					es=tolleranzeForo;
					ei =es.subtract(IT);	
					
					es=es.add(delta);
					ei=ei.add(delta);
				}

				else
				{
					tolleranzeForo=GestioneRilieviDAO.getTolleranzeForo(lettera,indiceTabellaTol,d,nomeColonna);
					es=tolleranzeForo;
					ei =es.subtract(IT);	
				}

				toRetun[0]=es;
				toRetun[1]=ei;
			}
			else 
			{
				/* ALBERO */ 
				BigDecimal tolleranzeAlbero=null;
				BigDecimal es=null;
				BigDecimal ei=null;
				toRetun= new BigDecimal[2];

				String nomeColonna=getColumnNameAlbero(lettera,indiceTabellaTol);
				
				if(lettera.equals("a")||lettera.equals("b")||lettera.equals("c")||lettera.equals("cd")||
						lettera.equals("d")||lettera.equals("e")||lettera.equals("ef")||lettera.equals("f")||
						lettera.equals("fg")||lettera.equals("g")||lettera.equals("h"))
				{
					tolleranzeAlbero=GestioneRilieviDAO.getTolleranzeAlbero(lettera,indiceTabellaTol,d,nomeColonna);	
					es=tolleranzeAlbero;
					ei =es.subtract(IT);
				}
				else if(lettera.equals("js"))
				{
					es=IT.divide(new BigDecimal("2"),RoundingMode.HALF_UP);
					ei=IT.divide(new BigDecimal("2"),RoundingMode.HALF_UP).multiply(new BigDecimal("-1"));
				}

				else
				{
					tolleranzeAlbero=GestioneRilieviDAO.getTolleranzeAlbero(lettera,indiceTabellaTol,d,nomeColonna);
					ei=tolleranzeAlbero;
					es =IT.subtract(ei.multiply(new BigDecimal("-1")));	
				}

				toRetun[0]=es;
				toRetun[1]=ei;
				//System.out.println("Tol + ("+es.setScale(3).divide(new BigDecimal(1000),RoundingMode.HALF_UP).toPlainString() + ") "
			//			+ "Tol- ("+ei.setScale(3).divide(new BigDecimal(1000),RoundingMode.HALF_UP).toPlainString()+")");

			}
		 
		}
		catch(Exception ex) 
		{
			ex.printStackTrace();
		}
		return toRetun;
	}

	private static String getColumnNameAlbero(String lettera, int indiceTabellaTol) {
		if(lettera.startsWith("j") && (indiceTabellaTol>4 &&indiceTabellaTol<7))
		{
			return "j_5_6";
		}
		if(lettera.startsWith("j") && indiceTabellaTol==7)
		{
			return "j_7";
		}				
		if(lettera.startsWith("j") && indiceTabellaTol==8)
		{
			return "j_8";
		}
		if(lettera.startsWith("j") && (indiceTabellaTol>4 &&indiceTabellaTol<7))
		{
			return "j_5_6";
		}
		if(lettera.startsWith("k") && (indiceTabellaTol> 3 &&indiceTabellaTol< 8))
		{
			return "k_4_7";
		}
		if(lettera.startsWith("k") && (indiceTabellaTol < 4 || indiceTabellaTol > 7))
		{
			return "k_altri";
		}

		return lettera;
	}

	private static String getColumnNameForo(String lettera, int indiceTabellaTol) {
		if(lettera.startsWith("J") && indiceTabellaTol==6)
		{
			return "j_6";
		}
		if(lettera.startsWith("J") && indiceTabellaTol==7)
		{
			return "j_7";
		}	
		if(lettera.startsWith("J") && indiceTabellaTol==8)
		{
			return "j_8";
		}
		
		if(lettera.startsWith("K") && indiceTabellaTol==8)
		{
			return "K_8";
		}
		if(lettera.startsWith("K") && indiceTabellaTol==9)
		{
			return "K_9";
		}
		if(lettera.startsWith("M") && indiceTabellaTol==8)
		{
			return "m_8";
		}
		if(lettera.startsWith("M") && indiceTabellaTol==9)
		{
			return "m_9";
		}
		if(lettera.startsWith("N") && indiceTabellaTol==8)
		{
			return "n_8";
		}
		if(lettera.startsWith("N") && indiceTabellaTol==9)
		{
			return "n_9";
		}


		return lettera;
	}

	public static RilQuotaDTO getQuotaFromId(int id_quota, Session session) {

		return GestioneRilieviDAO.getQuotaFromId(id_quota, session);
	}

	public static void updatePezzi(int n_pezzi, int id_rilievo, Session session) {

		GestioneRilieviDAO.updatePezzi(n_pezzi, id_rilievo, session);
		
	}

	public static void chiudiRilievo(int id_rilievo, Session session) {

		GestioneRilieviDAO.chiudiRilievi(id_rilievo, session);
		
	}

	public static ArrayList<RilMisuraRilievoDTO> getListaRilieviInLavorazione(int id_stato_lavorazione, Session session) {
		
		return GestioneRilieviDAO.getListaRilieviInLavorazione(id_stato_lavorazione, session);
	}

	public static void updateQuota(RilQuotaDTO quota, int id_impronta, Session session) {
		
		GestioneRilieviDAO.updateQuota(quota, id_impronta, session);
		
	}

	public static int getMaxIdRipetizione(RilParticolareDTO impronta, Session session) {
		
		return GestioneRilieviDAO.getMaxIdRipetizione(impronta, session);
	}

	public static ArrayList<RilMisuraRilievoDTO> getListaRilieviFiltrati(int id_stato_lavorazione, int cliente, Session session) {
	
		return GestioneRilieviDAO.getListaRilieviFiltrati(id_stato_lavorazione, cliente, session);
	}

	public static RilMisuraRilievoDTO getRilievoFromId(int id_rilievo, Session session) {

		return GestioneRilieviDAO.getRilievoFromId(id_rilievo, session);		
	}

	public static void uploadAllegato(FileItem item, int id, boolean img, boolean archivio, Session session) {

		GestioneRilieviDAO.uploadAllegato(item, id, img,archivio, session);
		
	}
	

	public static void updateNoteParticolare(int particolare, String note_particolare, Session session) {

		GestioneRilieviDAO.updateNoteParticolare(particolare, note_particolare, session);
		
	}

	public static ArrayList<RilAllegatiDTO> getlistaFileArchivio(int id_rilievo, Session session) {
 
		return GestioneRilieviDAO.getListaFileArchivio(id_rilievo, session);
	}

	public static RilSimboloDTO getSimboloFromDescrizione(String descrizione, Session session) {
		
		return GestioneRilieviDAO.getSimboloFromDescrizione(descrizione, session);
	}


	public static ArrayList<RilQuotaDTO> getQuoteImportate(int id_impronta, Session session) {
		
		return GestioneRilieviDAO.getQuoteImportate(id_impronta, session);
	}


	public static ArrayList<String> getListaClientiRilievi(Session session) throws Exception {

		return GestioneRilieviDAO.getListaClientiRilievi(session);
	}

	public static RilAllegatiDTO getAllegatoArchivioFromId(int id_rilievo, Session session) {
		
		return GestioneRilieviDAO.getAllegatoArchivioFromId(id_rilievo, session);
		
	}

	public static ArrayList<RilMisuraRilievoDTO> getListaRilieviSchedaConsegna(int id_cliente, int id_sede, String mese, String commessa, Session session) {
		
		return GestioneRilieviDAO.getListaRilieviSchedaConsegna(id_cliente, id_sede, mese, commessa, session);
	}

	public static int getQuotaRiferimento(int id_rilievo, Session session) {
	
		return GestioneRilieviDAO.getQuotaRiferimento(id_rilievo, session);
	}

	public static ArrayList<RilQuotaDTO> getQuoteFromImprontaAndRiferimento(int id_impronta, int riferimento, Session session) {
		
		return GestioneRilieviDAO.getQuoteFromImprontaAndRiferimento(id_impronta,riferimento,session);
	}

	public static int getNumeroPezziCPCPK(int id_particolare, Session session) {
		
		return GestioneRilieviDAO.getNumeroPezziCPCPK(id_particolare, session);
	}

	public static void updateQuotaCpCpk(RilQuotaDTO quota,int id_impronta,String riferimento, Session session) {
		
		GestioneRilieviDAO.updateQuotaCpCpk(quota,id_impronta,riferimento, session);
	}



}
