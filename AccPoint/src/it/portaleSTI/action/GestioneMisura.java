package it.portaleSTI.action;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
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
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import atg.taglib.json.util.JSONObject;
import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneMisuraDAO;
import it.portaleSTI.DAO.GestioneSessioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.ForCorsoCatDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
import it.portaleSTI.DTO.ForDocenteDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.MisuraWebDTO;
import it.portaleSTI.DTO.SchedaConsegnaDTO;
import it.portaleSTI.DTO.SessioneDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateReportAccredia;
import it.portaleSTI.bo.CreateSchedaConsegnaMetrologia;
import it.portaleSTI.bo.GestioneCertificatoBO;
import it.portaleSTI.bo.GestioneFormazioneBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneMisuraBO;
import it.portaleSTI.bo.GestioneSessioneBO;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class GestioneMisura
 */
@WebServlet("/gestioneMisura.do")
public class GestioneMisura extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(GestioneMisura.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneMisura() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		String action = request.getParameter("action");
		UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
		CompanyDTO company =(CompanyDTO)request.getSession().getAttribute("usrCompany");
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
		
		try {
			
			logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo());
			
			if(action.equals("lista")) {
							
				String date_from = request.getParameter("date_from");
				String date_to = request.getParameter("date_to");
				
				Date end = null;
				Date start = null;
				
				
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");	
				if(date_from == null) {
					end = new Date();
					
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(end);
					calendar.add(Calendar.DAY_OF_MONTH, -30);
					
					start = calendar.getTime();
				}else {
					
					
					end = df.parse(date_to);
					start = df.parse(date_from);	
					
				}
								
				ArrayList<String> lista_misure = DirectMySqlDAO.getListaMisureFromDate(df.format(start), df.format(end),utente);
				
				df = new SimpleDateFormat("dd/MM/yyyy");	
				request.getSession().setAttribute("lista_misure", lista_misure);
				request.getSession().setAttribute("date_to", df.format(end));
				request.getSession().setAttribute("date_from", df.format(start));
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaMisureGeneral.jsp");
		     	dispatcher.forward(request,response);
				
			}
			
			else if(action.equals("crea_report_accredia")) {
				
				String date_from = request.getParameter("date_from");
				String date_to = request.getParameter("date_to");
				
				
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");	
				Date end = df.parse(date_to);
				Date start = df.parse(date_from);	
				ArrayList<MisuraDTO> lista_misure = GestioneMisuraBO.getListaMisurePerData(start, end, true, session);
				
				new CreateReportAccredia(lista_misure, date_from, date_to, session);
				
				SimpleDateFormat output = new SimpleDateFormat("ddMMyyyy");
				Date dateValueFrom = df.parse(date_from);
				Date dateValueTo = df.parse(date_to);
				
				String path = Costanti.PATH_FOLDER+"\\ReportAccredia\\"+output.format(dateValueFrom)+output.format(dateValueTo)+".pdf";
				
				 File file = new File(path);
					
					FileInputStream fileIn = new FileInputStream(file);

					ServletOutputStream outp = response.getOutputStream();
					response.setContentType("application/octet-stream");
					response.setHeader("Content-Disposition","attachment;filename="+ output.format(dateValueFrom)+output.format(dateValueTo)+".pdf");
			
					    byte[] outputByte = new byte[1];
					    
					    while(fileIn.read(outputByte, 0, 1) != -1)
					    {
					    	outp.write(outputByte, 0, 1);
					    }
					    				    
					 
					    fileIn.close();
					    outp.flush();
					    outp.close();
				
				session.close();
				
				
			}else if(action.equals("download_condizioni_ambientali")) {
				
				String id_misura = request.getParameter("id_misura");
				
				id_misura = Utility.decryptData(id_misura);
				
				MisuraDTO misura = GestioneMisuraBO.getMiruraByID(Integer.parseInt(id_misura), session);
				
				String path = Costanti.PATH_FOLDER+misura.getIntervento().getNomePack()+"\\CondizioniAmbientali\\"+misura.getFile_condizioni_ambientali();
				
				 File file = new File(path);
					
					FileInputStream fileIn = new FileInputStream(file);

					ServletOutputStream outp = response.getOutputStream();
					response.setContentType("application/octet-stream");
					response.setHeader("Content-Disposition","attachment;filename="+ misura.getFile_condizioni_ambientali());
			
					    byte[] outputByte = new byte[1];
					    
					    while(fileIn.read(outputByte, 0, 1) != -1)
					    {
					    	outp.write(outputByte, 0, 1);
					    }
					    				    
					 
					    fileIn.close();
					    outp.flush();
					    outp.close();
				
				session.close();
			}
			
			else if(action.equals("modifica_certificato")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		       
				FileItem fileItem = null;
				String filename= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     filename = item.getName();
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
		        //String id_corso = request.getParameter("id_corso");
		        String id_certificato = ret.get("id_certificato");
				String numero_certificato = ret.get("numero_certificato");
				String data_emissione = ret.get("data_emissione");
				String note = ret.get("note");
				
				CertificatoDTO certificato = GestioneCertificatoBO.getCertificatoById(id_certificato,session);
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				if(data_emissione!=null && !data_emissione.equals("")) {
					certificato.setDataCreazione(df.parse(data_emissione));
				}
				
				certificato.getMisura().setnCertificato(numero_certificato);
				certificato.getMisura().setDataUpdate(new Date());
				certificato.getMisura().setUserModifica(utente);
				certificato.getMisura().setNotaModifica(note);
				
				if(certificato.getMisura().getMisuraLAT()!=null) {
					certificato.getMisura().getMisuraLAT().setnCertificato(numero_certificato);
					session.update(certificato.getMisura().getMisuraLAT());
				}
				
				
				session.update(certificato.getMisura());
				session.update(certificato);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Certificato modificato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
				
			}
			
			else if(action.equals("aggiorna_indice_prestazione")) {
				
				
				ajax = true;
				String id_misura = request.getParameter("id_misura");
				String stato = request.getParameter("stato");
				
				if(stato.equals("0")) {
					stato = null;
				}
								
				String id_strumento = "";
				MisuraDTO misura = GestioneMisuraBO.getMiruraByID(Integer.parseInt(id_misura), session);
				misura.setIndice_prestazione(stato);
				if(misura.getStrumento().getDataUltimaVerifica() == null || misura.getStrumento().getDataUltimaVerifica().equals(misura.getDataMisura())) {
					misura.getStrumento().setIndice_prestazione(stato);
					id_strumento = misura.getStrumento().get__id()+"";
				}
				
				session.update(misura);
				session.update(misura.getStrumento());
				
				myObj.addProperty("success", true);
				myObj.addProperty("id_strumento", id_strumento);
				
				session.getTransaction().commit();
				session.close();
				
				PrintWriter out = response.getWriter();
				out.print(myObj);
				
				
			}  else if(action.equals("checkInvioPacchettoCliente")){
				 ajax = true;
				
				logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+((UtenteDTO)request.getSession().getAttribute("userObj")).getNominativo());
				
				String idIntervento= request.getParameter("idIntervento");
				String email = request.getParameter("emailCliente");
				
				
				InterventoDTO intervento = GestioneInterventoBO.getIntervento(idIntervento, session);
				CompanyDTO cmp =(CompanyDTO)request.getSession().getAttribute("usrCompany");
				utente = (UtenteDTO)request.getSession().getAttribute("userObj");
				
				ArrayList<CertificatoDTO> listaCertificati = GestioneCertificatoBO.getListaCertificatoByIntervento(new StatoCertificatoDTO(2), intervento,cmp,utente,"N",""+intervento.getId_cliente(),""+intervento.getIdSede());
				
				
				ArrayList<MisuraDTO> listaMisureInt = GestioneInterventoBO.getListaMirureNonObsoleteByIntervento(intervento.getId(),session);
				ArrayList<StrumentoDTO> listaStrumenti = new ArrayList<StrumentoDTO>();
			
				
				for (MisuraDTO misura : listaMisureInt) {
					listaStrumenti.add(misura.getStrumento());
				}
				
				PrintWriter out = response.getWriter();
				
				if(listaStrumenti.size()!=listaCertificati.size()) {
				
				
		        	myObj.addProperty("successo", false);
		        	
				}else {
					myObj.addProperty("successo", true);
				}
				myObj.addProperty("success", true);
			
	
				request.getSession().setAttribute("listaStrumentiInt", listaStrumenti);
				request.getSession().setAttribute("userObj", utente);
				session.getTransaction().commit();
				session.close();
				
				out.print(myObj);
				
				
				
			}  else if (action.equals("inviaPacchettoCliente")) {
			    ajax = true;
			    response.setContentType("text/event-stream");
			    response.setCharacterEncoding("UTF-8");
			    response.setHeader("Cache-Control", "no-cache");
			    response.setHeader("Connection", "keep-alive");
			    PrintWriter out = response.getWriter();
			    SessioneDTO sessione = null;
			    boolean risp = false;
			    
			    
			 //  String urlDestinazione = "http://delivery.stisrl.com/DocumentalWEB/serviceRest.do";
			//	   String urlDestinazione = "http://localhost:8082/DocumentalWEB/serviceRest.do";  //CAMBIARE ANCHE IN ACTION=invalidaSessione
			    
			    long systime=System.currentTimeMillis();
			    

			    try {
			        InterventoDTO intervento = (InterventoDTO) request.getSession().getAttribute("intervento");
			        String email = request.getParameter("email");

			        if (intervento == null) {
			            out.write("data: {\"progress\":100, \"fase\": \"Errore\", \"testo\":\"Sessione scaduta o intervento non trovato\", \"success\":false}\n\n");
			            out.flush();
			            return;
			        }

			        String notaConsegna = request.getParameter("notaConsegnaCliente");
			        String corteseAttenzione = request.getParameter("corteseAttenzione");
			        String stato = request.getParameter("gridRadios");

			        ArrayList<StrumentoDTO> listaStrumenti = (ArrayList<StrumentoDTO>) request.getSession().getAttribute("listaStrumentiInt");
			        if (listaStrumenti == null) {
			            listaStrumenti = new ArrayList<>();
			        }

			        out.write("data: {\"progress\":15, \"fase\":1, \"testo\":\"Generazione scheda consegna...\"}\n\n");
			        out.flush();
			        Thread.sleep(1000);
			        new CreateSchedaConsegnaMetrologia(intervento, notaConsegna, Integer.parseInt(stato), corteseAttenzione, listaStrumenti, session, getServletContext(),systime);

			        File schedaConsegna = new File(Costanti.PATH_FOLDER + File.separator + intervento.getNomePack() + "//SchedaDiConsegna"+systime+ ".pdf");

			        out.write("data: {\"progress\":35, \"fase\":2, \"testo\":\"Recupero misure e certificati...\"}\n\n");
			        out.flush();
			        Thread.sleep(1000);
			        
			        ArrayList<MisuraDTO> listaMisure = GestioneInterventoBO.getListaMirureNonObsoleteByIntervento(intervento.getId(), session);
			     //   ArrayList<MisuraDTO> listaMisure = GestioneInterventoBO.getListaMirureByIntervento(intervento.getId(), session);

			        ArrayList<CertificatoDTO> listaCertificati = new ArrayList<>();
			        for (MisuraDTO mm : listaMisure) {
			            CertificatoDTO cc = GestioneCertificatoBO.getCertificatoByIdMisura("" + mm.getId(), session);
			            listaCertificati.add(cc);
			        }

			        Date today = new Date();
			        Calendar cal = Calendar.getInstance();
			        cal.setTime(today);
			        cal.add(Calendar.DAY_OF_MONTH, 30);
			        Date scadenza = cal.getTime();

			        out.write("data: {\"progress\":55, \"fase\":3, \"testo\":\"Creazione sessione...\"}\n\n");
			        out.flush();
			        Thread.sleep(1000);

			        String sessionId = Utility.generateCredential(1);
			        String username = Utility.generateCredential(2);
			        String password = Utility.generateCredential(3);

			        sessione = new SessioneDTO();
			        sessione.setSession_id(sessionId);
			        sessione.setUsername(username);
			        sessione.setPassword(password);
			        sessione.setDataCreazione(today);
			        sessione.setDataScadenza(scadenza);
			        sessione.setNome_cliente(intervento.getNome_cliente());
			        sessione.setId_cliente(intervento.getId_cliente());
			        sessione.setNome_sede(intervento.getNome_sede());
			        sessione.setId_sede(intervento.getIdSede());
			        sessione.setId_intervento(intervento.getId());
			        sessione.setUser(utente);
			        sessione.setEmail_cliente(email);
			        sessione.setAbilitato(1);

			        ArrayList<MisuraWebDTO> listaMisureWeb = new ArrayList<>();
			        for (int i = 0; i < listaMisure.size(); i++) {
			          
			        	MisuraDTO misura = listaMisure.get(i);
			           
			        	if(misura.getObsoleto().equals("N")) {
			            
			            MisuraWebDTO web = new MisuraWebDTO();
			            web.setData_misura(misura.getDataMisura());
			            web.setDenominazione_str(misura.getStrumento().getDenominazione());
			            web.setMatricola(misura.getStrumento().getMatricola());
			            web.setCodice_interno(misura.getStrumento().getCodice_interno());
			            web.setCostruttore(misura.getStrumento().getCostruttore());
			            web.setId_certificato(misura.getnCertificato());
			            CertificatoDTO certificato = GestioneCertificatoBO.getCertificatoByIdMisura("" + misura.getId(), session);
			            web.setNome_certificato(misura.getnCertificato()); //LAT....
			            web.setNome_file(certificato.getNomeCertificato());  //CM23255_241...
			            
			            listaMisureWeb.add(web);
			        	
			        	}
			        }

			        sessione.setLista_misure_inviate(new HashSet<>(listaMisure));

			        out.write("data: {\"progress\":70, \"fase\":4, \"testo\":\"Salvataggio su DB di CALVER...\"}\n\n");
			        out.flush();
			        Thread.sleep(1000);

			        //  beginTransaction esplicito
			        session.beginTransaction();
			        GestioneSessioneDAO.saveSession(sessione, session);
			        System.out.println("Salvataggio sessione su Calver effettuato");
			        
			      

			        String pathFileCalver = Costanti.PATH_FOLDER + File.separator + intervento.getNomePack();

			        out.write("data: {\"progress\":85, \"fase\":5, \"testo\":\"Invio file a DocumentalWeb...\"}\n\n");
			        out.flush();

			        risp = inviaFile(listaMisureWeb, sessione, pathFileCalver, schedaConsegna, session, Costanti.URL_DELIVERY);
			        System.out.println("Risposta DocumentalWEB: " + risp);

			     // Integer.parseInt("ciao");
			        
			        if (risp) {
			            out.write("data: {\"progress\":95, \"fase\":6, \"testo\":\"Invio email al cliente...\"}\n\n");
			            out.flush();

			          GestioneSessioneBO.sendEmailClienteDocumentalWeb(schedaConsegna, email, getServletContext(), sessione);
			            
			          SchedaConsegnaDTO scheda = new SchedaConsegnaDTO();
			   	   // InterventoDTO intervento = GestioneInterventoBO.getIntervento(id_intervento);
			   	    scheda.setIntervento(intervento);
			   	    scheda.setNome_file( "SchedaDiConsegna"+systime+ ".pdf");
			   	 DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			   	String dateCar= dateFormat.format(new Date()).toString();
			   	    scheda.setData_caricamento(dateCar);
			   	    scheda.setAbilitato(1);
			   	 session.save(scheda);

			            System.out.println("Email inviata");

			            session.getTransaction().commit();

			            //  Unica risposta finale di successo
			            out.write("data: {\"progress\":100, \"fase\":\"Finita\", \"testo\":\"Completato!\", \"success\":true}\n\n");
			            out.flush();
	

			        } else {
			            session.getTransaction().rollback();
			            //  Unica risposta finale di errore
			            out.write("data: {\"progress\":100, \"fase\":\"Interrotta\", \"testo\":\"Errore durante l'invio a DocumentalWeb\", \"success\":false}\n\n");
			            out.flush();
			        }

			    } catch (Exception e) {
			        e.printStackTrace();
			        logger.error(e);
			        request.getSession().setAttribute("exception", e);
			        boolean rispElimina = false;
			        //eliminare file In Docoumentale chimando funzione  eliminaFileService
			        if(sessione!=null && risp == true) {
			        rispElimina = eliminaFileService(sessione,Costanti.URL_DELIVERY);
			        }
			        System.out.println("risp elimina: " + rispElimina);
			        
			        if (session != null && session.isOpen()
			                && session.getTransaction() != null
			                && session.getTransaction().isActive()) {
			            session.getTransaction().rollback();
			        }

			        //  Risposta SSE di errore formattata correttamente
			        JSONObject obj = new JSONObject();
			        obj.put("progress", 100);
			        obj.put("testo", "Errore durante l'invio\n " + e.getMessage() + "\nEliminazione file binari in DocumentalWEb: " + rispElimina);
			        obj.put("success", false);
			      
			        out.write("data: " + obj.toString() + "\n\n");
			        out.flush();

			    } finally {
			        //  Chiusura sessione sempre garantita, nessuna scrittura sullo stream
			        if (session != null && session.isOpen()) {
			            session.close();
			        }
			    }
			} else if(action.equals("invalidaSessione")) {
			   // String urlDestinazione = "http://delivery.stisrl.com/DocumentalWEB/serviceRest.do";
				 //  String urlDestinazione = "http://localhost:8082/DocumentalWEB/serviceRest.do";
				
				 ajax = true;
				int idSessione = Integer.parseInt(request.getParameter("idSessione"));
				
				SessioneDTO sessione = GestioneSessioneDAO.getSessioneById(idSessione, session);
				
				GestioneSessioneBO.updateAbilitato(sessione,utente,session); //LATO CALVER
				
				//LATO DOCUMENTALWEB
				 boolean rispUpdate = updateAbilitatoFileService(sessione, Costanti.URL_DELIVERY);
				 System.out.println("rsipUpdate: "+rispUpdate  );
				 if (rispUpdate == true) {
						session.getTransaction().commit();
				 }
				 
				 response.setContentType("application/json");
				 response.getWriter().write("{\"successo\": " + rispUpdate + "}");
				
				return;
			}
					
		}catch(Exception e) {
		    
		    try {
		        if (session != null && session.isOpen() && session.getTransaction().isActive()) {
		            session.getTransaction().rollback();
		        }
		    } catch(Exception re) { re.printStackTrace(); }
		    
		    try {
		        if (session != null && session.isOpen()) {
		            session.close();
		        }
		    } catch(Exception ce) { ce.printStackTrace(); }

		    if(ajax) {
		        e.printStackTrace();
		        request.getSession().setAttribute("exception", e);
		        
		        // controlla se stiamo usando SSE
		        String contentType = response.getContentType();
		        if (contentType != null && contentType.contains("text/event-stream")) {
		            // manda errore in formato SSE
		            PrintWriter out = response.getWriter();
		            out.write("data: {\"progress\":100, \"testo\":\"Errore durante l'invio.\", \"success\":false}\n\n");
		            out.flush();
		        } else {
		            // risposta JSON normale come prima
		            PrintWriter out = response.getWriter();
		            myObj = STIException.getException(e);
		            out.print(myObj);
		        }

		    } else {
		        e.printStackTrace();
		        request.setAttribute("error", STIException.callException(e));
		        request.getSession().setAttribute("exception", e);
		        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		        dispatcher.forward(request, response);
		    }
		} finally {
			   if (session != null && session.isOpen()) {
		            session.close();
		        }
		}
		
	}
	
	public static boolean updateAbilitatoFileService(SessioneDTO sessione, String urlDestinazione)  throws Exception  {

		
	    String token = "TOKEN_SEGRETO_123456";
	    String boundary = "----Boundary" + System.currentTimeMillis();
	    
	    
	    HttpURLConnection conn = (HttpURLConnection) new URL(urlDestinazione).openConnection();
	    conn.setDoOutput(true);
	    conn.setRequestMethod("POST");
	    conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
	    conn.setRequestProperty("Authorization", "Bearer " + token);
	    conn.setConnectTimeout(30000);
	    conn.setReadTimeout(120000);
	    conn.setChunkedStreamingMode(8192);
	    
	    

	    
	    String sessionId = sessione.getSession_id();
	  //  String action = gson.toJson("elimina");
	    try (OutputStream output = conn.getOutputStream();
	            PrintWriter writer = new PrintWriter(
	                    new OutputStreamWriter(output, "UTF-8"), true)) {

	           // comando operazione
	           addFormField(writer, boundary, "action", "updateAbilitato");

	           // sessione
	           addFormField(writer, boundary, "sessioneId", sessionId);


	           // chiusura multipart
	           writer.append("--")
	                   .append(boundary)
	                   .append("--")
	                   .append("\r\n");

	           writer.flush();

	       } catch (Exception e) {
	           throw e;
	       }

	
	    int responseCode = conn.getResponseCode();

	    System.out.println("Response Code: " + responseCode);

	    InputStream stream = (responseCode >= 200 && responseCode < 300)
	            ? conn.getInputStream()
	            : conn.getErrorStream();

	    try (BufferedReader reader = new BufferedReader(
	            new InputStreamReader(stream, "UTF-8"))) {

	        String line;
	        StringBuilder response = new StringBuilder();

	        while ((line = reader.readLine()) != null) {
	            response.append(line);
	        }

	        System.out.println("Risposta App B: " + response);
	    }

	    return responseCode == 200;
		
	}
	
	
	
	
	public static boolean eliminaFileService(SessioneDTO sessione, String urlDestinazione)  throws Exception  {

		
	    String token = "TOKEN_SEGRETO_123456";
	    String boundary = "----Boundary" + System.currentTimeMillis();
	    
	    
	    HttpURLConnection conn = (HttpURLConnection) new URL(urlDestinazione).openConnection();
	    conn.setDoOutput(true);
	    conn.setRequestMethod("POST");
	    conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
	    conn.setRequestProperty("Authorization", "Bearer " + token);
	    conn.setConnectTimeout(30000);
	    conn.setReadTimeout(120000);
	    conn.setChunkedStreamingMode(8192);
	    
	    
	    Gson gson = new GsonBuilder()
	            .setDateFormat("dd/MM/yyyy HH:mm")
	            .create();
	    String sessioneJson = gson.toJson(sessione);
	  //  String action = gson.toJson("elimina");
	    
	    try (OutputStream output = conn.getOutputStream();
	            PrintWriter writer = new PrintWriter(
	                    new OutputStreamWriter(output, "UTF-8"), true)) {

	           // comando operazione
	           addFormField(writer, boundary, "action", "elimina");

	        

	           // sessione
	           addFormField(writer, boundary, "sessioneJson", sessioneJson);
	           

	           // id intervento
	           addFormField(writer, boundary,
	                   "interventoId",
	                   String.valueOf(sessione.getId_intervento()));

	           // chiusura multipart
	           writer.append("--")
	                   .append(boundary)
	                   .append("--")
	                   .append("\r\n");

	           writer.flush();

	       } catch (Exception e) {
	           throw e;
	       }

	    int responseCode = conn.getResponseCode();

	    System.out.println("Response Code: " + responseCode);

	    InputStream stream = (responseCode >= 200 && responseCode < 300)
	            ? conn.getInputStream()
	            : conn.getErrorStream();

	    try (BufferedReader reader = new BufferedReader(
	            new InputStreamReader(stream, "UTF-8"))) {

	        String line;
	        StringBuilder response = new StringBuilder();

	        while ((line = reader.readLine()) != null) {
	            response.append(line);
	        }

	        System.out.println("Risposta App B: " + response);
	    }

	    return responseCode == 200;
		
	}
	
	
	
	public static boolean inviaFile(ArrayList<MisuraWebDTO> listaMisure, SessioneDTO sessione, String pathFileCalver, 
	        File schedaConsegna, Session session, String urlDestinazione) throws Exception {

		
	
	    String token = "TOKEN_SEGRETO_123456";
	    String boundary = "----Boundary" + System.currentTimeMillis();

	    List<File> listaCertificatifile = new ArrayList<>();
	    for (int i = 0; i < listaMisure.size(); i++) {
	        File f = new File(pathFileCalver + "\\" + listaMisure.get(i).getNome_file());
	        listaCertificatifile.add(f);
	    }
	    /*
	    for (int i = 0; i < listaMisure.size(); i++) {
	    	listaMisure.get(i).setNome_certificato(listaMisure.get(i).getId_certificato());
	        listaMisure.get(i).setNomeFile(listaMisure.get(i).getId_certificato());
	    }
	    */

	    HttpURLConnection conn = (HttpURLConnection) new URL(urlDestinazione).openConnection();
	    conn.setDoOutput(true);
	    conn.setRequestMethod("POST");
	    conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
	    conn.setRequestProperty("Authorization", "Bearer " + token);
	    conn.setConnectTimeout(30000);
	    conn.setReadTimeout(120000);
	    conn.setChunkedStreamingMode(8192);

	    Gson gson = new GsonBuilder()
	            .setDateFormat("dd/MM/yyyy HH:mm")
	            .create();

	    System.out.println("id cliente (inviaFile): " + sessione.getId_cliente());
	    String misureJson = gson.toJson(listaMisure);
	    String sessioneJson = gson.toJson(sessione);

	    //  Try-with-resources SOLO per l'invio
	    try (OutputStream output = conn.getOutputStream();
	         PrintWriter writer = new PrintWriter(new OutputStreamWriter(output, "UTF-8"), true)) {

	    	System.out.println("misureJson "+ misureJson);
	        addFormField(writer, boundary, "misureJson", misureJson);
	        addFormField(writer, boundary, "sessioneJson", sessioneJson);
	        addFormField(writer, boundary, "interventoId", "" + sessione.getId_intervento());
	        addFilePart(writer, output, boundary, "schedaConsegna", schedaConsegna);

	        for (File f : listaCertificatifile) {
	            addFilePart(writer, output, boundary, "files", f);
	        }

	        //  Boundary di chiusura scritto PRIMA di chiudere lo stream
	        writer.append("--").append(boundary).append("--").append("\r\n");
	        writer.flush();

	    } catch (Exception e) {
	       
	        throw e;
	    }

	    //  Lettura risposta in try-with-resources separato, DOPO aver chiuso l'output
	    int responseCode = conn.getResponseCode();
	    System.out.println("Response Code: " + responseCode);

	    try (BufferedReader reader = new BufferedReader(
	            new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
	    	
	        String line;
	        StringBuilder response = new StringBuilder();
	        while ((line = reader.readLine()) != null) {
	            response.append(line);
	        }
	        System.out.println("Risposta App B: " + response.toString());
	    }

	    return responseCode == 200;
	}

	    private static void addFormField(PrintWriter writer, String boundary, String name, String value) {
	        writer.append("--").append(boundary).append("\r\n");
	        writer.append("Content-Disposition: form-data; name=\"").append(name).append("\"").append("\r\n");
	        writer.append("Content-Type: text/plain; charset=UTF-8").append("\r\n");
	        writer.append("\r\n");
	        writer.append(value).append("\r\n");
	        writer.flush();
	    }
	    	    

	    private static void addFilePart(PrintWriter writer, OutputStream output, String boundary,
	                                    String fieldName, File file) throws IOException {

	        writer.append("--").append(boundary).append("\r\n");
	        writer.append("Content-Disposition: form-data; name=\"")
	                .append(fieldName)
	                .append("\"; filename=\"")
	                .append(file.getName())
	                .append("\"")
	                .append("\r\n");

	        writer.append("Content-Type: application/octet-stream").append("\r\n");
	        writer.append("\r\n");
	        writer.flush();

	        try (FileInputStream input = new FileInputStream(file)) {
	            byte[] buffer = new byte[8192];
	            int bytesRead;

	            while ((bytesRead = input.read(buffer)) != -1) {
	                output.write(buffer, 0, bytesRead);
	            }

	            output.flush();
	        }

	        writer.append("\r\n");
	        writer.flush();
	    }
	    
	    public static String sanitize(String input) {
	        if (input == null) {
	            return "";
	        }

	        return input
	                .trim()                          // rimuove spazi iniziali/finali
	                .replaceAll("\\s+", " ")         // spazi multipli -> singolo spazio
	                .replaceAll("[^\\p{L}\\p{N} .,_-]", ""); 
	                // mantiene lettere, numeri, spazio, punto, virgola, underscore, trattino
	    }
	

	    
	    public static void main(String[] args) {
			System.out.println(sanitize("LAT172M0245/21"));
		}
}
