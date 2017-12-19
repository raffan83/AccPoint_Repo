package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCompanyBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

/**
 * Servlet implementation class ListaStrumentiSede
 */
@WebServlet(name= "/listaStrumentiCalendario", urlPatterns = { "/listaStrumentiCalendario.do" })
public class ListaStrumentiCalendario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaStrumentiCalendario() {
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
			
			String date =request.getParameter("date");

			
			if(date!=null && date.length()>0 && !date.equals("null"))
			{
				
				
					
				ArrayList<TipoStrumentoDTO> listaTipoStrumento = GestioneTLDAO.getListaTipoStrumento();
				ArrayList<TipoRapportoDTO> listaTipoRapporto = GestioneTLDAO.getListaTipoRapporto();
				ArrayList<StatoStrumentoDTO> listaStatoStrumento = GestioneTLDAO.getListaStatoStrumento();
				ArrayList<LuogoVerificaDTO> listaLuogoVerifica = GestioneTLDAO.getListaLuogoVerifica();
				
				ArrayList<ClassificazioneDTO> listaClassificazione = GestioneTLDAO.getListaClassificazione();
				
				ArrayList<StrumentoDTO> listaStrumentiPerSede=GestioneStrumentoBO.getListaStrumentiFromDate(utente, null, date); 

				request.getSession().setAttribute("listaStrumenti", listaStrumentiPerSede);
				
				PrintWriter out = response.getWriter();
			
				Gson gson = new Gson(); 
		        JsonObject myObj = new JsonObject();

		        JsonElement obj = gson.toJsonTree(listaStrumentiPerSede);
		       
		        if(listaStrumentiPerSede!=null && listaStrumentiPerSede.size()>0){
		            myObj.addProperty("success", true);
		        }
		        else {
		            myObj.addProperty("success", false);
		        }


		        myObj.add("dataInfo", obj);
		        
		        request.getSession().setAttribute("myObj",myObj);

		        request.getSession().setAttribute("listaTipoStrumento",listaTipoStrumento);
		        request.getSession().setAttribute("listaStatoStrumento",listaStatoStrumento);
		        request.getSession().setAttribute("listaTipoRapporto",listaTipoRapporto);
		        request.getSession().setAttribute("listaLuogoVerifica",listaLuogoVerifica);
		        request.getSession().setAttribute("listaClassificazione",listaClassificazione);
		        
		        
		        HashMap<String, String> listaSediStrumenti = GestioneStrumentoBO.getListaNominativiSediClienti();
				HashMap<String, String> listaClientiStrumenti = GestioneStrumentoBO.getListaNominativiClienti();
				

		        request.getSession().setAttribute("listaSediStrumenti", listaSediStrumenti);
				request.getSession().setAttribute("listaClientiStrumenti", listaClientiStrumenti);
		        
		        
		        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		        Date data = sdf.parse(date);
		        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		        String format = formatter.format(data);
		        
		        request.getSession().setAttribute("descrizioneClienteStrumenti",format);
				 
		        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaStrumentiCalendario.jsp");
			     dispatcher.forward(request,response);
		        
		        
				
			}
			
			String dateFrom =request.getParameter("dateFrom");
			String dateTo =request.getParameter("dateTo");
			String idCliente =request.getParameter("idCliente");
			String idSede =request.getParameter("idSede");
			ArrayList<StrumentoDTO> listaStrumentiFiltrata= new ArrayList<>();
			if(dateFrom!=null && dateFrom.length()>0 && !dateFrom.equals("null") && dateTo!=null && dateTo.length()>0 && !dateTo.equals("null"))
			{
				
				
				ArrayList<TipoStrumentoDTO> listaTipoStrumento = GestioneTLDAO.getListaTipoStrumento();
				ArrayList<TipoRapportoDTO> listaTipoRapporto = GestioneTLDAO.getListaTipoRapporto();
				ArrayList<StatoStrumentoDTO> listaStatoStrumento = GestioneTLDAO.getListaStatoStrumento();
				ArrayList<LuogoVerificaDTO> listaLuogoVerifica = GestioneTLDAO.getListaLuogoVerifica();
				ArrayList<ClassificazioneDTO> listaClassificazione = GestioneTLDAO.getListaClassificazione();
				
				ArrayList<StrumentoDTO> listaStrumenti = new ArrayList<StrumentoDTO>();
				
				if(idSede != null && !idSede.equals("")) {
					listaStrumenti =GestioneStrumentoBO.getListaStrumentiFromDate(utente, dateFrom, dateTo); 
					
					HashMap<String, String> listaSediStrumenti = (HashMap<String, String>) request.getSession().getAttribute("listaSediStrumenti");
					request.getSession().setAttribute("descrizioneClienteStrumenti", listaSediStrumenti.get(idSede));
				}
				else if(idCliente != null && !idCliente.equals("")) {
					listaStrumenti =GestioneStrumentoBO.getListaStrumentiFromDate(utente, dateFrom, dateTo); 
					
					HashMap<String, String> listaClientiStrumenti = (HashMap<String, String>) request.getSession().getAttribute("listaClientiStrumenti");
					request.getSession().setAttribute("descrizioneClienteStrumenti", listaClientiStrumenti.get(idCliente));

				}
				
				if(idSede!=null && idSede.length()>0)
				{
					for (StrumentoDTO str :listaStrumenti)
					{
						if(str.getId__sede_()==Integer.parseInt(idSede))
						{
							listaStrumentiFiltrata.add(str);
						}
					}
				}
				if(idCliente!=null && idCliente.length()>0 && idSede==null)
				{
					for (StrumentoDTO str :listaStrumenti)
					{
						if(str.getId_cliente()==Integer.parseInt(idCliente))
						{
							listaStrumentiFiltrata.add(str);
						}
					}
				}

				request.getSession().setAttribute("listaStrumenti", listaStrumentiFiltrata);
				PrintWriter out = response.getWriter();
			
				Gson gson = new Gson(); 
		        JsonObject myObj = new JsonObject();

		        JsonElement obj = gson.toJsonTree(listaStrumentiFiltrata);
		       
		        if(listaStrumentiFiltrata!=null && listaStrumentiFiltrata.size()>0){
		            myObj.addProperty("success", true);
		        }
		        else {
		            myObj.addProperty("success", false);
		        }


		        myObj.add("dataInfo", obj);
		        
		        request.getSession().setAttribute("myObj",myObj);

		        
		        
		        
		        request.getSession().setAttribute("listaTipoStrumento",listaTipoStrumento);
		        request.getSession().setAttribute("listaStatoStrumento",listaStatoStrumento);
		        request.getSession().setAttribute("listaTipoRapporto",listaTipoRapporto);
		        request.getSession().setAttribute("listaLuogoVerifica",listaLuogoVerifica);
		        request.getSession().setAttribute("listaClassificazione",listaClassificazione);
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaStrumentiCalendario.jsp");
			     dispatcher.forward(request,response);
		        
		        
				
			}
			
			
		session.getTransaction().commit();
		session.close();
		}
		
		
		catch(Exception ex)
    	{
		 session.getTransaction().rollback();
   		 ex.printStackTrace();
   	     request.setAttribute("error",STIException.callException(ex));
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	} 
		
	}

}
