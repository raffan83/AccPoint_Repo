package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class GestioneMisuraBO {

	
	public static int getTabellePerMisura(Set<PuntoMisuraDTO> listaPunti) {
		
		  int index=0;
		  Iterator<PuntoMisuraDTO> iterator = listaPunti.iterator(); 
	      
		   // check values
		   while (iterator.hasNext())
		   
		   {
		    PuntoMisuraDTO punto = (PuntoMisuraDTO) iterator.next();	   
		    
		    if(punto.getId_tabella()!=index)
		    {
		    	index++;
		    }
		   }
		return index;
	}
	
	public static ArrayList<PuntoMisuraDTO> getListaPuntiByIdTabella(Set<PuntoMisuraDTO> listaPunti, int idTabella) {
		  ArrayList<PuntoMisuraDTO> listaPuntiMisura = new ArrayList<>();
		  
		  
		  Iterator<PuntoMisuraDTO> iterator = listaPunti.iterator(); 
	      
		   // check values
		   while (iterator.hasNext())
		   
		   {
		    PuntoMisuraDTO punto = (PuntoMisuraDTO) iterator.next();	   
		    
		    if(punto.getId_tabella()==idTabella)
		    {
		    	listaPuntiMisura.add(punto);
		    }
		   }
		return listaPuntiMisura;
	}

	public static List<CampioneDTO> getListaCampioni(Set<PuntoMisuraDTO> listaPunti) {
	
		List<CampioneDTO> listToReturn = new ArrayList();
		
		HashMap<String,String> listaCampioni = new HashMap<>();
		
		Iterator<PuntoMisuraDTO> iterator = listaPunti.iterator(); 
	      
		   // check values
		   while (iterator.hasNext())
		   
		   {
		    PuntoMisuraDTO punto = (PuntoMisuraDTO) iterator.next();	   
		    
		    	if(!listaCampioni.containsKey(punto.getDesc_Campione()))
		    	{
		    		listaCampioni.put(punto.getDesc_Campione(), punto.getDesc_Campione());
		    	}
		    	
		    
		    
		   }
		   
		   Iterator itCampioni=listaCampioni.entrySet().iterator();
		   
		   while (itCampioni.hasNext()) {
		        
			   Map.Entry pair = (Map.Entry)itCampioni.next();
		        
		        CampioneDTO campione =GestioneCampioneDAO.getCampioneFromCodice(pair.getKey().toString());
		       
		        listToReturn.add(campione);
		        itCampioni.remove(); // avoids a ConcurrentModificationException
		    }
		   
		return listToReturn;
	}

}
