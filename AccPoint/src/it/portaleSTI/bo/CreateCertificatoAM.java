package it.portaleSTI.bo;


import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AMCampioneDTO;
import it.portaleSTI.DTO.AMOggettoProvaDTO;
import it.portaleSTI.DTO.AM_CertificatoWrapper;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.action.ContextListener;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

public class CreateCertificatoAM {
	
	public static void createCertificatoAM_UT_thk(Session session) 
	{
		try {
		
		List<AM_CertificatoWrapper> listaWrapper = new ArrayList<>();
		
		AMCampioneDTO campione =GestioneAM_BO.getCampioneFromID(1, session);
		
		AMOggettoProvaDTO strumento= GestioneAM_BO.getOggettoProvaFromID(1, session);

		
		listaWrapper.add(new AM_CertificatoWrapper(campione, strumento));
		
		InputStream is  = PivotTemplate.class.getResourceAsStream("TemplateAM.jrxml");
		
		JasperReport report = JasperCompileManager.compileReport(is);
		
		
		//JasperReportBuilder report = DynamicReports.report();
		Map<String, Object> parameters = new HashMap<>(); // se hai parametri, altrimenti lascia vuoto

		JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(listaWrapper);
		
	
		
		JasperPrint print = JasperFillManager.fillReport(report, parameters, dataSource);
		
		JasperExportManager.exportReportToPdfFile(print, System.getProperty("user.home")+"\\Desktop\\RapportoMisuraSpessimetrica.pdf");
		System.out.println("PDF generato con successo!");
		
		} catch (Exception e) 
		{
			e.printStackTrace();
		}
	}
	
	
		public static void main(String[] args) throws HibernateException, Exception {
			new ContextListener().configCostantApplication();
			Session session =SessionFacotryDAO.get().openSession();
			session.beginTransaction();
		
			createCertificatoAM_UT_thk(session);
			
			session.close();
		}

		
}
