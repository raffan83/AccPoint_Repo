package it.portaleSTI.bo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.io.StringWriter;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.hibernate.Session;

import com.lowagie.text.Document;

import it.portaleSTI.DAO.GestioneVerComunicazioniDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.VerComunicazioneDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.Util.Costanti;

public class GestioneVerComunicazioniBO {
	
	
	public static File creaFileComunicazionePreventiva(String source,Session session) 
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
			String[] ids=source.split(";");
			
			for (int i = 0; i <ids.length; i++) {
				
				String[] data=ids[i].split("_");
				
				VerStrumentoDTO strumento =GestioneVerStrumentiBO.getVerStrumentoFromId(Integer.parseInt(data[0]), session);
				
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
				
				ps.println("\t\t<comunicazione tipo=\"CPV\">");
				ps.println("\t\t\t<soggettoMetrico>");
				ps.println("\t\t\t\t<tipoSoggettoMetrico>UM</tipoSoggettoMetrico>");
				ps.println("\t\t\t\t<provinciaCdC>"+cliente.getProvincia()+"</provinciaCdC>");
				ps.println("\t\t\t\t<numeroRea>"+cliente.getNumeroREA()+"</numeroRea>");
				ps.println("\t\t\t\t<codiceFiscale>"+cliente.getPartita_iva()+"</codiceFiscale>");
				ps.println("\t\t\t\t<denominazione>"+getStringForXML(cliente.getNome())+"</denominazione>");
				ps.println("\t\t\t\t<via>"+getStringForXML(cliente.getIndirizzo())+"</via>");
				ps.println("\t\t\t\t<cap>"+cliente.getCap()+"</cap>");
				ps.println("\t\t\t\t<codiceComune>"+codiceComune+"</codiceComune>");
				ps.println("\t\t\t\t<sglProvincia>"+cliente.getProvincia()+"</sglProvincia>");
                ps.println("\t\t\t</soggettoMetrico>");
				
				
				ps.println("\t\t\t<strumento>");
				
				if(strumento.getTipologia().getId()==1) 
				{
					ps.println("\t\t\t\t<tipo>0222</tipo>");
				}
				else 
				{
					ps.println("\t\t\t\t<tipo>0221</tipo>");
				}
				ps.println("\t\t\t\t<matricola>"+strumento.getMatricola()+"</matricola>");
				ps.println("\t\t\t\t<marca>"+strumento.getCostruttore()+"</marca>");
				ps.println("\t\t\t\t<modello>"+strumento.getModello()+"</modello>");
				ps.println("\t\t\t\t<annoMarcaturaCe>"+strumento.getAnno_marcatura_ce()+"</annoMarcaturaCe>");
				ps.println("\t\t\t\t<dataInizioUtilizzo>"+sdf1.format(strumento.getData_messa_in_servizio())+"</dataInizioUtilizzo>");
				ps.println("\t\t\t\t<via>"+getStringForXML(cliente.getIndirizzo())+"</via>");
				ps.println("\t\t\t\t<numeroCivico>/</numeroCivico>");
				ps.println("\t\t\t\t<cap>"+cliente.getCap()+"</cap>");
				ps.println("\t\t\t\t<codiceComune>"+codiceComune+"</codiceComune>");
				ps.println("\t\t\t\t<sglProvincia>"+cliente.getProvincia()+"</sglProvincia>");
                ps.println("\t\t\t</strumento>");
                
                
                ps.println("\t\t\t<verifica>");
                ps.println("\t\t\t\t<tipoVerifica>P</tipoVerifica>");
                ps.println("\t\t\t</verifica>");
                ps.println("\t\t\t<richiesta>");
                
                SimpleDateFormat simpleDF=new SimpleDateFormat("dd/MM/yyyy");
                Date d =simpleDF.parse(data[1]);
                ps.println("\t\t\t\t<data>"+sdf1.format(new Date())+"</data>");
                ps.println("\t\t\t\t<dataPrevista>"+sdf1.format(d)+"</dataPrevista>");
               	ps.println("\t\t\t\t<oraPrevista>"+data[2]+"</oraPrevista>");
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
				
				/*Codice non trovato*/
				if(codiceComune.equals("0")) 
				{
					return null;
				}
				
				ps.println("\t\t<esito tipo=\"CEV\">");
				ps.println("\t\t\t<soggettoMetrico>");
				ps.println("\t\t\t\t<tipoSoggettoMetrico>UM</tipoSoggettoMetrico>");
				ps.println("\t\t\t\t<provinciaCdC>"+cliente.getProvincia()+"</provinciaCdC>");
				ps.println("\t\t\t\t<numeroRea>"+cliente.getNumeroREA()+"</numeroRea>");
				ps.println("\t\t\t\t<codiceFiscale>"+cliente.getPartita_iva()+"</codiceFiscale>");
				ps.println("\t\t\t\t<denominazione>"+cliente.getNome()+"</denominazione>");
				ps.println("\t\t\t\t<via>"+cliente.getIndirizzo()+"</via>");
				ps.println("\t\t\t\t<numeroCivico>/</numeroCivico>");
				ps.println("\t\t\t\t<cap>"+cliente.getCap()+"</cap>");
				ps.println("\t\t\t\t<codiceComune>"+codiceComune+"</codiceComune>");
				ps.println("\t\t\t\t<sglProvincia>"+cliente.getProvincia()+"</sglProvincia>");
                ps.println("\t\t\t</soggettoMetrico>");
				
				
				ps.println("\t\t\t<strumento>");
				
				if(strumento.getTipologia().getId()==1) 
				{
					ps.println("\t\t\t\t<tipo>0222</tipo>");
				}
				else 
				{
					ps.println("\t\t\t\t<tipo>0221</tipo>");
				}
				ps.println("\t\t\t\t<matricola>"+strumento.getMatricola()+"</matricola>");
				ps.println("\t\t\t\t<marca>"+strumento.getCostruttore()+"</marca>");
				ps.println("\t\t\t\t<modello>"+strumento.getModello()+"</modello>");
				ps.println("\t\t\t\t<annoMarcaturaCe>"+strumento.getAnno_marcatura_ce()+"</annoMarcaturaCe>");
				
				ps.println("\t\t\t\t<dataInizioUtilizzo>"+sdf1.format(strumento.getData_messa_in_servizio())+"</dataInizioUtilizzo>");
				ps.println("\t\t\t\t<via>"+cliente.getIndirizzo()+"</via>");
				ps.println("\t\t\t\t<numeroCivico>/</numeroCivico>");
				ps.println("\t\t\t\t<cap>"+cliente.getCap()+"</cap>");
				ps.println("\t\t\t\t<codiceComune>"+codiceComune+"</codiceComune>");
				ps.println("\t\t\t\t<sglProvincia>"+cliente.getProvincia()+"</sglProvincia>");
                ps.println("\t\t\t</strumento>");
                
                
                ps.println("\t\t\t<verifica>");
                ps.println("\t\t\t\t<tipoVerifica>P</tipoVerifica>");
                ps.println("\t\t\t\t<effettuataComunicazionePreventiva>NO</effettuataComunicazionePreventiva>");
                ps.println("\t\t\t\t<esito>POSITIVO</esito>");
                ps.println("\t\t\t\t<data>"+sdf1.format(misure.get(i).getDataVerificazione())+"</data>");
                ps.println("\t\t\t\t<nomiVerificatoriRiparatori>"+misura.getTecnicoVerificatore().getNominativo()+"</nomiVerificatoriRiparatori>");
                ps.println("\t\t\t\t<tipoVia>VIA</tipoVia>");
            	ps.println("\t\t\t\t<via>"+cliente.getIndirizzo()+"</via>");
				ps.println("\t\t\t\t<numeroCivico>/</numeroCivico>");
				ps.println("\t\t\t\t<cap>"+cliente.getCap()+"</cap>");
				ps.println("\t\t\t\t<codiceComune>"+codiceComune+"</codiceComune>");
				ps.println("\t\t\t\t<sglProvincia>"+cliente.getProvincia()+"</sglProvincia>");
                ps.println("\t\t\t</verifica>");
                ps.println("\t\t\t<richiesta>");

                ps.println("\t\t</esito>");
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
}
