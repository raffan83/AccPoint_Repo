package it.portaleSTI.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.RilTipoRilievoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneRilieviBO;

/**
 * Servlet implementation class ListaRilieviDimensionali
 */
@WebServlet("/listaRilieviDimensionali.do")
public class ListaRilieviDimensionali extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaRilieviDimensionali() {
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
		
		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		
		String action = request.getParameter("action");
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
				List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
//				HashMap<Integer, String> listaClientiAll = (HashMap<Integer, String>)request.getSession().getAttribute("listaClientiAll");
//				HashMap<String, String> listaSediAll = (HashMap<String, String>)request.getSession().getAttribute("listaSediAll");
//				ArrayList<RilMisuraRilievoDTO> lista_rilievi = GestioneRilieviBO.getListaRilievi();
//				ArrayList<RilTipoRilievoDTO> lista_tipo_rilievo = GestioneRilieviBO.getListaTipoRilievo();					
//				ArrayList<CommessaDTO> lista_commesse = GestioneCommesseBO.getListaCommesse(utente.getCompany(), "", utente);
//				
//				for (RilMisuraRilievoDTO rilievo : lista_rilievi) {
//					if(rilievo.getId_cliente_util()!=0) {
//						rilievo.setNome_cliente_util(listaClientiAll.get(rilievo.getId_cliente_util()));
//					}
//					rilievo.setNome_sede_util(listaSediAll.get(rilievo.getId_cliente_util()+"_"+rilievo.getId_sede_util()));
//				}
//
//				request.getSession().setAttribute("lista_rilievi", lista_rilievi);
				request.getSession().setAttribute("lista_clienti", listaClienti);				
				request.getSession().setAttribute("lista_sedi", listaSedi);
//				request.getSession().setAttribute("lista_tipo_rilievo", lista_tipo_rilievo);
//				request.getSession().setAttribute("lista_commesse", lista_commesse);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaRilievi.jsp");
		  	    dispatcher.forward(request,response);	
			}
			else if(action.equals("filtra")) {
				
				String id_stato_lavorazione = request.getParameter("id_stato_lavorazione");
				String cliente_filtro = request.getParameter("cliente_filtro");	
				
				
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
				List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				HashMap<Integer, String> listaClientiAll = (HashMap<Integer, String>)request.getSession().getAttribute("listaClientiAll");
				HashMap<String, String> listaSediAll = (HashMap<String, String>)request.getSession().getAttribute("listaSediAll");
				//ArrayList<RilMisuraRilievoDTO> lista_rilievi = GestioneRilieviBO.getListaRilievi();
				ArrayList<RilMisuraRilievoDTO> lista_rilievi = 	null;
				if(cliente_filtro!=null && !cliente_filtro.equals("")) {
					 lista_rilievi = GestioneRilieviBO.getListaRilieviFiltrati(Integer.parseInt(id_stato_lavorazione), Integer.parseInt(cliente_filtro));
				}else {
					 lista_rilievi = GestioneRilieviBO.getListaRilieviInLavorazione(Integer.parseInt(id_stato_lavorazione));	
				}
				
				ArrayList<RilTipoRilievoDTO> lista_tipo_rilievo = GestioneRilieviBO.getListaTipoRilievo();					
				ArrayList<CommessaDTO> lista_commesse = GestioneCommesseBO.getListaCommesse(utente.getCompany(), "", utente);
				
				for (RilMisuraRilievoDTO rilievo : lista_rilievi) {
					if(rilievo.getId_cliente_util()!=0) {
						rilievo.setNome_cliente_util(listaClientiAll.get(rilievo.getId_cliente_util()));
					}
					rilievo.setNome_sede_util(listaSediAll.get(rilievo.getId_cliente_util()+"_"+rilievo.getId_sede_util()));
				}

				request.getSession().setAttribute("lista_rilievi", lista_rilievi);
				request.getSession().setAttribute("lista_clienti", listaClienti);				
				request.getSession().setAttribute("lista_sedi", listaSedi);
				request.getSession().setAttribute("lista_tipo_rilievo", lista_tipo_rilievo);
				request.getSession().setAttribute("lista_commesse", lista_commesse);
				
				if(id_stato_lavorazione.equals("1")) {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaRilieviInLavorazione.jsp");
		  	    	dispatcher.forward(request,response);	
				}
				else if(id_stato_lavorazione.equals("0")) {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaRilieviTutti.jsp");
		  	    	dispatcher.forward(request,response);	
				}
				else {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaRilieviLavorati.jsp");
		  	    	dispatcher.forward(request,response);	
				}
				
			}

		} catch (Exception e) {
			
			e.printStackTrace();
			 request.setAttribute("error",STIException.callException(e));
	   	     request.getSession().setAttribute("exception", e);
	   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	   	     dispatcher.forward(request,response);	
		}
	}

}
