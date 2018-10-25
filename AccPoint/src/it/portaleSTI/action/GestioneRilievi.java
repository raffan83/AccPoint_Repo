package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.axis2.json.JSONBadgerfishOMBuilder;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import it.portaleSTI.DAO.GestioneMisuraDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.RilParticolareDTO;
import it.portaleSTI.DTO.RilPuntoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.RilAllegatiDTO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.RilPuntoQuotaDTO;
import it.portaleSTI.DTO.RilQuotaDTO;
import it.portaleSTI.DTO.RilQuotaFunzionaleDTO;
import it.portaleSTI.DTO.RilSimboloDTO;
import it.portaleSTI.DTO.RilStatoRilievoDTO;
import it.portaleSTI.DTO.RilTipoRilievoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Strings;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateSchedaRilievo;
import it.portaleSTI.bo.CreateSchedaRilievoExcel;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneRilieviBO;
import it.portaleSTI.bo.GestioneStrumentoBO;


/**
 * Servlet implementation class GestioneRilievi
 */
@WebServlet("/gestioneRilievi.do")
public class GestioneRilievi extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneRilievi() {
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
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		
		String action = request.getParameter("action");
		//PrintWriter out = response.getWriter();
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
        response.setContentType("application/json");
		try {
			if(action.equals("nuovo")) {
				ajax=true;
				PrintWriter out = response.getWriter();
				List<FileItem> items = null;
	            if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

	            		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
	            	}
				
        		
    	 		FileItem fileItem = null;
				
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
    	            	 if (!item.isFormField()) {       		
    	                     fileItem = item;                     
    	            	 }else
    	            	 {
    	                    ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));

    	            	 }
	            }
				
				String cliente = ret.get("cliente");
				String sede = ret.get("sede");
				String commessa = ret.get("commessa");
				
				String disegno = ret.get("disegno");
				String variante = ret.get("variante");
				String fornitore = ret.get("fornitore");
				String apparecchio = ret.get("apparecchio");
			
				String mese_riferimento = ret.get("mese_riferimento");
				String cifre_decimali = ret.get("cifre_decimali");
								
				String tipo_rilievo = ret.get("tipo_rilievo");
				String data_inizio_rilievo = ret.get("data_inizio_rilievo");
				
				RilMisuraRilievoDTO misura_rilievo = new RilMisuraRilievoDTO();
				
				misura_rilievo.setId_cliente_util(Integer.parseInt(cliente));
				misura_rilievo.setId_sede_util(Integer.parseInt(sede.split("_")[0]));
				misura_rilievo.setTipo_rilievo(new RilTipoRilievoDTO(Integer.parseInt(tipo_rilievo), ""));
				misura_rilievo.setCommessa(commessa);
				misura_rilievo.setUtente(utente);
				if(cifre_decimali.equals("")) {
					misura_rilievo.setCifre_decimali(3);
				}else {
					misura_rilievo.setCifre_decimali(Integer.parseInt(cifre_decimali));
				}
				misura_rilievo.setDisegno(disegno);
				misura_rilievo.setVariante(variante);
				misura_rilievo.setFornitore(fornitore);
				misura_rilievo.setApparecchio(apparecchio);
				misura_rilievo.setStato_rilievo(new RilStatoRilievoDTO(1, ""));
				if(!mese_riferimento.equals("")) {
					misura_rilievo.setMese_riferimento(mese_riferimento);
				}
				if(data_inizio_rilievo!=null && !data_inizio_rilievo.equals("")) {
					DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
					Date date = format.parse(data_inizio_rilievo);
					misura_rilievo.setData_inizio_rilievo(date);
				}
				GestioneRilieviBO.saveRilievo(misura_rilievo, session);				
				
				session.getTransaction().commit();
				
				session.close();
				myObj.addProperty("success", true);				
				myObj.addProperty("messaggio", "Misura Rilievo inserita con successo!");
				out.print(myObj);
			}
			else if(action.equals("modifica")) {
				ajax=true;
				PrintWriter out = response.getWriter();
				List<FileItem> items = null;
	            if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

	            		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
	            	}
				
        		
    	 		FileItem fileItem = null;
				
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
    	            	 if (!item.isFormField()) {       		
    	                     fileItem = item;                     
    	            	 }else
    	            	 {
    	                    ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));

    	            	 }
	            }
				
				String cliente = ret.get("mod_cliente");
				String sede = ret.get("mod_sede");
				String commessa = ret.get("mod_commessa");
				String tipo_rilievo = ret.get("mod_tipo_rilievo");
				String data_rilievo = ret.get("mod_data_inizio_rilievo");
				String id_rilievo = ret.get("id_rilievo");
				
				String disegno = ret.get("mod_disegno");
				String variante = ret.get("mod_variante");
				String fornitore = ret.get("mod_fornitore");
				String apparecchio = ret.get("mod_apparecchio");
				String mese_riferimento = ret.get("mod_mese_riferimento");
				String cifre_decimali = ret.get("mod_cifre_decimali");
							
				RilMisuraRilievoDTO misura_rilievo = GestioneRilieviBO.getMisuraRilieviFromId(Integer.parseInt(id_rilievo), session);
				
				misura_rilievo.setId_cliente_util(Integer.parseInt(cliente));
				misura_rilievo.setId_sede_util(Integer.parseInt(sede.split("_")[0]));
				misura_rilievo.setTipo_rilievo(new RilTipoRilievoDTO(Integer.parseInt(tipo_rilievo), ""));
				misura_rilievo.setCommessa(commessa);
				misura_rilievo.setUtente(utente);
				if(cifre_decimali.equals("")) {
					misura_rilievo.setCifre_decimali(3);
				}else {
					misura_rilievo.setCifre_decimali(Integer.parseInt(cifre_decimali));
				}
				misura_rilievo.setDisegno(disegno);
				misura_rilievo.setVariante(variante);
				misura_rilievo.setFornitore(fornitore);
				misura_rilievo.setApparecchio(apparecchio);
				misura_rilievo.setStato_rilievo(new RilStatoRilievoDTO(1, ""));
				if(!mese_riferimento.equals("")) {
					misura_rilievo.setMese_riferimento(mese_riferimento);
				}
				
				if(data_rilievo!=null && !data_rilievo.equals("")) {
					DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
					Date date = format.parse(data_rilievo);
					misura_rilievo.setData_inizio_rilievo(date);
				}
				GestioneRilieviBO.update(misura_rilievo, session);				
				
				session.getTransaction().commit();
				
				session.close();
				myObj.addProperty("success", true);				
				myObj.addProperty("messaggio", "Misura Rilievo modificata con successo!");
				out.print(myObj);
				
			}
			
			else if(action.equals("dettaglio")) {
				ajax=false;
				String id_rilievo = request.getParameter("id_rilievo");
				String cliente_filtro = request.getParameter("cliente_filtro");
				String filtro_rilievi = request.getParameter("filtro_rilievi");
				
				id_rilievo = Utility.decryptData(id_rilievo);
				cliente_filtro = Utility.decryptData(cliente_filtro);
				filtro_rilievi = Utility.decryptData(filtro_rilievi);
				
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(Integer.parseInt(id_rilievo), session);				
				ArrayList<RilParticolareDTO> lista_impronte = GestioneRilieviBO.getListaParticolariPerMisura(Integer.parseInt(id_rilievo), session);
				ArrayList<RilSimboloDTO> lista_simboli = GestioneRilieviBO.getListaSimboli(session);
				ArrayList<RilQuotaFunzionaleDTO> lista_quote_funzionali = GestioneRilieviBO.getListaQuoteFunzionali(session);				
				
				session.close();
				request.getSession().setAttribute("rilievo", rilievo);
				request.getSession().setAttribute("lista_impronte", lista_impronte);
				request.getSession().setAttribute("lista_simboli", lista_simboli);
				request.getSession().setAttribute("lista_quote_funzionali", lista_quote_funzionali);
				request.getSession().setAttribute("filtro_rilievi", filtro_rilievi);
				request.getSession().setAttribute("cliente_filtro", cliente_filtro);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioRilievo.jsp");
		  	    dispatcher.forward(request,response);	
		  	    
		  	    
			}
			else if(action.equals("nuovo_particolare")) {
				ajax = true;
				PrintWriter out = response.getWriter();
				RilMisuraRilievoDTO rilievo = (RilMisuraRilievoDTO)request.getSession().getAttribute("rilievo");
				
				String numero_impronte = request.getParameter("numero_impronte");
				String n_pezzi = request.getParameter("n_pezzi");
				String quote_pezzo = request.getParameter("quote_pezzo");
				String nomi_impronte = request.getParameter("nomi_impronte");
				String ripetizioni = request.getParameter("ripetizioni");
				String note_particolare = request.getParameter("note_particolare");
				int n =0;	
				
				if(numero_impronte.equals("")) {
					numero_impronte = "1";
				}

				
				if(ripetizioni!=null) {
					if(ripetizioni.equals("")) {
						ripetizioni = "1";
					}
					if(quote_pezzo.equals("")) {
						quote_pezzo = "0";
					}
					n=Integer.parseInt(ripetizioni) * Integer.parseInt(quote_pezzo);
				}else {
					if(quote_pezzo!=null && !quote_pezzo.equals("")) {
					n=Integer.parseInt(quote_pezzo);
					}
				}
					for(int i=0; i<Integer.parseInt(numero_impronte);i++) {					
					
						RilParticolareDTO particolare = new RilParticolareDTO();
						particolare.setMisura(rilievo);
						particolare.setNome_impronta("");
						particolare.setNumero_pezzi(Integer.parseInt(n_pezzi));
						particolare.setNote(note_particolare);
						if(nomi_impronte!=null && !nomi_impronte.equals("")) {
							particolare.setNome_impronta(nomi_impronte.split("%")[i]);
						}
						session.save(particolare);
					//	if(quote_pezzo!=null && !quote_pezzo.equals("")) {
							for(int j=0; j<n;j++) {
								RilQuotaDTO quota = new RilQuotaDTO();
								quota.setId_ripetizione(j+1);
								quota.setImpronta(particolare);
								
								session.save(quota);
								for(int k = 0; k<Integer.parseInt(n_pezzi);k++) {
									RilPuntoQuotaDTO punto = new RilPuntoQuotaDTO();
									punto.setId_quota(quota.getId());
									session.save(punto);
								}
							}
							
					//	}					
						
					}
				
				session.getTransaction().commit();
				ArrayList<RilParticolareDTO> lista_impronte = GestioneRilieviBO.getListaParticolariPerMisura(rilievo.getId(), session);
				session.close();
				
				request.getSession().setAttribute("numero_pezzi", n_pezzi);
				request.getSession().setAttribute("lista_impronte", lista_impronte);
				request.getSession().setAttribute("quote_pezzo", quote_pezzo);
				request.getSession().setAttribute("numero_impronte", numero_impronte);
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Particolare aggiunto con successo!");
				out.print(myObj);
				
			}
			
			else if(action.equals("update_celle")) {
				ajax = true;
				
				String data= request.getParameter("data");
				String simbolo = request.getParameter("simbolo");
				String quota_funzionale = request.getParameter("quota_funzionale");
				JsonElement jelement = new JsonParser().parse(data);
				JsonArray json_array = jelement.getAsJsonArray();
				
				int id_quota = json_array.get(0).getAsInt();
					RilQuotaDTO quota = GestioneRilieviBO.getQuotaFromId(id_quota, session);					
						if(json_array.size()>1) {
						String tolleranza_neg = json_array.get(1).getAsString();
						String tolleranza_pos = json_array.get(2).getAsString();
						String coordinata = json_array.get(3).getAsString();
						String val_nominale = json_array.get(5).getAsString();						
						String um = json_array.get(7).getAsString();			
						
						if(tolleranza_neg!=null && !tolleranza_neg.equals("")) {
							quota.setTolleranza_negativa(new BigDecimal(tolleranza_neg.replace(",", ".")));
						}
						if(tolleranza_pos!=null && !tolleranza_pos.equals("")) {
							quota.setTolleranza_positiva(new BigDecimal(tolleranza_pos.replace(",", ".")));
						}						
						quota.setCoordinata(coordinata);
						quota.setUm(um);
						if(val_nominale!=null && !val_nominale.equals("")) {
							quota.setVal_nominale(new BigDecimal(val_nominale.replace(",", ".")));
						}
						if(simbolo!=null && !simbolo.equals("")) {
							quota.setSimbolo(new RilSimboloDTO(Integer.parseInt(simbolo.split("_")[0]), ""));
						}
						if(quota_funzionale!=null && !quota_funzionale.equals("")&& !quota_funzionale.equals("0_nessuna")) {
							quota.setQuota_funzionale(new RilQuotaFunzionaleDTO(Integer.parseInt(quota_funzionale.split("_")[0]), ""));
						}else {
							quota.setQuota_funzionale(null);
						}
						List list = new ArrayList(quota.getListaPuntiQuota());
						Collections.sort(list, new Comparator<RilPuntoQuotaDTO>() {
						    public int compare(RilPuntoQuotaDTO o1, RilPuntoQuotaDTO o2) {
						    	Integer obj1 = o1.getId();
						    	Integer obj2 = o2.getId();
						        return obj1.compareTo(obj2);
						    }
						});
						int j=0;
						if(json_array.size()>0) {
							for(int i=8; i<json_array.size()-1;i++) {
								RilPuntoQuotaDTO punto;
								if(list.size()>0) {
									punto = (RilPuntoQuotaDTO) list.get(j);
								}else {
									punto = new RilPuntoQuotaDTO();
								}
								String pezzo = json_array.get(i).getAsString();
								if(pezzo != null && !pezzo.equals("")) {
									punto.setValore_punto(new BigDecimal(pezzo.replace(",", ".")));
								}else {
									punto.setValore_punto(null);
								}
								punto.setId_quota(quota.getId());
								if(list.size()==0) {
									session.save(punto);
								}
								
								j++;
								
							}
						
						}
						Set<RilPuntoQuotaDTO> foo = new HashSet<RilPuntoQuotaDTO>(list);
						
						TreeSet myTreeSet = new TreeSet();
						myTreeSet.addAll(foo);
						quota.setListaPuntiQuota(myTreeSet);
						session.saveOrUpdate(quota);
						
						session.getTransaction().commit();

						}
						session.close();
		
			}
			else if(action.equals("dettaglio_impronta")) {
				ajax=false;
				String id_impronta = request.getParameter("id_impronta");
				String quote_pezzo = (String)request.getSession().getAttribute("quote_pezzo");
				//Integer n_pezzi = (Integer)request.getSession().getAttribute("numero_pezzi");
				ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(Integer.parseInt(id_impronta), session);
				RilParticolareDTO impronta = GestioneRilieviBO.getImprontaById(Integer.parseInt(id_impronta), session);
				
				for(int i = 0;i<lista_quote.size();i++) {
					List list = new ArrayList(lista_quote.get(i).getListaPuntiQuota());

					Collections.sort(list, new Comparator<RilPuntoQuotaDTO>() {
					    public int compare(RilPuntoQuotaDTO o1, RilPuntoQuotaDTO o2) {
					        // I'm assuming your Employee.id is an Integer not an int.
					        // If you'd like to use int, create an Integer before calling compareTo.
					    	Integer obj1 = o1.getId();
					    	Integer obj2 = o2.getId();
					        return obj1.compareTo(obj2);
					    }
					});
					Set<RilPuntoQuotaDTO> foo = new HashSet<RilPuntoQuotaDTO>(list);
					
					TreeSet myTreeSet = new TreeSet();
					myTreeSet.addAll(foo);
					lista_quote.get(i).setListaPuntiQuota(myTreeSet);
				}
				
				session.close();
				
				if(lista_quote.size()>0) {
					request.getSession().setAttribute("numero_pezzi", lista_quote.get(0).getListaPuntiQuota().size());
				}else {
					request.getSession().setAttribute("numero_pezzi", impronta.getNumero_pezzi());
				}
				request.getSession().setAttribute("lista_quote", lista_quote);
				request.getSession().setAttribute("quote_pezzo", quote_pezzo);
				if(lista_quote.size()>0) {
					request.getSession().setAttribute("listaPuntiQuota", lista_quote.get(getIndexMax(lista_quote)).getListaPuntiQuota());
				}
				boolean isImpronta = false;
				
				if(impronta.getNome_impronta()!=null && !impronta.getNome_impronta().equals("")) {
					isImpronta=true;
				}
				request.getSession().setAttribute("isImpronta", isImpronta);
				request.getSession().setAttribute("particolare", impronta);
				request.getSession().setAttribute("id_impronta", id_impronta);		
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioPuntiQuota.jsp");
		  	    dispatcher.forward(request,response);
			
				
			}
			
			else if(action.equals("calcola_tolleranze")) {
				
				ajax=true;
				PrintWriter out = response.getWriter();
				ArrayList<RilQuotaDTO> lista_quote = (ArrayList<RilQuotaDTO>)request.getSession().getAttribute("lista_quote");
				String val_nominale = request.getParameter("val_nominale");
				String lettera = request.getParameter("lettera");
				String numero = request.getParameter("numero");
				
				request.getSession().setAttribute("lista_quote", lista_quote);	
				BigDecimal tolleranze[] = GestioneRilieviBO.getTolleranze(lettera, Integer.parseInt(numero), new BigDecimal(val_nominale.replace(",", ".")));
				if(tolleranze!=null) {
					myObj.addProperty("success", true);
					if(tolleranze.length>1) {
						myObj.addProperty("tolleranza_pos", tolleranze[0].divide(new BigDecimal(1000)));
						myObj.addProperty("tolleranza_neg", tolleranze[1].divide(new BigDecimal(1000)));
					}
				}else {
					myObj.addProperty("success", false);
					myObj.addProperty("messaggio", "Attenzione! Impossibile calcolare le tolleranze per i valori inseriti!");
				}
				session.close();
				out.print(myObj);
				
			}
			
			else if(action.equals("nuova_quota")) {
				ajax=true;
				PrintWriter out = response.getWriter();
				List<FileItem> items = null;
	            if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

	            		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
	            	}
				
        		
    	 		FileItem fileItem = null;
				
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
    	            	 if (!item.isFormField()) {       		
    	                     fileItem = item;                     
    	            	 }else
    	            	 {
    	                    ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));

    	            	 }
    	        }
		        
				int n_pezzi = (int) request.getSession().getAttribute("numero_pezzi");
				String val_nominale = ret.get("val_nominale");
				String particolare = ret.get("particolare");
				String coordinata = ret.get("coordinata");
				String simbolo = ret.get("simbolo");
				String tolleranza_neg = ret.get("tolleranza_neg");
				String tolleranza_pos = ret.get("tolleranza_pos");
				String quota_funzionale = ret.get("quota_funzionale");
				String lettera = ret.get("lettera");
				String numero = ret.get("numero");
				String id_quota = ret.get("id_quota");
				String um ="";
				if(simbolo.equals("2_ANGOLO")) {
					um = "°";
				}else {
					um = "mm";
				}
				String note_quota = ret.get("note_quota");
				String note_particolare = ret.get("note_part");
				
				GestioneRilieviBO.updateNoteParticolare(Integer.parseInt(particolare), note_particolare, session);
				RilQuotaDTO quota = null;
				
				int ripetizioni = 1;
				if(quota_funzionale!=null && !quota_funzionale.equals("") && !quota_funzionale.equals("0_nessuna")) {			
					if(quota_funzionale.equals("3_F0")) {
						ripetizioni = 5;
						}										
				}
				
				for(int i=0; i<ripetizioni; i++) {
					if(id_quota!=null && !id_quota.equals("")) {
						quota = GestioneRilieviBO.getQuotaFromId(Integer.parseInt(id_quota),session);					
					}else {
						quota = new RilQuotaDTO();
					}
					
					if(quota_funzionale!=null && !quota_funzionale.equals("") && !quota_funzionale.equals("0_nessuna")) {
						quota.setQuota_funzionale(new RilQuotaFunzionaleDTO(Integer.parseInt(quota_funzionale.split("_")[0]), ""));
					}
					else {
						quota.setQuota_funzionale(null);
					}
					quota.setNote(note_quota);
					quota.setImpronta(new RilParticolareDTO(Integer.parseInt(particolare)));
					quota.setCoordinata(coordinata);
					quota.setUm(um);
					quota.setVal_nominale(new BigDecimal(val_nominale.replace(",", ".")));
					if(simbolo!=null && !simbolo.equals("")) {
						quota.setSimbolo(new RilSimboloDTO(Integer.parseInt(simbolo.split("_")[0]),""));
					}
					quota.setTolleranza_negativa(new BigDecimal(tolleranza_neg.replace(",", ".")));
					quota.setTolleranza_positiva(new BigDecimal(tolleranza_pos.replace(",", ".")));
					
					
					if(!lettera.equals("") && !numero.equals("")) {
						quota.setSigla_tolleranza(lettera+numero);
					}
					
					if(id_quota!=null && !id_quota.equals("")) {
						session.update(quota);
					}else {
						session.save(quota);					
					}
				}
				
				if(id_quota!=null && !id_quota.equals("")) {	

					List list = new ArrayList(quota.getListaPuntiQuota());
					Collections.sort(list, new Comparator<RilPuntoQuotaDTO>() {
					    public int compare(RilPuntoQuotaDTO o1, RilPuntoQuotaDTO o2) {
					    	Integer obj1 = o1.getId();
					    	Integer obj2 = o2.getId();
					        return obj1.compareTo(obj2);
					    }
					});
					   for(int i=0; i<list.size();i++) {
						   RilPuntoQuotaDTO punto = (RilPuntoQuotaDTO) list.get(i);
						   String pezzo = ret.get("pezzo_"+(i+1));
						   if(!pezzo.equals("")) {
							punto.setValore_punto(new BigDecimal(pezzo.replace(",", ".")));
							punto.setId_quota(quota.getId());
							session.update(punto);
						   }
					   }
					   if(n_pezzi>quota.getListaPuntiQuota().size()) {
						   for(int j = quota.getListaPuntiQuota().size();j<n_pezzi;j++) {
							   RilPuntoQuotaDTO punto = new RilPuntoQuotaDTO();
							   String pezzo = ret.get("pezzo_"+(j+1));
							   if(!pezzo.equals("")) {
								punto.setValore_punto(new BigDecimal(pezzo.replace(",", ".")));
								punto.setId_quota(quota.getId());
								session.save(punto);
							   }
						   }
					   }
										
				}else {
					for(int i=0; i<n_pezzi;i++) {
						RilPuntoQuotaDTO punto = new RilPuntoQuotaDTO();
						String pezzo = ret.get("pezzo_"+(i+1));
						if(!pezzo.equals("")) {
							punto.setValore_punto(new BigDecimal(pezzo.replace(",", ".")));
							punto.setId_quota(quota.getId());
							session.save(punto);
						}
					}
				}

				session.getTransaction().commit();
				
				ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(Integer.parseInt(particolare), session);
				request.getSession().setAttribute("lista_quote", lista_quote);
				
				session.close();
				
				myObj.addProperty("success", true);		
				if(id_quota!=null && !id_quota.equals("")) {
					myObj.addProperty("messaggio", "Quota modificata con successo!");
				}else {
					myObj.addProperty("messaggio", "Quota inserita con successo!");					
				}
				myObj.addProperty("id_impronta", quota.getImpronta().getId());
				myObj.addProperty("n_pezzi", n_pezzi);
				out.print(myObj);

			}
			
			
			else if(action.equals("nuova_quota_replica")) {
				ajax=true;
				PrintWriter out = response.getWriter();
				List<FileItem> items = null;
	            if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

	            		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
	            	}
				
        		
    	 		FileItem fileItem = null;
				
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
    	            	 if (!item.isFormField()) {       		
    	                     fileItem = item;                     
    	            	 }else
    	            	 {
    	                    ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));

    	            	 }
	            }
				int n_pezzi = (int) request.getSession().getAttribute("numero_pezzi");
				String val_nominale = ret.get("val_nominale");
				String particolare = ret.get("particolare");
				String coordinata = ret.get("coordinata");
				String simbolo = ret.get("simbolo");
				String tolleranza_neg = ret.get("tolleranza_neg");
				String tolleranza_pos = ret.get("tolleranza_pos");
				String quota_funzionale = ret.get("quota_funzionale");
				String lettera = ret.get("lettera");
				String numero = ret.get("numero");
				String id_quota = ret.get("id_quota");
				String um ="";
				if(simbolo.equals("2_ANGOLO")) {
					um = "°";
				}else {
					um = "mm";
				}

				String note_quota = ret.get("note_quota");
				String note_particolare = ret.get("note_part");
				
				GestioneRilieviBO.updateNoteParticolare(Integer.parseInt(particolare), note_particolare, session);
				
				RilQuotaDTO quota = null;
				
				int ripetizioni = 1;
				if(quota_funzionale!=null && !quota_funzionale.equals("") && !quota_funzionale.equals("0_nessuna")) {			
					if(quota_funzionale.equals("3_F0")) {
						ripetizioni = 5;
						}										
				}
								
				int n = 1;
				ArrayList<RilParticolareDTO> lista_impronte = null;
				RilParticolareDTO impr = GestioneRilieviBO.getImprontaById(Integer.parseInt(particolare), session);
				if(impr.getNome_impronta()!=null && !impr.getNome_impronta().equals("")) {
					lista_impronte = GestioneRilieviBO.getListaImprontePerMisura(impr.getMisura().getId(), session); 
					if(id_quota!=null && !id_quota.equals("")) {
						n = 1; 		
					}else {
						n = lista_impronte.size();
					}
				}
				
				for(int i = 0; i<n;i++) {
					for(int t = 0; t<ripetizioni; t++) {
					if(id_quota!=null && !id_quota.equals("")) {
						quota = GestioneRilieviBO.getQuotaFromId(Integer.parseInt(id_quota),session);					
					}else {
						quota = new RilQuotaDTO();
					}

					if((id_quota!=null && !id_quota.equals(""))||impr.getNome_impronta().equals("")) {
						quota.setImpronta(impr);	
					}else {
						quota.setImpronta(lista_impronte.get(i));
					}
					
				quota.setCoordinata(coordinata);
				quota.setUm(um);
				quota.setNote(note_quota);
				quota.setVal_nominale(new BigDecimal(val_nominale.replace(",", ".")));
				if(simbolo!=null && !simbolo.equals("")) {
					quota.setSimbolo(new RilSimboloDTO(Integer.parseInt(simbolo.split("_")[0]),""));
				}
				quota.setTolleranza_negativa(new BigDecimal(tolleranza_neg.replace(",", ".")));
				quota.setTolleranza_positiva(new BigDecimal(tolleranza_pos.replace(",", ".")));
				if(quota_funzionale!=null && !quota_funzionale.equals("") && !quota_funzionale.equals("0_nessuna")) {
					quota.setQuota_funzionale(new RilQuotaFunzionaleDTO(Integer.parseInt(quota_funzionale.split("_")[0]), ""));
				}else {
					quota.setQuota_funzionale(null);
				}
				if(!lettera.equals("") && !numero.equals("")) {
					quota.setSigla_tolleranza(lettera+numero);
				}
				
				if(id_quota!=null && !id_quota.equals("")) {
					
					if(quota.getId_ripetizione()==0) {
						session.update(quota);
					}else {
						GestioneRilieviBO.updateQuota(quota, session);	
					}
					
					
				}else {

					if(impr.getNome_impronta().equals("")) {
						quota.setId_ripetizione(0);
					}else {
						quota.setId_ripetizione((GestioneRilieviBO.getMaxIdRipetizione(lista_impronte.get(i), session))+1);
					}

					session.save(quota);					
				}
				
				if(id_quota!=null && !id_quota.equals("")) {	

					List list = new ArrayList(quota.getListaPuntiQuota());
					Collections.sort(list, new Comparator<RilPuntoQuotaDTO>() {
					    public int compare(RilPuntoQuotaDTO o1, RilPuntoQuotaDTO o2) {
					    	Integer obj1 = o1.getId();
					    	Integer obj2 = o2.getId();
					        return obj1.compareTo(obj2);
					    }
					});
					   for(int h=0; h<list.size();h++) {
						   RilPuntoQuotaDTO punto = (RilPuntoQuotaDTO) list.get(h);
						   String pezzo = ret.get("pezzo_"+(h+1));
						   if(!pezzo.equals("")) {
							punto.setValore_punto(new BigDecimal(pezzo.replace(",", ".")));
							punto.setId_quota(quota.getId());
							session.update(punto);
						   }
					   }
					   if(n_pezzi>quota.getListaPuntiQuota().size()) {
						   for(int j = quota.getListaPuntiQuota().size();j<n_pezzi;j++) {
							   RilPuntoQuotaDTO punto = new RilPuntoQuotaDTO();
							   String pezzo = ret.get("pezzo_"+(j+1));
							   if(!pezzo.equals("")) {
								punto.setValore_punto(new BigDecimal(pezzo.replace(",", ".")));
								punto.setId_quota(quota.getId());
								session.save(punto);
							   }
						   }
					   }
										
				}else {

					if(lista_impronte!=null) {
					
						for(int k=0; k<n_pezzi;k++) {
							RilPuntoQuotaDTO punto = new RilPuntoQuotaDTO();
							if(impr.getId()==lista_impronte.get(i).getId()) {
								String pezzo = ret.get("pezzo_"+(k+1));
								if(!pezzo.equals("")) {
									punto.setValore_punto(new BigDecimal(pezzo.replace(",", ".")));							
								}else {
									punto.setValore_punto(null);	
								}
							}else {
								punto.setValore_punto(null);	
							}
										
								punto.setId_quota(quota.getId());
								session.save(punto);
							}
					
				}else {
						for(int k=0; k<n_pezzi;k++) {
							RilPuntoQuotaDTO punto = new RilPuntoQuotaDTO();
							String pezzo = ret.get("pezzo_"+(k+1));
							if(!pezzo.equals("")) {
								punto.setValore_punto(new BigDecimal(pezzo.replace(",", ".")));							
							}else {
								punto.setValore_punto(null);	
							}
							punto.setId_quota(quota.getId());
							session.save(punto);
						}
					}
				}
				
				}
				}
				session.getTransaction().commit();
				
				ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(Integer.parseInt(particolare), session);
				request.getSession().setAttribute("lista_quote", lista_quote);
				
				session.close();
				
				myObj.addProperty("success", true);		
				if(id_quota!=null && !id_quota.equals("")) {
					myObj.addProperty("messaggio", "Quota modificata con successo!");
				}else {
					myObj.addProperty("messaggio", "Quota inserita con successo!");					
				}
				myObj.addProperty("id_impronta", impr.getId());
				myObj.addProperty("n_pezzi", n_pezzi);
				out.print(myObj);

			}
			
			else if(action.equals("elimina_quota")) {
				
				ajax = true;
				PrintWriter out = response.getWriter();
				String id_quota = request.getParameter("id_quota");
								
				RilQuotaDTO quota = GestioneRilieviBO.getQuotaFromId(Integer.parseInt(id_quota), session);
			
				
				for (RilPuntoQuotaDTO punto : quota.getListaPuntiQuota()) {
					session.delete(punto);
				}
				session.delete(quota);
				session.getTransaction().commit();
				session.close();
				
				myObj.addProperty("success", true);
				myObj.addProperty("id_impronta", quota.getImpronta().getId());
				
				session.close();
				out.print(myObj);
				
			}
			
			else if(action.equals("elimina_quota_replica")) {
				
				ajax = true;
				PrintWriter out = response.getWriter();
				String id_quota = request.getParameter("id_quota");
								
				RilQuotaDTO quota = GestioneRilieviBO.getQuotaFromId(Integer.parseInt(id_quota), session);
			
				ArrayList<RilParticolareDTO> lista_impronte = GestioneRilieviBO.getListaImprontePerMisura(quota.getImpronta().getMisura().getId(), session);
				
				int n = 1; 
				if(lista_impronte.size()>1) {
					n=lista_impronte.size();
				}else {
					lista_impronte = GestioneRilieviBO.getListaParticolariPerMisura(quota.getImpronta().getMisura().getId(), session);
				}
				
				for(int i = 0; i<n;i++) {
					ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(lista_impronte.get(i).getId(), session);
					for (RilQuotaDTO rilQuotaDTO : lista_quote) {
						if(rilQuotaDTO.getId_ripetizione()== quota.getId_ripetizione()) {
							for (RilPuntoQuotaDTO punto : rilQuotaDTO.getListaPuntiQuota()) {
								session.delete(punto);
							}
							session.delete(rilQuotaDTO);
						}
					}
					
				
				}
				
				
				session.getTransaction().commit();
				session.close();
				
				myObj.addProperty("success", true);
				myObj.addProperty("id_impronta", quota.getImpronta().getId());
				
				out.print(myObj);
				
			}
			
			
			else if(action.equals("update_celle_replica")) {
				
				ajax = true;
				
				String data= request.getParameter("data");
				String simbolo = request.getParameter("simbolo");
				String quota_funzionale = request.getParameter("quota_funzionale");
				String particolare = request.getParameter("particolare");
				JsonElement jelement = new JsonParser().parse(data);
				JsonArray json_array = jelement.getAsJsonArray();
				
				if(json_array.get(0)!=null) {
				int id_quota = json_array.get(0).getAsInt();
					RilQuotaDTO quota = GestioneRilieviBO.getQuotaFromId(id_quota, session);
					
						if(json_array.size()>1) {
						String tolleranza_neg = json_array.get(1).getAsString();
						String tolleranza_pos = json_array.get(2).getAsString();
						String coordinata = json_array.get(3).getAsString();
						String val_nominale = json_array.get(5).getAsString();						
						String um = json_array.get(7).getAsString();	
						String note = json_array.get(json_array.size()-1).getAsString();
						
						RilParticolareDTO impr = GestioneRilieviBO.getImprontaById(Integer.parseInt(particolare), session);
						
							ArrayList<RilParticolareDTO> lista_impronte = GestioneRilieviBO.getListaImprontePerMisura(impr.getMisura().getId(), session); 
							
							if(lista_impronte.size()==0) {
								lista_impronte = GestioneRilieviBO.getListaParticolariPerMisura(impr.getMisura().getId(), session);
							}
							
							for (RilParticolareDTO impronta : lista_impronte) {
							
							if(tolleranza_neg!=null && !tolleranza_neg.equals("")) {
								quota.setTolleranza_negativa(new BigDecimal(tolleranza_neg.replace(",", ".")));
							}
							if(tolleranza_pos!=null && !tolleranza_pos.equals("")) {
								quota.setTolleranza_positiva(new BigDecimal(tolleranza_pos.replace(",", ".")));
							}						
							quota.setCoordinata(coordinata);
							quota.setUm(um);
							quota.setNote(note);
							if(val_nominale!=null && !val_nominale.equals("")) {
								quota.setVal_nominale(new BigDecimal(val_nominale.replace(",", ".")));
							}
							if(simbolo!=null && !simbolo.equals("")) {
								quota.setSimbolo(new RilSimboloDTO(Integer.parseInt(simbolo.split("_")[0]), ""));
							}
							if(quota_funzionale!=null && !quota_funzionale.equals("")&& !quota_funzionale.equals("0_nessuna")) {
								quota.setQuota_funzionale(new RilQuotaFunzionaleDTO(Integer.parseInt(quota_funzionale.split("_")[0]), ""));
							}else {
								quota.setQuota_funzionale(null);
							}
							if(quota.getId_ripetizione()==0) {
								session.update(quota);
							}else {
								GestioneRilieviBO.updateQuota(quota, session);
							}
							
						}
						List list = new ArrayList(quota.getListaPuntiQuota());
						Collections.sort(list, new Comparator<RilPuntoQuotaDTO>() {
						    public int compare(RilPuntoQuotaDTO o1, RilPuntoQuotaDTO o2) {
						    	Integer obj1 = o1.getId();
						    	Integer obj2 = o2.getId();
						        return obj1.compareTo(obj2);
						    }
						});
						int j=0;
						if(json_array.size()>0) {
							for(int i=8; i<json_array.size()-1;i++) {
								RilPuntoQuotaDTO punto;
								if(list.size()>0) {
									punto = (RilPuntoQuotaDTO) list.get(j);
								}else {
									punto = new RilPuntoQuotaDTO();
								}
								String pezzo = json_array.get(i).getAsString();
								if(pezzo != null && !pezzo.equals("")) {
									punto.setValore_punto(new BigDecimal(pezzo.replace(",", ".")));
								}else {
									punto.setValore_punto(null);
								}
								punto.setId_quota(quota.getId());
								if(list.size()==0) {
									session.save(punto);
								}
								
								j++;
								
							}
						
						}
						Set<RilPuntoQuotaDTO> foo = new HashSet<RilPuntoQuotaDTO>(list);
						
						TreeSet myTreeSet = new TreeSet();
						myTreeSet.addAll(foo);
						quota.setListaPuntiQuota(myTreeSet);
						session.saveOrUpdate(quota);
						
						session.getTransaction().commit();
						

						}
				}
				session.close();
			}
			
			
			else if(action.equals("chiudi_rilievo")) {
				ajax = true;
				PrintWriter out = response.getWriter();
				String id_rilievo = request.getParameter("id_rilievo");
				
				GestioneRilieviBO.chiudiRilievo(Integer.parseInt(id_rilievo), session);
				session.getTransaction().commit();
				session.close();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Rilievo chiuso con successo!");
				out.print(myObj);
				
			}
			
			else if(action.equals("upload_allegato")) {
								
				ajax = true;				
				PrintWriter out = response.getWriter();
				
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());				
				response.setContentType("application/json");
						
				String id_rilievo = request.getParameter("id_rilievo");
				//String tipo_allegato = request.getParameter("tipo_allegato");
				
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getRilievoFromId(Integer.parseInt(id_rilievo), session);
		
				List<FileItem> items;
				
					items = uploadHandler.parseRequest(request);
					
					for (FileItem item : items) {
						if (!item.isFormField()) {
							if(item.getName()!="") {		
								GestioneRilieviBO.uploadAllegato(item, rilievo.getId(),false,false, session);
								rilievo.setAllegato(item.getName());
							}								
						}
					}
				
					session.update(rilievo);
					session.getTransaction().commit();
					session.close();			
					
					myObj.addProperty("success", true);					
					myObj.addProperty("messaggio", "Allegato caricato con successo!");
					
					out.print(myObj);			
				
			}
			
			else if(action.equals("upload_allegato_img")) {
				
				ajax = true;				
				PrintWriter out = response.getWriter();
				
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());				
				response.setContentType("application/json");
						
				String id_rilievo = request.getParameter("id_rilievo");
				
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getRilievoFromId(Integer.parseInt(id_rilievo), session);
		
				List<FileItem> items;
				
					items = uploadHandler.parseRequest(request);
					
					for (FileItem item : items) {
						if (!item.isFormField()) {
							if(item.getName()!="") {		
								GestioneRilieviBO.uploadAllegato(item, rilievo.getId(),true,false, session);
								rilievo.setImmagine_frontespizio(item.getName());
							}								
						}
					}
				
					session.update(rilievo);
					session.getTransaction().commit();
					session.close();			
					
					myObj.addProperty("success", true);					
					myObj.addProperty("messaggio", "Allegato caricato con successo!");
					
					out.print(myObj);			
				
			}
			
			else if (action.equals("allegati_archivio")) {
				ajax = true;
				String id_rilievo = request.getParameter("id_rilievo");	
			
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(Integer.parseInt(id_rilievo), session);
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
				PrintWriter out = response.getWriter();
				response.setContentType("application/json");						
					
					List<FileItem> items = uploadHandler.parseRequest(request);
					for (FileItem item : items) {
						if (!item.isFormField()) {
							GestioneRilieviBO.uploadAllegato(item, rilievo.getId(),false,true, session);
							RilAllegatiDTO allegato = new RilAllegatiDTO();
							allegato.setNome_file(item.getName());
							allegato.setRilievo(rilievo);
							session.save(allegato);
						}
					}

					session.getTransaction().commit();
					session.close();	
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Upload effettuato con successo!");
					out.print(myObj);
				
			}
			else if (action.equals("download_allegato")) {
				
				ajax = false;
				String id_rilievo= request.getParameter("id_rilievo");
				String isArchivio = request.getParameter("isArchivio");
				String filename = request.getParameter("filename");
				
				id_rilievo = Utility.decryptData(id_rilievo);
				if(filename!= null) {
					filename = Utility.decryptData(filename);
				}
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(Integer.parseInt(id_rilievo), session);
				String path = null;
				if(isArchivio!= null && filename !=null) {
					path = Costanti.PATH_FOLDER +"\\RilieviDimensionali\\Allegati\\Archivio\\"+id_rilievo + "\\" +filename;
				}else {
					path = Costanti.PATH_FOLDER +"\\RilieviDimensionali\\Allegati\\"+id_rilievo + "\\" +rilievo.getAllegato();
				}
				File file = new File(path);
				
				FileInputStream fileIn = new FileInputStream(file);
				 
				 response.setContentType("application/octet-stream");
				  
				 response.setHeader("Content-Disposition","attachment;filename="+ file.getName());
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    
				    session.close();
				    fileIn.close();
				    outp.flush();
				    outp.close();
				
			}
			
			else if (action.equals("download_immagine")) {
				
				ajax = false;
				String id_rilievo= request.getParameter("id_rilievo");
				
				id_rilievo = Utility.decryptData(id_rilievo);
				
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(Integer.parseInt(id_rilievo), session);
				
				String path = Costanti.PATH_FOLDER +"\\RilieviDimensionali\\Allegati\\Immagini\\"+id_rilievo + "\\" +rilievo.getImmagine_frontespizio();
				File file = new File(path);
				
				FileInputStream fileIn = new FileInputStream(file);
				 
				 response.setContentType("application/octet-stream");
				  
				 response.setHeader("Content-Disposition","attachment;filename="+ file.getName());
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    
				    session.close();
				    fileIn.close();
				    outp.flush();
				    outp.close();
				
			}
			
			else if(action.equals("crea_scheda_rilievo")) {
				ajax = false;
				
				List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				
				String id_rilievo= request.getParameter("id_rilievo");
				
				id_rilievo = Utility.decryptData(id_rilievo);
				
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(Integer.parseInt(id_rilievo), session);
			
				String  path_simboli = getServletContext().getRealPath("/images") + "\\simboli_rilievi\\";
				
				new CreateSchedaRilievo(rilievo, listaSedi, path_simboli,session);
				
				String path = Costanti.PATH_FOLDER + "RilieviDimensionali\\Schede\\" + rilievo.getId() + "\\scheda_rilievo.pdf";
				File file = new File(path);
				
				FileInputStream fileIn = new FileInputStream(file);
				 
				 response.setContentType("application/octet-stream");
				  
				 response.setHeader("Content-Disposition","attachment;filename="+ file.getName());
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }

				    session.close();

				    fileIn.close();
				    outp.flush();
				    outp.close();
							
			}
			else if(action.equals("crea_scheda_rilievo_excel")) {
				ajax = false;
				
				List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				
				String id_rilievo = request.getParameter("id_rilievo");
				
				id_rilievo = Utility.decryptData(id_rilievo);
				
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(Integer.parseInt(id_rilievo), session);
				
				String  path_simboli = getServletContext().getRealPath("/images");
				
				new CreateSchedaRilievoExcel(rilievo, listaSedi, path_simboli, session);
				
				String path = Costanti.PATH_FOLDER + "RilieviDimensionali\\Schede\\" + rilievo.getId() + "\\Excel\\scheda_rilievo.xlsx";
				File file = new File(path);
				
				FileInputStream fileIn = new FileInputStream(file);
				 
				 response.setContentType("application/octet-stream");
				  
				 response.setHeader("Content-Disposition","attachment;filename="+ file.getName());
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    
				    session.close();
				    fileIn.close();
				    outp.flush();
				    outp.close();
				
				
			}
			else if(action.equals("lista_file_archivio")) {
				ajax = false;
				
				String id_rilievo = request.getParameter("id_rilievo");
				
			
				
				ArrayList<RilAllegatiDTO> lista_allegati = GestioneRilieviBO.getlistaFileArchivio(Integer.parseInt(id_rilievo), session);
				session.close();
				request.getSession().setAttribute("lista_allegati", lista_allegati);		
				request.getSession().setAttribute("id_rilievo", id_rilievo);	
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaFileArchivioRilievi.jsp");
		  	    dispatcher.forward(request,response);
			
				
			}


		} catch (Exception e) {
			session.getTransaction().rollback();
        	session.close();
			if(ajax) {
				PrintWriter out = response.getWriter();
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

	
	
	int getIndexMax(ArrayList<RilQuotaDTO> lista_quote) {		
		
		int max = 0;
		int result = 0;
		for (int i= 0; i<lista_quote.size();i++) {
			if(lista_quote.get(i).getListaPuntiQuota().size()>max) {
				max= lista_quote.get(i).getListaPuntiQuota().size();
				result= i;
			}		
		}
	
		return result;
	}
}
