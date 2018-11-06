package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
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
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.mysql.jdbc.Util;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.MagAspettoDTO;
import it.portaleSTI.DTO.MagCausaleDTO;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.DTO.MagItemDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.MagSaveStatoDTO;
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
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneMagazzinoBO;
import it.portaleSTI.bo.GestioneStrumentoBO;



/**
 * Servlet implementation class GestioneDDT
 */
@WebServlet("/gestioneDDT.do")
public class GestioneDDT extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneDDT() {
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
		List<SedeDTO> listaSedi = (List<SedeDTO>) request.getSession().getAttribute("lista_sedi"); 
		if(action.equals("dettaglio")) {
		
		String id_ddt = request.getParameter("id");
		
		try {
			
		id_ddt = Utility.decryptData(id_ddt);
		
		MagDdtDTO ddt = new MagDdtDTO();
		
		ddt= GestioneMagazzinoBO.getDDT(id_ddt, session);
		MagPaccoDTO pacco = GestioneMagazzinoBO.getPaccoByDDT(ddt.getId(), session);
				
			String destinatario = "";
			String sede_destinatario = "";
			String sede_destinazione = "";
			String destinazione = "";
			if(ddt.getId_destinatario()!=null && ddt.getId_destinatario()!=0) {
				ClienteDTO cl_destinatario = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(ddt.getId_destinatario()));
			destinatario = cl_destinatario.getNome();
			}else {
				destinatario = "Non Associato";
			}
			if(ddt.getId_sede_destinatario()!=null && ddt.getId_sede_destinatario()!=0) {
				SedeDTO sd_destinatario = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, ddt.getId_sede_destinatario(), ddt.getId_destinatario());
				sede_destinatario = sd_destinatario.getDescrizione();
			}else {
				sede_destinatario = "Non Associate";
			}
			if(ddt.getId_destinazione()!=null && ddt.getId_destinazione()!=0) {
				ClienteDTO cl_destinazione = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(ddt.getId_destinazione()));
				destinazione = cl_destinazione.getNome();
			}else {
				destinazione = "Non Associato";
			}
			if(ddt.getId_sede_destinazione()!=null && ddt.getId_sede_destinazione()!=0) {
				SedeDTO sd_destinazione = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, ddt.getId_sede_destinazione(), ddt.getId_destinazione());
				sede_destinazione = sd_destinazione.getDescrizione();
			}else {
				sede_destinazione = "Non Associate";
			}
	
		session.close();
		
		request.setAttribute("destinatario", destinatario);
		request.setAttribute("sede_destinatario", sede_destinatario);
		request.setAttribute("destinazione", destinazione);
		request.setAttribute("sede_destinazione", sede_destinazione);
		request.setAttribute("ddt", ddt);
		request.setAttribute("pacco", pacco);
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioDDT.jsp");
     	dispatcher.forward(request,response);
     	
		}catch (Exception e) {
			
     	e.printStackTrace();
		request.setAttribute("error",STIException.callException(e));
  	     request.getSession().setAttribute("exception", e);
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
     	
		}
		}
		
		else if(action.equals("crea_ddt")){
			
			JsonObject myObj = new JsonObject();
			PrintWriter  out = response.getWriter();
			
			String id_pacco = request.getParameter("id_pacco");
			String id_cliente = request.getParameter("id_cliente");
			String id_sede = request.getParameter("id_sede");
			String id_ddt = request.getParameter("id_ddt");
			List<SedeDTO> lista_sedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
			//Session session=SessionFacotryDAO.get().openSession();
			//session.beginTransaction();
			
			MagDdtDTO ddt = new MagDdtDTO();
			
			ddt = GestioneMagazzinoBO.getDDT(id_ddt, session);
			
			List<MagItemPaccoDTO> lista_item_pacco = GestioneMagazzinoBO.getListaItemPacco(Integer.parseInt(id_pacco), session);
			
			try {
				
				ClienteDTO cliente = null;
				if(id_sede.equals("0")) {
					cliente = GestioneAnagraficaRemotaBO.getClienteById(id_cliente);
				}else {
					cliente = GestioneAnagraficaRemotaBO.getClienteFromSede(id_cliente, id_sede);
				}
				ddt.setCliente(cliente);
				

				CreateDDT ddt_pdf =new CreateDDT(ddt, lista_sedi, lista_item_pacco, session);

				ddt = GestioneMagazzinoBO.getDDT(id_ddt, session);
				
				session.getTransaction().commit();
				session.close();
				request.getSession().setAttribute("ddt", ddt);
				myObj = STIException.getSuccessMessage("DDT Creato con successo!");
				out.print(myObj);
				
				
			} catch (Exception e) {
				
				e.printStackTrace();
				request.getSession().setAttribute("exception", e);
				
				myObj = STIException.getException(e);
				out.print(myObj);
			}

		}
		
		
		
		else if(action.equals("download")){
			
			try {
			String id_ddt= request.getParameter("id_ddt");
			MagPaccoDTO pacco = GestioneMagazzinoBO.getPaccoByDDT(Integer.parseInt(id_ddt), session);
			String path = Costanti.PATH_FOLDER+"Magazzino\\DDT\\PC_"+ pacco.getId() + "\\" + pacco.getDdt().getLink_pdf(); 
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
		   		request.getSession().setAttribute("exception",ex);
		   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		   	     dispatcher.forward(request,response);	
		   	  ex.printStackTrace();
			}
		
		}
		
		
		else if(action.equals("salva")){
			if(Utility.validateSession(request,response,getServletContext()))return;
			
			//Session session=SessionFacotryDAO.get().openSession();
			//session.beginTransaction();
			
			PrintWriter writer = response.getWriter();
			UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
			CompanyDTO company =(CompanyDTO)request.getSession().getAttribute("usrCompany");
			ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
			
			response.setContentType("application/json");
						
			String numero_ddt = "";
			String annotazioni = "";
			String tipo_trasporto = "";
			String tipo_porto = "";
			String tipo_ddt = "";
			String data_ddt = "";
			String aspetto = "";
			String causale ="";
			String data_ora_trasporto = "";
			String spedizioniere = "";
			String note = "";		
			String data_trasporto ="";
			String ora_trasporto = "";
			String link_pdf ="";
			String id_ddt = "";
			String pdf_path = "";
			String data_arrivo = "";
			String colli = "";
			String operatore_trasporto ="";
			String destinatario ="";
			String sede_destinatario="";
			String destinazione = "";
			String sede_destinazione = "";
			String destinatario_ddt = "";
			String sede_destinatario_ddt = "";
			String destinazione_ddt = "";
			String sede_destinazione_ddt = "";
			String cortese_attenzione = "";
			String note_ddt=null;
			String peso = "";
			String magazzino ="";
			String configurazione_ddt ="";
			FileItem pdf =null;
			MagDdtDTO ddt = new MagDdtDTO();
			
			List<FileItem> items;
			try {
				items = uploadHandler.parseRequest(request);
				
				for (FileItem item : items) {
					if (item.isFormField()) {
						
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
						if(item.getFieldName().equals("magazzino")) {
							 magazzino =	item.getString();
						}
						if(item.getFieldName().equals("configurazione_ddt")) {
							 configurazione_ddt =	item.getString();
						}
						if(item.getFieldName().equals("peso")) {
							 peso =	item.getString();
						}
						if(item.getFieldName().equals("causale")) {
							 causale =	item.getString();
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
						if(item.getFieldName().equals("destinatario_ddt")) {
							destinatario_ddt =	item.getString();
						}
						if(item.getFieldName().equals("sede_destinatario_ddt")) {
							sede_destinatario_ddt =	item.getString();
						}
						if(item.getFieldName().equals("destinazione_ddt")) {
							destinazione_ddt =	item.getString();
						}
						if(item.getFieldName().equals("sede_destinazione_ddt")) {
							sede_destinazione_ddt =	item.getString();
						}
						if(item.getFieldName().equals("cortese_attenzione")) {
							cortese_attenzione =	item.getString();
						}
						if(item.getFieldName().equals("note_ddt")) {
							note_ddt =	item.getString();
						}
						if(item.getFieldName().equals("colli")) {
							 colli =	item.getString();
						}
						if(item.getFieldName().equals("data_ora_trasporto")) {
							data_ora_trasporto =	item.getString();
							if(!data_ora_trasporto.equals(" ") && !data_ora_trasporto.equals("")) {
							 String x [];
							 x=data_ora_trasporto.split(" ");
							 if(x.length>1) {
							 data_trasporto = x[0];
							 ora_trasporto = x[1];
							 }else {
								 data_trasporto = x[0];
								 ora_trasporto = "";
							 }
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
					
						if(item.getFieldName().equals("id_ddt")) {
							 id_ddt =	item.getString();
						}
						if(item.getFieldName().equals("pdf_path")) {
							pdf_path =	item.getString();
						}
						if(item.getFieldName().equals("data_arrivo")) {
							data_arrivo = item.getString();
						}
						if(item.getFieldName().equals("operatore_trasporto")) {
							operatore_trasporto = item.getString();
						}

						
					}else {
						
						if(item.getName()!="") {
						//MagPaccoDTO pacco = GestioneMagazzinoBO.getPaccoByDDT(ddt.getId(), session);
						//link_pdf = GestioneMagazzinoBO.uploadPdf(item, item.getName());
						pdf = item;
						link_pdf = item.getName();
						
						}
						
					}
				
			}
				DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
				DateFormat time = new SimpleDateFormat("HH:mm");
		
				if(!ora_trasporto.equals("")) {
					long ms = time.parse(ora_trasporto).getTime();
					Time hour = new Time(ms);
					ddt.setOra_trasporto(hour);
					
				}
				if(!data_trasporto.equals("")) {
					
					ddt.setData_trasporto(format.parse(data_trasporto));
				}
				
				if(!data_ddt.equals("")) {
					ddt.setData_ddt(format.parse(data_ddt));
				}
				
				if(link_pdf == "" || link_pdf==null) {
					ddt.setLink_pdf(pdf_path);
				}else {
					ddt.setLink_pdf(link_pdf);
				}				
				ddt.setCortese_attenzione(cortese_attenzione);
				ddt.setNumero_ddt(numero_ddt);
				ddt.setAnnotazioni(annotazioni);
				ddt.setAspetto(new MagAspettoDTO(Integer.parseInt(aspetto),""));
				if(peso!=null && !peso.equals("")) {
					ddt.setPeso(Double.parseDouble(peso));
				}
				if(!causale.equals(""))
				ddt.setCausale(new MagCausaleDTO(Integer.parseInt(causale),""));
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
				if(!destinatario_ddt.equals("")) {
					ddt.setId_destinatario(Integer.parseInt(destinatario_ddt.split("_")[0]));
				}
				if(!sede_destinatario_ddt.equals("")) {
					String[] dest = sede_destinatario_ddt.split("_");
					ddt.setId_sede_destinatario(Integer.parseInt(dest[0]));
				}
				if(!destinazione_ddt.equals("")) {
					ddt.setId_destinazione(Integer.parseInt(destinazione_ddt.split("_")[0]));
				}
				if(!sede_destinazione_ddt.equals("")) {
					String[] dest = sede_destinazione_ddt.split("_");
					ddt.setId_sede_destinazione(Integer.parseInt(dest[0]));
				}
				
				//ddt.setPaese_destinazione(paese);
				ddt.setNote(note);
				if(note_ddt!=null) {
					ddt.setNote(note_ddt);
				}
				//ddt.setIndirizzo_destinazione(via);
				//ddt.setProvincia_destinazione(provincia);
				ddt.setTipo_ddt(new MagTipoDdtDTO(Integer.parseInt(tipo_ddt), ""));
				ddt.setTipo_porto(new MagTipoPortoDTO(Integer.parseInt(tipo_porto), ""));
				ddt.setTipo_trasporto(new MagTipoTrasportoDTO(Integer.parseInt(tipo_trasporto),""));
				ddt.setOperatore_trasporto(operatore_trasporto);
				ddt.setSpedizioniere(spedizioniere);
				ddt.setColli(Integer.parseInt(colli));
				
				if(!id_ddt.equals("")) {
					ddt.setId(Integer.parseInt(id_ddt));

				GestioneMagazzinoBO.updateDdt(ddt, session);
				
				}else {
					GestioneMagazzinoBO.saveDdt(ddt, session);
				}
				
				if(configurazione_ddt.equals("1")) {
					
					MagSaveStatoDTO save_stato = new MagSaveStatoDTO();
					
					save_stato.setId_cliente(ddt.getId_destinatario());
					save_stato.setId_sede(ddt.getId_sede_destinatario());
					save_stato.setCa(cortese_attenzione);
					save_stato.setTipo_porto(Integer.parseInt(tipo_porto));
					save_stato.setAspetto(Integer.parseInt(aspetto));
					save_stato.setSpedizioniere(spedizioniere);
					session.saveOrUpdate(save_stato);
				}
				
				if(pdf!=null) {
					MagPaccoDTO pacco = GestioneMagazzinoBO.getPaccoByDDT(ddt.getId(), session);
					GestioneMagazzinoBO.uploadPdf(pdf,pacco.getId(), pdf.getName());
				}
				
				session.getTransaction().commit();
				
				ArrayList<MagPaccoDTO> lista_pacchi = GestioneMagazzinoBO.getListaPacchi(company.getId(), session);
				
				request.getSession().setAttribute("lista_pacchi",lista_pacchi);				
				
				ArrayList<MagSaveStatoDTO> lista_save_stato = GestioneMagazzinoBO.getListaMagSaveStato(session);
				
				session.close();
				
				String lista_save_stato_json = new Gson().toJson(lista_save_stato);
				request.getSession().setAttribute("lista_save_stato_json", lista_save_stato_json);
		   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listapacchi.jsp");
		   		//dispatcher.forward(request, response);
		   		response.sendRedirect(request.getHeader("referer"));

			
			} catch (Exception e) {
				
				session.getTransaction().rollback();
				session.close();
				File f = new File(link_pdf);
				if(f.exists()) {
					f.delete();
				}
				
				e.printStackTrace();
				request.setAttribute("error",STIException.callException(e));
		  	     request.getSession().setAttribute("exception", e);
		   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		   	     dispatcher.forward(request,response);	
		   	 
			}
		}
		
	}

}
