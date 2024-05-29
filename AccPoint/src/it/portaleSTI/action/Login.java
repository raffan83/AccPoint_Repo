package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneAccessoDAO;
import it.portaleSTI.DAO.GestioneMagazzinoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.BachecaDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoTrendDTO;
import it.portaleSTI.DTO.TrendDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneBachecaBO;
import it.portaleSTI.bo.GestioneStrumentoBO;
import it.portaleSTI.bo.GestioneTrendBO;
import it.portaleSTI.bo.GestioneUtenteBO;
import it.portaleSTI.bo.GestioneVersionePortaleBO;

/**
 * Servlet implementation class Login
 */
@WebServlet("/login.do")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(Login.class);
    /**
     * Default constructor. 
     */
    public Login() {
     
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// TODO Auto-generated method stub
			if(request.getSession().getAttribute("userObj")!=null)
	        {
				
				UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
				Session hsession = SessionFacotryDAO.get().openSession();
				RequestDispatcher dispatcher;
				
				GestioneUtenteBO.updateUltimoAccesso(utente.getId());
				
				 
			        
				if(utente.checkRuolo("CL")) {
	
	
					
					
					ArrayList<StrumentoDTO> listaStrumentiPerSede;
					
						listaStrumentiPerSede = GestioneStrumentoBO.getListaStrumentiPerGrafici(""+utente.getIdCliente(),""+utente.getIdSede(),utente.getCompany().getId(),utente);
				
					
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
	
					for(StrumentoDTO strumentoDTO: listaStrumentiPerSede) {
	
						if(statoStrumenti.containsKey(strumentoDTO.getStato_strumento().getNome())) {
							Integer iter = statoStrumenti.get(strumentoDTO.getStato_strumento().getNome());
							iter++;
							statoStrumenti.put(strumentoDTO.getStato_strumento().getNome(), iter);
						}else {
							statoStrumenti.put(strumentoDTO.getStato_strumento().getNome(), 1);
						}
						
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
	
			        JsonElement obj = gson.toJsonTree(listaStrumentiPerSede);
			       
			        if(listaStrumentiPerSede!=null && listaStrumentiPerSede.size()>0){
			            myObj.addProperty("success", true);
			        }
			        else {
			            myObj.addProperty("success", false);
			        }
	
	
			        myObj.add("dataInfo", obj);
			        
			        request.getSession().setAttribute("myObj",myObj);
			        request.getSession().setAttribute("id_Cliente",utente.getIdCliente());
			        request.getSession().setAttribute("id_Sede",utente.getIdSede());
			      
			     
			        
					dispatcher = getServletContext().getRequestDispatcher("/site/dashboardCliente.jsp");
					
				}else {
					ArrayList<TipoTrendDTO> tipoTrend = (ArrayList<TipoTrendDTO>)GestioneTrendBO.getListaTipoTrendAttivi(hsession);
					String tipoTrendJson = new Gson().toJson(tipoTrend);
	
					ArrayList<TrendDTO> trend = (ArrayList<TrendDTO>)GestioneTrendBO.getListaTrendAttiviUser(""+utente.getCompany().getId(),hsession);
					Gson gson = new GsonBuilder().setDateFormat("M/yyyy").create();
					String trendJson = gson.toJson(trend);
	
					
					request.getSession().setAttribute("tipoTrend", tipoTrend);
					request.getSession().setAttribute("trend", trend);
					request.getSession().setAttribute("trendJson", trendJson);
					request.getSession().setAttribute("tipoTrendJson", tipoTrendJson);
					
					
					
					dispatcher = getServletContext().getRequestDispatcher("/site/dashboard.jsp");
				}
				
				
			
		 		
				
		 		
		 		
		    		dispatcher.forward(request,response);
	        }else {
	        		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
				dispatcher.forward(request,response);
	        }
	    	} catch (Exception e) {
			
				e.printStackTrace();
				   request.setAttribute("error",STIException.callException(e));
		       	     request.getSession().setAttribute("exception", e);
		    		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		    	     dispatcher.forward(request,response);	
		} 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
	//	if(Utility.validateSession(request,response,getServletContext()))return;
		Session session = SessionFacotryDAO.get().openSession();

		try{
			
		    response.setContentType("text/html");
	        
		    String user=request.getParameter("uid");
	        String pwd=request.getParameter("pwd");
	        
	        UtenteDTO utente=GestioneAccessoDAO.controllaAccesso(user,pwd);
	        
	        String versione_portale = GestioneVersionePortaleBO.getVersioneCorrente(session);
	        request.getSession().setAttribute("versione_portale",versione_portale);
	        
	        if(utente!=null && utente.getAbilitato()==1)
	        {
	        	
	        	 RequestDispatcher dispatcher;
	        	 GestioneUtenteBO.updateUltimoAccesso(utente.getId());
	        	 if(utente.getPrimoAccesso()==1) {
	        		 request.getSession().setAttribute("old_password",Utility.encryptData(pwd));
	        		 request.getSession().setAttribute("id_utente",Utility.encryptData(String.valueOf(utente.getId())));
	        		 dispatcher = getServletContext().getRequestDispatcher("/site/passwordResetOld.jsp");
	        		 dispatcher.forward(request,response);
	        		
	        	}else {
 	        	 request.setAttribute("forward","site/home.jsp"); 	
	        	 request.getSession().setAttribute("nomeUtente","  "+utente.getNominativo());
	        	 request.getSession().setAttribute("idUtente",utente.getId());
	        	 request.getSession().setAttribute("tipoAccount",utente.getTipoutente());
	        	 
	        	// utente.setPassw("");
	        	 utente.setIdFirma("");
	        	 
	        	 utente.getCompany().setPwd_pec("");
	        	 utente.getCompany().setEmail_pec("");
	        	 utente.getCompany().setHost_pec("");
	        	 
	        	 request.getSession().setAttribute("userObj", utente);
	        	 request.getSession().setAttribute("usrCompany", utente.getCompany());
	        	
	        	 String urlStatico =(String)request.getSession().getAttribute("urlStatico");
	        	 request.getSession().setAttribute("urlStatico","");
	        	
	        	
	        	
	        	if(urlStatico!=null && urlStatico.length()>0)
	        	{
	        		dispatcher = getServletContext().getRequestDispatcher(urlStatico);
	        	}
	        	else
	        	{ 
	        		if(utente.checkRuolo("CL")) {
	        			
	        			
						
				
						ArrayList<StrumentoDTO> listaStrumentiPerSede;
						
							listaStrumentiPerSede = GestioneStrumentoBO.getListaStrumentiPerGrafici(""+utente.getIdCliente(),""+utente.getIdSede(),utente.getCompany().getId(),utente);
					
						
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
		
						for(StrumentoDTO strumentoDTO: listaStrumentiPerSede) {
		
							if(statoStrumenti.containsKey(strumentoDTO.getStato_strumento().getNome())) {
								Integer iter = statoStrumenti.get(strumentoDTO.getStato_strumento().getNome());
								iter++;
								statoStrumenti.put(strumentoDTO.getStato_strumento().getNome(), iter);
							}else {
								statoStrumenti.put(strumentoDTO.getStato_strumento().getNome(), 1);
							}
							
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
		
				        JsonElement obj = gson.toJsonTree(listaStrumentiPerSede);
				       
				        if(listaStrumentiPerSede!=null && listaStrumentiPerSede.size()>0){
				            myObj.addProperty("success", true);
				        }
				        else {
				            myObj.addProperty("success", false);
				        }
		
		
				        myObj.add("dataInfo", obj);
				        
				        request.getSession().setAttribute("myObj",myObj);
				        request.getSession().setAttribute("id_Cliente",utente.getIdCliente());
				        request.getSession().setAttribute("id_Sede",utente.getIdSede());
				       
		
						dispatcher = getServletContext().getRequestDispatcher("/site/dashboardCliente.jsp");
						
					}else {
 
			        		ArrayList<TipoTrendDTO> tipoTrend = (ArrayList<TipoTrendDTO>)GestioneTrendBO.getListaTipoTrendAttivi(session);
			        		String tipoTrendJson = new Gson().toJson(tipoTrend);
		
			        		ArrayList<TrendDTO> trend = (ArrayList<TrendDTO>)GestioneTrendBO.getListaTrendAttiviUser(""+utente.getCompany().getId(),session);
			        		Gson gson = new GsonBuilder().setDateFormat("M/yyyy").create();
			        		String trendJson = gson.toJson(trend);
		
			        		ArrayList<BachecaDTO> lista_messaggi = GestioneBachecaBO.getMessaggiPerUtente(utente.getId(), session);
							request.getSession().setAttribute("lista_messaggi", lista_messaggi);
							
							ArrayList<String> lista_pacchi = GestioneMagazzinoDAO.getItemInRitardo(true, session);
							
			        		request.getSession().setAttribute("tipoTrend", tipoTrend);
			        		request.getSession().setAttribute("trend", trend);
			        		request.getSession().setAttribute("trendJson", trendJson);
			        		request.getSession().setAttribute("tipoTrendJson", tipoTrendJson);
			        		request.getSession().setAttribute("tipoTrendJson", tipoTrendJson);
			        		request.getSession().setAttribute("lista_pacchi_grafico", lista_pacchi);
			        		
			        		
			        		dispatcher = getServletContext().getRequestDispatcher("/site/dashboard.jsp");
					}
	        	}
	        	dispatcher.forward(request,response);
	        }
	        }
	        else if(utente != null && utente.getAbilitato()==0)
	        {
		        String action = 	(String) request.getParameter("action");
		        	if(action == null) {
	                request.setAttribute("errorMessage", "Utente non attivo");
		        	}
		        	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
		            dispatcher.forward(request,response);
		      
			}else{
				 String action = 	(String) request.getParameter("action");
		        	if(action == null) {
	                request.setAttribute("errorMessage", "Username o Password non validi");
		        	}
		        	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
		            dispatcher.forward(request,response);
		             
		      }
			}
		catch(Exception ex)
    	{
    	     request.setAttribute("error",STIException.callException(ex));
       	     request.getSession().setAttribute("exception", ex);
    		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
    	     dispatcher.forward(request,response);	
    	}  
	}

	

}
