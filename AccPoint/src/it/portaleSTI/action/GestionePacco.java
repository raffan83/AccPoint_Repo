package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.apache.commons.lang3.CharSet;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AttivitaMilestoneDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DpiAllegatiDTO;
import it.portaleSTI.DTO.MagAllegatoDTO;
import it.portaleSTI.DTO.MagAllegatoItemDTO;
import it.portaleSTI.DTO.MagAspettoDTO;
import it.portaleSTI.DTO.MagAttivitaItemDTO;
import it.portaleSTI.DTO.MagCausaleDTO;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.DTO.MagItemDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.MagSaveStatoDTO;
import it.portaleSTI.DTO.MagStatoItemDTO;
import it.portaleSTI.DTO.MagStatoLavorazioneDTO;
import it.portaleSTI.DTO.MagTipoDdtDTO;
import it.portaleSTI.DTO.MagTipoItemDTO;
import it.portaleSTI.DTO.MagTipoNotaPaccoDTO;
import it.portaleSTI.DTO.MagTipoPortoDTO;
import it.portaleSTI.DTO.MagTipoTrasportoDTO;
import it.portaleSTI.DTO.RilInterventoDTO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.RilStatoRilievoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateTestaPacco;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneMagazzinoBO;
import it.portaleSTI.bo.GestioneRilieviBO;
import it.portaleSTI.bo.GestioneStrumentoBO;




/**
 * Servlet implementation class GestionePacco
 */
