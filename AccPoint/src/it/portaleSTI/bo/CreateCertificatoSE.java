package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.io.File;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;

import com.google.gson.JsonObject;

import TemplateReport.PivotTemplate;
import it.arubapec.arubasignservice.ArubaSignService;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.ConfigurazioneClienteDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.SicurezzaElettricaDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.action.ContextListener;
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
	public String messaggio_firma;
	public String norma="";
	public final String CODICE_CAMPIONE="STI244";
	public CreateCertificatoSE(CertificatoDTO certificato,String data_emissione, UtenteDTO utente,  Session session) throws Exception {
		
		build(certificato,data_emissione, utente, session);
	}

	
	void build(CertificatoDTO certificato,String data_emissione,UtenteDTO utente,  Session session) throws Exception {
		
		SicurezzaElettricaDTO misura_se = GestioneSicurezzaElettricaBO.getMisuraSeFormIdMisura(certificato.getMisura().getId(), session);
		
		if(misura_se.getTIPO_NORMA()!=null) {
			
				norma=misura_se.getTIPO_NORMA();
				
		}
		InputStream is=null;
		
		
		if(norma.equals("601")) 
			{
				is =  PivotTemplate.class.getResourceAsStream("certificatoSE_601.jrxml");
			}
		else if(norma.equals("61010"))
			{
			is =  PivotTemplate.class.getResourceAsStream("certificatoSE_61010.jrxml");
			}
		else
			{
				is =  PivotTemplate.class.getResourceAsStream("certificatoSE_62353.jrxml");
			}
	
		
		JasperReportBuilder report = DynamicReports.report();
		
		MisuraDTO misura= certificato.getMisura();
		
		StrumentoDTO strumento =misura.getStrumento();
		
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
		
		
		
		if(imageHeader!=null) {
			report.addParameter("logo",imageHeader);
		}
		
		if(certificato.getMisura().getnCertificato()!=null) {
			report.addParameter("nRapporto", misura.getnCertificato());
		}else {
			report.addParameter("nRapporto", "");
		}
		
		report.addParameter("datiCliente",""+misura.getIntervento().getNome_cliente());
		report.addParameter("sedeCliente",""+misura.getIntervento().getNome_sede());
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		
		
		/*
		 * Aggiornata data Emissione su scadenzaDTO
		 */
	
			
		if(misura.getDataMisura()!=null){
					Calendar c = Calendar.getInstance(); 
					c.setTime(misura.getDataMisura()); 
					c.add(Calendar.MONTH,strumento.getFrequenza());
					c.getTime();
					
					strumento.setDataProssimaVerifica(new java.sql.Date(c.getTime().getTime()));
					
					GestioneStrumentoBO.update(strumento, session);
				
					report.addParameter("dataVerifica",""+sdf.format(misura.getDataMisura()));
										
					
				}else {
					report.addParameter("dataVerifica"," ");			
				}
				
			
				if(strumento.getDataProssimaVerifica()!=null){
					if(conf!=null && conf.getFmt_data_mese_anno()!=null && conf.getFmt_data_mese_anno().equals("S")) {
						LocalDate dataMisura = strumento.getDataProssimaVerifica().toLocalDate();
						
						 String formattedDate = dataMisura.format(DateTimeFormatter.ofPattern("MMMM/yyyy"));
						report.addParameter("dataProssimaVerifica",formattedDate.toUpperCase());
					}else {
						report.addParameter("dataProssimaVerifica",""+sdf.format(strumento.getDataProssimaVerifica()));
					}							
					
				}else 
				{
					report.addParameter("dataProssimaVerifica","/");			
				}
				
		
	/* Dati Apparecchio*/	
		
		if(strumento.getDenominazione()!=null) {
			report.addParameter("denominazione", strumento.getDenominazione());	
		}else {
			report.addParameter("denominazione", "");
		}
		
		if(strumento.getModello()!=null) {
			report.addParameter("modello", strumento.getModello());	
		}else {
			report.addParameter("modello", "");
		}
		
		if( strumento.getMatricola()!=null) {
			report.addParameter("matricola", strumento.getMatricola());
		}else {
			report.addParameter("matricola", "");
		}
		
		if( strumento.getCodice_interno()!=null) {
			report.addParameter("codice_interno", strumento.getCodice_interno());
		}else {
			report.addParameter("codice_interno", "");
		}
		
		if(strumento.getCostruttore()!=null) {
			report.addParameter("costruttore", strumento.getCostruttore());	
		}
		else {
			report.addParameter("costruttore","");
		}		

		/*ESAME A VISTA */
		if(misura_se.getCOND_PROT()!=null) {
			report.addParameter("cond_prot",misura_se.getCOND_PROT());
		}else {
			report.addParameter("cond_prot", "");
		}
		if(misura_se.getINVOLUCRO()!=null) {
			report.addParameter("involucro", misura_se.getINVOLUCRO());
		}else {
			report.addParameter("involucro", "");
		}
		if(misura_se.getFUSIBILI()!=null) {
			report.addParameter("isolamento",misura_se.getFUSIBILI());
		}else {
			report.addParameter("isolamento", "");
		}
		if(misura_se.getCONNETTORI()!=null) {
			report.addParameter("prese", misura_se.getCONNETTORI());
		}else {
			report.addParameter("prese","");
		}
		if(misura_se.getMARCHIATURE()!=null) {
			report.addParameter("leggibilita", misura_se.getMARCHIATURE());
		}else {
			report.addParameter("leggibilita", "");
		}
		if(misura_se.getALTRO()!=null) {
			if(misura_se.getALTRO().split("@")[0].equals("OK")) 
			{
				report.addParameter("altro","");
			}else 
			{
				report.addParameter("altro", misura_se.getALTRO().split("@")[0]);
			}
			
		}else {
			report.addParameter("altro","");
		}
		
		if(misura_se.getALTRO()!=null && misura_se.getALTRO().split("@").length>1) {
			report.addParameter("label_altro",": "+ misura_se.getALTRO().split("@")[1]);
		}else {
			report.addParameter("label_altro","");
		}
		
		boolean esitoMisure=true;
		
		if(misura_se.getTIPO_NORMA().equals("61010")) 
		{
			
				if(misura_se.getSK()!=null) {
					report.addParameter("classe_protezione", getClasse(misura_se.getSK()));
				}else{
					report.addParameter("classe_protezione", "");
				}
	
				
				if(misura_se.getR_SL()!=null && !misura_se.getR_SL().equals("")) 
				{	
					String esitoR_SL=Utility.returnEsit(misura_se.getR_SL(), misura_se.getR_SL_GW(), 0);
					if(esitoR_SL.equals("KO")) 
					{
						esitoMisure=false;
					}
				
			
					report.addParameter("misurato_1",misura_se.getR_SL());
					report.addParameter("limite_1",misura_se.getR_SL_GW());
					report.addParameter("esito_1",esitoR_SL);
				}else 
				{
					report.addParameter("misurato_1","N/A");
					report.addParameter("limite_1","N/A");
					report.addParameter("esito_1","N/A");
				}	
				
				if(misura_se.getI_DIFF()!=null && !misura_se.getI_DIFF().equals("")) {
					String esitoR_I_DIFF=Utility.returnEsit(misura_se.getI_DIFF(), misura_se.getI_DIFF_GW(), 0);
					if(esitoR_I_DIFF.equals("KO")) 
					{
						esitoMisure=false;
					}
				
				
				report.addParameter("misurato_2",misura_se.getI_DIFF());
				report.addParameter("limite_2",misura_se.getI_DIFF_GW());
				report.addParameter("esito_2",esitoR_I_DIFF);
				}else 
				{
					report.addParameter("misurato_2","N/A");
					report.addParameter("limite_2","N/A");
					report.addParameter("esito_2","N/A");
				}	
				
				
				if(misura_se.getI_GA_GW()!=null && !misura_se.getI_GA_GW().equals("")) 
				{		
					String esitoI_GA=Utility.returnEsit(misura_se.getI_GA(), misura_se.getI_GA_GW(), 0);
					
					if(esitoI_GA.equals("KO")) 
					{
						esitoMisure=false;
					}
					
					report.addParameter("misurato_3",misura_se.getI_GA());
					report.addParameter("limite_3",misura_se.getI_GA_GW());
					report.addParameter("esito_3",esitoI_GA);
				}
				else 
				{
					report.addParameter("misurato_3","N/A");
					report.addParameter("limite_3","N/A");
					report.addParameter("esito_3","N/A");
				}	
				
				if(misura_se.getI_GA_GW()!=null && !misura_se.getI_GA_GW().equals("")) 
				{	
					String esitoI_GA_SFC=Utility.returnEsit(misura_se.getI_GA_SFC(), misura_se.getI_GA_SFC_GW(), 0);
					
					if(esitoI_GA_SFC.equals("KO")) 
					{
						esitoMisure=false;
					}
					
					report.addParameter("misurato_4",misura_se.getI_GA_SFC());
					report.addParameter("limite_4",misura_se.getI_GA_SFC_GW());
					report.addParameter("esito_4",esitoI_GA_SFC);
				}
				else 
				{
					report.addParameter("misurato_4","N/A");
					report.addParameter("limite_4","N/A");
					report.addParameter("esito_4","N/A");
				}	
		}
		
		else if(norma.equals("62353"))
			
		{
			
			if(misura_se.getSK()!=null) {
				report.addParameter("classe_protezione", getClasse(misura_se.getSK()));
			}else{
				report.addParameter("classe_protezione", "");
			}
			
			
			if(misura_se.getPARTI_APPLICATE()!=null) {
				report.addParameter("parti_applicate", misura_se.getPARTI_APPLICATE());
			}else {
				report.addParameter("parti_applicate", "");	
			}
			
			String esitoR_SL=Utility.returnEsit(misura_se.getR_SL(), misura_se.getR_SL_GW(), 0);
			if(esitoR_SL.equals("KO")) 
			{
				esitoMisure=false;
			}
			report.addParameter("misurato_1",misura_se.getR_SL());
			report.addParameter("limite_1",misura_se.getR_SL_GW());
			report.addParameter("esito_1",esitoR_SL);
			
			String esitoR_ISO=Utility.returnEsit(misura_se.getR_ISO(), misura_se.getR_ISO_GW(), 1);
			if(esitoR_ISO.equals("KO")) 
			{
				esitoMisure=false;
			}
			report.addParameter("misurato_2",misura_se.getR_ISO());
			report.addParameter("limite_2",misura_se.getR_ISO_GW());
			report.addParameter("esito_2",esitoR_ISO);
			
			String esitoU_ISO=Utility.returnEsit(misura_se.getU_ISO(), misura_se.getU_ISO_GW(), 1);
			if(esitoU_ISO.equals("KO")) 
			{
				esitoMisure=false;
			}
			report.addParameter("misurato_3",misura_se.getU_ISO());
			report.addParameter("limite_3",misura_se.getU_ISO_GW());
			report.addParameter("esito_3",esitoU_ISO);
			
			String esitoI_EGA=Utility.returnEsit(misura_se.getI_EGA(), misura_se.getI_EGA_GW(), 0);
			if(esitoI_EGA.equals("KO")) 
			{
				esitoMisure=false;
			}
			report.addParameter("misurato_4",misura_se.getI_EGA());
			report.addParameter("limite_4",misura_se.getI_EGA_GW());
			report.addParameter("esito_4",esitoI_EGA);
			
			String esitoR_I_DIFF=Utility.returnEsit(misura_se.getI_DIFF(), misura_se.getI_DIFF_GW(), 0);
			if(esitoR_I_DIFF.equals("KO")) 
			{
				esitoMisure=false;
			}
			
			report.addParameter("misurato_5",misura_se.getI_DIFF());
			report.addParameter("limite_5",misura_se.getI_DIFF_GW());
			report.addParameter("esito_5",esitoR_I_DIFF);
			
			String esitoI_EPA=Utility.returnEsit(misura_se.getI_EPA(), misura_se.getI_EPA_GW(), 0);
			if(esitoI_EPA.equals("KO")) 
			{
				esitoMisure=false;
			}
			report.addParameter("misurato_6",misura_se.getI_EPA());
			report.addParameter("limite_6",misura_se.getI_EPA_GW());
			report.addParameter("esito_6",esitoI_EPA);
		
			String esitoI_GA=Utility.returnEsit(misura_se.getI_GA(), misura_se.getI_GA_GW(), 0);
			
			if(esitoI_GA.equals("KO")) 
			{
				esitoMisure=false;
			}
			
			report.addParameter("misurato_7",misura_se.getI_GA());
			report.addParameter("limite_7",misura_se.getI_GA_GW());
			report.addParameter("esito_7",esitoI_GA);
			
			String esitoI_GA_SFC=Utility.returnEsit(misura_se.getI_GA_SFC(), misura_se.getI_GA_SFC_GW(), 0);
			
			if(esitoI_GA_SFC.equals("KO")) 
			{
				esitoMisure=false;
			}
			
			report.addParameter("misurato_8",misura_se.getI_GA_SFC());
			report.addParameter("limite_8",misura_se.getI_GA_SFC_GW());
			report.addParameter("esito_8",esitoI_GA_SFC);
			
			String esitoI_PA_AC=Utility.returnEsit(misura_se.getI_PA_AC(), misura_se.getI_PA_AC_GW(), 0);
			
			if(esitoI_PA_AC.equals("KO")) 
			{
				esitoMisure=false;
			}
			
			report.addParameter("misurato_9",misura_se.getI_PA_AC());
			report.addParameter("limite_9",misura_se.getI_PA_AC_GW());
			report.addParameter("esito_9",esitoI_PA_AC);
			
			String esitoI_PA_DC=Utility.returnEsit(misura_se.getI_PA_DC(), misura_se.getI_PA_DC_GW(), 0);
			
			if(esitoI_PA_AC.equals("KO")) 
			{
				esitoMisure=false;
			}
			
			report.addParameter("misurato_10",misura_se.getI_PA_DC());
			report.addParameter("limite_10",misura_se.getI_PA_DC_GW());
			report.addParameter("esito_10",esitoI_PA_DC);
	
	
			
		}
		
		
		CampioneDTO campione=GestioneCampioneBO.controllaCodice(CODICE_CAMPIONE);
		
		report.addParameter("cmp_costruttore", campione.getCostruttore());
		report.addParameter("cmp_modello", campione.getModello());
		report.addParameter("cmp_matricola",campione.getMatricola());
		report.addParameter("cmp_certificato", campione.getNumeroCertificato());
		report.addParameter("cmp_data_sc", sdf.format(campione.getDataScadenza()));
		
		
		report.addParameter("str_nota",strumento.getNote());
		
		report.addParameter("operatore", certificato.getUtente().getNominativo());
		report.addParameter("firma_operatore", Costanti.PATH_FOLDER + "FileFirme\\"+certificato.getUtente().getFile_firma());
		
		
		if(valutaEsito(misura_se) && esitoMisure) 
			{
				report.addParameter("ok_cond", "X");
				report.addParameter("ko_cond", "");
			}
		else 
			{
				report.addParameter("ko_cond", "X");
				report.addParameter("ok_cond", "");
			}
		
		
		/*SubreportBuilder subreport; 
		subreport = cmp.subreport(getTableReport(misura_se));
		
		report.detail(subreport);
		*/report.ignorePagination();
		List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
		JasperPrint jasperPrint1 = report.toJasperPrint();
		jasperPrintList.add(jasperPrint1);
		
		
		//String path ="C:\\Users\\raffaele.fantini\\Desktop\\TestCeftificatoSE.pdf";
		String path = Costanti.PATH_FOLDER+"\\"+certificato.getMisura().getIntervento().getNomePack()+"\\"+certificato.getMisura().getIntervento().getNomePack()+"_"+certificato.getMisura().getInterventoDati().getId()+""+certificato.getMisura().getStrumento().get__id()+".pdf";

		
	
		JRPdfExporter exporter = new JRPdfExporter();
		exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList)); 
		exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(path)); 
		SimplePdfExporterConfiguration configuration = new SimplePdfExporterConfiguration();
		configuration.setCreatingBatchModeBookmarks(true); 
		exporter.setConfiguration(configuration);
		exporter.exportReport();
		this.file = new File(path);
		
		  
		  JsonObject jsonOP = new JsonObject();
		  
		  this.messaggio_firma ="";
	
		UtenteDTO operatore=misura.getUser();
		  
	
		  if(operatore.getFile_firma()!=null && operatore.getIdFirma()!=null) {
			 jsonOP =  ArubaSignService.signCertificatoPades(operatore,"",true, certificato);
		  }
		  
		  
		  if(jsonOP.get("success")==null || !jsonOP.get("success").getAsBoolean() || certificato.getMisura().getInterventoDati().getUtente().getIdFirma()==null) {
			  
			  messaggio_firma = "Non è stato possibile appore la firma digitale dell'operatore";				  
		  }
		
		certificato.setNomeCertificato(certificato.getMisura().getIntervento().getNomePack()+"_"+certificato.getMisura().getInterventoDati().getId()+""+certificato.getMisura().getStrumento().get__id()+".pdf");
		certificato.setDataCreazione(new Date());
		certificato.setStato(new StatoCertificatoDTO(2));		
		certificato.setUtenteApprovazione(utente);
		session.update(certificato);
		
		
		
	}

