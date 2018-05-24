package it.portaleSTI.action;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.SchedaConsegnaDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Strings;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneStrumentoBO;
import it.portaleSTI.bo.GestioneSchedaConsegnaBO;

/**
 * Servlet implementation class CaricaSchedaConsegna
 */
@WebServlet("/CaricaSchedaConsegna.do")
public class CaricaSchedaConsegna extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CaricaSchedaConsegna() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;

		
		JsonObject jsono = new JsonObject();
		PrintWriter writer = response.getWriter();
		
		InterventoDTO intervento= (InterventoDTO)request.getSession().getAttribute("intervento");
		
		int id=intervento.getId();
		boolean esito;
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();

		ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
		writer = response.getWriter();
		response.setContentType("application/json");

		try {
			List<FileItem> items = uploadHandler.parseRequest(request);
			for (FileItem item : items) {
				if (!item.isFormField()) {
					String filename=GestioneSchedaConsegnaBO.uploadSchedaConsegna(item, intervento.getNomePack());
					 esito = true;

					if(esito==false)
					{
						jsono.addProperty("success", false);
						jsono.addProperty("messaggio", "Salvataggio non riuscito!");
					}

					if(esito==true)
					{
						DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
						Date date = new Date();
						
						
						esito = GestioneSchedaConsegnaBO.saveDB(id, filename, dateFormat.format(date).toString(), session);
						jsono.addProperty("success", true);
						jsono.addProperty("messaggio", "Salvataggio riuscito!");

				}
			}
			}
			//request.getSession().setAttribute("esito", esito);
			
			session.getTransaction().commit();
			session.close();	
			writer.write(jsono.toString());
			writer.close();
	
		} catch (Exception e) 

		{ 
			e.printStackTrace();
			session.getTransaction().rollback();
			session.close();
			request.getSession().invalidate();

			request.getSession().setAttribute("exception", e);
			//jsono.addProperty("success", false);
			//jsono.addProperty("messaggio", "Errore salvataggio! "+e.getMessage());
			jsono = STIException.getException(e);
			writer.println(jsono.toString());
			writer.close();

		} 
	
	}
}
