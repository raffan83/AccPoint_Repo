package it.portaleSTI.bo;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.mail.EmailException;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneDeviceDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.DevAllegatiDeviceDTO;
import it.portaleSTI.DTO.DevAllegatiSoftwareDTO;
import it.portaleSTI.DTO.DevContrattoDTO;
import it.portaleSTI.DTO.DevDeviceDTO;
import it.portaleSTI.DTO.DevDeviceMonitorDTO;
import it.portaleSTI.DTO.DevDeviceSoftwareDTO;
import it.portaleSTI.DTO.DevLabelConfigDTO;
import it.portaleSTI.DTO.DevLabelTipoInterventoDTO;
import it.portaleSTI.DTO.DevProceduraDTO;
import it.portaleSTI.DTO.DevProceduraDeviceDTO;
import it.portaleSTI.DTO.DevRegistroAttivitaDTO;
import it.portaleSTI.DTO.DevSoftwareDTO;
import it.portaleSTI.DTO.DevStatoValidazioneDTO;
import it.portaleSTI.DTO.DevTestoEmailDTO;
import it.portaleSTI.DTO.DevTipoDeviceDTO;
import it.portaleSTI.DTO.DevTipoEventoDTO;
import it.portaleSTI.DTO.DevTipoLicenzaDTO;
import it.portaleSTI.DTO.DevTipoProceduraDTO;
import it.portaleSTI.DTO.ForMembriGruppoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;

public class GestioneDeviceBO {

	public static ArrayList<DevSoftwareDTO> lista_software_errori;
	public static ArrayList<DevContrattoDTO> lista_contratti_errori;
	
	
	public static ArrayList<DevTipoDeviceDTO> getListaTipiDevice(Session session) {
		
		return GestioneDeviceDAO.getListaTipiDevice(session);
	}

	public static DevTipoDeviceDTO getTipoDeviceFromID(int id_tipo_device, Session session) {
		
		return GestioneDeviceDAO.getTipoDeviceFromID(id_tipo_device, session);
	}

	public static ArrayList<DevDeviceDTO> getListaDevice(int id_company, Session session) {
		
		return GestioneDeviceDAO.getListaDevice(id_company,session);
	}

	public static DevDeviceDTO getDeviceFromID(int id_device, Session session) {

		return GestioneDeviceDAO.getDeviceFromID(id_device,  session);
	}

	public static ArrayList<DevSoftwareDTO> getListaSoftware(Session session) {
		
		return GestioneDeviceDAO.getListaSoftware(session);
	}

	public static ArrayList<DevStatoValidazioneDTO> getListaStatiValidazione(Session session) {
		
		return GestioneDeviceDAO.getListaStatiValidazione(session);
	}

	public static DevSoftwareDTO getSoftwareFromID(int id_seftware, Session session) {
		
		return  GestioneDeviceDAO.getSoftwareFromID(id_seftware,session);
	}

	public static ArrayList<DevRegistroAttivitaDTO> getRegistroAttivitaFromDevice(DevDeviceDTO device,int id_company, int tipo_evento, Session session) {
		
		return GestioneDeviceDAO.getRegistroAttivitaFromDevice(device,id_company, tipo_evento, session);
	}

	public static ArrayList<DevTipoEventoDTO> geListaTipiEvento(Session session) {
		
		return GestioneDeviceDAO.geListaTipiEvento(session);
	}

	public static DevRegistroAttivitaDTO getRegistroAttivitaFromID(int id_attivita, Session session) {
		
		return GestioneDeviceDAO.getRegistroAttivitaFromID(id_attivita, session);
	}

	public static ArrayList<DevLabelConfigDTO> getListaLabelConfigurazioni(Session session) {
		
		return GestioneDeviceDAO.getListaLabelConfigurazioni(session);
	}

	public static ArrayList<DevProceduraDTO> getListaProcedure(Session session) {
		
		return GestioneDeviceDAO.getListaProcedure( session);
	}
	
