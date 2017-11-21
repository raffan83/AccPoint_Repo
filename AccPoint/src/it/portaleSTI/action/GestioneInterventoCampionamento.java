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
import it.portaleSTI.bo.GestioneCommesseBO;
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
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
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
import com.google.gson.reflect.TypeToken;


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
				
			//	ArrayList<CommessaDTO> listaCommesse =(ArrayList<CommessaDTO>) request.getSession().getAttribute("listaCommesse");
				
				CommessaDTO comm=GestioneCommesseBO.getCommessaById(idCommessa);
				
				request.getSession().setAttribute("commessa", comm);
				
				ArrayList<InterventoCampionamentoDTO> listaInterventi = (ArrayList<InterventoCampionamentoDTO>) GestioneCampionamentoBO.getListaInterventi(idCommessa,session);	
				
				JsonArray listaInterventiJson = new JsonArray();
				for (InterventoCampionamentoDTO interventoCampionamentoDTO : listaInterventi) {
					JsonObject interventoJson = new JsonObject();
					interventoJson.addProperty("id", ""+interventoCampionamentoDTO.getId());
					interventoJson.addProperty("idAttivita", ""+interventoCampionamentoDTO.getIdAttivita());
					
					listaInterventiJson.add(interventoJson);
				}
				
				
				request.getSession().setAttribute("listaInterventi", listaInterventi);
				request.getSession().setAttribute("listaInterventiJson", listaInterventiJson);
	
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneInterventoCampionamento.jsp");
		     	dispatcher.forward(request,response);
			}
			
	        
			if(action !=null && action.equals("salvaIntervento")){
		 
				String dataJson = request.getParameter("data");
				JsonElement jelement = new JsonParser().parse(dataJson);
				
				
				
				String dataRange = jelement.getAsJsonObject().get("date").toString().replaceAll("\"", "");
				JsonObject dotazioniJson = jelement.getAsJsonObject().get("dotazioni").getAsJsonObject();
	          	
				//String[] selectTipologiaDotazione = request.getParameterValues("selectTipologiaDotazione");


	          	
	          	
	         	String date[] = dataRange.split(" - ");

	          	DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
	          	
	          	Date dataInizio = format.parse(date[0]);
	          	Date dataFine = format.parse(date[1]);
	          	
	          	


	          	String selectTipoCampionamento = jelement.getAsJsonObject().get("selectTipoCampionamento").toString().replaceAll("\"", "");
	          	
	          	CommessaDTO comm=(CommessaDTO)request.getSession().getAttribute("commessa");
			    InterventoCampionamentoDTO intervento= new InterventoCampionamentoDTO();
	          	
	          	ArrayList<DotazioneDTO> listadotazioni = new ArrayList<DotazioneDTO>();
	         	Set<PrenotazioniDotazioneDTO> setDotazioni = new HashSet<PrenotazioniDotazioneDTO>();


	         	Set<Map.Entry<String, JsonElement>> entrySet = dotazioniJson.entrySet();
	         	
	         	for(Map.Entry<String, JsonElement> entry : entrySet) {
	         	    String idDotazione = entry.getValue().toString().replaceAll("\"", "");
	         	    
					DotazioneDTO dotazione = GestioneDotazioneBO.getDotazioneById(idDotazione, session);					
					listadotazioni.add(dotazione);
					
				    	PrenotazioniDotazioneDTO prenotazione = new PrenotazioniDotazioneDTO();
				    	prenotazione.setDataRichiesta(new Date());
				    	prenotazione.setPrenotatoDal(dataInizio);
				    prenotazione.setPrenotatoAl(dataFine);
				    prenotazione.setUserRichiedente(user);
				    prenotazione.setDotazione(dotazione);
				    prenotazione.setIntervento(intervento);
				    setDotazioni.add(prenotazione);
				}

	         	
 				
	         	HashMap<String, ArrayList<AccessorioDTO>> listaaccessoriNew = (HashMap<String, ArrayList<AccessorioDTO>>) request.getSession().getAttribute("listaAccessoriAssociati");
 
	         	String idAtt = "";
 				
	         	Iterator itAgg1 = listaaccessoriNew.entrySet().iterator();
	         	 Set<PrenotazioneAccessorioDTO> set = new HashSet<PrenotazioneAccessorioDTO>();
	         	 int i = 0;
		    		 while (itAgg1.hasNext()) {
		    			
		    			 Map.Entry pair = (Map.Entry)itAgg1.next();

		    			 if(i > 0) {
		    				 idAtt += "|"+pair.getKey();
		    			 }else {
		    				 idAtt += pair.getKey();
		    			 }
		    			i++;	 
		    			 ArrayList<AccessorioDTO> listaAccessori = (ArrayList<AccessorioDTO>) pair.getValue();
		 			    
		 			    for (AccessorioDTO accessorio : listaAccessori) {
		 			
		 			    		PrenotazioneAccessorioDTO prenotazione = new PrenotazioneAccessorioDTO();
		 			    		
		 			    		int quantitaPrenotata = accessorio.getQuantitaPrenotata()+accessorio.getQuantitaNecessaria();
		 			    		int quantitaDisponibile = accessorio.getQuantitaFisica()-accessorio.getQuantitaNecessaria();
		 			    		
		 			    		accessorio.setQuantitaPrenotata(quantitaPrenotata);	
		 			    		accessorio.setQuantitaFisica(quantitaDisponibile);
		 			    		accessorio.setQuantitaNecessaria(0);
		 			    		
		 			    		prenotazione.setAccessorio(accessorio);
		 			    		prenotazione.setData_inizio_prenotazione(dataInizio);
		 			    		prenotazione.setData_fine_prenotazione(dataFine);
		 			    		prenotazione.setQuantita(accessorio.getQuantitaNecessaria());
		 			    		prenotazione.setUser(user);
		 			    		prenotazione.setIntervento(intervento);
		 			    		set.add(prenotazione);
		 			    
		 			    }

		    		 
		    		 }
			    
			  
			   
				
				CompanyDTO cmp =(CompanyDTO)request.getSession().getAttribute("usrCompany");
			    intervento.setID_COMMESSA(comm.getID_COMMESSA());
			    intervento.setListaPrenotazioniAccessori(set);
			    intervento.setListaPrenotazioniDotazioni(setDotazioni);
			    intervento.setDataCreazione(new Date());
			    intervento.setUser(user);
			    intervento.setStato(new StatoInterventoDTO());
			    intervento.setStatoUpload("N");
			    intervento.setIdAttivita(idAtt);
			    intervento.setDataInizio(dataInizio);
			    intervento.setDataFine(dataFine);
			    intervento.setIdAttivita("");
			    
			    TipoCampionamentoDTO tipoCamp = new TipoCampionamentoDTO();
			    tipoCamp.setId(Integer.parseInt(selectTipoCampionamento));
			    intervento.setTipoCampionamento(tipoCamp);
			    
			    String filename = GestioneStrumentoBO.creaPacchettoCampionamento(comm.getID_ANAGEN(),comm.getK2_ANAGEN_INDR(),cmp,comm.getID_ANAGEN_NOME(),session,intervento);
			    
			    intervento.setNomePack(filename);
			   
			    
			    GestioneCampionamentoBO.saveIntervento(intervento,session);
			  	myObj.addProperty("success", true);

				  
				  myObj.addProperty("messaggio", "Salvataggio Effettuato");
				  
				

				  PrintWriter  out = response.getWriter();
				  out.print(myObj);


		    }
	
	if(action !=null && action.equals("nuovoIntervento")){
		 

		
	    CommessaDTO comm=(CommessaDTO)request.getSession().getAttribute("commessa");
	    String jsonArrString=request.getParameter("ids");
	    	Gson gson = new Gson();

	    	
	    	JsonElement jelem = gson.fromJson(jsonArrString, JsonElement.class);
	    	JsonArray jobjArray = jelem.getAsJsonArray();
	    	



	    ArrayList<String> aggregatiArrayList = new Gson().fromJson(jelem, ArrayList.class);
	    	

	   
	    
		
	    ArrayList<AttivitaMilestoneDTO> listaAttivita = comm.getListaAttivita();
		
		HashMap<String,ArrayList<AttivitaMilestoneDTO>> attivitaAggregate = getAttivitaAggregate(listaAttivita,aggregatiArrayList);
		
		request.getSession().setAttribute("commessa", comm);
		
		Iterator itAgg1 = attivitaAggregate.entrySet().iterator();
		HashMap<String, HashMap<String, AccessorioDTO>> listaAccessoriAggregatiCampionamenti = new HashMap<String, HashMap<String, AccessorioDTO>>();
		HashMap<String, ArrayList<AccessorioDTO>> listaAccessoriAssociatix = new HashMap<String, ArrayList<AccessorioDTO>>();
		
		 while (itAgg1.hasNext()) {
		        Map.Entry pair = (Map.Entry)itAgg1.next();
		        	ArrayList<AttivitaMilestoneDTO> attivitaAggregata = (ArrayList<AttivitaMilestoneDTO>) pair.getValue();
				HashMap<String, AccessorioDTO> listaAccessoriAggregati = new HashMap<String, AccessorioDTO>();
				for (AttivitaMilestoneDTO attivitaMilestoneDTO : attivitaAggregata) {
					ArrayList<AccessorioDTO> listaAccessoriAssociati = GestioneAccessorioBO.getListaAccessoriByArticolo(user.getCompany(), attivitaMilestoneDTO.getCodiceArticolo());
					
					for (AccessorioDTO accessorio : listaAccessoriAssociati) {
						System.out.println("xxx - >"+accessorio.getId());
						if(listaAccessoriAggregati.containsKey(""+accessorio.getId())) {
							AccessorioDTO accessorioNew = listaAccessoriAggregati.get(""+accessorio.getId());
							int qnt = accessorioNew.getQuantitaNecessaria() + accessorio.getQuantitaNecessaria();
							accessorioNew.setQuantitaNecessaria(qnt);
							listaAccessoriAggregati.put(""+accessorio.getId(),accessorioNew);
							
						}else{
							listaAccessoriAggregati.put(""+accessorio.getId(),accessorio);
 						}
					}
					
					ArrayList<AccessorioDTO> arrAss = new ArrayList<AccessorioDTO>(listaAccessoriAggregati.values());
					
					listaAccessoriAssociatix.put((String) pair.getKey(), arrAss);
				}
				listaAccessoriAggregatiCampionamenti.put((String) pair.getKey(), listaAccessoriAggregati);
				
				 //itAgg1.remove(); // avoids a ConcurrentModificationException
		 }
		ArrayList<AccessorioDTO> listaAccessori = GestioneAccessorioBO.getListaAccessori(user.getCompany(), session);
		
		
		
		
		Iterator itAgg2 = attivitaAggregate.entrySet().iterator();
		 HashMap<String, TipologiaDotazioniDTO> listaTipologieAggregati = new HashMap<String, TipologiaDotazioniDTO>();
		 while (itAgg2.hasNext()) {
		        Map.Entry pair = (Map.Entry)itAgg2.next();
		       
		        ArrayList<AttivitaMilestoneDTO> attivitaAggregata = (ArrayList<AttivitaMilestoneDTO>) pair.getValue();

				for (AttivitaMilestoneDTO attivitaMilestoneDTO : attivitaAggregata) {
					ArrayList<TipologiaDotazioniDTO> listaTipologieAssociate = GestioneDotazioneBO.getListaTipologieDotazioniByArticolo(user.getCompany(),attivitaMilestoneDTO.getCodiceArticolo());
					
					for (TipologiaDotazioniDTO tipologia : listaTipologieAssociate) {
					
						if(listaTipologieAggregati.containsKey(""+tipologia.getId())) {
		
						}else{
							listaTipologieAggregati.put(""+tipologia.getId(),tipologia);
						}
					}
				}
				 //itAgg1.remove(); // avoids a ConcurrentModificationException
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
			jsObj.addProperty("idTipologia", ""+accessorio.getTipologia().getId());
			jsObj.addProperty("componibile", ""+accessorio.getComponibile());
			jsObj.addProperty("idCompobnibili", ""+accessorio.getIdComponibili());
			jsObj.addProperty("capacita", ""+accessorio.getCapacita());
			jsObj.addProperty("um", ""+accessorio.getUnitaMisura());
			jsObj.addProperty("nome", accessorio.getNome());
			jsObj.addProperty("descrizione", ""+accessorio.getDescrizione());
			jsObj.addProperty("id", ""+accessorio.getId());
			listaAccessoriJson.add(jsObj);
		}
		


		ArrayList<TipologiaDotazioniDTO> listaTipologieAssociate = new ArrayList<TipologiaDotazioniDTO>();
		listaTipologieAssociate.addAll(listaTipologieAggregati.values());
		

	    JsonElement element = 
	     gson.toJsonTree(listaAccessoriAssociatix);

	    JsonObject listaAccessoriAssociatiJson = element.getAsJsonObject();
		
		ArrayList<TipologiaDotazioniDTO> listaTipologieDotazioni = GestioneDotazioneBO.getListaTipologieDotazioni(session);
		request.getSession().setAttribute("listaTipologieDotazioni", listaTipologieDotazioni);
		
		JsonElement elementTipologieDotazioni = 
			     gson.toJsonTree(listaTipologieDotazioni);

	    JsonArray listaTipologieDotazioniJson = elementTipologieDotazioni.getAsJsonArray();
	    request.getSession().setAttribute("listaTipologieDotazioniJson", listaTipologieDotazioniJson);
			    
		request.getSession().setAttribute("listaAccessoriAggregati", listaAccessoriAggregatiCampionamenti);
		request.getSession().setAttribute("listaTipologieAggregati", listaTipologieAggregati);
		
		request.getSession().setAttribute("listaAccessoriAssociati", listaAccessoriAssociatix);
		request.getSession().setAttribute("listaTipologieAssociate", listaTipologieAssociate);

		
		
		request.getSession().setAttribute("listaAccessoriJson", listaAccessoriJson);
		request.getSession().setAttribute("listaAccessori", listaAccessori);
		request.getSession().setAttribute("listaAccessoriAssociatiJson", listaAccessoriAssociatiJson);
		request.getSession().setAttribute("listaTipoCampionamento", listaTipoCampionamento);
		request.getSession().setAttribute("listaDotazioni", listaDotazioni);
		request.getSession().setAttribute("attivitaAggregate", attivitaAggregate);

		


		JsonArray listaDotazioniJson = new JsonArray();
		for (DotazioneDTO dotazione : listaDotazioni) {
			JsonObject obj = new JsonObject();
			obj.addProperty("id", ""+dotazione.getId());
			obj.addProperty("idTipologia", ""+dotazione.getTipologia().getId());
			obj.addProperty("modello", dotazione.getModello());
			obj.addProperty("matricola", dotazione.getMatricola());
			obj.addProperty("targa", dotazione.getTarga());
			obj.addProperty("tipologiaCodice", dotazione.getTipologia().getCodice());
			obj.addProperty("tipologiaDescrizione", dotazione.getTipologia().getDescrizione());
			listaDotazioniJson.add(obj);;
		}
		request.getSession().setAttribute("listaDotazioniJson", listaDotazioniJson);

		
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/nuovoInterventoCampionamento.jsp");
     	dispatcher.forward(request,response);
	    
	    
	}
	
	if(action !=null && action.equals("getDotazioni")){
		
		
	}
	
	if(action !=null && action.equals("updateQuantita"))
	{
		
		String idAccessorio=request.getParameter("idAccessorio");
		String quantita=request.getParameter("quantita");
		String codiceCampionamento=request.getParameter("campionamento");
		
		HashMap<String, HashMap<String, AccessorioDTO>> listaAccessoriAggregatiCampionamento = (HashMap<String, HashMap<String, AccessorioDTO>>)request.getSession().getAttribute("listaAccessoriAggregati");
		
		HashMap<String, ArrayList<AccessorioDTO>> listaAccessoriAssociatiHash = (HashMap<String, ArrayList<AccessorioDTO>>) request.getSession().getAttribute("listaAccessoriAssociati");

		
		HashMap<String, AccessorioDTO> listaAccessoriAggregati = listaAccessoriAggregatiCampionamento.get(codiceCampionamento);

		
		AccessorioDTO accessorio = listaAccessoriAggregati.get(idAccessorio);
		
		if(accessorio!=null) {
		
			accessorio.setQuantitaNecessaria(accessorio.getQuantitaNecessaria()+Integer.parseInt(quantita));
		}else {
			accessorio = GestioneAccessorioBO.getAccessorioById(idAccessorio, session);
			accessorio.setQuantitaNecessaria(Integer.parseInt(quantita));

		}
		
		ArrayList<AccessorioDTO> listaAcc = listaAccessoriAssociatiHash.get(codiceCampionamento);
		
		for (AccessorioDTO accessorioDTO : listaAcc) {
			if(accessorioDTO.getId() == accessorio.getId()) {
				accessorioDTO = accessorio;
			}
		}
		
		listaAccessoriAssociatiHash.put(codiceCampionamento, listaAcc);
		listaAccessoriAggregati.put(idAccessorio, accessorio);
		
		ArrayList<AccessorioDTO> listaAccessoriAssociati = new ArrayList<AccessorioDTO>();
		listaAccessoriAssociati.addAll(listaAccessoriAggregati.values());

		listaAccessoriAggregatiCampionamento.put(codiceCampionamento, listaAccessoriAggregati);
		
		Gson gson = new Gson();

	    JsonElement element = 
	     gson.toJsonTree(listaAccessoriAssociati);

	    JsonArray listaAccessoriAssociatiJson = element.getAsJsonArray();
	    
	    JsonElement element2 = 
	   	     gson.toJsonTree(accessorio);
	    
	    JsonObject accessorioJson = element2.getAsJsonObject();
	    
		request.getSession().setAttribute("listaAccessoriAggregati", listaAccessoriAggregatiCampionamento);
		request.getSession().setAttribute("listaAccessoriAssociati", listaAccessoriAssociatiHash);
		request.getSession().setAttribute("listaAccessoriAssociatiJson", listaAccessoriAssociatiJson);

		  myObj.addProperty("success", true);
		  myObj.addProperty("accessorio", accessorioJson.toString());
		  
		  myObj.addProperty("messaggio", "Salvataggio Effettuato");
		  
		

		  PrintWriter  out = response.getWriter();
		  out.print(myObj);

	}
	
	if(action !=null && action.equals("removeAccessorio"))
	{
		
		String idAccessorio=request.getParameter("idAccessorio");
		String codiceCampionamento=request.getParameter("campionamento");
		
		HashMap<String, HashMap<String, AccessorioDTO>> listaAccessoriAggregatiCampionamento = (HashMap<String, HashMap<String, AccessorioDTO>>)request.getSession().getAttribute("listaAccessoriAggregati");
		
		HashMap<String, ArrayList<AccessorioDTO>> listaAccessoriAssociatiHash = (HashMap<String, ArrayList<AccessorioDTO>>) request.getSession().getAttribute("listaAccessoriAssociati");

		
		HashMap<String, AccessorioDTO> listaAccessoriAggregati = listaAccessoriAggregatiCampionamento.get(codiceCampionamento);
		
		AccessorioDTO accessorio = listaAccessoriAggregati.get(idAccessorio);

		listaAccessoriAggregati.remove(idAccessorio);
		
		
		ArrayList<AccessorioDTO> listaAcc = listaAccessoriAssociatiHash.get(codiceCampionamento);
		listaAcc.remove(accessorio);
		
		
		listaAccessoriAssociatiHash.put(codiceCampionamento, listaAcc);

		
		ArrayList<AccessorioDTO> listaAccessoriAssociati = new ArrayList<AccessorioDTO>();
		listaAccessoriAssociati.addAll(listaAccessoriAggregati.values());

		listaAccessoriAggregatiCampionamento.put(codiceCampionamento, listaAccessoriAggregati);
		
		Gson gson = new Gson();

	    JsonElement element = 
	     gson.toJsonTree(listaAccessoriAssociati);

	    JsonArray listaAccessoriAssociatiJson = element.getAsJsonArray();

	    
		request.getSession().setAttribute("listaAccessoriAggregati", listaAccessoriAggregatiCampionamento);
		request.getSession().setAttribute("listaAccessoriAssociati", listaAccessoriAssociatiHash);
		request.getSession().setAttribute("listaAccessoriAssociatiJson", listaAccessoriAssociatiJson);

		  myObj.addProperty("success", true);
		  
		  myObj.addProperty("messaggio", "Salvataggio Effettuato");
		  
		

		  PrintWriter  out = response.getWriter();
		  out.print(myObj);

	}

	if(action !=null && action.equals("checkDotazione")){
		
		String dataRange = request.getParameter("dataRange");
		String idDotazione = request.getParameter("idDotazione");
		
     	String date[] = dataRange.split(" - ");

      	DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
      	
      	Date dataInizio = format.parse(date[0]);
      	Date dataFine = format.parse(date[1]);
      	
      	//System.out.println(dataInizio+" "+dataFine+" "+idDotazione);
      	
      	if(GestioneCampionamentoBO.checkPrenotazioneDotazioneInRange(idDotazione,dataInizio,dataFine,session)) {
      	    myObj.addProperty("success", true);

      	}else {
      		myObj.addProperty("success", false);
		  
		    myObj.addProperty("messaggio", "Dotazione non prenotabile nelle date selezionate");

      	}
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
		  myObj.addProperty("messaggio", "Errore creazione intervento: " + ex.getMessage());
		  
		  PrintWriter  out = response.getWriter();
		  out.print(myObj);
		}
		
	}

	private HashMap<String, ArrayList<AttivitaMilestoneDTO>> getAttivitaAggregate(ArrayList<AttivitaMilestoneDTO> listaAttivita,
			ArrayList<String> aggregatiArrayList) {
		
		HashMap<String,ArrayList<AttivitaMilestoneDTO>> hashLista = new HashMap<String,ArrayList<AttivitaMilestoneDTO>>();
		
		for (String codAgg : aggregatiArrayList)
		{
			ArrayList<AttivitaMilestoneDTO> lista = new ArrayList<AttivitaMilestoneDTO>();
			for (AttivitaMilestoneDTO att : listaAttivita)
			{
			
				if(att.getCodiceAggregatore().equals(codAgg)) {
					lista.add(att);
				}
			}
			hashLista.put(codAgg, lista);
		}
			
		return hashLista;
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
