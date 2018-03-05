package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneStrumentoBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

/**
 * Servlet implementation class ListaStrumentiSede
 */
@WebServlet(name= "/listaStrumentiSedeNew", urlPatterns = { "/listaStrumentiSedeNew.do" })
public class ListaStrumentiSedeNew extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaStrumentiSedeNew() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		response.setContentType("text/html");
		
		 
		try {
			
			String param = request.getParameter("idSede");
			
			
			
			if(param!=null && param.length()>0 && !param.equals("null"))
			{
				
				String[] tmp=param.split(";");
				
				String idSede;
				String idCliente=tmp[1];
				
				if(tmp[0]!=null && !tmp[0].equalsIgnoreCase("null"))
				{
					idSede=tmp[0].split("_")[0];
				}
				else
				{
					idSede="0";
				}
				
				System.out.println("id_Cliente: "+idCliente +"\nid_Sede: "+idSede);
				
			
				CompanyDTO idCompany=(CompanyDTO)request.getSession().getAttribute("usrCompany");
				
				if(idCompany!=null)
				{
					
				ArrayList<TipoStrumentoDTO> listaTipoStrumento = GestioneTLDAO.getListaTipoStrumento();
				ArrayList<TipoRapportoDTO> listaTipoRapporto = GestioneTLDAO.getListaTipoRapporto();
				ArrayList<StatoStrumentoDTO> listaStatoStrumento = GestioneTLDAO.getListaStatoStrumento();
				ArrayList<LuogoVerificaDTO> listaLuogoVerifica = GestioneTLDAO.getListaLuogoVerifica();
				ArrayList<ClassificazioneDTO> listaClassificazione = GestioneTLDAO.getListaClassificazione();
			//	ArrayList<StrumentoDTO> listaStrumentiPerSede=GestioneStrumentoBO.getListaStrumentiPerGrafici(idCliente,idSede,idCompany.getId()); 
				ArrayList<StrumentoDTO> listaStrumentiPerSede=GestioneStrumentoBO.getListaStrumentiPerSediAttiviNEW(idCliente,idSede,idCompany.getId(), session); 
				
				
				HashMap<String,Integer> statoStrumenti = new HashMap<String,Integer>();
				HashMap<String,Integer> denominazioneStrumenti = new HashMap<String,Integer>();
				HashMap<String,Integer> tipoStrumenti = new HashMap<String,Integer>();
				HashMap<String,Integer> freqStrumenti = new HashMap<String,Integer>();
				HashMap<String,Integer> repartoStrumenti = new HashMap<String,Integer>();
				HashMap<String,Integer> utilizzatoreStrumenti = new HashMap<String,Integer>();
				
//				for (StatoStrumentoDTO statoStrumento : listaStatoStrumento) {
//					statoStrumenti.put(statoStrumento.getNome(), 0);
//
//				}
//				for (TipoStrumentoDTO tipoStrumento : listaTipoStrumento) {
//					tipoStrumenti.put(tipoStrumento.getNome(), 0);
//
//				}

				for(StrumentoDTO strumentoDTO: listaStrumentiPerSede) {

					if(statoStrumenti.containsKey(strumentoDTO.getStato_strumento().getNome())) {
						Integer iter = statoStrumenti.get(strumentoDTO.getStato_strumento().getNome());
						iter++;
						statoStrumenti.put(strumentoDTO.getStato_strumento().getNome(), iter);
					}else {
						statoStrumenti.put(strumentoDTO.getStato_strumento().getNome(), 1);
					}
					
					if(tipoStrumenti.containsKey(strumentoDTO.getTipo_strumento().getNome())) {
						Integer iter = tipoStrumenti.get(strumentoDTO.getTipo_strumento().getNome());
						iter++;
						tipoStrumenti.put(strumentoDTO.getTipo_strumento().getNome(), iter);
					}else {
						
						tipoStrumenti.put(strumentoDTO.getTipo_strumento().getNome(), 1);
						
					}
				
					if(denominazioneStrumenti.containsKey(strumentoDTO.getDenominazione())) {
						Integer iter = denominazioneStrumenti.get(strumentoDTO.getDenominazione());
						iter++;
						denominazioneStrumenti.put(strumentoDTO.getDenominazione(), iter);
					}else {
						
						denominazioneStrumenti.put(strumentoDTO.getDenominazione(), 1);
						
					}
					
					if(strumentoDTO.getFrequenza() != 0) {
						String freqKey = strumentoDTO.getFrequenza()+"mesi";
						if(strumentoDTO.getFrequenza()==1) {
							freqKey = strumentoDTO.getFrequenza()+"mese";
						}
						
						if(freqStrumenti.containsKey(""+strumentoDTO.getFrequenza())) {
							
							Integer iter = freqStrumenti.get(""+strumentoDTO.getFrequenza());
							iter++;
							
							
							
							freqStrumenti.put(freqKey, iter);
						}else {
							
							freqStrumenti.put(freqKey, 1);
							
						}
					}
					
					if(repartoStrumenti.containsKey(strumentoDTO.getReparto())) {
						Integer iter = repartoStrumenti.get(strumentoDTO.getReparto());
						iter++;
						repartoStrumenti.put(strumentoDTO.getReparto(), iter);
					}else {
						
						repartoStrumenti.put(strumentoDTO.getReparto(), 1);
						
					}
					if(utilizzatoreStrumenti.containsKey(strumentoDTO.getUtilizzatore())) {
						Integer iter = utilizzatoreStrumenti.get(strumentoDTO.getUtilizzatore());
						iter++;
						utilizzatoreStrumenti.put(strumentoDTO.getUtilizzatore(), iter);
					}else {
						
						utilizzatoreStrumenti.put(strumentoDTO.getUtilizzatore(), 1);
						
					}

				
				}
				Gson gson = new Gson(); 
				
				request.getSession().setAttribute("statoStrumentiJson", gson.toJsonTree(statoStrumenti).toString());
				request.getSession().setAttribute("tipoStrumentiJson", gson.toJsonTree(tipoStrumenti).toString());
				request.getSession().setAttribute("denominazioneStrumentiJson", gson.toJsonTree(denominazioneStrumenti).toString());
				request.getSession().setAttribute("freqStrumentiJson", gson.toJsonTree(freqStrumenti).toString());
				request.getSession().setAttribute("repartoStrumentiJson", gson.toJsonTree(repartoStrumenti).toString());
				request.getSession().setAttribute("utilizzatoreStrumentiJson", gson.toJsonTree(utilizzatoreStrumenti).toString());
				
				request.getSession().setAttribute("listaStrumenti", listaStrumentiPerSede);

				
				
				PrintWriter out = response.getWriter();
			
				
		        JsonObject myObj = new JsonObject();

		        JsonElement obj = gson.toJsonTree(listaStrumentiPerSede);
		       
		        if(listaStrumentiPerSede!=null && listaStrumentiPerSede.size()>0){
		            myObj.addProperty("success", true);
		        }
		        else {
		            myObj.addProperty("success", false);
		        }


		        myObj.add("dataInfo", obj);
		        
		        request.getSession().setAttribute("myObj",myObj);
		        request.getSession().setAttribute("id_Cliente",idCliente);
		        request.getSession().setAttribute("id_Sede",idSede);
		        request.getSession().setAttribute("listaTipoStrumento",listaTipoStrumento);
		        request.getSession().setAttribute("listaStatoStrumento",listaStatoStrumento);
		        request.getSession().setAttribute("listaTipoRapporto",listaTipoRapporto);
		        request.getSession().setAttribute("listaLuogoVerifica",listaLuogoVerifica);
		        request.getSession().setAttribute("listaClassificazione",listaClassificazione);
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaStrumentiSede.jsp");
			     dispatcher.forward(request,response);
		        
		        
				} 
			}
		session.getTransaction().commit();
		session.close();
		}
		
		
		catch(Exception ex)
    	{
		 session.getTransaction().rollback();
   		 ex.printStackTrace();
   	     request.setAttribute("error",STIException.callException(ex));
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	} 
		
	}

}
