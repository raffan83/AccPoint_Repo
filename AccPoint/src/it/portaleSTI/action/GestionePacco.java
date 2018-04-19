package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Time;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
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

import it.portaleSTI.DAO.GestioneMagazzinoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AttivitaMilestoneDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.MagAllegatoDTO;
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
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateDDT;
import it.portaleSTI.bo.CreateTestaPacco;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneMagazzinoBO;
import it.portaleSTI.bo.GestioneSchedaConsegnaBO;
import it.portaleSTI.bo.GestioneStrumentoBO;




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
		String data_trasporto ="";
		String ora_trasporto = "";
		String codice_pacco = "";
		String link_pdf ="";
		String link_pdf_old ="";
		String stato_lavorazione ="";
		String id_pacco ="";
		String id_ddt = "";
		String commessa = "";
		String origine= "";
		String testa_pacco = "";
		
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
						String note_item = json_obj.get("note").getAsString();
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
						map.put(mag_item, quantita+"_"+note_item);
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
						 codice_pacco =	item.getString();
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
						if(!data_ora_trasporto.equals(" ") && !data_ora_trasporto.equals("")) {
						 String x [];
						 x=data_ora_trasporto.split(" ");
						 data_trasporto = x[0];
						 ora_trasporto = x[1];
						}
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
				}else {
					
					if(item.getName()!="") {
					link_pdf = GestioneMagazzinoBO.uploadPdf(item, numero_ddt);
					ddt.setLink_pdf(link_pdf);
					}
					
				}
			
		}
			
	
			DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
			DateFormat time = new SimpleDateFormat("HH:mm");
	
			if(!ora_trasporto.equals("")&&!data_trasporto.equals("")) {
				long ms = time.parse(ora_trasporto).getTime();
				Time hour = new Time(ms);
				ddt.setOra_trasporto(hour);
				ddt.setData_trasporto(format.parse(data_trasporto));
			}
			
			if(!data_ddt.equals("")) {
				ddt.setData_ddt(format.parse(data_ddt));
			}
		
			ddt.setNumero_ddt(numero_ddt);
			ddt.setAnnotazioni(annotazioni);
			ddt.setAspetto(new MagAspettoDTO(Integer.parseInt(aspetto),""));
			ddt.setCap_destinazione(cap);
			ddt.setCausale_ddt(causale);
			ddt.setCitta_destinazione(citta);		
			ddt.setNome_destinazione(destinatario);
			ddt.setPaese_destinazione(paese);
			ddt.setNote(note);
			ddt.setIndirizzo_destinazione(via);
			ddt.setProvincia_destinazione(provincia);
			ddt.setTipo_ddt(new MagTipoDdtDTO(Integer.parseInt(tipo_ddt), ""));
			ddt.setTipo_porto(new MagTipoPortoDTO(Integer.parseInt(tipo_porto), ""));
			ddt.setTipo_trasporto(new MagTipoTrasportoDTO(Integer.parseInt(tipo_trasporto),""));
			ddt.setSpedizioniere(new MagSpedizioniereDTO(Integer.parseInt(spedizioniere), "", "", "", ""));
			
			pacco.setDdt(ddt);
			
			String cliente_split [];
			cliente_split=cliente.split("_");
			pacco.setId_cliente(Integer.parseInt(cliente_split[0]));
			pacco.setNome_cliente(cliente_split[1]);
			
			ClienteDTO cl = new ClienteDTO();
		
			if(!sede.equals("0")) {
			String sede_split [];
			sede_split=sede.split("_");
			cl=GestioneStrumentoBO.getClienteFromSede(cliente_split[0], sede_split[0]);
			pacco.setId_sede(Integer.parseInt(sede_split[0]));
			if(sede_split.length==4) {
				pacco.setNome_sede(sede_split[3]);
			}else {
			pacco.setNome_sede(sede_split[3] +" - "+ sede_split[5]);
			}
			}else {
				cl = GestioneStrumentoBO.getCliente(cliente_split[0]);
				pacco.setId_sede(Integer.parseInt(sede));
				pacco.setNome_sede("Non associate");
			}
			
			pacco.setCliente(cl);			
			pacco.setCompany(company);
			pacco.setUtente(utente);
			pacco.setCodice_pacco(codice_pacco);
			pacco.setData_lavorazione(new Date());			
			pacco.setStato_lavorazione(new MagStatoLavorazioneDTO(Integer.parseInt(stato_lavorazione), ""));
			//pacco.setLink_testa_pacco(testa_pacco);
			pacco.setCommessa(commessa);
					
			pacco.setOrigine(origine);
			if(!id_ddt.equals("")) {
				ddt.setId(Integer.parseInt(id_ddt));
				if(link_pdf.equals(""))
				ddt.setLink_pdf(link_pdf_old);
			GestioneMagazzinoBO.updateDdt(ddt, session);
			
			}else {
			
			
				GestioneMagazzinoBO.saveDdt(ddt, session);
			}
			
			if(!id_pacco.equals("")) {
				pacco.setId(Integer.parseInt(id_pacco));
				GestioneMagazzinoBO.updatePacco(pacco, session);
				GestioneMagazzinoBO.deleteItemPacco(Integer.parseInt(id_pacco), session);
			}else {
				GestioneMagazzinoBO.savePacco(pacco, session);
				
			}
			
			for(Map.Entry<MagItemDTO, String> entry: map.entrySet()) {
				MagItemPaccoDTO item_pacco = new MagItemPaccoDTO();
				
				item_pacco.setItem(entry.getKey());
				item_pacco.setPacco(pacco);
				String [] str = entry.getValue().split("_");
				
				item_pacco.setQuantita(Integer.parseInt(str[0]));
				if(str.length>1) {
				item_pacco.setNote(str[1]);
				}
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
			
			File f = new File(link_pdf);
			if(f.exists()) {
				f.delete();
			}
			
			e.printStackTrace();
		} catch (Exception e) {
			
			session.getTransaction().rollback();
			session.close();
			File f = new File(link_pdf);
			if(f.exists()) {
				f.delete();
			}
			
			e.printStackTrace();
		}
	}
		
		else if(action.equals("dettaglio")) {
			
			String id_pacco = request.getParameter("id_pacco");
			
			try {
				MagPaccoDTO pacco = GestioneMagazzinoBO.getPaccoById(Integer.parseInt(id_pacco), session);
				
				ArrayList<MagItemPaccoDTO> item_pacco = new ArrayList<MagItemPaccoDTO>();
				
				item_pacco = GestioneMagazzinoBO.getListaItemPacco(pacco.getId(), session);
				
				ArrayList<MagAllegatoDTO> allegati = GestioneMagazzinoBO.getAllegatiFromPacco(id_pacco, session);
				
				session.close();
				
				request.getSession().setAttribute("allegati", allegati);
				request.getSession().setAttribute("lista_item_pacco", item_pacco);
				request.getSession().setAttribute("pacco", pacco);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioPacco.jsp");
		     	dispatcher.forward(request,response);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		else if(action.equals("pacco_uscita")) {
			
			String id_pacco = request.getParameter("id_pacco");
			String codice = request.getParameter("codice");
			
			CompanyDTO company =(CompanyDTO)request.getSession().getAttribute("usrCompany");
			try {
				
				MagPaccoDTO pacco = GestioneMagazzinoBO.getPaccoById(Integer.parseInt(id_pacco), session);
				
				MagPaccoDTO new_pacco = new MagPaccoDTO();
				new_pacco.setCliente(pacco.getCliente());
				new_pacco.setCodice_pacco(codice);
				new_pacco.setCompany(pacco.getCompany());
				new_pacco.setData_lavorazione(new Date());
				new_pacco.setId_cliente(pacco.getId_cliente());
				new_pacco.setId_sede(pacco.getId_sede());
				new_pacco.setNome_cliente(pacco.getNome_cliente());
				new_pacco.setNome_sede(pacco.getNome_sede());
				new_pacco.setUtente(pacco.getUtente());
				MagStatoLavorazioneDTO stato = new MagStatoLavorazioneDTO(2, "");
				new_pacco.setStato_lavorazione(stato);
				new_pacco.setOrigine(pacco.getCodice_pacco());
				new_pacco.setDdt(new MagDdtDTO());
				new_pacco.setCommessa(pacco.getCommessa());
				
				GestioneMagazzinoBO.saveDdt(new_pacco.getDdt(), session);
				GestioneMagazzinoBO.savePacco(new_pacco, session);
				
				ArrayList<MagItemPaccoDTO> lista_item_pacco= GestioneMagazzinoBO.getListaItemPacco(Integer.parseInt(id_pacco), session);
				
				for(int i=0; i<lista_item_pacco.size();i++) {
					MagItemPaccoDTO item_pacco = new MagItemPaccoDTO();
					item_pacco.setItem(lista_item_pacco.get(i).getItem());
					item_pacco.setPacco(new_pacco);
					item_pacco.setQuantita(lista_item_pacco.get(i).getQuantita());
					item_pacco.setNote(lista_item_pacco.get(i).getNote());
					
					GestioneMagazzinoBO.saveItemPacco(item_pacco, session);
					
				}
				
				session.getTransaction().commit();
				ArrayList<MagPaccoDTO> lista_pacchi = GestioneMagazzinoBO.getListaPacchi(company.getId(), session);
				session.close();
				
				request.getSession().setAttribute("lista_pacchi",lista_pacchi);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listapacchi.jsp");
		     	//dispatcher.forward(request,response);
				response.sendRedirect(request.getHeader("referer"));
		
				
			} catch(Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				
			}
			
		}
		
		else if(action.equals("spedito")) {
			
			String id_pacco = request.getParameter("id_pacco");
			
			try {
				
				MagPaccoDTO pacco = GestioneMagazzinoBO.getPaccoById(Integer.parseInt(id_pacco), session);
				MagStatoLavorazioneDTO stato = new MagStatoLavorazioneDTO(3, "");
				
				pacco.setStato_lavorazione(stato);
				Date data_trasporto = new Date();
				Time ora_trasporto = new Time(data_trasporto.getTime());
				pacco.getDdt().setData_trasporto(data_trasporto);
				pacco.getDdt().setOra_trasporto(ora_trasporto);
				GestioneMagazzinoBO.savePacco(pacco, session);
				
				session.getTransaction().commit();
				session.close();
				
				JsonObject myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Data e Ora trasporto aggiornate!");
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				String date = "Pacco spedito il "+df.format(data_trasporto)+" alle "+ora_trasporto;
				myObj.addProperty("date", date);
				out.print(myObj);

				//RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listapacchi.jsp");
		     	//dispatcher.forward(request,response);
				//response.sendRedirect(request.getHeader("referer"));
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			
		}
		
//		else if(action.equals("spedito")) {
//			
//			String id_pacco = request.getParameter("id_pacco");
//			
//			try {
//				
//				MagPaccoDTO pacco = GestioneMagazzinoBO.getPaccoById(Integer.parseInt(id_pacco), session);
//				MagStatoLavorazioneDTO stato = new MagStatoLavorazioneDTO(3, "");
//				
//				pacco.setStato_lavorazione(stato);
//				Date data_trasporto = new Date();
//				Time ora_trasporto = new Time(data_trasporto.getTime());
//				pacco.getDdt().setData_trasporto(data_trasporto);
//				pacco.getDdt().setOra_trasporto(ora_trasporto);
//				GestioneMagazzinoBO.savePacco(pacco, session);
//				
//				session.getTransaction().commit();
//				session.close();
//
//				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listapacchi.jsp");
//		     	//dispatcher.forward(request,response);
//				response.sendRedirect(request.getHeader("referer"));
//			} catch (NumberFormatException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			} catch (Exception e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			
//			
//			
//		}
		
		else if (action.equals("testa_pacco")) {
			
			String id_pacco = request.getParameter("id_pacco");
			
			try {
				MagPaccoDTO pacco = GestioneMagazzinoBO.getPaccoById(Integer.parseInt(id_pacco), session);
				
				List<MagItemPaccoDTO> lista_item_pacco = GestioneMagazzinoBO.getListaItemPacco(Integer.parseInt(id_pacco), session);
				
				CreateTestaPacco testa_pacco =new CreateTestaPacco(pacco, lista_item_pacco, session);
				if(!testa_pacco.isEsito()) {
		
					response.sendError(response.SC_INTERNAL_SERVER_ERROR);
				}
				else {
					
				//ddt = GestioneMagazzinoBO.getDDT(id_ddt, session);
				
				session.getTransaction().commit();
				session.close();
				
			}
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	}
		else if(action.equals("dettaglio_commessa")) {
			
			String id_commessa = request.getParameter("id_commessa");
			
			try {
				CommessaDTO comm=GestioneCommesseBO.getCommessaById(id_commessa);
				
				ArrayList<AttivitaMilestoneDTO> lista_attivita = comm.getListaAttivita();
				
				request.getSession().setAttribute("lista_attivita",lista_attivita);
				request.getSession().setAttribute("id_commessa", id_commessa);

				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioCommessaPacchi.jsp");
		     	dispatcher.forward(request,response);
				
			} catch (Exception e) {

				
				JsonObject myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("messaggio", "Errore");
				
				out.print(myObj);

				e.printStackTrace();
			}
			
		}
		
		else if(action.equals("download_testa_pacco")) {
			
			try {
				String filename= request.getParameter("filename");
				String path = Costanti.PATH_FOLDER+"//"+"Magazzino" + "//"+ "testa_pacco//"+ filename +".pdf";
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
				    
				}catch(Exception ex)
		    	{
					
			   		request.setAttribute("error",STIException.callException(ex));
			   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
			   	     dispatcher.forward(request,response);	
			   	  ex.printStackTrace();
				}
			
		}
		
		
		else if(action.equals("upload_allegati")) {
			
			JsonObject myObj = new JsonObject();
			PrintWriter  out = response.getWriter();
			ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
			PrintWriter writer = response.getWriter();
			response.setContentType("application/json");
			
			String id_pacco = request.getParameter("id_pacco");
			boolean esito=false;
			
				List<FileItem> items;
				try {
					items = uploadHandler.parseRequest(request);
					MagPaccoDTO pacco=GestioneMagazzinoBO.getPaccoById(Integer.parseInt(id_pacco), session);
				for (FileItem item : items) {
					if (!item.isFormField()) {
						
						String filename = GestioneMagazzinoBO.uploadImage(item, pacco.getCodice_pacco());

						MagAllegatoDTO allegato = new MagAllegatoDTO();
						allegato.setPacco(pacco);
						allegato.setAllegato(filename);
						
						GestioneMagazzinoBO.saveAllegato(allegato, session);
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
				
				}catch (NumberFormatException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			
		//}
		
		}
		
		else if(action.equals("download_allegato")) {
			
			try {
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
				    
				}catch(Exception ex)
		    	{
					
			   		request.setAttribute("error",STIException.callException(ex));
			   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
			   	     dispatcher.forward(request,response);	
			   	  ex.printStackTrace();
				}
			
			
		}
		
		else if(action.equals("elimina_allegato")) {
			JsonObject myObj = new JsonObject();
			PrintWriter  out = response.getWriter();
			

			String id_allegato = request.getParameter("id_allegato");
			String id_pacco = request.getParameter("id_pacco");
			
			GestioneMagazzinoBO.eliminaAllegato(Integer.parseInt(id_allegato), session);
		
			
			ArrayList<MagAllegatoDTO> lista_allegati = GestioneMagazzinoBO.getAllegatiFromPacco(id_pacco, session);
			
			request.getSession().setAttribute("lista_allegati", lista_allegati);
			session.getTransaction().commit();
			session.close();
			
			String jsonObj = new Gson().toJson(lista_allegati);
		
			myObj.addProperty("json", jsonObj);
			myObj.addProperty("success", true);
			myObj.addProperty("messaggio", "Allegato eliminato con successo!");
			out.print(myObj);
			
			
		}
		
		}
}