	public static ArrayList<DevProceduraDeviceDTO> getListaProcedureDevice(int id_device, Session session) {
		
		return GestioneDeviceDAO.getListaProcedureDevice(id_device, session);
	}

	public static ArrayList<DevTipoProceduraDTO> getListaTipiProcedure(Session session) {

		return GestioneDeviceDAO.getListaTipiProcedure(session);
	}

	public static DevProceduraDTO getProceduraFromID(int id_procedura, Session session) {
		
		return GestioneDeviceDAO.getProceduraFromID(id_procedura, session);
	}

	public static ArrayList<DevAllegatiDeviceDTO> getListaAllegatiDevice(int id_device, Session session) {
	
		return GestioneDeviceDAO.getListaAllegatiDevice(id_device, session);
	}
	
	public static ArrayList<DevAllegatiSoftwareDTO> getListaAllegatiSoftware(int id_software, Session session) {
		
		return GestioneDeviceDAO.getListaAllegatiSoftware(id_software, session);
	}

	public static DevAllegatiDeviceDTO getAllegatoDeviceFromID(int id_device, Session session) {
		
		return GestioneDeviceDAO.getAllegatoDeviceFromID(id_device, session);
	}
	
	public static DevAllegatiSoftwareDTO getAllegatoSoftwareFromID(int id_software, Session session) {
		
		return GestioneDeviceDAO.getAllegatoSoftwareFromID(id_software, session);
	}

	public static ArrayList<DevDeviceSoftwareDTO> getListaDeviceSoftware(int id_device, Session session) {
		
		return GestioneDeviceDAO.getListaDeviceSoftware(id_device, session);
	}

	public static void dissociaSoftware(int id, Session session) {

		GestioneDeviceDAO.dissociaSoftware(id, session);
		
	}

	public static ArrayList<DevLabelTipoInterventoDTO> geListaLabelTipoIntervento(Session session) {
		
		return GestioneDeviceDAO.geListaLabelTipoIntervento(session);
	}

	public static ArrayList<DevRegistroAttivitaDTO> getListaScadenze(String dateFrom, String dateTo, int company, Session session) throws ParseException, Exception {

		return GestioneDeviceDAO.getListaScadenze(dateFrom, dateTo,company,session);
	}

	public static void sendEmailAttivitaScadute() throws ParseException, Exception {
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		Date today = new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(today);
	//	cal.add(Calendar.DATE, 15);
		Date nextDate = cal.getTime();
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		//ArrayList<DevRegistroAttivitaDTO> lista_scadenze = GestioneDeviceDAO.getListaScadenzeScheduler(df.format(nextDate), df.format(nextDate), 0,session);
		ArrayList<DevRegistroAttivitaDTO> lista_scadenze = GestioneDeviceDAO.getListaScadenzeScheduler(df.format(today),0,session);
		
		DevTestoEmailDTO testo_email = getTestoEmail(session);
		
		for (DevRegistroAttivitaDTO attivita : lista_scadenze) {
			
			if(attivita.getEmail_inviata()==0) {
				SendEmailBO.sendEmailScadenzaAttivitaDevice(attivita, testo_email.getDescrizione(), testo_email.getReferenti());	
				attivita.setEmail_inviata(1);
				cal.setTime(today);
				cal.add(Calendar.DATE, 45);				
				attivita.setData_invio_sollecito(cal.getTime());
				session.update(attivita);
				
			}
		}
		session.getTransaction().commit();
		session.close();
		
	}

