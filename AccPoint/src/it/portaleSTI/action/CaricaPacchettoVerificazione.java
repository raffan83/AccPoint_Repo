package it.portaleSTI.action;

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
import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Strings;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneStrumentoBO;
import it.portaleSTI.bo.GestioneVerInterventoBO;
import it.portaleSTI.bo.GestioneVerStrumentiBO;

/**
 * Servlet implementation class CaricaPacchettoVerificazione
 */
@WebServlet("/caricaPacchettoVerificazione.do")
public class CaricaPacchettoVerificazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static final Logger logger = Logger.getLogger(CaricaPacchettoVerificazione.class);
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CaricaPacchettoVerificazione() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		ObjSavePackDTO esito=null;
		JsonObject jsono = new JsonObject();
		PrintWriter writer = response.getWriter();
		
		try {			
			String action = request.getParameter("action");
			UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
			
			
			logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo());
			
			if(action== null) {
				
				String id_intervento = request.getParameter("id_intervento");
				
				
				VerInterventoDTO ver_intervento = GestioneVerInterventoBO.getInterventoFromId(Integer.parseInt(id_intervento), session);
				
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
				writer = response.getWriter();
				response.setContentType("application/json");
				
				List<FileItem> items = uploadHandler.parseRequest(request);
				for (FileItem item : items) {
					if (!item.isFormField()) {

						 esito =GestioneVerInterventoBO.savePackUpload(item,ver_intervento.getNome_pack());

						if(esito.getEsito()==0)
						{
							jsono.addProperty("success", false);
							jsono.addProperty("messaggio", esito.getErrorMsg());
						}

						else if(esito.getEsito()==1 && esito.isDuplicati()==false)
						{

							esito = GestioneVerInterventoBO.saveDataDB(esito,ver_intervento,utente,session);

							jsono.addProperty("success", true);
							jsono.addProperty("messaggio", "Pacchetto caricato con successo!");
						}
						if(esito.getEsito()==1 && esito.isDuplicati()==true)
						{
							for (int i = 0; i < esito.getListaVerStrumentiDuplicati().size(); i++) 
							{
								VerStrumentoDTO verStrumento = GestioneVerStrumentiBO.getVerStrumentoFromId(esito.getListaVerStrumentiDuplicati().get(i).getId(),session);
								esito.getListaVerStrumentiDuplicati().set(i,verStrumento);

							}
							
							Gson gson = new Gson();
							String jsonInString = gson.toJson(esito.getListaVerStrumentiDuplicati());
							
							jsono.addProperty("success", true);                      				
							jsono.addProperty("duplicate",jsonInString);
						}
						
						else if(esito.getEsito()==2)
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
			}
			else if(action!=null && action.equals("duplicati")) {
				
				String obj =request.getParameter("ids");
				String note_obsolescenza = request.getParameter("note");

				VerInterventoDTO ver_intervento  =(VerInterventoDTO)request.getSession().getAttribute("interventover");
				
				esito =(ObjSavePackDTO)request.getSession().getAttribute("esito");	

				if(obj!=null && obj.length()>0)
				{
					String[] lista =obj.split(",");
					String[] note = note_obsolescenza.split(",");

					for (int i = 0; i < lista.length; i++) 
					{
						
						GestioneVerInterventoBO.updateMisura(lista[i],esito,ver_intervento,utente, note[i], session);	
						

					}

					jsono.addProperty("success", true);
					jsono.addProperty("messaggio", "Misura caricata con successo!");

				}
				else
				{

					if(esito.getInterventoDati().getNumStrMis()==0)
					{
						jsono.addProperty("messaggio","Nessun strumento modificato o inserito");
						GestioneInterventoBO.removeInterventoDati(esito.getInterventoDati(),session);
						jsono.addProperty("success", true);
					}
					else
					{
						jsono.addProperty("success", true);
						jsono.addProperty("messaggio", Strings.CARICA_PACCHETTO_ESITO_1(esito.getInterventoDati().getNumStrMis(), esito.getInterventoDati().getNumStrNuovi()));

					}
				}
				session.getTransaction().commit();
				session.close();
				writer.write(jsono.toString());
				writer.close();
			}
			
		}
		catch (Exception e)
		{ 
			e.printStackTrace();
			session.getTransaction().rollback();
			session.close();
			
		    FileOutputStream outFile = new FileOutputStream(esito.getPackNameAssigned());
		    outFile.flush();
		    outFile.close();
			esito.getPackNameAssigned().delete();
		
			jsono= STIException.getException(e);
			request.getSession().setAttribute("exception", e);
			writer.println(jsono.toString());
			writer.close();

		} 

	
	}

}
