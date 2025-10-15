package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AMCampioneDTO;
import it.portaleSTI.DTO.AMInterventoDTO;
import it.portaleSTI.DTO.AMOggettoProvaDTO;
import it.portaleSTI.DTO.AMOggettoProvaZonaRifDTO;
import it.portaleSTI.DTO.AMOperatoreDTO;
import it.portaleSTI.DTO.AMProvaDTO;
import it.portaleSTI.DTO.AMRapportoDTO;
import it.portaleSTI.DTO.AMTipoProvaDTO;
import it.portaleSTI.DTO.ArticoloMilestoneDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.OffOffertaArticoloDTO;
import it.portaleSTI.DTO.OffOffertaDTO;
import it.portaleSTI.DTO.OffOffertaFotoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAM_BO;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneVerInterventoBO;

/**
 * Servlet implementation class GestioneVerOfferte
 */
@WebServlet("/gestioneVerOfferte.do")
public class GestioneVerOfferte extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(GestioneVerOfferte.class);
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneVerOfferte() {
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
			
			
			logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo());
			
			
			if(action!=null && action.equals("lista_offerte")) {
				
				ArrayList<OffOffertaDTO> lista_offerte = GestioneVerInterventoBO.getListaOfferte(utente, session);
				ArrayList<ClienteDTO> lista_clienti = GestioneAnagraficaRemotaBO.getListaClientiOfferte(utente.getCodice_agente(), session);
				ArrayList<ArticoloMilestoneDTO> lista_articoli = GestioneAnagraficaRemotaBO.getListaArticoliAgente(utente.getCodice_agente(), session);
				
				List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
									
						
				request.getSession().setAttribute("lista_sedi", listaSedi);
				request.getSession().setAttribute("lista_articoli", lista_articoli);
				request.getSession().setAttribute("non_associate_encrypt", Utility.encryptData("0"));
				request.getSession().setAttribute("lista_clienti", lista_clienti);
				request.getSession().setAttribute("lista_offerte", lista_offerte);
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaVerOfferte.jsp");
		  	    dispatcher.forward(request,response);
				
		  		
				
			}
			else if(action!=null && action.equals("nuova_offerta")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		       
			
				
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		        
		        ArrayList<FileItem> listaItems = new ArrayList<FileItem> ();		       
		        ArrayList<String> filenames = new ArrayList<String> ();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	            		 if(item.getFieldName().equals("fileupload_img")) {
	            			 listaItems.add(item);
	            			 filenames.add(item.getName());
	            			 
	            		 }
	                     	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
				String id_cliente = ret.get("cliente");
				String id_sede = ret.get("sede");
				String id_articoli= ret.get("id_articoli");
				
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				
				List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				 
				OffOffertaDTO offerta = new OffOffertaDTO();	
				
				id_cliente = Utility.decryptData(id_cliente);
				id_sede = Utility.decryptData(id_sede.split("_")[0]);
				
				offerta.setId_cliente(Integer.parseInt(id_cliente));
				offerta.setId_sede(Integer.parseInt(id_sede));
				
				ClienteDTO cl = GestioneAnagraficaRemotaBO.getClienteById(id_cliente);
				
				offerta.setNome_cliente(cl.getNome());
				SedeDTO sd =null;
				if(!id_sede.equals("0")) {
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(id_sede.split("_")[0]), Integer.parseInt(id_cliente));
					offerta.setNome_sede(sd.getDescrizione() + " - "+sd.getIndirizzo());
				}else {
					offerta.setNome_sede("Non associate");
				}
				
				offerta.setUtente(utente.getNominativo());
				offerta.setData_offerta(new Date());
				
				session.save(offerta);
				
				Double importo_tot = 0.0;
				
				for (int i = 0; i < id_articoli.split(";").length; i++) {
					OffOffertaArticoloDTO offerta_articolo = new OffOffertaArticoloDTO();
					offerta_articolo.setOfferta(offerta);
					ArticoloMilestoneDTO articolo = GestioneAnagraficaRemotaBO.getArticoloAgenteFromId(id_articoli.split(";")[i].split(",")[0]);
					offerta_articolo.setArticolo(articolo.getID_ANAART());
					offerta_articolo.setImporto(articolo.getImporto());
					offerta_articolo.setQuantita(Double.parseDouble(id_articoli.split(";")[i].split(",")[1]));
					session.save(offerta_articolo);
					
					importo_tot += offerta_articolo.getQuantita() * offerta_articolo.getImporto();
				}
				
				offerta.setImporto(importo_tot);
				session.update(offerta);
				
				for (int i = 0; i < listaItems.size(); i++) {
					
					
					Utility.saveFile(listaItems.get(i), Costanti.PATH_FOLDER+"\\OfferteCalver\\"+offerta.getId()+"\\immagini", filenames.get(i));
					OffOffertaFotoDTO foto = new OffOffertaFotoDTO();
					foto.setId_offerta(offerta.getId());
					foto.setNome_file(filenames.get(i));
					session.save(foto);
				}
				
				PrintWriter  out = response.getWriter();

						
	
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Offerta salvata con successo!");
					
			   out.print(myObj);
					
				
				
			}
			
			else if(action.equals("dettaglio_offerta")) {
				
				String id = request.getParameter("id");
				
				OffOffertaDTO offerta = (OffOffertaDTO) session.get(OffOffertaDTO.class, Integer.parseInt(id));
				
				ArrayList<OffOffertaArticoloDTO> lista_articoli = GestioneVerInterventoBO.getListaOfferteArticoli(offerta.getId(),session);
				for (OffOffertaArticoloDTO off : lista_articoli) {
					off.setArticoloObj(GestioneAnagraficaRemotaBO.getArticoloAgenteFromId(off.getArticolo()));
				}
				
				
				PrintWriter  out = response.getWriter();
				Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
				myObj.addProperty("success", true);
				myObj.add("offerta", g.toJsonTree(offerta));
				myObj.add("lista_articoli", g.toJsonTree(lista_articoli));
					
			   out.print(myObj);
				
			}
			
			session.getTransaction().commit();
			session.close();
			
			
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
