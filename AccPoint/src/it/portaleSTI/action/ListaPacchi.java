package it.portaleSTI.action;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneInterventoBO;
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
			
			session.close();
			List<ClienteDTO> listaClienti = GestioneStrumentoBO.getListaClientiNew(String.valueOf(id_company));
			
			for (int i=0;i<lista_pacchi.size();i++) {
				for(int j=0;j<listaClienti.size();j++)
				if(lista_pacchi.get(i).getId_cliente()==listaClienti.get(j).get__id()) {
					lista_pacchi.get(i).setNome_cliente(listaClienti.get(j).getNome());
				}
								
			}
		
			List<SedeDTO> listaSedi = GestioneStrumentoBO.getListaSediNew();
			
				for (int i=0;i<lista_pacchi.size();i++) {
					for(int j=0;j<listaSedi.size();j++)
	 				if(lista_pacchi.get(i).getId_sede()==listaSedi.get(j).get__id()) {
						lista_pacchi.get(i).setNome_sede(listaSedi.get(j).getDescrizione());
					}
				}
			
			request.getSession().setAttribute("lista_pacchi",lista_pacchi);
			request.getSession().setAttribute("lista_clienti", listaClienti);
			request.getSession().setAttribute("lista_sedi", listaSedi);

			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listapacchi.jsp");
	     	dispatcher.forward(request,response);
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
