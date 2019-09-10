package it.portaleSTI.bo;

import java.util.ArrayList;
import java.util.Arrays;

import org.hibernate.Session;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneVerCertificatoDAO;
import it.portaleSTI.DAO.GestioneVerMisuraDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.VerAccuratezzaDTO;
import it.portaleSTI.DTO.VerCertificatoDTO;
import it.portaleSTI.DTO.VerCodiceDocumentoDTO;
import it.portaleSTI.DTO.VerDecentramentoDTO;
import it.portaleSTI.DTO.VerLinearitaDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerMobilitaDTO;
import it.portaleSTI.DTO.VerRipetibilitaDTO;
import it.portaleSTI.Util.Utility;

public class GestioneVerMisuraBO {

	public static VerMisuraDTO getMisuraFromId(int id_misura, Session session) {
		
		return GestioneVerMisuraDAO.getMisuraFromId(id_misura, session);
	}

	public static ArrayList<VerRipetibilitaDTO> getListaRipetibilita(int id_misura, Session session) {
		
		return GestioneVerMisuraDAO.getListaRipetibilita(id_misura, session);
	}

	public static ArrayList<VerDecentramentoDTO> getListaDecentramento(int id_misura, Session session) {
		
		return GestioneVerMisuraDAO.getListaDecentramento(id_misura, session);
	}

	public static ArrayList<VerLinearitaDTO> getListaLinearita(int id_misura, Session session) {
		
		return GestioneVerMisuraDAO.getListaLinearita(id_misura, session);
	}

	public static ArrayList<VerAccuratezzaDTO> getListaAccuratezza(int id_misura, Session session) {

		return GestioneVerMisuraDAO.getListaAccuratezza(id_misura, session);
	}

	public static ArrayList<VerMobilitaDTO> getListaMobilita(int id_misura, Session session) {
		
		return GestioneVerMisuraDAO.getListaMobilita(id_misura, session);
	}

	public static ArrayList<VerMisuraDTO> getListaMisureFromDateAndProv(String dateFrom, String dateTo,String provincia,Session session) throws Exception {
		
		ArrayList<VerMisuraDTO> listaMisure = new ArrayList<VerMisuraDTO>();
		
		ArrayList<String> listaMisureFromDate =DirectMySqlDAO.getListaVerMisureFromDate(dateFrom,dateTo);
		
		for (String sequence : listaMisureFromDate) {
			
			String[] data=sequence.split(";");
			
			ClienteDTO cliente = null;
			
			if(data[2].equals("0")) 
			{
				cliente=GestioneAnagraficaRemotaBO.getClienteById(data[1]);
			}else 
			{
				cliente=GestioneAnagraficaRemotaBO.getClienteFromSede(data[1],data[2]);
			}
			
			if(cliente.getProvincia().equals(provincia)) 
			{
				VerMisuraDTO misura =GestioneVerMisuraBO.getMisuraFromId(Integer.parseInt(data[0]),session);
				
				VerCertificatoDTO certificato = GestioneVerCertificatoDAO.getCertificatoByMisura(misura);
				
				if(certificato.getStato().getId()==2) 
				{
					listaMisure.add(misura);
				}
			}
		}

		return listaMisure;
	}

	public static ArrayList<VerMisuraDTO> getListaMisure(Session session) {
		
		return GestioneVerMisuraDAO.getListaMisure(session);
	}

	public static int getEsito(VerMisuraDTO misura) {
		
		//boolean esito_globale = true;
		int motivo = 0;
		if(misura.getIs_difetti().equals("S")) {
			//esito_globale = false;
			motivo = 3;
		}else {
			if(misura.getSeqRisposte()!=null) {				
				if(new ArrayList<String>(Arrays.asList(misura.getSeqRisposte().split(";"))).contains("1")) {
					//esito_globale = false;
					motivo = 2;
					return motivo;
				}
			}
			
			if(misura.getListaPuntiRipetibilita()!=null && misura.getListaPuntiRipetibilita().size()>0) {
				for (VerRipetibilitaDTO item : misura.getListaPuntiRipetibilita()) {
					if(item.getEsito().equals("NEGATIVO")) {
						//esito_globale = false;
						motivo = 1;
					}
				}					
			}
			if(misura.getListaPuntiLinearita()!=null && misura.getListaPuntiLinearita().size()>0) {
				for (VerLinearitaDTO item : misura.getListaPuntiLinearita()) {
					if(item.getEsito().equals("NEGATIVO")) {
						//esito_globale = false;
						motivo = 1;
					}
				}					
			}
			if(misura.getListaPuntiDecentramento()!=null && misura.getListaPuntiDecentramento().size()>0) {
				for (VerDecentramentoDTO item : misura.getListaPuntiDecentramento()) {
					if(item.getEsito().equals("NEGATIVO")) {
						//esito_globale = false;
						motivo = 1;
					}
				}					
			}
			if(misura.getVerStrumento().getTipologia().getId()==2) {
				if(misura.getListaPuntiAccuratezza()!=null && misura.getListaPuntiAccuratezza().size()>0) {
					for (VerAccuratezzaDTO item : misura.getListaPuntiAccuratezza()) {
						if(item.getEsito().equals("NEGATIVO")) {
							//esito_globale = false;
							motivo = 1;
						}
					}					
				}	
			}				
			if(misura.getVerStrumento().getTipologia().getId()==2) {
				if(misura.getListaPuntiMobilita()!=null && misura.getListaPuntiMobilita().size()>0) {
					for (VerMobilitaDTO item : misura.getListaPuntiMobilita()) {
						if(item.getEsito()!=null && item.getEsito().equals("NEGATIVO")) {
							//esito_globale = false;
							motivo = 1;
						}
					}					
				}	
			}			
		}		
		
		return motivo;
	}

	public static String getCodiceAttestatoRapporto(VerMisuraDTO misura,Session session) {
		
		String codice_attestato = "";
		String codice_rapporto = "";
		VerCodiceDocumentoDTO codice = GestioneVerMisuraDAO.getCodiceDocumento(misura.getTecnicoVerificatore().getId(), misura.getVerStrumento().getFamiglia_strumento().getId(), session);
		String anno = Utility.getYearFromDate(misura.getDataVerificazione(), 2);
		if(codice==null) 
		{
			codice = new VerCodiceDocumentoDTO(misura.getTecnicoVerificatore(), misura.getVerStrumento().getFamiglia_strumento(), 1);
			session.save(codice);
			codice_attestato = codice.getUser().getCodiceTecnicoVerificazione() + "_AVP_"+codice.getFamiglia().getCodice()+"_0001/"+anno;
			codice_rapporto = codice.getUser().getCodiceTecnicoVerificazione() + "_RVP_"+codice.getFamiglia().getCodice()+"_0001/"+anno;
		}else {
			int progressivo = +codice.getCount()+1;			
			codice_attestato = codice.getUser().getCodiceTecnicoVerificazione() + "_AVP_"+codice.getFamiglia().getCodice()+"_"+Utility.LeftPaddingZero(""+progressivo, 4)+"/"+anno;
			codice_rapporto = codice.getUser().getCodiceTecnicoVerificazione() + "_RVP_"+codice.getFamiglia().getCodice()+"_"+Utility.LeftPaddingZero(""+progressivo, 4)+"/"+anno;
			codice.setCount(progressivo);
			session.update(codice);
		}
		
		misura.setNumeroAttestato(codice_attestato);
		misura.setNumeroRapporto(codice_rapporto);
		session.update(misura);
		
		return codice_attestato;
	}


}
