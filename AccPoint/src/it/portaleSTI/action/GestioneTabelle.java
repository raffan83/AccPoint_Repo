package it.portaleSTI.action;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DTO.ColonnaDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;

/**
 * Servlet implementation class GestioneTabelle
 */
@WebServlet("/gestioneTabelle.do")
public class GestioneTabelle extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneTabelle() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		String action = request.getParameter("action");
		JsonObject myObj = new JsonObject();
		PrintWriter  out = response.getWriter();
		boolean ajax = false;
		try {
			if(action== null || action.equals("")) {
			ajax=false;
			
			Properties prop = new Properties();
			String propFileName = "config.properties";

			InputStream inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);

			prop.load(inputStream);
			String tab[] = prop.getProperty("TAB_VIEW").split(";");
			ArrayList<String> lista_tabelle = DirectMySqlDAO.getListaTabelle(tab);
			
			request.setAttribute("lista_tabelle",lista_tabelle);
	   	     
	   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneTabelleDB.jsp");
	   	     dispatcher.forward(request,response);
			
			}
			
			else if(action !=null && action.equals("mostra_tabella")) {
				ajax=false;
				String tabella = request.getParameter("tabella");
				
				ArrayList<ColonnaDTO> lista_colonne = DirectMySqlDAO.getListaColonne(tabella);
				
				ArrayList<ArrayList<String>> dati_tabella = DirectMySqlDAO.getDatiTabella(tabella, lista_colonne);
				//ArrayList<ColonnaDTO> lista_colonne_noPK = DirectMySqlDAO.getListaNoPK(tabella, lista_colonne);
				ArrayList<ColonnaDTO> lista_colonne_noK = DirectMySqlDAO.getListaNoK(tabella, lista_colonne);
				
				request.getSession().setAttribute("lista_colonne", lista_colonne);
				request.getSession().setAttribute("dati_tabella", dati_tabella);				
				request.getSession().setAttribute("lista_colonne_noK", lista_colonne_noK);
				request.getSession().setAttribute("tabella", tabella);
				
		   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/datiTabella.jsp");
		   	     dispatcher.forward(request,response);
			}
			
			else if(action!=null && action.equals("modifica")) {
				ajax=true;
				 response.setContentType("application/json");
				 
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
				
			    ArrayList<ColonnaDTO> lista_colonne = (ArrayList<ColonnaDTO>) request.getSession().getAttribute("lista_colonne_noK");
			    
				String index = request.getParameter("index");
				String azione = request.getParameter("azione");
				String tabella = (String) request.getSession().getAttribute("tabella");
				ArrayList<String> lista_valori= new ArrayList<String>();
				for(int i=0;i<Integer.parseInt(index);i++) {
					lista_valori.add(ret.get("colonna_"+i));
				   if(lista_colonne.get(i).getTipo_dato().toString().equals( "class java.lang.String")) {
					  if(lista_valori.get(i)!=null && !lista_valori.get(i).equals("")) {
							 lista_valori.set(i,ret.get("colonna_"+i));
						 }else {
								lista_valori.set(i, "");
							}
				  }
				  else {
					  if(lista_valori.get(i)!=null && !lista_valori.get(i).equals("")) {
							 lista_valori.set(i,ret.get("colonna_"+i));
						 }else {
								lista_valori.set(i, "null");
							}
				  }
					
				}
				if(azione.equals("modifica")) {
					DirectMySqlDAO.updateTabellaDB(tabella, lista_valori, lista_colonne);
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Modifica effettuata con successo!");
				}else {
					DirectMySqlDAO.nuovaRigaTabellaDB(tabella, lista_valori, lista_colonne);
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Inserimento effettuato con successo!");
				}
				
				
				
				out.print(myObj);
				
			}
			
			
		}catch(Exception e) {
			if(ajax) {
				e.printStackTrace();
				request.getSession().setAttribute("exception", e);
				myObj = STIException.getException(e);
				out.print(myObj);
			
			}else {
			e.printStackTrace();
	   	     request.setAttribute("error",STIException.callException(e));
	   	     
	   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	   	     dispatcher.forward(request,response);
			}
		}
		
		
	}

}
