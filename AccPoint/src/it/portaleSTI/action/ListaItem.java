package it.portaleSTI.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AccessorioDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.MagAccessorioDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAccessorioBO;
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
		try {
		String tipo_item = request.getParameter("tipo_item");
		
		if(tipo_item.equals("")) {
			
		}
		
		
		
		if(tipo_item.equals("1")) {
			
			String id_cliente=request.getParameter("id_cliente");
			String id_sede = request.getParameter("id_sede");
			
			String[] sede= id_sede.split("_");
				ArrayList<StrumentoDTO> lista_strumenti = (ArrayList<StrumentoDTO>) GestioneStrumentoBO.getListaStrumentiPerSedi(sede[0], id_cliente);
			
			request.getSession().setAttribute("lista_strumenti", lista_strumenti);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaItemStrumenti.jsp");
		     dispatcher.forward(request,response);
		     
		     
		}
		
		else if(tipo_item.equals("2")) {
			
			Session session=SessionFacotryDAO.get().openSession();
			session.beginTransaction();
			CompanyDTO cmp=(CompanyDTO)request.getSession().getAttribute("usrCompany");
			ArrayList<AccessorioDTO> lista_accessori =  (ArrayList<AccessorioDTO>) GestioneAccessorioBO.getListaAccessori(cmp,session);
			session.close();
			request.getSession().setAttribute("lista_accessori", lista_accessori);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaItemAccessori.jsp");
		     dispatcher.forward(request,response);
			
		}
		
		else if(tipo_item.equals("3")) {
			
			Session session=SessionFacotryDAO.get().openSession();
			session.beginTransaction();
			
			ArrayList<MagAccessorioDTO> lista_generici =   GestioneMagazzinoBO.getListaGenerici(session);
			
			request.getSession().setAttribute("lista_generici", lista_generici);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaItemGenerici.jsp");
		     dispatcher.forward(request,response);
			
		}
		
		
		} catch (HibernateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
