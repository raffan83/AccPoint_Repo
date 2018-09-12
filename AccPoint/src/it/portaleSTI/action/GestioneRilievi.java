package it.portaleSTI.action;

import java.io.File;
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

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.RilParticolareDTO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.RilPuntoQuotaDTO;
import it.portaleSTI.DTO.RilQuotaDTO;
import it.portaleSTI.DTO.RilQuotaFunzionaleDTO;
import it.portaleSTI.DTO.RilSimboloDTO;
import it.portaleSTI.DTO.RilStatoRilievoDTO;
import it.portaleSTI.DTO.RilTipoRilievoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneRilieviBO;
import sun.security.krb5.internal.tools.Klist;

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
		PrintWriter out = response.getWriter();
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
        response.setContentType("application/json");
		try {
			if(action.equals("nuovo")) {
				ajax=true;
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
				
								
				String tipo_rilievo = ret.get("tipo_rilievo");
				String data_inizio_rilievo = ret.get("data_inizio_rilievo");
				
				RilMisuraRilievoDTO misura_rilievo = new RilMisuraRilievoDTO();
				
				misura_rilievo.setId_cliente_util(Integer.parseInt(cliente));
				misura_rilievo.setId_sede_util(Integer.parseInt(sede.split("_")[0]));
				misura_rilievo.setTipo_rilievo(new RilTipoRilievoDTO(Integer.parseInt(tipo_rilievo), ""));
				misura_rilievo.setCommessa(commessa);
				misura_rilievo.setUtente(utente);
	
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
							
				RilMisuraRilievoDTO misura_rilievo = GestioneRilieviBO.getMisuraRilieviFromId(Integer.parseInt(id_rilievo), session);
				
				misura_rilievo.setId_cliente_util(Integer.parseInt(cliente));
				misura_rilievo.setId_sede_util(Integer.parseInt(sede.split("_")[0]));
				misura_rilievo.setTipo_rilievo(new RilTipoRilievoDTO(Integer.parseInt(tipo_rilievo), ""));
				misura_rilievo.setCommessa(commessa);
				misura_rilievo.setUtente(utente);
				
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
				
				RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(Integer.parseInt(id_rilievo), session);				
				ArrayList<RilParticolareDTO> lista_impronte = GestioneRilieviBO.getListaParticolariPerMisura(Integer.parseInt(id_rilievo), session);
				ArrayList<RilSimboloDTO> lista_simboli = GestioneRilieviBO.getListaSimboli();
				ArrayList<RilQuotaFunzionaleDTO> lista_quote_funzionali = GestioneRilieviBO.getListaQuoteFunzionali();				
				
				session.close();
				request.getSession().setAttribute("rilievo", rilievo);
				request.getSession().setAttribute("lista_impronte", lista_impronte);
				request.getSession().setAttribute("lista_simboli", lista_simboli);
				request.getSession().setAttribute("lista_quote_funzionali", lista_quote_funzionali);
			//	request.getSession().setAttribute("numero_impronte", numero_impronte);
//				if(lista_impronte!=null && lista_impronte.size()>0) {
//					request.getSession().setAttribute("numero_pezzi", lista_impronte.get(0).getNumero_pezzi());
//				}else {
//					request.getSession().setAttribute("numero_pezzi", 0);
//				}
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioRilievo.jsp");
		  	    dispatcher.forward(request,response);	
		  	    
		  	    
			}
			else if(action.equals("nuovo_particolare")) {
				ajax = true;
				
				RilMisuraRilievoDTO rilievo = (RilMisuraRilievoDTO)request.getSession().getAttribute("rilievo");
				
				//String nome_impronta = request.getParameter("nome_impronta");
				String numero_impronte = request.getParameter("numero_impronte");
				String n_pezzi = request.getParameter("n_pezzi");
				String quote_pezzo = request.getParameter("quote_pezzo");
				String nomi_impronte = request.getParameter("nomi_impronte");
				String ripetizioni = request.getParameter("ripetizioni");
				int n =0;
				
				
				
				if(numero_impronte.equals("")) {
					numero_impronte = "1";
				}
				
				if(ripetizioni!=null) {
					n=Integer.parseInt(ripetizioni) * Integer.parseInt(quote_pezzo);
				}else {
					if(quote_pezzo!=null && !quote_pezzo.equals(""))
					n=Integer.parseInt(quote_pezzo);
				}
					for(int i=0; i<Integer.parseInt(numero_impronte);i++) {					
					
						RilParticolareDTO particolare = new RilParticolareDTO();
						particolare.setMisura(rilievo);
						particolare.setNome_impronta("");
						particolare.setNumero_pezzi(Integer.parseInt(n_pezzi));
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
				myObj.addProperty("messaggio", "Impronta aggiunta con successo!");
				out.print(myObj);
				
			}
			
			else if(action.equals("update_celle")) {
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
						if(quota_funzionale!=null && !quota_funzionale.equals("")) {
							quota.setQuota_funzionale(new RilQuotaFunzionaleDTO(Integer.parseInt(quota_funzionale.split("_")[0]), ""));
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
							for(int i=8; i<json_array.size();i++) {
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
						session.close();

						}
		
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

				request.getSession().setAttribute("id_impronta", id_impronta);		
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioPuntiQuota.jsp");
		  	    dispatcher.forward(request,response);
			
				
			}
			else if(action.equals("aggiungi_pezzo")) {
				ajax=true;
				int n_pezzi = (int)request.getSession().getAttribute("numero_pezzi");				
				String pezzi_da_aggiungere = request.getParameter("pezzi_da_aggiungere");				
				RilMisuraRilievoDTO rilievo = (RilMisuraRilievoDTO)request.getSession().getAttribute("rilievo");	
				
				GestioneRilieviBO.updatePezzi(n_pezzi+ Integer.parseInt(pezzi_da_aggiungere), rilievo.getId(), session);
				
				session.getTransaction().commit();
				session.close();
				
				request.getSession().setAttribute("numero_pezzi", n_pezzi+ Integer.parseInt(pezzi_da_aggiungere));
				myObj.addProperty("success", true);
				myObj.addProperty("pezzi", n_pezzi+ Integer.parseInt(pezzi_da_aggiungere));
				out.print(myObj);
				
			}
			
			else if(action.equals("calcola_tolleranze")) {
				
				ajax=true;
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
				
				out.print(myObj);
				
			}
			
			else if(action.equals("nuova_quota")) {
				ajax=true;
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
				if(simbolo.equals("2_intersezione")) {
					um = "°";
				}else {
					um = "mm";
				}
				String note = ret.get("note");
				RilQuotaDTO quota = null;
				
				if(id_quota!=null && !id_quota.equals("")) {
					quota = GestioneRilieviBO.getQuotaFromId(Integer.parseInt(id_quota),session);					
				}else {
					quota = new RilQuotaDTO();
				}
				
				
				
				quota.setImpronta(new RilParticolareDTO(Integer.parseInt(particolare)));
				quota.setCoordinata(coordinata);
				quota.setUm(um);
				quota.setVal_nominale(new BigDecimal(val_nominale.replace(",", ".")));
				quota.setSimbolo(new RilSimboloDTO(Integer.parseInt(simbolo.split("_")[0]),""));
				quota.setTolleranza_negativa(new BigDecimal(tolleranza_neg.replace(",", ".")));
				quota.setTolleranza_positiva(new BigDecimal(tolleranza_pos.replace(",", ".")));
				if(quota_funzionale!=null & !quota_funzionale.equals("")) {
					quota.setQuota_funzionale(new RilQuotaFunzionaleDTO(Integer.parseInt(quota_funzionale.split("_")[0]), ""));
				}
				
				if(!lettera.equals("") && !numero.equals("")) {
					quota.setSigla_tolleranza(lettera+numero);
				}
				
				if(id_quota!=null && !id_quota.equals("")) {
					session.update(quota);
				}else {
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
				if(simbolo.equals("2_intersezione")) {
					um = "°";
				}else {
					um = "mm";
				}
				String note = ret.get("note");
				RilQuotaDTO quota = null;
				
				
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
				quota.setVal_nominale(new BigDecimal(val_nominale.replace(",", ".")));
				if(simbolo!=null && !simbolo.equals("")) {
					quota.setSimbolo(new RilSimboloDTO(Integer.parseInt(simbolo.split("_")[0]),""));
				}
				quota.setTolleranza_negativa(new BigDecimal(tolleranza_neg.replace(",", ".")));
				quota.setTolleranza_positiva(new BigDecimal(tolleranza_pos.replace(",", ".")));
				if(quota_funzionale!=null & !quota_funzionale.equals("")) {
					quota.setQuota_funzionale(new RilQuotaFunzionaleDTO(Integer.parseInt(quota_funzionale.split("_")[0]), ""));
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
				//}
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
					if(impr.getId()==lista_impronte.get(i).getId()) {
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
			
			
			
			else if(action.equals("update_celle_replica")) {
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
							if(quota_funzionale!=null && !quota_funzionale.equals("")) {
								quota.setQuota_funzionale(new RilQuotaFunzionaleDTO(Integer.parseInt(quota_funzionale.split("_")[0]), ""));
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
						session.close();

						}
				}
		
			}
			
			
			else if(action.equals("chiudi_rilievo")) {
				ajax = true;
				
				String id_rilievo = request.getParameter("id_rilievo");
				
				GestioneRilieviBO.chiudiRilievo(Integer.parseInt(id_rilievo), session);
				session.getTransaction().commit();
				session.close();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Rilievo chiuso con successo!");
				out.print(myObj);
				
			}
			


		} catch (Exception e) {
			if(ajax) {
				e.printStackTrace();
	        	session.getTransaction().rollback();
	        	session.close();
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
		
		int max =0;
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
