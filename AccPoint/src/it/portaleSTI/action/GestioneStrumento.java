package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneAccessoDAO;
import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneStrumentoDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.DTO.ScadenzaDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoCampioneDTO;
import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestionePrenotazioniBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.Date;
import java.util.Hashtable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

/**
 * Servlet implementation class DettaglioCampione
 */
@WebServlet(name="gestioneStrumento" , urlPatterns = { "/gestioneStrumento.do" })
@MultipartConfig
public class GestioneStrumento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneStrumento() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		PrintWriter out = response.getWriter();
		ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");
	try{	
	

		String action=  request.getParameter("action");

		

		if(action !=null)
		{
			StrumentoDTO strumento = null;
			if(action.equals("toggleFuoriServizio")){
				strumento = GestioneStrumentoBO.getStrumentoById( request.getParameter("idStrumento"), session);
				
				CompanyDTO idCompany=(CompanyDTO)request.getSession().getAttribute("usrCompany");
				
				
				ArrayList<StrumentoDTO> listaStrumentiPerSede=GestioneStrumentoBO.getListaStrumentiPerSediAttiviNEW(request.getParameter("idCliente"),request.getParameter("idSede"),idCompany.getId(), session); 

				request.getSession().setAttribute("listaStrumenti", listaStrumentiPerSede);
				
				
			}else{
				JsonObject myObj = new JsonObject();

				myObj.addProperty("success", false);
				myObj.addProperty("message", "Errore, action non riconosciuta");
		        out.println(myObj.toString());
			}
			if(strumento.getStato_strumento() != null && strumento.getStato_strumento().getId() == 7225){
				strumento.setStato_strumento(new StatoStrumentoDTO(7226, "In serivzio"));
			}else{
				strumento.setStato_strumento(new StatoStrumentoDTO(7225, "Fuori servizio"));
			}
				
		
			
			JsonObject myObj = new JsonObject();

			Boolean success = GestioneStrumentoBO.update(strumento, session);
				
				String message = "";
				if(success){
					message = "Salvato con Successo";
				}else{
					message = "Errore Salvataggio";
				}
			
			
				Gson gson = new Gson();
				
				// 2. Java object to JSON, and assign to a String

				
				

					myObj.addProperty("success", success);
					myObj.addProperty("message", message);
			        out.println(myObj.toString());

		}else{
			JsonObject myObj = new JsonObject();

			myObj.addProperty("success", false);
			myObj.addProperty("message", "Nessuna action riconosciuta");
	        out.println(myObj.toString());
		}

		   session.getTransaction().commit();
			session.close();
	}catch(Exception ex)
	{
		 JsonObject myObj = new JsonObject();
			request.getSession().setAttribute("exception", ex);
		myObj.addProperty("success", false);
		myObj.addProperty("message", STIException.callException(ex).toString());
        //out.println(myObj.toString());
        session.getTransaction().rollback();
		session.close();
//		 ex.printStackTrace();
//	     request.setAttribute("error",STIException.callException(ex));
//		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
//	     dispatcher.forward(request,response);
		
	}  
	
	}
	


}
