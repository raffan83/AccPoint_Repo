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

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.GestioneMisuraDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;

public class GestioneMisuraBO {

	public static MisuraDTO getMiruraByID(int idMisura)throws Exception
	{
		
			return GestioneMisuraDAO.getMiruraByID(idMisura);
		
	}
	
	
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
		    		String[] array = punto.getDesc_Campione().split("\\|"); 
		    		for (String codCamp : array) {
		    			if(!listaCampioni.containsKey(codCamp))
		    			{
		    				listaCampioni.put(codCamp, codCamp);
		    			}
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
