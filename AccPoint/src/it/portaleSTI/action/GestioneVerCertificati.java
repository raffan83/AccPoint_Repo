package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.pdfbox.io.MemoryUsageSetting;
import org.apache.pdfbox.multipdf.PDFMergerUtility;
import org.hibernate.Session;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import it.arubapec.arubasignservice.ArubaSignService;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerCertificatoDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateVerCertificato;
import it.portaleSTI.bo.CreateVerRapporto;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneCertificatoBO;
import it.portaleSTI.bo.GestioneConfigurazioneClienteBO;
import it.portaleSTI.bo.GestioneUtenteBO;
import it.portaleSTI.bo.GestioneVerCertificatoBO;
import it.portaleSTI.bo.GestioneVerMisuraBO;
import it.portaleSTI.bo.SendEmailBO;

/**
 * Servlet implementation class GestioneVerCertificati
 */
@WebServlet("/gestioneVerCertificati.do")
public class GestioneVerCertificati extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneVerCertificati() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		
		String action = request.getParameter("action");
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
        response.setContentType("application/json");
		try {
			
			LinkedHashMap<String, String> listaClienti =  GestioneVerCertificatoBO.getClientiPerVerCertificato(utente, session);
			request.getSession().setAttribute("listaClienti",listaClienti);				
			
			if(action == null || action.equals("")){
				response.setContentType("text/html");
 				PrintWriter out = response.getWriter();
 				
 				session.getTransaction().commit();
		     	session.close();
		     	
 				RequestDispatcher dispatcher  = getServletContext().getRequestDispatcher("/site/listaVerCertificati.jsp");
		     	dispatcher.forward(request,response);		     	
				
			}else if(action.equals("tutti")){
				response.setContentType("text/html");
				
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
					
					
				}
				
				ArrayList<VerCertificatoDTO> listaCertificati =	GestioneVerCertificatoBO.getListaCertificati(0,0,Integer.parseInt(idCliente),Integer.parseInt(idSede), false,session);

				request.getSession().setAttribute("listaCertificati",listaCertificati);
				RequestDispatcher dispatcher  = getServletContext().getRequestDispatcher("/site/listaVerCertificatiTutti.jsp");
		     	dispatcher.forward(request,response);

				
			}else if(action.equals("lavorazione")){
				response.setContentType("text/html"); 				
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
					
					
				}
				
				ArrayList<VerCertificatoDTO> listaCertificati =	GestioneVerCertificatoBO.getListaCertificati(1,0, Integer.parseInt(idCliente),Integer.parseInt(idSede),false, session);
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaVerCertificatiInLavorazione.jsp");
		     	dispatcher.forward(request,response);

				
			}else if(action.equals("chiusi")){
				response.setContentType("text/html");
 				String idClienteSede = request.getParameter("cliente");
 				String filtro_emissione = request.getParameter("filtro_emissione");
				
				String idCliente = "";
				String idSede = "";
				if(idClienteSede == null) {
					idCliente = null;
					idSede = null;
				}else {

					String[] cliente = idClienteSede.split("_");
					
					 idCliente = cliente[0];
					 idSede = cliente[1];
					
					
				}
								
				ArrayList<VerCertificatoDTO> listaCertificati =	GestioneVerCertificatoBO.getListaCertificati(2,Integer.parseInt(filtro_emissione),Integer.parseInt(idCliente),Integer.parseInt(idSede),false, session);
				
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaVerCertificatiChiusi.jsp");
		     	dispatcher.forward(request,response);

			}
			else if(action.equals("obsoleti")) {
			
				
				response.setContentType("text/html");
 				String idClienteSede = request.getParameter("cliente");
				String idCliente = "";
				String idSede = "";
				if(idClienteSede == null) {
					idCliente = null;
					idSede = null;
				}else {

					String[] cliente = idClienteSede.split("_");
					
					 idCliente = cliente[0];
					 idSede = cliente[1];
					
					
				}
								
				ArrayList<VerCertificatoDTO> listaCertificati =	GestioneVerCertificatoBO.getListaCertificati(0,0,Integer.parseInt(idCliente),Integer.parseInt(idSede),true, session);
				
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaVerCertificatiTutti.jsp");
		     	dispatcher.forward(request,response);
			}
			
			else if(action.equals("crea_certificato")) {
				ajax = true;
				
				String id_misura = request.getParameter("id_misura");
				
				id_misura = Utility.decryptData(id_misura);
				
				VerMisuraDTO misura = GestioneVerMisuraBO.getMisuraFromId(Integer.parseInt(id_misura), session);

				List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
									
				int motivo = GestioneVerMisuraBO.getEsito(misura);
				boolean esito_globale = true;
				if(motivo!=0) {
					esito_globale = false;
				}					
							
				new CreateVerCertificato(misura, listaSedi, esito_globale, motivo, session);
				
				String filename=misura.getVerIntervento().getNome_pack()+"_"+misura.getId()+""+misura.getVerStrumento().getId()+".pdf";
				
				if(motivo != 3) {
					new CreateVerRapporto(misura, listaSedi, esito_globale, motivo,utente, session);	
				}
								
				VerCertificatoDTO cert=GestioneVerCertificatoBO.getCertificatoByMisura(misura);
				
				cert.setNomeCertificato(filename);
				cert.setStato(new StatoCertificatoDTO(2));
				if(motivo != 3) {
					cert.setNomeRapporto("RAP"+filename);
				}
				session.update(cert);
				
				session.getTransaction().commit();
			    session.close();
			    
			    PrintWriter out = response.getWriter();
			    myObj.addProperty("success", true);
			    myObj.addProperty("messaggio", "Certificato generato con successo!");
			    out.print(myObj);

			}
			else if(action.equals("crea_certificati_multi")){
				response.setContentType("text/html");
 				PrintWriter out = response.getWriter();
 				ajax = true;
 				
				String selezionati = request.getParameter("dataIn");
				
				
				JsonElement jelement = new JsonParser().parse(selezionati);
				JsonObject jsonObj = jelement.getAsJsonObject();
				JsonArray jsArr = jsonObj.get("ids").getAsJsonArray();
				
				List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				for(int i=0; i<jsArr.size(); i++){
					String id =  jsArr.get(i).toString().replaceAll("\"", "");
				
					VerCertificatoDTO certificato = GestioneVerCertificatoBO.getCertificatoById(Integer.parseInt(id), session);
					
					int motivo = GestioneVerMisuraBO.getEsito(certificato.getMisura());
					boolean esito_globale = true;
					if(motivo!=0) {
						esito_globale = false;
					}
					
					new CreateVerCertificato(certificato.getMisura(), listaSedi, esito_globale, motivo, session);
					
					String filename=certificato.getMisura().getVerIntervento().getNome_pack()+"_"+certificato.getMisura().getId()+""+certificato.getMisura().getVerStrumento().getId()+".pdf";
					
					if(motivo != 3) {
						new CreateVerRapporto(certificato.getMisura(), listaSedi, esito_globale, motivo, utente,session);	
					}								
									
					certificato.setNomeCertificato(filename);
					certificato.setStato(new StatoCertificatoDTO(2));
					if(motivo != 3) {
						certificato.setNomeRapporto("RAP"+filename);
					}
					
					session.update(certificato);
					
					
					
				}		
				
				session.getTransaction().commit();
			    session.close();
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Sono stati approvati "+jsArr.size()+" certificati ");
			        out.println(myObj.toString());
			        
			}
			else if(action.equals("download")) {
				
				String id_certificato = request.getParameter("id_certificato");
				id_certificato = Utility.decryptData(id_certificato);
				
				String cert_rap = request.getParameter("cert_rap");
				String p7m = request.getParameter("p7m");
				
				VerCertificatoDTO certificato = GestioneVerCertificatoBO.getCertificatoById(Integer.parseInt(id_certificato), session);
							
				String filename= "";
				String path= "";
				if(cert_rap.equals("1")) {
					filename = certificato.getNomeCertificato();
					if(p7m!= null && p7m.equals("1")) {
						path = Costanti.PATH_FOLDER+"\\"+certificato.getMisura().getVerIntervento().getNome_pack()+"\\"+filename+".p7m";
					}else {
						path = Costanti.PATH_FOLDER+"\\"+certificato.getMisura().getVerIntervento().getNome_pack()+"\\"+filename;	
					}
					
				}else if(cert_rap.equals("2")) {
					filename = certificato.getNomeRapporto();
					path = Costanti.PATH_FOLDER+"\\"+certificato.getMisura().getVerIntervento().getNome_pack()+"\\Rapporto\\"+filename;					
				}else if(cert_rap.equals("0")) {
					if(certificato.getNomeRapporto()==null || certificato.getNomeRapporto().equals("")) {
						filename = certificato.getNomeCertificato();
						path = Costanti.PATH_FOLDER+"\\"+certificato.getMisura().getVerIntervento().getNome_pack()+"\\"+filename;
					}else {
						String filename_cert = certificato.getNomeCertificato();
						String filename_rap = certificato.getNomeRapporto();
						String path_cert = Costanti.PATH_FOLDER+"\\"+certificato.getMisura().getVerIntervento().getNome_pack()+"\\"+filename_cert;
						String path_rap =  Costanti.PATH_FOLDER+"\\"+certificato.getMisura().getVerIntervento().getNome_pack()+"\\Rapporto\\"+filename_rap;
						
						File cert = new File(path_cert);
						File rap = new File(path_rap);
						PDFMergerUtility ut = new PDFMergerUtility();
						ut.addSource(cert);

						ut.addSource(rap);
						ut.setDestinationFileName(Costanti.PATH_FOLDER+"\\temp\\"+filename_cert);
						ut.mergeDocuments(MemoryUsageSetting.setupTempFileOnly());
						path = Costanti.PATH_FOLDER+"\\temp\\"+filename_cert;
						filename = filename_cert;
					}					
				}
				
							
				File d = new File(path);
				 FileInputStream fileIn = new FileInputStream(d);
				 
				// response.setContentType("application/octet-stream");
				 response.setContentType("application/pdf");
				
				 if(p7m!= null && p7m.equals("1")) {
					 response.setHeader("Content-Disposition","attachment;filename="+filename+".p7m");
				 }
				 
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				     }
				    
				    
				    session.getTransaction().commit();
				    session.close();
				    fileIn.close();
			
				    outp.flush();
				    outp.close();
				
			}
			else if(action.equals("firmaCertificato")) {
				
				response.setContentType("text/html");
 				PrintWriter out = response.getWriter();
 				ajax = true;
				String idCertificato = request.getParameter("idCertificato");
				String pin = request.getParameter("pin");				
				
				boolean esito = GestioneUtenteBO.checkPINFirma(utente.getId(),pin, session);
				if(esito) {
					VerCertificatoDTO certificato = GestioneVerCertificatoBO.getCertificatoById(Integer.parseInt(idCertificato),session);
					
					UtenteDTO utente_firma = GestioneUtenteBO.getUtenteById(String.valueOf(utente.getId()), session);

					myObj = ArubaSignService.signVerificazione(utente_firma.getIdFirma(),certificato);
					
					//myObj.addProperty("success", true);
	
					if(myObj.get("success").getAsBoolean()) {
						certificato.setFirmato(1);
						session.update(certificato);
					}
					
				}else {
					myObj.addProperty("success", false);
					myObj.addProperty("messaggio", "Attenzione! PIN errato!");
				}
				
				session.getTransaction().commit();
				session.close();
			    out.println(myObj.toString());
			}
			else if(action.equals("indirizzo_email")) {
				
				ajax = true;
				String id_certificato = request.getParameter("id_certificato");
				
				VerCertificatoDTO certificato = GestioneVerCertificatoBO.getCertificatoById(Integer.parseInt(id_certificato), session);
				String indirizzo = "";
				if(certificato.getMisura().getVerIntervento().getId_sede()==0) {
					ClienteDTO cliente = GestioneAnagraficaRemotaBO.getClienteById(""+certificato.getMisura().getVerIntervento().getId_cliente());
					indirizzo = cliente.getEmail();
				}else {
					ClienteDTO cliente = GestioneAnagraficaRemotaBO.getClienteFromSede(""+certificato.getMisura().getVerIntervento().getId_cliente(), ""+certificato.getMisura().getVerIntervento().getId_sede());
					indirizzo = cliente.getEmail();							
				}
				if(indirizzo == null) {
					indirizzo = "";
				}
				PrintWriter out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("indirizzo", indirizzo);
				
				session.getTransaction().commit();
				session.close();
			    out.println(myObj);
			}
			else if(action.equals("invia_email")) {
				
				response.setContentType("text/html");
 				PrintWriter out = response.getWriter();
 				ajax = true;
				String id_certificato = request.getParameter("id_certificato");
				String indirizzo = request.getParameter("indirizzo");
				
				VerCertificatoDTO certificato = GestioneVerCertificatoBO.getCertificatoById(Integer.parseInt(id_certificato), session);
				
				indirizzo = indirizzo.replaceAll(" ", "");
				
				String[] lista_indirizzi = indirizzo.split(";");
				
				for(int i = 0; i<lista_indirizzi.length;i++) {
					SendEmailBO.sendEmailCertificatoVerificazione(certificato, lista_indirizzi[i], getServletContext());
				}

				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Email inviata con successo");
				out.println(myObj.toString());
				
			}
			
		}catch (Exception e) {
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
