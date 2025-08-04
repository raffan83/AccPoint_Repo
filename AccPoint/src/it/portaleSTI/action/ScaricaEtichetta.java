package it.portaleSTI.action;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.EnumMap;
import java.util.Map;
import java.util.Locale;

import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.JsonObject;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.ConfigurazioneClienteDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneConfigurazioneClienteBO;
import it.portaleSTI.bo.GestioneMisuraBO;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.jasperreports.engine.JREmptyDataSource;

/**
 * Servlet implementation class ScaricaCertificato
 */
@WebServlet(name= "/scaricaEtichetta", urlPatterns = { "/scaricaEtichetta.do" })
public class ScaricaEtichetta extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(ScaricaEtichetta.class);   
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ScaricaEtichetta() {
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
		JsonObject myObj = new JsonObject();

		boolean ajax = false;

		String action = request.getParameter("action");
		
		try
		{	
			
		if(action == null || action.equals("stampaEtichetta")) {
			String idMisura=request.getParameter("idMisura");
			idMisura = Utility.decryptData(idMisura);
			
			String check_fuori_servizio = request.getParameter("check_fuori_servizio");

			MisuraDTO misura = GestioneMisuraBO.getMiruraByID(Integer.parseInt(idMisura), session);	
			ajax = false;

			String nomePack=misura.getIntervento().getNomePack();
			System.out.println(misura.getStrumento().getMatricola());

			InputStream is = PivotTemplate.class.getResourceAsStream("EtichettaZebra.jrxml");

		//	StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(8);//AGG

			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			
			JasperReportBuilder report = DynamicReports.report();

			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);

			File imageHeader = null;
			//Object imageHeader = context.getResourceAsStream(Costanti.PATH_FOLDER_LOGHI+"/"+misura.getIntervento().getCompany());
			ConfigurazioneClienteDTO conf = GestioneConfigurazioneClienteBO.getConfigurazioneClienteFromId(misura.getIntervento().getId_cliente(), misura.getIntervento().getIdSede(),0, session);
					if(conf != null && conf.getNome_file_logo()!=null && !conf.getNome_file_logo().equals("")) {
						imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+ "\\ConfigurazioneClienti\\"+misura.getIntervento().getId_cliente()+"\\"+misura.getIntervento().getIdSede()+"\\"+conf.getNome_file_logo());
					}else {
						imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+"/sti.jpg");
					}			
			
		//	byte[] byteFile=FileUtils.readFileToByteArray(imageHeader);	
			
		//	report.addParameter("logo",new ByteArrayInputStream(rotateImage(byteFile, 45.00)));

			BufferedImage in = ImageIO.read(imageHeader);		
			report.addParameter("logo",rotateClockwise90(in));
			report.addParameter("codiceInterno",misura.getStrumento().getCodice_interno());
			report.addParameter("matricola",misura.getStrumento().getMatricola());
			if(misura.getDataMisura()!=null) {
				report.addParameter("dataVerifica",sdf.format(misura.getDataMisura()));
			
				
			}else {
				report.addParameter("dataVerifica","");	
			}
			
			
			if(check_fuori_servizio.equals("1")) 
			{
				report.addParameter("labDataProVerifica","Stato Strumento");
				report.addParameter("dataProVerifica","FUORI SERVIZIO");
			}
			else 
			{
				report.addParameter("labDataProVerifica","Pross. Verifica");
				if(misura.getStrumento().getTipoRapporto().getId() == 7201 && misura.getStrumento().getDataProssimaVerifica()!=null) {
					if(conf!=null &&conf.getFmt_data_mese_anno().equals("S")) {
						LocalDate locDataMisura = misura.getStrumento().getDataProssimaVerifica().toLocalDate();

						String formattedDate = locDataMisura.format(DateTimeFormatter.ofPattern("MMM/yyyy", Locale.ITALIAN));

						report.addParameter("dataProVerifica",formattedDate.toUpperCase());
					}else {
						report.addParameter("dataProVerifica",sdf.format(misura.getStrumento().getDataProssimaVerifica()));
					}
				}else {
					report.addParameter("dataProVerifica","- - ");
				}
			}
			report.addParameter("nScheda",misura.getnCertificato());

			createQR(misura.getStrumento(),nomePack);

			File qr= new File(Costanti.PATH_FOLDER+"\\"+nomePack+"\\qr.png");
		
			report.addParameter("qr",qr);
			//	report.setColumnStyle(textStyle);

			report.setDataSource(new JREmptyDataSource());

			// java.io.File file = new java.io.File(Costanti.PATH_FOLDER+"//"+intervento.getNome_pack()+"//SchedaDiConsegna.pdf");
			java.io.File file = new java.io.File(Costanti.PATH_FOLDER+"//"+nomePack+"/ET_"+misura.getStrumento().get__id()+".pdf");
			FileOutputStream fos = new FileOutputStream(file);
			report.toPdf(fos);

			fos.flush();
			fos.close();


			File d = new File(Costanti.PATH_FOLDER+"//"+nomePack+"/ET_"+misura.getStrumento().get__id()+".pdf");

			FileInputStream fileIn = new FileInputStream(d);

			response.setContentType("application/pdf");

			//	 response.setHeader("Content-Disposition","attachment;filename="+filename);

			ServletOutputStream outp = response.getOutputStream();

			byte[] outputByte = new byte[1];

			while(fileIn.read(outputByte, 0, 1) != -1)
			{
				outp.write(outputByte, 0, 1);
			}

			session.close();
			fileIn.close();

			outp.flush();
			outp.close();
		}
		else if(action.equals("campione")) {
			
			String id_campione = request.getParameter("id_campione");
			
			CampioneDTO campione = GestioneCampioneDAO.getCampioneFromId(id_campione);
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			
			JasperReportBuilder report = DynamicReports.report();
			
			InputStream is = PivotTemplate.class.getResourceAsStream("EtichettaZebraCampione.jrxml");

			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);

			File imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+"/sti.jpg");				
			
			BufferedImage in = ImageIO.read(imageHeader);		
			report.addParameter("logo",rotateClockwise90(in));
			report.addParameter("codiceInterno",campione.getCodice());
			if(campione.getNumeroCertificato()!=null) {
				report.addParameter("certificato",campione.getNumeroCertificato());
			}else {
				report.addParameter("certificato","");
			}
			
			if(campione.getDataVerifica()!=null) {
				report.addParameter("dataTaratura",sdf.format(campione.getDataVerifica()));
			}else {
				report.addParameter("dataTaratura","");	
			}
						
			if(campione.getDataScadenza()!=null) {
				report.addParameter("dataScadenzaTaratura",sdf.format(campione.getDataScadenza()));
			}else {
				report.addParameter("dataScadenzaTaratura","");	
			}

	
			report.setDataSource(new JREmptyDataSource());

			// java.io.File file = new java.io.File(Costanti.PATH_FOLDER+"//"+intervento.getNome_pack()+"//SchedaDiConsegna.pdf");
			java.io.File file = new java.io.File(Costanti.PATH_FOLDER+"//Campioni//"+campione.getId()+"/ET_"+campione.getId()+".pdf");
			FileOutputStream fos = new FileOutputStream(file);
			report.toPdf(fos);

			fos.flush();
			fos.close();


			File d = new File(Costanti.PATH_FOLDER+"//Campioni//"+campione.getId()+"/ET_"+campione.getId()+".pdf");

			FileInputStream fileIn = new FileInputStream(d);

			response.setContentType("application/pdf");

			//	 response.setHeader("Content-Disposition","attachment;filename="+filename);

			ServletOutputStream outp = response.getOutputStream();

			byte[] outputByte = new byte[1];

			while(fileIn.read(outputByte, 0, 1) != -1)
			{
				outp.write(outputByte, 0, 1);
			}

			session.close();
			fileIn.close();

			outp.flush();
			outp.close();
			
			
		}
			

		}
		catch(Exception ex)
		{

			PrintWriter  out = response.getWriter();
			if(ajax) {
				ex.printStackTrace();
				session.getTransaction().rollback();
				session.close();
				request.getSession().setAttribute("exception", ex);
				myObj = STIException.getException(ex);
				out.print(myObj);
			}else {


				ex.printStackTrace();
				session.getTransaction().rollback();
				session.close();

				request.setAttribute("error",STIException.callException(ex));
				request.getSession().setAttribute("exception", ex);
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
				dispatcher.forward(request,response);
			}
		}  
	}
	
	public static BufferedImage rotateClockwise90(BufferedImage src) {
	    int width = src.getWidth();
	    int height = src.getHeight();

	    BufferedImage dest = new BufferedImage(height, width, src.getType());

	    Graphics2D graphics2D = dest.createGraphics();
	    graphics2D.translate((height - width) / 2, (height - width) / 2);
	    graphics2D.rotate(Math.PI / 2, height / 2, width / 2);
	    graphics2D.drawRenderedImage(src, null);

	    return dest;
	}
	
	public static void createQR(StrumentoDTO strumento, String nomePack) throws Exception
	{
		byte[] bytesEncoded = Base64.encodeBase64((""+strumento.get__id()).getBytes());
		System.out.println("encoded value is " + new String(bytesEncoded));

		String myCodeText = "http://www.calver.it/dettaglioStrumentoFull.do?id_str="+new String(bytesEncoded);

		String filePath =Costanti.PATH_FOLDER+"\\"+nomePack+"\\qr.png";
		                 
		
		int size=80;
		

		String fileType = "png";
		File myFile = new File(filePath);
		try {

			Map<EncodeHintType, Object> hintMap = new EnumMap<EncodeHintType, Object>(EncodeHintType.class);
			hintMap.put(EncodeHintType.CHARACTER_SET, "UTF-8");

			// Now with zxing version 3.2.1 you could change border size (white border size to just 1)
			hintMap.put(EncodeHintType.MARGIN, 0); /* default = 4 */
			hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);

			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			BitMatrix byteMatrix = qrCodeWriter.encode(myCodeText, BarcodeFormat.QR_CODE, size,
					size, hintMap);
			int CrunchifyWidth = byteMatrix.getWidth();
			BufferedImage image = new BufferedImage(CrunchifyWidth, CrunchifyWidth,
					BufferedImage.TYPE_INT_RGB);
			image.createGraphics();

			Graphics2D graphics = (Graphics2D) image.getGraphics();
			graphics.setColor(Color.WHITE);
			graphics.fillRect(0, 0, CrunchifyWidth, CrunchifyWidth);
			graphics.setColor(Color.BLACK);

			for (int i = 0; i < CrunchifyWidth; i++) {
				for (int j = 0; j < CrunchifyWidth; j++) {
					if (byteMatrix.get(i, j)) {
						graphics.fillRect(i, j, 1, 1);
					}
				}
			}
			ImageIO.write(image, fileType, myFile);
		} catch (WriterException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
	