	public static void esportaListaSoftware(ArrayList<DevSoftwareDTO> lista_software, String company) throws IOException {
		
		
			
	        XSSFWorkbook workbook = new XSSFWorkbook();         
	           
			 XSSFSheet sheet0 = workbook.createSheet("Lista Software");
			 
			 workbook.setSheetOrder("Lista Software", 0);
			 workbook.setActiveSheet(0);
			 sheet0.setSelected(true);
			 
			 
			 sheet0.setMargin(Sheet.RightMargin, 0.39);
			 sheet0.setMargin(Sheet.LeftMargin, 0.39);
			 sheet0.setMargin(Sheet.TopMargin, 0.39);
			 sheet0.setMargin(Sheet.BottomMargin, 0.39);
			 sheet0.setMargin(Sheet.HeaderMargin, 0.157);
			 sheet0.setMargin(Sheet.FooterMargin, 0.39);		
			 Font headerFont = workbook.createFont();
		     headerFont.setBold(false);
		     headerFont.setFontHeightInPoints((short) 12);
		     headerFont.setColor(IndexedColors.BLACK.getIndex());		
			 

			
		     CellStyle titleStyle = workbook.createCellStyle();
		        
		     titleStyle.setBorderBottom(BorderStyle.THIN);
		     titleStyle.setBorderTop(BorderStyle.THIN);
		     titleStyle.setBorderLeft(BorderStyle.THIN);
		     titleStyle.setBorderRight(BorderStyle.THIN);
		     titleStyle.setAlignment(HorizontalAlignment.CENTER);
		     titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		     titleStyle.setFont(headerFont);
		     
		     
			 Row rowHeader = sheet0.createRow(0);
	
			 for(int j = 0; j<4; j++) {
				 rowHeader.createCell(j);
				 
				 rowHeader.getCell(j).setCellStyle(titleStyle);
			 }
			 sheet0.addMergedRegion(CellRangeAddress.valueOf("A1:D1"));	
			 sheet0.getRow(0).getCell(0).setCellValue("Lista Software "+company);
			 
			 rowHeader = sheet0.createRow(1);
			 
			 
			 for(int j = 0; j<4; j++) {
				 rowHeader.createCell(j);
				 
				 rowHeader.getCell(j).setCellStyle(titleStyle);
			 }
			 
		
			 sheet0.getRow(1).getCell(0).setCellValue("ID Software");
			 
			 sheet0.getRow(1).getCell(1).setCellValue("Denominazione");
			 
			 sheet0.getRow(1).getCell(2).setCellValue("Produttore");		 
			 		 
			 sheet0.getRow(1).getCell(3).setCellValue("Versione");		 
			 
			
			 
	  
		     int row_index = 0;	        
		     for (int i = 0; i<lista_software.size();i++) {
		    	 
		    	 Row row = sheet0.createRow(2+row_index);
		    	 
		    	 DevSoftwareDTO software = lista_software.get(i);
		    	 
		    	 int col = 0;
		    	 
		    	 Cell cell = row.createCell(col);		    	 
		    		 
		    	 cell.setCellValue(""+software.getId());
		    	 
		    	 col++;
		    	 cell = row.createCell(col);
		    	 
		    	 if(software.getNome()!=null) {
		    		 cell.setCellValue(software.getNome());
		    		 
		    	 }else {
		    		 cell.setCellValue("");
		    	 }
		    	 col++;
		    	 cell = row.createCell(col);
				if(software.getProduttore()!=null) {
					cell.setCellValue(software.getProduttore());   		 
				}else {
					cell.setCellValue("");	    		 
				}
				 col++;
		    	 cell = row.createCell(col);
				if(software.getVersione()!=null) {
					cell.setCellValue(software.getVersione());
				}else {
					cell.setCellValue("");
				}
				
				row_index++;
		    	 
		     }
		    	 for(int j = 0; j<20;j++) {
		    		 sheet0.autoSizeColumn(j);
		    	 }
		     

		 		String path = Costanti.PATH_FOLDER + "Device\\";
		 		
		 		DateFormat df = new SimpleDateFormat("ddMMyyyy");			
		 		
		 		if(!new File(path).exists()) {
		 			new File(path).mkdirs();
		 		}
		        FileOutputStream fileOut = new FileOutputStream(path +"ListaSoftware"+df.format(new Date())+".xlsx");
		        workbook.write(fileOut);
		        fileOut.close();

		        workbook.close();
		  
		 
		
	}
	
//public static void sendEmailAttivitaScaduteSollecito() throws ParseException, Exception {
//		
//		Session session=SessionFacotryDAO.get().openSession();
//		session.beginTransaction();
//		
//		
//		
//			
//		ArrayList<DevRegistroAttivitaDTO> lista_scadenze = GestioneDeviceDAO.getListaScadenzeEmailInviata(session);
//		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
//		for (DevRegistroAttivitaDTO attivita : lista_scadenze) {
//			Date data_attivita = attivita.getData_evento();
//			Calendar cal = Calendar.getInstance();
//			cal.setTime(data_attivita);
//			cal.add(Calendar.DATE, 45);
//			Date nextDate = cal.getTime();
//			if(!nextDate.after(new Date())) {
//			
//				ArrayList<DevRegistroAttivitaDTO> lista_manutenzioni = GestioneDeviceDAO.getListaManutenzioniSuccessive(df.format(nextDate), attivita.getDevice().getId(),session);
//				
//				if(lista_manutenzioni.size()==0) {
//					DevTestoEmailDTO testo_email = getTestoEmail(session);
//					
//					
//					if(attivita.getSollecito_inviato() == 1) {
//						if(attivita.getData_invio_sollecito()!=null) {
//							cal = Calendar.getInstance();
//							cal.setTime(attivita.getData_invio_sollecito());
//							cal.add(Calendar.DATE, 30);
//							Date d = cal.getTime();
//							
//							if(d.equals(new Date()) || d.before(new Date())) {
//							//	SendEmailBO.sendEmailScadenzaAttivitaDevice(attivita, testo_email.getSollecito(), testo_email.getReferenti());
//								attivita.setData_invio_sollecito(new Date());
//								session.update(attivita);
//							}
//							
//						}
//						
//					}else {
//					//	SendEmailBO.sendEmailScadenzaAttivitaDevice(attivita, testo_email.getSollecito(), testo_email.getReferenti());
//						attivita.setSollecito_inviato(1);
//						attivita.setData_invio_sollecito(new Date());
//						session.update(attivita);
//						
//					}
//					
//				}
//			}
//			
//			
//		}
////		Calendar cal = Calendar.getInstance();
////		cal.setTime(today);
////		cal.add(Calendar.DATE, 30);
////		Date nextDate = cal.getTime();
////		
////	
////		
////		ArrayList<DevRegistroAttivitaDTO> lista_scadenze = GestioneDeviceDAO.getListaScadenze(df.format(nextDate), df.format(nextDate), 0,session);
////		
////		DevTestoEmailDTO testo_email = getTestoEmail(session);
////		
////		for (DevRegistroAttivitaDTO attivita : lista_scadenze) {
////			
////			if(attivita.getEmail_inviata()==0) {
////				SendEmailBO.sendEmailScadenzaAttivitaDevice(attivita, testo_email.getDescrizione(), testo_email.getReferenti());	
////				attivita.setEmail_inviata(1);
////				session.update(attivita);
////			}
////		}
//		session.getTransaction().commit();
//		session.close();
//		
//	}
	
	
//public static void sendEmailAttivitaScaduteSollecito() throws ParseException, Exception {
//		
//		Session session=SessionFacotryDAO.get().openSession();
//		session.beginTransaction();
//		
//		
//		ArrayList<DevRegistroAttivitaDTO> lista_scadenze = GestioneDeviceDAO.getListaScadenzeEmailInviata(session);
//		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
//		 LocalDate today = LocalDate.now();
//
//		for (DevRegistroAttivitaDTO attivita : lista_scadenze) {
//			Date data_sollecito = attivita.getData_invio_sollecito();
//			if(data_sollecito!=null) {
//				System.out.println(data_sollecito);	
//				java.sql.Date sqlDate = new java.sql.Date(data_sollecito.getTime());
//				LocalDate dataSollecitoLocalDate = sqlDate.toLocalDate();
//				 
//			
//			
//			if(dataSollecitoLocalDate!=null && dataSollecitoLocalDate.equals(today)) {
//				ArrayList<DevRegistroAttivitaDTO> lista_manutenzioni = GestioneDeviceDAO.getListaManutenzioniSuccessive(attivita.getId()+"", attivita.getDevice().getId(),session);
//				
//				if(lista_manutenzioni.size()==0) {
//					DevTestoEmailDTO testo_email = getTestoEmail(session);
//					
//			
//						Calendar cal = Calendar.getInstance();
//						cal = Calendar.getInstance();
//						
//						cal.add(Calendar.DATE, 30);
//						Date d = cal.getTime();
//						
//						attivita.setSollecito_inviato(1);
//						
//						//	SendEmailBO.sendEmailScadenzaAttivitaDevice(attivita, testo_email.getSollecito(), testo_email.getReferenti());
//							attivita.setData_invio_sollecito(d);
//							session.update(attivita);					
//				
//							
//						
//					}
//				}
//			
//			
//			}
//			}
//			
//			
//		
//
//		session.getTransaction().commit();
//		session.close();
//		
//	}
	
public static void sendEmailAttivitaScaduteSollecito() throws ParseException, Exception {
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		Date today = new Date();

		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		ArrayList<DevRegistroAttivitaDTO> lista_scadenze = GestioneDeviceDAO.getListaScadenzeScheduler(df.format(today), 1, session);

		for (DevRegistroAttivitaDTO attivita : lista_scadenze) {
			DevTestoEmailDTO testo_email = getTestoEmail(session);
			
			
			Calendar cal = Calendar.getInstance();
			cal = Calendar.getInstance();
							
			cal.add(Calendar.DATE, 30);
			Date d = cal.getTime();
							
			attivita.setSollecito_inviato(1);
							
				SendEmailBO.sendEmailScadenzaAttivitaDevice(attivita, testo_email.getSollecito(), testo_email.getReferenti());
			attivita.setData_invio_sollecito(d);
			session.update(attivita);
		}
	

		session.getTransaction().commit();
		session.close();
		
	}
	
