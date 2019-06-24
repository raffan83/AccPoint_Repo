package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
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
import org.apache.poi.hssf.record.crypto.Biff8DecryptingStream;
import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.DTO.VerTipoStrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneUtenteBO;
import it.portaleSTI.bo.GestioneVerStrumentiBO;

/**
 * Servlet implementation class GestioneVerStrumenti
 */
@WebServlet("/gestioneVerStrumenti.do")
public class GestioneVerStrumenti extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneVerStrumenti() {
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
				
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneVerStrumenti.jsp");
		  	    dispatcher.forward(request,response);	
				
			}
			
			else if(action.equals("lista")) {
				
				String id_cliente = request.getParameter("id_cliente");
				String id_sede = request.getParameter("id_sede");
				
				ArrayList<VerStrumentoDTO> lista_strumenti = GestioneVerStrumentiBO.getStrumentiClienteSede(Integer.parseInt(id_cliente), Integer.parseInt(id_sede.split("_")[0]), session);
				ArrayList<VerTipoStrumentoDTO> lista_tipo_strumento = GestioneVerStrumentiBO.getListaTipoStrumento(session);
				
				request.getSession().setAttribute("lista_strumenti",lista_strumenti);
				request.getSession().setAttribute("lista_tipo_strumento",lista_tipo_strumento);	
				
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneVerStrumentiSede.jsp");
		  	    dispatcher.forward(request,response);	
			}
			else if(action.equals("nuovo")) {				

				ajax=true;
				PrintWriter out = response.getWriter();
				List<FileItem> items = null;
	            if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

	            		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
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
				
				String cliente = ret.get("id_cliente");
				String sede = ret.get("id_sede");
				String denominazione = ret.get("denominazione");				
				String costruttore = ret.get("costruttore");
				String modello = ret.get("modello");
				String matricola = ret.get("matricola");
				String classe = ret.get("classe");
				String tipo_ver_strumento = ret.get("tipo_ver_strumento");
				String um = ret.get("um");
				String data_ultima_verifica = ret.get("data_ultima_verifica");
				String data_prossima_verifica = ret.get("data_prossima_verifica");
				String portata_min_c1 = ret.get("portata_min_c1");
				String portata_max_c1 = ret.get("portata_max_c1");
				String div_ver_c1 = ret.get("div_ver_c1");
				String div_rel_c1 = ret.get("div_rel_c1");
				String numero_div_c1 = ret.get("numero_div_c1");
				String portata_min_c2 = ret.get("portata_min_c2");
				String portata_max_c2 = ret.get("portata_max_c2");
				String div_ver_c2 = ret.get("div_ver_c2");
				String div_rel_c2 = ret.get("div_rel_c2");
				String numero_div_c2 = ret.get("numero_div_c2");
				String portata_min_c3 = ret.get("portata_min_c3");
				String portata_max_c3 = ret.get("portata_max_c3");
				String div_ver_c3 = ret.get("div_ver_c3");
				String div_rel_c3 = ret.get("div_rel_c3");
				String numero_div_c3 = ret.get("numero_div_c3");
				
				VerStrumentoDTO strumento = new VerStrumentoDTO();
				
				strumento.setId_cliente(Integer.parseInt(cliente));
				strumento.setId_sede(Integer.parseInt(sede.split("_")[0]));
				strumento.setCostruttore(costruttore);
				SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				strumento.setData_prossima_verifica(sdf.parse(data_prossima_verifica));
				strumento.setData_ultima_verifica(sdf.parse(data_ultima_verifica));
				strumento.setDenominazione(denominazione);				
				strumento.setMatricola(matricola);
				strumento.setModello(modello);
				strumento.setClasse(Integer.parseInt(classe));
				strumento.setUm(um);
				strumento.setTipo(new VerTipoStrumentoDTO(Integer.parseInt(tipo_ver_strumento),""));
				strumento.setDiv_rel_C1(new BigDecimal(div_rel_c1));
				strumento.setDiv_ver_C1(new BigDecimal(div_ver_c1));
				strumento.setNumero_div_C1(new BigDecimal(numero_div_c1));
				strumento.setPortata_max_C1(new BigDecimal(portata_max_c1));
				strumento.setPortata_min_C1(new BigDecimal(portata_min_c1));
				
				if(!tipo_ver_strumento.equals("1")) {
					strumento.setDiv_rel_C2(new BigDecimal(div_rel_c2));
					strumento.setDiv_ver_C2(new BigDecimal(div_ver_c2));
					strumento.setNumero_div_C2(new BigDecimal(numero_div_c2));
					strumento.setPortata_max_C2(new BigDecimal(portata_max_c2));
					strumento.setPortata_min_C2(new BigDecimal(portata_min_c2));
					strumento.setDiv_rel_C3(new BigDecimal(div_rel_c3));
					strumento.setDiv_ver_C3(new BigDecimal(div_ver_c3));
					strumento.setNumero_div_C3(new BigDecimal(numero_div_c3));
					strumento.setPortata_max_C3(new BigDecimal(portata_max_c3));
					strumento.setPortata_min_C3(new BigDecimal(portata_min_c3));
				}else {
					strumento.setDiv_rel_C2(new BigDecimal(0));
					strumento.setDiv_ver_C2(new BigDecimal(0));
					strumento.setNumero_div_C2(new BigDecimal(0));
					strumento.setPortata_max_C2(new BigDecimal(0));
					strumento.setPortata_min_C2(new BigDecimal(0));
					strumento.setDiv_rel_C3(new BigDecimal(0));
					strumento.setDiv_ver_C3(new BigDecimal(0));
					strumento.setNumero_div_C3(new BigDecimal(0));
					strumento.setPortata_max_C3(new BigDecimal(0));
					strumento.setPortata_min_C3(new BigDecimal(0));
				}

				session.save(strumento);
								
				session.getTransaction().commit();
				
				session.close();
				myObj.addProperty("success", true);				
				myObj.addProperty("messaggio", "Strumento inserito con successo!");
				out.print(myObj);
				
				
			}
			else if(action.equals("modifica")) {
				
				ajax=true;
				PrintWriter out = response.getWriter();
				List<FileItem> items = null;
	            if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

	            		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
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
				
		        String id_strumento = ret.get("id_strumento");
				String cliente = ret.get("cliente_mod");
				String sede = ret.get("sede_mod");
				String denominazione = ret.get("denominazione_mod");				
				String costruttore = ret.get("costruttore_mod");
				String modello = ret.get("modello_mod");
				String matricola = ret.get("matricola_mod");
				String classe = ret.get("classe_mod");
				String tipo_ver_strumento = ret.get("tipo_ver_strumento_mod");
				String um = ret.get("um_mod");
				String data_ultima_verifica = ret.get("data_ultima_verifica_mod");
				String data_prossima_verifica = ret.get("data_prossima_verifica_mod");
				String portata_min_c1 = ret.get("portata_min_c1_mod");
				String portata_max_c1 = ret.get("portata_max_c1_mod");
				String div_ver_c1 = ret.get("div_ver_c1_mod");
				String div_rel_c1 = ret.get("div_rel_c1_mod");
				String numero_div_c1 = ret.get("numero_div_c1_mod");
				String portata_min_c2 = ret.get("portata_min_c2_mod");
				String portata_max_c2 = ret.get("portata_max_c2_mod");
				String div_ver_c2 = ret.get("div_ver_c2_mod");
				String div_rel_c2 = ret.get("div_rel_c2_mod");
				String numero_div_c2 = ret.get("numero_div_c2_mod");
				String portata_min_c3 = ret.get("portata_min_c3_mod");
				String portata_max_c3 = ret.get("portata_max_c3_mod");
				String div_ver_c3 = ret.get("div_ver_c3_mod");
				String div_rel_c3 = ret.get("div_rel_c3_mod");
				String numero_div_c3 = ret.get("numero_div_c3_mod");
				
				VerStrumentoDTO strumento = GestioneVerStrumentiBO.getVerStrumentoFromId(Integer.parseInt(id_strumento), session);
				
				strumento.setId_cliente(Integer.parseInt(cliente));
				strumento.setId_sede(Integer.parseInt(sede.split("_")[0]));
				strumento.setCostruttore(costruttore);
				SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				strumento.setData_prossima_verifica(sdf.parse(data_prossima_verifica));
				strumento.setData_ultima_verifica(sdf.parse(data_ultima_verifica));
				strumento.setDenominazione(denominazione);				
				strumento.setMatricola(matricola);
				strumento.setModello(modello);
				strumento.setClasse(Integer.parseInt(classe));
				strumento.setUm(um);
				strumento.setTipo(new VerTipoStrumentoDTO(Integer.parseInt(tipo_ver_strumento),""));
				strumento.setDiv_rel_C1(new BigDecimal(div_rel_c1));
				strumento.setDiv_ver_C1(new BigDecimal(div_ver_c1));
				strumento.setNumero_div_C1(new BigDecimal(numero_div_c1));
				strumento.setPortata_max_C1(new BigDecimal(portata_max_c1));
				strumento.setPortata_min_C1(new BigDecimal(portata_min_c1));
				
				if(!tipo_ver_strumento.equals("1")) {
					strumento.setDiv_rel_C2(new BigDecimal(div_rel_c2));
					strumento.setDiv_ver_C2(new BigDecimal(div_ver_c2));
					strumento.setNumero_div_C2(new BigDecimal(numero_div_c2));
					strumento.setPortata_max_C2(new BigDecimal(portata_max_c2));
					strumento.setPortata_min_C2(new BigDecimal(portata_min_c2));
					strumento.setDiv_rel_C3(new BigDecimal(div_rel_c3));
					strumento.setDiv_ver_C3(new BigDecimal(div_ver_c3));
					strumento.setNumero_div_C3(new BigDecimal(numero_div_c3));
					strumento.setPortata_max_C3(new BigDecimal(portata_max_c3));
					strumento.setPortata_min_C3(new BigDecimal(portata_min_c3));
				}else {
					strumento.setDiv_rel_C2(new BigDecimal(0));
					strumento.setDiv_ver_C2(new BigDecimal(0));
					strumento.setNumero_div_C2(new BigDecimal(0));
					strumento.setPortata_max_C2(new BigDecimal(0));
					strumento.setPortata_min_C2(new BigDecimal(0));
					strumento.setDiv_rel_C3(new BigDecimal(0));
					strumento.setDiv_ver_C3(new BigDecimal(0));
					strumento.setNumero_div_C3(new BigDecimal(0));
					strumento.setPortata_max_C3(new BigDecimal(0));
					strumento.setPortata_min_C3(new BigDecimal(0));
				}

				session.update(strumento);
								
				session.getTransaction().commit();
				
				session.close();
				myObj.addProperty("success", true);				
				myObj.addProperty("messaggio", "Strumento modificato con successo!");
				out.print(myObj);
				
				
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
