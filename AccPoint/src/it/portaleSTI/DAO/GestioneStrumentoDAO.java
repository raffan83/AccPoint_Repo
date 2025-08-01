package it.portaleSTI.DAO;

import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DocumentiEsterniStrumentoDTO;
import it.portaleSTI.DTO.FornitoreDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoMisuraDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.bo.GestioneInterventoBO;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

public class GestioneStrumentoDAO {

	public static List<StrumentoDTO> getListaStrumentiPerSede(String idSede) throws HibernateException, Exception
	{
	Session session=SessionFacotryDAO.get().openSession();
	List<StrumentoDTO> lista =null;
	
	session.beginTransaction();
	Query query  = session.createQuery( "from StrumentoDTO WHERE id__sede_= :_id_sede");
	
			query.setParameter("_id_sede", Integer.parseInt(idSede));
			
	
	lista=query.list();
	
	
	session.getTransaction().commit();
	session.close();
	
	return lista;
	}
	
	public static List<TipoStrumentoDTO> getListaTipoStrumento() throws HibernateException, Exception
	{
	Session session=SessionFacotryDAO.get().openSession();
	List<TipoStrumentoDTO> lista =null;
	
	session.beginTransaction();
	Query query  = session.createQuery( "from TipoStrumentoDTO Order BY nome ASC");

	lista=query.list();
	
	session.getTransaction().commit();
	session.close();

	return lista;
	}
	
	public static List<TipoRapportoDTO> getListaTipoRapporto() throws HibernateException, Exception
	{
	Session session=SessionFacotryDAO.get().openSession();
	List<TipoRapportoDTO> lista =null;
	
	session.beginTransaction();
	Query query  = session.createQuery( "from TipoRapportoDTO Order BY nome ASC");

	lista=query.list();
	
	session.getTransaction().commit();
	session.close();
	
	return lista;
	}


	
	
	

	


public static List<TipoMisuraDTO> getListaTipiMisura(String tpS) throws HibernateException, Exception {
	Session session=SessionFacotryDAO.get().openSession();
	List<TipoMisuraDTO> lista =null;
	
	session.beginTransaction();
	Query query  = session.createQuery( "from TipoMisuraDTO WHERE id__tipo_strumento_= :_id_tipo_strumento");
	
			query.setParameter("_id_tipo_strumento", Integer.parseInt(tpS));
			
	
	lista=query.list();
	
	
	session.getTransaction().commit();
	session.close();
	
	return lista;
}

public static StrumentoDTO getStrumentoById(String id, Session session)throws HibernateException, Exception {


	Query query  = session.createQuery( "from StrumentoDTO WHERE id= :_id");
	
	query.setParameter("_id", Integer.parseInt(id));
	List<StrumentoDTO> result =query.list();
	


	if(result.size()>0)
	{			
		return result.get(0);
	}
	return null;
	
}

public static ArrayList<StrumentoDTO> getListaStrumenti(String idCliente,String idSede, Integer idCompany, Session session,UtenteDTO utente) throws Exception {
	
	ArrayList<StrumentoDTO> lista =null;
	Query query=null;
	if(utente.isTras()) 
	{
		 query  = session.createQuery( "from StrumentoDTO WHERE id__sede_= :_idSede AND id_cliente=:_idcliente");
			query.setParameter("_idSede", Integer.parseInt(idSede));
			query.setParameter("_idcliente",  Integer.parseInt(idCliente));
	}
	else 
	{
		 query  = session.createQuery( "from StrumentoDTO WHERE id__sede_= :_idSede AND company.id=:_idCompany AND id_cliente=:_idcliente");
			query.setParameter("_idSede", Integer.parseInt(idSede));
			query.setParameter("_idCompany", idCompany);
			query.setParameter("_idcliente",  Integer.parseInt(idCliente));
	}
	
	
		
			
	
	lista=(ArrayList<StrumentoDTO>) query.list();
	
	return lista;
}



public static ArrayList<StrumentoDTO> getListaStrumentiInFuoriServizio(String idCliente,String idSede, Integer idCompany, Session session,UtenteDTO utente, int stato) throws Exception {
	
	ArrayList<StrumentoDTO> lista =null;
	Query query=null;
	if(utente.isTras()) 
	{
		 query  = session.createQuery( "from StrumentoDTO WHERE id__sede_= :_idSede AND id_cliente=:_idcliente and stato_strumento.id =:_stato");
			query.setParameter("_idSede", Integer.parseInt(idSede));
			query.setParameter("_idcliente",  Integer.parseInt(idCliente));
			query.setParameter("_stato",  stato);
			
	}
	else 
	{
		 query  = session.createQuery( "from StrumentoDTO WHERE id__sede_= :_idSede AND company.id=:_idCompany AND id_cliente=:_idcliente and stato_strumento.id =:_stato");
			query.setParameter("_idSede", Integer.parseInt(idSede));
			query.setParameter("_idCompany", idCompany);
			query.setParameter("_idcliente",  Integer.parseInt(idCliente));
			query.setParameter("_stato",  stato);
	}
	
	
		
			
	
	lista=(ArrayList<StrumentoDTO>) query.list();
	
	return lista;
}

public static ArrayList<MisuraDTO> getListaMirureByStrumento(int idStrumento, Session session) {

		Query query=null;
		
		ArrayList<MisuraDTO> misura=null;
		try {
//		Session session =SessionFacotryDAO.get().openSession();
//		session.beginTransaction();
		
		
		String s_query = "from MisuraDTO WHERE strumento.__id = :_idStrumento";
						  
	    query = session.createQuery(s_query);
	    query.setParameter("_idStrumento",idStrumento);
		
	    misura=(ArrayList<MisuraDTO>)query.list();
		
//		session.getTransaction().commit();
//		session.close();
	     } 
		catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     }
		
