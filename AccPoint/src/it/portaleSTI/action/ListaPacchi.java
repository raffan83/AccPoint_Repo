package it.portaleSTI.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.MagAspettoDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.MagSpedizioniereDTO;
import it.portaleSTI.DTO.MagStatoLavorazioneDTO;
import it.portaleSTI.DTO.MagTipoDdtDTO;
import it.portaleSTI.DTO.MagTipoItemDTO;
import it.portaleSTI.DTO.MagTipoPortoDTO;
import it.portaleSTI.DTO.MagTipoTrasportoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneMagazzinoBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class ListaPacchi
 */
@WebServlet("/listaPacchi.do")
public class ListaPacchi extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaPacchi() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		
		int id_company= utente.getCompany().getId();

		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		try {
			
			ArrayList<MagPaccoDTO> lista_pacchi = GestioneMagazzinoBO.getListaPacchi(id_company, session);
			List<ClienteDTO> listaClienti = GestioneStrumentoBO.getListaClientiNew(String.valueOf(id_company));	
			List<SedeDTO> listaSedi = GestioneStrumentoBO.getListaSediNew();			
			ArrayList<MagTipoDdtDTO> tipo_ddt = GestioneMagazzinoBO.getListaTipoDDT(session);
			ArrayList<MagTipoPortoDTO> tipo_porto = GestioneMagazzinoBO.getListaTipoPorto(session);
			ArrayList<MagTipoTrasportoDTO> tipo_trasporto = GestioneMagazzinoBO.getListaTipoTrasporto(session); 
			ArrayList<MagSpedizioniereDTO> spedizionieri = GestioneMagazzinoBO.getListaSpedizionieri(session);
			ArrayList<MagAspettoDTO> aspetto = GestioneMagazzinoBO.getListaTipoAspetto(session);
			ArrayList<MagTipoItemDTO> tipo_item = GestioneMagazzinoBO.getListaTipoItem(session);
			ArrayList<MagStatoLavorazioneDTO> stato_lavorazione = GestioneMagazzinoBO.getListaStatoLavorazione(session);
			
			
			session.close();
			
			request.getSession().setAttribute("lista_pacchi",lista_pacchi);
			request.getSession().setAttribute("lista_clienti", listaClienti);
			request.getSession().setAttribute("lista_sedi", listaSedi);
			request.getSession().setAttribute("lista_tipo_ddt", tipo_ddt);
			request.getSession().setAttribute("lista_tipo_porto", tipo_porto);
			request.getSession().setAttribute("lista_tipo_trasporto", tipo_trasporto);
			request.getSession().setAttribute("lista_spedizionieri", spedizionieri);
			request.getSession().setAttribute("lista_aspetto", aspetto);
			request.getSession().setAttribute("lista_tipo_item", tipo_item);
			request.getSession().setAttribute("lista_tipo_aspetto", aspetto);
			request.getSession().setAttribute("lista_stato_lavorazione", stato_lavorazione);

			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listapacchi.jsp");
	     	dispatcher.forward(request,response);
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
