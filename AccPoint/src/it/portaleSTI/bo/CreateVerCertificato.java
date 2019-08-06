package it.portaleSTI.bo;

import java.io.File;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import TemplateReportLAT.ImageReport.PivotTemplateLAT_Image;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.ConfigurazioneClienteDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.VerAccuratezzaDTO;
import it.portaleSTI.DTO.VerDecentramentoDTO;
import it.portaleSTI.DTO.VerLinearitaDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerMobilitaDTO;
import it.portaleSTI.DTO.VerRipetibilitaDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.CostantiCertificato;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.action.ContextListener;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.constant.PageOrientation;
import net.sf.dynamicreports.report.constant.PageType;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;


public class CreateVerCertificato {
	
	public CreateVerCertificato(VerMisuraDTO misura, List<SedeDTO> listaSedi, boolean conforme, int motivo,  Session session) throws Exception {
		
		build(misura, listaSedi,conforme, motivo, session);
	}
	
	
	private void build(VerMisuraDTO misura,List<SedeDTO> listaSedi, boolean conforme, int motivo, Session session) throws Exception {
		
		InputStream is = null;
		if(misura.getVerStrumento().getTipo().getId()==1) {
			is = PivotTemplate.class.getResourceAsStream("VerCertificatoCSP1.jrxml");
		}else if(misura.getVerStrumento().getTipo().getId()==2) {
			is = PivotTemplate.class.getResourceAsStream("VerCertificatoDPP1.jrxml");
		}else {
			is = PivotTemplate.class.getResourceAsStream("VerCertificatoCPP1.jrxml");
		}
	
		InputStream is2 =  PivotTemplate.class.getResourceAsStream("VerCertificatoP2.jrxml");
		
		JasperReportBuilder report = DynamicReports.report();
		JasperReportBuilder reportP2 = DynamicReports.report();

		//Object imageHeader = context.getResourceAsStream(Costanti.PATH_FOLDER_LOGHI+"/"+misura.getIntervento().getCompany());
//		File logo = new File(Costanti.PATH_FOLDER_LOGHI +"logo_sti_ddt.png");
//		if(logo!=null) {
//			report.addParameter("logo",logo);
//		
//			}
//		
//		File logoAccredia = new File(Costanti.PATH_FOLDER_LOGHI +"logo_sti_ddt.png");
//		if(logoAccredia!=null) {
//			report.addParameter("logo_accredia",logoAccredia);
//		
//			}
		
		report.addParameter("logo_accredia",PivotTemplateLAT_Image.class.getResourceAsStream("accredia.png"));
		report.addParameter("logo",PivotTemplateLAT_Image.class.getResourceAsStream("sti.jpg"));	
		//report.addParameter("immagine_ilac",PivotTemplateLAT_Image.class.getResourceAsStream("ilac.jpg"));	
		
		report.setTemplateDesign(is);
		report.setTemplate(Templates.reportTemplate);

		report.setDataSource(new JREmptyDataSource());		
		report.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			
		ClienteDTO cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(misura.getVerStrumento().getId_cliente()));
	
