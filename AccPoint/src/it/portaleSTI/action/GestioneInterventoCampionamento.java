package it.portaleSTI.action;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AccessorioDTO;
import it.portaleSTI.DTO.AttivitaMilestoneDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DotazioneDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.PrenotazioneAccessorioDTO;
import it.portaleSTI.DTO.PrenotazioniDotazioneDTO;
import it.portaleSTI.DTO.StatoInterventoDTO;
import it.portaleSTI.DTO.TipoCampionamentoDTO;
import it.portaleSTI.DTO.TipologiaDotazioniDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAccessorioBO;
import it.portaleSTI.bo.GestioneCampionamentoBO;
import it.portaleSTI.bo.GestioneDotazioneBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

/**
 * Servlet implementation class GestioneIntervento
 */
@WebServlet(name = "gestioneInterventoCampionamento", urlPatterns = { "/gestioneInterventoCampionamento.do" })
public class GestioneInterventoCampionamento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneInterventoCampionamento() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  
		response.setCharacterEncoding("ISO-8859-1");
		response.setContentType("text/html; charset=ISO-8859-1");
		 
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		JsonObject myObj = new JsonObject();
		
		try 
		{
			
			
			String action=request.getParameter("action");
			UtenteDTO user = (UtenteDTO) request.getSession().getAttribute("userObj");
			
			if(action ==null || action.equals(""))
			{
				String idCommessa=request.getParameter("idCommessa");
				
				ArrayList<CommessaDTO> listaCommesse =(ArrayList<CommessaDTO>) request.getSession().getAttribute("listaCommesse");
				
				CommessaDTO comm=getCommessa(listaCommesse,idCommessa);
				
				request.getSession().setAttribute("commessa", comm);
				
				ArrayList<InterventoCampionamentoDTO> listaInterventi = (ArrayList<InterventoCampionamentoDTO>) GestioneCampionamentoBO.getListaInterventi(idCommessa,session);	
				
				request.getSession().setAttribute("listaInterventi", listaInterventi);
	
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneInterventoCampionamento.jsp");
		     	dispatcher.forward(request,response);
			}
			
	        
			if(action !=null && action.equals("salvaIntervento")){
		 
	          	String dataRange = request.getParameter("datarange");
	          	String[] selectTipologiaDotazione = request.getParameterValues("selectTipologiaDotazione");

	          	
	          	
	         	String date[] = dataRange.split(" - ");

	          	DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
	          	
	          	Date dataInizio = format.parse(date[0]);
	          	Date dataFine = format.parse(date[1]);
	          	
	          	
	          	String  selectTipologia  = request.getParameter("selectTipologiaDotazione");

	          	String  selectTipoCampionamento  = request.getParameter("selectTipoCampionamento");
	          	
	          	
	          	
	          	ArrayList<DotazioneDTO> listadotazioni = new ArrayList<DotazioneDTO>();
	         	Set<PrenotazioniDotazioneDTO> setDotazioni = new HashSet<PrenotazioniDotazioneDTO>();

	          	for (int j = 0; j < selectTipologiaDotazione.length; j++) {

					String idDotazione=selectTipologiaDotazione[j];
					
					DotazioneDTO dotazione = GestioneDotazioneBO.getDotazioneById(idDotazione, session);					
					listadotazioni.add(dotazione);
					
				    	PrenotazioniDotazioneDTO prenotazione = new PrenotazioniDotazioneDTO();
				    	prenotazione.setDataRichiesta(new Date());
				    	prenotazione.setPrenotatoDal(dataInizio);
				    prenotazione.setPrenotatoAl(dataFine);
				    prenotazione.setUserRichiedente(user);
				    prenotazione.setDotazione(dotazione);
				    	
				    setDotazioni.add(prenotazione);
					
					
					
				}

 				
 				ArrayList<AccessorioDTO> listaaccessoriNew = (ArrayList<AccessorioDTO>) request.getSession().getAttribute("listaAccessoriAssociati");
 
 				CommessaDTO comm=(CommessaDTO)request.getSession().getAttribute("commessa");
			    InterventoCampionamentoDTO intervento= new InterventoCampionamentoDTO();

			    
			    Set<PrenotazioneAccessorioDTO> set = new HashSet<PrenotazioneAccessorioDTO>();
			    
			    for (AccessorioDTO accessorio : listaaccessoriNew) {
			
			    		PrenotazioneAccessorioDTO prenotazione = new PrenotazioneAccessorioDTO();
			    		prenotazione.setAccessorio(accessorio);
			    		prenotazione.setData_inizio_prenotazione(dataInizio);
			    		prenotazione.setData_fine_prenotazione(dataFine);
			    		prenotazione.setQuantita(accessorio.getQuantitaNecessaria());
			    		set.add(prenotazione);
			    
			    }

			   
				
				CompanyDTO cmp =(CompanyDTO)request.getSession().getAttribute("usrCompany");
			    intervento.setID_COMMESSA(comm.getID_COMMESSA());
			    intervento.setListaPrenotazioniAccessori(set);
			    intervento.setListaPrenotazioniDotazioni(setDotazioni);
			    intervento.setDataCreazione(new Date());
			    intervento.setUser(user);
			    intervento.setStato(new StatoInterventoDTO());
			    intervento.setStatoUpload("N");

			    intervento.setDataInizio(dataInizio);
			    intervento.setDataFine(dataFine);
			    intervento.setIdAttivita(request.getSession().getAttribute("codiceAggregatore").toString());
			    
			    
			    
			    TipoCampionamentoDTO tipoCamp = new TipoCampionamentoDTO();
			    tipoCamp.setId(Integer.parseInt(selectTipoCampionamento));
			    intervento.setTipoCampionamento(tipoCamp);
			    
			    	GestioneCampionamentoBO.saveIntervento(intervento,session);
			

		    }
	
	if(action !=null && action.equals("nuovoIntervento")){
		 

		
	    CommessaDTO comm=(CommessaDTO)request.getSession().getAttribute("commessa");

	    String idAttivita=request.getParameter("idAttivita");
		
		ArrayList<AttivitaMilestoneDTO> listaAttivita = comm.getListaAttivita();
		
		ArrayList<AttivitaMilestoneDTO> attivitaAggregate = getAttivitaAggregate(listaAttivita,idAttivita);
		
		request.getSession().setAttribute("commessa", comm);
		
		HashMap<String, AccessorioDTO> listaAccessoriAggregati = new HashMap<String, AccessorioDTO>();
		
		for (AttivitaMilestoneDTO attivitaMilestoneDTO : attivitaAggregate) {
			ArrayList<AccessorioDTO> listaAccessoriAssociati = GestioneAccessorioBO.getListaAccessoriByArticolo(user.getCompany(), attivitaMilestoneDTO.getCodiceArticolo());
			
			for (AccessorioDTO accessorio : listaAccessoriAssociati) {
			
				if(listaAccessoriAggregati.containsKey(""+accessorio.getId())) {
					AccessorioDTO accessorioNew = listaAccessoriAggregati.get(""+accessorio.getId());
					int qnt = accessorioNew.getQuantitaNecessaria() + accessorio.getQuantitaNecessaria();
					accessorioNew.setQuantitaNecessaria(qnt);
					listaAccessoriAggregati.put(""+accessorio.getId(),accessorioNew);
				}else{
					listaAccessoriAggregati.put(""+accessorio.getId(),accessorio);
				}
			}
		}

		ArrayList<AccessorioDTO> listaAccessori = GestioneAccessorioBO.getListaAccessori(user.getCompany(), session);
		
		HashMap<String, TipologiaDotazioniDTO> listaTipologieAggregati = new HashMap<String, TipologiaDotazioniDTO>();
		
		for (AttivitaMilestoneDTO attivitaMilestoneDTO : attivitaAggregate) {
			ArrayList<TipologiaDotazioniDTO> listaTipologieAssociate = GestioneDotazioneBO.getListaTipologieDotazioniByArticolo(user.getCompany(),attivitaMilestoneDTO.getCodiceArticolo());
			
			for (TipologiaDotazioniDTO tipologia : listaTipologieAssociate) {
			
				if(listaTipologieAggregati.containsKey(""+tipologia.getId())) {

				}else{
					listaTipologieAggregati.put(""+tipologia.getId(),tipologia);
				}
			}
		}
		
		
		
		ArrayList<DotazioneDTO> listaDotazioni = GestioneDotazioneBO.getListaDotazioni(user.getCompany(), session);
		
		ArrayList<TipoCampionamentoDTO> listaTipoCampionamento = GestioneCampionamentoBO.getListaTipoCampionamento(session);

		JsonArray listaAccessoriJson = new JsonArray();
		JsonObject jsObjEmpty = new JsonObject();
		jsObjEmpty.addProperty("label", "Sccegli un valore");
		jsObjEmpty.addProperty("value", "");
		listaAccessoriJson.add(jsObjEmpty);
		for (AccessorioDTO accessorio : listaAccessori) {

			JsonObject jsObj = new JsonObject();
			jsObj.addProperty("label", accessorio.getNome().replace("'", " "));
			jsObj.addProperty("value", ""+accessorio.getId());
			jsObj.addProperty("qf", ""+accessorio.getQuantitaFisica());
			jsObj.addProperty("qp", ""+accessorio.getQuantitaPrenotata());
			jsObj.addProperty("descrizione", ""+accessorio.getDescrizione());
			listaAccessoriJson.add(jsObj);
		}
		
		ArrayList<AccessorioDTO> listaAccessoriAssociati = new ArrayList<AccessorioDTO>();
		listaAccessoriAssociati.addAll(listaAccessoriAggregati.values());

		ArrayList<TipologiaDotazioniDTO> listaTipologieAssociate = new ArrayList<TipologiaDotazioniDTO>();
		listaTipologieAssociate.addAll(listaTipologieAggregati.values());
		
		Gson gson = new Gson();

	    JsonElement element = 
	     gson.toJsonTree(listaAccessoriAssociati);

	    JsonArray listaAccessoriAssociatiJson = element.getAsJsonArray();
		
		
		request.getSession().setAttribute("listaAccessoriAggregati", listaAccessoriAggregati);
		request.getSession().setAttribute("listaTipologieAggregati", listaTipologieAggregati);
		
		request.getSession().setAttribute("listaAccessoriAssociati", listaAccessoriAssociati);
		request.getSession().setAttribute("listaTipologieAssociate", listaTipologieAssociate);

		
		
		request.getSession().setAttribute("listaAccessoriJson", listaAccessoriJson);
		request.getSession().setAttribute("listaAccessori", listaAccessori);
		request.getSession().setAttribute("listaAccessoriAssociatiJson", listaAccessoriAssociatiJson);
		request.getSession().setAttribute("listaTipoCampionamento", listaTipoCampionamento);
		request.getSession().setAttribute("listaDotazioni", listaDotazioni);
		request.getSession().setAttribute("attivitaAggregate", attivitaAggregate);
		request.getSession().setAttribute("codiceAggregatore", idAttivita);
		
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/nuovoInterventoCampionamento.jsp");
     	dispatcher.forward(request,response);
	    
	    
	}
	
	if(action !=null && action.equals("getDotazioni")){
		
		
	}
	
	if(action !=null && action.equals("updateQuantita"))
	{
		
		String idAccessorio=request.getParameter("idAccessorio");
		String quantita=request.getParameter("quantita");
		
		HashMap<String, AccessorioDTO> listaAccessoriAggregati = (HashMap<String, AccessorioDTO>)request.getSession().getAttribute("listaAccessoriAggregati");
		
		AccessorioDTO accessorio = listaAccessoriAggregati.get(idAccessorio);
		
		if(accessorio!=null) {
		
			accessorio.setQuantitaNecessaria(accessorio.getQuantitaNecessaria()+Integer.parseInt(quantita));
		}else {
			accessorio = GestioneAccessorioBO.getAccessorioById(idAccessorio, session);
			accessorio.setQuantitaNecessaria(Integer.parseInt(quantita));

		}
		
		listaAccessoriAggregati.put(idAccessorio, accessorio);
		
		ArrayList<AccessorioDTO> listaAccessoriAssociati = new ArrayList<AccessorioDTO>();
		listaAccessoriAssociati.addAll(listaAccessoriAggregati.values());

		
		Gson gson = new Gson();

	    JsonElement element = 
	     gson.toJsonTree(listaAccessoriAssociati);

	    JsonArray listaAccessoriAssociatiJson = element.getAsJsonArray();
	    
	    JsonElement element2 = 
	   	     gson.toJsonTree(accessorio);
	    
	    JsonObject accessorioJson = element2.getAsJsonObject();
	    
		request.getSession().setAttribute("listaAccessoriAggregati", listaAccessoriAggregati);
		request.getSession().setAttribute("listaAccessoriAssociati", listaAccessoriAssociati);
		request.getSession().setAttribute("listaAccessoriAssociatiJson", listaAccessoriAssociatiJson);

		  myObj.addProperty("success", true);
		  myObj.addProperty("accessorio", accessorioJson.toString());
		  
		  myObj.addProperty("messaggio", "Salvataggio OK");
		  
		

		  PrintWriter  out = response.getWriter();
		  out.print(myObj);

	}

	session.getTransaction().commit();
	session.close();	
		
		}catch (Exception ex) 
		{	
		  session.getTransaction().rollback();
		  ex.printStackTrace(); 
		  
		  myObj.addProperty("success", false);
		  myObj.addProperty("messaggio", "Errore creazione intervento");
		  
		  PrintWriter  out = response.getWriter();
		  out.print(myObj);
		}
		
	}

	private ArrayList<AttivitaMilestoneDTO> getAttivitaAggregate(ArrayList<AttivitaMilestoneDTO> listaAttivita,
			String idAttivita) {
		
		ArrayList<AttivitaMilestoneDTO> lista = new ArrayList<AttivitaMilestoneDTO>();
		for (AttivitaMilestoneDTO att : listaAttivita)
		{
			if(att.getCodiceAggregatore().equals(idAttivita)) {
				lista.add(att);
			}
		}
			
		return lista;
	}

	private AttivitaMilestoneDTO getAttivita(ArrayList<AttivitaMilestoneDTO> listaAttivita, String idAttivita) {
		for (AttivitaMilestoneDTO att : listaAttivita)
		{
			if(att.getId_riga() == Integer.parseInt(idAttivita))
			return att;
		}
			
		return null;
	}

	private CommessaDTO getCommessa(ArrayList<CommessaDTO> listaCommesse,String idCommessa) {

		for (CommessaDTO comm : listaCommesse)
		{
			if(comm.getID_COMMESSA().equals(idCommessa))
			return comm;
		}
			
		
		return null;
	}

}
