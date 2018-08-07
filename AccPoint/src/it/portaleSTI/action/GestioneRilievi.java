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

import org.apache.axis2.json.JSONBadgerfishOMBuilder;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.RilImprontaDTO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.RilPuntoQuotaDTO;
import it.portaleSTI.DTO.RilQuotaDTO;
import it.portaleSTI.DTO.RilQuotaFunzionaleDTO;
import it.portaleSTI.DTO.RilSimboloDTO;
import it.portaleSTI.DTO.RilTipoRilievoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneRilieviBO;
import sun.security.krb5.internal.tools.Klist;

/**
 * Servlet implementation class GestioneRilievi
 */
@WebServlet("/gestioneRilievi.do")
public class GestioneRilievi extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneRilievi() {
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
		PrintWriter out = response.getWriter();
		JsonObject myObj = new JsonObject();

        response.setContentType("application/json");
		try {
			if(action.equals("nuovo")) {
				
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
				
				String cliente = ret.get("cliente");
				String sede = ret.get("sede");
				String commessa = ret.get("commessa");
				String tipo_rilievo = ret.get("tipo_rilievo");
				String data_rilievo = ret.get("data_rilievo");
				
				RilMisuraRilievoDTO misura_rilievo = new RilMisuraRilievoDTO();
				
				misura_rilievo.setId_cliente_util(Integer.parseInt(cliente));
				misura_rilievo.setId_sede_util(Integer.parseInt(sede.split("_")[0]));
				misura_rilievo.setTipo_rilievo(new RilTipoRilievoDTO(Integer.parseInt(tipo_rilievo), ""));
				misura_rilievo.setCommessa(commessa);
				misura_rilievo.setUtente(utente);
				
				if(data_rilievo!=null && !data_rilievo.equals("")) {
					DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
					Date date = format.parse(data_rilievo);
				}
				GestioneRilieviBO.saveRilievo(misura_rilievo, session);				
				
				session.getTransaction().commit();
				
				session.close();
				myObj.addProperty("success", true);				
				myObj.addProperty("messaggio", "Misura Rilievo inserita con successo!");
				out.print(myObj);
			}
			else if(action.equals("modifica")) {
				
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
				
				String cliente = ret.get("mod_cliente");
				String sede = ret.get("mod_sede");
				String commessa = ret.get("mod_commessa");
				String tipo_rilievo = ret.get("mod_tipo_rilievo");
				String data_rilievo = ret.get("mod_data_rilievo");
				String id_rilievo = ret.get("id_rilievo");
				
				
				RilMisuraRilievoDTO misura_rilievo = GestioneRilieviBO.getMisuraRilieviFromId(Integer.parseInt(id_rilievo), session);
				
				misura_rilievo.setId_cliente_util(Integer.parseInt(cliente));
				misura_rilievo.setId_sede_util(Integer.parseInt(sede.split("_")[0]));
				misura_rilievo.setTipo_rilievo(new RilTipoRilievoDTO(Integer.parseInt(tipo_rilievo), ""));
				misura_rilievo.setCommessa(commessa);
				misura_rilievo.setUtente(utente);
				
				if(data_rilievo!=null && !data_rilievo.equals("")) {
					DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
					Date date = format.parse(data_rilievo);
				}
				GestioneRilieviBO.update(misura_rilievo, session);				
				
				session.getTransaction().commit();
				
				session.close();
				myObj.addProperty("success", true);				
				myObj.addProperty("messaggio", "Misura Rilievo modificata con successo!");
				out.print(myObj);
				
			}
			
			else if(action.equals("dettaglio")) {
				
				String id_rilievo = request.getParameter("id_rilievo");
				
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(Integer.parseInt(id_rilievo), session);				
				ArrayList<RilImprontaDTO> lista_impronte = GestioneRilieviBO.getListaImprontePerMisura(Integer.parseInt(id_rilievo));
				ArrayList<RilSimboloDTO> lista_simboli = GestioneRilieviBO.getListaSimboli();
				ArrayList<RilQuotaFunzionaleDTO> lista_quote_funzionali = GestioneRilieviBO.getListaQuoteFunzionali();				
				
				session.close();
				request.getSession().setAttribute("rilievo", rilievo);
				request.getSession().setAttribute("lista_impronte", lista_impronte);
				request.getSession().setAttribute("lista_simboli", lista_simboli);
				request.getSession().setAttribute("lista_quote_funzionali", lista_quote_funzionali);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioRilievo.jsp");
		  	    dispatcher.forward(request,response);	
		  	    
		  	    
			}
			else if(action.equals("dettaglio_impronta")) {
				
				String id_impronta = request.getParameter("id_impronta");
				
				ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(Integer.parseInt(id_impronta));
//				ArrayList<ArrayList<RilPuntoQuotaDTO>> lista_punti_quote = new ArrayList<ArrayList<RilPuntoQuotaDTO>>();
				ArrayList<RilPuntoQuotaDTO> lista_punti_quote = new ArrayList<RilPuntoQuotaDTO>();
				for (RilQuotaDTO quota : lista_quote) {
					
					ArrayList<RilPuntoQuotaDTO> lista_punti_quota = GestioneRilieviBO.getPuntoQuotiFromQuota(quota.getId());
					for (int i = 0; i<lista_punti_quota.size();i++) {
						lista_punti_quote.add(lista_punti_quota.get(i));
					}
				}
				
				request.getSession().setAttribute("lista_punti_quote", lista_punti_quote);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioPuntiQuota.jsp");
		  	    dispatcher.forward(request,response);
			
				
			}
			


		} catch (Exception e) {
			
			e.printStackTrace();
        	session.getTransaction().rollback();
        	session.close();
        	request.getSession().setAttribute("exception", e);
        	myObj = STIException.getException(e);
        	out.print(myObj);
		}
	}

}
