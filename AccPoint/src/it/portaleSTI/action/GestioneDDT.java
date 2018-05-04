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
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateDDT;
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
		
		String action = request.getParameter("action");
		
		if(action.equals("dettaglio")) {
		
		String id_ddt = request.getParameter("id");
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		MagDdtDTO ddt = new MagDdtDTO();
		
		ddt= GestioneMagazzinoBO.getDDT(id_ddt, session);
		MagPaccoDTO pacco = GestioneMagazzinoBO.getPaccoByDDT(ddt.getId(), session);
		session.close();
		
		request.setAttribute("ddt", ddt);
		request.setAttribute("pacco", pacco);
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioDDT.jsp");
     	dispatcher.forward(request,response);
		}
		
		else if(action.equals("crea_ddt")){
			
			JsonObject myObj = new JsonObject();
			PrintWriter  out = response.getWriter();
			
			String id_pacco = request.getParameter("id_pacco");
			String id_cliente = request.getParameter("id_cliente");
			String id_sede = request.getParameter("id_sede");
			String id_ddt = request.getParameter("id_ddt");
			Session session=SessionFacotryDAO.get().openSession();
			session.beginTransaction();
			
			MagDdtDTO ddt = new MagDdtDTO();
			
			ddt = GestioneMagazzinoBO.getDDT(id_ddt, session);
			
			List<MagItemPaccoDTO> lista_item_pacco = GestioneMagazzinoBO.getListaItemPacco(Integer.parseInt(id_pacco), session);
			
			try {
				
				ClienteDTO cliente = null;
				if(id_sede.equals("0")) {
					cliente = GestioneStrumentoBO.getCliente(id_cliente);
				}else {
					cliente = GestioneStrumentoBO.getClienteFromSede(id_cliente, id_sede);
				}
				ddt.setCliente(cliente);

				CreateDDT ddt_pdf =new CreateDDT(ddt, lista_item_pacco, session);
				if(!ddt_pdf.isEsito()) {
		
					response.sendError(response.SC_INTERNAL_SERVER_ERROR);
				}
				else {
					
				ddt = GestioneMagazzinoBO.getDDT(id_ddt, session);
				
				session.getTransaction().commit();
				session.close();
				
				request.getSession().setAttribute("ddt", ddt);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		
		
		
		else if(action.equals("download")){
			
			try {
			String filename= request.getParameter("link_pdf");
			
			String path = Costanti.PATH_FOLDER+"Magazzino" + "\\"+ filename; 
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
		
		
		else if(action.equals("salva")){
			if(Utility.validateSession(request,response,getServletContext()))return;
			
			Session session=SessionFacotryDAO.get().openSession();
			session.beginTransaction();
			
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
			String link_pdf ="";
			String id_ddt = "";
			String pdf_path = "";
			String data_arrivo = "";
			String colli = "";

		
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

						
					}else {
						
						if(item.getName()!="") {
						link_pdf = GestioneMagazzinoBO.uploadPdf(item, numero_ddt);
						ddt.setLink_pdf(link_pdf);
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
				if(!data_arrivo.equals("")) {
					ddt.setData_arrivo(format.parse(data_arrivo));
				}
				if(link_pdf == "" || link_pdf==null) {
					ddt.setLink_pdf(pdf_path);
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
				ddt.setColli(Integer.parseInt(colli));
				if(!id_ddt.equals("")) {
					ddt.setId(Integer.parseInt(id_ddt));

				GestioneMagazzinoBO.updateDdt(ddt, session);
				
				}else {
					GestioneMagazzinoBO.saveDdt(ddt, session);
				}
				
				session.getTransaction().commit();
				ArrayList<MagPaccoDTO> lista_pacchi = GestioneMagazzinoBO.getListaPacchi(company.getId(), session);

				request.getSession().setAttribute("lista_pacchi",lista_pacchi);

				session.close();
				
		   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listapacchi.jsp");
		   		//dispatcher.forward(request, response);
		   		response.sendRedirect(request.getHeader("referer"));

			} catch (FileUploadException e) {
				
				session.getTransaction().rollback();
				session.close();
				e.printStackTrace();
				request.setAttribute("error",STIException.callException(e));
		   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		   	     dispatcher.forward(request,response);	
			} catch (ParseException e) {

				session.getTransaction().rollback();
				session.close();
				
				File f = new File(link_pdf);
				if(f.exists()) {
					f.delete();
				}
				
				e.printStackTrace();
				
				request.setAttribute("error",STIException.callException(e));
		   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		   	     dispatcher.forward(request,response);	
			} catch (Exception e) {
				
				session.getTransaction().rollback();
				session.close();
				File f = new File(link_pdf);
				if(f.exists()) {
					f.delete();
				}
				
				e.printStackTrace();
				request.setAttribute("error",STIException.callException(e));
		   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		   	     dispatcher.forward(request,response);	
		   	 
			}
		}
		
	}

}
