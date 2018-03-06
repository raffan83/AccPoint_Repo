package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneCertificatoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoCampioneDTO;
import it.portaleSTI.DTO.DatasetCampionamentoDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.PlayloadCampionamentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCampionamentoBO;
import it.portaleSTI.bo.GestioneCampioneBO;
import it.portaleSTI.bo.GestioneCertificatoBO;
import it.portaleSTI.bo.GestioneInterventoCampionamentoBO;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.TreeMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.Session;

import com.google.gson.JsonObject;

/**
 * Servlet implementation class ScaricaCertificato
 */
@WebServlet(name= "/scaricaSchedaCampionamento", urlPatterns = { "/scaricaSchedaCampionamento.do" })
public class ScaricaSchedaCampionamento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScaricaSchedaCampionamento() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("static-access")
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();	
		
	
		
		try
		{
			
			
			String action=request.getParameter("action");
			
			
			if(action.equals("schedaCampionamento"))
			{
				String nomePack= request.getParameter("nomePack");
			 	

			 
			     File d = new File(Costanti.PATH_FOLDER+"//"+nomePack+"//"+nomePack+".pdf");
				 
				 FileInputStream fileIn = new FileInputStream(d);
				 
				 response.setContentType("application/octet-stream");
				 
				 response.setHeader("Content-Disposition","attachment;filename="+nomePack+".pdf");
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				     }
				    
				    
				    fileIn.close();
			
				    outp.flush();
				    outp.close();
			 	 
			}
			if(action.equals("exportSchedaCampionamento"))
			{
				String id= request.getParameter("id");
			 	
				InterventoCampionamentoDTO intervento = GestioneInterventoCampionamentoBO.getIntervento(id);
				ArrayList<DatasetCampionamentoDTO> listaDataset = GestioneCampionamentoBO.getListaDataset(intervento.getTipoMatrice().getId(),intervento.getTipoAnalisi().getId());
				LinkedHashMap<Integer,ArrayList<PlayloadCampionamentoDTO>> listaPayload = GestioneCampionamentoBO.getListaPayload(intervento.getId(),session);
				
			
				
				 //Blank workbook
		        XSSFWorkbook workbook = new XSSFWorkbook();
		         
		        //Create a blank sheet
		        XSSFSheet sheet = workbook.createSheet("Employee Data");
		          
		        //This data needs to be written (Object[])
		        Map<String, Object[]> data = new TreeMap<String, Object[]>();
		        
		        Object[] objs = new Object[listaDataset.size()];
		        int iterator = 1;
		        for(int i = 0; i < listaDataset.size(); i++) {
		        	
		        		DatasetCampionamentoDTO dataset = listaDataset.get(i);
		        		objs[i] = dataset.getNomeCampo();
				}
		        data.put(""+iterator, objs);
		        iterator ++;
		        for (Entry<Integer, ArrayList<PlayloadCampionamentoDTO>> entry : listaPayload.entrySet()) {
		            Integer key = entry.getKey();
		            ArrayList<PlayloadCampionamentoDTO> value = entry.getValue();
		            Object[] objsP = new Object[value.size()];
		            for(int j = 0; j < value.size(); j++) {
			        	
		            	PlayloadCampionamentoDTO playload = value.get(j);
			        		objsP[j] = playload.getValore_misurato();
		            }
		            data.put(""+iterator, objsP);
		            iterator ++;
		        }
		
		          
		        //Iterate over data and write to sheet
		        Set<String> keyset = data.keySet();
		        int rownum = 0;
		        for (String key : keyset)
		        {
		            Row row = sheet.createRow(rownum++);
		            Object [] objArr = data.get(key);
		            int cellnum = 0;
		            for (Object obj : objArr)
		            {
		               Cell cell = row.createCell(cellnum++);
		               if(obj instanceof String)
		                    cell.setCellValue((String)obj);
		                else if(obj instanceof Integer)
		                    cell.setCellValue((Integer)obj);
		            }
		        }
		       
		        File d = new File(Costanti.PATH_FOLDER+"//"+intervento.getNomePack()+"//excel_"+intervento.getNomePack()+".xlsx");
		        
		            //Write the workbook in file system
		            FileOutputStream out = new FileOutputStream(d);
		            workbook.write(out);


		           
					 
					 FileInputStream fileIn = new FileInputStream(d);
					 
					 response.setContentType("application/octet-stream");
					 
					 response.setHeader("Content-Disposition","attachment;filename=excel_"+intervento.getNomePack()+".xlsx");
					 
					 ServletOutputStream outp = response.getOutputStream();
					     
					    byte[] outputByte = new byte[1];
					    
					    while(fileIn.read(outputByte, 0, 1) != -1)
					    {
					    	outp.write(outputByte, 0, 1);
					     }
					    
					    
					    fileIn.close();
				
					    outp.flush();
					    outp.close();

		       
			 	 
			}
			
		
			
		
		}
		catch(Exception ex)
    	{
			
   		 ex.printStackTrace();
   		 session.getTransaction().rollback();
   		 session.close();
   		 
   	//	 jsono.addProperty("success", false);
   	//	 jsono.addProperty("messaggio",ex.getMessage());
		
   	     request.setAttribute("error",STIException.callException(ex));
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	}  
	}

}
