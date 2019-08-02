package it.portaleSTI.bo;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.action.ContextListener;

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
			
			ps.println("<XML>");
			
			
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
                ps.println("\t\t\t</verifica>");
                ps.println("\t\t\t<richiesta>");
                ps.println("\t\t\t\t<dataPrevista>"+data[1]+"+00:00</dataPrevista>");
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

	
	private static String getCodiceComune(String citta) throws Exception {
		return GestioneAnagraficaRemotaBO.getCodiceComune(citta);
	
	}


	public static void main(String[] args) throws HibernateException, Exception {
		new ContextListener().configCostantApplication();
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();

		

		creaFileComunicazionePreventiva("509",session);

		
		
	}
}