private String getClasse(String sk) {
		
	if(sk!=null && sk.equals("1")) 
	{
		return "I";
	}
	if(sk!=null && sk.equals("2")) 
	{
		return "II";
	}
	if(sk!=null && sk.equals("3")) 
	{
		return "III";
	}
		return null;
	}


private boolean valutaEsito(SicurezzaElettricaDTO misura_se) {
	
	
	
		if(misura_se.getCOND_PROT()!=null && misura_se.getCOND_PROT().equals("KO")) 
		{
			return false;
		}
		
		if(misura_se.getINVOLUCRO()!=null && misura_se.getINVOLUCRO().equals("KO")) 
		{
			return false;
		}
		
		if(misura_se.getFUSIBILI()!=null && misura_se.getFUSIBILI().equals("KO")) 
		{
			return false;
		}
		
		if(misura_se.getCONNETTORI()!=null && misura_se.getCONNETTORI().equals("KO")) 
		{
			return false;
		}
		
		if(misura_se.getMARCHIATURE()!=null && misura_se.getMARCHIATURE().equals("KO")) 
		{
			return false;
		}
		
		if(misura_se.getALTRO()!=null && misura_se.getALTRO().equals("KO")) 
		{
			return false;
		}
	
		return true;
	}


public static void main(String[] args) throws Exception {
	try 
	{
		new ContextListener().configCostantApplication();
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		UtenteDTO u=GestioneUtenteBO.getUtenteById("3", session);
		
		CertificatoDTO certificato=GestioneCertificatoBO.getCertificatoById("28984",session);
		//String pathImage="C:\\Users\\raffaele.fantini\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\AccPoint\\images\\livella.png";
			new CreateCertificatoSE(certificato,"",u,session);
			session.getTransaction().commit();
			session.close();
			System.out.println("FINITO");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
}
}