		return misura;
	}


public static HashMap<String, Integer> getListaStrumentiScadenziario(UtenteDTO user) {
	
	Query query=null;
	HashMap<String, Integer> listMap= new HashMap<String, Integer>();
	try {
		
	Session session = SessionFacotryDAO.get().openSession();
    
	session.beginTransaction();
	List<StrumentoDTO> lista =null;
	
	if(user.isTras())
	{
		query  = session.createQuery( "from StrumentoDTO ");	
	}
	else
	{
			if(user.getIdSede() != 0 && user.getIdCliente() != 0) {
				query  = session.createQuery( "from StrumentoDTO WHERE company.id= :_id_cmp AND id__sede_ =:_id_sede AND id_cliente=:idCliente");
				query.setParameter("_id_cmp", user.getCompany().getId());
				query.setParameter("_id_sede",user.getIdSede());
				query.setParameter("idCliente", user.getIdCliente());
				
		
			}else if(user.getIdSede() == 0 && user.getIdCliente() != 0) {
				query  = session.createQuery( "from StrumentoDTO WHERE company.id= :_id_cmp AND id_cliente=:idCliente");
				query.setParameter("_id_cmp", user.getCompany().getId());
				query.setParameter("idCliente", user.getIdCliente());
		
			}else {
				
				query  = session.createQuery( "from StrumentoDTO WHERE company.id= :_id_cmp");
				query.setParameter("_id_cmp", user.getCompany().getId());
			}
	}
	
	lista=query.list();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	for (StrumentoDTO str: lista) {
		
		if(str.getDataProssimaVerifica()!=null)
		{
			int i=1;
			
			if(listMap.get(sdf.format(str.getDataProssimaVerifica()))!=null)
			{
				i= listMap.get(sdf.format(str.getDataProssimaVerifica()))+1;
			}
			
				listMap.put(sdf.format(str.getDataProssimaVerifica()),i);
				
		}
	}
	
	session.getTransaction().commit();
	session.close();

    } 
	catch(Exception e)
     {
    	 e.printStackTrace();
     } 
	return listMap;
}




