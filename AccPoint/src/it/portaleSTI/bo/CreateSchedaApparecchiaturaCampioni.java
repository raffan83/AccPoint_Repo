package it.portaleSTI.bo;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.jasperreports.engine.JREmptyDataSource;

public class CreateSchedaApparecchiaturaCampioni {

	public CreateSchedaApparecchiaturaCampioni(CampioneDTO campione, boolean registro_eventi, Session session) throws Exception {
		
		
		 build(campione,registro_eventi, session);
	}
	
	
	private void build(CampioneDTO campione, boolean isCDT, Session session) throws Exception {

		InputStream is =  null;
		
		if(!isCDT) {
			is = PivotTemplate.class.getResourceAsStream("scheda_apparecchiatura_evento.jrxml");
		}else {
			is = PivotTemplate.class.getResourceAsStream("scheda_anagrafica_campione.jrxml");			
		}
				

		JasperReportBuilder report = DynamicReports.report();
			
	
			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);
			
			report.addParameter("codice_interno", campione.getCodice());
			report.addParameter("denominazione", campione.getNome() +" "+campione.getDescrizione());
			report.addParameter("modello", campione.getModello());
			report.addParameter("costruttore", campione.getCostruttore());
			report.addParameter("matricola", campione.getMatricola());
			
			if(campione.getDistributore()!=null) {
				report.addParameter("distributore", campione.getDistributore());
			}else {
				report.addParameter("distributore", "");
			}
			SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy"); 
			
			if( campione.getData_acquisto()==null) {
				report.addParameter("data_acquisto","");
			}else {
				report.addParameter("data_acquisto", dt.format(campione.getData_acquisto()));
				}		
			
			
			if(campione.getUnita_formato()!=null) {
				report.addParameter("unita_formato", campione.getUnita_formato());
			}else {
				report.addParameter("unita_formato", "");
			}
			
			if(campione.getUbicazione()!=null) {
				report.addParameter("ubicazione", campione.getUbicazione());
			}else {
				report.addParameter("ubicazione", "");
			}
			
			if(!isCDT) {
				if(campione.getCampo_accettabilita()!=null) {
					report.addParameter("campo_accettabilita", campione.getCampo_accettabilita());
				}else {
					report.addParameter("campo_accettabilita", "");
				}
				
				if(campione.getData_messa_in_servizio()!=null) {
					report.addParameter("data_registrazione", dt.format(campione.getData_messa_in_servizio())); 
				}else {
					report.addParameter("data_registrazione", ""); 	
				}
				
//				report.addParameter("condizioni_utilizzo", ""); //MANCA CONDIZIONI UTILIZZO
				if(campione.getCampo_misura()!=null) {
					report.addParameter("campi_misura", campione.getCampo_misura());
				}else {
					report.addParameter("campi_misura", "");
				}
			}else {
				
							
				if(campione.getCampo_misura()!=null) {
					report.addParameter("campi_misura", campione.getCampo_misura());
				}else {
					report.addParameter("campi_misura", "");
				}
				
				if(campione.getData_messa_in_servizio()!=null) {
					report.addParameter("messa_in_servizio", dt.format(campione.getData_messa_in_servizio())); 
				}else {
					report.addParameter("messa_in_servizio", ""); 	
				}
				
				
				
			}
			
			
			
			if(campione.getDescrizione_verifica_intermedia()!=null) {
				report.addParameter("attivita_verifica", campione.getDescrizione_verifica_intermedia());
			}else{
				report.addParameter("attivita_verifica", "");	
			}
			
			report.addParameter("frequenza_verifica_intermedia", campione.getFrequenza_verifica_intermedia());
			
			
			if(campione.getTipo_campione()!=null && campione.getTipo_campione().getNome()!=null) {
				report.addParameter("classificazione", campione.getTipo_campione().getNome());
			}else {
				report.addParameter("classificazione", "");
			}
			report.addParameter("frequenza", campione.getFreqTaraturaMesi());
			
