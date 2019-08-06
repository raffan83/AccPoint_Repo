package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneVerCertificatoDAO;
import it.portaleSTI.DTO.VerCertificatoDTO;
import it.portaleSTI.DTO.VerMisuraDTO;

public class VerCertificatoBO {

	public static  VerCertificatoDTO getCertificatoByMisura(VerMisuraDTO misura) throws Exception 
	{
		return GestioneVerCertificatoDAO.getCertificatoByMisura(misura);
	}
	

}
