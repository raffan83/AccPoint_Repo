package it.portaleSTI.bo;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import it.portaleSTI.DAO.DirectMySqlDAO;

public class ServiceBO {

	public static HashMap<Integer, String> getHashEncrypt() throws SQLException {
		// TODO Auto-generated method stub
		return DirectMySqlDAO.getHashEncrypt();
	}

	
	
	public static HashMap<String, Integer> getHashDecrypt() throws SQLException {
		return DirectMySqlDAO.getHashDecrypt();
	}
}
