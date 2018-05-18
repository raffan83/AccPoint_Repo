package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.TipoCampioneDTO;
import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCampioneBO;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;

import java.io.PrintWriter;
import java.math.BigDecimal;

import java.util.Date;
import java.util.Hashtable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
			else
			{

			CampioneDTO campione = null;
			
			if(action.equals("modifica")){
				campione = GestioneCampioneDAO.getCampioneFromId( request.getParameter("id"));
				
			}
			 else if(action.equals("nuovo"))
			 {
				campione = new CampioneDTO();
			
			}
			

			
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
		  String attivita_di_taratura ="";
		  
		  
		  if(action.equals("nuovo")) {
			  attivita_di_taratura = (String) ret.get("attivita_di_taratura_text");
		  }
		  else if(action.equals("modifica")) {
			  attivita_di_taratura = (String) ret.get("attivita_taratura_text");
		  }
			campione.setNome(nome);
			campione.setMatricola(matricola);
 			campione.setDescrizione(descrizione);
			campione.setCostruttore(costruttore);
			campione.setModello(modello);
			campione.setInterpolazionePermessa(Integer.parseInt(interpolazione));
			campione.setFreqTaraturaMesi(Integer.parseInt(freqTaratura));
			campione.setStatoCampione(statoCampione);
	 
			campione.setAttivita_di_taratura(attivita_di_taratura);
			campione.setCampo_accettabilita(campo_accettabilita);
			campione.setDistributore(distributore);
			
			DateFormat format = new SimpleDateFormat("dd/MM/yyyy", Locale.ITALIAN);
			
			if(data_acquisto !=null && !data_acquisto.equals("")) {
			Date dataAcquisto = (Date) format.parse(data_acquisto);
			campione.setData_acquisto(dataAcquisto);
			}else {
				campione.setData_acquisto(null);
			}
			Date dataVerificaDate = (Date) format.parse(dataVerifica);
 			campione.setDataVerifica(dataVerificaDate);
 			
 			Date dataScadenzaCampione=null;
 			
 			Calendar cal = Calendar.getInstance();
 			cal.setTime(dataVerificaDate);
 			cal.add(Calendar.MONTH, Integer.parseInt(freqTaratura));

 			dataScadenzaCampione=cal.getTime();
 			
 			campione.setDataScadenza(dataScadenzaCampione);
 			
			campione.setNumeroCertificato(numeroCerificato);

			ArrayList<ValoreCampioneDTO> listaValoriNew = new ArrayList<ValoreCampioneDTO>();

			if(action.equals("nuovo")){
			
				campione.setUtilizzatore(utilizzatore);
				campione.setTipo_campione(new TipoCampioneDTO(Integer.parseInt(tipoCampione),""));
				campione.setCodice(codice);
				
				campione.setCompany((CompanyDTO) request.getSession().getAttribute("usrCompany"));
				campione.setCompany_utilizzatore((CompanyDTO) request.getSession().getAttribute("usrCompany"));
			
			
			String rowOrder =  (String) ret.get("tblAppendGrid_rowOrder").replaceAll("\"", "");
			
			String[] list = new String[0];
			if(!rowOrder.equals(""))
				{
					list = rowOrder.split(",");
				}
	
			for (int i = 0; i < list.length; i++) {
				
				String valNom =  (String) ret.get("tblAppendGrid_valore_nominale_"+list[i]);
				String valTar =  (String) ret.get("tblAppendGrid_valore_taratura_"+list[i]);
				String valInAs =  (String) ret.get("tblAppendGrid_incertezza_assoluta_"+list[i]);
				String valInRel =  (String) ret.get("tblAppendGrid_incertezza_relativa_"+list[i]);
				String valPT =  (String) ret.get("tblAppendGrid_parametri_taratura_"+list[i]);
				String valUM =  (String) ret.get("tblAppendGrid_unita_misura_"+list[i]);
			//	String valInterp =  (String) ret.get("tblAppendGrid_interpolato_"+list[i]);
			//	String valComp =  (String) ret.get("tblAppendGrid_valore_composto_"+list[i]);
				String valDivUM =  (String) ret.get("tblAppendGrid_divisione_UM_"+list[i]);
				String valTipoG =  (String) ret.get("tblAppendGrid_tipo_grandezza_"+list[i]);
	
				
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
	myObj.addProperty("success", false);
	myObj.addProperty("messaggio", STIException.callException(ex).toString());
	//out.println(myObj.toString());
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

}
