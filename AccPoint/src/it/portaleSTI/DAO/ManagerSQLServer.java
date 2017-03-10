package it.portaleSTI.DAO;

import java.sql.Connection;
import java.sql.DriverManager;

public class ManagerSQLServer {

	public static Connection getConnectionSQL()throws Exception
	{
		Connection con=null;
		
		try
		{
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			con = DriverManager.getConnection("jdbc:sqlserver://158.58.172.111:1433;databaseName=BTOMEN_CRESCO_DATI","fantini","fantini");
			
			
		}
		catch(Exception e)
		{
			throw e;
		}
		return con;
		
		
	}
}
