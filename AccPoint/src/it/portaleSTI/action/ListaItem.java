package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AccessorioDTO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.MagAccessorioDTO;
import it.portaleSTI.DTO.MagAspettoDTO;
import it.portaleSTI.DTO.MagAttivitaPaccoDTO;
import it.portaleSTI.DTO.MagCategoriaDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.MagSpedizioniereDTO;
import it.portaleSTI.DTO.MagStatoLavorazioneDTO;
import it.portaleSTI.DTO.MagTipoDdtDTO;
import it.portaleSTI.DTO.MagTipoItemDTO;
import it.portaleSTI.DTO.MagTipoPortoDTO;
import it.portaleSTI.DTO.MagTipoTrasportoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAccessorioBO;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneMagazzinoBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class ListaItem
 */
@WebServlet("/listaItem.do")
public class ListaItem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaItem() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		try {
		String tipo_item = request.getParameter("tipo_item");
		String action = request.getParameter("action");
		
	
		if(action!=null && action.equals("new")) {
			
			JsonObject myObj = new JsonObject();
			PrintWriter  out = response.getWriter();
			String categoria = request.getParameter("categoria");
			String descrizione = request.getParameter("descrizione");
			String quantita = request.getParameter("quantita");
			
			MagAccessorioDTO generico= new MagAccessorioDTO();
			
			generico.setCategoria(new MagCategoriaDTO(Integer.parseInt(categoria),""));
			generico.setDescrizione(descrizione);
			generico.setQuantita_fisica(Integer.parseInt(quantita));
			
			GestioneMagazzinoBO.saveGenerico(generico, session);
			
			session.getTransaction().commit();
			session.close();
			
			myObj.addProperty("success", true);
			myObj.addProperty("messaggio", "Generico inserito correttamente!");
		
		out.print(myObj);
		}
		
		
		
		if(tipo_item!=null && tipo_item.equals("1")) {
			
			String id_cliente=request.getParameter("id_cliente");
			String id_sede = request.getParameter("id_sede");
			
			String[] sede= id_sede.split("_");
			String[] cliente= id_cliente.split("_");
				ArrayList<StrumentoDTO> lista_strumenti = (ArrayList<StrumentoDTO>) GestioneStrumentoBO.getListaStrumentiPerSedi(sede[0], id_cliente);
				
				ArrayList<TipoStrumentoDTO> listaTipoStrumento = GestioneTLDAO.getListaTipoStrumento();
				ArrayList<TipoRapportoDTO> listaTipoRapporto = GestioneTLDAO.getListaTipoRapporto();
				ArrayList<StatoStrumentoDTO> listaStatoStrumento = GestioneTLDAO.getListaStatoStrumento();
				ArrayList<LuogoVerificaDTO> listaLuogoVerifica = GestioneTLDAO.getListaLuogoVerifica();
				ArrayList<ClassificazioneDTO> listaClassificazione = GestioneTLDAO.getListaClassificazione();
				
				
		        request.getSession().setAttribute("listaTipoStrumento",listaTipoStrumento);
		        request.getSession().setAttribute("listaStatoStrumento",listaStatoStrumento);
		        request.getSession().setAttribute("listaTipoRapporto",listaTipoRapporto);
		        request.getSession().setAttribute("listaLuogoVerifica",listaLuogoVerifica);
		        request.getSession().setAttribute("listaClassificazione",listaClassificazione);
			
			request.getSession().setAttribute("lista_strumenti", lista_strumenti);
			request.getSession().setAttribute("id_Cliente", cliente[0]);
			request.getSession().setAttribute("id_Sede", sede[0]);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaItemStrumenti.jsp");
		     dispatcher.forward(request,response);
		     
		     
		}
		
		else if(tipo_item!=null && tipo_item.equals("2")) {
			
			
			CompanyDTO cmp=(CompanyDTO)request.getSession().getAttribute("usrCompany");
			ArrayList<AccessorioDTO> lista_accessori =  (ArrayList<AccessorioDTO>) GestioneAccessorioBO.getListaAccessori(cmp,session);
			session.close();
			request.getSession().setAttribute("lista_accessori", lista_accessori);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaItemAccessori.jsp");
		     dispatcher.forward(request,response);
			
		}
		
