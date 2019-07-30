package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerAccuratezzaDTO;
import it.portaleSTI.DTO.VerDecentramentoDTO;
import it.portaleSTI.DTO.VerLinearitaDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerMobilitaDTO;
import it.portaleSTI.DTO.VerRipetibilitaDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneVerInterventoBO;
import it.portaleSTI.bo.GestioneVerMisuraBO;

/**
 * Servlet implementation class GestioneVerMisura
 */
@WebServlet("/gestioneVerMisura.do")
public class GestioneVerMisura extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneVerMisura() {
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
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		
		String action = request.getParameter("action");
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
        response.setContentType("application/json");
		try {
			
		if(action!=null && action.equals("dettaglio")) {
			
			String id_misura = request.getParameter("id_misura");
			
			id_misura = Utility.decryptData(id_misura);
			
			VerMisuraDTO misura = GestioneVerMisuraBO.getMisuraFromId(Integer.parseInt(id_misura), session);
			
			ArrayList<VerRipetibilitaDTO> lista_ripetibilita = GestioneVerMisuraBO.getListaRipetibilita(Integer.parseInt(id_misura), session);
			ArrayList<VerDecentramentoDTO> lista_decentramento = GestioneVerMisuraBO.getListaDecentramento(Integer.parseInt(id_misura), session);
			ArrayList<VerLinearitaDTO> lista_linearita = GestioneVerMisuraBO.getListaLinearita(Integer.parseInt(id_misura), session);
			ArrayList<VerAccuratezzaDTO> lista_accuratezza = GestioneVerMisuraBO.getListaAccuratezza(Integer.parseInt(id_misura), session);
			ArrayList<VerMobilitaDTO> lista_mobilita = GestioneVerMisuraBO.getListaMobilita(Integer.parseInt(id_misura), session);
			
			ClienteDTO cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(misura.getVerStrumento().getId_cliente()));
			List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
			if(listaSedi== null) {
				listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
			}
			
			SedeDTO sede = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, misura.getVerStrumento().getId_sede(), misura.getVerStrumento().getId_cliente());
			
			ArrayList<String> checkList = null;
			String esitoCheck = "1";
			if(misura.getSeqRisposte()!=null) {
				checkList = new ArrayList<String>(Arrays.asList(misura.getSeqRisposte().split(";")));	
				if(checkList.contains("1")) {
					esitoCheck="0";
				}
			}
			boolean esito_globale = true;
			if(lista_ripetibilita!=null && lista_ripetibilita.size()>0) {
				if(lista_ripetibilita.get(0).getEsito().equals("NEGATIVO")) {
					esito_globale = false;
				}
			}
			if(lista_linearita!=null && lista_linearita.size()>0) {
				if(lista_linearita.get(0).getEsito().equals("NEGATIVO")) {
					esito_globale = false;
				}
			}
			if(lista_decentramento!=null && lista_decentramento.size()>0) {
				if(lista_decentramento.get(0).getEsito().equals("NEGATIVO")) {
					esito_globale = false;
				}
			}
			if(lista_accuratezza!=null && lista_accuratezza.size()>0) {
				if(lista_accuratezza.get(0).getEsito().equals("NEGATIVO")) {
					esito_globale = false;
				}
			}
			if(lista_mobilita!=null && lista_mobilita.size()>0) {
				if(lista_ripetibilita.get(0).getEsito().equals("NEGATIVO")) {
					esito_globale = false;
				}
			}
						
			request.getSession().setAttribute("lista_ripetibilita", lista_ripetibilita);
			request.getSession().setAttribute("lista_decentramento", lista_decentramento);
			request.getSession().setAttribute("lista_linearita", lista_linearita);
			request.getSession().setAttribute("lista_accuratezza", lista_accuratezza);
			request.getSession().setAttribute("lista_mobilita", lista_mobilita);
			request.getSession().setAttribute("cliente", cliente);		
			request.getSession().setAttribute("sede", sede);	
			request.getSession().setAttribute("misura", misura);
			request.getSession().setAttribute("checkList", checkList);
			request.getSession().setAttribute("esitoCheck", esitoCheck);
			request.getSession().setAttribute("esito_globale", esito_globale);
			
			
					
			session.close();
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioVerMisura.jsp");
	  	    dispatcher.forward(request,response);
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
