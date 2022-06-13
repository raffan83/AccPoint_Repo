package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneStrumentoDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.StrumentoNoteDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class ListaStrumentiSede
 */
@WebServlet(name= "/listaStrumentiSedeNew", urlPatterns = { "/listaStrumentiSedeNew.do" })
public class ListaStrumentiSedeNew extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaStrumentiSedeNew() {
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
		
		response.setContentType("text/html");
		String action = request.getParameter("action");

		try {
		
			if(action==null || action.equals("")) {
				String param = request.getParameter("idSede");
				
				
				
				if(param!=null && param.length()>0 && !param.equals("null"))
				{
					
					String[] tmp=param.split(";");
					
					String idSede;
					String idCliente=tmp[1];
					
					if(tmp[0]!=null && !tmp[0].equalsIgnoreCase("null"))
					{
						idSede=tmp[0].split("_")[0];
					}
					else
					{
						idSede="0";
					}
					
					
				
					CompanyDTO idCompany=(CompanyDTO)request.getSession().getAttribute("usrCompany");
					UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
					
					if(idCompany!=null)
					{
					
					ArrayList<TipoStrumentoDTO> listaTipoStrumento = GestioneTLDAO.getListaTipoStrumento(session);
					ArrayList<TipoRapportoDTO> listaTipoRapporto = GestioneTLDAO.getListaTipoRapporto(session);
					ArrayList<StatoStrumentoDTO> listaStatoStrumento = GestioneTLDAO.getListaStatoStrumento(session);
					ArrayList<LuogoVerificaDTO> listaLuogoVerifica = GestioneTLDAO.getListaLuogoVerifica(session);
					ArrayList<ClassificazioneDTO> listaClassificazione = GestioneTLDAO.getListaClassificazione(session);
	
		//			ArrayList<StrumentoDTO> listaStrumentiPerSede=GestioneStrumentoBO.getListaStrumentiPerSediAttiviNEW(idCliente, idSede, idCompany.getId(), session,utente);
					
					ArrayList<StrumentoDTO> listaStrumentiPerSede=GestioneStrumentoBO.getListaStrumentiInFuoriServizio(idCliente, idSede, idCompany.getId(), session,utente, 7226);
					
					request.getSession().setAttribute("listaStrumenti", listaStrumentiPerSede);
					ArrayList<StrumentoDTO> listaStrumentiPerSedeGrafici=GestioneStrumentoBO.getListaStrumentiPerGrafici(idCliente,idSede,idCompany.getId(),utente); 
	
					
					HashMap<String,Integer> statoStrumenti = new HashMap<String,Integer>();
					HashMap<String,Integer> denominazioneStrumenti = new HashMap<String,Integer>();
					HashMap<String,Integer> tipoStrumenti = new HashMap<String,Integer>();
					HashMap<String,Integer> freqStrumenti = new HashMap<String,Integer>();
					HashMap<String,Integer> repartoStrumenti = new HashMap<String,Integer>();
					HashMap<String,Integer> utilizzatoreStrumenti = new HashMap<String,Integer>();
					
	//				for (StatoStrumentoDTO statoStrumento : listaStatoStrumento) {
	//					statoStrumenti.put(statoStrumento.getNome(), 0);
	//
	//				}
	//				for (TipoStrumentoDTO tipoStrumento : listaTipoStrumento) {
	//					tipoStrumenti.put(tipoStrumento.getNome(), 0);
	//
	//				}
	
					for(StrumentoDTO strumentoDTO: listaStrumentiPerSedeGrafici) {
	
						
							
						
						if(statoStrumenti.containsKey(strumentoDTO.getStato_strumento().getNome())) {
							Integer iter = statoStrumenti.get(strumentoDTO.getStato_strumento().getNome());
							iter++;
							statoStrumenti.put(strumentoDTO.getStato_strumento().getNome(), iter);
						}else {
							statoStrumenti.put(strumentoDTO.getStato_strumento().getNome(), 1);
						}
						
						if(strumentoDTO.getStato_strumento().getNome().equals("In servizio")) {	
						if(tipoStrumenti.containsKey(strumentoDTO.getTipo_strumento().getNome())) {
							Integer iter = tipoStrumenti.get(strumentoDTO.getTipo_strumento().getNome());
							iter++;
							tipoStrumenti.put(strumentoDTO.getTipo_strumento().getNome(), iter);
						}else {
							
							tipoStrumenti.put(strumentoDTO.getTipo_strumento().getNome(), 1);
							
						}
					
						if(denominazioneStrumenti.containsKey(strumentoDTO.getDenominazione())) {
							Integer iter = denominazioneStrumenti.get(strumentoDTO.getDenominazione());
							iter++;
							denominazioneStrumenti.put(strumentoDTO.getDenominazione(), iter);
						}else {
							
							denominazioneStrumenti.put(strumentoDTO.getDenominazione(), 1);
							
						}
						
						if(strumentoDTO.getFrequenza() != 0) {
							String freqKey = strumentoDTO.getFrequenza()+"mesi";
							if(strumentoDTO.getFrequenza()==1) {
								freqKey = strumentoDTO.getFrequenza()+"mese";
							}
							
							if(freqStrumenti.containsKey(freqKey)) {
								
								Integer iter = freqStrumenti.get(freqKey);
								iter++;

								freqStrumenti.put(freqKey, iter);
							}else {
								
								freqStrumenti.put(freqKey, 1);
								
							}
						}
						
						if(repartoStrumenti.containsKey(strumentoDTO.getReparto())) {
							Integer iter = repartoStrumenti.get(strumentoDTO.getReparto());
							iter++;
							repartoStrumenti.put(strumentoDTO.getReparto(), iter);
						}else {
							
							repartoStrumenti.put(strumentoDTO.getReparto(), 1);
							
						}
						if(utilizzatoreStrumenti.containsKey(strumentoDTO.getUtilizzatore())) {
							Integer iter = utilizzatoreStrumenti.get(strumentoDTO.getUtilizzatore());
							iter++;
							utilizzatoreStrumenti.put(strumentoDTO.getUtilizzatore(), iter);
						}else {
							
							utilizzatoreStrumenti.put(strumentoDTO.getUtilizzatore(), 1);
							
						}
						}
					
					}
					Gson gson = new Gson(); 
					
					
					request.getSession().setAttribute("statoStrumentiJson", gson.toJsonTree(statoStrumenti).toString());
					request.getSession().setAttribute("tipoStrumentiJson", gson.toJsonTree(tipoStrumenti).toString());
					request.getSession().setAttribute("denominazioneStrumentiJson", gson.toJsonTree(denominazioneStrumenti).toString());
					request.getSession().setAttribute("freqStrumentiJson", gson.toJsonTree(freqStrumenti).toString());
					request.getSession().setAttribute("repartoStrumentiJson", gson.toJsonTree(repartoStrumenti).toString());
					request.getSession().setAttribute("utilizzatoreStrumentiJson", gson.toJsonTree(utilizzatoreStrumenti).toString());
					
					
					request.getSession().setAttribute("listaStrumenti", listaStrumentiPerSede);
	
					
					
					
					PrintWriter out = response.getWriter();
				
					
			        JsonObject myObj = new JsonObject();
	
			        listaStrumentiPerSede= new ArrayList<>();
			      
			        JsonElement obj = gson.toJsonTree(listaStrumentiPerSede);
			       
			        if(listaStrumentiPerSede!=null && listaStrumentiPerSede.size()>0){
			            myObj.addProperty("success", true);
			        }
			        else {
			            myObj.addProperty("success", false);
			        }
	
	
			        myObj.add("dataInfo", obj);
			        
			        request.getSession().setAttribute("myObj",myObj);
			        request.getSession().setAttribute("id_Cliente",idCliente);
			        request.getSession().setAttribute("id_Sede",idSede);
			        request.getSession().setAttribute("listaTipoStrumento",listaTipoStrumento);
			        request.getSession().setAttribute("listaStatoStrumento",listaStatoStrumento);
			        request.getSession().setAttribute("listaTipoRapporto",listaTipoRapporto);
			        request.getSession().setAttribute("listaLuogoVerifica",listaLuogoVerifica);
			        request.getSession().setAttribute("listaClassificazione",listaClassificazione);
			        request.getSession().setAttribute("listaStrumentiTemp",null);
			        
			        
					 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaStrumentiSede.jsp");
				     dispatcher.forward(request,response);
			        
			        
					} 
				}
			session.getTransaction().commit();
			session.close();
			
		}
		
		else if(action.equals("lista_strumenti_campione")) {
			
			CompanyDTO cmp=(CompanyDTO)request.getSession().getAttribute("usrCompany");
			UtenteDTO user=(UtenteDTO)request.getSession().getAttribute("userObj");
			
			ArrayList<StrumentoDTO> lista_strumenti = null;
			String id_cliente = request.getParameter("id_cliente");
			String id_sede = request.getParameter("id_sede");
			if(id_cliente!=null && !id_cliente.equals("") && id_sede!=null && !id_sede.equals("")) {
				lista_strumenti = GestioneStrumentoDAO.getListaStrumenti(id_cliente,id_sede,cmp.getId(),session, user);				
			}else {
				lista_strumenti = GestioneStrumentoBO.getlistaStrumentiFromCompany(cmp.getId(),session);	
			}			
			
			JsonObject myObj = new JsonObject();
			Gson gson = new Gson(); 
	        JsonElement obj = gson.toJsonTree(lista_strumenti);
			
	        
	        
	        myObj.add("dataInfoStr", obj);
	        
	        request.getSession().setAttribute("myObjStr",myObj);
	       
	        session.close();
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaStrumentiCampioni.jsp");
		     dispatcher.forward(request,response);
		    
		}
		else if(action.equals("in_servizio")) {
			
			String id_cliente = request.getParameter("id_cliente");
			String id_sede = request.getParameter("id_sede");
			
			CompanyDTO idCompany=(CompanyDTO)request.getSession().getAttribute("usrCompany");
			UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
			ArrayList<StrumentoDTO> listaStrumentiTemp = (ArrayList<StrumentoDTO>) request.getSession().getAttribute("listaStrumentiTemp");
			ArrayList<StrumentoDTO> listaStrumenti = (ArrayList<StrumentoDTO>) request.getSession().getAttribute("listaStrumenti");
			ArrayList<StrumentoDTO> listaStrumentiAnn = (ArrayList<StrumentoDTO>) request.getSession().getAttribute("listaStrumentiAnn");
		
			if(listaStrumentiTemp!=null && listaStrumentiAnn== null) {
					
				request.getSession().setAttribute("listaStrumentiTemp", listaStrumenti);
				request.getSession().setAttribute("listaStrumenti", listaStrumentiTemp);
				
			}else {
				ArrayList<StrumentoDTO> listaStrumentiFiltrata=GestioneStrumentoBO.getListaStrumentiInFuoriServizio(id_cliente, id_sede, idCompany.getId(), session,utente, 7226);
				request.getSession().setAttribute("listaStrumenti", listaStrumentiFiltrata);
				
			}

			  session.getTransaction().commit();
				session.close();
			
			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaStrumentiSede.jsp");
		     dispatcher.forward(request,response);
		     
		   
			
		}
		else if(action.equals("fuori_servizio")) {
			
			String id_cliente = request.getParameter("id_cliente");
			String id_sede = request.getParameter("id_sede");
			
			CompanyDTO idCompany=(CompanyDTO)request.getSession().getAttribute("usrCompany");
			UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		
			ArrayList<StrumentoDTO> listaStrumentiTemp = (ArrayList<StrumentoDTO>) request.getSession().getAttribute("listaStrumentiTemp");
			ArrayList<StrumentoDTO> listaStrumenti = (ArrayList<StrumentoDTO>) request.getSession().getAttribute("listaStrumenti");
			ArrayList<StrumentoDTO> listaStrumentiAnn = (ArrayList<StrumentoDTO>) request.getSession().getAttribute("listaStrumentiAnn");
	
		
			
			if(listaStrumentiTemp!=null && listaStrumentiAnn== null) {
				request.getSession().setAttribute("listaStrumenti", listaStrumentiTemp);			
				request.getSession().setAttribute("listaStrumentiTemp", listaStrumenti);				
				
			}else {
				request.getSession().setAttribute("listaStrumentiTemp", listaStrumenti);				
				ArrayList<StrumentoDTO> listaStrumentiFiltrata=GestioneStrumentoBO.getListaStrumentiInFuoriServizio(id_cliente, id_sede, idCompany.getId(), session,utente, 7225);
				request.getSession().setAttribute("listaStrumenti", listaStrumentiFiltrata);
				
			}
			
			session.getTransaction().commit();
			session.close();
	
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaStrumentiSede.jsp");
		    dispatcher.forward(request,response);
		    
		    

		}
		else if(action.equals("annullati")) {
			
			String id_cliente = request.getParameter("id_cliente");
			String id_sede = request.getParameter("id_sede");
			
			CompanyDTO idCompany=(CompanyDTO)request.getSession().getAttribute("usrCompany");
			UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		
		//	ArrayList<StrumentoDTO> listaStrumentiTemp = (ArrayList<StrumentoDTO>) request.getSession().getAttribute("listaStrumentiTemp");
			ArrayList<StrumentoDTO> listaStrumenti = (ArrayList<StrumentoDTO>) request.getSession().getAttribute("listaStrumenti");
	
	
//			if(listaStrumentiTemp!=null) {
//				request.getSession().setAttribute("listaStrumenti", listaStrumentiTemp);			
//				request.getSession().setAttribute("listaStrumentiTemp", listaStrumenti);
//				
//			}else {
				request.getSession().setAttribute("listaStrumentiTemp", listaStrumenti);				
				ArrayList<StrumentoDTO> listaStrumentiFiltrata=GestioneStrumentoBO.getListaStrumentiInFuoriServizio(id_cliente, id_sede, idCompany.getId(), session,utente, 7227);
				request.getSession().setAttribute("listaStrumenti", listaStrumentiFiltrata);
				request.getSession().setAttribute("listaStrumentiAnn", listaStrumentiFiltrata);
				
	//		}
				
				  session.getTransaction().commit();
					session.close();

			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaStrumentiSede.jsp");
		    dispatcher.forward(request,response);
		    
		  
			
		}
		else if(action.equals("note_strumento")) {
			
			String id = request.getParameter("id_str");
			StrumentoDTO strumento = GestioneStrumentoBO.getStrumentoById(id, session);

			
			request.getSession().setAttribute("lista_note", strumento.getListaNoteStrumento());
			request.getSession().setAttribute("id_strum", id);
			
			session.getTransaction().commit();
			session.close();
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaNoteStrumento.jsp");
		    dispatcher.forward(request,response);
		    
		}
		else if(action.equals("nuovo_strumento_general")) {
			
			CompanyDTO idCompany=(CompanyDTO)request.getSession().getAttribute("usrCompany");
			List<ClienteDTO> listaClientiFull = GestioneAnagraficaRemotaBO.getListaClienti(idCompany.getId()+"");
			
			List<SedeDTO> listaSediFull = GestioneAnagraficaRemotaBO.getListaSedi();
			
			String idCliente = request.getParameter("idCliente");
			String idSede = request.getParameter("idSede");
			
			if(idCliente==null || idCliente.equals("")) {
				idCliente="0";
			}
			
			if(idSede==null || idSede.equals("")) {
				idSede="0";
			}
			
			request.getSession().setAttribute("listaSediGeneral",listaSediFull);
			
			request.getSession().setAttribute("listaClientiGeneral", listaClientiFull);
			
			
			ArrayList<TipoStrumentoDTO> listaTipoStrumento = GestioneTLDAO.getListaTipoStrumento(session);
			ArrayList<TipoRapportoDTO> listaTipoRapporto = GestioneTLDAO.getListaTipoRapporto(session);
			ArrayList<StatoStrumentoDTO> listaStatoStrumento = GestioneTLDAO.getListaStatoStrumento(session);
			ArrayList<LuogoVerificaDTO> listaLuogoVerifica = GestioneTLDAO.getListaLuogoVerifica(session);
			ArrayList<ClassificazioneDTO> listaClassificazione = GestioneTLDAO.getListaClassificazione(session);
			
			
	        request.getSession().setAttribute("listaTipoStrumento",listaTipoStrumento);
	        request.getSession().setAttribute("listaStatoStrumento",listaStatoStrumento);
	        request.getSession().setAttribute("listaTipoRapporto",listaTipoRapporto);
	        request.getSession().setAttribute("listaLuogoVerifica",listaLuogoVerifica);
	        request.getSession().setAttribute("listaClassificazione",listaClassificazione);
	        request.getSession().setAttribute("id_Cliente",idCliente);
	        request.getSession().setAttribute("id_Sede",idSede);
			
			session.getTransaction().commit();
			session.close();
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/nuovoStrumentoGeneral.jsp");
		    dispatcher.forward(request,response);
		}
			 
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
