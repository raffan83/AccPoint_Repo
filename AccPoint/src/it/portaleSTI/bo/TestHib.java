package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneAccessoDAO;


public class TestHib {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		try {
			GestioneAccessoDAO.controllaAccesso("Admin", "portalsti");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
