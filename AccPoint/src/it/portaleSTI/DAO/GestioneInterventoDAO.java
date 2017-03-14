package it.portaleSTI.DAO;

import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class GestioneInterventoDAO {
	
	private final static String sqlQuery_Inervento="select a.id,presso_destinatario,id__SEDE_, nome_sede , data_creazione , b.descrizione, u.NOMINATIVO " +
			"from intervento  a " +
			"Left join stato_intervento  b  ON a.id_stato_intervento=b.id  " +
			"left join users u on a.id__user_creation=u.ID " +
			"where id_Commessa=?";

	

	public static ArrayList<InterventoDTO> getListaInterventi(String idCommessa) throws Exception {
		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		
		ArrayList<InterventoDTO> listaInterventi = new ArrayList<>();
		
		try
		{
			con=DirectMySqlDAO.getConnection();
			pst=con.prepareStatement(sqlQuery_Inervento);
			pst.setString(1, idCommessa);
			InterventoDTO intervento = null;
			rs=pst.executeQuery();
			
			
			while(rs.next()){
				intervento=new InterventoDTO();
				intervento.setId(rs.getInt("ID"));
				intervento.setDataCreazione(rs.getDate("data_creazione"));
				intervento.setPressoDestinatario(rs.getInt("presso_destinatario"));
				intervento.setIdSede(rs.getInt("id__SEDE_"));
				intervento.setNome_sede(rs.getString("nome_sede"));
				intervento.setRefStatoIntervento(rs.getString("b.descrizione"));
				intervento.setRefUtenteCreazione(rs.getString("u.NOMINATIVO"));
				
				listaInterventi.add(intervento);
			}			
		}
		catch (Exception e) 
		{
		
		throw e;
		}
		return listaInterventi;
	}
}