	public static DevTestoEmailDTO getTestoEmail(Session session) {
		
		return GestioneDeviceDAO.getTestoEmail(session);
	}

	public static void dissociaProcedura(int id, Session session) {
		
		GestioneDeviceDAO.dissociaProcedura(id, session);
	}

	public static ArrayList<DevDeviceDTO> getListaDeviceArchiviati(int id_company, Session session) {
		
		return GestioneDeviceDAO.getListaDeviceArchiviati(id_company, session);
	}

	public static ArrayList<DevSoftwareDTO> getListaSoftwareCompany(int id_company, Session session) {
		// TODO Auto-generated method stub
		return GestioneDeviceDAO.getListaSoftwareCompany(id_company, session);
	}

	public static ArrayList<DevDeviceDTO> getListaMonitor(Session session) {
		
		return GestioneDeviceDAO.getListaMonitor( session);
	}

	public static ArrayList<DevDeviceMonitorDTO> getListaMonitorDevice(int id_device ,Session session) {
		// TODO Auto-generated method stub
		return GestioneDeviceDAO.getListaMonitorDevice(id_device, session);
	}
	
	public static void dissociaMonitor(int id, Session session) {

		GestioneDeviceDAO.dissociaMonitor(id, session);
		
	}

	public static ArrayList<DevDeviceDTO> getListaDeviceNoMan(int id_company, Session session) {
		
		return GestioneDeviceDAO.getListaDeviceNoMan(id_company, session);
	}

