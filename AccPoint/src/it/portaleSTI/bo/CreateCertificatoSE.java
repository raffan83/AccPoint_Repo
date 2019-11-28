package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.io.File;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.ConfigurazioneClienteDTO;
import it.portaleSTI.DTO.SicurezzaElettricaDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.Util.Utility;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.PageOrientation;
import net.sf.dynamicreports.report.constant.PageType;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;

public class CreateCertificatoSE {
	
	public File file;
	public CreateCertificatoSE(CertificatoDTO certificato,UtenteDTO utente, Session session) throws Exception {
		
		build(certificato,utente, session);
	}

	
	void build(CertificatoDTO certificato,UtenteDTO utente, Session session) throws Exception {
		
		InputStream is =  PivotTemplate.class.getResourceAsStream("certificatoSE.jrxml");
		
		JasperReportBuilder report = DynamicReports.report();
		
		File imageHeader = null;
		//Object imageHeader = context.getResourceAsStream(Costanti.PATH_FOLDER_LOGHI+"/"+misura.getIntervento().getCompany());
		ConfigurazioneClienteDTO conf = GestioneConfigurazioneClienteBO.getConfigurazioneClienteFromId(certificato.getMisura().getIntervento().getId_cliente(), certificato.getMisura().getIntervento().getIdSede(), certificato.getMisura().getStrumento().getTipoRapporto().getId(), session);
				if(conf != null && conf.getNome_file_logo()!=null && !conf.getNome_file_logo().equals("")) {
					imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+ "\\ConfigurazioneClienti\\"+certificato.getMisura().getIntervento().getId_cliente()+"\\"+certificato.getMisura().getIntervento().getIdSede()+"\\"+conf.getNome_file_logo());
				}else {
					imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+"/"+certificato.getMisura().getIntervento().getCompany().getNomeLogo());
				}	
		
		report.setTemplateDesign(is);
		report.setTemplate(Templates.reportTemplate);

		report.setDataSource(new JREmptyDataSource());		
		report.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		
		SicurezzaElettricaDTO misura_se = GestioneSicurezzaElettricaBO.getMisuraSeFormIdMisura(certificato.getMisura().getId(), session);
		
		if(imageHeader!=null) {
			report.addParameter("logo",imageHeader);
		}
		report.addParameter("codice_interno", certificato.getMisura().getStrumento().getCodice_interno());
		if(certificato.getMisura().getnCertificato()!=null) {
			report.addParameter("numero_scheda", certificato.getMisura().getnCertificato());
		}else {
			report.addParameter("numero_scheda", "");
		}
		
		report.addParameter("cliente", certificato.getMisura().getIntervento().getNome_cliente());
		
		ClienteDTO cl = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(certificato.getMisura().getIntervento().getId_cliente()));
		
		if(cl!=null && cl.getIndirizzo()!=null) {
			if(cl.getProvincia()!=null) 
			{
				report.addParameter("indirizzo_cliente", cl.getIndirizzo() +"\n"+cl.getCap()+" - "+cl.getCitta()+" ("+cl.getProvincia()+")");
			}
			else 
			{
				report.addParameter("indirizzo_cliente", cl.getIndirizzo() +"\n"+cl.getCap()+" - "+cl.getCitta());
			}
			
		}else{
			report.addParameter("indirizzo_cliente", "");
		}
		
		report.addParameter("verificatore", certificato.getMisura().getIntervento().getCompany().getDenominazione());
		report.addParameter("indirizzo_verificatore", certificato.getMisura().getIntervento().getCompany().getIndirizzo() +"\n"+ certificato.getMisura().getIntervento().getCompany().getCap()
				+" - " + certificato.getMisura().getIntervento().getCompany().getComune());
		
		if(certificato.getMisura().getStrumento().getDenominazione()!=null) {
			report.addParameter("strumento", certificato.getMisura().getStrumento().getDenominazione());	
		}else {
			report.addParameter("strumento", "");
		}
		if(certificato.getMisura().getStrumento().getModello()!=null) {
			report.addParameter("tipo", certificato.getMisura().getStrumento().getModello());	
		}else {
			report.addParameter("tipo", "");
		}
		if( certificato.getMisura().getStrumento().getMatricola()!=null) {
			report.addParameter("matricola", certificato.getMisura().getStrumento().getMatricola());
		}else {
			report.addParameter("matricola", "");
		}
		if(certificato.getMisura().getStrumento().getCostruttore()!=null) {
			report.addParameter("produttore", certificato.getMisura().getStrumento().getCostruttore());	
		}else {
			report.addParameter("produttore","");
		}		
		
		if(misura_se.getSK()!=null) {
			report.addParameter("classe_protezione", misura_se.getSK());
		}else{
			report.addParameter("classe_protezione", "");
		}
		if(misura_se.getPARTI_APPLICATE()!=null) {
			report.addParameter("parti_applicate", misura_se.getPARTI_APPLICATE());
		}else {
			report.addParameter("parti_applicate", "");	
		}
		report.addParameter("verifica_conformita", "EN 62353 / CEI 62-148");		
		
		if(misura_se.getCOND_PROT()!=null) {
			report.addParameter("cond_prot", "[ "+misura_se.getCOND_PROT()+" ]");
		}else {
			report.addParameter("cond_prot", "");
		}
		if(misura_se.getINVOLUCRO()!=null) {
			report.addParameter("involucro", "[ "+misura_se.getINVOLUCRO()+" ]");
		}else {
			report.addParameter("involucro", "");
		}
		if(misura_se.getFUSIBILI()!=null) {
			report.addParameter("fusibili", "[ "+misura_se.getFUSIBILI()+" ]");
		}else {
			report.addParameter("fusibili", "");
		}
		if(misura_se.getCONNETTORI()!=null) {
			report.addParameter("connettori", "[ "+misura_se.getCONNETTORI()+" ]");
		}else {
			report.addParameter("connettori","");
		}
		if(misura_se.getMARCHIATURE()!=null) {
			report.addParameter("marchiature", "[ "+misura_se.getMARCHIATURE()+" ]");
		}else {
			report.addParameter("marchiature", "");
		}
		if(misura_se.getALTRO()!=null) {
			report.addParameter("altro", "[ "+misura_se.getALTRO()+" ]");
		}else {
			report.addParameter("altro","");
		}
		
		if(misura_se.getCOND_PROT()!=null && misura_se.getCOND_PROT().equals("OK") 
			    && misura_se.getINVOLUCRO()!=null && misura_se.getINVOLUCRO().equals("OK")
				&& misura_se.getFUSIBILI()!=null && misura_se.getFUSIBILI().equals("OK")
				&& misura_se.getCONNETTORI()!=null && misura_se.getCONNETTORI().equals("OK")
				&& misura_se.getMARCHIATURE()!=null && misura_se.getMARCHIATURE().equals("OK")
				&& misura_se.getALTRO()!=null && misura_se.getALTRO().equals("OK")) {
				
				report.addParameter("verifica_sicurezza", "[ OK ]");
			}else {
				report.addParameter("altro", "[ KO ]");
			}
				
		report.addParameter("parti_non_sicure", "");
		report.addParameter("guasto_l_n", "");
		

		report.addParameter("periodicita_verifica", certificato.getMisura().getStrumento().getFrequenza() + " mesi");
		
		if(certificato.getMisura().getStrumento().getDataProssimaVerifica()!=null) {		
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			report.addParameter("prossima_verifica", df.format(certificato.getMisura().getStrumento().getDataProssimaVerifica()));	
		}else {
			report.addParameter("prossima_verifica", "");
		}		
		report.addParameter("strumento_utilizzato", "STI 244");
		report.addParameter("tipo_strumento", "SECUTEST 0751/601");
		report.addParameter("produttore_strumento", "GOSSEN-METRAWATT");
		report.addParameter("operatore", certificato.getUtente().getNominativo());
		if(misura_se.getDATA()!=null) {
			report.addParameter("data", misura_se.getDATA());	
		}else {
			report.addParameter("data", "");
		}
		
		
		SubreportBuilder subreport; 
		subreport = cmp.subreport(getTableReport(misura_se));
		
		report.detail(subreport);
		report.ignorePagination();
		List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
		JasperPrint jasperPrint1 = report.toJasperPrint();
		jasperPrintList.add(jasperPrint1);
		
		
	//	String path ="C:\\Users\\antonio.dicivita\\Desktop\\TestCeftificatoSE.pdf";
		String path = Costanti.PATH_FOLDER+"\\"+certificato.getMisura().getIntervento().getNomePack()+"\\"+certificato.getMisura().getIntervento().getNomePack()+"_"+certificato.getMisura().getInterventoDati().getId()+""+certificato.getMisura().getStrumento().get__id()+".pdf";

		JRPdfExporter exporter = new JRPdfExporter();
		exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList)); 
		exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(path)); 
		SimplePdfExporterConfiguration configuration = new SimplePdfExporterConfiguration();
		configuration.setCreatingBatchModeBookmarks(true); 
		exporter.setConfiguration(configuration);
		exporter.exportReport();
		this.file = new File(path);
		
		certificato.setNomeCertificato(certificato.getMisura().getIntervento().getNomePack()+"_"+certificato.getMisura().getInterventoDati().getId()+""+certificato.getMisura().getStrumento().get__id()+".pdf");
		certificato.setDataCreazione(new Date());
		certificato.setStato(new StatoCertificatoDTO(2));		
		certificato.setUtenteApprovazione(utente);
		session.update(certificato);
		
		StrumentoDTO strumento = GestioneStrumentoBO.getStrumentoById(""+certificato.getMisura().getStrumento().get__id(), session);
		strumento.setDataUltimaVerifica(new java.sql.Date(certificato.getMisura().getDataMisura().getTime()));
		
		
		
		java.sql.Date sqlDate = new java.sql.Date(strumento.getDataUltimaVerifica().getTime());

		
		Calendar data = Calendar.getInstance();
		
		data.setTime(sqlDate);
		data.add(Calendar.MONTH,strumento.getFrequenza());
		
		java.sql.Date sqlDateProssimaVerifica = new java.sql.Date(data.getTime().getTime());
			
		strumento.setDataProssimaVerifica(sqlDateProssimaVerifica);
		
		session.update(strumento);
		
	}
	
	@SuppressWarnings("deprecation")
	public JasperReportBuilder getTableReport(SicurezzaElettricaDTO misura_se) throws Exception{

		JasperReportBuilder report = DynamicReports.report();

		try {			

			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
			report.addColumn(col.column("Misure","misure", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(335));
	 		report.addColumn(col.column("Valore","valore", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(70));
	 		report.addColumn(col.column("Limite","limite", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(70));
	 		report.addColumn(col.column("Esito","esito", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(70));
	 			 	
			report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()));
		
	 		report.setDataSource(createDataSource(misura_se));
	 		
	 		report.highlightDetailEvenRows();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return report;
	}
	
	private JRDataSource createDataSource(SicurezzaElettricaDTO misura_se)throws Exception {
		DRDataSource dataSource = null;
		String[] listaCodici = null;
			
			listaCodici = new String[4];
			
			listaCodici[0]="misure";
			listaCodici[1]="valore";
			listaCodici[2]="limite";
			listaCodici[3]="esito";			

			dataSource = new DRDataSource(listaCodici);
			ArrayList<String> arrayPs = new ArrayList<String>();
			arrayPs.add("Conduttore di protezione");
			arrayPs.add(misura_se.getR_SL());
			arrayPs.add(misura_se.getR_SL_GW());
			arrayPs.add(Utility.returnEsit(misura_se.getR_SL(), misura_se.getR_SL_GW(), 0));
			dataSource.add(arrayPs.toArray());
			
			ArrayList<String> arrayPs1 = new ArrayList<String>();
			arrayPs1.add("Resistenza d'isolamento");
			arrayPs1.add(misura_se.getR_ISO());
			arrayPs1.add(misura_se.getR_ISO_GW());
			arrayPs1.add(Utility.returnEsit(misura_se.getR_ISO(), misura_se.getR_ISO_GW(), 1));
			dataSource.add(arrayPs1.toArray());
			
			ArrayList<String> arrayPs2 = new ArrayList<String>();
			arrayPs2.add("Tensione di verifica");
			arrayPs2.add(misura_se.getU_ISO());
			arrayPs2.add(misura_se.getU_ISO_GW());
			arrayPs2.add(Utility.returnEsit(misura_se.getU_ISO(), misura_se.getU_ISO_GW(), 1));
			dataSource.add(arrayPs2.toArray());
			
			ArrayList<String> arrayPs3 = new ArrayList<String>();
			arrayPs3.add("Corrente dispersione equivalente (Metodo Alternativo)");
			arrayPs3.add(misura_se.getI_EGA());
			arrayPs3.add(misura_se.getI_EGA_GW());
			arrayPs3.add(Utility.returnEsit(misura_se.getI_EGA(), misura_se.getI_EGA_GW(), 0));
			dataSource.add(arrayPs3.toArray());
			
			ArrayList<String> arrayPs4 = new ArrayList<String>();
			arrayPs4.add("Conduttore dispersione apparecchio (Metodo Differenziale)");
			arrayPs4.add(misura_se.getI_DIFF());
			arrayPs4.add(misura_se.getI_DIFF_GW());
			arrayPs4.add(Utility.returnEsit(misura_se.getI_DIFF(), misura_se.getI_DIFF_GW(), 0));
			dataSource.add(arrayPs4.toArray());
			
			ArrayList<String> arrayPs5 = new ArrayList<String>();
			arrayPs5.add("Conduttore dispersione apparecchio (Metodo Diretto");
			arrayPs5.add(misura_se.getI_EPA());
			arrayPs5.add(misura_se.getI_EPA_GW());
			arrayPs5.add(Utility.returnEsit(misura_se.getI_EPA(), misura_se.getI_EPA_GW(), 0));
			dataSource.add(arrayPs5.toArray());
			
			ArrayList<String> arrayPs6 = new ArrayList<String>();
			arrayPs6.add("Corrente di contatto");
			arrayPs6.add(misura_se.getI_GA());
			arrayPs6.add(misura_se.getI_GA_GW());
			arrayPs6.add(Utility.returnEsit(misura_se.getI_GA(), misura_se.getI_GA_GW(), 0));
			dataSource.add(arrayPs6.toArray());
			
			ArrayList<String> arrayPs7 = new ArrayList<String>();
			arrayPs7.add("Corrente di dispersione sulle parti applicate");
			arrayPs7.add(misura_se.getI_PA_AC());
			arrayPs7.add(misura_se.getI_PA_AC_GW());
			arrayPs7.add(Utility.returnEsit(misura_se.getI_PA_AC(), misura_se.getI_PA_AC_GW(), 0));
			dataSource.add(arrayPs7.toArray());
			
			ArrayList<String> arrayPs8 = new ArrayList<String>();
			arrayPs8.add("Corrente dispersione paziente AC");
			arrayPs8.add(misura_se.getI_GA_SFC());
			arrayPs8.add(misura_se.getI_GA_SFC_GW());
			arrayPs8.add(Utility.returnEsit(misura_se.getI_GA_SFC(), misura_se.getI_GA_SFC_GW(), 0));
			dataSource.add(arrayPs8.toArray());
			
			ArrayList<String> arrayPs9 = new ArrayList<String>();
			arrayPs9.add("Corrente dispersione paziente DC");
			arrayPs9.add(misura_se.getI_PA_DC());
			arrayPs9.add(misura_se.getI_PA_DC_GW());
			arrayPs9.add(Utility.returnEsit(misura_se.getI_PA_DC(), misura_se.getI_PA_DC_GW(), 0));
			dataSource.add(arrayPs9.toArray());
			
			ArrayList<String> arrayPs10 = new ArrayList<String>();
			arrayPs10.add("Tensione di verifica");
			arrayPs10.add(misura_se.getPSPG());
			arrayPs10.add("");
			arrayPs10.add("-");
			dataSource.add(arrayPs10.toArray());
			
			ArrayList<String> arrayPs11 = new ArrayList<String>();
			arrayPs11.add("Tensione nominale");
			arrayPs11.add(misura_se.getUBEZ_GW());
			arrayPs11.add("");
			arrayPs11.add("-");
			dataSource.add(arrayPs11.toArray());
			
	 		return dataSource;
	 	}
	
//	public static void main(String[] args) throws Exception {
//	new ContextListener().configCostantApplication();
//	Session session=SessionFacotryDAO.get().openSession();
//	session.beginTransaction();
//	
//	
//	CertificatoDTO certificato=GestioneCertificatoBO.getCertificatoById("121");
//	//String pathImage="C:\\Users\\raffaele.fantini\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\AccPoint\\images\\livella.png";
//		new CreateCertificatoSE(certificato,session);
//		session.getTransaction().commit();
//		session.close();
//		System.out.println("FINITO");
//}
}