		else if(tipo_item!=null && tipo_item.equals("3")) {
			

			ArrayList<MagAccessorioDTO> lista_generici =   GestioneMagazzinoBO.getListaGenerici(session);
			ArrayList<MagCategoriaDTO> categoria_generico = GestioneMagazzinoBO.getListaCategorie(session);
 			
			request.getSession().setAttribute("lista_generici", lista_generici);
			request.getSession().setAttribute("categoria_generico", categoria_generico);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaItemGenerici.jsp");
		     dispatcher.forward(request,response);
			
		}
		
		else if(action.equals("lista")) {
			
			UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
			
			int id_company= utente.getCompany().getId();
			
			ArrayList<MagPaccoDTO> lista_pacchi = GestioneMagazzinoBO.getListaPacchi(id_company, session);
			List<ClienteDTO> listaClienti = GestioneStrumentoBO.getListaClientiNew(String.valueOf(id_company));	
			List<ClienteDTO> listaFornitori = GestioneStrumentoBO.getListaFornitori(String.valueOf(id_company));
			List<SedeDTO> listaSedi = GestioneStrumentoBO.getListaSediNew();			
			ArrayList<MagTipoDdtDTO> tipo_ddt = GestioneMagazzinoBO.getListaTipoDDT(session);
			ArrayList<MagTipoPortoDTO> tipo_porto = GestioneMagazzinoBO.getListaTipoPorto(session);
			ArrayList<MagTipoTrasportoDTO> tipo_trasporto = GestioneMagazzinoBO.getListaTipoTrasporto(session); 
			ArrayList<MagAspettoDTO> aspetto = GestioneMagazzinoBO.getListaTipoAspetto(session);
			ArrayList<MagTipoItemDTO> lista_tipo_item = GestioneMagazzinoBO.getListaTipoItem(session);
			ArrayList<MagStatoLavorazioneDTO> stato_lavorazione = GestioneMagazzinoBO.getListaStatoLavorazione(session);
			ArrayList<CommessaDTO> lista_commesse = GestioneCommesseBO.getListaCommesse(utente.getCompany(), "", utente);
			//ArrayList<MagAttivitaPaccoDTO> lista_attivita_pacco = GestioneMagazzinoBO.getListaAttivitaPacco(session);
			ArrayList<MagItemPaccoDTO> lista_item_pacco = GestioneMagazzinoBO.getListaItemPacco(session);
			
			session.close();
			
			request.getSession().setAttribute("lista_pacchi",lista_pacchi);
			request.getSession().setAttribute("lista_clienti", listaClienti);
			request.getSession().setAttribute("lista_fornitori", listaFornitori);
			request.getSession().setAttribute("lista_sedi", listaSedi);
			request.getSession().setAttribute("lista_tipo_ddt", tipo_ddt);
			request.getSession().setAttribute("lista_tipo_porto", tipo_porto);
			request.getSession().setAttribute("lista_tipo_trasporto", tipo_trasporto);
			request.getSession().setAttribute("lista_aspetto", aspetto);
			request.getSession().setAttribute("lista_tipo_item", lista_tipo_item);
			request.getSession().setAttribute("lista_tipo_aspetto", aspetto);
			request.getSession().setAttribute("lista_stato_lavorazione", stato_lavorazione);
			request.getSession().setAttribute("lista_commesse", lista_commesse);
			//request.getSession().setAttribute("lista_attivita_pacco", lista_attivita_pacco);
			Gson gson = new Gson();
    		String item_pacco_json = gson.toJson(lista_item_pacco);
    		
			request.getSession().setAttribute("lista_item_pacco", lista_item_pacco);
			request.getSession().setAttribute("item_pacco_json", item_pacco_json);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaItemMagazzino.jsp");
		     dispatcher.forward(request,response);
			
			
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
