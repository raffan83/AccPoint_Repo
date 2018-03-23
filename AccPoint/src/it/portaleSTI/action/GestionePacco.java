package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Time;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hwpf.usermodel.DateAndTime;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.stream.JsonReader;


import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.MagAspettoDTO;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.DTO.MagItemDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.MagSpedizioniereDTO;
import it.portaleSTI.DTO.MagStatoItemDTO;
import it.portaleSTI.DTO.MagStatoLavorazioneDTO;
import it.portaleSTI.DTO.MagTipoDdtDTO;
import it.portaleSTI.DTO.MagTipoItemDTO;
import it.portaleSTI.DTO.MagTipoPortoDTO;
import it.portaleSTI.DTO.MagTipoTrasportoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneMagazzinoBO;




/**
 * Servlet implementation class GestionePacco
 */
@WebServlet("/gestionePacco.do")
public class GestionePacco extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
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
		if(action.equals("new")) {
			
		PrintWriter writer = response.getWriter();
		UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
		CompanyDTO company =(CompanyDTO)request.getSession().getAttribute("usrCompany");
		ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
		
		response.setContentType("application/json");
		
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
		String via ="";
		String citta =	"";
		String cap = "";
		String provincia ="";
		String data_ora_trasporto = "";
		String spedizioniere = "";
		String note = "";
		String paese ="";
		String data_lavorazione ="";
		String ora_lavorazione = "";
		String link_pdf ="";
		String codice_pacco = "";
		String stato_lavorazione ="";
		String id_pacco ="";
		String id_ddt = "";
		
		MagPaccoDTO pacco = new MagPaccoDTO();
		MagDdtDTO ddt = new MagDdtDTO();
		 Map<MagItemDTO, String> map = new HashMap<MagItemDTO, String>();
		List<FileItem> items;
		try {
			items = uploadHandler.parseRequest(request);
			
			for (FileItem item : items) {
				if (item.isFormField()) {
					if(item.getFieldName().equals("json")) {
					String data_json = item.getString();
					
					JsonElement jelement = new JsonParser().parse(data_json);
					JsonArray json_array = jelement.getAsJsonArray();
					
					
					for(int i = 0 ; i<json_array.size();i++) {
						
						JsonObject json_obj = json_array.get(i).getAsJsonObject();
						
						String id = json_obj.get("id").getAsString();
						String tipo = json_obj.get("tipo").getAsString();
						String denominazione = json_obj.get("denominazione").getAsString();
						String quantita = json_obj.get("quantita").getAsString();
						String stato = json_obj.get("stato").getAsString();
						MagItemDTO mag_item = new MagItemDTO();
						
						mag_item.setId_tipo_proprio(Integer.parseInt(id));
						mag_item.setDescrizione(denominazione);
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
						map.put(mag_item, quantita);
						GestioneMagazzinoBO.saveItem(mag_item, session);

					}
				
					
					}
					if(item.getFieldName().equals("select1")) {
						cliente =	item.getString();
					}			
					if(item.getFieldName().equals("select2")) {
						 sede =	item.getString();
					}
					if(item.getFieldName().equals("codice_pacco")) {
						codice_pacco = item.getString();
					}
					if(item.getFieldName().equals("stato_lavorazione")) {
						stato_lavorazione = item.getString();
					}
					if(item.getFieldName().equals("numero_ddt")) {
						 numero_ddt =	item.getString();
					}
					if(item.getFieldName().equals("tipo_trasporto")) {
						 tipo_trasporto =	item.getString();
					}
					if(item.getFieldName().equals("tipo_porto")) {
						 tipo_porto =	item.getString();
					}
					if(item.getFieldName().equals("tipo_ddt")) {
						 tipo_ddt =	item.getString();
					}
					if(item.getFieldName().equals("data_ddt")) {
						 data_ddt =	item.getString();
					}
					if(item.getFieldName().equals("aspetto")) {
						 aspetto =	item.getString();
					}
					if(item.getFieldName().equals("causale")) {
						 causale =	item.getString();
					}
					if(item.getFieldName().equals("destinatario")) {
						 destinatario =	item.getString();
					}
					if(item.getFieldName().equals("via")) {
						 via =	item.getString();
					}
					if(item.getFieldName().equals("citta")) {
						 citta =	item.getString();
					}
					if(item.getFieldName().equals("cap")) {
						 cap =	item.getString();
					}
					if(item.getFieldName().equals("provincia")) {
						 provincia =	item.getString();
					}
					if(item.getFieldName().equals("paese")) {
						 paese =	item.getString();
					}
					if(item.getFieldName().equals("data_ora_trasporto")) {
						data_ora_trasporto =	item.getString();
						 String x [];
						 x=data_ora_trasporto.split(" ");
						 data_lavorazione = x[0];
						 ora_lavorazione = x[1];
					}
					if(item.getFieldName().equals("spedizioniere")) {
						 spedizioniere =	item.getString();
					}
					if(item.getFieldName().equals("annotazioni")) {
						annotazioni =	item.getString();
					}
					if(item.getFieldName().equals("note")) {
						 note =	item.getString();
					}
					if(item.getFieldName().equals("id_pacco")) {
						 id_pacco =	item.getString();
					}
					if(item.getFieldName().equals("id_ddt")) {
						 id_ddt =	item.getString();
					}
					
				}else {
					
					
					link_pdf = GestioneMagazzinoBO.uploadPdf(item, numero_ddt);
					ddt.setLink_pdf(link_pdf);
					
					System.out.println(link_pdf);
				}
			
				
		}
			
			
			DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
			DateFormat time = new SimpleDateFormat("HH:mm");
	
			long ms = time.parse(ora_lavorazione).getTime();
			Time t = new Time(ms);
		
			ddt.setNumero_ddt(numero_ddt);
			ddt.setAnnotazioni(annotazioni);
			ddt.setAspetto(new MagAspettoDTO(Integer.parseInt(aspetto),""));
			ddt.setCap_destinazione(cap);
			ddt.setCausale_ddt(causale);
			ddt.setCitta_destinazione(citta);			
			ddt.setData_ddt(format.parse(data_ddt));
			ddt.setData_trasporto(format.parse(data_lavorazione));
			ddt.setNome_destinazione(destinatario);
			ddt.setPaese_destinazione(paese);
			ddt.setNote(note);
			ddt.setOra_trasporto(t);
			ddt.setIndirizzo_destinazione(via);
			ddt.setProvincia_destinazione(provincia);
			ddt.setTipo_ddt(new MagTipoDdtDTO(Integer.parseInt(tipo_ddt), ""));
			ddt.setTipo_porto(new MagTipoPortoDTO(Integer.parseInt(tipo_porto), ""));
			ddt.setTipo_trasporto(new MagTipoTrasportoDTO(Integer.parseInt(tipo_trasporto),""));
			ddt.setSpedizioniere(new MagSpedizioniereDTO(Integer.parseInt(spedizioniere), "", "", "", ""));
			
			pacco.setDdt(ddt);
			String y [];
			y=cliente.split("_");
			
			pacco.setId_cliente(Integer.parseInt(y[0]));
			pacco.setNome_cliente(y[1]);
			
			String x []; 
			x=sede.split("_");
			
			pacco.setId_sede(Integer.parseInt(x[0]));
			pacco.setNome_sede(x[3]);
			
			pacco.setCompany(company);
			pacco.setUtente(utente);
			pacco.setData_lavorazione(format.parse(data_lavorazione));
			pacco.setCodice_pacco(codice_pacco);
			pacco.setStato_lavorazione(new MagStatoLavorazioneDTO(Integer.parseInt(stato_lavorazione), ""));
			
			if(!id_ddt.equals("")) {
				ddt.setId(Integer.parseInt(id_ddt));
			GestioneMagazzinoBO.updateDdt(ddt, session);
			
			}else {
				//pacco.setId(Integer.parseInt(id_pacco));
				GestioneMagazzinoBO.saveDdt(ddt, session);
				
			}
			
			
			if(!id_pacco.equals("")) {
				pacco.setId(Integer.parseInt(id_pacco));
			GestioneMagazzinoBO.updatePacco(pacco, session);
			GestioneMagazzinoBO.deleteItemPacco(pacco, session);
			}else {
				//pacco.setId(Integer.parseInt(id_pacco));
				GestioneMagazzinoBO.savePacco(pacco, session);
				
			}
			
			for(Map.Entry<MagItemDTO, String> entry: map.entrySet()) {
				MagItemPaccoDTO item_pacco = new MagItemPaccoDTO();
				
				item_pacco.setItem(entry.getKey());
				item_pacco.setPacco(pacco);
				item_pacco.setQuantita(Integer.parseInt(entry.getValue()));
			    
				GestioneMagazzinoBO.saveItemPacco(item_pacco, session);
				
			}
			
			session.getTransaction().commit();
			
			
			ArrayList<MagPaccoDTO> lista_pacchi = GestioneMagazzinoBO.getListaPacchi(company.getId(), session);
			ArrayList<MagItemPaccoDTO> item_pacco = GestioneMagazzinoBO.getListaItemPacco(pacco.getId(), session);
			request.getSession().setAttribute("lista_pacchi",lista_pacchi);
			request.getSession().setAttribute("lista_item_pacco", item_pacco);
			request.getSession().setAttribute("pacco", pacco);
			session.close();
			
	   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listapacchi.jsp");
	   		response.sendRedirect(request.getHeader("referer"));
	   	     //dispatcher.forward(request,response);	
			
			
		} catch (FileUploadException e) {
			
			session.getTransaction().rollback();
			session.close();
			e.printStackTrace();
		} catch (ParseException e) {

			session.getTransaction().rollback();
			session.close();
			e.printStackTrace();
		} catch (Exception e) {
			
			session.getTransaction().rollback();
			session.close();
			e.printStackTrace();
		}
	}
		
		else if(action.equals("dettaglio")) {
			
			String id_pacco = request.getParameter("id_pacco");
			
			try {
				MagPaccoDTO pacco = GestioneMagazzinoBO.getPaccoById(Integer.parseInt(id_pacco), session);
				
				ArrayList<MagItemPaccoDTO> item_pacco = new ArrayList<MagItemPaccoDTO>();
				
				item_pacco = GestioneMagazzinoBO.getListaItemPacco(pacco.getId(), session);
				
				session.close();

				request.getSession().setAttribute("lista_item_pacco", item_pacco);
				request.getSession().setAttribute("pacco", pacco);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioPacco.jsp");
		     	dispatcher.forward(request,response);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		
		else if(action.equals("modifica")) {
			
			String id_pacco = request.getParameter("id_pacco");
			
		}
		
	}
	
	
	
}
