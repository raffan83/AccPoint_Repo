package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DTO.AttivitaManutenzioneDTO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.DTO.RegistroEventiDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.exception.DRException;
import net.sf.jasperreports.engine.JREmptyDataSource;

public class CreateSchedaApparecchiatura {
	
	
	File file; 
	private boolean esito; 
	public CreateSchedaApparecchiatura(CampioneDTO campione, ArrayList<AttivitaManutenzioneDTO> lista_attivita, RegistroEventiDTO evento, Session session) throws Exception {
		try {
			// Utility.memoryInfo();
			build(campione, lista_attivita, evento, session);
			// Utility.memoryInfo();
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		} 
	}
	
	

	private void build(CampioneDTO campione, ArrayList<AttivitaManutenzioneDTO> lista_attivita, RegistroEventiDTO evento, Session session) {
		
		
		InputStream is =  PivotTemplate.class.getResourceAsStream("scheda_apparecchiatura.jrxml");
		

		JasperReportBuilder report = DynamicReports.report();
		
		
		try {
			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);
			
			report.addParameter("codice_interno", campione.getCodice());
			report.addParameter("denominazione", campione.getNome());
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
			if(campione.getCampo_accettabilita()!=null) {
				report.addParameter("campo_accettabilita", campione.getCampo_accettabilita());
			}else {
				report.addParameter("campo_accettabilita", "");
			}
			report.addParameter("classificazione", campione.getTipo_campione().getNome());
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
			String attivita_manutenzione = "- ";
			String esito = "";
			for(int i = 0; i<lista_attivita.size(); i++) {
				attivita_manutenzione =attivita_manutenzione + lista_attivita.get(i).getTipo_attivita().getDescrizione() +"\n- ";
				esito = esito + lista_attivita.get(i).getEsito() + "\n";
			}
			attivita_manutenzione = attivita_manutenzione.substring(0, attivita_manutenzione.length()-2);
			
			report.addParameter("attivita_manutenzione",attivita_manutenzione);
			report.addParameter("esito",esito);
			report.addParameter("frequenza_manutenzione", evento.getFrequenza_manutenzione());
			
			String nome_logo = campione.getCompany().getNomeLogo().substring(0,campione.getCompany().getNomeLogo().length()-4 );
			
			File imageHeader = new File(Costanti.PATH_FOLDER_LOGHI +nome_logo+"_sc.jpg");
			if(imageHeader!=null) {
				report.addParameter("logo",imageHeader);
			
				}
			
			report.setDataSource(new JREmptyDataSource());
			
			String path = Costanti.PATH_SCHEDA_ANAGRAFICA+"scheda_anagrafica_"+campione.getId()+"_"+evento.getId()+".pdf";
			
			  java.io.File file = new java.io.File(path);
			  FileOutputStream fos = new FileOutputStream(file);
			  report.toPdf(fos);
			
			  fos.close();
			 
			  this.file = file;
			 // this.setEsito(true);
			  evento.setNome_file(file.getName());
			  session.update(evento);
			
			//  GestioneMagazzinoBO.updateDdt(ddt, session);
			
			
		} catch (DRException e) {

			//this.setEsito(false);
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			
			//this.setEsito(false);
			e.printStackTrace();

		} catch (IOException e) {

			//this.setEsito(false);
			e.printStackTrace();
		}
		
	}
}