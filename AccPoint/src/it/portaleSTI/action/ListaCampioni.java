package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneAttivitaCampioneDAO;
import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AcAttivitaCampioneDTO;
import it.portaleSTI.DTO.AcTipoAttivitaCampioniDTO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.RegistroEventiDTO;
import it.portaleSTI.DTO.TipoCampioneDTO;
import it.portaleSTI.DTO.TipoEventoRegistroDTO;
import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateSchedaScadenzarioCampioni;
import it.portaleSTI.bo.GestioneAttivitaCampioneBO;
import it.portaleSTI.bo.GestioneCampioneBO;
import it.portaleSTI.bo.GestioneCompanyBO;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="listaCampioni" , urlPatterns = { "/listaCampioni.do" })

public class ListaCampioni extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaCampioni() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;

	
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		response.setContentType("text/html");
	
		
		try {
		//	GestioneAttivitaCampioneDAO.mergeTabelleAttivita(session);
		//	GestioneAttivitaCampioneDAO.aggiornaCampioni(session);
		//	GestioneAttivitaCampioneDAO.mergeRenameAllegati(session);
		//	GestioneAttivitaCampioneDAO.aggiornaObsolete(session);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
		
		String action = request.getParameter("action");
		int idCompany=0;
		
		CompanyDTO cmp=(CompanyDTO)request.getSession().getAttribute("usrCompany");

		if(cmp.getId()==4132) 
		{ 

			idCompany=0;
		}
		else 
		{
			idCompany=cmp.getId();
		}
		try 
		{
			//	String myCMP =  request.getParameter("p");
			if(action==null) {
	
				String date =request.getParameter("date");
				String tipo_data =request.getParameter("tipo_data");
				//String manutenzione =request.getParameter("manutenzione");
				String verificazione = (String) request.getSession().getAttribute("verificazione");
				//String tipo_evento = request.getParameter("tipo_evento");
				String campioni_verificazione = request.getParameter("campioni_verificazione");
				String lat = request.getParameter("lat");
	
				ArrayList<CampioneDTO> listaCampioni=new ArrayList<CampioneDTO>();
	
				if(date==null || date.equals(""))
				{
					if(campioni_verificazione!=null) {
						listaCampioni =GestioneCampioneDAO.getListaCampioniVerificazione(session);	
						
	
					}else {
						listaCampioni =GestioneCampioneDAO.getListaCampioni(null,idCompany, session);
						
					}
					
				}
				else
				{
					if(tipo_data!=null) {
						if(date.length()>=10)
						{
						
							if(verificazione==null) {
								verificazione = "0";
							}
							
							if(lat==null) {
								lat = "";
							}
							
							listaCampioni =GestioneAttivitaCampioneBO.getListaCampioniPerData(date.substring(0,10), tipo_data , verificazione, lat, session);
						}
					}
//					else if(manutenzione!= null) {
//						if(date.length()>=10)
//						{						
//							listaCampioni =GestioneAttivitaCampioneBO.getListaCampioniPerData(date.substring(0,10), null, null, 0);
//						}
//					}
//					else if(verificazione!=null) {
//						if(date.length()>=10)
//						{						
//							listaCampioni =GestioneAttivitaCampioneBO.getListaCampioniPerData(date.substring(0,10), tipo_data_lat, tipo_evento, Integer.parseInt(verificazione));
//						}
//					}
//					
//					
//					else {
//						if(date.length()>=10)
//						{
//							//listaCampioni =GestioneCampioneDAO.getListaCampioni(date.substring(0,10),idCompany, session);
//							listaCampioni =GestioneAttivitaCampioneBO.getListaCampioniPerData(date.substring(0,10), tipo_data_lat, tipo_evento, 0);
//						}
//					}
					
				}
				
				
				Integer[] max_codici = GestioneCampioneBO.getProgressivoCampione();

				ArrayList<CompanyDTO> lista_company = GestioneCompanyBO.getAllCompany(session);

				 ArrayList<TipoGrandezzaDTO> tgArr = GestioneTLDAO.getListaTipoGrandezza(session);
			        JsonArray tgArrJson = new JsonArray();
			        JsonObject umArrJson = new JsonObject();
			        JsonObject jsObjDefault = new JsonObject();
			        jsObjDefault.addProperty("label", "Seleziona");
			        jsObjDefault.addProperty("value", "0");
					tgArrJson.add(jsObjDefault);
			        for (Iterator iterator = tgArr.iterator(); iterator.hasNext();) {
						TipoGrandezzaDTO tipoGrandezzaDTO = (TipoGrandezzaDTO) iterator.next();
						JsonObject jsObj = new JsonObject();
						jsObj.addProperty("label", tipoGrandezzaDTO.getNome().replace("'", " "));
						jsObj.addProperty("value", ""+tipoGrandezzaDTO.getId());
	
						JsonArray umArrJsonChild = new JsonArray();
						ArrayList<UnitaMisuraDTO> list = new ArrayList<UnitaMisuraDTO>(tipoGrandezzaDTO.getListaUM());
						Collections.sort( list, new Comparator<UnitaMisuraDTO>() {
				            public int compare(UnitaMisuraDTO v1, UnitaMisuraDTO v2) {
				                return v1.getNome().compareTo(v2.getNome());
				            }
				        });
				        for (Iterator iterator2 = list.iterator(); iterator2.hasNext();) {
							UnitaMisuraDTO unitaMisuraDTO = (UnitaMisuraDTO) iterator2.next();
							JsonObject jsObj2 = new JsonObject();
							jsObj2.addProperty("label", unitaMisuraDTO.getNome().replace("'", " "));
							jsObj2.addProperty("value", ""+unitaMisuraDTO.getId());
							umArrJsonChild.add(jsObj2);
						}
					        
				        umArrJson.add(""+tipoGrandezzaDTO.getId(), umArrJsonChild);
					     tgArrJson.add(jsObj);
					}
			        
			        
		
			        request.getSession().setAttribute("listaTipoGrandezza",tgArrJson);
			        request.getSession().setAttribute("listaUnitaMisura",umArrJson);
			        request.getSession().setAttribute("max_codice_sti",max_codici[0]);
			        request.getSession().setAttribute("max_codice_cdt",max_codici[1]);
			        request.getSession().setAttribute("lista_company", lista_company);
	
	
				SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				ArrayList<TipoCampioneDTO> listaTipoCampione= GestioneTLDAO.getListaTipoCampione(session);
				request.getSession().setAttribute("listaTipoCampione",listaTipoCampione);
				request.getSession().setAttribute("listaCampioni",listaCampioni);
	
				String rilievi = request.getParameter("rilievi");
				
				
//				ArrayList<RegistroEventiDTO> lista_eventi = GestioneCampioneDAO.getListaEventiNonSti(session);
//				
//				for (RegistroEventiDTO r : lista_eventi) {
//					AcAttivitaCampioneDTO attivita = new AcAttivitaCampioneDTO();
//					
//					attivita.setAllegato(r.getAllegato());
//					attivita.setCampione(r.getCampione());
//					attivita.setCampo_sospesi(r.getCampo_sospesi());
//					attivita.setData(r.getData_evento());
//					attivita.setData_scadenza(r.getData_scadenza());
//					attivita.setDescrizione_attivita(r.getDescrizione());
//					attivita.setDisabilitata(0);
//					attivita.setObsoleta(r.getObsoleta());
//					attivita.setOperatore(r.getOperatore());
//					attivita.setStato(r.getStato());
//					if(r.getTipo_evento().getId()==2) {
//						attivita.setTipo_attivita(new AcTipoAttivitaCampioniDTO(3, ""));
//					}else {
//						attivita.setTipo_attivita(new AcTipoAttivitaCampioniDTO(r.getTipo_evento().getId(), ""));
//					}
//					attivita.setTipo_manutenzione(r.getTipo_manutenzione().getId());
//					
//				//	session.save(attivita);
//				}
				
				
				session.getTransaction().commit();
				session.close();
				
				if(rilievi != null && rilievi.equals("true")) {
					String id_rilievo = request.getParameter("id_rilievo");
					request.getSession().setAttribute("id_rilievo",id_rilievo);
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaCampioniRilievi.jsp");
			     	dispatcher.forward(request,response);
				}else {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaCampioni.jsp");
			     	dispatcher.forward(request,response);
				}
			}
			
			else if(action!=null && action.equals("campioni_scadenza")) {
				
				ajax = true;
				
				String data_start = request.getParameter("data_start");
				String data_end = request.getParameter("data_end");
				String tipo = request.getParameter("tipo");
				String verificazione = request.getParameter("verificazione");
				
				boolean lat = false;
				if(tipo!=null && tipo.equals("CDT")) {
					lat = true;
				}
				
				if(verificazione == null || !verificazione.equals("1")) {
					verificazione = "0";
				}
				
				PrintWriter out = response.getWriter();
							
				JsonArray listaCampioni = GestioneCampioneBO.getCampioniScadenzaDate(data_start, data_end, lat, cmp.getId(), Integer.parseInt(verificazione), session);
			
				JsonArray campioni = (JsonArray) listaCampioni.get(0);
				JsonArray descrizioni = (JsonArray)listaCampioni.get(1);
				JsonArray date = (JsonArray)listaCampioni.get(2);
				
				if(campioni.size()>0) {
					Type listType = new TypeToken<ArrayList<CampioneDTO>>(){}.getType();
					ArrayList<CampioneDTO> listaCamp = new Gson().fromJson(campioni, listType);
					
					listType = new TypeToken<ArrayList<Integer>>(){}.getType();
					ArrayList<Integer> listaDesc = new Gson().fromJson(descrizioni, listType);
					
					listType = new TypeToken<ArrayList<String>>(){}.getType();
					ArrayList<String> listaDate = new Gson().fromJson(date, listType);				
					
					new CreateSchedaScadenzarioCampioni(listaCamp, listaDesc, listaDate, data_start, data_end);
					
					myObj.addProperty("success", true);
					out.print(myObj);
					
				}else {
					
					myObj.addProperty("success", false);
					myObj.addProperty("messaggio", "Nessun campione in scadenza nel periodo selezionato!");
					out.print(myObj);
				}
				
				session.getTransaction().commit();
				session.close();
			}
			else if(action.equals("download_scadenzario")) {
				
				File file = new File(Costanti.PATH_FOLDER+"//ScadenzarioCampioni//SchedaListacampioni.pdf");
				
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
				    
					session.getTransaction().commit();
					session.close();
				
			}
			

		} 
		catch (Exception ex) {
			session.getTransaction().rollback();
			session.close();
			ex.printStackTrace();
			
			if(ajax) {
				
				PrintWriter out = response.getWriter();
				ex.printStackTrace();
	        	
	        	request.getSession().setAttribute("exception", ex);
	        	myObj = STIException.getException(ex);
	        	out.print(myObj);
        	}else {
		     request.setAttribute("error",STIException.callException(ex));
		     request.getSession().setAttribute("exception", ex);
			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
			 dispatcher.forward(request,response);
        	}
		}
		 
	}

}