public static List<StrumentoDTO> getListaStrumentiFromUser(UtenteDTO user, String dateFrom, String dateTo) {
	Query query=null;
	List<StrumentoDTO> list=null;

	try {

		Session session = SessionFacotryDAO.get().openSession();

		session.beginTransaction();

		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		
		if(user.isTras())
		{
			if(dateFrom==null && dateTo!=null)
			{
				
		
				
				//query  = session.createQuery( "select strumentodto from StrumentoDTO as strumentodto left join strumentodto.listaScadenzeDTO as lista where lista.dataProssimaVerifica = :dateTo");
				query  = session.createQuery( "from StrumentoDTO where dataProssimaVerifica = :dateTo");
				query.setParameter("dateTo",df.parse(dateTo));
			}
			
			else
			{
				//query=session.createQuery("select strumentodto from StrumentoDTO as strumentodto left join strumentodto.listaScadenzeDTO as lista where lista.dataProssimaVerifica BETWEEN :dateFrom AND :dateTo");
				query=session.createQuery("from StrumentoDTO  where dataProssimaVerifica BETWEEN :dateFrom AND :dateTo");
				query.setParameter("dateFrom",df.parse(dateFrom));
				query.setParameter("dateTo",df.parse(dateTo));
			}

		}

		else
		{
		
			if(dateFrom==null && dateTo!=null)
			{
				if(user.getIdCliente()==0 && user.getIdSede()==0)
				{
					//query  = session.createQuery( "select strumentodto from StrumentoDTO as strumentodto left join strumentodto.listaScadenzeDTO as lista where strumentodto.company.id=:_idCmp AND lista.dataProssimaVerifica = :dateTo ");
					query  = session.createQuery( "from StrumentoDTO where company.id=:_idCmp AND dataProssimaVerifica = :dateTo ");
					query.setParameter("_idCmp", user.getCompany().getId());
					query.setParameter("dateTo",df.parse(dateTo));
				}
				else if(user.getIdCliente()!=0 && user.getIdSede()==0)
				{
					//query  = session.createQuery( "select strumentodto from StrumentoDTO as strumentodto left join strumentodto.listaScadenzeDTO as lista where strumentodto.company.id=:_idCmp AND lista.dataProssimaVerifica = :dateTo  AND strumentodto.id_cliente=:idCliente");
					query  = session.createQuery( "from StrumentoDTO where company.id=:_idCmp AND dataProssimaVerifica = :dateTo  AND id_cliente=:idCliente");
					query.setParameter("_idCmp", user.getCompany().getId());
					query.setParameter("idCliente", user.getIdCliente());
					query.setParameter("dateTo",df.parse(dateTo));
				}
				else
				{
					//query  = session.createQuery( "select strumentodto from StrumentoDTO as strumentodto left join strumentodto.listaScadenzeDTO as lista where lista.dataProssimaVerifica = :dateTo AND strumentodto.company.id=:_idCmp AND strumentodto.id_cliente=:idCliente AND strumentodto.id__sede_=:idSede");
					query  = session.createQuery( "from StrumentoDTO where dataProssimaVerifica = :dateTo AND company.id=:_idCmp AND id_cliente=:idCliente AND id__sede_=:idSede");
					query.setParameter("_idCmp", user.getCompany().getId());
					query.setParameter("idCliente", user.getIdCliente());
					query.setParameter("idSede", user.getIdSede());
					query.setParameter("dateTo",df.parse(dateTo));
				}
			}else
			{
				if(user.getIdCliente()==0 && user.getIdSede()==0)
				{
					//query  = session.createQuery( "select strumentodto from StrumentoDTO as strumentodto left join strumentodto.listaScadenzeDTO as lista where strumentodto.company.id=:_idCmp AND lista.dataProssimaVerifica BETWEEN :dateFrom AND :dateTo");
					query  = session.createQuery( "from StrumentoDTO  where company.id=:_idCmp AND dataProssimaVerifica BETWEEN :dateFrom AND :dateTo");
					query.setParameter("_idCmp", user.getCompany().getId());
					query.setParameter("dateTo",df.parse(dateTo));
					query.setParameter("dateFrom",df.parse(dateFrom));
				}
				else if(user.getIdCliente()!=0 && user.getIdSede()==0)
				{
					//query  = session.createQuery( "select strumentodto from StrumentoDTO as strumentodto left join strumentodto.listaScadenzeDTO as lista where lista.dataProssimaVerifica BETWEEN :dateFrom AND :dateTo AND company.id=:_idCmp AND strumentodto.id_cliente=:idCliente");
					query  = session.createQuery( "from StrumentoDTO where dataProssimaVerifica BETWEEN :dateFrom AND :dateTo AND company.id=:_idCmp AND id_cliente=:idCliente");
					query.setParameter("_idCmp", user.getCompany().getId());
					query.setParameter("idCliente", user.getIdCliente());
					query.setParameter("dateTo",df.parse(dateTo));
					query.setParameter("dateFrom",df.parse(dateFrom));	
				}
				else
				{
					//query  = session.createQuery( "select strumentodto from StrumentoDTO as strumentodto left join strumentodto.listaScadenzeDTO as lista where lista.dataProssimaVerifica BETWEEN :dateFrom AND :dateTo AND company.id=:_idCmp AND strumentodto.id_cliente=:idCliente AND strumentodto.id__sede_=:idSede");
					query  = session.createQuery( "from StrumentoDTO where dataProssimaVerifica BETWEEN :dateFrom AND :dateTo AND company.id=:_idCmp AND id_cliente=:idCliente AND id__sede_=:idSede");
					query.setParameter("_idCmp", user.getCompany().getId());
					query.setParameter("idCliente", user.getIdCliente());
					query.setParameter("idSede", user.getIdSede());
					query.setParameter("dateTo",df.parse(dateTo));
					query.setParameter("dateFrom",df.parse(dateFrom));
	
				}
			}
		}


		list=query.list();

		session.getTransaction().commit();
		session.close();

	} catch(Exception e)
	{
		e.printStackTrace();
	} 
	return list;
}


	
	public static ArrayList<StrumentoDTO> getListaStrumentiIntervento(InterventoDTO intervento, Session session) {
		
		ArrayList<StrumentoDTO> list=null;
		
		try {
		
			String s_query = "SELECT m.strumento from MisuraDTO m WHERE m.intervento =:_intervento GROUP BY m.strumento";
	
	    
			Query query = session.createQuery(s_query);
	
			query.setParameter("_intervento", intervento);
			
			list = (ArrayList<StrumentoDTO>)query.list();
			
			
		
		}catch(Exception e)
	    {
			e.printStackTrace();
	    } 
		return list;

	}

	public static DocumentiEsterniStrumentoDTO getDocumentoEsterno(String idDocumento, Session session) {
		ArrayList<DocumentiEsterniStrumentoDTO> list=null;
		try {

			Query query  = session.createQuery( "from DocumentiEsterniStrumentoDTO WHERE id= :_id_doc");
			
			query.setParameter("_id_doc", Integer.parseInt(idDocumento));

			list = (ArrayList<DocumentiEsterniStrumentoDTO>)query.list();
			
	
		
		}catch(Exception e)
	    {
			e.printStackTrace();
	    } 
		
		if(list.size()>0)
		{			
			return list.get(0);
		}
		return null;
	}

	public static void deleteDocumentoEsterno(String idDocumento, Session session) {
		// TODO Auto-generated method stub
		DocumentiEsterniStrumentoDTO documento = getDocumentoEsterno(idDocumento, session);
		session.delete(documento);
		
	}

	public static ObjSavePackDTO saveDocumentoEsterno(FileItem fileUploaded, StrumentoDTO strumento, String dataVerifica,  Session session) {

		ObjSavePackDTO  objSave= new ObjSavePackDTO();
		
		File directory =new File(Costanti.PATH_FOLDER+"//DocumentiEsterni//"+strumento.get__id());
			
		if(directory.exists()==false)
		{
			directory.mkdir();
		}
		
		File file = new File(Costanti.PATH_FOLDER+"//DocumentiEsterni//"+strumento.get__id()+"/"+fileUploaded.getName());
				
		try {
			
			fileUploaded.write(file);
			objSave.setPackNameAssigned(file);
			
			
			DocumentiEsterniStrumentoDTO documento = new DocumentiEsterniStrumentoDTO();
			
			SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
			if(dataVerifica!=null && !dataVerifica.equals("")) {
				Date dataCaricamento = format.parse(dataVerifica);
				documento.setDataCaricamento(dataCaricamento);
			}else {
				documento.setDataCaricamento(new Date());
			}
			
			documento.setId_strumento(strumento.get__id());
			documento.setNomeDocumento(fileUploaded.getName());
			
			session.save(documento);
			
			objSave.setEsito(1);

		
		} catch (Exception e) {

			e.printStackTrace();
			objSave.setEsito(0);
			objSave.setErrorMsg("Errore Salvataggio Dati");

			return objSave; 
		}
	
		return objSave;
	}
	

	public static ArrayList<Integer> getListaClientiStrumenti() {
		Query query=null;
		
		ArrayList<Integer> lista=null;
		try {
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		
		String s_query = "select DISTINCT(str.id_cliente) from StrumentoDTO as str";
						  
	    query = session.createQuery(s_query);
 		
	    lista=(ArrayList<Integer>)query.list();

	     } 
		catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     }
		
		return lista;
	}



	public static ArrayList<Integer> getListaSediStrumenti() {
		Query query=null;
		
		ArrayList<Integer> lista=null;
		try {
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		
		String s_query = "select DISTINCT(str.id__sede_) from StrumentoDTO as str";
						  
	    query = session.createQuery(s_query);
 		
	    lista=(ArrayList<Integer>)query.list();

	     } 
		catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     }
		
		return lista;
	}

	public static ArrayList<StrumentoDTO> getStrumentiFiltrati(String nome, String marca, String modello, String matricola, String codice_interno, int id_company) {
	
		ArrayList<StrumentoDTO> lista = null;
		
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		Query query = session.createQuery("select distinct strumento from MisuraDTO mis where mis.strumento.denominazione like :_nome "
				+ "and mis.strumento.costruttore like :_marca "
				+ "and mis.strumento.modello like :_modello "
				+ "and mis.strumento.matricola like :_matricola "
				+ "and mis.strumento.codice_interno like :_codice_interno "
				+ "and mis.strumento.company.id = :_id_company");
		
		query.setParameter("_nome", "%"+nome+"%");
		query.setParameter("_marca", "%"+marca+"%");
		query.setParameter("_modello", "%"+modello+"%");
		query.setParameter("_matricola", "%"+matricola+"%");
		query.setParameter("_codice_interno", "%"+codice_interno+"%");
		query.setParameter("_id_company", id_company);

		
		lista = (ArrayList<StrumentoDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<StrumentoDTO> getlistaStrumentiFromCompany(Integer id_company, Session session) {
		
		ArrayList<StrumentoDTO> lista = null;
		
		Query query = session.createQuery("from StrumentoDTO  where id_cliente = :_id_company");
		query.setParameter("_id_company", id_company);

		
		lista = (ArrayList<StrumentoDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<StrumentoDTO> getStrumentiFiltratiGenerale(int id, String nome, String marca, String modello, String matricola, String codice_interno, Integer id_company, UtenteDTO user) {
		
		ArrayList<StrumentoDTO> lista = null;
		
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		String str = "from StrumentoDTO where";
		
		if(id!=0) {
			str = str+" __id =:_id and"; 
					
		}
		if(user.getTrasversale()==1) {
			str = str + " denominazione like :_nome "
					+ "and costruttore like :_marca "
					+ "and modello like :_modello "
					+ "and matricola like :_matricola "
					+ "and codice_interno like :_codice_interno ";
		}else {
			str = str + " denominazione like :_nome "
					+ "and costruttore like :_marca "
					+ "and modello like :_modello "
					+ "and matricola like :_matricola "
					+ "and codice_interno like :_codice_interno "
					+ "and company.id = :_id_company";
		}
	
		
		Query query = session.createQuery(str);
		
		if(id!=0) {
			query.setParameter("_id", id);
		}		
		query.setParameter("_nome", "%"+nome+"%");
		query.setParameter("_marca", "%"+marca+"%");
		query.setParameter("_modello", "%"+modello+"%");
		query.setParameter("_matricola", "%"+matricola+"%");
		query.setParameter("_codice_interno", "%"+codice_interno+"%");
		if(user.getTrasversale()!=1) {
			query.setParameter("_id_company", id_company);
		}
		
		lista = (ArrayList<StrumentoDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<StrumentoDTO> getlistaStrumenti(int i, int j, Session session) {
		
		ArrayList<StrumentoDTO> lista = null;
		
		Query query = session.createQuery("from StrumentoDTO  where id_cliente = :_i and id__sede_ = :_j");
		query.setParameter("_i", i);

		query.setParameter("_j", j);
		
		lista = (ArrayList<StrumentoDTO>) query.list();
		
		return lista;
	}

	public static boolean updateStatoIp(String idStr, int stato) throws Exception {
		
		Connection con=null; 
		PreparedStatement pst=null;
		int _return;
		try {
			
			con =DirectMySqlDAO.getConnection();
			
			pst=con.prepareStatement("UPDATE strumento set ip=? WHERE __id=?");
			
			pst.setInt(1, stato);
			pst.setString(2, idStr);
			
			_return=pst.executeUpdate();
			
			if(_return>0) 
			{
				return true;
			}
			else 
			{
				return false;
			}
			
		} finally {
			pst.close();
			con.close();
		}
	}


}
