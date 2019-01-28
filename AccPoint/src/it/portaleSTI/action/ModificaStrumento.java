package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

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

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneMagazzinoBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class DettaglioStrumento
 */

@WebServlet(name="modificaStrumento" , urlPatterns = { "/modificaStrumento.do" })
public class ModificaStrumento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModificaStrumento() {
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
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		try
		{

			
			String action = request.getParameter("action");
			if(action.equals("modifica")) {
				String idS = request.getParameter("id");
		
				 
				//ArrayList<StrumentoDTO> listaStrumenti = (ArrayList<StrumentoDTO>)request.getSession().getAttribute("listaStrumenti");
				
				
				StrumentoDTO dettaglio = GestioneStrumentoBO.getStrumentoById(idS, session);
				
 			
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
		
					 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/modificaStrumento.jsp");
				     dispatcher.forward(request,response);
			}
			if(action.equals("salva")) {
				String idS = request.getParameter("id");
				StrumentoDTO strumento = GestioneStrumentoBO.getStrumentoById(idS, session);
				
			 	String denominazione=request.getParameter("denominazione");
			 	String codice_interno=request.getParameter("codice_interno");
			 	String costruttore=request.getParameter("costruttore");
			 	String modello=request.getParameter("modello");
			 	String matricola=request.getParameter("matricola");
			 	String risoluzione=request.getParameter("risoluzione");
			 	String campo_misura=request.getParameter("campo_misura");
			 	String ref_tipo_strumento=request.getParameter("ref_tipo_strumento");
			 	String reparto=request.getParameter("reparto");
			 	String utilizzatore=request.getParameter("utilizzatore");
			 	String note=request.getParameter("note");
			 	String luogo_verifica=request.getParameter("luogo_verifica");
			 	//String interpolazione=request.getParameter("interpolazione");
			 	String classificazione=request.getParameter("classificazione");
			 	String procedura = request.getParameter("procedura");
			 	
			 	strumento.setDenominazione(denominazione);
			 	strumento.setCodice_interno(codice_interno);
			 	strumento.setCostruttore(costruttore);
			 	strumento.setModello(modello);
			 	strumento.setMatricola(matricola);
			 	strumento.setRisoluzione(risoluzione);
			 	strumento.setCampo_misura(campo_misura);
			 	strumento.setReparto(reparto);
			 	strumento.setUtilizzatore(utilizzatore);
			 	strumento.setNote(note);
			 	strumento.setProcedura(procedura);
			 	//strumento.setInterpolazione(Integer.parseInt(interpolazione));
			 	
			 	
				strumento.setTipo_strumento(new TipoStrumentoDTO(Integer.parseInt(ref_tipo_strumento),""));		
				strumento.setClassificazione(new ClassificazioneDTO(Integer.parseInt(classificazione),""));
				strumento.setLuogo(new LuogoVerificaDTO(Integer.parseInt(luogo_verifica),""));
				
				String message = "Salvato con Successo";
				Boolean success = true;
				if(!GestioneStrumentoBO.update(strumento, session)) {
					 session.getTransaction().rollback();
					 session.close();	
					 message = "Errore Salvataggio";
					success = false;
				}
				GestioneMagazzinoBO.updateStrumento(strumento, session);
				Gson gson = new Gson();
				
				// 2. Java object to JSON, and assign to a String
				String jsonInString = gson.toJson(strumento);
				
				
					JsonObject myObj = new JsonObject();

					myObj.addProperty("success", success);
					myObj.addProperty("messaggio", message);
					myObj.addProperty("strumento", jsonInString);
					
					PrintWriter out = response.getWriter();

			        out.println(myObj.toString());

			}
		     session.getTransaction().commit();
				session.close();
				
	        
		}catch(Exception ex)
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
