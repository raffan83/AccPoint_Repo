package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.apache.pdfbox.io.MemoryUsageSetting;
import org.apache.pdfbox.multipdf.PDFMergerUtility;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import it.arubapec.arubasignservice.ArubaSignService;
import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.SicurezzaElettricaDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerAccuratezzaDTO;
import it.portaleSTI.DTO.VerCertificatoDTO;
import it.portaleSTI.DTO.VerDecentramentoDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerLinearitaDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerMobilitaDTO;
import it.portaleSTI.DTO.VerRipetibilitaDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateCertificatoSE;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneCertificatoBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneLivellaBollaBO;
import it.portaleSTI.bo.GestioneMisuraBO;
import it.portaleSTI.bo.GestioneRilieviBO;
import it.portaleSTI.bo.GestioneSicurezzaElettricaBO;
import it.portaleSTI.bo.GestioneUtenteBO;
import it.portaleSTI.bo.GestioneVerCertificatoBO;
import it.portaleSTI.bo.GestioneVerInterventoBO;
import it.portaleSTI.bo.SendEmailBO;
import it.portaleSTI.certificatiLAT.CreaCertificatoLivellaBolla;
import it.portaleSTI.certificatiLAT.CreaCertificatoLivellaElettronica;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="listaCertificati" , urlPatterns = { "/listaCertificati.do" })

