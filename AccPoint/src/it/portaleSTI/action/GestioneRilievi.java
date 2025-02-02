package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.math.NumberUtils;
import org.apache.log4j.Logger;
import org.apache.pdfbox.io.MemoryUsageSetting;
import org.apache.pdfbox.multipdf.PDFMergerUtility;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import antlr.Utils;
import it.arubapec.arubasignservice.ArubaSignService;
import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoCampioneDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.RilAllegatiDTO;
import it.portaleSTI.DTO.RilInterventoDTO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.RilParticolareDTO;
import it.portaleSTI.DTO.RilPuntoDTO;
import it.portaleSTI.DTO.RilPuntoQuotaDTO;
import it.portaleSTI.DTO.RilQuotaDTO;
import it.portaleSTI.DTO.RilQuotaFunzionaleDTO;
import it.portaleSTI.DTO.RilSimboloDTO;
import it.portaleSTI.DTO.RilStatoRilievoDTO;
import it.portaleSTI.DTO.RilTipoRilievoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateSchedaRilievo;
import it.portaleSTI.bo.CreateSchedaRilievoCMCMK;
import it.portaleSTI.bo.CreateSchedaRilievoExcel;
import it.portaleSTI.bo.CreateTabellaFromXML;
import it.portaleSTI.bo.CreateTabellaRilievoPDF;
import it.portaleSTI.bo.GestioneCertificatoBO;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneRilieviBO;
import it.portaleSTI.bo.GestioneSchedaConsegnaBO;
import it.portaleSTI.bo.GestioneUtenteBO;


/**
 * Servlet implementation class GestioneRilievi
 */
