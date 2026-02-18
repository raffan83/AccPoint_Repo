package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.exception.ConstraintViolationException;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.ConfigurazioneClienteDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.StrumentoNoteDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateSchedaListaStrumenti;
import it.portaleSTI.bo.CreateSchedaNoteTecnicheStrumenti;
import it.portaleSTI.bo.GestioneConfigurazioneClienteBO;
import it.portaleSTI.bo.GestioneMagazzinoBO;
import it.portaleSTI.bo.GestioneMisuraBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class DettaglioCampione
 */
@WebServlet(name="gestioneStrumento" , urlPatterns = { "/gestioneStrumento.do" })
@MultipartConfig
public class GestioneStrumento extends HttpServlet {
	private static final long serialVersionUID = 1L;
	boolean ajax=false;
	static final Logger logger = Logger.getLogger(GestioneStrumento.class);
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
		
	try{	
	

		String action=  request.getParameter("action");
		
		logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+((UtenteDTO)request.getSession().getAttribute("userObj")).getNominativo());

		if(action !=null)
		{
			StrumentoDTO strumento = null;
			if(action.equals("toggleFuoriServizio")){
				ajax=true;
				PrintWriter out = response.getWriter();
  		        response.setContentType("application/json");
				strumento = GestioneStrumentoBO.getStrumentoById( request.getParameter("idStrumento"), session);
				
				CompanyDTO idCompany=(CompanyDTO)request.getSession().getAttribute("usrCompany");
				UtenteDTO user=(UtenteDTO)request.getSession().getAttribute("userObj");
				
				
				//ArrayList<StrumentoDTO> listaStrumentiPerSede=GestioneStrumentoBO.getListaStrumentiPerSediAttiviNEW(request.getParameter("idCliente"),request.getParameter("idSede"),idCompany.getId(), session,user); 

				//request.getSession().setAttribute("listaStrumenti", listaStrumentiPerSede);
				
				StrumentoNoteDTO noteStrumento = new StrumentoNoteDTO();
					
				noteStrumento.setId_strumento(Integer.parseInt(request.getParameter("idStrumento")));		
				noteStrumento.setUser(user);
				noteStrumento.setData(new Date(System.currentTimeMillis()));
				
				String descrizione="Modifica stato strumento|";
				
				if(strumento.getStato_strumento() != null && (strumento.getStato_strumento().getId() == 7225 || strumento.getStato_strumento().getId() == 7227)){
					strumento.setStato_strumento(new StatoStrumentoDTO(7226, "In serivzio"));
					descrizione=descrizione+"Strumento messo In Servizio";
				}else{
					strumento.setStato_strumento(new StatoStrumentoDTO(7225, "Fuori servizio"));
					descrizione=descrizione+"Strumento messo Fuori Servizio";
				}
				noteStrumento.setDescrizione(descrizione);
				
				
				JsonObject myObj = new JsonObject();
				strumento.setUserModifica(user);
				strumento.setDataModifica(new Date(System.currentTimeMillis()));
				Boolean success = GestioneStrumentoBO.update(strumento, session);
				success=GestioneStrumentoBO.saveNote(noteStrumento, session);
					
					String message = "";
					if(success){
						message = "Salvato con Successo";
					}else{
						message = "Errore Salvataggio";
					}
				
				
					Gson gson = new Gson();
					
					// 2. Java object to JSON, and assign to a String

					
					

						myObj.addProperty("success", success);
						myObj.addProperty("messaggio", message);
				        out.println(myObj.toString());
				        
				        
				        session.getTransaction().commit();
						session.close();

			}else if(action.equals("pdffiltrati")) {
				
				ajax=false;
				String idsStrumenti = request.getParameter("idstrumenti");
				
 				String cliente = request.getParameter("cliente");
				String sede = request.getParameter("sede");
				cliente = Utility.decryptData(cliente);
				sede = Utility.decryptData(sede);
				
				String nome_cliente = request.getParameter("nome_cliente");
				String nome_sede = request.getParameter("nome_sede");
				
				UtenteDTO user=(UtenteDTO)request.getSession().getAttribute("userObj");
				
				ArrayList<StrumentoDTO> arrayStrumenti = GestioneStrumentoBO.getStrumentiByIds(idsStrumenti, session);
				
				ConfigurazioneClienteDTO conf = GestioneConfigurazioneClienteBO.getConfigurazioneClienteFromId(Integer.parseInt(cliente), Integer.parseInt(sede), 0, session);
						
				
				new CreateSchedaListaStrumenti(arrayStrumenti,cliente, sede ,session,getServletContext(), conf,  user, nome_cliente, nome_sede);
				
				
				File output = new File(Costanti.PATH_FOLDER+"//temp//SchedaListastrumenti.pdf");
				
				 FileInputStream fileIn = new FileInputStream(output);
				 
				 response.setContentType("application/octet-stream");
				  
				 response.setHeader("Content-Disposition","attachment;filename=SchedaListastrumenti.pdf");
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    
				    
				    fileIn.close();
				    outp.flush();
				    outp.close();

				    Utility.removeDirectory(new File(Costanti.PATH_FOLDER+"//temp//"));
			 
				    session.getTransaction().commit();
					session.close();
				
				
			}
			else if(action.equals("note_tecniche_strumenti")) {
				
				
				ajax=false;
				String idsStrumenti = request.getParameter("idstrumenti");
				
 				String cliente = request.getParameter("cliente");
				String sede = request.getParameter("sede");
				String nome_cliente = request.getParameter("nome_cliente");
				String nome_sede = request.getParameter("nome_sede");
				
				UtenteDTO user=(UtenteDTO)request.getSession().getAttribute("userObj");
				
				ArrayList<StrumentoDTO> arrayStrumenti = GestioneStrumentoBO.getStrumentiByIds(idsStrumenti, session);
				
			
				new CreateSchedaNoteTecnicheStrumenti(arrayStrumenti,cliente, sede ,session,getServletContext(),  user, nome_cliente, nome_sede);
				
				
				File output = new File(Costanti.PATH_FOLDER+"//temp//SchedaNoteTecnicheStrumenti.pdf");
				
				 FileInputStream fileIn = new FileInputStream(output);
				 
				 response.setContentType("application/octet-stream");
				  
				 response.setHeader("Content-Disposition","attachment;filename=SchedaNoteTecnicheStrumenti.pdf");
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    
				    
				    fileIn.close();
				    outp.flush();
				    outp.close();

				    session.getTransaction().commit();
					session.close();
				    
				    Utility.removeDirectory(new File(Costanti.PATH_FOLDER+"//temp//"));
			}
			
			else if(action.equals("filtra_misure")) {
			
				ajax=false;
				
				String nome = request.getParameter("nome");
				String marca = request.getParameter("marca");
				String modello = request.getParameter("modello");
				String matricola = request.getParameter("matricola");
				String codice_interno = request.getParameter("codice_interno");
				
				CompanyDTO idCompany=(CompanyDTO)request.getSession().getAttribute("usrCompany");
				
				ArrayList<StrumentoDTO> lista_strumenti_filtrati = GestioneStrumentoBO.getStrumentiFiltrati(nome, marca, modello, matricola, codice_interno, idCompany.getId());

		
				
				if(idCompany!=null)
				{
					
				ArrayList<TipoStrumentoDTO> listaTipoStrumento = GestioneTLDAO.getListaTipoStrumento(session);
				ArrayList<TipoRapportoDTO> listaTipoRapporto = GestioneTLDAO.getListaTipoRapporto(session);
				ArrayList<StatoStrumentoDTO> listaStatoStrumento = GestioneTLDAO.getListaStatoStrumento(session);
				ArrayList<LuogoVerificaDTO> listaLuogoVerifica = GestioneTLDAO.getListaLuogoVerifica(session);
				ArrayList<ClassificazioneDTO> listaClassificazione = GestioneTLDAO.getListaClassificazione(session);

				
				HashMap<String,Integer> statoStrumenti = new HashMap<String,Integer>();
				HashMap<String,Integer> denominazioneStrumenti = new HashMap<String,Integer>();
				HashMap<String,Integer> tipoStrumenti = new HashMap<String,Integer>();
				HashMap<String,Integer> freqStrumenti = new HashMap<String,Integer>();
				HashMap<String,Integer> repartoStrumenti = new HashMap<String,Integer>();
				HashMap<String,Integer> utilizzatoreStrumenti = new HashMap<String,Integer>();
				

				Gson gson = new Gson(); 
				
				request.getSession().setAttribute("statoStrumentiJson", gson.toJsonTree(statoStrumenti).toString());
				request.getSession().setAttribute("tipoStrumentiJson", gson.toJsonTree(tipoStrumenti).toString());
				request.getSession().setAttribute("denominazioneStrumentiJson", gson.toJsonTree(denominazioneStrumenti).toString());
				request.getSession().setAttribute("freqStrumentiJson", gson.toJsonTree(freqStrumenti).toString());
				request.getSession().setAttribute("repartoStrumentiJson", gson.toJsonTree(repartoStrumenti).toString());
				request.getSession().setAttribute("utilizzatoreStrumentiJson", gson.toJsonTree(utilizzatoreStrumenti).toString());
				

				PrintWriter out = response.getWriter();
			
				
		        JsonObject myObj = new JsonObject();

		        
		       
		        if(lista_strumenti_filtrati!=null && lista_strumenti_filtrati.size()>0){
		            myObj.addProperty("success", true);
		        }
		        else {
		            myObj.addProperty("success", false);
		        }
		        
		        
//		        ArrayList<MisuraDTO> lista_misure = new ArrayList<MisuraDTO>();
//		        
//		        for(int i=0;i<lista_strumenti_filtrati.size();i++) {
//		        	lista_misure = GestioneStrumentoBO.getListaMisureByStrumento(lista_strumenti_filtrati.get(i).get__id(), session);
//		        	ArrayList<Integer>lista_id_misure = new ArrayList<Integer>();
//		        	for(int j = 0; j<lista_misure.size();j++) {
//		        		lista_id_misure.add(lista_misure.get(j).getId());
//		        	}
//		        		Integer max = Collections.max(lista_id_misure);
//		        	lista_strumenti_filtrati.get(i).setUltimaMisura(GestioneMisuraBO.getMiruraByID(max));
//		        	
//		        }

		        JsonElement obj = gson.toJsonTree(lista_strumenti_filtrati);
		        myObj.add("dataInfo", obj);
		        
		        request.getSession().setAttribute("myObj",myObj);

		        request.getSession().setAttribute("listaTipoStrumento",listaTipoStrumento);
		        request.getSession().setAttribute("listaStatoStrumento",listaStatoStrumento);
		        request.getSession().setAttribute("listaTipoRapporto",listaTipoRapporto);
		        request.getSession().setAttribute("listaLuogoVerifica",listaLuogoVerifica);
		        request.getSession().setAttribute("listaClassificazione",listaClassificazione);

					request.getSession().setAttribute("lista_strumenti_filtrati", lista_strumenti_filtrati);
					
				
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaStrumentiFiltrati.jsp");
				     dispatcher.forward(request,response);

				}
				
				session.getTransaction().commit();
				session.close();
			}
			
//			else if(action.equals("filtra_generali")) {
//				
//				ajax=false;
//				String id = request.getParameter("id");
//				String nome = request.getParameter("nome");
//				String marca = request.getParameter("marca");
//				String modello = request.getParameter("modello");
//				String matricola = request.getParameter("matricola");
//				String codice_interno = request.getParameter("codice_interno");
//				
//				CompanyDTO idCompany=(CompanyDTO)request.getSession().getAttribute("usrCompany");
//				UtenteDTO user=(UtenteDTO)request.getSession().getAttribute("userObj");
//				if(id==null || id.equals("")) {
//					id ="0";
//				}
//				ArrayList<StrumentoDTO> lista_strumenti_filtrati = GestioneStrumentoBO.getStrumentiFiltratiGenerale(Integer.parseInt(id),nome, marca, modello, matricola, codice_interno, idCompany.getId(), user);
//
//				if(idCompany!=null)
//				{
//					
//				ArrayList<TipoStrumentoDTO> listaTipoStrumento = GestioneTLDAO.getListaTipoStrumento(session);
//				ArrayList<TipoRapportoDTO> listaTipoRapporto = GestioneTLDAO.getListaTipoRapporto(session);
//				ArrayList<StatoStrumentoDTO> listaStatoStrumento = GestioneTLDAO.getListaStatoStrumento(session);
//				ArrayList<LuogoVerificaDTO> listaLuogoVerifica = GestioneTLDAO.getListaLuogoVerifica(session);
//				ArrayList<ClassificazioneDTO> listaClassificazione = GestioneTLDAO.getListaClassificazione(session);
//
//				
//				HashMap<String,Integer> statoStrumenti = new HashMap<String,Integer>();
//				HashMap<String,Integer> denominazioneStrumenti = new HashMap<String,Integer>();
//				HashMap<String,Integer> tipoStrumenti = new HashMap<String,Integer>();
//				HashMap<String,Integer> freqStrumenti = new HashMap<String,Integer>();
//				HashMap<String,Integer> repartoStrumenti = new HashMap<String,Integer>();
//				HashMap<String,Integer> utilizzatoreStrumenti = new HashMap<String,Integer>();
//				
//
//				Gson gson = new Gson(); 
//				
//				request.getSession().setAttribute("statoStrumentiJson", gson.toJsonTree(statoStrumenti).toString());
//				request.getSession().setAttribute("tipoStrumentiJson", gson.toJsonTree(tipoStrumenti).toString());
//				request.getSession().setAttribute("denominazioneStrumentiJson", gson.toJsonTree(denominazioneStrumenti).toString());
//				request.getSession().setAttribute("freqStrumentiJson", gson.toJsonTree(freqStrumenti).toString());
//				request.getSession().setAttribute("repartoStrumentiJson", gson.toJsonTree(repartoStrumenti).toString());
//				request.getSession().setAttribute("utilizzatoreStrumentiJson", gson.toJsonTree(utilizzatoreStrumenti).toString());
//				
//
//				PrintWriter out = response.getWriter();
//			
//				
//		        JsonObject myObj = new JsonObject();
//
//		        
//		       
//		        if(lista_strumenti_filtrati!=null && lista_strumenti_filtrati.size()>0){
//		            myObj.addProperty("success", true);
//		        }
//		        else {
//		            myObj.addProperty("success", false);
//		        }
//		        
//		        
////		        ArrayList<MisuraDTO> lista_misure = new ArrayList<MisuraDTO>();
//		        
////		        for(int i=0;i<lista_strumenti_filtrati.size();i++) {
////		        	lista_misure = GestioneStrumentoBO.getListaMisureByStrumento(lista_strumenti_filtrati.get(i).get__id(), session);
////		        	ArrayList<Integer>lista_id_misure = new ArrayList<Integer>();
////		        	for(int j = 0; j<lista_misure.size();j++) {
////		        		lista_id_misure.add(lista_misure.get(j).getId());
////		        	}
////		        	if(lista_id_misure.size()>0) {
////		        		Integer max = Collections.max(lista_id_misure);
////		        	lista_strumenti_filtrati.get(i).setUltimaMisura(GestioneMisuraBO.getMiruraByID(max));
////		        	}
////		        }
//
//		        JsonElement obj = gson.toJsonTree(lista_strumenti_filtrati);
//		        myObj.add("dataInfo", obj);
//		        
//		        request.getSession().setAttribute("myObj",myObj);
//
//		        request.getSession().setAttribute("listaTipoStrumento",listaTipoStrumento);
//		        request.getSession().setAttribute("listaStatoStrumento",listaStatoStrumento);
//		        request.getSession().setAttribute("listaTipoRapporto",listaTipoRapporto);
//		        request.getSession().setAttribute("listaLuogoVerifica",listaLuogoVerifica);
//		        request.getSession().setAttribute("listaClassificazione",listaClassificazione);
//
//					request.getSession().setAttribute("lista_strumenti_filtrati", lista_strumenti_filtrati);
//					
//					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaStrumentiFiltrati.jsp");
//				     dispatcher.forward(request,response);
//
//				} 
//			}
			
			else if(action.equals("sposta")) {
				
				ajax=true;
				PrintWriter out = response.getWriter();
				 JsonObject myObj = new JsonObject();
				 response.setContentType("application/json");
				 
				String id_strumento = request.getParameter("id_strumento");
				String id_cliente = request.getParameter("id_cliente");
				String id_sede = request.getParameter("id_sede");
				
				
				ArrayList<Integer> lista_pacchi = GestioneMagazzinoBO.getPaccoFromStrumento(id_strumento, session);
				
				if(lista_pacchi.size()==0) {
					strumento = GestioneStrumentoBO.getStrumentoById(id_strumento, session);
					strumento.setId__sede_(Integer.parseInt(id_sede.split("_")[0]));
					strumento.setId_cliente(Integer.parseInt(id_cliente));
					session.update(strumento);
					
					
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Strumento spostato con successo!");
			       
					
				}else {
					myObj.addProperty("success", false);
					myObj.addProperty("pacchi", true);
					if(lista_pacchi.size()==1) {
						myObj.addProperty("messaggio", "Impossibile spostare lo strumento poichè contenuto nel pacco "+lista_pacchi.get(0)+ "!\nRimuovere lo strumento dal pacco e riprovare!");	
					}else {
						
						String s = "Impossibile spostare lo strumento poichè contenuto nei pacchi ";
						for (Integer p : lista_pacchi) {
							s = s + p +", ";
						}
						myObj.addProperty("messaggio", s.substring(0, s.length()-2) + "!\nRimuovere gli strumenti dai pacchi e riprovare!");
					}
					
				}
				session.getTransaction().commit();
				session.close();
				 out.println(myObj);
			}
			else if(action.equals("annullaStrumento")) {
			
				
				ajax=true;
				PrintWriter out = response.getWriter();
  		        response.setContentType("application/json");
  		        
  		        String idStr=Utility.decryptData(request.getParameter("idStrumento"));
  		        
				strumento = GestioneStrumentoBO.getStrumentoById( idStr, session);
				
				CompanyDTO idCompany=(CompanyDTO)request.getSession().getAttribute("usrCompany");
				UtenteDTO user=(UtenteDTO)request.getSession().getAttribute("userObj");
				
				String idCliente=Utility.decryptData(request.getParameter("idCliente"));
				String idSede=Utility.decryptData(request.getParameter("idSede"));
				
				ArrayList<StrumentoDTO> listaStrumentiPerSede=GestioneStrumentoBO.getListaStrumentiPerSediAttiviNEW(idCliente,idSede,idCompany.getId(), session,user); 

				request.getSession().setAttribute("listaStrumenti", listaStrumentiPerSede);
				
				String elimina = request.getParameter("elimina");
				
				Boolean success = true;
				String message = "";
				if(elimina !=null && elimina.equals("1")) {
			
					 try {
					        session.delete(strumento);
					        session.getTransaction().commit();
					        message = "Strumento eliminato con successo!";
							
					    } catch (ConstraintViolationException  e) {
					        success = false;
					        SQLException sqlException = (SQLException) e.getCause();
					        String sqlMessage = sqlException.getMessage();
					        
					        // Regex pattern per estrarre il nome della tabella dal messaggio di errore
					        Pattern pattern = Pattern.compile("a foreign key constraint fails \\(`[^`]+`\\.([^,]+),");
					        Matcher matcher = pattern.matcher(sqlMessage);

					        if (matcher.find()) {
					            String referencedTable = matcher.group(1).trim();
					            message = "Eliminazione non riuscita a causa di vincoli referenziali sulla tabella '" + referencedTable + "'.";
					        } else {
					        	message = "Eliminazione non riuscita a causa di vincoli referenziali: " + sqlMessage;
					        }
					    } catch (Exception e) {
					        success = false;
					        message = "Eliminazione non riuscita: " + e.getMessage();
					    }
					 
					 session.close();
				}else {
					strumento.setStato_strumento(new StatoStrumentoDTO(7227, "Annullato"));
					success = GestioneStrumentoBO.update(strumento, session);
					
					if(success){
						message = "Annullato con Successo";
					}else{
						message = "Errore Salvataggio";
					}
					
					session.getTransaction().commit();
					session.close();
				}
		
			
				JsonObject myObj = new JsonObject();

				
					
					
					
				
				
					Gson gson = new Gson();
					
					// 2. Java object to JSON, and assign to a String

					
					

						myObj.addProperty("success", success);
						myObj.addProperty("messaggio", message);
				        out.println(myObj.toString());
				
			}
			
		

	

		}else{
			ajax=true;
			PrintWriter out = response.getWriter();
 	        response.setContentType("application/json");
			JsonObject myObj = new JsonObject();

			myObj.addProperty("success", false);
			myObj.addProperty("messaggio", "Nessuna action riconosciuta");
	        out.println(myObj.toString());
		}

		 //  session.getTransaction().commit();
		//	session.close();
	}catch(Exception e)
	{
//		 ex.printStackTrace();
//         response.setContentType("application/json");
         PrintWriter out = response.getWriter();
		 JsonObject myObj = new JsonObject();
//			request.getSession().setAttribute("exception", ex);
//		
//        session.getTransaction().rollback();
//		session.close();
//		myObj = STIException.getException(ex);
//		out.print(myObj);

		 session.getTransaction().rollback();
     	session.close();
		if(ajax) {
			e.printStackTrace();
			request.getSession().setAttribute("exception", e);
			myObj = STIException.getException(e);
			out.print(myObj);
		
		}else {
		e.printStackTrace();
   	     request.setAttribute("error",STIException.callException(e));
   	  request.getSession().setAttribute("exception", e);
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);
		}
		
	}  
	
	}
	


}
