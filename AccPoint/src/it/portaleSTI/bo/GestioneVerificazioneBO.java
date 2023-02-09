package it.portaleSTI.bo;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.SQLLiteDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.Util.Costanti;

import java.io.File;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import org.hibernate.Session;


public class GestioneVerificazioneBO {

	
	public static String creaPacchettoConNome(VerInterventoDTO intervento, CompanyDTO cmp,Session session) throws Exception, SQLException {

		Connection con=null;
		
		String nomeFile=intervento.getNome_pack();
		
		try 
		{
			
			File directory= new File(Costanti.PATH_FOLDER+nomeFile);

			if(!directory.exists())
			{
				directory.mkdir();

			}
	
			
		File file= new File(directory+"\\"+nomeFile+".db");

		FileOutputStream fos = new FileOutputStream(file);
		
		fos.close();
		
		directory.delete();
	
		File directory1= new File(Costanti.PATH_FOLDER+nomeFile+"\\"+nomeFile+".db");
	
		
		con = SQLLiteDAO.getConnection(directory1.getPath());
		
		SQLLiteDAO.createDBVER(con);
		
		DirectMySqlDAO.insertClasseMasse(con);
		
		DirectMySqlDAO.insertListaCampioni(con,cmp);
		
		DirectMySqlDAO.insertStrumentiVerificazione(intervento,con,session);
		
		
		con.close();
		}catch (Exception e) {
			throw e;
		}
		finally 
		{
			con.close();
		}
		return nomeFile;
	}
	

}
