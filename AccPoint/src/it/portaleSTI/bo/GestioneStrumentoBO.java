package it.portaleSTI.bo;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneStrumentoDAO;
import it.portaleSTI.DAO.SQLLiteDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoMisuraDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.Util.Costanti;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;


public class GestioneStrumentoBO {

	/*
	 * Inizio Chiamate creazioni select clienti e sedi
	 * */

	public static List<ClienteDTO> getListaClientiNew(String id_company) throws HibernateException, Exception {

		return GestioneStrumentoDAO.getListaClientiNew(id_company);
	}

	public static List<SedeDTO> getListaSediNew() throws SQLException {

		return GestioneStrumentoDAO.getListaSediNEW();
	}

	/*
	 * Fine Chiamate creazioni select clienti e sedi
	 * */

	public static List<TipoStrumentoDTO> getListaTipoStrumento() throws HibernateException, Exception
	{
		return GestioneStrumentoDAO.getListaTipoStrumento();
	}

	public static List<TipoRapportoDTO> getListaTipoRapporto() throws HibernateException, Exception
	{
		return GestioneStrumentoDAO.getListaTipoRapporto();
	}

	public static List<StrumentoDTO> getListaStrumentiPerSedi(String idSede, String idCliente) throws HibernateException, Exception {

		return GestioneStrumentoDAO.getListaStrumentiPerSede(idSede);
	}


	public static ArrayList<StrumentoDTO> getListaStrumentiPerSediAttiviNEW(String idCliente,String idSede, Integer idCompany) throws SQLException{

		return GestioneStrumentoDAO.getListaStrumenti(idCliente,idSede,idCompany);
		
				
		//return DirectMySqlDAO.getRedordDatiStrumentoAvviviNew(idCliente,idSede,idCompany);

	}

	public static List<TipoMisuraDTO> getTipiMisura(String tpS) throws HibernateException, Exception {

		return GestioneStrumentoDAO.getListaTipiMisura(tpS);
	}

	public static String creaPacchetto(int idCliente, int idSede, CompanyDTO cmp) throws Exception {


		SimpleDateFormat sdf = new SimpleDateFormat("ddMMYYYYhhmmss");

		String timeStamp=sdf.format(new Date());
		String nomeFile="CM"+cmp.getId()+""+timeStamp;
		File directory= new File(Costanti.PATH_FOLDER+nomeFile);

		if(!directory.exists())
		{
			directory.mkdir();

		}

		Connection con = SQLLiteDAO.getConnection(directory.getPath(),nomeFile);
		
		SQLLiteDAO.createDB(con);
		
		DirectMySqlDAO.insertFattoriMoltiplicativi(con);
		
		DirectMySqlDAO.insertConversioni(con);

		DirectMySqlDAO.insertListaCampioni(con,cmp);
		
		DirectMySqlDAO.insertRedordDatiStrumento(idCliente,idSede,cmp,con);
		
		DirectMySqlDAO.insertTipoGrandezza_TipoStrumento(con);
		
		return nomeFile;
	}

	private static void creaListaStrumenti(String idCliente, String idSede, CompanyDTO cmp,Connection con) throws Exception {

		
	//	ArrayList<String> listaTipoStrumento=DirectMySqlDAO.insertRedordDatiStrumento(idCliente,idSede,cmp,con);

	//	ArrayList<String> listaCodiciCampioni=new ArrayList<>();
				
	//	for (int i = 0; i < listaTipoStrumento.size(); i++) {

	//		String[] valoriRecordData =listaTipoStrumento.get(i).split(";");

	//		System.out.println("Strumento id: "+valoriRecordData[0]);

		
				
		//	listaCodiciCampioni.add(DirectMySqlDAO.getCodiciCampioni(valoriRecordData[0],valoriRecordData[1],cmp));
			
		//	DirectMySqlDAO.insertCampioniAssociati(con,valoriRecordData[0],listaCodiciCampioni.substring(1,listaCodiciCampioni.length()));
	
			
			/*String cod_camp="";
			for (int j = 0; j < listaCodiciCampioni.size(); j++) {

				if(j==listaCodiciCampioni.size()-1)
				{
					cod_camp=cod_camp+listaCodiciCampioni.get(j).toString()+"[END]";
				}
				else
				{
					cod_camp=cod_camp+listaCodiciCampioni.get(j).toString()+";";
				}
			}*/
		//	psCP.println(valoriRecordData[0]+"|"+valoriRecordData[2]+"[START]"+cod_camp);

		//	}

	}

	public static StrumentoDTO getStrumentoById(String id_str) throws SQLException {


		return DirectMySqlDAO.getStrumentoById(id_str);
	}
	
	public static int save(StrumentoDTO strumento){
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();

		session.save(strumento);
		
		session.getTransaction().commit();
		session.close();
		return strumento.get__id();
	}

}
