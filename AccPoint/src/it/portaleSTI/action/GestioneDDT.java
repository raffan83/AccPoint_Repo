package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Time;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MagAspettoDTO;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.DTO.MagSpedizioniereDTO;
import it.portaleSTI.DTO.MagTipoDdtDTO;
import it.portaleSTI.DTO.MagTipoPortoDTO;
import it.portaleSTI.DTO.MagTipoTrasportoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneMagazzinoBO;
import it.portaleSTI.bo.GestioneSchedaConsegnaBO;

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
			
		String numero_ddt = request.getParameter("numero_ddt");
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		MagDdtDTO ddt = new MagDdtDTO();
		
		ddt= GestioneMagazzinoBO.getDDT(numero_ddt, session);
		
		session.close();
		
		request.setAttribute("ddt", ddt);
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioDDT.jsp");
     	dispatcher.forward(request,response);
		}
		
		else if(action.equals("salva")){
			try {
			
			String numero_ddt = request.getParameter("numero_ddt");
			String tipo_trasporto = request.getParameter("tipo_trasporto");
			String tipo_porto = request.getParameter("tipo_porto");
			String tipo_ddt = request.getParameter("tipo_ddt");
			String data_ddt = request.getParameter("data_ddt");
			String causale = request.getParameter("causale");
			String destinatario = request.getParameter("destinatario");
			String via = request.getParameter("via");
			String citta = request.getParameter("citta");
			String provincia = request.getParameter("provincia");
			String paese = request.getParameter("paese");
			String data_lavorazione = request.getParameter("data_lavorazione");
			String ora_lavorazione = request.getParameter("ora_lavorazione");
			String cap = request.getParameter("cap");
			String aspetto = request.getParameter("aspetto");
			String spedizioniere = request.getParameter("spedizioniere");
			String annotazioni = request.getParameter("annotazioni");
			String note = request.getParameter("note");
			String link_pdf=request.getParameter("link_pdf");
			
			
			DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
			DateFormat time = new SimpleDateFormat("HH:mm");
	
			long ms = time.parse(ora_lavorazione).getTime();
			Time t = new Time(ms);
			
			
			MagDdtDTO ddt = new MagDdtDTO();
			
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
			ddt.setSpedizioniere(new MagSpedizioniereDTO(1, "", "", "", ""));
			ddt.setLink_pdf(link_pdf);
			
			
			Session session=SessionFacotryDAO.get().openSession();
			session.beginTransaction();
			
			GestioneMagazzinoBO.saveDdt(ddt, session);
			
			session.getTransaction().commit();
			session.close();
			
			
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
		
		
		
		else if(action.equals("download")){
			
			try {
			String path= request.getParameter("link_pdf");
						
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
				
		   		 ex.printStackTrace();
		   				   		 
		   		request.setAttribute("error",STIException.callException(ex));
		   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		   	     dispatcher.forward(request,response);	
				
			}
		
		}
	}

}
