package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.SequenceDTO;
import it.portaleSTI.DTO.TipoCampioneDTO;
import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCampioneBO;
import it.portaleSTI.bo.GestioneCompanyBO;


/**
 * Servlet implementation class DettaglioCampione
 */
@WebServlet(name="gestioneCampione" , urlPatterns = { "/gestioneCampione.do" })
@MultipartConfig
public class GestioneCampione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneCampione() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		if(Utility.validateSession(request,response,getServletContext()))return;

	 try{	
		 String action=  request.getParameter("action");
			if(action.equals("exportLista"))
			{
				CompanyDTO company = (CompanyDTO) request.getSession().getAttribute("usrCompany");
				ArrayList<String> listaCampioni = GestioneCampioneBO.getListaCampioniString(company);
				File file = new File(Costanti.PATH_FOLDER+"/listaCampioni.csv");
				FileWriter writer = new FileWriter(file); 
				for (String string : listaCampioni) {
					writer.write(string);
					writer.write(System.getProperty( "line.separator" ));
				}
				writer.close();

				 FileInputStream fileIn = new FileInputStream(file);
				 response.setContentType("application/octet-stream");
				  
				 response.setHeader("Content-Disposition","attachment;filename=listaCampioni.csv");
				 
				 ServletOutputStream outp = response.getOutputStream();
				 byte[] outputByte = new byte[1];
//				    copy binary contect to output stream
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				     }
				    
				    
				    fileIn.close();
				    outp.flush();
				    outp.close();
			}
		}catch(Exception ex)
		{

			ex.printStackTrace();
		     request.setAttribute("error",STIException.callException(ex));
		     request.getSession().setAttribute("exception", ex);
			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
			 dispatcher.forward(request,response);
		}  

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		PrintWriter out = response.getWriter();
		JsonObject myObj = new JsonObject();
   
        response.setContentType("application/json");
        
        try{	
	
     List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
	
	 String action=  request.getParameter("action");

		if(action !=null )
		{
			
			if(action.equals("controllaCodice"))
			{
				String codice=  request.getParameter("codice");
				
				CampioneDTO campioneControllo=GestioneCampioneBO.controllaCodice(codice);
				
				if(campioneControllo!=null)
				{
					myObj.addProperty("success", false);
				}
				else
				{
					myObj.addProperty("success", true);
				}
			}
			
			else if(action.equals("nuovo")) {
				
				CampioneDTO campione = new CampioneDTO();
				
								
				FileItem fileItem = null;
				
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	
	            	 }
	            	
	            
	            }
			        
			  String nome = (String) ret.get("nome");
	
			  String descrizione = (String) ret.get("descrizione");
			  String costruttore = (String) ret.get("costruttore");
			  String modello = (String) ret.get("modello");
			  String interpolazione = (String) ret.get("interpolazione");
			  String freqTaratura = (String) ret.get("freqTaratura");
			  String statoCampione = (String) ret.get("statoCampione");
			  String dataVerifica = (String) ret.get("dataVerifica");
			  String numeroCerificato  = (String) ret.get("numeroCerificato");
			  String interpolato  = (String) ret.get("interpolato");			  
			 
			  String tipoVerifica = (String) ret.get("tipoVerifica");
			  String tipoCampione = (String) ret.get("tipoCampione");
			  String codice  = (String) ret.get("codice");
			  String matricola = (String) ret.get("matricola");
			  String dataScadenza = (String) ret.get("dataScadenza");
			  String utilizzatore = (String) ret.get("utilizzatore"); 
			  String dataInizio  = (String) ret.get("dataInizio");
			  String dataFine  = (String) ret.get("dataFine"); 
			  
			  String distributore = (String) ret.get("distributore");
			  String data_acquisto = (String) ret.get("data_acquisto");
			  String campo_accettabilita = (String)ret.get("campo_accettabilita");
			  String ente_certificatore = (String)ret.get("ente_certificatore");
			  
			  String data_messa_in_servizio = (String) ret.get("data_messa_in_servizio");
			  String campo_misura = (String)ret.get("campo_misura");
			  String unita_formato = (String)ret.get("unita_formato");
			  String frequenza_manutenzione = (String)ret.get("frequenza_manutenzione");
			  String frequenza_verifica_intermedia = (String)ret.get("frequenza_verifica_intermedia");
			  String note_attivita_taratura = (String)ret.get("note_attivita_taratura");
			  String ubicazione = (String)ret.get("ubicazione");
			  String id_strumento = (String)ret.get("strumento");
			  String descrizione_manutenzione = (String)ret.get("descrizione_manutenzione");
			  String descrizione_verifica_intermedia = (String)ret.get("descrizione_verifica_intermedia");
			  String settore = (String)ret.get("settore");
			  String slash = (String)ret.get("slash");
			  String proprietario = (String)ret.get("proprietario");
			  String campione_verificazione = (String) ret.get("campione_verificazione");
			  String clona_valori_campione = (String) ret.get("clona_valori_campione");
			  
			  if(clona_valori_campione!=null && !clona_valori_campione.equals("") && !clona_valori_campione.equals("0")) {
				  clona_valori_campione = "Ajax";
			  }else {
				  clona_valori_campione  ="";
			  }
			  
			  String attivita_di_taratura ="";
			  
				 attivita_di_taratura = (String) ret.get("attivita_di_taratura_text");
			 
			 
				campione.setNome(nome);
				campione.setMatricola(matricola);
	 			campione.setDescrizione(descrizione);
				campione.setCostruttore(costruttore);
				campione.setModello(modello);
				if(interpolazione!=null && !interpolazione.equals("")) {
					campione.setInterpolazionePermessa(Integer.parseInt(interpolazione));	
				}
				
				if(freqTaratura!=null && !freqTaratura.equals("")) {
					campione.setFreqTaraturaMesi(Integer.parseInt(freqTaratura));	
				}
				
				campione.setStatoCampione(statoCampione);
				campione.setSettore(Integer.parseInt(settore));
		 
				campione.setAttivita_di_taratura(attivita_di_taratura);
				campione.setCampo_accettabilita(campo_accettabilita);
				campione.setDistributore(distributore);
				
				campione.setCampo_misura(campo_misura);
				campione.setUnita_formato(unita_formato);
				
				if(id_strumento!=null && !id_strumento.equals("")) {
					campione.setId_strumento(Integer.parseInt(id_strumento));
				}
				if(frequenza_manutenzione!=null && !frequenza_manutenzione.equals("")) {
					campione.setFrequenza_manutenzione(Integer.parseInt(frequenza_manutenzione));	
				}
				
				if(frequenza_verifica_intermedia!=null && !frequenza_verifica_intermedia.equals("")) {
					campione.setFrequenza_verifica_intermedia(Integer.parseInt(frequenza_verifica_intermedia));
				}
				campione.setNote_attivita(note_attivita_taratura);
				campione.setUbicazione(ubicazione);
				
				campione.setDescrizione_manutenzione(descrizione_manutenzione);
				campione.setDescrizione_verifica_intermedia(descrizione_verifica_intermedia);
				
				DateFormat format = new SimpleDateFormat("dd/MM/yyyy", Locale.ITALIAN);
				
				if(data_acquisto !=null && !data_acquisto.equals("")) {
				Date dataAcquisto = (Date) format.parse(data_acquisto);
				campione.setData_acquisto(dataAcquisto);
				}else {
					campione.setData_acquisto(null);
				}
				
				if(campione_verificazione==null) {
					campione_verificazione = "0";
				}
				
				campione.setCampione_verificazione(Integer.parseInt(campione_verificazione));
				
				if(data_messa_in_servizio !=null && !data_messa_in_servizio.equals("")) {
					Date d = (Date) format.parse(data_messa_in_servizio);
					campione.setData_messa_in_servizio(d);
					}else {
						campione.setData_messa_in_servizio(null);
					}
				
				if(dataVerifica !=null && !dataVerifica.equals("")) {
					Date dataVerificaDate = (Date) format.parse(dataVerifica);
		 			campione.setDataVerifica(dataVerificaDate);
		 			Date dataScadenzaCampione=null;
		 			
		 			Calendar cal = Calendar.getInstance();
		 			cal.setTime(dataVerificaDate);
		 			cal.add(Calendar.MONTH, Integer.parseInt(freqTaratura));
		
		 			dataScadenzaCampione=cal.getTime();
		 			
		 			campione.setDataScadenza(dataScadenzaCampione);
				}
				
				campione.setNumeroCertificato(numeroCerificato);
	
				ArrayList<ValoreCampioneDTO> listaValoriNew = new ArrayList<ValoreCampioneDTO>();
	
			
					campione.setUtilizzatore(utilizzatore);
					campione.setTipo_campione(new TipoCampioneDTO(Integer.parseInt(tipoCampione),""));
					if(slash!=null && !slash.equals("")) {
						campione.setCodice(codice+"/"+slash);						
					}else {
						campione.setCodice(codice);	
						
						if(codice.startsWith("STI")||codice.startsWith("CDT")) {
							SequenceDTO seq = GestioneCampioneBO.getSequence(session);
							if(settore!=null && settore.equals("0")) {
								seq.setSeq_sti_campione(seq.getSeq_sti_campione()+1);
							}else if(settore!=null && settore.equals("1")) {
								seq.setSeq_cdt_campione(seq.getSeq_cdt_campione()+1);
							}
							session.update(seq);
						}
					}
					
					if(proprietario!=null && !proprietario.equals("")) {
						CompanyDTO cmp = GestioneCompanyBO.getCompanyById(proprietario, session);
						campione.setCompany(cmp);
					}else {
						campione.setCompany((CompanyDTO) request.getSession().getAttribute("usrCompany"));	
					}
					
					if(utilizzatore!=null && !utilizzatore.equals("")) {
						CompanyDTO cmp = GestioneCompanyBO.getCompanyById(utilizzatore, session);
						campione.setCompany_utilizzatore(cmp);
					}else {
						campione.setCompany_utilizzatore((CompanyDTO) request.getSession().getAttribute("usrCompany"));	
					}
					
					campione.setPrenotabile("N");
					
				if(!tipoCampione.equals("3")) {
				String rowOrder =  (String) ret.get("tblAppendGrid"+clona_valori_campione+"_rowOrder").replaceAll("\"", "");
				
				String[] list = new String[0];
				if(!rowOrder.equals(""))
					{
						list = rowOrder.split(",");
					}
		
				for (int i = 0; i < list.length; i++) {
					
					String valNom =  (String) ret.get("tblAppendGrid"+clona_valori_campione+"_valore_nominale_"+list[i]);
					String valTar =  (String) ret.get("tblAppendGrid"+clona_valori_campione+"_valore_taratura_"+list[i]);
					String valInAs =  (String) ret.get("tblAppendGrid"+clona_valori_campione+"_incertezza_assoluta_"+list[i]);
					String valInRel =  (String) ret.get("tblAppendGrid"+clona_valori_campione+"_incertezza_relativa_"+list[i]);
					String valPT =  (String) ret.get("tblAppendGrid"+clona_valori_campione+"_parametri_taratura_"+list[i]);
					String valUM =  (String) ret.get("tblAppendGrid"+clona_valori_campione+"_unita_misura_"+list[i]);
				//	String valInterp =  (String) ret.get("tblAppendGrid_interpolato_"+list[i]);
				//	String valComp =  (String) ret.get("tblAppendGrid_valore_composto_"+list[i]);
					String valDivUM =  (String) ret.get("tblAppendGrid"+clona_valori_campione+"_divisione_UM_"+list[i]);
					String valTipoG =  (String) ret.get("tblAppendGrid"+clona_valori_campione+"_tipo_grandezza_"+list[i]);
		
					
					ValoreCampioneDTO valc = new ValoreCampioneDTO();
					valc.setValore_nominale(new BigDecimal(valNom));
					valc.setValore_taratura(new BigDecimal(valTar));
					if(valInAs.length()>0){
						valc.setIncertezza_assoluta(new BigDecimal(valInAs));
					}
					if(valInRel.length()>0){
						valc.setIncertezza_relativa(new BigDecimal(valInRel));
					}
					
					UnitaMisuraDTO um = new UnitaMisuraDTO();
					um.setId(Integer.parseInt(valUM));
					
					TipoGrandezzaDTO tipoGrandezzaDTO = new TipoGrandezzaDTO();
					tipoGrandezzaDTO.setId(Integer.parseInt(valTipoG));
					valc.setParametri_taratura(valPT);
					valc.setUnita_misura(um);
				//	valc.setValore_composto(Integer.parseInt(valComp));
					valc.setInterpolato(Integer.parseInt(interpolato));
					valc.setDivisione_UM(new BigDecimal(valDivUM));
					valc.setTipo_grandezza(tipoGrandezzaDTO);
					
					valc.setCampione(campione);
					
					listaValoriNew.add(valc);
					}
				
					
				
				}
				int success = GestioneCampioneBO.saveCampione(campione, action, listaValoriNew,fileItem,ente_certificatore, session);
	
					if(success==0)
					{
						myObj.addProperty("success", true);
						myObj.addProperty("messaggio","Salvato con Successo");
						session.getTransaction().commit();
						session.close();
					
					}
					if(success==1)
					{
						
						myObj.addProperty("success", false);
						myObj.addProperty("messaggio","Errore Salvataggio");
						
						session.getTransaction().rollback();
				 		session.close();
				 		
					} 
					if(success==2)
					{
						
						myObj.addProperty("success", false);
						myObj.addProperty("messaggio","Caricare solo file in formato pdf");
						
						session.getTransaction().rollback();
				 		session.close();
				 		
					} 
				}
			
			
			else if(action.equals("modifica")) {
				
				
				CampioneDTO campione = GestioneCampioneDAO.getCampioneFromId( request.getParameter("id"));
				
				
				FileItem fileItem = null;
				
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	
	            	 }
	            	
	            
	            }
			        
			  String nome = (String) ret.get("nome_mod");
	
			  String descrizione = (String) ret.get("descrizione_mod");
			  String costruttore = (String) ret.get("costruttore_mod");
			  String modello = (String) ret.get("modello_mod");
			  String interpolazione = (String) ret.get("interpolazione_mod");
			  String freqTaratura = (String) ret.get("freqTaratura_mod");
			  String statoCampione = (String) ret.get("statoCampione_mod");
			  String dataVerifica = (String) ret.get("dataVerifica_mod");
			  String numeroCerificato  = (String) ret.get("numeroCerificato_mod");
			  		  
			  String matricola = (String) ret.get("matricola_mod");			 
			  
			  String distributore = (String) ret.get("distributore_mod");
			  String data_acquisto = (String) ret.get("data_acquisto_mod");
			  String data_messa_in_servizio = (String) ret.get("data_messa_in_servizio_mod");
			  String campo_accettabilita = (String)ret.get("campo_accettabilita_mod");
			  String ente_certificatore = (String)ret.get("ente_certificatore_mod");			  
			  
			  String campo_misura = (String)ret.get("campo_misura_mod");
			  String unita_formato = (String)ret.get("unita_formato_mod");
			  String frequenza_manutenzione = (String)ret.get("frequenza_manutenzione_mod");
			  String frequenza_verifica_intermedia = (String)ret.get("frequenza_verifica_intermedia_mod");
			  String note_attivita_taratura = (String)ret.get("note_attivita_taratura_mod");
			  String ubicazione = (String)ret.get("ubicazione_mod");
			  String id_strumento = (String)ret.get("strumento");
			  String descrizione_manutenzione = (String)ret.get("descrizione_manutenzione_mod");
			  String descrizione_verifica_intermedia = (String)ret.get("descrizione_verifica_intermedia_mod");
			  String attivita_di_taratura = (String) ret.get("attivita_taratura_text_mod");
			  String tipo_campione = (String) ret.get("tipoCampione_mod");
			  String campione_verificazione = (String) ret.get("campione_verificazione_mod");
			  
			 
				campione.setNome(nome);
				campione.setMatricola(matricola);
	 			campione.setDescrizione(descrizione);
				campione.setCostruttore(costruttore);
				campione.setModello(modello);
				
				if(interpolazione!=null && !interpolazione.equals("")) {
					campione.setInterpolazionePermessa(Integer.parseInt(interpolazione));	
				}else {
					campione.setInterpolazionePermessa(0);
				}
				
				if(freqTaratura!=null && !freqTaratura.equals("")) {
					campione.setFreqTaraturaMesi(Integer.parseInt(freqTaratura));	
				}else {
					campione.setFreqTaraturaMesi(0);
				}
				
				campione.setStatoCampione(statoCampione);
		 
				campione.setAttivita_di_taratura(attivita_di_taratura);
				campione.setCampo_accettabilita(campo_accettabilita);
				campione.setDistributore(distributore);
				
				campione.setCampo_misura(campo_misura);
				campione.setUnita_formato(unita_formato);
				campione.setTipo_campione(new TipoCampioneDTO(Integer.parseInt(tipo_campione), ""));
				
				if(id_strumento!=null && !id_strumento.equals("")) {
					campione.setId_strumento(Integer.parseInt(id_strumento));
				}
				if(frequenza_manutenzione!=null && !frequenza_manutenzione.equals("")) {
					campione.setFrequenza_manutenzione(Integer.parseInt(frequenza_manutenzione));	
				}else {
					campione.setFrequenza_manutenzione(0);
				}
				
				if(frequenza_verifica_intermedia!=null && !frequenza_verifica_intermedia.equals("")) {
					campione.setFrequenza_verifica_intermedia(Integer.parseInt(frequenza_verifica_intermedia));
				}else {
					campione.setFrequenza_verifica_intermedia(0);
				}
				campione.setNote_attivita(note_attivita_taratura);
				campione.setUbicazione(ubicazione);
				
				campione.setDescrizione_manutenzione(descrizione_manutenzione);
				campione.setDescrizione_verifica_intermedia(descrizione_verifica_intermedia);
				
				
				campione.setCampione_verificazione(Integer.parseInt(campione_verificazione));
				
				DateFormat format = new SimpleDateFormat("dd/MM/yyyy", Locale.ITALIAN);
				
				if(data_acquisto !=null && !data_acquisto.equals("")) {
				Date dataAcquisto = (Date) format.parse(data_acquisto);
				campione.setData_acquisto(dataAcquisto);
				}else {
					campione.setData_acquisto(null);
				}
				
				if(data_messa_in_servizio !=null && !data_messa_in_servizio.equals("")) {
					Date d = (Date) format.parse(data_messa_in_servizio);
					campione.setData_messa_in_servizio(d);
					}else {
						campione.setData_messa_in_servizio(null);
					}
				
				if(dataVerifica!=null && !dataVerifica.equals("")) {
					Date dataVerificaDate = (Date) format.parse(dataVerifica);
		 			campione.setDataVerifica(dataVerificaDate);
		 			Date dataScadenzaCampione=null;
		 			
		 			Calendar cal = Calendar.getInstance();
		 			cal.setTime(dataVerificaDate);
		 			cal.add(Calendar.MONTH, Integer.parseInt(freqTaratura));
		
		 			dataScadenzaCampione=cal.getTime();
		 			
		 			campione.setDataScadenza(dataScadenzaCampione);
				}else {
					campione.setDataVerifica(null);
					campione.setDataScadenza(null);
				}
	 				 			
	 			
				campione.setNumeroCertificato(numeroCerificato);
	
				ArrayList<ValoreCampioneDTO> listaValoriNew = new ArrayList<ValoreCampioneDTO>();
	
						
				int success = GestioneCampioneBO.saveCampione(campione, action, listaValoriNew,fileItem,ente_certificatore, session);
	
					if(success==0)
					{
						myObj.addProperty("success", true);
						myObj.addProperty("messaggio","Salvato con Successo");
						session.getTransaction().commit();
						session.close();
					
					}
					if(success==1)
					{
						
						myObj.addProperty("success", false);
						myObj.addProperty("messaggio","Errore Salvataggio");
						
						session.getTransaction().rollback();
				 		session.close();
				 		
					} 
					if(success==2)
					{
						
						myObj.addProperty("success", false);
						myObj.addProperty("messaggio","Caricare solo file in formato pdf");
						
						session.getTransaction().rollback();
				 		session.close();
				 		
					} 
				
			}
				
				
	
		}
		else
		{
			myObj.addProperty("success", false);
			myObj.addProperty("messaggio", "Nessuna action riconosciuta");  
		}
		
		out.println(myObj.toString());


		
	}
        catch(Exception ex)
	{
	ex.printStackTrace();
	session.getTransaction().rollback();
	session.close();
	request.getSession().setAttribute("exception", ex);
	//myObj.addProperty("success", false);
	//myObj.addProperty("messaggio", STIException.callException(ex).toString());
	myObj = STIException.getException(ex);
	out.println(myObj.toString());
	}  
	
	}
	
	static CampioneDTO getCampione(ArrayList<CampioneDTO> listaCampioni,String idC) {
		CampioneDTO campione =null;
		
		try
		{		
		for (int i = 0; i < listaCampioni.size(); i++) {
			
			if(listaCampioni.get(i).getId()==Integer.parseInt(idC))
			{
				return listaCampioni.get(i);
			}
		}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			campione=null;
			throw ex;
		}
		return campione;
	}

	public static void updateManutenzioniObsolete(CampioneDTO campione, Session session) {
		
		GestioneCampioneDAO.updateManutenzioniObsolete(campione, session);
	}

}
