package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.Month;
import java.time.ZoneId;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneUtenteDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AmScAttivitaDTO;
import it.portaleSTI.DTO.AmScAttrezzaturaDTO;
import it.portaleSTI.DTO.AmScScadenzarioDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAM_ScadenzarioBO;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;

/**
 * Servlet implementation class AmSc_gestioneScadenzario
 */
@WebServlet("/amScGestioneScadenzario.do")
public class AmSc_gestioneScadenzario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AmSc_gestioneScadenzario() {
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
    			
    			if(action == null) {
    				
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
    							
    				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/am_sc_scadenzario.jsp");
    		     	dispatcher.forward(request,response);
    			}

    			else if(action.equals("lista")) {
    				
    				String idCliente = request.getParameter("id_cliente");
    				String idSede = request.getParameter("id_sede");
    				String anno = request.getParameter("anno");
    				
    				if(anno == null) {
    					anno = ""+Calendar.getInstance().get(Calendar.YEAR);
    				}
    				
    				
    				
    				ArrayList<AmScAttrezzaturaDTO> lista_attrezzature = GestioneAM_ScadenzarioBO.getListaAttrezzature(Integer.parseInt(idCliente), Integer.parseInt(idSede.split("_")[0]),session);
    				ArrayList<AmScScadenzarioDTO> lista_scadenze = GestioneAM_ScadenzarioBO.getListaScadenze(Integer.parseInt(idCliente), Integer.parseInt(idSede.split("_")[0]),Integer.parseInt(anno), session);
    				ArrayList<AmScAttivitaDTO> lista_attivita = GestioneAM_ScadenzarioBO.getListaAttivita(session);
    				
    				Map<Integer, Map<String, Integer>> conteggiPerAttrezzatura = new HashMap<>();

    				for (AmScScadenzarioDTO scadenza : lista_scadenze) {
    				    AmScAttrezzaturaDTO attrezzatura = scadenza.getAttrezzatura();
    				    Integer idAttrezzatura = attrezzatura.getId();
    				    java.sql.Date data = scadenza.getDataProssimaAttivita();

    				    if (data != null) {
    				        LocalDate localDate = data.toLocalDate(); // ✅ corretto
    				        String mese = localDate.getMonth().getDisplayName(TextStyle.FULL, Locale.ITALIAN).toUpperCase();

    				        // Recupera o crea la mappa dei conteggi per questa attrezzatura
    				        Map<String, Integer> mappaMesi = conteggiPerAttrezzatura.computeIfAbsent(idAttrezzatura, k -> new HashMap<>());

    				        // Incrementa il contatore per il mese
    				        mappaMesi.put(mese, mappaMesi.getOrDefault(mese, 0) + 1);
    				    }
    				}

    				  
    				  Set<Integer> attrezzatureAggiornate = new HashSet<>();

    				    for (AmScScadenzarioDTO scadenza : lista_scadenze) {
    				        AmScAttrezzaturaDTO attrezzatura = scadenza.getAttrezzatura();
    				        Integer idAttrezzatura = attrezzatura.getId();

    				        if (!attrezzatureAggiornate.contains(idAttrezzatura)) {
    				            Map<String, Integer> scadenzeMese = conteggiPerAttrezzatura.get(idAttrezzatura);
    				            if (scadenzeMese != null) {
    				                attrezzatura.setMapScadenze(new HashMap<>(scadenzeMese));
    				            }
    				            attrezzatureAggiornate.add(idAttrezzatura); // per non riscrivere più volte
    				        }
    				    }
    				
    				request.getSession().setAttribute("lista_attrezzature", lista_attrezzature);
    				request.getSession().setAttribute("lista_attivita", lista_attivita);
    				
    				
    				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/am_sc_scadenzario_cliente_sede.jsp");
    		     	dispatcher.forward(request,response);
    			}else if(action.equals("lista_scadenze_mese")) {
    				
    				String id_attrezzatura = request.getParameter("id_attrezzatura");
    				String mese = request.getParameter("mese");
    				String anno = request.getParameter("anno");
    				
    				if(anno == null) {
    					anno = ""+Calendar.getInstance().get(Calendar.YEAR);
    				}
    				
    		
    				
    				ArrayList<AmScScadenzarioDTO> scadenze = GestioneAM_ScadenzarioBO.getListaScadenzeAttrezzatura(Integer.parseInt(id_attrezzatura), Integer.parseInt(mese), Integer.parseInt(anno), session);
    				
    				request.getSession().setAttribute("scadenze", scadenze);
    				
    				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/am_sc_lista_scadenze_attrezzatura.jsp");
    		     	dispatcher.forward(request,response);
    			}
    			
    			session.getTransaction().commit();
    			session.close();
    				
    			} 
    			catch(Exception e)
    	    	{
    				e.printStackTrace();
    				session.getTransaction().rollback();
    	        	session.close();
    				if(ajax) {
    					
    					PrintWriter out = response.getWriter();
    					
    		        	
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