@WebServlet("/gestionePacco.do")
public class GestionePacco extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	static final Logger logger = Logger.getLogger(GestionePacco.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestionePacco() {
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
		
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		String action = request.getParameter("action");
		UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
		CompanyDTO company =(CompanyDTO)request.getSession().getAttribute("usrCompany");
		boolean ajax = false;
		boolean rilievi=false;
		try {
			
		logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo());
		
		if(action.equals("new")) {
		ArrayList<MagPaccoDTO> lista_pacchi = (ArrayList<MagPaccoDTO>) request.getSession().getAttribute("lista_pacchi");
		
		ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
		
		response.setContentType("application/json");
		request.setCharacterEncoding("utf-8");
		String cliente = "";
		String sede = "";
		String numero_ddt = "";
		String annotazioni = "";
		String tipo_trasporto = "";
		String tipo_porto = "";
		String tipo_ddt = "";
		String data_ddt = "";
		String aspetto = "";
		String causale ="";
		String destinatario ="";
		String data_ora_trasporto = "";
		String spedizioniere = "";
		String note = "";
		String data_trasporto ="";
		String codice_pacco = "";
		String link_pdf ="";
		String link_pdf_old ="";
		String stato_lavorazione ="";
		String id_pacco ="";
		String id_ddt = "";
		String commessa = "";		
		String origine= "";
		String note_pacco = "";
		String data_arrivo = "";
		String colli = "";
		String fornitore = "";
		String fornitore_modal = "";
		String operatore_trasporto = "";
		String select_nota_pacco = "";
		String data_spedizione = "";
		String sede_destinatario = "";
		String destinazione = "";
		String sede_destinazione = "";
		String cortese_attenzione = "";
		String peso="";
		String magazzino="";
		String configurazione="";
		String account = "";
		String testa_pacco = "";
		String cliente_util = "";
		String sede_util = "";
		String ritardo = "";
		String pezzi_ingresso="";
		Map<String, String> filename_allegato_rilievo = new HashMap<String,String>();
		String data_json_rilievi ="";
		String modifica_pezzi_rilievo_id = "";
		String data_lavorazione = "";
		
		FileItem pdf = null;
		
		Map<String,FileItem> allegato_rilievo = new HashMap<String,FileItem>();
		MagPaccoDTO pacco = new MagPaccoDTO();
		MagDdtDTO ddt = new MagDdtDTO();
		 Map<MagItemDTO, String> map = new HashMap<MagItemDTO, String>();
		 List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
		 RilMisuraRilievoDTO rilievo = null;  
		 RilInterventoDTO ril_intervento= null;
		List<FileItem> items;
		//try {
			items = uploadHandler.parseRequest(request);
			
			for (FileItem item : items) {
				if (item.isFormField()) {
					if(item.getFieldName().equals("json")) {
						
					String data_json = item.getString("UTF-8");
					
					JsonElement jelement = new JsonParser().parse(data_json);
					JsonArray json_array = jelement.getAsJsonArray();
					
					
					for(int i = 0 ; i<json_array.size();i++) {
						
						JsonObject json_obj = json_array.get(i).getAsJsonObject();
						
						String id_proprio = json_obj.get("id_proprio").getAsString();
						String tipo = json_obj.get("tipo").getAsString();
 						String denominazione = json_obj.get("denominazione").getAsString().replaceAll("\t", " ");
						String quantita = json_obj.get("quantita").getAsString();
						String stato = json_obj.get("stato").getAsString();
						String note_item = json_obj.get("note").getAsString().replaceAll("\t", " ");
						String priorita = json_obj.get("priorita").getAsString();
						String attivita = json_obj.get("attivita").getAsString();
						String dest = json_obj.get("destinazione").getAsString();
						String codice_interno = null;
						String matricola = null;
						String id = null;
						if(json_obj.get("id")!=null) {
							id = json_obj.get("id").getAsString();
						}
						
						if(tipo.equals("Strumento")) {
							if(json_obj.get("codice_interno")!=null) {
								codice_interno = json_obj.get("codice_interno").getAsString();
							}							
						}
						if(json_obj.get("matricola")!=null) {
							matricola = json_obj.get("matricola").getAsString();
						}
						MagItemDTO mag_item = null;
						if(id!=null){
							mag_item = GestioneMagazzinoBO.getItemById(Integer.parseInt(id), session);
						}else {
							mag_item = new MagItemDTO();
						}
						mag_item.setId_tipo_proprio(Integer.parseInt(id_proprio));
						mag_item.setDescrizione(denominazione);
						if(codice_interno!=null) {
							mag_item.setCodice_interno(codice_interno);
						}
						if(matricola!=null) {
							mag_item.setMatricola(matricola);
						}
						if(priorita.equals("1")) {
						mag_item.setPriorita(1);
						}else {
							mag_item.setPriorita(0);
						}
						int tipo_number;
						if(tipo.equals("Strumento"))
							tipo_number = 1;
						else if(tipo.equals("Accessorio"))
							tipo_number = 2;
						else
							tipo_number = 3;
						
						int stato_number;
						if(stato.equals("In lavorazione"))
							stato_number = 1;
						else if(stato.equals("Lavorato"))
							stato_number = 2;
						else
							stato_number = 3;
						
						mag_item.setTipo_item(new MagTipoItemDTO(tipo_number, ""));
						mag_item.setStato(new MagStatoItemDTO(stato_number, ""));
						if(attivita!=null && !attivita.equals("")) {
							mag_item.setAttivita_item((new MagAttivitaItemDTO(Integer.parseInt(attivita), "")));
						}else {
							mag_item.setAttivita_item(null);
						}
						mag_item.setDestinazione(dest);
						map.put(mag_item, quantita+"_"+note_item);
						if(id!=null) {
							session.update(mag_item);
						}else {
							GestioneMagazzinoBO.saveItem(mag_item, session);
						}
					}
				
					
					}
					if(item.getFieldName().equals("json_rilievi")) {
						
						data_json_rilievi = item.getString();
						//String data_json = item.getString();
//					    if(data_json!=null && !data_json.equals("")) {
//						JsonElement jelement = new JsonParser().parse(data_json);
//						JsonArray json_array = jelement.getAsJsonArray();
//						
//						
//						for(int i = 0 ; i<json_array.size();i++) {
//							
//							rilievi=true;
//							JsonObject json_obj = json_array.get(i).getAsJsonObject();
//							
//							String id_proprio = null;
//							
//							if(json_obj.get("id_proprio")!=null) {
//								id_proprio =json_obj.get("id_proprio").getAsString(); 
//							}									
//							String disegno = json_obj.get("disegno").getAsString();
//							String variante = json_obj.get("variante").getAsString();
//	 						pezzi_ingresso = json_obj.get("pezzi_ingresso").getAsString();
//	 						String note_rilievo = json_obj.get("note_rilievo").getAsString();
//						//	String quantita = json_obj.get("quantita").getAsString();
//	 						String id = null;
//							if(json_obj.get("id")!=null) {
//								id = json_obj.get("id").getAsString();
//							}
//							
//							MagItemDTO mag_item = 	null;
//							
//	 						if(id!=null) {
//	 							rilievo = GestioneRilieviBO.getMisuraRilieviFromId(Integer.parseInt(id_proprio), session);
//	 							mag_item = GestioneMagazzinoBO.getItemById(Integer.parseInt(id), session);
//	 						}else {
//	 							rilievo = new RilMisuraRilievoDTO();
//	 							mag_item = 	new MagItemDTO();
//	 							rilievo.setStato_rilievo(new RilStatoRilievoDTO(1, ""));
//	 						}
//							rilievo.setDisegno(disegno);
//							rilievo.setVariante(variante);
//							rilievo.setCifre_decimali(3);
//							
//							if(pezzi_ingresso!= null && !pezzi_ingresso.equals("")) {
//								rilievo.setPezzi_ingresso(Integer.parseInt(pezzi_ingresso));	
//							}
//							
//							
//							rilievo.setId_cliente_util(Integer.parseInt(cliente_util));
//							//rilievo.setNome_cliente_util(util.getNome());
//							rilievo.setId_sede_util(Integer.parseInt(sede_util.split("_")[0]));
//							rilievo.setData_inizio_rilievo(new Date());
//							rilievo.setCommessa(commessa);
//							rilievo.setClasse_tolleranza("m");
//							
//						
//							
//							if(id!=null) {
//								session.update(rilievo);
//							}else {
//								session.save(rilievo);
//							}
//							
//							mag_item.setId_tipo_proprio(rilievo.getId());							
//							
//							mag_item.setTipo_item(new MagTipoItemDTO(4, ""));
//							mag_item.setDescrizione(disegno+" "+variante);
//							mag_item.setDisegno(disegno);
//							mag_item.setVariante(variante);
//							if(pezzi_ingresso!= null && !pezzi_ingresso.equals("")) {
//								mag_item.setPezzi_ingresso(Integer.parseInt(pezzi_ingresso));
//							}
//							
//							
//							map.put(mag_item, "0_"+note_rilievo);
//							
//							if(id!=null) {
//								
//								session.update(mag_item);
//							}else {
//								
//								GestioneMagazzinoBO.saveItem(mag_item, session);
//							}
//						}
//							
//						}
						
					}
					if(item.getFieldName().equals("select1")) {
						cliente =	item.getString();
					}			
					if(item.getFieldName().equals("select2")) {
						 sede =	item.getString();
					}
					if(item.getFieldName().equals("codice_pacco")) {
						 codice_pacco =	item.getString();
					}
					if(item.getFieldName().equals("stato_lavorazione")) {
						stato_lavorazione = item.getString();
					}
					if(item.getFieldName().equals("numero_ddt")) {
						 numero_ddt =	item.getString();
					}
					if(item.getFieldName().equals("magazzino")) {
						magazzino =	item.getString();
					}
					if(item.getFieldName().equals("tipo_trasporto")) {
						 tipo_trasporto =	item.getString();
					}
					if(item.getFieldName().equals("data_lavorazione")) {
						data_lavorazione =	item.getString();
					}
					if(item.getFieldName().equals("tipo_porto")) {
						 tipo_porto =	item.getString();
					}
					if(item.getFieldName().equals("tipo_ddt")) {
						 tipo_ddt =	item.getString();
					}
					if(item.getFieldName().equals("peso")) {
						peso =	item.getString();
					}
					if(item.getFieldName().equals("data_ddt")) {
						 data_ddt =	item.getString();
					}
					if(item.getFieldName().equals("aspetto")) {
						 aspetto =	item.getString().replaceAll("\t", " ");
					}
					if(item.getFieldName().equals("configurazione")) {
						 configurazione =	item.getString().replaceAll("\t", " ");
					}
					if(item.getFieldName().equals("causale")) {
						 causale =	item.getString().replaceAll("\t", " ");
					}
					if(item.getFieldName().equals("destinatario")) {
						 destinatario =	item.getString();
					}
					if(item.getFieldName().equals("sede_destinatario")) {
						sede_destinatario =	item.getString();
					}
					if(item.getFieldName().equals("destinazione")) {
						destinazione =	item.getString();
					}
					if(item.getFieldName().equals("sede_destinazione")) {
						sede_destinazione =	item.getString();
					}
					if(item.getFieldName().equals("via")) {
						 item.getString();
					}
					if(item.getFieldName().equals("citta")) {
						 item.getString();
					}
					if(item.getFieldName().equals("cap")) {
						 item.getString();
					}
					if(item.getFieldName().equals("provincia")) {
						 item.getString();
					}
					if(item.getFieldName().equals("paese")) {
						 item.getString();
					}
					if(item.getFieldName().equals("select_fornitore")) {
						 fornitore =	item.getString();
					}
					if(item.getFieldName().equals("select_sede_fornitore")) {
						 item.getString();
					}
					if(item.getFieldName().equals("select_fornitore_modal")) {
						 fornitore_modal =	item.getString();
					}
					if(item.getFieldName().equals("cortese_attenzione")) {
						cortese_attenzione =	item.getString().replaceAll("\t", " ");
					}
					if(item.getFieldName().equals("data_ora_trasporto")) {
						data_ora_trasporto =	item.getString();
						if(!data_ora_trasporto.equals(" ") && !data_ora_trasporto.equals("")) {
						 String x [];
						 x=data_ora_trasporto.split(" ");
						 if(x.length>1) {
						 data_trasporto = x[0];
						 //ora_trasporto = x[1];
						 }else {
							 data_trasporto = x[0];
						 }
						}
					}
					if(item.getFieldName().equals("spedizioniere")) {
						 spedizioniere =	item.getString().replaceAll("\t", " ");
					}
					if(item.getFieldName().equals("account")) {
						 account =	item.getString().replaceAll("\t", " ");
					}
					if(item.getFieldName().equals("annotazioni")) {
						annotazioni =	item.getString().replaceAll("\t", " ");
					}
					if(item.getFieldName().equals("note")) {
						 note =	item.getString().replaceAll("\t", " ");
					}
					if(item.getFieldName().equals("id_pacco")) {
						 id_pacco =	item.getString();
					}
					if(item.getFieldName().equals("id_ddt")) {
						 id_ddt =	item.getString();
					}
					if(item.getFieldName().equals("pdf_path")) {
						link_pdf_old = item.getString();
					}
					if(item.getFieldName().equals("commessa_text")) {
						commessa = item.getString();
					}
					if(item.getFieldName().equals("origine_pacco")) {
						origine = item.getString();
					}
					if(item.getFieldName().equals("testa_pacco")) {
						testa_pacco = item.getString();
					}
					if(item.getFieldName().equals("note_pacco")) {
						
						byte[] b = item.get();
						note_pacco = new String(b);
				
					}
					if(item.getFieldName().equals("data_arrivo")) {
						data_arrivo = item.getString();
					}
					if(item.getFieldName().equals("colli")) {
						colli = item.getString();
					}
					if(item.getFieldName().equals("attivita_pacco")) {
						item.getString();
					}
					if(item.getFieldName().equals("operatore_trasporto")) {
						operatore_trasporto = item.getString().replaceAll("\t", " ");
					}
					if(item.getFieldName().equals("select_nota_pacco")) {
						select_nota_pacco = item.getString();
					}
					if(item.getFieldName().equals("data_spedizione")) {
						data_spedizione = item.getString();
					}
					if(item.getFieldName().equals("cliente_utilizzatore")) {
						cliente_util = item.getString();
					}
					if(item.getFieldName().equals("sede_utilizzatore")) {
						sede_util = item.getString();
					}
					if(item.getFieldName().equals("ritardo")) {
						ritardo = item.getString();
					}
					if(item.getFieldName().equals("modifica_pezzi_rilievo_id")) {
						modifica_pezzi_rilievo_id = item.getString();
					}
				}else {
					
					if(item.getName()!="" && !item.getFieldName().startsWith("modifica_pezzi_rilievo_upload")) {
					pdf = item;
					link_pdf = item.getName();
					
					}
					else if(item.getFieldName().startsWith("modifica_pezzi_rilievo_upload")) {
						
						allegato_rilievo.put(item.getFieldName().split("_")[4], item);
						System.out.println(item.getSize());
						filename_allegato_rilievo.put(item.getFieldName().split("_")[4], item.getName());
					}
					
				}
			
		}
			ClienteDTO cl = new ClienteDTO();
			SedeDTO sd = null;
			if(!sede.equals("0")) {
				String sede_split [];
				sede_split=sede.split("_");
				cl=GestioneAnagraficaRemotaBO.getClienteFromSede(cliente, sede_split[0]);
				pacco.setId_sede(Integer.parseInt(sede_split[0]));
	
				sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(sede_split[0]), cl.get__id());
				pacco.setNome_sede(sd.getDescrizione() +" - " +sd.getIndirizzo());
			}else {
				cl = GestioneAnagraficaRemotaBO.getClienteById(cliente);
				pacco.setId_sede(0);
				pacco.setNome_sede("Non associate");
			}
			
			pacco.setCliente(cl);
			pacco.setId_cliente(cl.get__id());
			pacco.setNome_cliente(cl.getNome());
			
			ClienteDTO util = new ClienteDTO();
			SedeDTO sd_util = null;
			if(!sede_util.equals("0")) {
				String sede_util_split [];
				sede_util_split=sede_util.split("_");
				util=GestioneAnagraficaRemotaBO.getClienteFromSede(cliente_util, sede_util_split[0]);
				
				sd_util = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(sede_util_split[0]), util.get__id());
				pacco.setNome_sede_util(sd_util.getDescrizione() + " - "+sd_util.getIndirizzo());
			}else {
				util = GestioneAnagraficaRemotaBO.getClienteById(cliente_util);				
				pacco.setNome_sede_util("Non associate");
			}
			pacco.setNome_cliente_util(util.getNome());	
			pacco.setId_cliente_util(Integer.parseInt(cliente_util));
			pacco.setId_sede_util(Integer.parseInt(sede_util.split("_")[0]));
			
			
			if(data_json_rilievi!=null && !data_json_rilievi.equals("") && !data_json_rilievi.equals("[]")) {
				JsonElement jelement = new JsonParser().parse(data_json_rilievi);
				JsonArray json_array = jelement.getAsJsonArray();
				
				
				ril_intervento = new RilInterventoDTO();
				
				if(id_pacco==null || id_pacco.equals("")) {
					ril_intervento.setData_apertura(new Date());
					ril_intervento.setId_cliente(Integer.parseInt(cliente_util));
					ril_intervento.setId_sede(Integer.parseInt(sede_util.split("_")[0]));
					ril_intervento.setCommessa(commessa);
					ril_intervento.setStato_intervento(1);
					ril_intervento.setNome_cliente(util.getNome());
					ril_intervento.setId_pacco(pacco.getId());
					
					if(!sede_util.equals("0")) {
						ril_intervento.setNome_sede(sd_util.getDescrizione() + " - "+sd_util.getIndirizzo());
					}else {
							
						ril_intervento.setNome_sede("Non associate");						
					}
					
					session.save(ril_intervento);
				}else {
					
					ril_intervento = GestioneRilieviBO.getIntrventoFromPacco(Integer.parseInt(id_pacco), session);
				}
				
				//rilievo.setId_intervento(ril_intervento.getId());
				
				
				for(int i = 0 ; i<json_array.size();i++) {
					
					rilievi=true;
					JsonObject json_obj = json_array.get(i).getAsJsonObject();
					
					String id_proprio = null;
					
					if(json_obj.get("id_proprio")!=null) {
						id_proprio =json_obj.get("id_proprio").getAsString(); 
					}									
					String disegno = json_obj.get("disegno").getAsString();
					String variante = json_obj.get("variante").getAsString();
						pezzi_ingresso = json_obj.get("pezzi_ingresso").getAsString();
						String note_rilievo = json_obj.get("note_rilievo").getAsString();
				//	String quantita = json_obj.get("quantita").getAsString();
						String id = null;
					if(json_obj.get("id")!=null) {
						id = json_obj.get("id").getAsString();
					}
					
					MagItemDTO mag_item = 	null;
					
						if(id!=null) {
							rilievo = GestioneRilieviBO.getMisuraRilieviFromId(Integer.parseInt(id_proprio), session);
							mag_item = GestioneMagazzinoBO.getItemById(Integer.parseInt(id), session);							
							
							if(allegato_rilievo.size()>0 && allegato_rilievo.containsKey(id)) {
								
								String filename = saveFile(allegato_rilievo.get(id), id, filename_allegato_rilievo.get(id));
								DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
								//note_rilievo = "N. pezzi mod. da "+mag_item.getPezzi_ingresso()+" a " +pezzi_ingresso+" in data "+df.format(new Date())+" da "+utente.getNominativo();
								MagAllegatoItemDTO allegato = new MagAllegatoItemDTO();
								allegato.setData(new Date());
								allegato.setNome_file(filename);
								allegato.setUtente(utente);
								allegato.setId_item(Integer.parseInt(id));
								session.save(allegato);
							}
							
							
						}else {
							
							rilievo = new RilMisuraRilievoDTO();
							mag_item = 	new MagItemDTO();
							rilievo.setStato_rilievo(new RilStatoRilievoDTO(1, ""));
						}
					rilievo.setDisegno(disegno);
					rilievo.setVariante(variante);
					rilievo.setCifre_decimali(3);
					
					if(pezzi_ingresso!= null && !pezzi_ingresso.equals("")) {
						rilievo.setPezzi_ingresso(Integer.parseInt(pezzi_ingresso));	
					}
					
					
					rilievo.setId_cliente_util(Integer.parseInt(cliente_util));
					//rilievo.setNome_cliente_util(util.getNome());
					rilievo.setId_sede_util(Integer.parseInt(sede_util.split("_")[0]));
					rilievo.setData_inizio_rilievo(new Date());
					rilievo.setCommessa(commessa);
					rilievo.setClasse_tolleranza("m");
					
					//if(id_pacco==null || id_pacco.equals("")) {
						rilievo.setIntervento(ril_intervento);	
					//}
					
					
					if(id!=null) {
						session.update(rilievo);
					}else {
						session.save(rilievo);
					}

					
					
					
					mag_item.setId_tipo_proprio(rilievo.getId());							
					
					mag_item.setTipo_item(new MagTipoItemDTO(4, ""));
					mag_item.setDescrizione(disegno+" "+variante);
					mag_item.setDisegno(disegno);
					mag_item.setVariante(variante);
					if(pezzi_ingresso!= null && !pezzi_ingresso.equals("")) {
						mag_item.setPezzi_ingresso(Integer.parseInt(pezzi_ingresso));
					}
					
					
					map.put(mag_item, "0_"+note_rilievo);
					
					if(id!=null) {
						
						session.update(mag_item);
					}else {
						
						GestioneMagazzinoBO.saveItem(mag_item, session);
					}
				}
					
				}
			
			
			
			
			
			DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
			new SimpleDateFormat("HH:mm");
	

			if(!data_trasporto.equals("")) {
				
				ddt.setData_trasporto(format.parse(data_trasporto));
			}
			
			if(!data_ddt.equals("")) {
				ddt.setData_ddt(format.parse(data_ddt));
			}
			
			
			ddt.setNumero_ddt(numero_ddt);
			ddt.setAnnotazioni(annotazioni);
			ddt.setAspetto(new MagAspettoDTO(Integer.parseInt(aspetto),""));
			if(!causale.equals("")) {
				ddt.setCausale(new MagCausaleDTO(Integer.parseInt(causale),""));
			}
			ddt.setCortese_attenzione(cortese_attenzione);
			ddt.setNote(note);
			
			if(stato_lavorazione.equals("1")) {
				
				if(!destinatario.equals("")) {
					ddt.setId_destinatario(Integer.parseInt(destinatario.split("_")[0]));
					ddt.setId_destinazione(Integer.parseInt(destinatario.split("_")[0]));
				}else {
					//ddt.setId_destinatario(Integer.parseInt("0"));
					ddt.setId_destinatario(Integer.parseInt(cliente));
					ddt.setId_destinazione(Integer.parseInt(cliente));
				}
				if(!sede_destinatario.equals("")) {
					String[] dest = sede_destinatario.split("_");
					ddt.setId_sede_destinazione(Integer.parseInt(dest[0]));
					ddt.setId_sede_destinatario(Integer.parseInt(dest[0]));
				}else {
					//ddt.setId_sede_destinatario(Integer.parseInt("0"));
					ddt.setId_sede_destinatario(Integer.parseInt(sede.split("_")[0]));
					ddt.setId_sede_destinazione(Integer.parseInt(sede.split("_")[0]));
				}				
			}else {
				if(!destinatario.equals("")) {
					ddt.setId_destinatario(Integer.parseInt(destinatario.split("_")[0]));
				}else {
					ddt.setId_destinatario(Integer.parseInt("0"));
					
				}
				if(!sede_destinatario.equals("")) {
					String[] dest = sede_destinatario.split("_");
					ddt.setId_sede_destinatario(Integer.parseInt(dest[0]));
				}else {
					ddt.setId_sede_destinatario(Integer.parseInt("0"));
					
				}
				
				if(!destinazione.equals("")) {
					ddt.setId_destinazione(Integer.parseInt(destinazione.split("_")[0]));	
				}else {
					ddt.setId_destinazione(Integer.parseInt("0"));
				}
				if(!sede_destinazione.equals("")) {
					String [] dest2 = sede_destinazione.split("_");
					ddt.setId_sede_destinazione(Integer.parseInt(dest2[0]));
				}else {
					ddt.setId_sede_destinazione(Integer.parseInt("0"));
				}
			}
			
			
			
			if(peso!=null && !peso.equals("")) {
				ddt.setPeso(Double.parseDouble(peso.replace(",", ".")));
			}
			ddt.setTipo_ddt(new MagTipoDdtDTO(Integer.parseInt(tipo_ddt), ""));
			ddt.setTipo_porto(new MagTipoPortoDTO(Integer.parseInt(tipo_porto), ""));
			ddt.setTipo_trasporto(new MagTipoTrasportoDTO(Integer.parseInt(tipo_trasporto),""));
			ddt.setSpedizioniere(spedizioniere);
			ddt.setAccount(account);
			ddt.setOperatore_trasporto(operatore_trasporto);
			ddt.setMagazzino(magazzino);
			if(colli!=null && !colli.equals("")) {
				ddt.setColli(Integer.parseInt(colli));
			}else {
				ddt.setColli(0);
			}
			
			pacco.setDdt(ddt);
			
			if(configurazione.equals("1")) {
				MagSaveStatoDTO save_stato = new MagSaveStatoDTO();
				
				save_stato.setId_cliente(Integer.parseInt(cliente));
				save_stato.setId_sede(Integer.parseInt(sede.split("_")[0]));
				save_stato.setCa(cortese_attenzione);
				save_stato.setTipo_porto(Integer.parseInt(tipo_porto));
				save_stato.setAspetto(Integer.parseInt(aspetto));
				save_stato.setSpedizioniere(spedizioniere);
				save_stato.setAccount(account);
				session.saveOrUpdate(save_stato);
			}
			
			
			
			pacco.setCompany(company);
			pacco.setUtente(utente);	
			pacco.setCodice_pacco(codice_pacco);
			
			if(testa_pacco!=null) {
				pacco.setLink_testa_pacco(testa_pacco);
			}
			
			if(commessa==null || commessa.equals("")) {
				pacco.setTipo_nota_pacco(new MagTipoNotaPaccoDTO(7,""));
			}else {
				if(select_nota_pacco!=null && !select_nota_pacco.equals("")) {
					pacco.setTipo_nota_pacco(new MagTipoNotaPaccoDTO(Integer.parseInt(select_nota_pacco),""));
				}
			}
			
			if(id_pacco == null || id_pacco.equals("")) {
				pacco.setData_lavorazione(new Date());	
			}else {
				if(!data_lavorazione.equals("")&& data_lavorazione!=null) {
					pacco.setData_lavorazione(format.parse(data_lavorazione));
				}
			}
			
				
			pacco.setStato_lavorazione(new MagStatoLavorazioneDTO(Integer.parseInt(stato_lavorazione), ""));
			
			if(!data_arrivo.equals("")&& data_arrivo!=null) {
				pacco.setData_arrivo(format.parse(data_arrivo));
			}
			if(!data_spedizione.equals("")&& data_spedizione!=null) {
				pacco.setData_spedizione(format.parse(data_spedizione));
			}
			if(commessa!=null && !commessa.equals("")) {
				if(pacco.getTipo_nota_pacco()!=null && pacco.getTipo_nota_pacco().getId()==7) {
					pacco.setTipo_nota_pacco(null);
				}
			}
			pacco.setCommessa(commessa);			
		
			pacco.setNote_pacco(note_pacco);
			
			if(fornitore!=null && !fornitore.equals("")) {
				pacco.setFornitore(fornitore.split("_")[1]);
			}
			if(fornitore_modal!=null && !fornitore_modal.equals("")) {
				pacco.setFornitore(fornitore_modal);
			}
			
				ddt.setLink_pdf(link_pdf);
			
			if(!id_ddt.equals("")) {
				ddt.setId(Integer.parseInt(id_ddt));
				if(link_pdf.equals("")) {
					ddt.setLink_pdf(link_pdf_old);
				}
			GestioneMagazzinoBO.updateDdt(ddt, session);
			
			}else {
			
			
				GestioneMagazzinoBO.saveDdt(ddt, session);
			}
			
			if(!id_pacco.equals("")) {
				pacco.setId(Integer.parseInt(id_pacco));
				if(!ritardo.equals("")) {
					pacco.setRitardo(Integer.parseInt(ritardo));
					pacco.setSegnalato(Integer.parseInt(ritardo));
				}
				GestioneMagazzinoBO.updatePacco(pacco, session);
				GestioneMagazzinoBO.deleteItemPacco(Integer.parseInt(id_pacco), session);
				
			}else {
				GestioneMagazzinoBO.savePacco(pacco, session);
				
			}
			
			if((id_pacco==null || id_pacco.equals("")) && ril_intervento!=null) {
				ril_intervento.setId_pacco(pacco.getId());
				session.update(ril_intervento);
			}
			
			
			String codice = "PC_"+pacco.getId();
			
			if(pacco.getStato_lavorazione().getId()==1) {			
				pacco.setOrigine(codice);
			}else {
				if(!origine.equals("")) {
					pacco.setOrigine(origine);	
				}	else {
					pacco.setOrigine(codice);
				}
			}

			pacco.setCodice_pacco(codice);
			GestioneMagazzinoBO.updatePacco(pacco, session);
			ArrayList <MagItemPaccoDTO> listaItemPacco = (ArrayList<MagItemPaccoDTO>)request.getSession().getAttribute("lista_item_pacco");
			for(Map.Entry<MagItemDTO, String> entry: map.entrySet()) {
				MagItemPaccoDTO item_pacco = new MagItemPaccoDTO();
				
				item_pacco.setItem(entry.getKey());
				item_pacco.setPacco(pacco);
				String [] str = entry.getValue().split("_");
				
				if(str.length>0) {
					if(str[0]!=null && !str[0].equals("")) {
					
					if(rilievi) 
						{
							item_pacco.setQuantita(entry.getKey().getPezzi_ingresso());
						}
						else 
						{
							item_pacco.setQuantita(Integer.parseInt(str[0]));
						}
						
						}
					if(str.length>1) {
						if(allegato_rilievo.size()>0 && item_pacco.getNote()!=null && !item_pacco.getNote().equals("")) {
							item_pacco.setNote(item_pacco.getNote()+" - "+str[1]);
						}else {
							item_pacco.setNote(str[1]);
						}
					
					}	
				}

				if(listaItemPacco!=null) {
				for(int i = 0; i<listaItemPacco.size();i++) {
				
					if(item_pacco.getItem().getId_tipo_proprio()==listaItemPacco.get(i).getItem().getId_tipo_proprio() && item_pacco.getPacco().getId() == listaItemPacco.get(i).getPacco().getId()) {
						item_pacco.setAccettato(listaItemPacco.get(i).getAccettato());
						item_pacco.setNote_accettazione(listaItemPacco.get(i).getNote_accettazione());
					}
				}
				
				}
				GestioneMagazzinoBO.saveItemPacco(item_pacco, session);
			}
			if(pdf!=null) {
				GestioneMagazzinoBO.uploadPdf(pdf, pacco.getId(), pdf.getName());
			}
			
			
						

			
			session.getTransaction().commit();
			
			
			//ArrayList<MagPaccoDTO> lista_pacchi = GestioneMagazzinoBO.getListaPacchi(company.getId(), session);
			
			if(id_pacco==null || id_pacco.equals("")) {
				lista_pacchi.add(pacco);
			}
			ArrayList<MagItemPaccoDTO> item_pacco = GestioneMagazzinoBO.getListaItemPacco(pacco.getId(), session);
			ArrayList<MagSaveStatoDTO> lista_save_stato = GestioneMagazzinoBO.getListaMagSaveStato(session);
			request.getSession().setAttribute("lista_pacchi",lista_pacchi);
			request.getSession().setAttribute("lista_item_pacco", item_pacco);
			request.getSession().setAttribute("pacco", pacco);
			String lista_save_stato_json = new Gson().toJson(lista_save_stato);
			request.getSession().setAttribute("lista_save_stato_json", lista_save_stato_json);
			session.close();
	   		 getServletContext().getRequestDispatcher("/site/listapacchi.jsp");
	   		response.sendRedirect(request.getHeader("referer"));
	   	     //dispatcher.forward(request,response);	
			
	}
		
		
		
		else if(action.equals("dettaglio")) {
			
			String id_pacco = request.getParameter("id_pacco");
		
				
				id_pacco = Utility.decryptData(id_pacco);
				
				MagPaccoDTO pacco = GestioneMagazzinoBO.getPaccoById(Integer.parseInt(id_pacco), session);
				
				ArrayList<MagItemPaccoDTO> item_pacco = new ArrayList<MagItemPaccoDTO>();
				
				CommessaDTO commessa = null;
				if(pacco.getCommessa()!=null) {
					 commessa = GestioneCommesseBO.getCommessaById(pacco.getCommessa());					 
				}				
				
				item_pacco = GestioneMagazzinoBO.getListaItemPacco(pacco.getId(), session);
				
				ArrayList<MagAllegatoDTO> allegati = GestioneMagazzinoBO.getAllegatiFromPacco(id_pacco, session);
				
				session.close();
				
				Gson g = new Gson();
				JsonElement json = g.toJsonTree(item_pacco);
				
				request.getSession().setAttribute("allegati", allegati);
				request.getSession().setAttribute("lista_item_pacco", item_pacco);
				request.getSession().setAttribute("item_pacco_json", json);
				request.getSession().setAttribute("pacco", pacco);
				request.getSession().setAttribute("commessa", commessa);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioPacco.jsp");
		     	dispatcher.forward(request,response);
				
		}
		
	
		else if(action.equals("cambia_nota_pacco")) {
			
			ajax = true;
			
			String id_pacco = request.getParameter("id_pacco");
			String nota = request.getParameter("nota");
			
			JsonObject myObj = new JsonObject();
			PrintWriter  out = response.getWriter();

				MagPaccoDTO pacco = GestioneMagazzinoBO.getPaccoById(Integer.parseInt(id_pacco), session);
				MagTipoNotaPaccoDTO tipo_nota = null;
				if(!nota.equals("0")) {
				tipo_nota = new MagTipoNotaPaccoDTO(Integer.parseInt(nota), "");
				}
				pacco.setTipo_nota_pacco(tipo_nota);
				
				
				GestioneMagazzinoBO.updatePacco(pacco, session);
				
				session.getTransaction().commit();
				session.close();
				

				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Nota cambiata con successo!");
				
				out.print(myObj);
		
		}
		
		
		else if(action.equals("cambia_stato_pacco")) {
			
			String id_pacco = request.getParameter("id_pacco");			
			String codice = request.getParameter("codice");
			String fornitore = request.getParameter("fornitore");
			String stato_pacco = request.getParameter("stato");
			request.getParameter("ddt");
			String strumenti_json = request.getParameter("strumenti_json");
			String sede_fornitore = request.getParameter("sede_fornitore");
			String pezzi_json = request.getParameter("pezzi_json");
			
			ArrayList<MagPaccoDTO> lista_pacchi = (ArrayList<MagPaccoDTO>) request.getSession().getAttribute("lista_pacchi");
		
				
				MagPaccoDTO pacco = GestioneMagazzinoBO.getPaccoById(Integer.parseInt(id_pacco), session);
				MagStatoLavorazioneDTO stato = new MagStatoLavorazioneDTO(Integer.parseInt(stato_pacco), "");
				
				if(stato_pacco.equals("3")||stato_pacco.equals("4")) {
					pacco.setStato_lavorazione(stato);
					if(fornitore!=null && !fornitore.equals("")) {
						pacco.setFornitore(fornitore.split("_")[1]);
						pacco.getDdt().setId_destinazione(Integer.parseInt(fornitore.split("_")[0]));
						pacco.getDdt().setId_destinatario(Integer.parseInt(fornitore.split("_")[0]));
					}
					if(sede_fornitore!=null && !sede_fornitore.equals("")) {					
						pacco.getDdt().setId_sede_destinazione(Integer.parseInt(sede_fornitore.split("_")[0]));
						pacco.getDdt().setId_sede_destinatario(Integer.parseInt(sede_fornitore.split("_")[0]));
					}
					
					int id_ddt = GestioneMagazzinoBO.getProgressivoDDT(session);
					pacco.getDdt().setNumero_ddt("STI_"+(id_ddt+1));
					pacco.getDdt().setTipo_ddt(new MagTipoDdtDTO(2,""));
					pacco.getDdt().setData_ddt(new Date());
					pacco.setData_spedizione(new Date());							

					if(stato_pacco.equals("4")) {
						//ArrayList<Integer>lista_strumenti = new Gson().fromJson(strumenti_json, new TypeToken<List<Integer>>(){}.getType());
						ArrayList<MagItemPaccoDTO> lista_item_pacco= GestioneMagazzinoBO.getListaItemPacco(Integer.parseInt(id_pacco), session);
						ArrayList<Integer> lista_strumenti = new ArrayList<Integer>();
						String [] lista_id_strumenti = strumenti_json.split(";");
						for(int i = 0; i<lista_id_strumenti.length; i++) {
							lista_strumenti.add(Integer.parseInt(lista_id_strumenti[i]));
						}
						for(int i= 0;i<lista_item_pacco.size();i++) {
							boolean found = false;
							for(int j=0;j<lista_strumenti.size();j++) {								
								if(lista_item_pacco.get(i).getItem().getId_tipo_proprio()==lista_strumenti.get(j)) {
									found=true;
								}
							}
							if(found==false) {
								session.delete(lista_item_pacco.get(i));
							}
						}
						
						pacco.setTipo_nota_pacco(new MagTipoNotaPaccoDTO(14, ""));;
						
						MagSaveStatoDTO save_stato = GestioneMagazzinoBO.getMagSaveStato(Integer.parseInt(fornitore.split("_")[0]),Integer.parseInt(sede_fornitore.split("_")[0]), session);
						if(save_stato!=null) {
							pacco.getDdt().setSpedizioniere(save_stato.getSpedizioniere());
							pacco.getDdt().setAccount(save_stato.getAccount());
							pacco.getDdt().setTipo_trasporto(new MagTipoTrasportoDTO(1, ""));
							pacco.getDdt().setAspetto(new MagAspettoDTO(save_stato.getAspetto(), ""));
							pacco.getDdt().setTipo_porto(new MagTipoPortoDTO(save_stato.getTipo_porto(), ""));
							pacco.getDdt().setCortese_attenzione(save_stato.getCa());
						}

					}
					if(stato_pacco.equals("3")) {
						
						MagSaveStatoDTO save_stato = GestioneMagazzinoBO.getMagSaveStato(pacco.getId_cliente(), pacco.getId_sede(), session);
						if(save_stato!=null) {
							pacco.getDdt().setSpedizioniere(save_stato.getSpedizioniere());
							pacco.getDdt().setAccount(save_stato.getAccount());
							pacco.getDdt().setTipo_trasporto(new MagTipoTrasportoDTO(1, ""));
							pacco.getDdt().setAspetto(new MagAspettoDTO(save_stato.getAspetto(), ""));
							pacco.getDdt().setTipo_porto(new MagTipoPortoDTO(save_stato.getTipo_porto(), ""));
							pacco.getDdt().setCortese_attenzione(save_stato.getCa());
							
						}
						Object[] riferimento = GestioneMagazzinoBO.getRiferimentoDDT(pacco.getOrigine(), session);
						String ann = null;
						if(riferimento!=null) {															
							if(!riferimento[0].equals("INTERNO") && !riferimento[0].equals("interno") && !riferimento[0].equals("")) {
								ann ="RIF. DDT "+ (String) riferimento[0];
								if(riferimento[1]!=null) {
									DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");										 
							        String strDate = dateFormat.format(riferimento[1]);										
									ann = ann + " del "+ strDate;
								}
								ann = ann +". ";
							}							
						}
						if(pacco.getCommessa()!=null && !pacco.getCommessa().equals("")) {
							CommessaDTO commessa = GestioneCommesseBO.getCommessaById(pacco.getCommessa());
							if(commessa!=null && commessa.getN_ORDINE()!=null && !commessa.getN_ORDINE().equals("")) {
								if(ann!=null) {
									ann = ann + "\n";
								}else {
									ann="";
								}
								ann = ann + "RIF. ORDINE "+commessa.getN_ORDINE();
							}
						}
						pacco.getDdt().setAnnotazioni(ann);	
					}
					
					GestioneMagazzinoBO.updateDdt(pacco.getDdt(), session);
					GestioneMagazzinoBO.updatePacco(pacco, session);
					
				}
				else {
					MagPaccoDTO newPacco = new MagPaccoDTO();
					
					newPacco.setStato_lavorazione(stato);
					newPacco.setData_lavorazione(new Date());
					if(fornitore!=null && fornitore!="") {
						newPacco.setFornitore(fornitore);
					}else {
						if(pacco.getFornitore()!=null && !stato_pacco.equals("3")) {
							newPacco.setFornitore(pacco.getFornitore());
						}else {
							newPacco.setFornitore(null);
						}
					}
					newPacco.setCodice_pacco(codice);
					newPacco.setCliente(pacco.getCliente());
					newPacco.setCommessa(pacco.getCommessa());
					newPacco.setCompany(pacco.getCompany());
					newPacco.setId_cliente(pacco.getId_cliente());
					newPacco.setId_sede(pacco.getId_sede());
					newPacco.setNome_cliente(pacco.getNome_cliente());
					newPacco.setNome_sede(pacco.getNome_sede());
					newPacco.setNome_cliente_util(pacco.getNome_cliente_util());
					newPacco.setNome_sede_util(pacco.getNome_sede_util());
					newPacco.setId_cliente_util(pacco.getId_cliente_util());
					newPacco.setId_sede_util(pacco.getId_sede_util());
					
					//newPacco.setTipo_nota_pacco(pacco.getTipo_nota_pacco());
					MagDdtDTO ddt = new MagDdtDTO();
					if(stato_pacco.equals("2")) {
						ddt.setTipo_ddt(new MagTipoDdtDTO(2, ""));
						ddt.setId_destinatario(pacco.getId_cliente());
						ddt.setId_sede_destinatario(pacco.getId_sede());
						ddt.setId_destinazione(pacco.getDdt().getId_destinazione());
						ddt.setId_sede_destinazione(pacco.getDdt().getId_sede_destinazione());
						

					}
					
					newPacco.setUtente(utente);
					if(stato_pacco.equals("2")){
						newPacco.setOrigine(pacco.getCodice_pacco());
					}else {
						newPacco.setOrigine(pacco.getOrigine());
					}
					if(stato_pacco.equals("5")) {
						newPacco.setData_arrivo(new Date());
						ddt.setTipo_ddt(new MagTipoDdtDTO(1, ""));
						ddt.setId_destinatario(pacco.getDdt().getId_destinazione());
						ddt.setId_sede_destinatario(pacco.getDdt().getId_sede_destinazione());
					}
					if(stato_pacco.equals("3")||stato_pacco.equals("4") ) {
						newPacco.setData_spedizione(new Date());
					}

					newPacco.setDdt(ddt);		
					GestioneMagazzinoBO.saveDdt(newPacco.getDdt(), session);
					GestioneMagazzinoBO.savePacco(newPacco, session);
					
					if(stato_pacco.equals("2")) {
						
						ArrayList<Integer> lista_strumenti = new ArrayList<Integer>();
						ArrayList<Integer> lista_pezzi = new ArrayList<Integer>();
						String [] lista_id_strumenti = strumenti_json.split(";");
						if(pezzi_json!=null && !pezzi_json.equals("")) {
							String [] lista_pezzi_uscita = pezzi_json.split(";");
							for(int i = 0; i<lista_pezzi_uscita.length; i++) {
								lista_pezzi.add(Integer.parseInt(lista_pezzi_uscita[i]));
								
							}
						}
						for(int i = 0; i<lista_id_strumenti.length; i++) {
							lista_strumenti.add(Integer.parseInt(lista_id_strumenti[i]));
							
						}
						ArrayList<MagItemPaccoDTO> lista_item_pacco= GestioneMagazzinoBO.getListaItemPacco(Integer.parseInt(id_pacco), session);
						
						for(int i= 0;i<lista_item_pacco.size();i++) {

							MagItemPaccoDTO item_pacco = new MagItemPaccoDTO();
							for(int j=0;j<lista_strumenti.size();j++) {								
								if(lista_item_pacco.get(i).getItem().getId_tipo_proprio()==lista_strumenti.get(j)) {
									if(lista_pezzi.size()>0) {
										MagItemDTO item = new MagItemDTO();
										item.setVariante(lista_item_pacco.get(i).getItem().getVariante());
										item.setDisegno(lista_item_pacco.get(i).getItem().getDisegno());
										item.setId_tipo_proprio(lista_item_pacco.get(i).getItem().getId_tipo_proprio());
										item.setPezzi_ingresso(lista_pezzi.get(j));				
										item.setTipo_item(lista_item_pacco.get(i).getItem().getTipo_item());
										item.setDescrizione(lista_item_pacco.get(i).getItem().getDescrizione());
										item_pacco.setItem(item);
										item_pacco.setQuantita(lista_pezzi.get(j));
										session.save(item);
									}else {
										item_pacco.setItem(lista_item_pacco.get(i).getItem());
										item_pacco.setQuantita(lista_item_pacco.get(i).getQuantita());
									}
									
									
									item_pacco.setPacco(newPacco);
									
									item_pacco.setNote(lista_item_pacco.get(i).getNote());
									GestioneMagazzinoBO.saveItemPacco(item_pacco, session);
								}
							}							
						}

					}else {
					
					ArrayList<MagItemPaccoDTO> lista_item_pacco= GestioneMagazzinoBO.getListaItemPacco(Integer.parseInt(id_pacco), session);
					for(int i=0; i<lista_item_pacco.size();i++) {
						
						MagItemPaccoDTO item_pacco = new MagItemPaccoDTO();
						item_pacco.setItem(lista_item_pacco.get(i).getItem());
						item_pacco.setPacco(newPacco);
						item_pacco.setQuantita(lista_item_pacco.get(i).getQuantita());
						item_pacco.setNote(lista_item_pacco.get(i).getNote());
						if(stato_pacco.equals("5")&&item_pacco.getItem().getTipo_item().getId()==1) {
							item_pacco.getItem().setStato(new MagStatoItemDTO(2, ""));
						}
						
						GestioneMagazzinoBO.saveItemPacco(item_pacco, session);
						
					}
					}
					
					lista_pacchi.add(newPacco);
				}
				session.getTransaction().commit();
				
				/*rivedere*/
				//ArrayList<MagPaccoDTO> lista_pacchi = GestioneMagazzinoBO.getListaPacchiApertiChiusi(utente.getCompany().getId(),0, session);
				session.close();
				request.getSession().setAttribute("lista_pacchi",lista_pacchi);
				
				response.sendRedirect(request.getHeader("referer"));

		}
		
	

		else if(action.equals("chiudi_origine")) {
			ajax = true;
			
			String origine = request.getParameter("origine");
			JsonObject myObj = new JsonObject();
			PrintWriter  out = response.getWriter();
		

				if(origine!=null && !origine.equals("")) {
				GestioneMagazzinoBO.chiudiPacchiCommessa(origine, session);
				session.getTransaction().commit();
				session.close();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Pacchi chiusi con successo!");
			
				out.print(myObj);
				}

		}
		
		else if (action.equals("accettazione")) {
			
			ajax = true;
			JsonObject myObj = new JsonObject();
			PrintWriter  out = response.getWriter();
			String id_pacco = request.getParameter("id_pacco");
			String accettati = request.getParameter("accettati");
			String non_accettati = request.getParameter("non_accettati");
			String note_acc = request.getParameter("note_acc");
			String note_non_acc = request.getParameter("note_non_acc");

		//	try {
			JsonElement jelement_acc = new JsonParser().parse(accettati);
			JsonElement jelement_non_acc = new JsonParser().parse(non_accettati);
			JsonElement jelement_note_acc = new JsonParser().parse(note_acc);
			JsonElement jelement_note_non_acc = new JsonParser().parse(note_non_acc);
			JsonArray json_array_acc = jelement_acc.getAsJsonArray();
			JsonArray json_array_non_acc = jelement_non_acc.getAsJsonArray();
			JsonArray json_array_note_acc = jelement_note_acc.getAsJsonArray();
			JsonArray json_array_note_non_acc = jelement_note_non_acc.getAsJsonArray();
			GestioneMagazzinoBO.accettaItem(json_array_acc,json_array_non_acc, json_array_note_acc,json_array_note_non_acc, id_pacco, session);
			
			session.getTransaction().commit();
			session.close();
			
			myObj.addProperty("success", true);
			myObj.addProperty("messaggio", "Accettazione effettuata con successo!");
			out.print(myObj);
			
		}
		
			

		else if (action.equals("testa_pacco")) {
			
			ajax = true;
			String id_pacco = request.getParameter("id_pacco");
			JsonObject myObj = new JsonObject();
			PrintWriter  out = response.getWriter();

				MagPaccoDTO pacco = GestioneMagazzinoBO.getPaccoById(Integer.parseInt(id_pacco), session);
				
				List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				List<MagItemPaccoDTO> lista_item_pacco = GestioneMagazzinoBO.getListaItemPacco(Integer.parseInt(id_pacco), session);
				
				new CreateTestaPacco(pacco, lista_item_pacco, listaSedi, session);

				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Testa pacco creato con successo!");
				
				session.getTransaction().commit();
				session.close();
				out.print(myObj);

	}
		else if(action.equals("dettaglio_commessa")) {
			
			String id_commessa = request.getParameter("id_commessa");
			
	
				CommessaDTO comm=GestioneCommesseBO.getCommessaById(id_commessa);
				
				ArrayList<AttivitaMilestoneDTO> lista_attivita = comm.getListaAttivita();
				
				request.getSession().setAttribute("lista_attivita",lista_attivita);
				request.getSession().setAttribute("id_commessa", id_commessa);
				request.getSession().setAttribute("note_commessa", comm.getNOTE_GEN());

				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioCommessaPacchi.jsp");
		     	dispatcher.forward(request,response);
				
		}
		
		else if(action.equals("download_testa_pacco")) {
			
		
				String filename= request.getParameter("filename");
				filename = Utility.decryptData(filename);
				String path = Costanti.PATH_FOLDER+"//"+"Magazzino" + "//"+ "testa_pacco//"+ filename +".pdf";
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
		
		
		else if(action.equals("upload_allegati")) {
			
			ajax = true;
			JsonObject myObj = new JsonObject();
			PrintWriter  out = response.getWriter();
			ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
			PrintWriter writer = response.getWriter();
			response.setContentType("application/json");
			
			String id_pacco = request.getParameter("id_pacco");
			boolean esito=false;
			
				List<FileItem> items;
			
					items = uploadHandler.parseRequest(request);
					MagPaccoDTO pacco=GestioneMagazzinoBO.getPaccoById(Integer.parseInt(id_pacco), session);
				for (FileItem item : items) {
					if (!item.isFormField()) {
						
						String filename = GestioneMagazzinoBO.uploadImage(item, pacco.getCodice_pacco());

						MagAllegatoDTO allegato = new MagAllegatoDTO();
						allegato.setPacco(pacco);
						allegato.setAllegato(filename);
						
						GestioneMagazzinoBO.saveAllegato(allegato, session);
						pacco.setHasAllegato(1);
						session.update(pacco);
						session.getTransaction().commit();
						esito = true;

					}

				}

				if(esito==true) {
					myObj.addProperty("success", true);
					
				}else {
					myObj.addProperty("success", false);
					
				}
				ArrayList<MagAllegatoDTO> allegati = GestioneMagazzinoBO.getAllegatiFromPacco(id_pacco, session);
				session.close();
				
				request.getSession().setAttribute("allegati", allegati);
				
				out.print(myObj);
				

		}
		
		else if(action.equals("download_allegato")) {
			
		
				String filename= request.getParameter("allegato");
				String codice_pacco = request.getParameter("codice_pacco");
				String path = Costanti.PATH_FOLDER+"//"+"Magazzino" + "//"+ "Allegati//"+ codice_pacco+ "//"+filename;
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
				    
				    
				    fileIn.close();
				    outp.flush();
				    outp.close();
				    session.close();
			
		}
		
		else if(action.equals("elimina_allegato")) {
			
			ajax = true;
			JsonObject myObj = new JsonObject();
			PrintWriter  out = response.getWriter();
		
			String id_allegato = request.getParameter("id_allegato");
			String id_pacco = request.getParameter("id_pacco");
			
			GestioneMagazzinoBO.eliminaAllegato(Integer.parseInt(id_allegato), session);
		
			
			ArrayList<MagAllegatoDTO> lista_allegati = GestioneMagazzinoBO.getAllegatiFromPacco(id_pacco, session);
			if(lista_allegati.size()==0) {
				MagPaccoDTO pacco = GestioneMagazzinoBO.getPaccoById(Integer.parseInt(id_pacco), session);
				pacco.setHasAllegato(0);
				session.update(pacco);
			}
			
			request.getSession().setAttribute("lista_allegati", lista_allegati);
			session.getTransaction().commit();
			session.close();
			
			String jsonObj = new Gson().toJson(lista_allegati);
		
			myObj.addProperty("json", jsonObj);
			myObj.addProperty("success", true);
			myObj.addProperty("messaggio", "Allegato eliminato con successo!");
			out.print(myObj);
		}
		
		else if(action.equals("note_commessa")) {
		
			ajax = true;
			String id_commessa = request.getParameter("id");
			JsonObject myObj = new JsonObject();
			response.setCharacterEncoding("utf-8");
			PrintWriter  out = response.getWriter();

				
				CommessaDTO commessa = GestioneCommesseBO.getCommessaById(id_commessa);
				
				session.getTransaction().commit();
				session.close();
				
			//	String jsonObj = new Gson().toJson(commessa);
			
				myObj.addProperty("json", commessa.getNOTE_GEN());
				myObj.addProperty("success", true);
				
				out.print(myObj);
				
		}
		
		
		else if(action.equals("cambio_stato_strumento")) {

			ajax = true;
			JsonObject myObj = new JsonObject();
			PrintWriter  out = response.getWriter();
			String id_strumento = request.getParameter("id");
			String stato_attuale = request.getParameter("stato_attuale");
			int new_stato=1;
		
				if(stato_attuale.equals("1")) {
					new_stato=2;
				}
				GestioneMagazzinoBO.cambiaStatoStrumento(Integer.parseInt(id_strumento),new_stato, session);
				
				session.getTransaction().commit();
				
				session.close();
				
				myObj.addProperty("messaggio", "Stato cambiato con successo!");
				myObj.addProperty("success", true);
				
				out.print(myObj);
				
		}
		
		else if(action.equals("item_uscita")) {
			
			String id_pacco = request.getParameter("id_pacco");
			
			ArrayList<MagItemPaccoDTO> item_pacco_fornitore = GestioneMagazzinoBO.getListaItemPacco(Integer.parseInt(id_pacco), session);
			ArrayList<MagItemDTO> item_spediti = GestioneMagazzinoBO.getListaItemSpediti(Integer.parseInt(id_pacco), session);
			
			if(item_pacco_fornitore.size()>0 && item_pacco_fornitore.get(0).getItem().getTipo_item().getId()==4) {
				
				for (MagItemPaccoDTO item_pacco : item_pacco_fornitore) {
					int somma = 0;
					ArrayList<MagItemDTO> lista_rilievi_iviati = GestioneMagazzinoBO.getListaRilieviSpediti(item_pacco.getPacco().getOrigine(), item_pacco.getItem().getId_tipo_proprio(), session);
					for (MagItemDTO magItemDTO : lista_rilievi_iviati) {
						somma =somma+ magItemDTO.getPezzi_ingresso();
					}
				item_pacco.setGia_spediti(somma);	
				}
			}
			
			
			session.close();
			
			request.getSession().setAttribute("item_pacco_fornitore", item_pacco_fornitore);
			
			String item_spediti_json = new Gson().toJson(item_spediti);
			request.getSession().setAttribute("item_spediti_json", item_spediti_json);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/itemUscita.jsp");
	     	dispatcher.forward(request,response);
		}
		
		else if(action.equals("importa_da_commessa")) {
			ajax = true;
			JsonObject myObj = new JsonObject();
			PrintWriter  out = response.getWriter();
			String id_commessa = request.getParameter("id_commessa");
			List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
		
			if(id_commessa == null || id_commessa.equals("")) {
				myObj.addProperty("success", false);
				myObj.addProperty("messaggio", "Attenzione! Nessuna commessa associata al pacco!");
			}else {
			
			CommessaDTO commessa = GestioneCommesseBO.getCommessaById(id_commessa);
			
				if(commessa!=null) {
				
					

				String id_destinatario = String.valueOf(commessa.getID_ANAGEN());
				String id_sede_destinatario = String.valueOf(commessa.getK2_ANAGEN_INDR());
				String id_destinazione = String.valueOf(commessa.getID_ANAGEN());
				String id_sede_destinazione = String.valueOf(commessa.getK2_ANAGEN_INDR());
				//String id_destinazione = String.valueOf(commessa.getID_ANAGEN_UTIL());
				//String id_sede_destinazione = String.valueOf(commessa.getK2_ANAGEN_INDR_UTIL());			
				String id_utilizzatore = String.valueOf(commessa.getID_ANAGEN_UTIL());
				String id_sede_utilizzatore = String.valueOf(commessa.getK2_ANAGEN_INDR_UTIL());	
				String nome_cliente = commessa.getNOME_UTILIZZATORE();
				String nome_sede_cliente = null;
				if(!id_sede_destinazione.equals("0")) {
				
					nome_sede_cliente = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(id_sede_destinazione), Integer.parseInt(id_destinazione)).getDescrizione();
				}
			
					myObj.addProperty("success", true);
					myObj.addProperty("id_destinatario", id_destinatario);
					myObj.addProperty("id_sede_destinatario", id_sede_destinatario);
					myObj.addProperty("id_destinazione", id_destinazione);
					myObj.addProperty("id_sede_destinazione", id_sede_destinazione);
					myObj.addProperty("id_utilizzatore", id_utilizzatore);
					myObj.addProperty("id_sede_utilizzatore", id_sede_utilizzatore);
					myObj.addProperty("nome_cliente", nome_cliente);
					myObj.addProperty("nome_sede_cliente", nome_sede_cliente);
					
					
				}else {
					myObj.addProperty("success", false);
					myObj.addProperty("messaggio", "Attenzione! Non esiste una commessa con questo ID!");
				}
			}	
			
			out.print(myObj);
			session.close();
		}
		
		
		else if(action.equals("modifica_item")) {
			ajax = true;
			JsonObject myObj = new JsonObject();
			PrintWriter  out = response.getWriter();
			String id_item = request.getParameter("id_item");
			String matricola = request.getParameter("matricola");
			String codice_interno = request.getParameter("codice_interno");
			String denominazione = request.getParameter("denominazione");
		
			MagItemDTO item = GestioneMagazzinoBO.getItemById(Integer.parseInt(id_item), session);
			item.setMatricola(matricola);
			item.setCodice_interno(codice_interno);
			item.setDescrizione(denominazione);
			session.update(item);			
			
				StrumentoDTO strumento = GestioneStrumentoBO.getStrumentoById(String.valueOf(item.getId_tipo_proprio()), session);
				strumento.setCodice_interno(codice_interno);
				strumento.setMatricola(matricola);
				strumento.setDenominazione(denominazione);
				GestioneMagazzinoBO.updateStrumento(strumento, session);
				session.getTransaction().commit();
				session.close();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Strumento modificato con successo!");
				out.print(myObj);
			
		}
		
		else if(action.equals("lista_allegati")) {
			
			String id_pacco = request.getParameter("id_pacco");
			
			ArrayList<MagAllegatoDTO> lista_allegati = GestioneMagazzinoBO.getAllegatiFromPacco(id_pacco, session);
			
			request.getSession().setAttribute("lista_allegati", lista_allegati);
			session.close();
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaFileAllegatiMagazzino.jsp");
	     	dispatcher.forward(request,response);
		}
		
		else if(action.equals("sposta_strumenti")) {
			
			ajax = true;
		
			String id_utilizzatore = request.getParameter("id_util");
			String id_sede_utilizzatore = request.getParameter("id_sede_util");
			String id_pacco = request.getParameter("id_pacco");
			
			ArrayList<MagItemDTO> lista_item = GestioneMagazzinoBO.getListaItemByPacco(Integer.parseInt(id_pacco), session);
			
			for (MagItemDTO item : lista_item) {
				if(item.getTipo_item().getId()==1) {
					StrumentoDTO strumento = GestioneStrumentoBO.getStrumentoById(String.valueOf(item.getId_tipo_proprio()), session);
					strumento.setId_cliente(Integer.parseInt(id_utilizzatore));
					strumento.setId__sede_(Integer.parseInt(id_sede_utilizzatore.split("_")[0]));
					session.update(strumento);
				}				
			}
			
			session.getTransaction().commit();
			session.close();
			JsonObject myObj = new JsonObject();
			PrintWriter out = response.getWriter();
			
			myObj.addProperty("success", true);
			myObj.addProperty("messaggio", "Strumenti spostati con successo!");
			out.print(myObj);
			
		}
		else if(action.equals("riapri_origine")) {
			ajax = true;
			
			String origine = request.getParameter("origine");
			
			GestioneMagazzinoBO.riapriOrigine(origine, session);
			
			
			session.getTransaction().commit();
			session.close();
			JsonObject myObj = new JsonObject();
			PrintWriter out = response.getWriter();
			
			myObj.addProperty("success", true);
			myObj.addProperty("messaggio", "Pacchi origine riaperti con successo!");
			out.print(myObj);
			
		}
	
		
		else if(action.equals("upload_allegato_rilievi")) {
			ajax = true;
			String id_item = request.getParameter("id_item_rilievo");
							
			ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
			PrintWriter out = response.getWriter();
			response.setContentType("application/json");						
				
				List<FileItem> items = uploadHandler.parseRequest(request);
				for (FileItem item : items) {
					if (!item.isFormField()) {							
															
						if(id_item!=null) {
						MagAllegatoItemDTO allegato = new MagAllegatoItemDTO();
						allegato.setData(new Date());
						allegato.setId_item(Integer.parseInt(id_item));
						
						allegato.setUtente(utente);
						
						String filename = saveFile(item,  id_item, item.getName());	
						allegato.setNome_file(filename);
						session.save(allegato);
						}														
					}
				}

				JsonObject myObj = new JsonObject();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Upload effettuato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			
		}
		
		else if(action.equals("update_dashboard")) {
			
			
			ajax = true;
			
			String origine = request.getParameter("origine");
			String stato = request.getParameter("stato");
			
			GestioneMagazzinoBO.updateOrigineDashboard(origine, Integer.parseInt(stato), utente.getNominativo());
			
			
			session.getTransaction().commit();
			session.close();
			JsonObject myObj = new JsonObject();
			PrintWriter out = response.getWriter();
			
			myObj.addProperty("success", true);
			
			out.print(myObj);
			
			
		}
		else if(action.equals("pacchi_lavorazione")) {
		
			ArrayList<String> lista_pacchi = DirectMySqlDAO.getItemInRitardoDashboard(session);
			
//			Collections.sort(lista_pacchi, new Comparator<String>() {
//			    @Override
//			    public int compare(String s1, String s2) {
//			        int giorniMancanti1 = estraiGiorniMancanti(s1);
//			        int giorniMancanti2 = estraiGiorniMancanti(s2);
//
//			        // Ordina in modo decrescente
//			        return Integer.compare(giorniMancanti2, giorniMancanti1);
//			    }
//			});
			Collections.sort(lista_pacchi, new Comparator<String>() {
			    @Override
			    public int compare(String s1, String s2) {
			        // Ottieni i giorni mancanti dai due elementi della lista
			        int giorniMancanti1 = 0;
			        int giorniMancanti2 = 0;

			       // String s1n1 = s1.split(";")[s1.split(";").length - 3].replaceAll("[^\\d-]", "").trim();
			        String s1n1 = s1.split(";")[s1.split(";").length - 5].replaceAll("[^\\d\\/-]", "").trim();
			        String s1n2 = s1.split(";")[s1.split(";").length - 4].replaceAll("[^\\d\\/-]", "").trim();
			        String s1n3 = s1.split(";")[s1.split(";").length - 3].replaceAll("[^\\d\\/-]", "").trim();
			        String s1n4 = s1.split(";")[s1.split(";").length - 2].replaceAll("[^\\d\\/-]", "").trim();
			        String s1n5 = s1.split(";")[s1.split(";").length - 1].replaceAll("[^\\d\\/-]", "").trim();
			        
			        if(s1n1.matches("-?[0-9]+")) {
			        	giorniMancanti1 = Integer.parseInt(s1n1);
			        }else if(s1n2.matches("-?[0-9]+")) {
			        	giorniMancanti1 = Integer.parseInt(s1n2);
			        }else if(s1n3.matches("-?[0-9]+")) {
			        	giorniMancanti1 = Integer.parseInt(s1n3);
			        }
			        else if(s1n4.matches("-?[0-9]+")) {
			        	giorniMancanti1 = Integer.parseInt(s1n4);
			        }
			        else if(s1n5.matches("-?[0-9]+")) {
			        	giorniMancanti1 = Integer.parseInt(s1n5);
			        }
			        
			        String s2n1 = s2.split(";")[s2.split(";").length - 5].replaceAll("[^\\d\\/-]", "").trim();
			        String s2n2 = s2.split(";")[s2.split(";").length - 4].replaceAll("[^\\d\\/-]", "").trim();
			        String s2n3 = s2.split(";")[s2.split(";").length - 3].replaceAll("[^\\d\\/-]", "").trim();
			        String s2n4 = s2.split(";")[s2.split(";").length - 2].replaceAll("[^\\d\\/-]", "").trim();
			        String s2n5 = s2.split(";")[s2.split(";").length - 1].replaceAll("[^\\d\\/-]", "").trim();
			        
			
			        if(s2n1.matches("-?[0-9]+")) {
			        	giorniMancanti2 = Integer.parseInt(s2n1);
			        }else if(s2n2.matches("-?[0-9]+")) {
			        	giorniMancanti2 = Integer.parseInt(s2n2);
			        }else if(s2n3.matches("-?[0-9]+")) {
			        	giorniMancanti2 = Integer.parseInt(s2n3);
			        }
			        else if(s2n4.matches("-?[0-9]+")) {
			        	giorniMancanti2 = Integer.parseInt(s2n4);
			        }
			        else if(s2n5.matches("-?[0-9]+")) {
			        	giorniMancanti2 = Integer.parseInt(s2n5);
			        }
			        
			     			        
			        // Ordina in modo decrescente
			        return Integer.compare(giorniMancanti2, giorniMancanti1);
			    }
			});
			
			
			request.getSession().setAttribute("lista_pacchi_grafico", lista_pacchi);
			session.getTransaction().commit();
			session.close();
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaPacchiInLavorazione.jsp");
	     	dispatcher.forward(request,response);
			
			
			
		}
		
		}catch(Exception e) {
			
			session.getTransaction().rollback();
        	session.close();
			if(ajax) {
				JsonObject myObj = new JsonObject();
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
	
	private String saveFile(FileItem item,String id_item, String filename) {

	 	String path_folder =Costanti.PATH_FOLDER+"\\Magazzino\\AllegatiItem\\"+id_item+"\\";
	 	
	 
		File folder=new File(path_folder);
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
	
		int index = 1;
		
		while(true)
		{
			File file=null;
			
			
			file = new File(path_folder+filename);			
			
			if(file.exists()) {
				filename = filename.replace(".pdf", "").replace(".PDF", "").replace("_"+(index-1), "")+"_"+index+".pdf";
				index++;
			}else {
				try {
					item.write(file);
					break;

				} catch (Exception e) 
				{

					e.printStackTrace();
					break;
				}
			}
			
				
		}
		return filename;
	}

    private int estraiGiorniMancanti(String s) {
        String[] parts = s.split(";");
        for (int i = parts.length - 5; i < parts.length; i++) {
            if (i >= 0 && parts[i].matches("-?\\d+")) {
                return Integer.parseInt(parts[i].trim());
            }
        }
        return Integer.MIN_VALUE; // Valore predefinito se non ci sono giorni mancanti validi
    }

}
