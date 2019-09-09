package it.portaleSTI.bo;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneVerComunicazioniDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.ComuneDTO;
import it.portaleSTI.DTO.ProvinciaDTO;
import it.portaleSTI.DTO.VerComunicazioneDTO;
import it.portaleSTI.DTO.VerInterventoStrumentiDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;

public class GestioneVerComunicazioniBO {
	
	
	public static File creaFileComunicazionePreventiva(ArrayList<VerInterventoStrumentiDTO> listaStrumentiPerIntervento,Session session) throws Exception
	{
		File f=null;
		try 
		{
			SimpleDateFormat sdf = new SimpleDateFormat("ddMMYYYYhhmmss");
			String nomeFile=sdf.format(new Date());
			f=new File(Costanti.PATH_FOLDER+"\\Comunicazioni\\"+nomeFile+".xml");
			
			FileOutputStream fos =new FileOutputStream(f);
			
			PrintStream ps = new PrintStream(fos);

			ps.println("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>");
			ps.println("<?xml-stylesheet type=\"text/xsl\" href=\"http://praticaeureka.infocamere.it/ptsm/res/xsl/it.ictechnology.ptsm.modelloDomanda_v1.0.xsl\" ?>");
			ps.println("<domanda xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"http://praticaeureka.infocamere.it/ptsm/res/xsd/it.ictechnology.ptsm.jaxb.modelloDomanda.xsd\">");
			ps.println("\t<softwareUtilizzato>");
			ps.println("\t\t<produttore>");
			ps.println("\t\t\t<denominazione>S.T.I. SVILUPPO TECNOLOGIE INDUSTRIALI S.R.L.</denominazione>");
			ps.println("\t\t</produttore>");
			ps.println("\t\t<prodotto>CALVER</prodotto>");
			ps.println("\t\t<versione>2.0.2</versione>");
			ps.println("\t</softwareUtilizzato>");
			ps.println("\t<dati>");
			ps.println("\t\t<tipoPratica>CPV</tipoPratica>");
			
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd+hh:mm");
			
			ps.println("\t\t<dataCompilazione>"+sdf1.format(new Date())+"</dataCompilazione>");
			ps.println("\t\t<idDomanda>-----------</idDomanda>");
			ps.println("\t</dati>");
			ps.println("\t<richiedente>");
			ps.println("\t\t<userId>TXHIT5</userId>");
			ps.println("\t\t<cciaa>FR</cciaa>");
			ps.println("\t\t<nRea>107255</nRea>");
			ps.println("\t\t<progUl>0</progUl>");
		    ps.println("\t\t<tipoSoggetto>LA</tipoSoggetto>");
			ps.println("\t\t<denominazione>MAMMONE GABRIELLA</denominazione>");
			ps.println("\t\t<nome>GABRIELLA</nome>");
			ps.println("\t\t<cognome>MAMMONE</cognome>");
			ps.println("\t\t<marchio>000000002</marchio>");
			ps.println("\t</richiedente>");
			ps.println("\t<dataRichiesta>"+sdf1.format(new Date())+"</dataRichiesta>");
			ps.println("\t<comunicazioni>");
			
			/*
			 *  Inserimento Strumenti;
			 */

			
			for (int i = 0; i <listaStrumentiPerIntervento.size(); i++) {
				
				VerInterventoStrumentiDTO info =listaStrumentiPerIntervento.get(i);
				
				VerStrumentoDTO strumento =info.getVerStrumento();
				
				ClienteDTO cliente=null;
				
				if(strumento.getId_sede()!=0) 
				{
				 cliente =GestioneAnagraficaRemotaBO.getClienteFromSede(""+strumento.getId_cliente(),""+ strumento.getId_sede());
				}
				else 
				{
			     cliente =GestioneAnagraficaRemotaBO.getClienteById(""+strumento.getId_cliente());
				}
				
				String codiceComune=getCodiceComune(cliente.getCitta());
				
				if(codiceComune.equals("0")) 
				{
					codiceComune="000";
				}
				ps.println("\t\t<comunicazione tipo=\"CPV\">");
				ps.println("\t\t\t<soggettoMetrico>");
				ps.println("\t\t\t\t<tipoSoggettoMetrico>UM</tipoSoggettoMetrico>");
				ps.println("\t\t\t\t<provinciaCdC>"+cliente.getProvincia()+"</provinciaCdC>");
				if(!cliente.getNumeroREA().equals("")) 
				{
					ps.println("\t\t\t\t<numeroRea>"+cliente.getNumeroREA()+"</numeroRea>");
				}
				ps.println("\t\t\t\t<codiceFiscale>"+cliente.getPartita_iva()+"</codiceFiscale>");
				ps.println("\t\t\t\t<denominazione>"+getStringForXML(cliente.getNome())+"</denominazione>");
				ps.println("\t\t\t\t<via>"+getStringForXML(cliente.getIndirizzo())+"</via>");
				ps.println("\t\t\t\t<cap>"+Utility.LeftPaddingZero(""+cliente.getCap(),5)+"</cap>");
				ps.println("\t\t\t\t<codiceComune>"+codiceComune+"</codiceComune>");
				ps.println("\t\t\t\t<sglProvincia>"+cliente.getProvincia()+"</sglProvincia>");
                ps.println("\t\t\t</soggettoMetrico>");
				
				
				ps.println("\t\t\t<strumento>");
			    ps.println("\t\t\t\t<tipo>"+strumento.getFamiglia_strumento().getId()+"</tipo>");
				
				ps.println("\t\t\t\t<matricola>"+strumento.getMatricola()+"</matricola>");
				ps.println("\t\t\t\t<marca>"+strumento.getCostruttore()+"</marca>");
				ps.println("\t\t\t\t<modello>"+strumento.getModello()+"</modello>");
				ps.println("\t\t\t\t<annoMarcaturaCe>"+strumento.getAnno_marcatura_ce()+"</annoMarcaturaCe>");
				ps.println("\t\t\t\t<dataInizioUtilizzo>"+sdf1.format(strumento.getData_messa_in_servizio())+"</dataInizioUtilizzo>");
				ps.println("\t\t\t\t<via>"+getStringForXML(cliente.getIndirizzo())+"</via>");
			//	ps.println("\t\t\t\t<numeroCivico>/</numeroCivico>");
				ps.println("\t\t\t\t<cap>"+Utility.LeftPaddingZero(cliente.getCap(),5)+"</cap>");
				ps.println("\t\t\t\t<codiceComune>"+codiceComune+"</codiceComune>");
				ps.println("\t\t\t\t<sglProvincia>"+cliente.getProvincia()+"</sglProvincia>");
                ps.println("\t\t\t</strumento>");
                
                
                ps.println("\t\t\t<verifica>");
                ps.println("\t\t\t\t<tipoVerifica>P</tipoVerifica>");
                if(info.getIn_sede_cliente()==2) 
                {
                	ps.println("\t\t\t\t<tipoVia>VIA</tipoVia>");
                	ps.println("\t\t\t\t<via>"+getStringForXML(info.getVia())+"</via>");
                	ps.println("\t\t\t\t<numeroCivico>"+info.getCivico()+"</numeroCivico>");
                	ComuneDTO comune =info.getComune();
                	ps.println("\t\t\t\t<cap>"+Utility.LeftPaddingZero(""+comune.getCap(),5)+"</cap>");
                	ps.println("\t\t\t\t<codiceComune>"+Utility.LeftPaddingZero(""+comune.getCodice(),3)+"</codiceComune>");
                	ps.println("\t\t\t\t<sglProvincia>"+comune.getProvincia()+"</sglProvincia>");
                }
                ps.println("\t\t\t</verifica>");
                ps.println("\t\t\t<richiesta>");
                
                SimpleDateFormat simpleDF=new SimpleDateFormat("dd/MM/yyyy");
               
                ps.println("\t\t\t\t<data>"+sdf1.format(new Date())+"</data>");
                ps.println("\t\t\t\t<dataPrevista>"+sdf1.format(info.getData_prevista())+"</dataPrevista>");
               	ps.println("\t\t\t\t<oraPrevista>"+info.getOra_prevista()+"</oraPrevista>");
                ps.println("\t\t\t</richiesta>");
            
            
                
                ps.println("\t\t</comunicazione>");
			}
			
			
			ps.println("\t</comunicazioni>");
			ps.println("</domanda>");
			ps.close();
			fos.close();
			
			System.out.println("FINE");
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return f;
	}

	public static File creaFileComunicazioneVerifica(ArrayList<VerMisuraDTO> misure,Session session) 
	{
		File f=null;
		try 
		{
			SimpleDateFormat sdf = new SimpleDateFormat("ddMMYYYYhhmmss");
			String nomeFile=sdf.format(new Date());
			f=new File(Costanti.PATH_FOLDER+"\\Comunicazioni\\"+nomeFile+".xml");
			
			FileOutputStream fos =new FileOutputStream(f);
			
			PrintStream ps = new PrintStream(fos);
						
			ps.println("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>");
			ps.println("<?xml-stylesheet type=\"text/xsl\" href=\"http://praticaeureka.infocamere.it/ptsm/res/xsl/it.ictechnology.ptsm.modelloDomanda_v1.0.xsl\" ?>");
			ps.println("<domanda xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"http://praticaeureka.infocamere.it/ptsm/res/xsd/it.ictechnology.ptsm.jaxb.modelloDomanda.xsd\">");
			ps.println("\t<softwareUtilizzato>");
			ps.println("\t\t<produttore>");
			ps.println("\t\t\t<denominazione>S.T.I. SVILUPPO TECNOLOGIE INDUSTRIALI S.R.L.</denominazione>");
			ps.println("\t\t</produttore>");
			ps.println("\t\t<prodotto>CALVER</prodotto>");
			ps.println("\t\t<versione>2.0.2</versione>");
			ps.println("\t</softwareUtilizzato>");
			ps.println("\t<dati>");
			ps.println("\t\t<tipoPratica>CEV</tipoPratica>");
			
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd+hh:mm");
			
			ps.println("\t\t<dataCompilazione>"+sdf1.format(new Date())+"</dataCompilazione>");
			ps.println("\t\t<idDomanda>-----------</idDomanda>");
			ps.println("\t</dati>");
			ps.println("\t<richiedente>");
			ps.println("\t\t<userId>TXHIT5</userId>");
			ps.println("\t\t<cciaa>FR</cciaa>");
			ps.println("\t\t<nRea>107255</nRea>");
			ps.println("\t\t<progUl>0</progUl>");
		    ps.println("\t\t<tipoSoggetto>LA</tipoSoggetto>");
			ps.println("\t\t<denominazione>MAMMONE GABRIELLA</denominazione>");
			ps.println("\t\t<nome>GABRIELLA</nome>");
			ps.println("\t\t<cognome>MAMMONE</cognome>");
			ps.println("\t\t<marchio>000000002</marchio>");
			ps.println("\t</richiedente>");
			ps.println("\t<dataRichiesta>"+sdf1.format(new Date())+"</dataRichiesta>");
			ps.println("\t<comunicazioni>");
			
			/*
			 *  Inserimento Strumenti;
			 */
			
			
			for (int i = 0; i <misure.size(); i++) {	
				
				VerMisuraDTO misura=misure.get(i);
				
				VerStrumentoDTO strumento =misura.getVerStrumento();
				
				ClienteDTO cliente=null;
				
				if(strumento.getId_sede()!=0) 
				{
				 cliente =GestioneAnagraficaRemotaBO.getClienteFromSede(""+strumento.getId_cliente(),""+ strumento.getId_sede());
				}
				else 
				{
			     cliente =GestioneAnagraficaRemotaBO.getClienteById(""+strumento.getId_cliente());
				}
				
				String codiceComune=getCodiceComune(cliente.getCitta());
				
				if(codiceComune.equals("0")) 
				{
					codiceComune="000";
				}
				
				ps.println("\t\t<esito tipo=\"CEV\">");
				ps.println("\t\t\t<soggettoMetrico>");
				ps.println("\t\t\t\t<tipoSoggettoMetrico>UM</tipoSoggettoMetrico>");
				ps.println("\t\t\t\t<provinciaCdC>"+cliente.getProvincia()+"</provinciaCdC>");
				ps.println("\t\t\t\t<numeroRea>"+cliente.getNumeroREA()+"</numeroRea>");
				ps.println("\t\t\t\t<codiceFiscale>"+cliente.getPartita_iva()+"</codiceFiscale>");
				ps.println("\t\t\t\t<denominazione>"+cliente.getNome()+"</denominazione>");
				ps.println("\t\t\t\t<via>"+getStringForXML(cliente.getIndirizzo())+"</via>");
		//		ps.println("\t\t\t\t<numeroCivico>/</numeroCivico>");
				ps.println("\t\t\t\t<cap>"+Utility.LeftPaddingZero(cliente.getCap(),5)+"</cap>");
				ps.println("\t\t\t\t<codiceComune>"+codiceComune+"</codiceComune>");
				ps.println("\t\t\t\t<sglProvincia>"+cliente.getProvincia()+"</sglProvincia>");
                ps.println("\t\t\t</soggettoMetrico>");
				
				
				ps.println("\t\t\t<strumento>");
				ps.println("\t\t\t\t<tipo>"+strumento.getFamiglia_strumento().getId()+"</tipo>");
				
				ps.println("\t\t\t\t<matricola>"+strumento.getMatricola()+"</matricola>");
				ps.println("\t\t\t\t<marca>"+strumento.getCostruttore()+"</marca>");
				ps.println("\t\t\t\t<modello>"+strumento.getModello()+"</modello>");
				ps.println("\t\t\t\t<annoMarcaturaCe>"+strumento.getAnno_marcatura_ce()+"</annoMarcaturaCe>");
				
				ps.println("\t\t\t\t<dataInizioUtilizzo>"+sdf1.format(strumento.getData_messa_in_servizio())+"</dataInizioUtilizzo>");
				ps.println("\t\t\t\t<via>"+getStringForXML(cliente.getIndirizzo())+"</via>");
			//	ps.println("\t\t\t\t<numeroCivico>/</numeroCivico>");
				ps.println("\t\t\t\t<cap>"+Utility.LeftPaddingZero(""+cliente.getCap(),5)+"</cap>");
				ps.println("\t\t\t\t<codiceComune>"+codiceComune+"</codiceComune>");
				ps.println("\t\t\t\t<sglProvincia>"+cliente.getProvincia()+"</sglProvincia>");
                ps.println("\t\t\t</strumento>");
                
                
                ps.println("\t\t\t<verifica>");
                ps.println("\t\t\t\t<tipoVerifica>P</tipoVerifica>");
                if(misura.getComunicazione_preventiva().equals("V"))
                {
                	ps.println("\t\t\t\t<effettuataComunicazionePreventiva>NO</effettuataComunicazionePreventiva>");
                }else 
                {
                	ps.println("\t\t\t\t<effettuataComunicazionePreventiva>SI</effettuataComunicazionePreventiva>");
                }
                
                if(GestioneVerMisuraBO.getEsito(misura)==0) 
                {
                	ps.println("\t\t\t\t<esito>POSITIVO</esito>");	
                }
                else 
                {
                	ps.println("\t\t\t\t<esito>NEGATIVO</esito>");	
                }
                ps.println("\t\t\t\t<data>"+sdf1.format(misura.getDataVerificazione())+"</data>");
                ps.println("\t\t\t\t<nomiVerificatoriRiparatori>"+misura.getTecnicoVerificatore().getNominativo()+"</nomiVerificatoriRiparatori>");
                ps.println("\t\t\t\t<tipoVia>VIA</tipoVia>");
            	ps.println("\t\t\t\t<via>"+getStringForXML(cliente.getIndirizzo())+"</via>");
			//	ps.println("\t\t\t\t<numeroCivico>/</numeroCivico>");
				ps.println("\t\t\t\t<cap>"+Utility.LeftPaddingZero(""+cliente.getCap(),5)+"</cap>");
				ps.println("\t\t\t\t<codiceComune>"+codiceComune+"</codiceComune>");
				ps.println("\t\t\t\t<sglProvincia>"+cliente.getProvincia()+"</sglProvincia>");
                ps.println("\t\t\t</verifica>");
                ps.println("\t\t\t<richiesta/>");

                ps.println("\t\t</esito>");
                
                misura.setComunicazione_esito("S");
                session.update(misura);
			}
			
			
			ps.println("\t</comunicazioni>");
			ps.println("</domanda>");
			ps.close();
			fos.close();
			
			System.out.println("FINE");
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return f;
	}
	
	private static String getCodiceComune(String citta) throws Exception {
		return GestioneAnagraficaRemotaBO.getCodiceComune(citta);
	
	}

	public static String getStringForXML(String string)
	{
		String toRet="";
		
		for (int i=0;i<string.length();i++) 
		{
			
			if(String.valueOf(string.charAt(i)).matches("[a-zA-Z0-9]+")) 
			{
				toRet=toRet.concat(String.valueOf(string.charAt(i)));
			}
			else 
			{
				toRet=toRet.concat(" ");
			}
		}
		
		
		return toRet;
	} 


	public static ArrayList<VerComunicazioneDTO> getListaComunicazioni(Session session) {
		
		return GestioneVerComunicazioniDAO.getListaComunicazioni(session);
	}

	public static ArrayList<ProvinciaDTO> getListaProvince(Session session) {
		
		return GestioneVerComunicazioniDAO.getListaProvince(session);
	}
}