	public static ArrayList<DevDeviceDTO> getListaDeviceManScad(int id_company, Session session) throws ParseException, Exception {
		// TODO Auto-generated method stub
		return GestioneDeviceDAO.getListaDeviceManScad(id_company, session);
	}

	public static ArrayList<DevTipoLicenzaDTO> getListaTipiLicenze(Session session) {
		// TODO Auto-generated method stub
		return GestioneDeviceDAO.getListaTipiLicenze(session);
	}

	public static ArrayList<DevSoftwareDTO> getListaSoftwareFiltro(int id_company) throws Exception {
		// TODO Auto-generated method stub
		return DirectMySqlDAO.getListaSoftwareFiltro(id_company);
	}

	public static void updateSoftwareObsoleti() {

		GestioneDeviceDAO.updateSoftwareObsoleti();
	}

	public static void sendEmailScadenzaSoftware() throws Exception {

		
			
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
			Date today = new Date();
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(today);
		//	cal.add(Calendar.DATE, 15);
			Date nextDate = cal.getTime();
			
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			
			//ArrayList<DevRegistroAttivitaDTO> lista_scadenze = GestioneDeviceDAO.getListaScadenzeScheduler(df.format(nextDate), df.format(nextDate), 0,session);
			ArrayList<DevSoftwareDTO> lista_scadenze_software = GestioneDeviceDAO.getListaScadenzeSoftware(df.format(today),session);
			//ArrayList<DevContrattoDTO> lista_scadenze_contratti = GestioneDeviceDAO.getListaScadenzeContratto(df.format(today),session);
			ArrayList<DevContrattoDTO> lista_scadenze_contratti = GestioneDeviceDAO.getListaRemindContratto(df.format(today),session);
			
			
			lista_contratti_errori = new ArrayList<DevContrattoDTO>();
			for (DevContrattoDTO c : lista_scadenze_contratti) {
				
				try {
					
					SendEmailBO.sendEmailScadenzaContratto(c);	
				
//					cal.setTime(today);
//					cal.add(Calendar.DATE, 30);				
//					software.setData_invio_remind(cal.getTime());
//					session.update(software);
				}catch (Exception e) {
					e.printStackTrace();
					lista_contratti_errori.add(c);
					
				}
				
			
				
			}
			
			
			lista_software_errori = new ArrayList<DevSoftwareDTO>();
			for (DevSoftwareDTO software : lista_scadenze_software) {
				try {
	
					SendEmailBO.sendEmailScadenzaSoftware(software);	
				
					cal.setTime(today);
					cal.add(Calendar.DATE, 30);				
					software.setData_invio_remind(cal.getTime());
					session.update(software);
				}catch (Exception e) {
					e.printStackTrace();
					lista_software_errori.add(software);
					
				}
				
			}
			session.getTransaction().commit();
			session.close();
			
			if(lista_software_errori.size()>0) {
				
				String messaggio = "Non è stato possibile recapitare il remind di scadenza per i seguenti Software:<br><br>";
				for (DevSoftwareDTO software : lista_software_errori) {
					messaggio+= "ID: "+software.getId()+" Descrizione: "+software.getNome()+"<br>";	
				}
				
			
					Utility.sendEmail("antonio.dicivita@ncsnetwork.it","Errore invio Remind scadenza Software",messaggio);
			}
			
		
	}

	public static ArrayList<DevContrattoDTO> getListaContratto(Session session) {
		
		return GestioneDeviceDAO.getListaContratto(session);
	}

	public static ArrayList<DevSoftwareDTO> getListaContrattoSoftware(int id_contratto, Session session) {
		
		return GestioneDeviceDAO.getListaContrattoSoftware(id_contratto, session);
	}

	public static DevContrattoDTO getContrattoFromID(int id_contratto, Session session) {
		
		return GestioneDeviceDAO.getContrattoFromId(id_contratto, session);
	}

	public static ArrayList<DevDeviceSoftwareDTO> getListaSoftwareDevice(int id, Session session) {
		
		return GestioneDeviceDAO.getListaSoftwareDevice(id, session);
	}

	public static void updateScadenzaContratti() throws HibernateException, ParseException {
		
		GestioneDeviceDAO.updateScadenzaContratti(); 
	}

	public static ArrayList<DevSoftwareDTO> getListaSoftwareArchiviati(Session session) {
		
		return GestioneDeviceDAO.getListaSoftwareArchiviati(session);
	}
}
