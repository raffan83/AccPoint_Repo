package it.portaleSTI.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class ListaStrumentiSede
 */
@WebServlet(name= "/listaSediStrumentiInScadenza", urlPatterns = { "/listaSediStrumentiInScadenza.do" })
public class ListaSediStrumentiInScadenza extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaSediStrumentiInScadenza() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
		
		response.setContentType("text/html");
		
		 
		try {
			
			String dateFrom =request.getParameter("dateFrom");
			String dateTo =request.getParameter("dateTo");
			String tipo_rapporto = request.getParameter("tipo_rapporto");
			
			
			if(dateFrom!=null && dateFrom.length()>0 && !dateFrom.equals("null") && dateTo!=null && dateTo.length()>0 && !dateTo.equals("null"))
			{
				ArrayList<StrumentoDTO> listaStrumenti=GestioneStrumentoBO.getListaStrumentiFromDate(utente, dateFrom, dateTo, Integer.parseInt(tipo_rapporto)); 

				HashMap<String,ArrayList<StrumentoDTO>> listaStrumentiPerSede = new HashMap<String,ArrayList<StrumentoDTO>>();
				
				for (StrumentoDTO strumento : listaStrumenti) {
					
					
					if(strumento.getId__sede_()==0) {
						if(listaStrumentiPerSede.containsKey("c_"+strumento.getId_cliente())){
							ArrayList<StrumentoDTO> listaS = listaStrumentiPerSede.get("c_"+strumento.getId_cliente());
							listaS.add(strumento);
							listaStrumentiPerSede.put("c_"+strumento.getId_cliente(), listaS);
						}else {
							ArrayList<StrumentoDTO> listaS = new ArrayList<StrumentoDTO>();
							listaS.add(strumento);
							listaStrumentiPerSede.put("c_"+strumento.getId_cliente(), listaS);
						}
					
					}else {
//						if( listaStrumentiPerSede.containsKey("s_"+strumento.getId__sede_())) {
//							ArrayList<StrumentoDTO> listaS = listaStrumentiPerSede.get("s_"+strumento.getId__sede_());
//							listaS.add(strumento);
//							listaStrumentiPerSede.put("s_"+strumento.getId__sede_(), listaS);
//						}else {
//							ArrayList<StrumentoDTO> listaS = new ArrayList<StrumentoDTO>();
//							listaS.add(strumento);
//							listaStrumentiPerSede.put("s_"+strumento.getId__sede_(), listaS);
//						}
						if( listaStrumentiPerSede.containsKey("s_"+strumento.getId__sede_()+"_"+strumento.getId_cliente())) {
							ArrayList<StrumentoDTO> listaS = listaStrumentiPerSede.get("s_"+strumento.getId__sede_()+"_"+strumento.getId_cliente());
							listaS.add(strumento);
							listaStrumentiPerSede.put("s_"+strumento.getId__sede_()+"_"+strumento.getId_cliente(), listaS);
						}else {
							ArrayList<StrumentoDTO> listaS = new ArrayList<StrumentoDTO>();
							listaS.add(strumento);
							listaStrumentiPerSede.put("s_"+strumento.getId__sede_()+"_"+strumento.getId_cliente(), listaS);
						}
					
					}
					
				}
				
				HashMap<String, String> listaSediStrumenti = GestioneAnagraficaRemotaBO.getListaNominativiSediClienti();
				HashMap<String, String> listaClientiStrumenti = GestioneAnagraficaRemotaBO.getListaNominativiClienti();
				
				
				request.getSession().setAttribute("listaStrumentiPerSede", listaStrumentiPerSede);
				
				String sede = listaSediStrumenti.get("1");
				request.getSession().setAttribute("listaSediStrumenti", listaSediStrumenti);
				request.getSession().setAttribute("listaClientiStrumenti", listaClientiStrumenti);


				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaSediStrumentiInScadenza.jsp");
			     dispatcher.forward(request,response);
		        
		        
				
			}
		session.getTransaction().commit();
		session.close();
		}
		
		
		catch(Exception ex)
    	{
		 session.getTransaction().rollback();
		 session.close();
   		 ex.printStackTrace();
   	     request.setAttribute("error",STIException.callException(ex));
   	     request.getSession().setAttribute("exception", ex);
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	} 
		
	}

}
