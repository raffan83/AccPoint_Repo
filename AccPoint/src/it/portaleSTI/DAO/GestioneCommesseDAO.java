package it.portaleSTI.DAO;

import it.portaleSTI.DTO.AttivitaMilestoneDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.UtenteDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class GestioneCommesseDAO {

	private static final String querySqlServerComTras = "SELECT ID_COMMESSA,DT_COMMESSA,FIR_CHIUSURA_DT, B.ID_ANAGEN,b.NOME," +
			"a.DESCR,a.SYS_STATO,C.K2_ANAGEN_INDIR,C.DESCR,C.INDIR,C.CITTA,C.CODPROV,b.INDIR AS INDIRIZZO_PRINCIPALE,b.CITTA AS CITTAPRINCIPALE, b.CODPROV AS CODICEPROVINCIA,NOTE_GEN,N_ORDINE," +
			"a.ID_ANAGEN_UTILIZ AS ID_UTIL ,a.K2_ANAGEN_INDIR_UTILIZ AS ID_IND_UTIL, e.nome as NOME_CLIENTE_UTIL, e.INDIR as IND_PRINC_UTIL,e.CITTA AS CITTAPRINCIPALE,e.CODPROV AS COD_PROV_PRINCIPALE,d.DESCR AS DESC_SEDE_UTIL,d.INDIR AS IND_SEDE_UTIL ,d.CITTA AS CITTA_SEDE_UTIL,d.CODPROV AS PROV_SEDE_UTIL, "+
			"(SELECT COGNOME FROM [BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI] WHERE TB_RESP_COMM=[BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI].USERNAME) AS RESPCOMM_COGNOME ,"+
			"(SELECT NOME FROM [BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI] WHERE TB_RESP_COMM=[BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI].USERNAME) AS RESPCOMM_NOME "+
			"FROM BWT_COMMESSA AS a " +
			"LEFT JOIN BWT_ANAGEN AS b ON  a.ID_ANAGEN=b.ID_ANAGEN " +
			"LEFT JOIN BWT_ANAGEN_INDIR AS c on a.K2_ANAGEN_INDIR=c.K2_ANAGEN_INDIR AND a.ID_ANAGEN=c.ID_ANAGEN " +
			"LEFT JOIN [BTOMEN_CRESCO_DATI].[dbo].[BWT_ANAGEN_INDIR] AS d on a.K2_ANAGEN_INDIR_UTILIZ=d.K2_ANAGEN_INDIR AND a.ID_ANAGEN_UTILIZ=d.ID_ANAGEN "+
			"LEFT JOIN [BTOMEN_CRESCO_DATI].[dbo].[BWT_ANAGEN] AS e on a.ID_ANAGEN_UTILIZ=e.ID_ANAGEN "+			
			"WHERE ID_ANAGEN_COMM<>52 AND ID_ANAGEN_COMM<>1703 AND ID_ANAGEN_COMM<>1428 AND ID_ANAGEN_COMM<>7011";
	
	private static final String querySqlServerComTrasWhitYear = "SELECT ID_COMMESSA,DT_COMMESSA,FIR_CHIUSURA_DT, B.ID_ANAGEN,b.NOME," +
			"a.DESCR,a.SYS_STATO,C.K2_ANAGEN_INDIR,C.DESCR,C.INDIR,C.CITTA,C.CODPROV,b.INDIR AS INDIRIZZO_PRINCIPALE,b.CITTA AS CITTAPRINCIPALE, b.CODPROV AS CODICEPROVINCIA,NOTE_GEN,N_ORDINE," +
			"a.ID_ANAGEN_UTILIZ AS ID_UTIL ,a.K2_ANAGEN_INDIR_UTILIZ AS ID_IND_UTIL, e.nome as NOME_CLIENTE_UTIL, e.INDIR as IND_PRINC_UTIL,e.CITTA AS CITTAPRINCIPALE,e.CODPROV AS COD_PROV_PRINCIPALE,d.DESCR AS DESC_SEDE_UTIL,d.INDIR AS IND_SEDE_UTIL ,d.CITTA AS CITTA_SEDE_UTIL,d.CODPROV AS PROV_SEDE_UTIL,"+
			"(SELECT COGNOME FROM [BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI] WHERE TB_RESP_COMM=[BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI].USERNAME) AS RESPCOMM_COGNOME ,"+
			"(SELECT NOME FROM [BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI] WHERE TB_RESP_COMM=[BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI].USERNAME) AS RESPCOMM_NOME "+
			"FROM BWT_COMMESSA AS a " +
			"LEFT JOIN BWT_ANAGEN AS b ON  a.ID_ANAGEN=b.ID_ANAGEN " +
			"LEFT JOIN BWT_ANAGEN_INDIR AS c on a.K2_ANAGEN_INDIR=c.K2_ANAGEN_INDIR AND a.ID_ANAGEN=c.ID_ANAGEN " +
			"LEFT JOIN [BTOMEN_CRESCO_DATI].[dbo].[BWT_ANAGEN_INDIR] AS d on a.K2_ANAGEN_INDIR_UTILIZ=d.K2_ANAGEN_INDIR AND a.ID_ANAGEN_UTILIZ=d.ID_ANAGEN "+
			"LEFT JOIN [BTOMEN_CRESCO_DATI].[dbo].[BWT_ANAGEN] AS e on a.ID_ANAGEN_UTILIZ=e.ID_ANAGEN "+			
			"WHERE ID_ANAGEN_COMM<>52 AND ID_ANAGEN_COMM<>1703 AND ID_ANAGEN_COMM<>1428 AND ID_ANAGEN_COMM<>7011 AND  year([DT_COMMESSA])=? ";

	private static final String queryArticoli = "SELECT * FROM BWT_ANAART WHERE ID_ANAART=?";

	private static String querySqlServerCommon="SELECT ID_COMMESSA,DT_COMMESSA,FIR_CHIUSURA_DT, B.ID_ANAGEN,b.NOME," +
			"a.DESCR,a.SYS_STATO,C.K2_ANAGEN_INDIR,C.DESCR,C.INDIR,C.CITTA,C.CODPROV,b.INDIR AS INDIRIZZO_PRINCIPALE,b.CITTA AS CITTAPRINCIPALE, b.CODPROV AS CODICEPROVINCIA,NOTE_GEN,N_ORDINE " +
			",a.ID_ANAGEN_UTILIZ AS ID_UTIL ,a.K2_ANAGEN_INDIR_UTILIZ AS ID_IND_UTIL, e.nome as NOME_CLIENTE_UTIL, e.INDIR as IND_PRINC_UTIL,e.CITTA AS CITTAPRINCIPALE,e.CODPROV AS COD_PROV_PRINCIPALE,d.DESCR AS DESC_SEDE_UTIL,d.INDIR AS IND_SEDE_UTIL ,d.CITTA AS CITTA_SEDE_UTIL,d.CODPROV AS PROV_SEDE_UTIL, "+
			"(SELECT COGNOME FROM [BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI] WHERE TB_RESP_COMM=[BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI].USERNAME) AS RESPCOMM_COGNOME ,"+
			"(SELECT NOME FROM [BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI] WHERE TB_RESP_COMM=[BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI].USERNAME) AS RESPCOMM_NOME "+
			"FROM BWT_COMMESSA AS a " +
			"LEFT JOIN BWT_ANAGEN AS b ON  a.ID_ANAGEN=b.ID_ANAGEN " +
			"LEFT JOIN BWT_ANAGEN_INDIR AS c on a.K2_ANAGEN_INDIR=c.K2_ANAGEN_INDIR AND a.ID_ANAGEN=c.ID_ANAGEN " +
			"LEFT JOIN [BTOMEN_CRESCO_DATI].[dbo].[BWT_ANAGEN_INDIR] AS d on a.K2_ANAGEN_INDIR_UTILIZ=d.K2_ANAGEN_INDIR AND a.ID_ANAGEN_UTILIZ=d.ID_ANAGEN "+
			"LEFT JOIN [BTOMEN_CRESCO_DATI].[dbo].[BWT_ANAGEN] AS e on a.ID_ANAGEN_UTILIZ=e.ID_ANAGEN "+
			"WHERE ID_ANAGEN_COMM=? ";
	
	private static String querySqlServerCommonWhitYear="SELECT ID_COMMESSA,DT_COMMESSA,FIR_CHIUSURA_DT, B.ID_ANAGEN,b.NOME," +
			"a.DESCR,a.SYS_STATO,C.K2_ANAGEN_INDIR,C.DESCR,C.INDIR,C.CITTA,C.CODPROV,b.INDIR AS INDIRIZZO_PRINCIPALE,b.CITTA AS CITTAPRINCIPALE, b.CODPROV AS CODICEPROVINCIA,NOTE_GEN,N_ORDINE " +
			",a.ID_ANAGEN_UTILIZ AS ID_UTIL ,a.K2_ANAGEN_INDIR_UTILIZ AS ID_IND_UTIL, e.nome as NOME_CLIENTE_UTIL, e.INDIR as IND_PRINC_UTIL,e.CITTA AS CITTAPRINCIPALE,e.CODPROV AS COD_PROV_PRINCIPALE,d.DESCR AS DESC_SEDE_UTIL,d.INDIR AS IND_SEDE_UTIL ,d.CITTA AS CITTA_SEDE_UTIL,d.CODPROV AS PROV_SEDE_UTIL, "+
			"(SELECT COGNOME FROM [BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI] WHERE TB_RESP_COMM=[BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI].USERNAME) AS RESPCOMM_COGNOME ,"+
			"(SELECT NOME FROM [BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI] WHERE TB_RESP_COMM=[BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI].USERNAME) AS RESPCOMM_NOME "+
			"FROM BWT_COMMESSA AS a " +
			"LEFT JOIN BWT_ANAGEN AS b ON  a.ID_ANAGEN=b.ID_ANAGEN " +
			"LEFT JOIN BWT_ANAGEN_INDIR AS c on a.K2_ANAGEN_INDIR=c.K2_ANAGEN_INDIR AND a.ID_ANAGEN=c.ID_ANAGEN " +
			"LEFT JOIN [BTOMEN_CRESCO_DATI].[dbo].[BWT_ANAGEN_INDIR] AS d on a.K2_ANAGEN_INDIR_UTILIZ=d.K2_ANAGEN_INDIR AND a.ID_ANAGEN_UTILIZ=d.ID_ANAGEN "+
			"LEFT JOIN [BTOMEN_CRESCO_DATI].[dbo].[BWT_ANAGEN] AS e on a.ID_ANAGEN_UTILIZ=e.ID_ANAGEN "+
			"WHERE ID_ANAGEN_COMM=? AND  year([DT_COMMESSA])=?";
	
	private static String querySqlServerComId="SELECT ID_COMMESSA,DT_COMMESSA,FIR_CHIUSURA_DT, B.ID_ANAGEN,b.NOME," +
			"a.DESCR,a.SYS_STATO,C.K2_ANAGEN_INDIR,C.DESCR,C.INDIR,C.CITTA,C.CODPROV,b.INDIR AS INDIRIZZO_PRINCIPALE,b.CITTA AS CITTAPRINCIPALE, b.CODPROV AS CODICEPROVINCIA,NOTE_GEN,N_ORDINE, ID_ANAGEN_COMM " +
			",a.ID_ANAGEN_UTILIZ AS ID_UTIL ,a.K2_ANAGEN_INDIR_UTILIZ AS ID_IND_UTIL, e.nome as NOME_CLIENTE_UTIL, e.INDIR as IND_PRINC_UTIL,e.CITTA AS CITTAPRINCIPALE,e.CODPROV AS COD_PROV_PRINCIPALE,d.DESCR AS DESC_SEDE_UTIL,d.INDIR AS IND_SEDE_UTIL ,d.CITTA AS CITTA_SEDE_UTIL,d.CODPROV AS PROV_SEDE_UTIL, "+
			"(SELECT COGNOME FROM [BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI] WHERE TB_RESP_COMM=[BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI].USERNAME) AS RESPCOMM_COGNOME ,"+
			"(SELECT NOME FROM [BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI] WHERE TB_RESP_COMM=[BTOMEN_CRESCO_DATI].[dbo].[BWT_UTENTI].USERNAME) AS RESPCOMM_NOME "+
			"FROM BWT_COMMESSA AS a " +
			"LEFT JOIN BWT_ANAGEN AS b ON  a.ID_ANAGEN=b.ID_ANAGEN " +
			"LEFT JOIN BWT_ANAGEN_INDIR AS c on a.K2_ANAGEN_INDIR=c.K2_ANAGEN_INDIR AND a.ID_ANAGEN=c.ID_ANAGEN " +
			"LEFT JOIN [BTOMEN_CRESCO_DATI].[dbo].[BWT_ANAGEN_INDIR] AS d on a.K2_ANAGEN_INDIR_UTILIZ=d.K2_ANAGEN_INDIR AND a.ID_ANAGEN_UTILIZ=d.ID_ANAGEN "+
			"LEFT JOIN [BTOMEN_CRESCO_DATI].[dbo].[BWT_ANAGEN] AS e on a.ID_ANAGEN_UTILIZ=e.ID_ANAGEN "+
			"WHERE ID_COMMESSA=?";

	
	private static String querySqlAttivitaCom="SELECT a.descr as DESC_ATT,a.note AS NOTE_ATT,b.DESCR as DESC_ART,a.QTA AS QUANTITA ,a.K2_RIGA AS RIGA , a.ID_ANAART as CODICEARTICOLO, a.NOTE_AGGREG_COD as CODAGG,a.IMPORTO_UNIT as IMPORTO_U,a.UM  " +
										"from BWT_COMMESSA_AVANZ AS a " +
										"Left join BWT_ANAART AS b ON a.ID_ANAART =b.ID_ANAART " +
										"where ID_COMMESSA=? AND TB_TIPO_MILE='MILE'";

	public static ArrayList<CommessaDTO> getListaCommesse(CompanyDTO company, String categoria, UtenteDTO user, int year, boolean soloAperte) throws Exception {
		Connection con=null;
		PreparedStatement pst=null;
		PreparedStatement pstA=null;
		ResultSet rs=null;
		ResultSet rsA=null;
		
		ArrayList<CommessaDTO> listaCommesse = new ArrayList<>();
		
		try
		{
		
		con =ManagerSQLServer.getConnectionSQL();
		
		String categ="";
		
		if(!categoria.equals("")){
			
			
			String[] listaCategorie=categoria.split(";");

			for (int i = 0; i < listaCategorie.length; i++) {
				
				categ=categ+" AND TB_CATEG_COM='"+listaCategorie[i]+"'";
			}
			
		}
				
		if(user.isTras())
		{
			if(!categ.equals(""))
			{
				if(year!=0)
				{
					String query=querySqlServerComTrasWhitYear.concat(" WHERE ").concat(categ.substring(5,categ.length()));
					pst=con.prepareStatement(query);
					pst.setInt(1, year);
				}else 
				{
					String query=querySqlServerComTras.concat(" WHERE ").concat(categ.substring(5,categ.length()));
					pst=con.prepareStatement(query);
					
				}	
				
			}
			else
			{
				if(year!=0) 
				{
					pst=con.prepareStatement(querySqlServerComTrasWhitYear);
					pst.setInt(1, year);
				}else 
				{
					pst=con.prepareStatement(querySqlServerComTras);
				}
			}
		}
		else
		{
			if(year!=0) 
			{
				pst=con.prepareStatement(querySqlServerCommonWhitYear+categ);
				pst.setInt(1, company.getId());
				pst.setInt(2, year);
			}
			else 
			{
				pst=con.prepareStatement(querySqlServerCommon+categ);
				pst.setInt(1, company.getId());
			}
		}

		rs=pst.executeQuery();
		
		CommessaDTO commessa=null;
		while(rs.next())
		{
			
			commessa= new CommessaDTO();
			String idCommessa=rs.getString(1);
			commessa.setID_COMMESSA(idCommessa);
			commessa.setDT_COMMESSA(rs.getDate(2));
			commessa.setFIR_CHIUSURA_DT(rs.getDate(3));
			commessa.setID_ANAGEN(rs.getInt(4));
			commessa.setID_ANAGEN_NOME(rs.getString(5));
			commessa.setDESCR(rs.getString(6));
			commessa.setID_ANAGEN_COMM(company.getId());
			commessa.setSYS_STATO(rs.getString(7));
			commessa.setK2_ANAGEN_INDR(rs.getInt(8));
			commessa.setANAGEN_INDR_DESCR(null);
			String indirizzoSede=rs.getString(10);
			
			String cognomeResp=rs.getString("RESPCOMM_COGNOME");
			String nomeResp =rs.getString("RESPCOMM_NOME");
			if(cognomeResp!=null) 
			{
				commessa.setRESPONSABILE(cognomeResp+" "+nomeResp);
			}
	
			
			if (indirizzoSede!=null)
			{
				String provincia=rs.getString(12);
				
				if(provincia!=null && !provincia.equals("null"))
				{
					commessa.setANAGEN_INDR_INDIRIZZO(indirizzoSede+" - "+rs.getString(11)+" ("+provincia+")");
				}
				else 
				{
					commessa.setANAGEN_INDR_INDIRIZZO(indirizzoSede+" - "+rs.getString(11));
				}
			}
			else
			{
				commessa.setANAGEN_INDR_INDIRIZZO("");
			}
		
			String prov=rs.getString(15);
			if(prov!=null && !prov.equals("null")) 
			{
				commessa.setINDIRIZZO_PRINCIPALE(rs.getString(13)+" - "+rs.getString(14)+" ("+prov+")");
			}else 
			{
				commessa.setINDIRIZZO_PRINCIPALE(rs.getString(13)+" - "+rs.getString(14));
			}
			commessa.setNOTE_GEN(rs.getString(16));
			commessa.setN_ORDINE(rs.getString(17));

			commessa.setID_ANAGEN_UTIL(rs.getInt(18));
			commessa.setK2_ANAGEN_INDR_UTIL(rs.getInt(19));
			commessa.setNOME_UTILIZZATORE(rs.getString(20));
		
			String sede_util=rs.getString(25);
			
			if (sede_util!=null)
			{
				String provincia=rs.getString(27);
				if(provincia!=null && !provincia.equals("null"))
				{
					commessa.setINDIRIZZO_UTILIZZATORE(sede_util+" - "+rs.getString(26)+" ("+provincia+")");
				}
				else 
				{
					commessa.setINDIRIZZO_UTILIZZATORE(sede_util+" - "+rs.getString(26));
				}
			}
			else
			{
				String provincia=rs.getString(23);
				
				if(provincia!=null && !provincia.equals("null"))
				{
					commessa.setINDIRIZZO_UTILIZZATORE(rs.getString(21)+" - "+rs.getString(22)+" ("+provincia+")");
				}else 
				{
					commessa.setINDIRIZZO_UTILIZZATORE(rs.getString(21)+" - "+rs.getString(22));
				}
			}
			
			if(soloAperte && commessa.getSYS_STATO().equals("1APERTA")) {
				listaCommesse.add(commessa);	
			}
			if(!soloAperte) {
				listaCommesse.add(commessa);
			}
			
		}
		
		}catch (Exception e) 
		{
		throw e;
		}
		return listaCommesse;
	}

	public static CommessaDTO getCommessaById(String idCommessa) throws Exception {
		Connection con=null;
		PreparedStatement pst=null;
		PreparedStatement pstA=null;
		ResultSet rs=null;
		ResultSet rsA=null;
		
		CommessaDTO commessa=null;
		try
		{
		con =ManagerSQLServer.getConnectionSQL();
		
		
			pst=con.prepareStatement(querySqlServerComId);
	
		
		pst.setString(1, idCommessa);
		
		
	
		
		rs=pst.executeQuery();
		
		
		while(rs.next())
		{
			commessa= new CommessaDTO();

			commessa.setID_COMMESSA(idCommessa);
			commessa.setDT_COMMESSA(rs.getDate(2));
			commessa.setFIR_CHIUSURA_DT(rs.getDate(3));
			commessa.setID_ANAGEN(rs.getInt(4));
			commessa.setID_ANAGEN_NOME(rs.getString(5));
			commessa.setDESCR(rs.getString(6));
			commessa.setSYS_STATO(rs.getString(7));
			commessa.setK2_ANAGEN_INDR(rs.getInt(8));
			commessa.setANAGEN_INDR_DESCR("");
			String indirizzoSede=rs.getString(10);
			
			String cognomeResp=rs.getString("RESPCOMM_COGNOME");
			String nomeResp =rs.getString("RESPCOMM_NOME");
			if(cognomeResp!=null) 
			{
				commessa.setRESPONSABILE(cognomeResp+" "+nomeResp);
			}
			
			if (indirizzoSede!=null)
			{
				String provincia=rs.getString(12);
				if(provincia!=null && !provincia.equals("null")) 
				{
					commessa.setANAGEN_INDR_INDIRIZZO(indirizzoSede+" - "+rs.getString(11)+" ("+provincia+")");
				}else 
				{
					commessa.setANAGEN_INDR_INDIRIZZO(indirizzoSede+" - "+rs.getString(11));
				}
			}
			else
			{
				commessa.setANAGEN_INDR_INDIRIZZO("");
			}
			
			commessa.setINDIRIZZO_PRINCIPALE(rs.getString(13)+" - "+rs.getString(14)+" ("+rs.getString(15)+")");
			
			commessa.setNOTE_GEN(rs.getString(16));
			commessa.setN_ORDINE(rs.getString(17));
			
			commessa.setID_ANAGEN_UTIL(rs.getInt(19));
			commessa.setK2_ANAGEN_INDR_UTIL(rs.getInt(20));
			commessa.setNOME_UTILIZZATORE(rs.getString(21));
			
			String sede_util=rs.getString(26);
			
			if (sede_util!=null)
			{
				String provincia=rs.getString(28);
				if(provincia!=null && !provincia.equals("null")) 
				{
					commessa.setINDIRIZZO_UTILIZZATORE(sede_util+" - "+rs.getString(27)+" ("+provincia+")");
				}
				else 
				{
					commessa.setINDIRIZZO_UTILIZZATORE(sede_util+" - "+rs.getString(27));
				}
			}
			else
			{
				String provincia=rs.getString(24);
				if(provincia!=null && !provincia.equals("null")) 
				{
					commessa.setINDIRIZZO_UTILIZZATORE(rs.getString(22)+" - "+rs.getString(23)+" ("+provincia+")");
				}
				else 
				{
					commessa.setINDIRIZZO_UTILIZZATORE(rs.getString(22)+" - "+rs.getString(23));
				}
			}
			
			commessa.setID_ANAGEN_COMM(rs.getInt(18));
			
			pstA=con.prepareStatement(querySqlAttivitaCom);
			pstA.setString(1,idCommessa);
			rsA=pstA.executeQuery();

			while(rsA.next())
			{
				AttivitaMilestoneDTO attivita = new AttivitaMilestoneDTO();
				attivita.setId_riga(rsA.getInt("RIGA"));
				attivita.setDescrizioneAttivita(rsA.getString("DESC_ATT"));
				attivita.setNoteAttivita(rsA.getString("NOTE_ATT"));
				attivita.setDescrizioneArticolo(rsA.getString("DESC_ART"));
				attivita.setQuantita(rsA.getString("QUANTITA"));
				attivita.setCodiceArticolo(rsA.getString("CODICEARTICOLO"));
				attivita.setImporto_unitario(rsA.getDouble("IMPORTO_U"));
				String um=rsA.getString("UM");
				attivita.setUnitaMisura(um == null ? "" : um);
				
				String codAggreg=rsA.getString("CODAGG");
				
				if(codAggreg!=null)
				{
					ArrayList<AttivitaMilestoneDTO> listaAttivitaAggregate=getListaAttivitaAggregate(con,codAggreg,attivita);
					
					for(AttivitaMilestoneDTO attivitaAggragata: listaAttivitaAggregate)
					{
						commessa.getListaAttivita().add(attivitaAggragata);
					}
				}
				else
				{
					attivita.setCodiceAggregatore("CAMPIONAMENTO_"+attivita.getId_riga());
					commessa.getListaAttivita().add(attivita);
				}
		
				
				
				
			}
			rsA.close();
			pstA.close();
			
			
		}
		
		}catch (Exception e) 
		{
		throw e;
		}
		return commessa;
	}

	private static ArrayList<AttivitaMilestoneDTO> getListaAttivitaAggregate(Connection con, String codAggreg, AttivitaMilestoneDTO attivita) throws Exception {
		
		ArrayList<AttivitaMilestoneDTO> listaAttivita= new ArrayList<AttivitaMilestoneDTO>();
		
		try 
		{
			String[] listaArticoli=codAggreg.split(",");
		
			for (int i = 0; i < listaArticoli.length; i++) {
				
				PreparedStatement pst= con.prepareStatement(queryArticoli);
				pst.setString(1, listaArticoli[i]);
				
				ResultSet rs =pst.executeQuery();
				
				AttivitaMilestoneDTO att=null;
				
				while(rs.next())
				{
					att= new AttivitaMilestoneDTO();
					att.setId_riga(attivita.getId_riga());
					att.setDescrizioneAttivita(attivita.getDescrizioneAttivita());
					att.setNoteAttivita("");
					att.setDescrizioneArticolo(rs.getString("DESCR"));
					att.setQuantita("1");
					att.setCodiceArticolo(rs.getString("ID_ANAART"));
					att.setCodiceAggregatore("CAMPIONAMENTO_"+attivita.getId_riga());
				    
				    listaAttivita.add(att);
				}
				
				
			}
			
		} 
		catch (Exception e) {
			throw e;
		}
		return listaAttivita;
	}

	

}
