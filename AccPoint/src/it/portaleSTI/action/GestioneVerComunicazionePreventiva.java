package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.sun.xml.internal.ws.policy.privateutil.PolicyUtils.Collections;

import groovy.ui.SystemOutputInterceptor;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.ProvinciaDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerComunicazioneDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.DTO.VerTipoStrumentoDTO;
import it.portaleSTI.DTO.VerTipologiaStrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneVerComunicazioniBO;
import it.portaleSTI.bo.GestioneVerMisuraBO;
import it.portaleSTI.bo.GestioneVerStrumentiBO;

/**
 * Servlet implementation class ComunicazionePreventiva
 */
@WebServlet("/gestioneVerComunicazionePreventiva.do")
public class GestioneVerComunicazionePreventiva extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneVerComunicazionePreventiva() {
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
			
			if(action==null) {
				
				if(request.getSession().getAttribute("listaClientiAll")==null) 
				{
					request.getSession().setAttribute("listaClientiAll",GestioneAnagraficaRemotaBO.getListaClientiAll());
				}	
				
				if(request.getSession().getAttribute("listaSediAll")==null) 
				{				
						request.getSession().setAttribute("listaSediAll",GestioneAnagraficaRemotaBO.getListaSediAll());				
				}			
		
				List<ClienteDTO> listaClienti = (List<ClienteDTO>)request.getSession().getAttribute("lista_clienti");
				if(listaClienti==null) {
					listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(utente.getCompany().getId()));							
				}
				
				List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
									
				request.getSession().setAttribute("lista_clienti", listaClienti);				
				request.getSession().setAttribute("lista_sedi", listaSedi);

				Gson gson = new GsonBuilder().create();
				JsonArray listaCl = gson.toJsonTree(listaClienti).getAsJsonArray();
				
