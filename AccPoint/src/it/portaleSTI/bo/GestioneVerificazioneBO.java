package it.portaleSTI.bo;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.GestioneStrumentoDAO;
import it.portaleSTI.DAO.SQLLiteDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DocumentiEsterniStrumentoDTO;
import it.portaleSTI.DTO.FornitoreDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.ScadenzaDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoMisuraDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.Util.Costanti;

import java.io.File;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.HibernateException;
import org.hibernate.Session;


public class GestioneVerificazioneBO {

	
	public static String creaPacchettoConNome(int idCliente,int idSede, CompanyDTO cmp,String nomeCliente, Session session,VerInterventoDTO intervento) throws Exception, SQLException {

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
		
		DirectMySqlDAO.insertStrumentiVerificazione(idCliente,idSede,con);
		
		
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
