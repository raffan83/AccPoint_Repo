package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.google.gson.JsonNull;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneStrumentoDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
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
import it.portaleSTI.bo.GestioneMisuraBO;
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

		JsonObject myObjJSON = new JsonObject();
		boolean ajax = true;
		
		try {
		
			if(action==null || action.equals("")) {
				String param = request.getParameter("idSede");
				
				
				
				if(param!=null && param.length()>0 && !param.equals("null"))
				{
					
					String[] tmp=param.split(";");
					
					String idSede;
					String idCliente=tmp[1];
					idCliente = Utility.decryptData(idCliente);
					
					if(tmp[0]!=null && !tmp[0].equalsIgnoreCase("null"))
					{
						idSede=tmp[0].split("_")[0];
						idSede = Utility.decryptData(idSede);
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
					
					String json = gson.toJson(denominazioneStrumenti);  
					request.getSession().setAttribute("denominazioneStrumentiJson", json);
					
					request.getSession().setAttribute("freqStrumentiJson", gson.toJsonTree(freqStrumenti).toString());
					
					json = gson.toJson(repartoStrumenti);  
					request.getSession().setAttribute("repartoStrumentiJson", json);
					
					json = gson.toJson(utilizzatoreStrumenti);  
					request.getSession().setAttribute("utilizzatoreStrumentiJson", json);
					
					
					
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
			        request.getSession().setAttribute("id_Cliente",Utility.encryptData(idCliente));
			        request.getSession().setAttribute("id_Sede",Utility.encryptData(idSede));
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
			String id_company = request.getParameter("id_company");
			
			if(id_company==null) {
				id_company = ""+cmp.getId();
			}
			
			if(id_cliente!=null && !id_cliente.equals("") && id_sede!=null && !id_sede.equals("")) {
				lista_strumenti = GestioneStrumentoDAO.getListaStrumenti(id_cliente,id_sede,Integer.parseInt(id_company),session, user);				
			}else {
				lista_strumenti = GestioneStrumentoBO.getlistaStrumentiFromCompany(Integer.parseInt(id_company),session);	
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
				ArrayList<StrumentoDTO> listaStrumentiFiltrata=GestioneStrumentoBO.getListaStrumentiInFuoriServizio(Utility.decryptData(id_cliente), Utility.decryptData(id_sede), idCompany.getId(), session,utente, 7226);
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
				ArrayList<StrumentoDTO> listaStrumentiFiltrata=GestioneStrumentoBO.getListaStrumentiInFuoriServizio(Utility.decryptData(id_cliente), Utility.decryptData(id_sede), idCompany.getId(), session,utente, 7225);
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
				ArrayList<StrumentoDTO> listaStrumentiFiltrata=GestioneStrumentoBO.getListaStrumentiInFuoriServizio(Utility.decryptData(id_cliente), Utility.decryptData(id_sede), idCompany.getId(), session,utente, 7227);
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
			id = Utility.decryptData(id);
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
			
			List<ClienteDTO> listaClientiFull = (List<ClienteDTO>) request.getSession().getAttribute("listaClientiFull");
			if(listaClientiFull== null) {
				listaClientiFull = GestioneAnagraficaRemotaBO.getListaClienti(idCompany.getId()+"");
			}
		
			
			List<SedeDTO> listaSediFull = (List<SedeDTO>) request.getSession().getAttribute("listaSediFull");
			if(listaSediFull== null) {
				listaSediFull=GestioneAnagraficaRemotaBO.getListaSedi();
			}
			
			
			
			String idCliente = request.getParameter("idCliente");
			String idSede = request.getParameter("idSede");
			
			if(idCliente==null || idCliente.equals("")) {
				idCliente="0";
			}else {
				idCliente = Utility.decryptData(idCliente);
			}
			
			if(idSede==null || idSede.equals("")) {
				idSede="0";
			}else {
				idSede = Utility.decryptData(idSede);
			}
			
			
			
			UtenteDTO user = (UtenteDTO)request.getSession().getAttribute("userObj");
			
			if(user.checkRuolo("CM")) {
				ClienteDTO cliente = GestioneAnagraficaRemotaBO.getClienteById(idCliente);
				listaClientiFull = new ArrayList<ClienteDTO>();
				listaClientiFull.add(cliente);
				
				listaSediFull = GestioneAnagraficaRemotaBO.getSediFromCliente(listaSediFull, cliente.get__id());
				
				
			}
			
			request.getSession().setAttribute("listaClientiGeneral", listaClientiFull);
			request.getSession().setAttribute("listaSediGeneral",listaSediFull);
			
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
	        request.getSession().setAttribute("id_Cliente",Utility.encryptData(idCliente));
	        request.getSession().setAttribute("id_Sede",Utility.encryptData(idSede));
			
			session.getTransaction().commit();
			session.close();
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/nuovoStrumentoGeneral.jsp");
		    dispatcher.forward(request,response);
		}
		else if(action.equals("dettaglioIndicePrestazione")) 
		{ 
			
			
			// Costruisci JSON
			    response.setContentType("application/json");
			    response.setCharacterEncoding("UTF-8");

			    Map<String, String> dati = new HashMap<>();
			    
			    String idStr = request.getParameter("id_str");
			    String id_misura = request.getParameter("id_misura");
			    BigDecimal max = BigDecimal.ZERO;
			    
			    dati.put("puntoRiferimento","ND");
			    dati.put("incertezza", "ND");
			    dati.put("valAccettabilita","ND" );
			    dati.put("indice","ND");
			    dati.put("link", "ND");
			    
				MisuraDTO misura= null;

				if(id_misura!=null && !id_misura.equals("")) {
					misura = GestioneMisuraBO.getMiruraByID(Integer.parseInt(id_misura), session);
					
					dati.put("matricola", misura.getStrumento().getMatricola());
				}else {
					 int id = Integer.parseInt(idStr);
					 
						
					StrumentoDTO strumento=GestioneStrumentoBO.getStrumentoById(idStr, session);
					dati.put("matricola", strumento.getMatricola());
					ArrayList<MisuraDTO> listaMisure = GestioneStrumentoBO.getListaMisureByStrumento(id, session);
				
					
					
					int idMisura=0;
					
					for (MisuraDTO m : listaMisure) {
						
						if(m.getId()>idMisura) 
						{
							misura=m;
							idMisura=m.getId();
						}
						
					}
				}
				
				
				for (PuntoMisuraDTO punto : misura.getListaPunti()) {
						if(!punto.getTipoProva().equals("D")) {
							if(punto.getAccettabilita()!=null && punto.getAccettabilita().compareTo(BigDecimal.ZERO)==1) {
								BigDecimal indice_prestazione = punto.getIncertezza().multiply(new BigDecimal(100)).divide(punto.getAccettabilita(),5,RoundingMode.HALF_UP);
								if(indice_prestazione.compareTo(max)==1) {
									max = indice_prestazione;
									
								    dati.put("puntoRiferimento",punto.getTipoVerifica());
								    String u=punto.getIncertezza().setScale(2,RoundingMode.HALF_UP).toPlainString();
								    String acc=punto.getAccettabilita().setScale(2,RoundingMode.HALF_UP).toPlainString();
								    dati.put("incertezza", u);
								    dati.put("valAccettabilita",acc );
								    dati.put("indice","iP=("+u+" * 100 / "+acc+") ="+ max.setScale(2,RoundingMode.HALF_UP).toPlainString()+"%");
								    dati.put("link", "<td><a href=\"dettaglioMisura.do?idMisura="+Utility.encryptData(""+misura.getId())+"\" target=\"_blank\">"+misura.getId()+"</a></td>");
								}
							}
						}
						
						
								
					}

			    Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
				
				myObjJSON = new JsonObject();
				myObjJSON.add("dati_indice", g.toJsonTree(dati));
				
				PrintWriter  out = response.getWriter();
				myObjJSON.addProperty("success", true);
				
				session.getTransaction().commit();
				session.close();
				
				
				out.print(myObjJSON); 
				out.flush();

		}
		
		else if(action.equals("cambiaStatoIp")) 
		{
			ajax=true;
			PrintWriter out = response.getWriter();
		    response.setContentType("application/json");
			String idStr=request.getParameter("idStrumento");
			int stato =Integer.parseInt(request.getParameter("stato"));
			UtenteDTO user=(UtenteDTO)request.getSession().getAttribute("userObj");
			
			StrumentoNoteDTO note  = new StrumentoNoteDTO();
			note.setId_strumento(Integer.parseInt(idStr));		
			note.setUser(user);
			note.setData(new Date(System.currentTimeMillis()));
			String descrizione="";
			
			if (stato==0) 
			{
				descrizione="Lo strumento è stato disabilitato alla visualizzazione dell Indice di prestazione"; 
			}else 
			{
				descrizione="Lo strumento è stato abilitato alla visualizzazione dell Indice di prestazione";
			}
			note.setDescrizione(descrizione);
			
			boolean success = GestioneStrumentoBO.updateStatoIp(idStr,stato);
			
			success=GestioneStrumentoBO.saveNote(note, session);
			
			StrumentoDTO strumento = GestioneStrumentoBO.getStrumentoById(idStr, session);
			
			String indice =strumento.getIndice_prestazione();
			
			int ip=strumento.getIp();
				
				String message = "";
				if(success){
					message = "Salvato con Successo";
				}else{
					message = "Errore Salvataggio";
				}
				
				session.getTransaction().commit();
				session.close();
				
				JsonObject myObj = new JsonObject();
				
				myObj.addProperty("success", success);
				
				myObj.addProperty("ip", ip);

				if (indice != null) {
				    myObj.addProperty("indice", indice);
				} else {
				    myObj.add("indice", JsonNull.INSTANCE);
				}
				
				myObj.addProperty("messaggio", message);
		        out.println(myObj.toString());
		}
			
		
			 
		}

		catch(Exception ex)
    	{
			
			
		 session.getTransaction().rollback();
		 session.close();
		 
		    if(ajax) {
				
					PrintWriter out = response.getWriter();
					
		        	
		        	request.getSession().setAttribute("exception", ex);
		        	myObjJSON = STIException.getException(ex);
		        	out.print(myObjJSON);
		    	}
		    else {
		    	ex.printStackTrace();
		   	     request.setAttribute("error",STIException.callException(ex));
		   	     request.getSession().setAttribute("exception", ex);
		   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		   	     dispatcher.forward(request,response);	
		    }
   	} 
		
	}

}