			String attivita_taratura = campione.getAttivita_di_taratura();
			
			if(attivita_taratura!=null && !attivita_taratura.equals("")) {
				if(attivita_taratura.equals("INTERNA")) {
					report.addParameter("attivita_taratura", attivita_taratura);
				}else {
					report.addParameter("attivita_taratura", "ESTERNA Presso: "+attivita_taratura);
				}
			}else {
				report.addParameter("attivita_taratura", "");
			}
			
			if(campione.getNote_attivita()!=null) {
				report.addParameter("descrizione_attivita_taratura", campione.getNote_attivita());
			}else {
				report.addParameter("descrizione_attivita_taratura", "");
			}
			
//			String attivita_manutenzione = "- ";
//			
//			if(registro_eventi) {
//				
//				ArrayList<RegistroEventiDTO> lista_evento_manutenzione = GestioneCampioneBO.getListaEvento(campione.getId(), 1, session);
//				
//				for(int i = 0; i<lista_evento_manutenzione.size(); i++) {
//					if(lista_evento_manutenzione.get(i).getTipo_manutenzione().getId()==1) {
//						if(lista_evento_manutenzione.get(i).getDescrizione()!= null) {
//							attivita_manutenzione =attivita_manutenzione + lista_evento_manutenzione.get(i).getDescrizione() +"\n- ";	
//						}											
//					}
//				}
//				attivita_manutenzione = attivita_manutenzione.substring(0, attivita_manutenzione.length()-2);
//				
//			}else {
//				ArrayList<AcAttivitaCampioneDTO> lista_manutenzioni = GestioneAttivitaCampioneBO.getListaManutenzioni(campione.getId(), session);
//				
//				for(int i = 0; i<lista_manutenzioni.size(); i++) {
//					if(lista_manutenzioni.get(i).getTipo_manutenzione()==1) {
//						attivita_manutenzione =attivita_manutenzione + lista_manutenzioni.get(i).getDescrizione_attivita() +"\n- ";					
//					}
//				}
//				attivita_manutenzione = attivita_manutenzione.substring(0, attivita_manutenzione.length()-2);
//			}
//			
//			
//			
//			report.addParameter("attivita_manutenzione",attivita_manutenzione);
			
			if(campione.getDescrizione_manutenzione()!=null) {
				report.addParameter("attivita_manutenzione",campione.getDescrizione_manutenzione());
			}else{
				report.addParameter("attivita_manutenzione","");	
			}
			
			report.addParameter("frequenza_manutenzione", campione.getFrequenza_manutenzione());
			
			
			//String nome_logo = campione.getCompany().getNomeLogo().substring(0,campione.getCompany().getNomeLogo().length()-4 );
			
			File imageHeader = new File(Costanti.PATH_FOLDER_LOGHI +"logo_sti.png");
			if(imageHeader!=null) {
				report.addParameter("logo",imageHeader);
			
				}
			
			report.setDataSource(new JREmptyDataSource());
			
			String path = Costanti.PATH_FOLDER_CAMPIONI+campione.getId()+"\\SchedaApparecchiatura\\";

			 
			  java.io.File folder = new java.io.File(path);
			  if(!folder.exists()) {
				  folder.mkdirs();
				  
			  }
			
			java.io.File file = new java.io.File(path + "sa_"+campione.getId()+".pdf");
			  FileOutputStream fos = new FileOutputStream(file);
			  report.toPdf(fos);
			
			  fos.close();
			 
	}
	
	
//	public static void main(String[] args) throws  Exception {
//		new ContextListener().configCostantApplication();
//		Session session=SessionFacotryDAO.get().openSession();
//		session.beginTransaction();
//
//			CampioneDTO campione = GestioneCampioneDAO.getCampioneFromId(String.valueOf(54800));
//			new CreateSchedaApparecchiaturaCampioni(campione,session);
//			session.close();
//			System.out.println("FINITO");
//	}
	
}