				request.getSession().setAttribute("listaCl", listaCl.toString().replace("\'", ""));
				
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneVerComunicazionePreventiva.jsp");
		  	    dispatcher.forward(request,response);	
				
			}
			else if(action.equals("lista_strumenti")) {
				
				String id_cliente = request.getParameter("id_cliente");
				String id_sede = request.getParameter("id_sede");
				
				ArrayList<VerStrumentoDTO> lista_strumenti = GestioneVerStrumentiBO.getStrumentiClienteSede(Integer.parseInt(id_cliente), Integer.parseInt(id_sede.split("_")[0]), session);
				ArrayList<VerTipoStrumentoDTO> lista_tipo_strumento = GestioneVerStrumentiBO.getListaTipoStrumento(session);
				ArrayList<VerTipologiaStrumentoDTO> lista_tipologie_strumento = GestioneVerStrumentiBO.getListaTipologieStrumento(session);
				
				request.getSession().setAttribute("lista_strumenti",lista_strumenti);
				request.getSession().setAttribute("lista_tipo_strumento",lista_tipo_strumento);
				request.getSession().setAttribute("lista_tipologie_strumento",lista_tipologie_strumento);	
				
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneVerComunicazionePreventivaSede.jsp");
		  	    dispatcher.forward(request,response);	
			}
			
			else if(action.equals("salva")) {
				
				ajax=true;
				String ids = request.getParameter("ids");
				
				String onlyIDs="";
				
				for (String id: ids.split(";")) 
				{
					onlyIDs=onlyIDs+id.split("_")[0]+";";
				}
				
				onlyIDs=onlyIDs.substring(0,onlyIDs.length()-1);
				
				System.out.println(ids+"\n");

				 File d = GestioneVerComunicazioniBO.creaFileComunicazionePreventiva(ids, session);
				
				if(d!=null) {
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "File XML creato correttamente!");
					myObj.addProperty("filename", d.getName());
					
					 VerComunicazioneDTO comunicazione = new VerComunicazioneDTO();
					 
					 comunicazione.setTipoComunicazione("P");
					 comunicazione.setDataComunicazione(new Date());
					 comunicazione.setFilename(d.getName());
					 comunicazione.setIdsStrumenti(onlyIDs);
					 comunicazione.setUtente(utente);
					  session.save(comunicazione);
				}else {
					myObj.addProperty("success", false);
					myObj.addProperty("messaggio", "Errore nella creazione del file!");
				}
				PrintWriter  out = response.getWriter();
				out.print(myObj);
							  
				session.getTransaction().commit();
				session.close();
			}
			else if(action.equals("lista")) {
				
				ArrayList<VerComunicazioneDTO> lista_comunicazioni = GestioneVerComunicazioniBO.getListaComunicazioni(session);
				
				request.getSession().setAttribute("lista_comunicazioni", lista_comunicazioni);
				
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaVerComunicazioni.jsp");
		  	    dispatcher.forward(request,response);	
				
			}
			else if(action.equals("dettaglio_strumenti")) {
				
				String ids = request.getParameter("ids");
				
				ArrayList<VerStrumentoDTO> lista_strumenti = new ArrayList<VerStrumentoDTO>();
				
				String[] id_strumenti = ids.split(";");
				
				for (String string : id_strumenti) {
					if(!string.equals("")) {
						VerStrumentoDTO strumento = GestioneVerStrumentiBO.getVerStrumentoFromId(Integer.parseInt(string), session); 
						if(strumento!=null) {
							lista_strumenti.add(strumento);	
						}						
					}
				}
				
				request.getSession().setAttribute("lista_strumenti", lista_strumenti);
				
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioVerStumentiComunicazione.jsp");
		  	    dispatcher.forward(request,response);
			}
			else if(action.equals("download")) {								
								
				String filename= request.getParameter("filename");
				
				String path = Costanti.PATH_FOLDER+"\\Comunicazioni\\"+filename;
				File file = new File(path);
				
				FileInputStream fileIn = new FileInputStream(file);
				 
				 response.setContentType("application/octet-stream");
				  
				 response.setHeader("Content-Disposition","attachment;filename="+ file.getName());
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    
				    
				    fileIn.close();
				    outp.flush();
				    outp.close();
				    session.close();
				
			}
			else if(action.equals("crea_comunicazione")) {
				
				String ids = request.getParameter("ids");
				
				String[] idMis=ids.split(";"); 
						
				ArrayList<VerMisuraDTO> listaMisure = new ArrayList<>();
				
				String onlyIDs="";
				
				for (int i = 0; i <idMis.length; i++) {
					
					VerMisuraDTO misura=GestioneVerMisuraBO.getMisuraFromId(Integer.parseInt(idMis[i]), session);
					listaMisure.add(misura);
					onlyIDs=onlyIDs+misura.getVerStrumento().getId()+";";
				}
				
				System.out.println(ids);
				
				 File d = GestioneVerComunicazioniBO.creaFileComunicazioneVerifica(listaMisure, session);
					
				 FileInputStream fileIn = new FileInputStream(d);
				 
				 VerComunicazioneDTO comunicazione = new VerComunicazioneDTO();
				 
				 comunicazione.setTipoComunicazione("C");
				 comunicazione.setDataComunicazione(new Date());
				 comunicazione.setFilename(d.getName());
				 comunicazione.setIdsStrumenti(onlyIDs.substring(0,onlyIDs.length()-1));
				 comunicazione.setUtente(utente);

				 
				 response.setContentType("application/octet-stream");
								 
				 response.setHeader("Content-Disposition","attachment;filename="+d.getName());
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				     }
				    				    
				    
				    fileIn.close();
			
				    outp.flush();
				    outp.close();
				
				    session.save(comunicazione);
				    session.getTransaction().commit();
				    session.close();
				    
			}
			
			else if(action.equals("esito_comunicazioni")) {
				
				ArrayList<ProvinciaDTO> lista_province = GestioneVerComunicazioniBO.getListaProvince(session);
				session.close();
				
				request.getSession().setAttribute("lista_province", lista_province);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/esitoVerComunicazione.jsp");
		  	    dispatcher.forward(request,response);
				
			}
			
			else if(action.equals("crea_file_esito_comunicazione")) {
				
				String provincia = request.getParameter("provincia");
				String dateFrom = request.getParameter("dateFrom");
				String dateTo = request.getParameter("dateTo");
				
				System.out.println(provincia+"\n");
				System.out.println(dateFrom+"\n");
				System.out.println(dateTo+"\n");
				
				
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
