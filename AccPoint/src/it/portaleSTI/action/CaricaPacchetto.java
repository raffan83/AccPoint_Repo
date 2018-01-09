package it.portaleSTI.action;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Strings;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneStrumentoBO;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
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



/**
 * Servlet implementation class ScaricaStrumento
 */
@WebServlet(name= "/caricaPacchetto", urlPatterns = { "/caricaPacchetto.do" })

public class CaricaPacchetto extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CaricaPacchetto() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		if(Utility.validateSession(request,response,getServletContext()))return;

		ObjSavePackDTO esito=null;
		JsonObject jsono = new JsonObject();
		PrintWriter writer = response.getWriter();
		

		InterventoDTO intervento= (InterventoDTO)request.getSession().getAttribute("intervento");
		UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();

		ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
		writer = response.getWriter();
		response.setContentType("application/json");

		try {
			List<FileItem> items = uploadHandler.parseRequest(request);
			for (FileItem item : items) {
				if (!item.isFormField()) {

					 esito =GestioneInterventoBO.savePackUpload(item,intervento.getNomePack());

					if(esito.getEsito()==0)
					{
						jsono.addProperty("success", false);
						jsono.addProperty("messaggio", esito.getErrorMsg());
					}

					if(esito.getEsito()==1)
					{

						esito = GestioneInterventoBO.saveDataDB(esito,intervento,utente,session);

						if(esito.getEsito()==0)
						{
							jsono.addProperty("success", false);
							jsono.addProperty("messaggio", esito.getErrorMsg());
						}

						if(esito.getEsito()==1 && esito.isDuplicati()==false)
						{

							jsono.addProperty("success", true);
							jsono.addProperty("messaggio", Strings.CARICA_PACCHETTO_ESITO_1(esito.getInterventoDati().getNumStrMis(), esito.getInterventoDati().getNumStrNuovi()));

						}
						if(esito.getEsito()==1 && esito.isDuplicati()==true)
						{
							for (int i = 0; i < esito.getListaStrumentiDuplicati().size(); i++) 
							{
								StrumentoDTO strumento =GestioneStrumentoBO.getStrumentoById(""+esito.getListaStrumentiDuplicati().get(i).get__id(),session);
								esito.getListaStrumentiDuplicati().set(i,strumento);

							}
							
							Gson gson = new Gson();
							String jsonInString = gson.toJson(esito.getListaStrumentiDuplicati());
							
							jsono.addProperty("success", true);                      				
							jsono.addProperty("duplicate",jsonInString);
						}
					}
					
					if(esito.getEsito()==2)
					{
						jsono.addProperty("success", false);
						jsono.addProperty("messaggio",Strings.CARICA_PACCHETTO_ESITO_2);

					}

				}
			}

			request.getSession().setAttribute("esito", esito);
			
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
			
		    FileOutputStream outFile = new FileOutputStream(esito.getPackNameAssigned());
		    outFile.flush();
		    outFile.close();
			esito.getPackNameAssigned().delete();
			
			jsono.addProperty("success", false);
			jsono.addProperty("messaggio", "Errore importazione pacchetto "+e.getMessage());
			writer.println(jsono.toString());
			writer.close();

		} 

			
		
		

	}

}