public class ListaCertificati extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(ListaCertificati.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaCertificati() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;

		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		JsonObject myObj = new JsonObject();

		Boolean ajax = false;
		try 
		{
			
	
			
			String action =request.getParameter("action");
		
			
			RequestDispatcher dispatcher = null;
			ArrayList<CertificatoDTO> listaCertificati = null;
			
			request.getSession().setAttribute("action",action);
			CompanyDTO cmp =(CompanyDTO)request.getSession().getAttribute("usrCompany");
			UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
			UtenteDTO utente_firma = GestioneUtenteBO.getUtenteById(String.valueOf(utente.getId()), session);
			
			
			logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo());
			
			if(utente_firma.getIdFirma()!=null && !utente_firma.getIdFirma().equals("")) {
				request.getSession().setAttribute("abilitato_firma", true);
			}else {
				request.getSession().setAttribute("abilitato_firma", false);
			}
			LinkedHashMap<String, String> listaClienti =  GestioneCertificatoBO.getListaClientiCertificato(cmp.getId(),utente);
			request.getSession().setAttribute("listaClienti",listaClienti);
			
			if(action == null || action.equals("")){
				
				ajax = false;
				
				response.setContentType("text/html");
 				PrintWriter out = response.getWriter();
   				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificati.jsp");
		     	dispatcher.forward(request,response);

				
			}else if(action.equals("tutti")){
				ajax = false;
				
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
 				String idClienteSede =request.getParameter("cliente");
				
				String idCliente = "";
				String idSede = "";
				if(idClienteSede == null) {
					idCliente = null;
					idSede = null;
				}else {

					String[] cliente = idClienteSede.split("_");
					
					 idCliente = cliente[0];
					 idSede = cliente[1];
					
					if(idCliente.equals("0") && idSede.equals("0")) {
						idCliente = null;
						idSede = null;
					}
				}
				
				listaCertificati = GestioneCertificatoBO.getListaCertificato(null, null,cmp,utente,null,idCliente,idSede,0);

				request.getSession().setAttribute("listaCertificati",listaCertificati);
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiTutti.jsp");
		     	dispatcher.forward(request,response);

				
			}else if(action.equals("lavorazione")){
				ajax = false;
				
				response.setContentType("text/html");
 				PrintWriter out = response.getWriter();
 				String idClienteSede =request.getParameter("cliente");
				

				String idCliente = "";
				String idSede = "";
				if(idClienteSede == null) {
					idCliente = null;
					idSede = null;
				}else {

					String[] cliente = idClienteSede.split("_");
					
					 idCliente = cliente[0];
					 idSede = cliente[1];
					
					if(idCliente.equals("0") && idSede.equals("0")) {
						idCliente = null;
						idSede = null;
					}
				}
				
				listaCertificati = GestioneCertificatoBO.getListaCertificato(new StatoCertificatoDTO(1), null,cmp,utente,"N",idCliente,idSede,0);
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiInLavorazione.jsp");
		     	dispatcher.forward(request,response);

				
			}else if(action.equals("obsoleti")){
				
				ajax = false;
				
				response.setContentType("text/html");
 				PrintWriter out = response.getWriter();
 				String idClienteSede =request.getParameter("cliente");
				

				String idCliente = "";
				String idSede = "";
				if(idClienteSede == null) {
					idCliente = null;
					idSede = null;
				}else {

					String[] cliente = idClienteSede.split("_");
					
					 idCliente = cliente[0];
					 idSede = cliente[1];
					
					if(idCliente.equals("0") && idSede.equals("0")) {
						idCliente = null;
						idSede = null;
					}
				}
				
				listaCertificati = GestioneCertificatoBO.getListaCertificato(new StatoCertificatoDTO(1), null,cmp,utente,"S",idCliente,idSede,0);
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiObsoleti.jsp");
		     	dispatcher.forward(request,response);

				
			}else if(action.equals("chiusi")){
				
				ajax = false;
				
				response.setContentType("text/html");
 				PrintWriter out = response.getWriter();
 				String idClienteSede =request.getParameter("cliente");
 				String anno = request.getParameter("anno");
				
				String idCliente = "";
				String idSede = "";
				if(idClienteSede == null) {
					idCliente = null;
					idSede = null;
				}else {

					String[] cliente = idClienteSede.split("_");
					
					 idCliente = cliente[0];
					 idSede = cliente[1];
					
					if(idCliente.equals("0") && idSede.equals("0")) {
						idCliente = null;
						idSede = null;
					}
				}
				int massimo = 0;
								
				ArrayList<Integer> listaAnni = GestioneCertificatoBO.getListaAnni(idCliente,idSede,session);
				if(anno != null) {
					massimo = Integer.parseInt(anno);
				}else {
					
					
					 massimo = listaAnni.get(0);

				        // Itera sull'ArrayList per trovare il massimo
				        for (int i = 1; i < listaAnni.size(); i++) {
				            int elementoCorrente = listaAnni.get(i);
				            if (elementoCorrente > massimo) {
				                massimo = elementoCorrente;
				            }
				        }
				}
				
				
				listaCertificati = GestioneCertificatoBO.getListaCertificato(new StatoCertificatoDTO(2), null,cmp,utente,null,idCliente,idSede,massimo);
				
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				request.getSession().setAttribute("listaAnni",listaAnni);
				request.getSession().setAttribute("anno_corrente",massimo);
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiChiusi.jsp");
		     	dispatcher.forward(request,response);

			}else if(action.equals("annullati")){
				
				ajax = false;
				
				response.setContentType("text/html");
 				PrintWriter out = response.getWriter();
 				String idClienteSede =request.getParameter("cliente");
				
				String idCliente = "";
				String idSede = "";
				if(idClienteSede == null) {
					idCliente = null;
					idSede = null;
				}else {

					String[] cliente = idClienteSede.split("_");
					
					 idCliente = cliente[0];
					 idSede = cliente[1];
					
					if(idCliente.equals("0") && idSede.equals("0")) {
						idCliente = null;
						idSede = null;
					}
				}
				
				listaCertificati = GestioneCertificatoBO.getListaCertificato(new StatoCertificatoDTO(3), null,cmp,utente,null,idCliente,idSede,0);
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiAnnullati.jsp");
		     	dispatcher.forward(request,response);

			}else if(action.equals("creaCertificato")){
				ajax = true;
				
				response.setContentType("text/html");
 				PrintWriter out = response.getWriter();
 			
				ServletContext context =getServletContext();
	
				
				String idCertificato = request.getParameter("idCertificato");
				String data_emissione = request.getParameter("data_emissione");
				
				
				CertificatoDTO certificato = GestioneCertificatoBO.getCertificatoById(idCertificato);
				
				List<CampioneDTO> listaCampioni = GestioneMisuraBO.getListaCampioni(certificato.getMisura().getListaPunti(),certificato.getMisura().getStrumento().getTipoRapporto());
				
				boolean dataCampioneSuccessiva = false;
				for (CampioneDTO campioneDTO : listaCampioni) {
					if(campioneDTO.getDataVerifica()!= null && campioneDTO.getDataVerifica().after(certificato.getMisura().getDataMisura())) {
						myObj.addProperty("success", false);
						myObj.addProperty("messaggio", "Attenzione! La data verifica del campione è successiva alla data misura!");
				        out.println(myObj.toString());
				        dataCampioneSuccessiva = true;
				        break;
				        
					}
				}

				
				if(dataCampioneSuccessiva == false) {
					String resultFirma = GestioneCertificatoBO.createCertificato(idCertificato, data_emissione,session,context, utente);	

					
					

					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Misura Approvata, il certificato &egrave; stato genereato con successo <br>"+ resultFirma);
			        out.println(myObj.toString());
				}
			
			        
			     
			}
			else if(action.equals("livella_bolla")) {
				ajax = true;
				PrintWriter out = response.getWriter();				
				
				String idCertificato = request.getParameter("idCertificato");
				
				CertificatoDTO certificato = GestioneCertificatoBO.getCertificatoById(idCertificato);
				
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());				
				response.setContentType("application/json");
				List<FileItem> items = uploadHandler.parseRequest(request);
				
				List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				for (FileItem item : items) {
					if (!item.isFormField()) {
						if(item.getName()!="") {	
							InputStream is = item.getInputStream();
							
							new CreaCertificatoLivellaBolla(certificato, certificato.getMisura().getMisuraLAT(), is, utente,null,listaSedi, session);
						}								
					}
				}
				
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Misura Approvata, il certificato &egrave; stato genereato con successo");
		        out.println(myObj.toString());
				
			}
			
			
			
			else if(action.equals("creaCertificatoLat")) {
				ajax = true;
				PrintWriter out = response.getWriter();				
				
				String idCertificato = request.getParameter("idCertificato");
				String latMaster = request.getParameter("latMaster");
				
				CertificatoDTO certificato = GestioneCertificatoBO.getCertificatoById(idCertificato);				
				
				if(latMaster.equals("2")) {
					new CreaCertificatoLivellaElettronica(certificato, certificato.getMisura().getMisuraLAT(), utente, null,session);
				}
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Misura Approvata, il certificato &egrave; stato genereato con successo");
		        out.println(myObj.toString());
				
			}
			else if(action.equals("creaCertificatoSE")) {
				ajax = true;
				PrintWriter out = response.getWriter();				
				
				String idCertificato = request.getParameter("idCertificato");
				String data_emissione = request.getParameter("data_emissione");
							
				CertificatoDTO certificato = GestioneCertificatoBO.getCertificatoById(idCertificato);
				
				CreateCertificatoSE resultFirma = new CreateCertificatoSE(certificato,data_emissione, utente,session);				
			
//				}
					
				

					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Misura Approvata, il certificato &egrave; stato genereato con successo <br>"+ resultFirma.messaggio_firma);
			        out.println(myObj.toString());
				
//				myObj.addProperty("success", true);
//				myObj.addProperty("messaggio", "Misura Approvata, il certificato &egrave; stato genereato con successo");
//		        out.println(myObj.toString());
				
			}
			
			
			else if(action.equals("inviaEmailCertificato")){
				response.setContentType("text/html");
 				PrintWriter out = response.getWriter();
 				ajax = true;
				String idCertificato = request.getParameter("idCertificato");
				String email = request.getParameter("email");
				
				CertificatoDTO certificato = GestioneCertificatoBO.getCertificatoById(idCertificato);
					
				SendEmailBO.sendEmailCertificato(certificato, email, getServletContext());

				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Certificato inviato con successo");
				out.println(myObj.toString());
			        
			    
			}else if(action.equals("firmaCertificato")){
				response.setContentType("text/html");
 				PrintWriter out = response.getWriter();
 				ajax = true;
				String idCertificato = request.getParameter("idCertificato");
				String pin = request.getParameter("pin");				
				
				boolean esito = GestioneUtenteBO.checkPINFirma(utente_firma.getId(),pin, session);
				if(esito) {
					CertificatoDTO certificato = GestioneCertificatoBO.getCertificatoById(idCertificato);
					
					//UtenteDTO utente_firma = GestioneUtenteBO.getUtenteById(String.valueOf(utente.getId()), session);

					myObj = ArubaSignService.sign(utente_firma.getIdFirma(),certificato);
					//myObj.addProperty("success", true);
	
					if(myObj.get("success").getAsBoolean()) {
						certificato.setFirmato(true);
						session.update(certificato);
					}
					
				}else {
					myObj.addProperty("success", false);
					myObj.addProperty("messaggio", "Attenzione! PIN errato!");
				}
				
				
			        out.println(myObj.toString());
			        
			}else if(action.equals("annullaCertificato")){
				ajax = true;
				
				response.setContentType("text/html");
 				PrintWriter out = response.getWriter();
 				
				String idCertificato = request.getParameter("idCertificato");
				
				CertificatoDTO certificato =GestioneCertificatoBO.getCertificatoById(idCertificato);
				
				certificato.getStato().setId(3);
				MisuraDTO misura = certificato.getMisura();
				misura.setObsoleto("S");
				session.update(certificato);
				session.update(misura);
			
				
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Certificato Annullato");
			        out.println(myObj.toString());
			        
			}else if(action.equals("approvaCertificatiMulti")){
				
				ajax = true;
				
				response.setContentType("text/html");
 				PrintWriter out = response.getWriter();
 				
 				
				String selezionati = request.getParameter("dataIn");
				String data_emissione = request.getParameter("data_emissione");
				
				JsonElement jelement = new JsonParser().parse(selezionati);
				JsonObject jsonObj = jelement.getAsJsonObject();
				JsonArray jsArr = jsonObj.get("ids").getAsJsonArray();
				boolean dataCampioneSuccessiva = false;
			//	String resultFirma = "";
				for(int i=0; i<jsArr.size(); i++){
					String id =  jsArr.get(i).toString().replaceAll("\"", "");
				
					ServletContext context =getServletContext();
					CertificatoDTO certificato = GestioneCertificatoBO.getCertificatoById(id);
					
					if(certificato.getMisura().getLat().equals("E")) {
						new CreateCertificatoSE(certificato,data_emissione,utente,session);
					}
					else if(certificato.getMisura().getMisuraLAT()!=null && certificato.getMisura().getMisuraLAT().getMisura_lat().getId()==1) {
//						new CreaCertificatoLivellaBolla(certificato, certificato.getMisura().getMisuraLAT(), null,utente, session);
					}
					else if(certificato.getMisura().getMisuraLAT()!=null && certificato.getMisura().getMisuraLAT().getMisura_lat().getId()==2) {
						new CreaCertificatoLivellaElettronica(certificato, certificato.getMisura().getMisuraLAT(), utente, null,session);
					}
					
					else {
						
						
						List<CampioneDTO> listaCampioni = GestioneMisuraBO.getListaCampioni(certificato.getMisura().getListaPunti(),certificato.getMisura().getStrumento().getTipoRapporto());
						for (CampioneDTO campioneDTO : listaCampioni) {
							if(campioneDTO.getDataVerifica().after(certificato.getMisura().getDataMisura())) {
								myObj.addProperty("success", false);
								myObj.addProperty("messaggio", "Attenzione! La data verifica del campione sul certificato ID "+certificato.getId()+" è successiva alla data misura!");
						        out.println(myObj.toString());
						        dataCampioneSuccessiva = true;
						        break;
						        
							}
						}
						if(dataCampioneSuccessiva == false) {
							GestioneCertificatoBO.createCertificato(id,data_emissione, session,context, utente);	
						}
							
					}
					
				}		
				
				if(dataCampioneSuccessiva == false) {
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Sono stati approvati "+jsArr.size()+" certificati ");
			        out.println(myObj.toString());
				}
			        
			}else if(action.equals("annullaCertificatiMulti")){
				
				ajax = true;
				
				response.setContentType("text/html");
 				PrintWriter out = response.getWriter();
				
				
				String selezionati = request.getParameter("dataIn");
				
				JsonElement jelement = new JsonParser().parse(selezionati);
				JsonObject jsonObj = jelement.getAsJsonObject();
				JsonArray jsArr = jsonObj.get("ids").getAsJsonArray();
				
				for(int i=0; i<jsArr.size(); i++){
					String id =  jsArr.get(i).toString().replaceAll("\"", "");
					
					CertificatoDTO certificato =GestioneCertificatoBO.getCertificatoById(id);
					
					certificato.getStato().setId(3);
					MisuraDTO misura = certificato.getMisura();
					misura.setObsoleto("S");
					session.update(misura);
					session.update(certificato);
				}

					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Sono stati annullati "+jsArr.size()+" certificati ");
			        out.println(myObj.toString());
			        
			}else if(action.equals("generaCertificatiMulti")) {
 				ajax = false;

				String selezionati = request.getParameter("dataIn");

				
				JsonElement jelement = new JsonParser().parse(selezionati);
				JsonObject jsonObj = jelement.getAsJsonObject();
				JsonArray jsArr = jsonObj.get("ids").getAsJsonArray();
		
				PDFMergerUtility ut = new PDFMergerUtility();
				
				ArrayList<File> fileAllegati = new ArrayList<File>();
				
				for(int i=0; i<jsArr.size(); i++){
					String id =  jsArr.get(i).toString().replaceAll("\"", "");
				
					ServletContext context =getServletContext();
					CertificatoDTO cert = GestioneCertificatoBO.getCertificatoById(id);
					File certificato = GestioneCertificatoBO.createCertificatoMulti(id,"",session,context, cert.getUtenteApprovazione());	

					ut.addSource(certificato);
					if(cert.getMisura().getLat().equals("N")) {
						fileAllegati.add(certificato);
					}
						
				}	
				
				File theDir = new File(Costanti.PATH_FOLDER+"//temp//");

				// if the directory does not exist, create it
				if (!theDir.exists()) {
 				    boolean result = false;
 
				        theDir.mkdir();
				        result = true;

				}
				
				String timestamp =  String.valueOf(System.currentTimeMillis());
				ut.setDestinationFileName(Costanti.PATH_FOLDER+"//temp//"+timestamp+".pdf");
				ut.mergeDocuments(MemoryUsageSetting.setupTempFileOnly());
				
				File d = new File(Costanti.PATH_FOLDER+"//temp//"+timestamp+".pdf");
				
				FileInputStream fileIn = new FileInputStream(d);
				 
				 response.setContentType("application/octet-stream");
				  
				 response.setHeader("Content-Disposition","attachment;filename="+timestamp+".pdf");
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    
				    fileIn.close();
				    d.delete();
				    
				    for (File certificato : fileAllegati) {
				    		certificato.delete();
					}

				    outp.flush();
				    outp.close();
				    theDir.delete();
			        
			}
			
			else if(action.equals("certificati_misure_campione")) {
				ajax = false;
				
				String id_campione = request.getParameter("idCamp");
				
				CampioneDTO campione = GestioneCampioneDAO.getCampioneFromId(id_campione);
				
				ArrayList<CertificatoDTO> lista_certificati = GestioneCertificatoBO.getListaCertificatiCampioneStrumento(campione.getId_strumento(), session);
				
				request.getSession().setAttribute("lista_certificati", lista_certificati);				
				
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiCampioneStrumento.jsp");
		     	dispatcher.forward(request,response);
			}
			else if(action.equals("certificati_precedenti")) {
				
				ajax = true;
				
				String id_strumento = request.getParameter("id_strumento");
				
				ArrayList<CertificatoDTO> lista_certificati = GestioneCertificatoBO.getListaCertificatiChiusiStrumento(Integer.parseInt(id_strumento), session);
				PrintWriter out = response.getWriter();
				response.setContentType("application/json");
				 Gson gson = new GsonBuilder().setDateFormat("dd/MM/yyyy").create(); 			        			        
			     			      		       
			        myObj.addProperty("success", true);
			
			        myObj.add("lista_certificati", gson.toJsonTree(lista_certificati));			      
			        
			        out.println(myObj.toString());
		
			        out.close();
			        
						
			}
			else if(action.equals("riemetti_certificato")) {
				
				String id_certificato_old = request.getParameter("id_certificato_old");
				String id_certificato_new = request.getParameter("id_certificato_new");
				
				CertificatoDTO certificato_old = GestioneCertificatoBO.getCertificatoById(id_certificato_old);
				CertificatoDTO certificato_new = GestioneCertificatoBO.getCertificatoById(id_certificato_new);
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());				
				response.setContentType("application/json");
				List<FileItem> items = uploadHandler.parseRequest(request);
				InputStream is = null;
				for (FileItem item : items) {
					if (!item.isFormField()) {
						if(item.getName()!="") {	
							 is = item.getInputStream();
						}								
					}
				}
				
				List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				if(certificato_new.getMisura().getMisuraLAT().getMisura_lat().getId()== 1) {
					new CreaCertificatoLivellaBolla(certificato_new, certificato_new.getMisura().getMisuraLAT(), is, utente, certificato_old, listaSedi,   session);
				}
				
				if(certificato_new.getMisura().getMisuraLAT().getMisura_lat().getId()== 2) {
					new CreaCertificatoLivellaElettronica(certificato_new, certificato_new.getMisura().getMisuraLAT(), utente,certificato_old,  session);
				}
				
				certificato_old.getMisura().setObsoleto("S");
				session.update(certificato_old.getMisura());

	        	PrintWriter out = response.getWriter();
	        	myObj.addProperty("success", true);
	        	myObj.addProperty("messaggio", "Certificato riemesso con successo!");
	        	out.print(myObj);
				
				
			}
			   session.getTransaction().commit();
		       session.close();
			 
		} 
		catch (Exception e) {
			session.getTransaction().rollback();
        	session.close();
			if(ajax) {
				
				PrintWriter out = response.getWriter();
				e.printStackTrace();
	        	
	        	request.getSession().setAttribute("exception", e);
	        	myObj = STIException.getException(e);
	        	out.print(myObj);
        	}else {
   			    			
    			e.printStackTrace();
    			request.setAttribute("error",STIException.callException(e));
    	  	     request.getSession().setAttribute("exception", e);
    			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
    		     dispatcher.forward(request,response);	
        	}

		}
	
	}

}
