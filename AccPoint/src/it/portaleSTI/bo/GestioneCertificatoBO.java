package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneCertificatoDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;

import java.util.ArrayList;

public class GestioneCertificatoBO {
	
	
		public static ArrayList<CertificatoDTO> getListaCertificato(StatoCertificatoDTO stato,InterventoDatiDTO intervento) throws Exception
		{
				
				return GestioneCertificatoDAO.getListaCertificati(stato,intervento);
			
		}

		
		public static void main(String[] args) {
			try {
				ArrayList<CertificatoDTO> listaCert=getListaCertificato(null, null);
				
				for (CertificatoDTO certificatoDTO : listaCert) {
					
					System.out.println("ID intervento: " +certificatoDTO.getMisura().getIntervento().getId() + 
							           " ID interventoDati: "+certificatoDTO.getMisura().getInterventoDati().getId()+
										" Misura: "+certificatoDTO.getMisura().getId());
					
				}
				System.out.println(listaCert.size());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
}