@WebServlet("/gestioneRilievi.do")
public class GestioneRilievi extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	static final Logger logger = Logger.getLogger(GestioneRilievi.class);
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
			
			logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo());
			
			
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
				String materiale = ret.get("materiale");
				String denominazione = ret.get("denominazione");
			
				String mese_riferimento = ret.get("mese_riferimento");
				String cifre_decimali = ret.get("cifre_decimali");
								
				String tipo_rilievo = ret.get("tipo_rilievo");
				String data_inizio_rilievo = ret.get("data_inizio_rilievo");
				String classe_tolleranza = ret.get("classe_tolleranza");
				String note = ret.get("note_rilievo");
	
				RilMisuraRilievoDTO misura_rilievo = new RilMisuraRilievoDTO();
				
				misura_rilievo.setId_cliente_util(Integer.parseInt(cliente));
				misura_rilievo.setId_sede_util(Integer.parseInt(sede.split("_")[0]));
				misura_rilievo.setTipo_rilievo(new RilTipoRilievoDTO(Integer.parseInt(tipo_rilievo), ""));
				
				if(commessa!=null && !commessa.equals("")) {
					misura_rilievo.setCommessa(commessa.split("\\*")[0]);	
				}	
				misura_rilievo.setUtente(utente);
				misura_rilievo.setNote(note);
				if(cifre_decimali.equals("")) {
					misura_rilievo.setCifre_decimali(3);
				}else {
					misura_rilievo.setCifre_decimali(Integer.parseInt(cifre_decimali));
				}
				misura_rilievo.setDisegno(disegno);
				misura_rilievo.setVariante(variante);
				misura_rilievo.setFornitore(fornitore);
				misura_rilievo.setApparecchio(apparecchio);
				misura_rilievo.setClasse_tolleranza(classe_tolleranza);
				misura_rilievo.setMateriale(materiale);
				misura_rilievo.setDenominazione(denominazione);
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
				String classe_tolleranza = ret.get("mod_classe_tolleranza");
				String denominazione = ret.get("mod_denominazione");
				String materiale = ret.get("mod_materiale");
				String note = ret.get("mod_note_rilievo");
							
				RilMisuraRilievoDTO misura_rilievo = GestioneRilieviBO.getMisuraRilieviFromId(Integer.parseInt(id_rilievo), session);
				
				misura_rilievo.setId_cliente_util(Integer.parseInt(cliente));
				misura_rilievo.setId_sede_util(Integer.parseInt(sede.split("_")[0]));
				misura_rilievo.setTipo_rilievo(new RilTipoRilievoDTO(Integer.parseInt(tipo_rilievo), ""));
				if(commessa!=null && !commessa.equals("")) {
					misura_rilievo.setCommessa(commessa.split("\\*")[0]);	
				}				
				misura_rilievo.setUtente(utente);
				misura_rilievo.setClasse_tolleranza(classe_tolleranza);
				misura_rilievo.setNote(note);
				if(cifre_decimali.equals("")) {
					misura_rilievo.setCifre_decimali(3);
				}else {
					misura_rilievo.setCifre_decimali(Integer.parseInt(cifre_decimali));
				}
				misura_rilievo.setDisegno(disegno);
				misura_rilievo.setVariante(variante);
				misura_rilievo.setFornitore(fornitore);
				misura_rilievo.setApparecchio(apparecchio);
				misura_rilievo.setMateriale(materiale);
				misura_rilievo.setDenominazione(denominazione);
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
				

				
				request.getSession().setAttribute("rilievo", rilievo);
				request.getSession().setAttribute("lista_impronte", lista_impronte);
				request.getSession().setAttribute("lista_simboli", lista_simboli);
				request.getSession().setAttribute("lista_quote_funzionali", lista_quote_funzionali);
				request.getSession().setAttribute("filtro_rilievi", filtro_rilievi);
				request.getSession().setAttribute("cliente_filtro", cliente_filtro);
				
				session.getTransaction().commit();
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioRilievo.jsp");
		  	    dispatcher.forward(request,response);	
		  	    
		  	    
			}
			else if(action.equals("nuovo_particolare")) {
				ajax = true;
				PrintWriter out = response.getWriter();
				RilMisuraRilievoDTO rilievo = (RilMisuraRilievoDTO)request.getSession().getAttribute("rilievo");
				rilievo = GestioneRilieviBO.getMisuraRilieviFromId(rilievo.getId(), session);
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
					if(quote_pezzo==null||quote_pezzo.equals("")) {
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
				
					}


				
				ArrayList<RilParticolareDTO> lista_impronte = GestioneRilieviBO.getListaParticolariPerMisura(rilievo.getId(), session);
				
				int pezzi_tot=0;
				for (RilParticolareDTO part : lista_impronte) {
					//pezzi_tot = pezzi_tot + part.getNumero_pezzi();
					if(rilievo.getTipo_rilievo().getId()!=2) {
						pezzi_tot = pezzi_tot + part.getNumero_pezzi();	
					}else {
						pezzi_tot = pezzi_tot + GestioneRilieviBO.getNumeroPezziCPCPK(part.getId(), session);
					}
				}
							
				rilievo.setN_pezzi_tot(pezzi_tot);
				session.update(rilievo);
				
				request.getSession().setAttribute("numero_pezzi", n_pezzi);
				request.getSession().setAttribute("lista_impronte", lista_impronte);
				request.getSession().setAttribute("quote_pezzo", quote_pezzo);
				request.getSession().setAttribute("numero_impronte", numero_impronte);
				
				session.getTransaction().commit();
				session.close();
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
				PrintWriter out = response.getWriter();
				int id_quota = json_array.get(0).getAsInt();
					RilQuotaDTO quota = GestioneRilieviBO.getQuotaFromId(id_quota, session);					
						if(json_array.size()>1) {
						String tolleranza_neg = json_array.get(6).getAsString();
						String tolleranza_pos = json_array.get(7).getAsString();
						String coordinata = json_array.get(1).getAsString();
						String val_nominale = json_array.get(3).getAsString();						
						String um = json_array.get(5).getAsString();			
						String note = json_array.get(8+quota.getImpronta().getNumero_pezzi()).getAsString();
											
						
						if(tolleranza_neg!=null && !tolleranza_neg.equals("")) {
							quota.setTolleranza_negativa(tolleranza_neg.replace(",", "."));
						}
						if(tolleranza_pos!=null && !tolleranza_pos.equals("")) {
							quota.setTolleranza_positiva(tolleranza_pos.replace(",", "."));
						}						
						quota.setCoordinata(coordinata);
						quota.setUm(um);
						quota.setNote(note);
						if(val_nominale!=null && !val_nominale.equals("")) {
							quota.setVal_nominale(val_nominale.replace(",", "."));
						}
						if(simbolo!=null && !simbolo.equals("") && !simbolo.equals("Nessuno")) {
							quota.setSimbolo(new RilSimboloDTO(Integer.parseInt(simbolo.split("_")[0]), ""));
						}else {
							quota.setSimbolo(null);
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
									punto.setValore_punto(pezzo.replace(",", "."));
									punto.setDelta(Utility.setDecimalDigits(quota.getImpronta().getMisura().getCifre_decimali(),Utility.calcolaDelta(quota.getTolleranza_negativa(), quota.getTolleranza_positiva(),quota.getVal_nominale(),pezzo.replace(",", "."))));
									punto.setDelta_perc(Utility.setDecimalDigits(quota.getImpronta().getMisura().getCifre_decimali(),Utility.calcolaDeltaPerc(quota.getTolleranza_negativa(), quota.getTolleranza_positiva(), punto.getDelta())));						
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
						
						RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(quota.getImpronta().getMisura().getId(), session);
						ArrayList<RilParticolareDTO> lista_particolari = GestioneRilieviBO.getListaParticolariPerMisura(quota.getImpronta().getMisura().getId(),session);
						int quote_tot=0;
						int pezzi_tot=0;
						for (RilParticolareDTO part : lista_particolari) {
							ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(part.getId(), session);
							//quote_tot = quote_tot + (lista_quote.size()*part.getNumero_pezzi());
							quote_tot = quote_tot + GestioneRilieviBO.contaQuote(lista_quote);
							//pezzi_tot = pezzi_tot + part.getNumero_pezzi();
							if(rilievo.getTipo_rilievo().getId()!=2) {
								pezzi_tot = pezzi_tot + part.getNumero_pezzi();	
							}else {
								pezzi_tot = pezzi_tot + GestioneRilieviBO.getNumeroPezziCPCPK(part.getId(), session);
							}
						}
						
						
						
						myObj.addProperty("success", true);
						}
						session.getTransaction().commit();
						session.close();
						out.print(myObj);
			}
			else if(action.equals("dettaglio_impronta")) {
				ajax=false;
				
				//String s = null; s.toString();
				
				String id_impronta = request.getParameter("id_impronta");
				String quote_pezzo = (String)request.getSession().getAttribute("quote_pezzo");
				
				String riferimento = request.getParameter("riferimento");
				ArrayList<RilQuotaDTO> lista_quote = null;
				ArrayList<RilQuotaDTO> lista_quoteTot = null;
				lista_quoteTot = GestioneRilieviBO.getQuoteFromImpronta(Integer.parseInt(id_impronta), session);
				if(riferimento!=null && !riferimento.equals("") && !riferimento.equals("0")) {
					lista_quote = GestioneRilieviBO.getQuoteFromImprontaAndRiferimento(Integer.parseInt(id_impronta), Integer.parseInt(riferimento),session);			
				}else {
					lista_quote = lista_quoteTot;
				}
				
				RilParticolareDTO impronta = GestioneRilieviBO.getImprontaById(Integer.parseInt(id_impronta), session);
				
								
				 JsonArray jsArray = new JsonArray();
				ArrayList<Integer> rif = new ArrayList<Integer>();
				
				if(impronta.getMisura().getTipo_rilievo().getId()==2 && lista_quoteTot!=null) {
					
					 JsonObject jsObjDefault = new JsonObject();
				     jsObjDefault.addProperty("riferimento", "");
				     jsObjDefault.addProperty("value", "Seleziona Riferimento...");

				     jsArray.add(jsObjDefault);	
				     
					for (int i = 0; i<lista_quoteTot.size();i++) {
						if(lista_quoteTot.get(i).getRiferimento()!=0) {
							if(i==0 ||(lista_quoteTot.get(i).getRiferimento()!=lista_quoteTot.get(i-1).getRiferimento() && !rif.contains(lista_quoteTot.get(i).getRiferimento()))) {
								JsonObject jsObj = new JsonObject();
								jsObj.addProperty("riferimento", lista_quoteTot.get(i).getRiferimento());
								jsObj.addProperty("value", lista_quoteTot.get(i).getVal_nominale());
								jsArray.add(jsObj);
								rif.add(lista_quoteTot.get(i).getRiferimento());
								
							}
						}
					}
				}

				int max_riferimento = GestioneRilieviBO.getQuotaRiferimento(impronta.getId(), session);
				
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
				

				if(riferimento!=null && !riferimento.equals("")) {
					request.getSession().setAttribute("checkRiferimento", 1);
					request.getSession().setAttribute("riferimento", riferimento);
				}else {
					request.getSession().setAttribute("checkRiferimento", "");
				}
				request.getSession().setAttribute("numero_pezzi", impronta.getNumero_pezzi());
				request.getSession().setAttribute("lista_quote", lista_quote);
				request.getSession().setAttribute("lista_quote_riferimento", jsArray);
				request.getSession().setAttribute("quote_pezzo", quote_pezzo);
				request.getSession().setAttribute("max_riferimento", max_riferimento);
				request.getSession().setAttribute("filtro_delta", false);
				if(lista_quote.size()>0) {
					request.getSession().setAttribute("listaPuntiQuota", lista_quote.get(Utility.getIndexMax(lista_quote)).getListaPuntiQuota());
					request.getSession().setAttribute("empty", false);
				}else {
					request.getSession().setAttribute("empty", true);
				}
				boolean isImpronta = false;
				
				if(impronta.getNome_impronta()!=null && !impronta.getNome_impronta().equals("")) {
					isImpronta=true;
				}
				request.getSession().setAttribute("isImpronta", isImpronta);
				request.getSession().setAttribute("particolare", impronta);
				request.getSession().setAttribute("id_impronta", id_impronta);		
				
				session.getTransaction().commit();
				session.close();
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
				
				session.getTransaction().commit();
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
				String capability = ret.get("capability");
				String um ="";
				String riferimento = ret.get("riferimento");
				if(simbolo.equals("2_ANGOLO")) {
					um = "°";
				}else {
					um = "mm";
				}
				String note_quota = ret.get("note_quota");
				String rip = ret.get("ripetizioni");
				
				RilQuotaDTO quota = null;
				
				JsonElement jelement = null;
				JsonArray jsonObj = null;
				if(!id_quota.equals("")) {
					jelement = new JsonParser().parse(id_quota);
					jsonObj = jelement.getAsJsonArray();
				}
				
				
				RilParticolareDTO impr = GestioneRilieviBO.getImprontaById(Integer.parseInt(particolare), session);
				int ripetizioni = 1;

				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(impr.getMisura().getId(), session);
				if(rip!=null && !rip.equals("")) {
					ripetizioni = Integer.parseInt(rip);
				}
				
				for(int i=0; i<ripetizioni; i++) {
					if(jsonObj!=null && jsonObj.get(0)!=null && !jsonObj.get(0).getAsString().equals("")) {
						quota = GestioneRilieviBO.getQuotaFromId(Integer.parseInt(jsonObj.get(0).getAsString()),session);					
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
					quota.setImpronta(impr);
					quota.setCoordinata(coordinata);
					quota.setUm(um);
					quota.setVal_nominale(val_nominale.replace(",", "."));
					quota.setCapability(capability.replace(",", "."));
					if(simbolo!=null && !simbolo.equals("") && !simbolo.equals("Nessuno")) {
						quota.setSimbolo(new RilSimboloDTO(Integer.parseInt(simbolo.split("_")[0]),""));
					}else {
						quota.setSimbolo(null);
					}
					quota.setTolleranza_negativa(tolleranza_neg.replace(",", "."));
					quota.setTolleranza_positiva(tolleranza_pos.replace(",", "."));
					
					if(rilievo.getTipo_rilievo().getId()==2 && riferimento != null && !riferimento.equals("")) {						
						quota.setRiferimento(Integer.parseInt(riferimento));
					}
					
					if(!lettera.equals("") && !numero.equals("")) {
						quota.setSigla_tolleranza(lettera+numero);
					}
					
					if(jsonObj!=null && jsonObj.get(0)!=null && !jsonObj.get(0).getAsString().equals("")) {
						if(riferimento!=null && !riferimento.equals("")) {
							GestioneRilieviBO.updateQuotaCpCpk(quota,impr.getId(),riferimento,session);
						}else {
							session.update(quota);
						}
					}else {
						session.save(quota);					
					}
				}
				
				if(jsonObj!=null && jsonObj.get(0)!=null && !jsonObj.get(0).getAsString().equals("")) {	

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
							punto.setValore_punto(pezzo.replace(",", "."));
							punto.setId_quota(quota.getId());				
							punto.setDelta(Utility.setDecimalDigits(quota.getImpronta().getMisura().getCifre_decimali(),Utility.calcolaDelta(quota.getTolleranza_negativa(), quota.getTolleranza_positiva(),quota.getVal_nominale(),pezzo.replace(",", "."))));
							punto.setDelta_perc(Utility.setDecimalDigits(quota.getImpronta().getMisura().getCifre_decimali(),Utility.calcolaDeltaPerc(quota.getTolleranza_negativa(), quota.getTolleranza_positiva(), punto.getDelta())));
						   }else {
							   punto.setId_quota(quota.getId());
						   }
						   session.update(punto);
					   }
					   if(n_pezzi>quota.getListaPuntiQuota().size()) {
						   for(int j = quota.getListaPuntiQuota().size();j<n_pezzi;j++) {
							   RilPuntoQuotaDTO punto = new RilPuntoQuotaDTO();
							   String pezzo = ret.get("pezzo_"+(j+1));
							   if(!pezzo.equals("")) {
								punto.setValore_punto(pezzo.replace(",", "."));
								punto.setId_quota(quota.getId());							
							   }else {
								   punto.setId_quota(quota.getId());
							   }
							   session.save(punto);
						   }
					   }
										
				}else {
					for(int i=0; i<n_pezzi;i++) {
						RilPuntoQuotaDTO punto = new RilPuntoQuotaDTO();
						String pezzo = ret.get("pezzo_"+(i+1));
						if(!pezzo.equals("")) {
							punto.setValore_punto(pezzo.replace(",", "."));
							punto.setDelta(Utility.setDecimalDigits(quota.getImpronta().getMisura().getCifre_decimali(),Utility.calcolaDelta(quota.getTolleranza_negativa(), quota.getTolleranza_positiva(),quota.getVal_nominale(),pezzo.replace(",", "."))));
							punto.setDelta_perc(Utility.setDecimalDigits(quota.getImpronta().getMisura().getCifre_decimali(),Utility.calcolaDeltaPerc(quota.getTolleranza_negativa(), quota.getTolleranza_positiva(), punto.getDelta())));
							punto.setId_quota(quota.getId());							
						}else {							
							punto.setId_quota(quota.getId());
						}
						session.save(punto);
					}
				}

				
				ArrayList<RilParticolareDTO> lista_particolari = GestioneRilieviBO.getListaParticolariPerMisura(impr.getMisura().getId(), session);
				int quote_tot=0;
				int pezzi_tot=0;
				
				for (RilParticolareDTO part : lista_particolari) {
					ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(part.getId(), session);
					if(part.getId()==impr.getId()) {
						request.getSession().setAttribute("lista_quote", lista_quote);			
					}
					//quote_tot = quote_tot + (lista_quote.size()*part.getNumero_pezzi());
					quote_tot = quote_tot + GestioneRilieviBO.contaQuote(lista_quote);
					
					if(rilievo.getTipo_rilievo().getId()!=2) {
						pezzi_tot = pezzi_tot + part.getNumero_pezzi();	
					}else {
						pezzi_tot = pezzi_tot + GestioneRilieviBO.getNumeroPezziCPCPK(part.getId(), session);
					}
				}
				
				rilievo.setN_quote(quote_tot);
				rilievo.setN_pezzi_tot(pezzi_tot);
				session.update(rilievo);	
				
				session.getTransaction().commit();
				
			//	ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(Integer.parseInt(particolare), session);
			
				session.close();
				
				myObj.addProperty("success", true);		
				if(jsonObj!=null && jsonObj.getAsString()!=null && !jsonObj.getAsString().equals("")) {
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
				String capability = ret.get("capability");
				String riferimento = ret.get("riferimento");
				String um ="";
				if(simbolo!=null) {
					if(simbolo.equals("2_ANGOLO")) {
						um = "°";
					}else {
						um = "mm";
					}
				}
				String note_quota = ret.get("note_quota");
				String rip = ret.get("ripetizioni");

				RilQuotaDTO quota = null;
				JsonElement jelement = null;
				JsonArray jsonObj = null;
				if(!id_quota.equals("")) {
					jelement = new JsonParser().parse(id_quota);
					jsonObj = jelement.getAsJsonArray();
				}
				
				int ripetizioni = 1;

				if(rip!=null && !rip.equals("")) {
					ripetizioni = Integer.parseInt(rip);
				}
								
				int n = 1;
				ArrayList<RilParticolareDTO> lista_impronte = null;
				RilParticolareDTO impr = GestioneRilieviBO.getImprontaById(Integer.parseInt(particolare), session);
				
				if(impr.getNome_impronta()!=null && !impr.getNome_impronta().equals("")) {
					lista_impronte = GestioneRilieviBO.getListaImprontePerMisura(impr.getMisura().getId(), session); 
					n = lista_impronte.size();
				}
				
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(impr.getMisura().getId(), session);
				int max_id_ripetizione = 0;
				
				if(lista_impronte!=null) {
				
					max_id_ripetizione = GestioneRilieviBO.getMaxIdRipetizione(lista_impronte, session);
				}
				
				
				for(int i = 0; i<n;i++) {
					for(int t = 0; t<ripetizioni; t++) {
						if(jsonObj!=null && jsonObj.get(0)!=null && !jsonObj.get(0).getAsString().equals("")) {
							quota = GestioneRilieviBO.getQuotaFromId(Integer.parseInt(jsonObj.get(0).getAsString()),session);					
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
					quota.setVal_nominale(val_nominale.replace(",", "."));
					quota.setCapability(capability.replace(",", "."));
					
					if(rilievo.getTipo_rilievo().getId()==2 && riferimento != null && !riferimento.equals("")) {						
						quota.setRiferimento(Integer.parseInt(riferimento));
					}
					
					if(simbolo!=null && !simbolo.equals("") && !simbolo.equals("Nessuno")) {
						quota.setSimbolo(new RilSimboloDTO(Integer.parseInt(simbolo.split("_")[0]),""));
					}else {
						quota.setSimbolo(null);
					}
					quota.setTolleranza_negativa(tolleranza_neg.replace(",", "."));
					quota.setTolleranza_positiva(tolleranza_pos.replace(",", "."));
	
					if(quota_funzionale!=null && !quota_funzionale.equals("") && !quota_funzionale.equals("0_nessuna")) {
						quota.setQuota_funzionale(new RilQuotaFunzionaleDTO(Integer.parseInt(quota_funzionale.split("_")[0]), ""));
					}else {
						quota.setQuota_funzionale(null);
					}
					if(!lettera.equals("") && !numero.equals("")) {
						quota.setSigla_tolleranza(lettera+numero);
					}
					
					if(id_quota!=null && !id_quota.equals("")) {
					
						if(riferimento!=null && !riferimento.equals("")) {
							GestioneRilieviBO.updateQuotaCpCpk(quota,lista_impronte.get(i).getId(),riferimento,session);
						}else {
							if(quota.getId_ripetizione()==0) {
								session.update(quota);
							}						
							else {
								GestioneRilieviBO.updateQuota(quota,lista_impronte.get(i).getId(), session);	
							}
						}
						
					}else {
	
						if(impr.getNome_impronta().equals("")) {
							quota.setId_ripetizione(0);
						}else {
							quota.setId_ripetizione(max_id_ripetizione+1);
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
								punto.setValore_punto(pezzo.replace(",", "."));
								punto.setId_quota(quota.getId());
								punto.setDelta(Utility.setDecimalDigits(quota.getImpronta().getMisura().getCifre_decimali(),Utility.calcolaDelta(quota.getTolleranza_negativa(), quota.getTolleranza_positiva(),quota.getVal_nominale(),pezzo.replace(",", "."))));
								punto.setDelta_perc(Utility.setDecimalDigits(quota.getImpronta().getMisura().getCifre_decimali(),Utility.calcolaDeltaPerc(quota.getTolleranza_negativa(), quota.getTolleranza_positiva(), punto.getDelta())));							
							   }else {
								   punto.setId_quota(quota.getId());
							   }
							   session.update(punto);
						   }
						   if(n_pezzi>quota.getListaPuntiQuota().size()) {
							   for(int j = quota.getListaPuntiQuota().size();j<n_pezzi;j++) {
								   RilPuntoQuotaDTO punto = new RilPuntoQuotaDTO();
								   String pezzo = ret.get("pezzo_"+(j+1));
								   if(!pezzo.equals("")) {
									punto.setValore_punto(pezzo.replace(",", "."));
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
										punto.setValore_punto(pezzo.replace(",", "."));		
										punto.setDelta(Utility.setDecimalDigits(quota.getImpronta().getMisura().getCifre_decimali(),Utility.calcolaDelta(quota.getTolleranza_negativa(), quota.getTolleranza_positiva(),quota.getVal_nominale(),pezzo.replace(",", "."))));
										punto.setDelta_perc(Utility.setDecimalDigits(quota.getImpronta().getMisura().getCifre_decimali(),Utility.calcolaDeltaPerc(quota.getTolleranza_negativa(), quota.getTolleranza_positiva(), punto.getDelta())));
									}else {
										punto.setValore_punto(null);	
									}
								}else {
									punto.setValore_punto(null);	
								}
									punto.setId_quota(quota.getId());
									session.save(punto);
									quota.getListaPuntiQuota().add(punto);
								}
						}else {
							for(int k=0; k<n_pezzi;k++) {
								RilPuntoQuotaDTO punto = new RilPuntoQuotaDTO();
								String pezzo = ret.get("pezzo_"+(k+1));
								if(!pezzo.equals("")) {
									punto.setValore_punto(pezzo.replace(",", "."));		
									punto.setDelta(Utility.setDecimalDigits(quota.getImpronta().getMisura().getCifre_decimali(),Utility.calcolaDelta(quota.getTolleranza_negativa(), quota.getTolleranza_positiva(),quota.getVal_nominale(),pezzo.replace(",", "."))));
									punto.setDelta_perc(Utility.setDecimalDigits(quota.getImpronta().getMisura().getCifre_decimali(),Utility.calcolaDeltaPerc(quota.getTolleranza_negativa(), quota.getTolleranza_positiva(), punto.getDelta())));
								}else {
									punto.setValore_punto(null);	
								}
								punto.setId_quota(quota.getId());
								session.save(punto);
								quota.getListaPuntiQuota().add(punto);
								}
							}
						
						}
					
					}
			}
				
				ArrayList<RilParticolareDTO> lista_particolari = GestioneRilieviBO.getListaParticolariPerMisura(impr.getMisura().getId(), session);
				int quote_tot=0;
				int pezzi_tot=0;
				for (RilParticolareDTO part : lista_particolari) {
					ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(part.getId(), session);
					if(part.getId() == Integer.parseInt(particolare)) {
						request.getSession().setAttribute("lista_quote", lista_quote);
					}
					//quote_tot = quote_tot + (lista_quote.size()*part.getNumero_pezzi());
					quote_tot = quote_tot + GestioneRilieviBO.contaQuote(lista_quote);
					//pezzi_tot = pezzi_tot + part.getNumero_pezzi();
					if(rilievo.getTipo_rilievo().getId()!=2) {
						pezzi_tot = pezzi_tot + part.getNumero_pezzi();	
					}else {
						pezzi_tot = pezzi_tot + GestioneRilieviBO.getNumeroPezziCPCPK(part.getId(), session);
					}
				}
				
				
				rilievo.setN_quote(quote_tot);
				rilievo.setN_pezzi_tot(pezzi_tot);
				session.update(rilievo);
				
				session.getTransaction().commit();
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
				
				JsonElement jelement = new JsonParser().parse(id_quota);
				JsonArray jsonObj = jelement.getAsJsonArray();
				//JsonArray jsArr = jsonObj.get("ids").getAsJsonArray();
				
				RilQuotaDTO quota = GestioneRilieviBO.getQuotaFromId(Integer.parseInt(jsonObj.get(0).getAsString()), session);
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(quota.getImpronta().getMisura().getId(), session);
				ArrayList<RilParticolareDTO> lista_particolari = GestioneRilieviBO.getListaParticolariPerMisura(quota.getImpronta().getMisura().getId(), session);
				for(int i = 0;i<jsonObj.size();i++) {
					
					//RilQuotaDTO quota = GestioneRilieviBO.getQuotaFromId(Integer.parseInt(id_quota), session);
					RilQuotaDTO q = GestioneRilieviBO.getQuotaFromId(Integer.parseInt(jsonObj.get(i).getAsString()), session);
					
					for (RilPuntoQuotaDTO punto : q.getListaPuntiQuota()) {
						session.delete(punto);
					}
					session.delete(q);
				}
				
				int quote_tot=0;
				int pezzi_tot=0;
				for (RilParticolareDTO part : lista_particolari) {
					ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(part.getId(), session);
					//quote_tot = quote_tot + (lista_quote.size()*part.getNumero_pezzi());
					quote_tot = quote_tot + GestioneRilieviBO.contaQuote(lista_quote);
					if(rilievo.getTipo_rilievo().getId()!=2) {
						pezzi_tot = pezzi_tot + part.getNumero_pezzi();	
					}else {
						pezzi_tot = pezzi_tot + GestioneRilieviBO.getNumeroPezziCPCPK(part.getId(), session);
					}
				}				
				rilievo.setN_quote(quote_tot);
				rilievo.setN_pezzi_tot(pezzi_tot);
				session.update(rilievo);				
				
				session.getTransaction().commit();
				session.close();
				
				myObj.addProperty("success", true);
				myObj.addProperty("id_impronta", quota.getImpronta().getId());
				
			
				out.print(myObj);
				
			}
			
			else if(action.equals("elimina_quota_replica")) {
				
				ajax = true;
				PrintWriter out = response.getWriter();
				String id_quota = request.getParameter("id_quota");
				JsonElement jelement = new JsonParser().parse(id_quota);
				JsonArray jsonObj = jelement.getAsJsonArray();
								
				//RilQuotaDTO quota = GestioneRilieviBO.getQuotaFromId(Integer.parseInt(id_quota), session);
				RilQuotaDTO quota = GestioneRilieviBO.getQuotaFromId(Integer.parseInt(jsonObj.get(0).getAsString()), session);
				
				ArrayList<RilParticolareDTO> lista_impronte = GestioneRilieviBO.getListaImprontePerMisura(quota.getImpronta().getMisura().getId(), session);
				
				int n = 1; 
				if(lista_impronte.size()>1) {
					n=lista_impronte.size();
				}else {
					lista_impronte = GestioneRilieviBO.getListaParticolariPerMisura(quota.getImpronta().getMisura().getId(), session);
				}
				
				
				for(int j = 0; j<jsonObj.size();j++) {
					RilQuotaDTO q = GestioneRilieviBO.getQuotaFromId(Integer.parseInt(jsonObj.get(j).getAsString()), session);
					for(int i = 0; i<n;i++) {
						ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(lista_impronte.get(i).getId(), session);
						for (RilQuotaDTO rilQuotaDTO : lista_quote) {
							if(rilQuotaDTO.getId_ripetizione()== q.getId_ripetizione()) {
								for (RilPuntoQuotaDTO punto : rilQuotaDTO.getListaPuntiQuota()) {
									session.delete(punto);
								}
								session.delete(rilQuotaDTO);
							}
						}
					}
				}
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(quota.getImpronta().getMisura().getId(), session);
				int quote_tot=0;
				int pezzi_tot=0;
				for (RilParticolareDTO part : lista_impronte) {
					ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(part.getId(), session);
					//quote_tot = quote_tot + (lista_quote.size()*part.getNumero_pezzi());
					
					quote_tot = quote_tot + GestioneRilieviBO.contaQuote(lista_quote);
					//pezzi_tot = pezzi_tot + part.getNumero_pezzi();
					if(rilievo.getTipo_rilievo().getId()!=2) {
						pezzi_tot = pezzi_tot + part.getNumero_pezzi();	
					}else {
						pezzi_tot = pezzi_tot + GestioneRilieviBO.getNumeroPezziCPCPK(part.getId(), session);
					}
				}
				
				rilievo.setN_quote(quote_tot);
				rilievo.setN_pezzi_tot(pezzi_tot);
				session.update(rilievo);
				
				
				session.getTransaction().commit();
				session.close();
				
				myObj.addProperty("success", true);
				myObj.addProperty("id_impronta", quota.getImpronta().getId());
				
				out.print(myObj);
				
			}
			
			else if(action.equals("svuota")) {
				ajax = true;
				PrintWriter out = response.getWriter();
				String id_particolare = request.getParameter("id_particolare");
								
				RilParticolareDTO particolare = GestioneRilieviBO.getImprontaById(Integer.parseInt(id_particolare), session);
				ArrayList<RilParticolareDTO> lista_impronte = null;
				
				if(particolare.getNome_impronta()!=null && !particolare.getNome_impronta().equals("")) {
					lista_impronte = GestioneRilieviBO.getListaImprontePerMisura(particolare.getMisura().getId(), session);
				}else {
					lista_impronte = new ArrayList<RilParticolareDTO>();
				}
				
				int n = 1; 
				if(lista_impronte.size()>1) {
					n=lista_impronte.size();
				}else {
					lista_impronte.add(particolare);
 				}
				
				for(int i = 0; i<n;i++) {
					ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(lista_impronte.get(i).getId(), session);
					for (RilQuotaDTO rilQuotaDTO : lista_quote) {						
							for (RilPuntoQuotaDTO punto : rilQuotaDTO.getListaPuntiQuota()) {
								session.delete(punto);
							}
							session.delete(rilQuotaDTO);
						}
					}				
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(particolare.getMisura().getId(), session);
				ArrayList<RilParticolareDTO> lista_particolari = GestioneRilieviBO.getListaParticolariPerMisura(particolare.getMisura().getId(), session);
				int quote_tot=0;
				int pezzi_tot=0;
				for (RilParticolareDTO part : lista_particolari) {
					ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(part.getId(), session);
					//quote_tot = quote_tot + (lista_quote.size()*part.getNumero_pezzi());
					quote_tot = quote_tot + GestioneRilieviBO.contaQuote(lista_quote);
					//pezzi_tot = pezzi_tot + part.getNumero_pezzi();
					if(rilievo.getTipo_rilievo().getId()!=2) {
						pezzi_tot = pezzi_tot + part.getNumero_pezzi();	
					}else {
						pezzi_tot = pezzi_tot + GestioneRilieviBO.getNumeroPezziCPCPK(part.getId(), session);
					}
				}
				
				rilievo.setN_quote(quote_tot);
				rilievo.setN_pezzi_tot(pezzi_tot);
				session.update(rilievo);				
				
				session.getTransaction().commit();
				session.close();
				
				myObj.addProperty("success", true);
							
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
				PrintWriter out = response.getWriter();
				
				if(json_array.get(0)!=null && NumberUtils.isNumber(json_array.get(0).getAsString())) {
				int id_quota = json_array.get(0).getAsInt();
					RilQuotaDTO quota = GestioneRilieviBO.getQuotaFromId(id_quota, session);
					
						if(json_array.size()>1) {
							String coordinata = json_array.get(1).getAsString();
							String val_nominale = json_array.get(3).getAsString();	
							String um = json_array.get(5).getAsString();
							String tolleranza_neg = json_array.get(6).getAsString();
							String tolleranza_pos = json_array.get(7).getAsString();						
							String note = json_array.get(8+quota.getImpronta().getNumero_pezzi()).getAsString();
						
							RilParticolareDTO impr = GestioneRilieviBO.getImprontaById(Integer.parseInt(particolare), session);
							ArrayList<RilParticolareDTO> lista_impronte = null;
							
							if(impr.getNome_impronta()==null || impr.getNome_impronta().equals("")){
								lista_impronte = new ArrayList<RilParticolareDTO>();
								lista_impronte.add(impr);
							}else {
								lista_impronte =  GestioneRilieviBO.getListaImprontePerMisura(impr.getMisura().getId(), session);	
							}
						
//							if(lista_impronte.size()==0) {
//								lista_impronte = GestioneRilieviBO.getListaParticolariPerMisura(impr.getMisura().getId(), session);
//							}
							
							for (RilParticolareDTO impronta : lista_impronte) {
							
							if(tolleranza_neg!=null && !tolleranza_neg.equals("")) {
								quota.setTolleranza_negativa(tolleranza_neg.replace(",", "."));
							}
							if(tolleranza_pos!=null && !tolleranza_pos.equals("")) {
								quota.setTolleranza_positiva(tolleranza_pos.replace(",", "."));
							}						
							quota.setCoordinata(coordinata);
							quota.setUm(um);
							quota.setNote(note);
							if(val_nominale!=null && !val_nominale.equals("")) {
								quota.setVal_nominale(val_nominale.replace(",", "."));
							}
							if(simbolo!=null && !simbolo.equals("")&& !simbolo.equals("Nessuno")) {
								quota.setSimbolo(new RilSimboloDTO(Integer.parseInt(simbolo.split("_")[0]), ""));
							}else {
								quota.setSimbolo(null);
							}
							if(quota_funzionale!=null && !quota_funzionale.equals("")&& !quota_funzionale.equals("0_nessuna")) {
								quota.setQuota_funzionale(new RilQuotaFunzionaleDTO(Integer.parseInt(quota_funzionale.split("_")[0]), ""));
							}else {
								quota.setQuota_funzionale(null);
							}
							if(quota.getId_ripetizione()==0) {
								session.update(quota);
							}else {
								GestioneRilieviBO.updateQuota(quota, impronta.getId(), session);
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
							//for(int i=8; i<json_array.size()-1;i++) {
							for(int i=8; i<8+quota.getImpronta().getNumero_pezzi();i++) {
								RilPuntoQuotaDTO punto;
								if(list.size()>j) {
									punto = (RilPuntoQuotaDTO) list.get(j);
								}else {
									punto = new RilPuntoQuotaDTO();
								}
								String pezzo = json_array.get(i).getAsString();
								if(pezzo != null && !pezzo.equals("")) {
									punto.setValore_punto(pezzo.replace(",", "."));
									punto.setDelta(Utility.setDecimalDigits(quota.getImpronta().getMisura().getCifre_decimali(),Utility.calcolaDelta(quota.getTolleranza_negativa(), quota.getTolleranza_positiva(),quota.getVal_nominale(),pezzo.replace(",", "."))));
									punto.setDelta_perc(Utility.setDecimalDigits(quota.getImpronta().getMisura().getCifre_decimali(),Utility.calcolaDeltaPerc(quota.getTolleranza_negativa(), quota.getTolleranza_positiva(), punto.getDelta())));						
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
						
						RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(quota.getImpronta().getMisura().getId(), session);
						ArrayList<RilParticolareDTO> lista_particolari = GestioneRilieviBO.getListaParticolariPerMisura(quota.getImpronta().getMisura().getId(),session);
						int quote_tot=0;
						int pezzi_tot=0;
						for (RilParticolareDTO part : lista_particolari) {
							ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(part.getId(), session);
							//quote_tot = quote_tot + (lista_quote.size()*part.getNumero_pezzi());
							quote_tot = quote_tot + GestioneRilieviBO.contaQuote(lista_quote);
							//pezzi_tot = pezzi_tot + part.getNumero_pezzi();
							if(rilievo.getTipo_rilievo().getId()!=2) {
								pezzi_tot = pezzi_tot + part.getNumero_pezzi();	
							}else {
								pezzi_tot = pezzi_tot + GestioneRilieviBO.getNumeroPezziCPCPK(part.getId(), session);
							}
						}
						
						
						rilievo.setN_quote(quote_tot);
						rilievo.setN_pezzi_tot(pezzi_tot);
						session.update(rilievo);
						
						
						myObj.addProperty("success", true);
						
						
						}
				}
				session.getTransaction().commit();
				session.close();
				out.print(myObj);
			}
					
			
			else if(action.equals("apri_chiudi_rilievo")) {
				ajax = true;
				PrintWriter out = response.getWriter();
				String id_rilievo = request.getParameter("id_rilievo");
				String stato = request.getParameter("stato");
				String smaltimento = request.getParameter("smaltimento");
				String non_lavorato = request.getParameter("non_lavorato");
				
					
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getRilievoFromId(Integer.parseInt(id_rilievo), session);
				rilievo.setStato_rilievo(new RilStatoRilievoDTO(Integer.parseInt(stato), ""));
				
				if(stato.equals("2")) {
					rilievo.setData_consegna(new Date());
					
					int ultima_scheda = 0;
					
					if(rilievo.getNumero_scheda()!=null && !rilievo.getNumero_scheda().equals("")) {
						ultima_scheda = Integer.parseInt(rilievo.getNumero_scheda().split("_")[1]);
					}else {
						ultima_scheda = (GestioneSchedaConsegnaBO.getUltimaScheda(session)+1);
					}				
					
					rilievo.setNumero_scheda("SRD_"+(ultima_scheda));
					
					ArrayList<RilParticolareDTO> lista_particolari = GestioneRilieviBO.getListaParticolariPerMisura(rilievo.getId(), session);
				
					int quote_tot=0;
					int pezzi_tot=0;
					
					for (RilParticolareDTO part : lista_particolari) {
						ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(part.getId(), session);
						//quote_tot = quote_tot + (lista_quote.size()*part.getNumero_pezzi());
						quote_tot = quote_tot + GestioneRilieviBO.contaQuote(lista_quote);
						//pezzi_tot = pezzi_tot + part.getNumero_pezzi();
						if(rilievo.getTipo_rilievo().getId()!=2) {
							pezzi_tot = pezzi_tot + part.getNumero_pezzi();	
						}else {
							pezzi_tot = pezzi_tot + GestioneRilieviBO.getNumeroPezziCPCPK(part.getId(), session);
						}
					}
					
					
					rilievo.setN_quote(quote_tot);
					rilievo.setN_pezzi_tot(pezzi_tot);
					session.update(rilievo);	
					
					
					String path_simboli = getServletContext().getRealPath("/images") + "\\simboli_rilievi\\";		
					List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
					if(rilievo.getTipo_rilievo().getId()!=2) {
						new CreateSchedaRilievo(rilievo, listaSedi, path_simboli,  ultima_scheda, session);
					}else {
						new CreateSchedaRilievoCMCMK(rilievo, listaSedi, path_simboli, ultima_scheda, session);
					}	
					rilievo.setControfirmato(0);										
					
					if(smaltimento!=null && !smaltimento.equals("")) {
						rilievo.setSmaltimento(Integer.parseInt(smaltimento));
					}
					
					if(non_lavorato!=null && !non_lavorato.equals("")) {
						rilievo.setNon_lavorato(Integer.parseInt(non_lavorato));
					}
					
					ArubaSignService.signRilievoPades(rilievo.getUtente(), rilievo.getUtente().getNominativo(), rilievo);
					rilievo.setFirmato(1);
				}
				
			
				myObj.addProperty("success", true);
				if(stato.equals("1")) {
					myObj.addProperty("messaggio", "Rilievo aperto con successo!");
					rilievo.setControfirmato(0);
					rilievo.setFirmato(0);
					
				}else {
					myObj.addProperty("messaggio", "Rilievo chiuso con successo!");	
				}
				
				session.getTransaction().commit();
				session.close();
				
				out.print(myObj);
				
			}
			
			else if(action.equals("approva_rilievo")) {
				
				ajax = true;
				PrintWriter out = response.getWriter();
				String id_rilievo = request.getParameter("id_rilievo");
				
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getRilievoFromId(Integer.parseInt(id_rilievo), session);
				
				ArubaSignService.signRilievoPades(GestioneUtenteBO.getUtenteById(""+utente.getId(), session), "Terenzio Fantauzzi", rilievo);
				
				rilievo.setControfirmato(1);
				session.update(rilievo);
				session.getTransaction().commit();
				session.close();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Rilievo approvato con successo!");
				
				
				out.print(myObj);
				
			}
			
			else if(action.equals("approva_selezionati")) {
				
				ajax = true;
				PrintWriter out = response.getWriter();
				String ids = request.getParameter("ids");
				
				String[] id_rilievi = ids.split(";"); 
				
				for (int i = 0; i<id_rilievi.length;i++) {
					
					RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getRilievoFromId(Integer.parseInt(id_rilievi[i]), session);
					ArubaSignService.signRilievoPades(GestioneUtenteBO.getUtenteById(""+utente.getId(), session), "Terenzio Fantauzzi", rilievo);
					
					rilievo.setControfirmato(1);
					session.update(rilievo);
				}
								
				
				session.getTransaction().commit();
				session.close();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Rilievi approvati con successo!");
				
				
				out.print(myObj);
				
			}
			
			
			else if(action.equals("upload_allegato")) {
								
				ajax = true;				
				PrintWriter out = response.getWriter();
				
				boolean certificato_rilievo = Boolean.valueOf(request.getParameter("certificato_rilievo"));
				
				String id_rilievo = request.getParameter("id_rilievo");
				//String tipo_allegato = request.getParameter("tipo_allegato");
				
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getRilievoFromId(Integer.parseInt(id_rilievo), session);
				PDFMergerUtility ut = new PDFMergerUtility();
				if(certificato_rilievo) {
					String selezionati = request.getParameter("json");
					boolean esito = false;
					
					JsonElement jelement = new JsonParser().parse(selezionati);
					JsonObject jsonObj = jelement.getAsJsonObject();
					JsonArray jsArr = jsonObj.get("ids").getAsJsonArray();
			
					
					ArrayList<File> certificati = new ArrayList<File>();
					ArrayList<Integer> lista_falliti = new ArrayList<Integer>();
					
					if(rilievo.getAllegato()!=null && !rilievo.getAllegato().equals("") && !rilievo.getAllegato().equals("certificatoCampioneAllegato.pdf")) {
						ut.setDestinationFileName(Costanti.PATH_FOLDER+"\\RilieviDimensionali\\Allegati\\"+rilievo.getId()+"\\certificatoCampioneAllegato.pdf");
						ut.addSource(new File(Costanti.PATH_FOLDER+"\\RilieviDimensionali\\Allegati\\"+rilievo.getId()+"\\"+rilievo.getAllegato()));
						rilievo.setAllegato("certificatoCampioneAllegato.pdf");
					}else {
						ut.setDestinationFileName(Costanti.PATH_FOLDER+"\\RilieviDimensionali\\Allegati\\"+rilievo.getId()+"\\certificatoCampione.pdf");
						rilievo.setAllegato("certificatoCampione.pdf");
					}				
					
					
					for(int i=0; i<jsArr.size(); i++){
						String id =  jsArr.get(i).toString().replaceAll("\"", "");
	
						CampioneDTO campione= GestioneCampioneDAO.getCampioneFromId(id);
						if(campione.getCertificatoCorrente(campione.getListaCertificatiCampione())!=null){
						 File d = new File(Costanti.PATH_FOLDER+"//Campioni//"+campione.getId()+"/"+campione.getCertificatoCorrente(campione.getListaCertificatiCampione()).getFilename());
							if(d.exists()) {
								ut.addSource(d);
								certificati.add(d);
								esito = true;
							}else {
								lista_falliti.add(campione.getId());
							}
						}else {
							lista_falliti.add(campione.getId());
						}
					}	
					
					if(esito) {
						File f = new File(Costanti.PATH_FOLDER+"\\RilieviDimensionali\\Allegati\\"+rilievo.getId()+"\\");
						if(!f.exists()) {
							f.mkdirs();
						}
						
						
						ut.mergeDocuments(MemoryUsageSetting.setupTempFileOnly());						
						
						if(!lista_falliti.isEmpty()) {
							myObj.addProperty("success", false);
							String messaggio ="";
							if(lista_falliti.size()>1) {
								 messaggio = "I campioni ";
								for (Integer i : lista_falliti) {
									messaggio = messaggio + i +", ";
								}
								messaggio = messaggio + "non hanno un certificato!";
								
							}else if(lista_falliti.size()==1){
								messaggio = "Il campione " + lista_falliti.get(0) + " non ha un certificato!";
							}
							myObj.addProperty("messaggio", messaggio);
						}else {
							myObj.addProperty("success", true);					
							myObj.addProperty("messaggio", "Allegato caricato con successo!");
						}
					}else {
						myObj.addProperty("success", false);	
						if(lista_falliti.size()==1) {
							myObj.addProperty("messaggio", "Il campione non ha un certificato!");
						}else {
							myObj.addProperty("messaggio", "I campioni non hanno un certificato!");
						}
						
					}
				}else {
				
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());				
				response.setContentType("application/json");
		
				List<FileItem> items;
				
					items = uploadHandler.parseRequest(request);
					
					for (FileItem item : items) {
						if (!item.isFormField()) {
							if(item.getName()!="") {
								GestioneRilieviBO.uploadAllegato(item, rilievo.getId(),false,false, session);
								if(rilievo.getAllegato()!=null && rilievo.getAllegato().equals("certificatoCampione.pdf")) {

									
									ut.addSource(new File(Costanti.PATH_FOLDER+"\\RilieviDimensionali\\Allegati\\"+rilievo.getId()+"\\"+item.getName()));
									ut.addSource(new File(Costanti.PATH_FOLDER+"\\RilieviDimensionali\\Allegati\\"+rilievo.getId()+"\\certificatoCampione.pdf"));
									ut.setDestinationFileName(Costanti.PATH_FOLDER+"\\RilieviDimensionali\\Allegati\\"+rilievo.getId()+"\\certificatoCampioneAllegato.pdf");
									ut.mergeDocuments(MemoryUsageSetting.setupTempFileOnly());
									rilievo.setAllegato("certificatoCampioneAllegato.pdf");
								}else {
									rilievo.setAllegato(item.getName());	
								}
								
							}								
						}
					}
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Allegato caricato con successo!");
					
				}
					session.update(rilievo);
					session.getTransaction().commit();
					session.close();			
					
					
					
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
				if(filename!=null && (filename.endsWith("pdf")||filename.endsWith("PDF"))) {
					response.setContentType("application/pdf");
				}
				else if(filename==null) {
					response.setContentType("application/pdf");
				}
				else {
					response.setContentType("application/octet-stream");
					response.setHeader("Content-Disposition","attachment;filename="+ file.getName());
				}
				 
				  
				// response.setHeader("Content-Disposition","attachment;filename="+ file.getName());
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    session.getTransaction().commit();
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
				    session.getTransaction().commit();
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
			
				String path_simboli = getServletContext().getRealPath("/images") + "\\simboli_rilievi\\";			
				
				int ultima_scheda = 0;
				
				if(rilievo.getNumero_scheda()!=null && !rilievo.getNumero_scheda().equals("")) {
					ultima_scheda = Integer.parseInt(rilievo.getNumero_scheda().split("_")[1]);
				}else {
					ultima_scheda = (GestioneSchedaConsegnaBO.getUltimaScheda(session)+1);
				}
				
				if(rilievo.getTipo_rilievo().getId()!=2) {
					new CreateSchedaRilievo(rilievo, listaSedi, path_simboli,  ultima_scheda, session);
				}else {
					new CreateSchedaRilievoCMCMK(rilievo, listaSedi, path_simboli, ultima_scheda, session);
				}				
				rilievo.setFirmato(0);
				rilievo.setControfirmato(0);
				rilievo.setNumero_scheda("SRD_"+(ultima_scheda));
				session.update(rilievo);
				session.getTransaction().commit();
				
				String path = Costanti.PATH_FOLDER + "RilieviDimensionali\\Schede\\" + rilievo.getId() + "\\SRD_"+ultima_scheda+".pdf";
				File file = new File(path);
				
				FileInputStream fileIn = new FileInputStream(file);
				 
				 response.setContentType("application/pdf");
				  
				// response.setHeader("Content-Disposition","attachment;filename="+ file.getName());
				 
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
				    session.getTransaction().commit();
				    session.close();
				    fileIn.close();
				    outp.flush();
				    outp.close();
				
				
			}
			else if(action.equals("lista_file_archivio")) {
				ajax = false;
				
				String id_rilievo = request.getParameter("id_rilievo");
				ArrayList<RilAllegatiDTO> lista_allegati = GestioneRilieviBO.getlistaFileArchivio(Integer.parseInt(id_rilievo), session);
				
				request.getSession().setAttribute("lista_allegati", lista_allegati);		
				request.getSession().setAttribute("id_rilievo", id_rilievo);	
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaFileArchivioRilievi.jsp");
		  	    dispatcher.forward(request,response);
		  	    
			}
			
			else if(action.equals("modifica_particolare")) {
				ajax = true;
				String id_particolare = request.getParameter("id_particolare");
				String nome_impronta_mod = request.getParameter("nome_impronta_mod");
				String n_pezzi_mod = request.getParameter("n_pezzi_mod");
				String note_particolare_mod = request.getParameter("note_particolare_mod");				
				RilParticolareDTO particolare = GestioneRilieviBO.getImprontaById(Integer.parseInt(id_particolare), session);
				boolean reload = false;
				if(!particolare.getNome_impronta().equals(nome_impronta_mod)) {
					reload = true;
				}
				particolare.setNote(note_particolare_mod);
				int n_pezzi_new = Integer.parseInt(n_pezzi_mod);
				
				if(nome_impronta_mod!=null) {
					ArrayList<RilParticolareDTO> lista_impronte = GestioneRilieviBO.getListaImprontePerMisura(particolare.getMisura().getId(), session);
					for (RilParticolareDTO impronta : lista_impronte) {
						modificaPezziParticolare(impronta, n_pezzi_new, session);
						if(impronta.getId()==Integer.parseInt(id_particolare)) {
							impronta.setNote(note_particolare_mod);
							impronta.setNome_impronta(nome_impronta_mod);
						}
						impronta.setNumero_pezzi(n_pezzi_new);
						session.update(impronta);
					}
				}else {
					
					modificaPezziParticolare(particolare, n_pezzi_new, session);
					particolare.setNote(note_particolare_mod);
					particolare.setNumero_pezzi(n_pezzi_new);
					session.update(particolare);
				}

				ArrayList<RilParticolareDTO> lista_particolari = GestioneRilieviBO.getListaParticolariPerMisura(particolare.getMisura().getId(), session);
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(particolare.getMisura().getId(), session);
				int pezzi_tot=0;
				for (RilParticolareDTO part : lista_particolari) {
					//pezzi_tot = pezzi_tot + part.getNumero_pezzi();
					if(rilievo.getTipo_rilievo().getId()!=2) {
						pezzi_tot = pezzi_tot + part.getNumero_pezzi();	
					}else {
						pezzi_tot = pezzi_tot + GestioneRilieviBO.getNumeroPezziCPCPK(part.getId(), session);
					}
				}
							
				rilievo.setN_pezzi_tot(pezzi_tot);
				session.update(rilievo);
				
				session.getTransaction().commit();
				session.close();
				PrintWriter out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("reload", reload);
				myObj.addProperty("messaggio", "Modifica effettuata con successo!");
				out.print(myObj);
				
			}
			
			else if(action.equals("importa_da_xml")) {
				ajax = true;
				String id_particolare = request.getParameter("id_particolare");
				String applica_tutti = request.getParameter("applica_tutti");
								
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
				
				response.setContentType("application/json");
				
				RilParticolareDTO particolare = GestioneRilieviBO.getImprontaById(Integer.parseInt(id_particolare), session);	
				
				List<FileItem> items;				
					items = uploadHandler.parseRequest(request);
					
					for (FileItem item : items) {
						if (!item.isFormField()) {
							String index = null;
							if(item.getFieldName().length()<13) {
								index = item.getFieldName().substring(item.getFieldName().length()-1);
							}else {
								index = item.getFieldName().substring(item.getFieldName().length()-2);
							}
							if(!item.getName().equals("")) {
								
								new CreateTabellaFromXML(item.getInputStream(), particolare,Integer.parseInt(index), items.size(), applica_tutti, session);
							}							
						}
					}
					
					ArrayList<RilParticolareDTO> lista_particolari = GestioneRilieviBO.getListaParticolariPerMisura(particolare.getMisura().getId(), session);
					RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(particolare.getMisura().getId(), session);
					int quote_tot=0;
					int pezzi_tot=0;
					for (RilParticolareDTO part : lista_particolari) {
						ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(part.getId(), session);
						//quote_tot = quote_tot + (lista_quote.size()*part.getNumero_pezzi());
						quote_tot = quote_tot + GestioneRilieviBO.contaQuote(lista_quote);
						//pezzi_tot = pezzi_tot + part.getNumero_pezzi();
						if(rilievo.getTipo_rilievo().getId()!=2) {
							pezzi_tot = pezzi_tot + part.getNumero_pezzi();	
						}else {
							pezzi_tot = pezzi_tot + GestioneRilieviBO.getNumeroPezziCPCPK(part.getId(), session);
						}
					}
					
					
					rilievo.setN_quote(quote_tot);
					rilievo.setN_pezzi_tot(pezzi_tot);
					session.update(rilievo);	
					
					session.getTransaction().commit();
					session.close();
					
					PrintWriter out = response.getWriter();
					myObj.addProperty("success", true);
					
					out.print(myObj);
			}
			
			else if(action.equals("filtra_non_conformi")){
				
				ajax= false;
				String id_particolare = request.getParameter("id_particolare");
				String riferimento = request.getParameter("riferimento");
				ArrayList<RilQuotaDTO>lista_quote = null;
						
				if(riferimento!=null && !riferimento.equals("") && !riferimento.equals("0")) {
					lista_quote = GestioneRilieviBO.getQuoteFromImprontaAndRiferimento(Integer.parseInt(id_particolare), Integer.parseInt(riferimento),session);			
				}else {
					lista_quote = GestioneRilieviBO.getQuoteFromImpronta(Integer.parseInt(id_particolare), session);
				}
				//ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(Integer.parseInt(id_particolare), session);
				ArrayList<RilQuotaDTO> lista_quote_filtrate = new ArrayList<RilQuotaDTO>();
				for (RilQuotaDTO quota : lista_quote) {
					List list = new ArrayList(quota.getListaPuntiQuota());
					Collections.sort(list, new Comparator<RilPuntoQuotaDTO>() {
					    public int compare(RilPuntoQuotaDTO o1, RilPuntoQuotaDTO o2) {
					    	Integer obj1 = o1.getId();
					    	Integer obj2 = o2.getId();
					        return obj1.compareTo(obj2);
					    }
					});
					for(int i = 0; i<list.size();i++) {
						if(((RilPuntoQuotaDTO)list.get(i)).getValore_punto()!=null && !((RilPuntoQuotaDTO)list.get(i)).getValore_punto().equals("OK") && !((RilPuntoQuotaDTO)list.get(i)).getValore_punto().equals("/")) {
							if(((RilPuntoQuotaDTO)list.get(i)).getValore_punto().equals("KO") || (NumberUtils.isNumber(quota.getTolleranza_positiva())&& !quota.getVal_nominale().contains("M")  && Double.parseDouble(((RilPuntoQuotaDTO)list.get(i)).getValore_punto())> Double.parseDouble(quota.getVal_nominale())+Double.parseDouble(quota.getTolleranza_positiva()))
							 || (NumberUtils.isNumber(quota.getTolleranza_negativa())&& !quota.getVal_nominale().contains("M")  && Double.parseDouble(((RilPuntoQuotaDTO)list.get(i)).getValore_punto())< Double.parseDouble(quota.getVal_nominale()) + Double.parseDouble(quota.getTolleranza_negativa()))) {
								lista_quote_filtrate.add(quota);
								break;
							}
						}
					}
					Set<RilPuntoQuotaDTO> foo = new HashSet<RilPuntoQuotaDTO>(list);

					TreeSet myTreeSet = new TreeSet();
					myTreeSet.addAll(foo);
					quota.setListaPuntiQuota(myTreeSet);
				}
								
				request.getSession().setAttribute("lista_quote", lista_quote_filtrate);
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioPuntiQuota.jsp");
		  	    dispatcher.forward(request,response);
			}
			
			else if(action.equals("filtra_delta")){
				
				ajax= false;
				String id_particolare = request.getParameter("id_particolare");
				String delta = request.getParameter("delta");
				String options = request.getParameter("options");
				String riferimento = request.getParameter("riferimento");
				ArrayList<RilQuotaDTO>lista_quote = null;
						
				if(riferimento!=null && !riferimento.equals("") && !riferimento.equals("0")) {
					lista_quote = GestioneRilieviBO.getQuoteFromImprontaAndRiferimento(Integer.parseInt(id_particolare), Integer.parseInt(riferimento),session);			
				}else {
					lista_quote = GestioneRilieviBO.getQuoteFromImpronta(Integer.parseInt(id_particolare), session);
				}
				//ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(Integer.parseInt(id_particolare), session);
				ArrayList<RilQuotaDTO> lista_quote_filtrate = new ArrayList<RilQuotaDTO>();				
				
					for (RilQuotaDTO quota : lista_quote) {
						List list = new ArrayList(quota.getListaPuntiQuota());
						Collections.sort(list, new Comparator<RilPuntoQuotaDTO>() {
						    public int compare(RilPuntoQuotaDTO o1, RilPuntoQuotaDTO o2) {
						    	Integer obj1 = o1.getId();
						    	Integer obj2 = o2.getId();
						        return obj1.compareTo(obj2);
						    }
						});
						if(!delta.equals("0")) {
							for(int i = 0; i<list.size();i++) {							

								if((RilPuntoQuotaDTO)list.get(i)!=null && ((RilPuntoQuotaDTO)list.get(i)).getDelta()!=null && !((RilPuntoQuotaDTO)list.get(i)).getDelta().equals("")) {
									Double delta_punto = new Double(((RilPuntoQuotaDTO) list.get(i)).getDelta().replace("-",""));
									Double delta_filtro  = new Double(delta.replace(",", ".")); 
									
									if(delta_punto.equals(delta_filtro) && !lista_quote_filtrate.contains(quota)) {
										lista_quote_filtrate.add(quota);		
									}
								}
								
							}
						}	
						Set<RilPuntoQuotaDTO> foo = new HashSet<RilPuntoQuotaDTO>(list);
	
						TreeSet myTreeSet = new TreeSet();
						myTreeSet.addAll(foo);
						quota.setListaPuntiQuota(myTreeSet);
					}
				
				if(!delta.equals("0")) {
					request.getSession().setAttribute("lista_quote", lista_quote_filtrate);
				}else {
					request.getSession().setAttribute("lista_quote", lista_quote);
				}
				
				ArrayList list = new ArrayList<String>(Arrays.asList(options.split(",")));
				request.getSession().setAttribute("delta_options", list);
				request.getSession().setAttribute("filtro_delta", true);
				request.getSession().setAttribute("delta", delta.replace(",", "."));
				request.getSession().setAttribute("filtro_da", "");
				request.getSession().setAttribute("filtro_a", "");
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioPuntiQuota.jsp");
		  	    dispatcher.forward(request,response);
			}
			
			else if(action.equals("filtra_da_a")){
				
				ajax= false;
				String id_particolare = request.getParameter("id_particolare");
				String da = request.getParameter("filtra_da");
				String a = request.getParameter("filtra_a");
				String options = request.getParameter("options");
				String riferimento = request.getParameter("riferimento");
				ArrayList<RilQuotaDTO>lista_quote = null;
						
				if(riferimento!=null && !riferimento.equals("") && !riferimento.equals("0")) {
					lista_quote = GestioneRilieviBO.getQuoteFromImprontaAndRiferimento(Integer.parseInt(id_particolare), Integer.parseInt(riferimento),session);			
				}else {
					lista_quote = GestioneRilieviBO.getQuoteFromImpronta(Integer.parseInt(id_particolare), session);
				}
				
				//ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(Integer.parseInt(id_particolare), session);
				ArrayList<RilQuotaDTO> lista_quote_filtrate = new ArrayList<RilQuotaDTO>();				
				
					for (RilQuotaDTO quota : lista_quote) {
						List list = new ArrayList(quota.getListaPuntiQuota());
						Collections.sort(list, new Comparator<RilPuntoQuotaDTO>() {
						    public int compare(RilPuntoQuotaDTO o1, RilPuntoQuotaDTO o2) {
						    	Integer obj1 = o1.getId();
						    	Integer obj2 = o2.getId();
						        return obj1.compareTo(obj2);
						    }
						});
						String max = Utility.getMaxDelta(quota, false);
						Double max_delta = null;
						if(!max.equals("")) {
							max_delta = new Double(max);
						}
						for(int i = 0; i<list.size();i++) {	
							
							if(max_delta!=null &&(RilPuntoQuotaDTO)list.get(i)!=null && ((RilPuntoQuotaDTO)list.get(i)).getDelta()!=null && (!((RilPuntoQuotaDTO) list.get(i)).getDelta().equals("")) && 
									max_delta>=new Double(da) && max_delta<=new Double(a) && !lista_quote_filtrate.contains(quota)) {
									lista_quote_filtrate.add(quota);										
							}								
						}
							
						Set<RilPuntoQuotaDTO> foo = new HashSet<RilPuntoQuotaDTO>(list);
	
						TreeSet myTreeSet = new TreeSet();
						myTreeSet.addAll(foo);
						quota.setListaPuntiQuota(myTreeSet);
					}
				
				
				request.getSession().setAttribute("lista_quote", lista_quote_filtrate);				
				ArrayList list = new ArrayList<String>(Arrays.asList(options.split(",")));
				request.getSession().setAttribute("delta_options", list);
				request.getSession().setAttribute("filtro_delta", true);
				request.getSession().setAttribute("filtro_da", da);
				request.getSession().setAttribute("filtro_a", a);
				request.getSession().setAttribute("delta", "");
				if(lista_quote_filtrate.size()==0) {
					request.getSession().setAttribute("empty", true);
				}else {
					request.getSession().setAttribute("empty", false);
				}
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioPuntiQuota.jsp");
		  	    dispatcher.forward(request,response);
			}
			
			
			else if(action.equals("elimina_rilievo")) {
				String id_rilievo = request.getParameter("id_rilievo");
				
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(Integer.parseInt(id_rilievo), session);
				rilievo.setDisabilitato(1);
//				ArrayList<RilParticolareDTO> lista_particolari = GestioneRilieviBO.getListaParticolariPerMisura(Integer.parseInt(id_rilievo), session);
//				for (RilParticolareDTO particolare : lista_particolari) {
//					ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(particolare.getId(), session);
//					for (RilQuotaDTO quota : lista_quote) {
//						List lista_punti = new ArrayList(quota.getListaPuntiQuota());
//						for (Object punto : lista_punti) {
//							session.delete(punto);
//						}
//						session.delete(quota);
//					}
//					session.delete(particolare);
//				}
//				session.delete(rilievo);
				session.update(rilievo);
				session.getTransaction().commit();
				session.close();
				
				PrintWriter out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Rilievo eliminato correttamente!");
				out.print(myObj);
				
			}
			
			else if(action.equals("elimina_allegato_archivio")) {
				String id_allegato = request.getParameter("id_allegato");
				RilAllegatiDTO allegato = GestioneRilieviBO.getAllegatoArchivioFromId(Integer.parseInt(id_allegato), session);
				session.delete(allegato);
				session.getTransaction().commit();
				session.close();
				
				PrintWriter out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Allegato eliminato correttamente!");
				out.print(myObj);
				
			}
			
			else if(action.equals("esporta_pdf")) {
				
				String selezionati = request.getParameter("dataIn");
				
				String[] ids = selezionati.split(",");
				
				ArrayList<RilQuotaDTO> lista_quote = new ArrayList<RilQuotaDTO>();
				for(int i = 0; i<ids.length;i++) {
					RilQuotaDTO quota = GestioneRilieviBO.getQuotaFromId(Integer.parseInt(ids[i]), session);
					lista_quote.add(quota);
				}
				List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
			
				String  path_simboli = getServletContext().getRealPath("/images") + "\\simboli_rilievi\\";
								
				RilMisuraRilievoDTO rilievo = lista_quote.get(0).getImpronta().getMisura();
				int ultima_scheda = 0;
				
				if(rilievo.getNumero_scheda()!=null && !rilievo.getNumero_scheda().equals("")) {
					ultima_scheda = Integer.parseInt(rilievo.getNumero_scheda().split("_")[1]);
				}else {
					ultima_scheda = (GestioneSchedaConsegnaBO.getUltimaScheda(session)+1);
				}
								
				new CreateTabellaRilievoPDF(lista_quote, rilievo, listaSedi, path_simboli, ultima_scheda, session);
				
				String path = Costanti.PATH_FOLDER + "RilieviDimensionali\\Schede\\" + lista_quote.get(0).getImpronta().getMisura().getId() + "\\Temp\\SRD_"+ultima_scheda+".pdf";
				//String path = "C:\\Users\\antonio.dicivita\\Desktop\\scheda_rilievo.pdf";
				File file = new File(path);
				
				FileInputStream fileIn = new FileInputStream(file);
				 
				 response.setContentType("application/pdf");
				  
				 response.setHeader("Content-Disposition","attachment;filename="+ file.getName());
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    rilievo.setNumero_scheda("SRD_"+ultima_scheda);
					session.update(rilievo);
				    session.getTransaction().commit();
				    session.close();

				    fileIn.close();
				    outp.flush();
				    outp.close();
			}
			else if(action.equals("clona_rilievo")) {
				
				String id_rilievo = request.getParameter("id_rilievo");
				String id_intervento = request.getParameter("id_intervento");
				String id_rilievo_new = request.getParameter("id_rilievo_new");
				
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getRilievoFromId(Integer.parseInt(id_rilievo), session);
				RilMisuraRilievoDTO new_rilievo =  GestioneRilieviBO.getRilievoFromId(Integer.parseInt(id_rilievo_new), session);
				new_rilievo.setApparecchio(rilievo.getApparecchio());
				new_rilievo.setDenominazione(rilievo.getDenominazione());				
				new_rilievo.setCifre_decimali(rilievo.getCifre_decimali());
				if(rilievo.getClasse_tolleranza()!=null && !rilievo.getClasse_tolleranza().equals("")) {
					new_rilievo.setClasse_tolleranza(rilievo.getClasse_tolleranza());
				}else {
					new_rilievo.setClasse_tolleranza("m");
				}				
				if(id_intervento!=null && !id_intervento.equals("")) {
					//new_rilievo.setId_intervento(Integer.parseInt(id_intervento));	
					RilInterventoDTO intervento = GestioneRilieviBO.getInterventoFromId(Integer.parseInt(id_intervento), session);
					new_rilievo.setIntervento(intervento);
					new_rilievo.setId_cliente_util(intervento.getId_cliente());
					new_rilievo.setId_sede_util(intervento.getId_sede());
					new_rilievo.setNome_cliente_util(intervento.getNome_cliente());
					new_rilievo.setNome_sede_util(intervento.getNome_sede());
				}
				
				//new_rilievo.setCommessa(intervento.getCommessa());
				new_rilievo.setData_inizio_rilievo(new Date());
				new_rilievo.setDisegno(rilievo.getDisegno());
				new_rilievo.setFornitore(rilievo.getFornitore());
				//new_rilievo.setId_cliente_util(rilievo.getId_cliente_util());
				//new_rilievo.setId_sede_util(rilievo.getId_sede_util());
				new_rilievo.setMateriale(rilievo.getMateriale());
				new_rilievo.setN_pezzi_tot(rilievo.getN_pezzi_tot());
				new_rilievo.setN_quote(0);
			
				new_rilievo.setStato_rilievo(new RilStatoRilievoDTO(1, ""));
				new_rilievo.setTipo_rilievo(rilievo.getTipo_rilievo());
				new_rilievo.setUtente(utente);
				new_rilievo.setVariante(rilievo.getVariante());
				DateFormatSymbols dfs = new DateFormatSymbols(Locale.ITALY);
		       // String[] months = dfs.getMonths();
		      //  String mese = months[Calendar.getInstance().get(Calendar.MONTH)];
				//new_rilievo.setMese_riferimento(mese.substring(0, 1).toUpperCase() + mese.substring(1));
				
				session.update(new_rilievo);
				ArrayList<RilParticolareDTO> lista_particolari = GestioneRilieviBO.getListaParticolariPerMisura(Integer.parseInt(id_rilievo), session);
				
				for (RilParticolareDTO particolare : lista_particolari) {
					RilParticolareDTO new_particolare = new RilParticolareDTO();
					new_particolare.setNome_impronta(particolare.getNome_impronta());
					new_particolare.setNumero_pezzi(particolare.getNumero_pezzi());
					new_particolare.setMisura(new_rilievo);
					ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(particolare.getId(), session);
					
					session.save(new_particolare);
					
					for (RilQuotaDTO quota : lista_quote) {
						RilQuotaDTO new_quota = new RilQuotaDTO();
						new_quota.setCapability(quota.getCapability());
						new_quota.setCoordinata(quota.getCoordinata());
						new_quota.setId_ripetizione(quota.getId_ripetizione());
						new_quota.setImportata(quota.getImportata());
						new_quota.setQuota_funzionale(quota.getQuota_funzionale());
						new_quota.setSigla_tolleranza(quota.getSigla_tolleranza());
						new_quota.setSimbolo(quota.getSimbolo());
						new_quota.setTolleranza_negativa(quota.getTolleranza_negativa());
						new_quota.setTolleranza_positiva(quota.getTolleranza_positiva());
						new_quota.setImpronta(new_particolare);		
						new_quota.setVal_nominale(quota.getVal_nominale());
						new_quota.setUm(quota.getUm());
						
						session.save(new_quota);
						List list = new ArrayList(quota.getListaPuntiQuota());
						Collections.sort(list, new Comparator<RilPuntoQuotaDTO>() {
						    public int compare(RilPuntoQuotaDTO o1, RilPuntoQuotaDTO o2) {
						    	Integer obj1 = o1.getId();
						    	Integer obj2 = o2.getId();
						        return obj1.compareTo(obj2);
						    }
						});
						
						for(int i = 0; i<list.size();i++) {
							RilPuntoQuotaDTO new_punto = new RilPuntoQuotaDTO();
							new_punto.setId_quota(new_quota.getId());
							new_punto.setValore_punto(null);
							
							session.save(new_punto);
						}						
					}					
				}
				
				session.getTransaction().commit();
				session.close();
				
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Rilievo clonato con successo!");
				PrintWriter out = response.getWriter();
				out.print(myObj);
				
			}
			else if(action.equals("elimina_particolare")) {
				
				String id_particolare = request.getParameter("id_particolare");
				
				RilParticolareDTO particolare = GestioneRilieviBO.getImprontaById(Integer.parseInt(id_particolare), session);			
				RilMisuraRilievoDTO rilievo = particolare.getMisura();
						
						
				ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(Integer.parseInt(id_particolare), session);
				
				for (RilQuotaDTO rilQuotaDTO : lista_quote) {

					for (RilPuntoQuotaDTO rilPuntoQuotaDTO : rilQuotaDTO.getListaPuntiQuota()) {
						session.delete(rilPuntoQuotaDTO);
					}
					session.delete(rilQuotaDTO);
				}
				
				
				session.delete(particolare);
				
				ArrayList<RilParticolareDTO> lista_particolari = GestioneRilieviBO.getListaParticolariPerMisura(rilievo.getId(), session);
				int quote_tot = 0;
				int pezzi_tot = 0;
				for (RilParticolareDTO part : lista_particolari) {
					ArrayList<RilQuotaDTO> quote = GestioneRilieviBO.getQuoteFromImpronta(part.getId(), session);
					//quote_tot = quote_tot + (lista_quote.size()*part.getNumero_pezzi());
					quote_tot = quote_tot + GestioneRilieviBO.contaQuote(quote);
					if(rilievo.getTipo_rilievo().getId()!=2) {
						pezzi_tot = pezzi_tot + part.getNumero_pezzi();	
					}else {
						pezzi_tot = pezzi_tot + GestioneRilieviBO.getNumeroPezziCPCPK(part.getId(), session);
					}
				}				
				rilievo.setN_quote(quote_tot);
				rilievo.setN_pezzi_tot(pezzi_tot);
				session.update(rilievo);				
				
				session.getTransaction().commit();
				session.close();
				
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Particolare eliminato con successo!");
				PrintWriter out = response.getWriter();
				out.print(myObj);
				
			}
			else if(action.equals("salva_tempo_scansione")) {
				
				String id_rilievo = request.getParameter("id_rilievo");
				String tempo_scansione = request.getParameter("tempo_scansione");
				
				RilMisuraRilievoDTO rilievo = (RilMisuraRilievoDTO) request.getSession().getAttribute("rilievo");
				
				if(rilievo==null) {
					rilievo = GestioneRilieviBO.getMisuraRilieviFromId(Integer.parseInt(id_rilievo), session);					
				}			
				
				
				PrintWriter out = response.getWriter();
				if(tempo_scansione!=null) {
					rilievo.setTempo_scansione(new Double(tempo_scansione));
					session.update(rilievo);
					myObj.addProperty("success", true);
					
				}
				else if(tempo_scansione.equals("")){
					rilievo.setTempo_scansione(null);
					session.update(rilievo);
					myObj.addProperty("success", true);
				}else {
				
					myObj.addProperty("success", false);
					myObj.addProperty("messaggio", "Impossibile salvare il tempo scansione! Formato errato!");
					
					
				}
				session.getTransaction().commit();
				session.close();
				out.print(myObj);
				
				
			}
			
			else if(action.equals("download_scheda_rilievo")) {
				
				ajax = false;
				String id_rilievo= request.getParameter("id_rilievo");	
				String filename = request.getParameter("filename");
				
				id_rilievo = Utility.decryptData(id_rilievo);
				
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(Integer.parseInt(id_rilievo), session);
				String path = Costanti.PATH_FOLDER+"RilieviDimensionali\\Schede\\"+rilievo.getId()+"\\"+rilievo.getNumero_scheda()+".pdf";
				
				File file = new File(path);
				
				FileInputStream fileIn = new FileInputStream(file);
				if(filename!=null && (filename.endsWith("pdf")||filename.endsWith("PDF"))) {
					response.setContentType("application/pdf");
				}
				else if(filename==null) {
					response.setContentType("application/pdf");
				}
				else {
					response.setContentType("application/octet-stream");
					response.setHeader("Content-Disposition","attachment;filename="+ file.getName());
				}
				 
				  
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    session.getTransaction().commit();
				    session.close();
				    fileIn.close();
				    outp.flush();
				    outp.close();
				
			}

			else if(action.equals("cerca_rilievi")) {
				
				String disegno = request.getParameter("disegno_clona");
				String variante = request.getParameter("variante_clona");
				
				ArrayList<RilMisuraRilievoDTO> lista_rilievi = GestioneRilieviBO.getListaRilieviDisVar(disegno, variante, session);
				
				
				session.getTransaction().commit();
				session.close();
				
				 Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
				myObj.addProperty("success", true);
				myObj.add("lista_rilievi", g.toJsonTree(lista_rilievi));
				PrintWriter out = response.getWriter();
				out.print(myObj);
				
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

	
	
	void modificaPezziParticolare(RilParticolareDTO particolare, int n_pezzi_new, Session session) {
		ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(particolare.getId(), session);
		if(n_pezzi_new < particolare.getNumero_pezzi()) {
			int toDelete = particolare.getNumero_pezzi() - n_pezzi_new;
			
			for(int i = 0; i< toDelete; i++) {
			for (RilQuotaDTO quota : lista_quote) {
			List list = new ArrayList(quota.getListaPuntiQuota());
			
			Collections.sort(list, new Comparator<RilPuntoQuotaDTO>() {
			    public int compare(RilPuntoQuotaDTO o1, RilPuntoQuotaDTO o2) {
			    	Integer obj1 = o1.getId();
			    	Integer obj2 = o2.getId();
			        return obj1.compareTo(obj2);
			    }
			});
				int index = Utility.getMaxIdPuntoQuota((ArrayList<RilPuntoQuotaDTO>) list);						
				session.delete(list.get(index-i));	
			}
		}
	}else {
		for (RilQuotaDTO quota : lista_quote) {
			int toAdd =	n_pezzi_new - quota.getListaPuntiQuota().size();
			for(int i = 0; i<toAdd; i++) {
				RilPuntoQuotaDTO punto = new RilPuntoQuotaDTO();
				punto.setId_quota(quota.getId());
				punto.setValore_punto(null);
				session.save(punto);
			}
		}
	}
	}
}