		SedeDTO sede = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, misura.getVerStrumento().getId_sede(), misura.getVerStrumento().getId_cliente());
		
		if(misura.getNumeroAttestato()!=null) {
			report.addParameter("numero_certificato", misura.getNumeroAttestato());
		}else {
			report.addParameter("numero_certificato", "");
		}
		
		report.addParameter("allegato", ""); //MANCA ALLEGATO
		
		report.addParameter("registro_laboratorio", ""); //MANCA REGISTRO
		
		if(misura.getDataVerificazione()!=null) {
			report.addParameter("data_verifica", df.format(misura.getDataVerificazione()));
		}
		
		if(cliente!=null) {
			report.addParameter("denominazione_titolare", cliente.getNome());
		}else {
			report.addParameter("denominazione_titolare", "");
		}
		if(cliente!=null && cliente.getIndirizzo()!=null) {
			report.addParameter("indirizzo", cliente.getIndirizzo());
		}else {
			report.addParameter("indirizzo", "");
		}
		
		if(cliente!=null && cliente.getPartita_iva()!=null) {
			report.addParameter("partita_iva", cliente.getPartita_iva());
		}else {
			report.addParameter("partita_iva", "");
		}
			
		if(sede!=null && sede.getIndirizzo()!=null) {
			report.addParameter("indirizzo_servizio", sede.getIndirizzo());
		}else {
			report.addParameter("indirizzo_servizio", "");
		}
		
		if(cliente!=null && cliente.getTelefono()!=null) {
			report.addParameter("telefono", cliente.getTelefono());
		}else {
			report.addParameter("telefono", "");
		}
		
		if(misura.getVerStrumento().getDenominazione()!=null) {
			report.addParameter("denominazione_strumento", misura.getVerStrumento().getDenominazione());
		}else{
			report.addParameter("denominazione_strumento", "");
		}
		
		if(misura.getVerStrumento().getCostruttore()!=null) {
			report.addParameter("costruttore", misura.getVerStrumento().getCostruttore());
		}else{
			report.addParameter("costruttore", "");
		}
		
		if(misura.getVerStrumento().getModello()!=null) {
			report.addParameter("modello", misura.getVerStrumento().getModello());
		}else{
			report.addParameter("modello", "");
		}
		
		if(misura.getVerStrumento().getMatricola()!=null) {
			report.addParameter("matricola", misura.getVerStrumento().getMatricola());
		}else{
			report.addParameter("matricola", "");
		}
		
		if(misura.getVerStrumento().getClasse()!=0) {
			report.addParameter("classe_precisione", misura.getVerStrumento().getClasse());
		}else{
			report.addParameter("classe_precisione", "");
		}
		
		if(misura.getVerStrumento().getTipo()!=null && misura.getVerStrumento().getTipo().getDescrizione()!=null) {
			report.addParameter("tipo", misura.getVerStrumento().getTipo().getDescrizione());
		}else{
			report.addParameter("tipo", "");
		}
		
		if(misura.getVerStrumento().getUm()!=null) {
			report.addParameter("um", misura.getVerStrumento().getUm());
		}else{
			report.addParameter("um", "");
		}
		
		if(misura.getVerStrumento().getPortata_max_C1()!=null) {
			report.addParameter("portata_max_c1", misura.getVerStrumento().getPortata_max_C1().stripTrailingZeros());
		}else{
			report.addParameter("portata_max_c1", "");
		}
		
		if(misura.getVerStrumento().getPortata_min_C1()!=null) {
			report.addParameter("portata_min_c1", misura.getVerStrumento().getPortata_min_C1().stripTrailingZeros());
		}else{
			report.addParameter("portata_min_c1", "");
		}
		
		if(misura.getVerStrumento().getDiv_ver_C1()!=null) {
			report.addParameter("divisione_verifica_c1", misura.getVerStrumento().getDiv_ver_C1().stripTrailingZeros());
		}else{
			report.addParameter("divisione_verifica_c1", "");
		}
		
		if(misura.getVerStrumento().getDiv_rel_C1()!=null) {
			report.addParameter("divisione_reale_c1", misura.getVerStrumento().getDiv_rel_C1().stripTrailingZeros());
		}else{
			report.addParameter("divisione_reale_c1", "");
		}
		
		if(misura.getVerStrumento().getNumero_div_C1()!=null) {
			report.addParameter("numero_divisioni_c1", misura.getVerStrumento().getNumero_div_C1().stripTrailingZeros().toPlainString());
		}else{
			report.addParameter("numero_divisioni_c1", "");
		}
		if(misura.getVerStrumento().getTipo().getId()!=1) {
			if(misura.getVerStrumento().getTipo().getId()==2) {
				
				if(misura.getVerStrumento().getPortata_max_C3()!=null) {
					report.addParameter("portata_max", misura.getVerStrumento().getPortata_max_C3().stripTrailingZeros());
				}else{
					if(misura.getVerStrumento().getPortata_max_C2()!=null) {
						report.addParameter("portata_max",  misura.getVerStrumento().getPortata_max_C2().stripTrailingZeros());	
					}else {
						report.addParameter("portata_max",  "");
					}				
				}
				
				if(misura.getVerStrumento().getPortata_min_C1()!=null) {
					report.addParameter("portata_min", misura.getVerStrumento().getPortata_min_C1().stripTrailingZeros());
				}else{
					report.addParameter("portata_min", "");
				}
				if(misura.getVerStrumento().getPortata_min_C1()!=null && misura.getVerStrumento().getPortata_max_C1()!=null) {
					report.addParameter("campo_1", "(" +  misura.getVerStrumento().getPortata_min_C1().stripTrailingZeros() + "÷" +  misura.getVerStrumento().getPortata_max_C1().stripTrailingZeros() + ")" +  misura.getVerStrumento().getUm());	
				}else {
					report.addParameter("campo_1", "");
				}
				
				if(misura.getVerStrumento().getPortata_min_C1()!=null && misura.getVerStrumento().getPortata_max_C1()!=null) {
					report.addParameter("campo_2", "(" +  misura.getVerStrumento().getPortata_min_C2().stripTrailingZeros() + "÷" +  misura.getVerStrumento().getPortata_max_C2().stripTrailingZeros() + ")" + misura.getVerStrumento().getUm());
				}else {
					report.addParameter("campo_2", "");
				}
				
				if(misura.getVerStrumento().getPortata_min_C1()!=null && misura.getVerStrumento().getPortata_max_C1()!=null) {
					report.addParameter("campo_3", "(" + misura.getVerStrumento().getPortata_min_C3().stripTrailingZeros() + "÷" +  misura.getVerStrumento().getPortata_max_C3().stripTrailingZeros() + ")" + misura.getVerStrumento().getUm());	
				}else {
					report.addParameter("campo_3", "");
				}
				
				
//				if(misura.getVerStrumento().getDiv_ver_C1()!=null) {
//					report.addParameter("divisione_verifica_c1", misura.getVerStrumento().getDiv_ver_C1().stripTrailingZeros());
//				}else{
//					report.addParameter("divisione_verifica_c1", "");
//				}
//				
//				if(misura.getVerStrumento().getDiv_ver_C2()!=null) {
//					report.addParameter("divisione_verifica_c2", misura.getVerStrumento().getDiv_ver_C2().stripTrailingZeros());
//				}else{
//					report.addParameter("divisione_verifica_c2", "");
//				}
//				
//				
//				if(misura.getVerStrumento().getDiv_rel_C2()!=null) {
//					report.addParameter("divisione_reale_c2", misura.getVerStrumento().getDiv_rel_C2().stripTrailingZeros());
//				}else{
//					report.addParameter("divisione_reale_c2", "");
//				}
//				
//				if(misura.getVerStrumento().getNumero_div_C2()!=null) {
//					report.addParameter("numero_divisioni_c2", misura.getVerStrumento().getNumero_div_C2().stripTrailingZeros().toPlainString());
//				}else{
//					report.addParameter("numero_divisioni_c2", "");
//				}
			}	
			else if(misura.getVerStrumento().getTipo().getId()==3) {
				
				if(misura.getVerStrumento().getPortata_max_C2()!=null) {
					report.addParameter("portata_max_c2", misura.getVerStrumento().getPortata_max_C2().stripTrailingZeros());
				}else{
					report.addParameter("portata_max_c2", "");
				}
				
				if(misura.getVerStrumento().getPortata_min_C2()!=null) {
					report.addParameter("portata_min_c2", misura.getVerStrumento().getPortata_min_C2().stripTrailingZeros());
				}else{
					report.addParameter("portata_min_c2", "");
				}
				
				if(misura.getVerStrumento().getPortata_max_C3()!=null) {
					report.addParameter("portata_max_c3", misura.getVerStrumento().getPortata_max_C3().stripTrailingZeros());
				}else{
					report.addParameter("portata_max_c3", "");
				}
				
				if(misura.getVerStrumento().getPortata_min_C3()!=null) {
					report.addParameter("portata_min_c3", misura.getVerStrumento().getPortata_min_C3().stripTrailingZeros());
				}else{
					report.addParameter("portata_min_c3", "");
				}
			}			
			
			if(misura.getVerStrumento().getDiv_ver_C2()!=null) {
				report.addParameter("divisione_verifica_c2", misura.getVerStrumento().getDiv_ver_C2().stripTrailingZeros());
			}else{
				report.addParameter("divisione_verifica_c2", "");
			}
			
			if(misura.getVerStrumento().getDiv_rel_C2()!=null) {
				report.addParameter("divisione_reale_c2", misura.getVerStrumento().getDiv_rel_C2().stripTrailingZeros());
			}else{
				report.addParameter("divisione_reale_c2", "");
			}
			
			if(misura.getVerStrumento().getNumero_div_C2()!=null) {
				report.addParameter("numero_divisioni_c2", misura.getVerStrumento().getNumero_div_C2().stripTrailingZeros().toPlainString());
			}else{
				report.addParameter("numero_divisioni_c2", "");
			}
			
			
			if(misura.getVerStrumento().getDiv_ver_C3()!=null) {
				report.addParameter("divisione_verifica_c3", misura.getVerStrumento().getDiv_ver_C3().stripTrailingZeros());
			}else{
				report.addParameter("divisione_verifica_c3", "");
			}
			
			if(misura.getVerStrumento().getDiv_rel_C3()!=null) {
				report.addParameter("divisione_reale_c3", misura.getVerStrumento().getDiv_rel_C3().stripTrailingZeros());
			}else{
				report.addParameter("divisione_reale_c3", "");
			}
			
			if(misura.getVerStrumento().getNumero_div_C3()!=null) {
				report.addParameter("numero_divisioni_c3", misura.getVerStrumento().getNumero_div_C3().stripTrailingZeros().toPlainString());
			}else{
				report.addParameter("numero_divisioni_c3", "");
			}
		}
		
		if(misura.getMotivo_verifica().getId()==1) {
			report.addParameter("croce1", "X");
			report.addParameter("croce2", "");
			report.addParameter("croce3", "");
			report.addParameter("riparatore", "");
			report.addParameter("data_riparazione", "");
		}else if(misura.getMotivo_verifica().getId()==2) {
			report.addParameter("croce1", "");
			report.addParameter("croce2", "X");
			report.addParameter("croce3", "");
			report.addParameter("riparatore", misura.getNomeRiparatore());
			report.addParameter("data_riparazione", misura.getDataRiparazione());
		}else{
			report.addParameter("croce1", "");
			report.addParameter("croce2", "");
			report.addParameter("croce3", "X");
			report.addParameter("riparatore", "");
			report.addParameter("data_riparazione", "");
		}
		
		List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
		JasperPrint jasperPrint1 = report.toJasperPrint();
		jasperPrintList.add(jasperPrint1);
		
		
		reportP2.setTemplateDesign(is2);
		reportP2.setTemplate(Templates.reportTemplate);

		reportP2.setDataSource(new JREmptyDataSource());		
		reportP2.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		
