package it.portaleSTI.bo;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneStrumentoDAO;
import it.portaleSTI.DAO.SQLLiteDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoMisuraDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;


public class GestioneListaStrumenti {

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

		return DirectMySqlDAO.getRedordDatiStrumentoAvviviNew(idCliente,idSede,idCompany);

	}

	public static List<TipoMisuraDTO> getTipiMisura(String tpS) throws HibernateException, Exception {

		return GestioneStrumentoDAO.getListaTipiMisura(tpS);
	}




	public static String creaPacchetto(String idCliente, String idSede, CompanyDTO cmp) throws Exception {


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

		creaListaCampioni(cmp, con);
		creaListaStrumenti(directory,nomeFile,idCliente,idSede,cmp);

		Utility.generateZipSTI(Costanti.PATH_FOLDER+"\\"+timeStamp,timeStamp+".zip");

		return timeStamp;
	}

	private static void creaListaStrumenti(File directory,String nomeFile, String idCliente, String idSede, CompanyDTO cmp) throws Exception {

		
		/*ArrayList<String> listaRecordStrumento=DirectMySqlDAO.getRedordDatiStrumento(idCliente,idSede,cmp);

		for (int i = 0; i < listaRecordStrumento.size(); i++) {

			String recordStrumento=listaRecordStrumento.get(i);

	//		ps.println(recordStrumento);
			String[] valoriRecordData =recordStrumento.split(";");

			System.out.println("Strumento id: "+valoriRecordData[0]);

			//	String filename=valoriRecordData[17];
			String id_tipo_strumento=valoriRecordData[17];

			//	if(filename!=null && !filename.equalsIgnoreCase("null") &&!filename.equalsIgnoreCase(""))
			//	{
			//	if(filename.length()>0 && !new File(directory.getPath()+"\\CORE\\"+filename).exists())
			//	{
			//		Utility.copiaFile(Costanti.PATH_SOURCE_FORM+"\\"+filename, directory.getPath()+"\\CORE\\"+filename);
			//	}

			ArrayList<String> listaCodiciCampioni=DirectMySqlDAO.getCodiciCampioni(valoriRecordData[0],id_tipo_strumento,cmp);

			String cod_camp="";
			for (int j = 0; j < listaCodiciCampioni.size(); j++) {

				if(j==listaCodiciCampioni.size()-1)
				{
					cod_camp=cod_camp+listaCodiciCampioni.get(j).toString()+"[END]";
				}
				else
				{
					cod_camp=cod_camp+listaCodiciCampioni.get(j).toString()+";";
				}
			}
		//	psCP.println(valoriRecordData[0]+"|"+valoriRecordData[2]+"[START]"+cod_camp);


			//	ArrayList<String> listaSchede=DirectMySqlDAO.getSchede(valoriRecordData[0],idSede);

				for (int z = 0; z < listaSchede.size(); z++) 
		{

			psSC.println(listaSchede.get(z));
		}
		}*/

		//	}

	}

	/*	private static void creaListaScheda(File directory) throws Exception {
		File listaSched = new File(directory.getPath()+"\\"+Costanti.FILE_NAME_LS_SCH);
		FileOutputStream fos = new FileOutputStream(listaSched);
		PrintStream ps = new PrintStream(fos);

		ArrayList<String> listaRecord=DirectMySqlDAO.getLiscaSchede();

		for (int i = 0; i <listaRecord.size(); i++) 
		{
			ps.println(listaRecord.get(i).toString());
		}
		ps.close();
		fos.close();

	}
	 */
	private static void creaListaCampioni(CompanyDTO cmp , Connection con) throws Exception {


		ArrayList<String> listaRecord=DirectMySqlDAO.getLiscaCampioni(cmp);


	}


}
