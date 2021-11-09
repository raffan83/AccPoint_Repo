package it.portaleSTI.bo;

import org.apache.commons.mail.EmailException;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneValidazioneGPDAO;
import it.portaleSTI.DTO.GPDTO;

public class GestioneValidazioneGPBO {

	public static void bundleGP(GPDTO greenPass, Session session) throws EmailException {
		
		
		String[] listaDestinatari= {"raffan83@gmail.com","lisa.lombardozzi@crescosrl.net","contabilita@stisrl.com","gabriella@stisrl.com"};
		
		
		if(greenPass.getEsito().equals("NOT_VALID") ||greenPass.getEsito().equals("NOT_VALID_YET") ) 
		{
			for (String destinatari : listaDestinatari) {
				
				 Thread thread = new Thread(){
					    public void run(){
					    	try {
								SendEmailBO.sendEmailGreenPass(greenPass,destinatari);
							} catch (EmailException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
					    }
					  };

					  thread.start();
					  
				
				
			}
		}
		
		GestioneValidazioneGPDAO.save(greenPass,session);
	}

}