//		if(logo!=null) {
//			reportP2.addParameter("logo",logo);
//		
//			}
//	
//		if(logoAccredia!=null) {
//			reportP2.addParameter("logo_accredia",logoAccredia);
//		
//			}		
		
		reportP2.addParameter("logo_accredia",PivotTemplateLAT_Image.class.getResourceAsStream("accredia.png"));
		reportP2.addParameter("logo",PivotTemplateLAT_Image.class.getResourceAsStream("sti.jpg"));	
		
		if(misura.getNumeroAttestato()!=null) {
			reportP2.addParameter("numero_certificato", misura.getNumeroAttestato());
		}else {
			reportP2.addParameter("numero_certificato", "");
		}
		
		reportP2.addParameter("allegato", ""); //MANCA ALLEGATO
		
		if(misura.getCampioniLavoro()!=null) {
			reportP2.addParameter("campioni_lavoro", misura.getCampioniLavoro());
		}else {
			reportP2.addParameter("campioni_lavoro", "");
		}

		reportP2.addParameter("campioni_prima_linea", CostantiCertificato.CAMPIONI_PRIMA_LINEA);
		
		if(misura.getDataScadenza()!=null) {
			reportP2.addParameter("data_scadenza", df.format(misura.getDataScadenza()));	
		}else {
			reportP2.addParameter("data_scadenza", "");
		}
		
		if(conforme) {
			reportP2.addParameter("conforme", "X");
			reportP2.addParameter("non_conforme", "");
			reportP2.addParameter("motivo1", "");
			reportP2.addParameter("motivo2", "");
			reportP2.addParameter("motivo3", "");
		}else {
			reportP2.addParameter("conforme", "");
			reportP2.addParameter("non_conforme", "X");
			if(motivo==1) {
				reportP2.addParameter("motivo1", "X");
				reportP2.addParameter("motivo2", "");
				reportP2.addParameter("motivo3", "");
			}else if(motivo==2) {
				reportP2.addParameter("motivo1", "");
				reportP2.addParameter("motivo2", "X");
				reportP2.addParameter("motivo3", "");
			}else {
				reportP2.addParameter("motivo1", "");
				reportP2.addParameter("motivo2", "");
				reportP2.addParameter("motivo3", "X");
			}
		}
		
		reportP2.addParameter("note", "");
		reportP2.addParameter("nome_titolare", "");
		if(misura.getTecnicoVerificatore()!=null && misura.getTecnicoVerificatore().getNominativo()!=null) {
			reportP2.addParameter("nome_operatore", misura.getTecnicoVerificatore().getNominativo());	
		}else {
			reportP2.addParameter("nome_operatore", "");
		}
		
		reportP2.addParameter("responsabile", "");
		
		JasperPrint jasperPrint2 = reportP2.toJasperPrint();
		jasperPrintList.add(jasperPrint2);
		
		
		//String path ="C:\\Users\\antonio.dicivita\\Desktop\\TestVerCertificato.pdf";
		String path = Costanti.PATH_FOLDER+"\\"+misura.getVerIntervento().getNome_pack()+"\\"+misura.getVerIntervento().getNome_pack()+"_"+misura.getId()+""+misura.getVerStrumento().getId()+".pdf";
		
		JRPdfExporter exporter = new JRPdfExporter();
		exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList)); 
		exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(path)); 
		SimplePdfExporterConfiguration configuration = new SimplePdfExporterConfiguration();
		configuration.setCreatingBatchModeBookmarks(true); 
		exporter.setConfiguration(configuration);
		exporter.exportReport();
		
	};
	
	
	
	public static void main(String[] args) throws Exception {
	new ContextListener().configCostantApplication();
	Session session=SessionFacotryDAO.get().openSession();
	session.beginTransaction();
	
	VerMisuraDTO misura = GestioneVerMisuraBO.getMisuraFromId(8, session);

		List<SedeDTO> listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	

		new CreateVerCertificato(misura, listaSedi, false, 3, session);
		session.getTransaction().commit();
		session.close();
		System.out.println("FINITO");
}
}
