package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
import org.apache.commons.codec.binary.Base64;
/**
 * Servlet implementation class DettaglioStrumento
 */

@WebServlet(name="dettaglioStrumentoFull" , urlPatterns = { "/dettaglioStrumentoFull.do" })
public class DettaglioStrumentoFull extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DettaglioStrumentoFull() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (request.getSession().getAttribute("userObj")==null ) {
			request.getSession().setAttribute("urlStatico", "/dettaglioStrumentoFull.do?id_str="+request.getParameter("id_str"));
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
            dispatcher.forward(request,response);
		}else {
			doPost(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		try
		{

		String idS = request.getParameter("id_str");

		// idS = Utility.decryptData(idS);
		//ArrayList<StrumentoDTO> listaStrumenti = (ArrayList<StrumentoDTO>)request.getSession().getAttribute("listaStrumenti");
		byte[] valueDecoded = Base64.decodeBase64(idS);
		//System.out.println("Decoded value is " + new String(valueDecoded));
		String idS_decoded = new String(valueDecoded);
		Integer.parseInt(idS_decoded);
		StrumentoDTO dettaglio = GestioneStrumentoBO.getStrumentoById(idS_decoded, session);
		
		//StrumentoDTO dettaglio =getDettaglio(listaStrumenti,idS);
	
		PrintWriter out = response.getWriter();
		
		 Gson gson = new Gson(); 
	        JsonObject myObj = new JsonObject();

	        JsonElement obj = gson.toJsonTree(dettaglio);
	       

	            myObj.addProperty("success", true);
	       
	        myObj.add("dataInfo", obj);
//	        out.println(myObj.toString());
//	        System.out.println(myObj.toString());
//	        out.close();
	        
	        request.getSession().setAttribute("myObj",myObj);

			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioStrumentoFull.jsp");
		     dispatcher.forward(request,response);
		     
		     session.getTransaction().commit();
				session.close();
				
	        
		}
		catch (NumberFormatException e) {
			 UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
			 try {
				 
				//GestioneStrumentoBO.getListaStrumentiPerSediAttiviNEW(String.valueOf(utente.getIdCliente()), String.valueOf(utente.getIdSede()), utente.getCompany().getId(), session);

				List<ClienteDTO> listaClientiFull = new ArrayList<ClienteDTO>();
				listaClientiFull.add(GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(utente.getIdCliente())));

//				}
				request.getSession().setAttribute("listaClienti",listaClientiFull);
				
				List<SedeDTO> listaSediFull = GestioneAnagraficaRemotaBO.getListaSedi();
				
				request.getSession().setAttribute("listaSedi",listaSediFull);
				
				ArrayList<StrumentoDTO> strumenti= new ArrayList<StrumentoDTO>();
				request.getSession().setAttribute("listaStrumenti",strumenti);
				
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaStrumentiNEW.jsp");
		     	dispatcher.forward(request,response);
			 } catch (Exception e1) {
				 session.getTransaction().rollback();
				 session.close();
				
	   		 e1.printStackTrace();
	   	     request.setAttribute("error",STIException.callException(e1));
	   	     request.getSession().setAttribute("exception",e1);
	   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	   	     dispatcher.forward(request,response);	
				}
		}
		
		catch(Exception ex)
    	{
			
			 session.getTransaction().rollback();
			 session.close();
			
   		 ex.printStackTrace();
   	     request.setAttribute("error",STIException.callException(ex));
   	     request.getSession().setAttribute("exception",ex);
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	}  
	}
	
	

	private StrumentoDTO getDettaglio(ArrayList<StrumentoDTO> listaStrumenti,String idS) {
		StrumentoDTO strumento =null;
		
		try
		{
		
		
		
		for (int i = 0; i < listaStrumenti.size(); i++) {
			
			if(listaStrumenti.get(i).get__id()==Integer.parseInt(idS))
			{
				return listaStrumenti.get(i);
			}
		}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			strumento=null;
			
		}
		return strumento;
	}

}
