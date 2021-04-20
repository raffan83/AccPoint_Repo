package it.arubapec.arubasignservice;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.imageio.ImageIO;

import org.apache.commons.io.FileUtils;

import com.google.gson.JsonObject;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.parser.ImageRenderInfo;
import com.itextpdf.text.pdf.parser.PdfReaderContentParser;
import com.itextpdf.text.pdf.parser.RenderListener;
import com.itextpdf.text.pdf.parser.TextRenderInfo;

import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.Auth;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.PdfProfile;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.PdfSignApparence;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.PdfsignatureV2;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.PdfsignatureV2E;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.PdfsignatureV2ResponseE;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.Pkcs7SignV2;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.Pkcs7SignV2E;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.Pkcs7SignV2ResponseE;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.SignRequestV2;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.TypeTransport;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerCertificatoDTO;
import it.portaleSTI.Util.Costanti;
import net.sf.dynamicreports.report.constant.HorizontalImageAlignment;

public class ArubaSignService {

	public static JsonObject sign(String utente, CertificatoDTO certificato) throws TypeOfTransportNotImplementedException, IOException {
	
		 
		ArubaSignServiceServiceStub stub = new ArubaSignServiceServiceStub();
		
		
		Pkcs7SignV2E request= new Pkcs7SignV2E();
		Pkcs7SignV2 pkcs = new Pkcs7SignV2();
		
		SignRequestV2  sign = new SignRequestV2();
		
		sign.setCertID("AS0");
		
		Auth identity = new Auth();
		identity.setDelegated_domain("faSTI");
		identity.setTypeOtpAuth("faSTI");
		identity.setOtpPwd("dsign");
		identity.setTypeOtpAuth("faSTI");
		
		identity.setUser(utente);
		
		identity.setDelegated_user("admin.firma");
		identity.setDelegated_password("uBFqc8YYslTG");
		
		sign.setIdentity(identity);
		//${certificato.nomeCertificato}&pack=${certificato.misura.intervento.nomePack}
		
		String nomeCert = Costanti.PATH_FOLDER+certificato.getMisura().getIntervento().getNomePack()+"/"+certificato.getNomeCertificato();
		File f = new File(nomeCert);

 		URI uri = f.toURI();
		
		javax.activation.DataHandler dh = new DataHandler(uri.toURL());
		
		sign.setBinaryinput(dh);
	//	sign.setSrcName("C:\\Users\\raffaele.fantini\\Desktop\\FirmDigitale\\Test\\test_firm.pdf");
		
	//	sign.setDstName("C:\\Users\\raffaele.fantini\\Desktop\\FirmDigitale\\Test\\TestFirm_firmato.pdf.p7m");
		
		
		sign.setTransport(TypeTransport.BYNARYNET);
		
		pkcs.setSignRequestV2(sign);
		
		request.setPkcs7SignV2(pkcs);
		
		Pkcs7SignV2ResponseE response= stub.pkcs7SignV2(request);
		JsonObject jsonObj = new JsonObject();
		

	
//	System.out.println("Status :"+response.getPkcs7SignV2Response().get_return().getStatus());
//	System.out.println("Status :"+response.getPkcs7SignV2Response().get_return().getDescription());
//	System.out.println("Status :"+response.getPkcs7SignV2Response().get_return().getReturn_code());
	
		if( response.getPkcs7SignV2Response().get_return().getStatus().equals("KO")) {
			jsonObj.addProperty("success", false);
			jsonObj.addProperty("messaggio", response.getPkcs7SignV2Response().get_return().getDescription());
			jsonObj.addProperty("errorType", "sign");
		}else {
			
			jsonObj.addProperty("success", true);
			
			DataHandler fileReturn=response.getPkcs7SignV2Response().get_return().getBinaryoutput();
			File targetFile = new File(nomeCert+".p7m");
			FileUtils.copyInputStreamToFile(fileReturn.getInputStream(), targetFile);

			jsonObj.addProperty("messaggio", "Certificato firmato");
		}
		return jsonObj;
		 
	}
	
	
	
	public static JsonObject signVerificazione(String utente, VerCertificatoDTO certificato) throws TypeOfTransportNotImplementedException, IOException {
		
		 
		ArubaSignServiceServiceStub stub = new ArubaSignServiceServiceStub();
		
		
		Pkcs7SignV2E request= new Pkcs7SignV2E();
		Pkcs7SignV2 pkcs = new Pkcs7SignV2();
		
		SignRequestV2  sign = new SignRequestV2();
		
		sign.setCertID("AS0");
		
		Auth identity = new Auth();
		identity.setDelegated_domain("faSTI");
		identity.setTypeOtpAuth("faSTI");
		identity.setOtpPwd("dsign");
		identity.setTypeOtpAuth("faSTI");
		
		identity.setUser(utente);
		
		identity.setDelegated_user("admin.firma");
		identity.setDelegated_password("uBFqc8YYslTG");
		
		sign.setIdentity(identity);
		
		String nomeCert = Costanti.PATH_FOLDER+"\\"+certificato.getMisura().getVerIntervento().getNome_pack()+"\\"+certificato.getNomeCertificato();
		
		File f = new File(nomeCert);

 		URI uri = f.toURI();
		
		javax.activation.DataHandler dh = new DataHandler(uri.toURL());
		
		sign.setBinaryinput(dh);
	//	sign.setSrcName("C:\\Users\\raffaele.fantini\\Desktop\\FirmDigitale\\Test\\test_firm.pdf");
		
	//	sign.setDstName("C:\\Users\\raffaele.fantini\\Desktop\\FirmDigitale\\Test\\TestFirm_firmato.pdf.p7m");
		
		
		sign.setTransport(TypeTransport.BYNARYNET);
		
		pkcs.setSignRequestV2(sign);
		
		request.setPkcs7SignV2(pkcs);
		
		Pkcs7SignV2ResponseE response= stub.pkcs7SignV2(request);
		JsonObject jsonObj = new JsonObject();
		

	
	//System.out.println("Status :"+response.getPkcs7SignV2Response().get_return().getStatus());
	//System.out.println("Status :"+response.getPkcs7SignV2Response().get_return().getDescription());
	//System.out.println("Status :"+response.getPkcs7SignV2Response().get_return().getReturn_code());
	
		if( response.getPkcs7SignV2Response().get_return().getStatus().equals("KO")) {
			jsonObj.addProperty("success", false);
			jsonObj.addProperty("messaggio", response.getPkcs7SignV2Response().get_return().getDescription());
			jsonObj.addProperty("errorType", "sign");
		}else {
			
			jsonObj.addProperty("success", true);
			
			DataHandler fileReturn=response.getPkcs7SignV2Response().get_return().getBinaryoutput();
			File targetFile = new File(nomeCert+".p7m");
			FileUtils.copyInputStreamToFile(fileReturn.getInputStream(), targetFile);

			jsonObj.addProperty("messaggio", "Certificato firmato");
		}
		return jsonObj;
		 
	}
	


	
	
public static JsonObject signDocumento(String utente, String filename) throws TypeOfTransportNotImplementedException, IOException {
		

		ArubaSignServiceServiceStub stub = new ArubaSignServiceServiceStub();
		
		
		Pkcs7SignV2E request= new Pkcs7SignV2E();
		Pkcs7SignV2 pkcs = new Pkcs7SignV2();
		
		SignRequestV2  sign = new SignRequestV2();
		
		sign.setCertID("AS0");
		
		Auth identity = new Auth();
		identity.setDelegated_domain("faSTI");
		identity.setTypeOtpAuth("faSTI");
		identity.setOtpPwd("dsign");
		identity.setTypeOtpAuth("faSTI");
		
		identity.setUser(utente);
		
		identity.setDelegated_user("admin.firma");
		identity.setDelegated_password("uBFqc8YYslTG");
		
		sign.setIdentity(identity);
	
		String path = Costanti.PATH_FIRMA_DIGITALE+filename;
		File f = new File(path);

 		URI uri = f.toURI();
		
		javax.activation.DataHandler dh = new DataHandler(uri.toURL());
		
		sign.setBinaryinput(dh);
		
		

		sign.setTransport(TypeTransport.BYNARYNET);
		
	
		pkcs.setSignRequestV2(sign);
		
		request.setPkcs7SignV2(pkcs);
		
		
		Pkcs7SignV2ResponseE response= stub.pkcs7SignV2(request);
		JsonObject jsonObj = new JsonObject();
		

	
		if( response.getPkcs7SignV2Response().get_return().getStatus().equals("KO")) {
			jsonObj.addProperty("success", false);
			jsonObj.addProperty("messaggio", response.getPkcs7SignV2Response().get_return().getDescription());
		}else {
			
			jsonObj.addProperty("success", true);
			String fileNoExt = filename.substring(0, filename.length()-4);
			DataHandler fileReturn=response.getPkcs7SignV2Response().get_return().getBinaryoutput();
			File targetFile = new File(Costanti.PATH_FIRMA_DIGITALE+ fileNoExt+".p7m");
			FileUtils.copyInputStreamToFile(fileReturn.getInputStream(), targetFile);

			jsonObj.addProperty("messaggio", "Documento firmato");
		}
		
		f.delete();
		return jsonObj;
		
		
		 
	}

public static JsonObject signDocumentoPades(String utente, String filename) throws TypeOfTransportNotImplementedException, IOException {
	

	ArubaSignServiceServiceStub stub = new ArubaSignServiceServiceStub();
	
	
	PdfsignatureV2E request= new PdfsignatureV2E();
	PdfsignatureV2 pkcs = new PdfsignatureV2();
	
	SignRequestV2  sign = new SignRequestV2();
	
	
	sign.setCertID("AS0");
	
	Auth identity = new Auth();
	identity.setDelegated_domain("faSTI");
	identity.setTypeOtpAuth("faSTI");
	identity.setOtpPwd("dsign");
	identity.setTypeOtpAuth("faSTI");
	
	identity.setUser(utente);
	
	identity.setDelegated_user("admin.firma");
	identity.setDelegated_password("uBFqc8YYslTG");
	
	sign.setIdentity(identity);

	String path = Costanti.PATH_FIRMA_DIGITALE+filename;
	File f = new File(path);

		URI uri = f.toURI();
	
	javax.activation.DataHandler dh = new DataHandler(uri.toURL());
	
	sign.setBinaryinput(dh);
	
	

	sign.setTransport(TypeTransport.BYNARYNET);
	

	pkcs.setSignRequestV2(sign);
	pkcs.setPdfprofile(PdfProfile.BASIC);
	
	
	request.setPdfsignatureV2(pkcs);
	
	
	PdfsignatureV2ResponseE response= stub.pdfsignatureV2(request);
	JsonObject jsonObj = new JsonObject();
	


	if( response.getPdfsignatureV2Response().get_return().getStatus().equals("KO")) {
		jsonObj.addProperty("success", false);
		jsonObj.addProperty("messaggio", response.getPdfsignatureV2Response().get_return().getDescription());
	}else {
		
		jsonObj.addProperty("success", true);
		String fileNoExt = filename.substring(0, filename.length()-4);
		DataHandler fileReturn=response.getPdfsignatureV2Response().get_return().getBinaryoutput();
		File targetFile = new File(Costanti.PATH_FIRMA_DIGITALE+ fileNoExt+".pdf");
		FileUtils.copyInputStreamToFile(fileReturn.getInputStream(), targetFile);

		jsonObj.addProperty("messaggio", "Documento firmato");
	}
	
//	f.delete();
	return jsonObj;
	
	
	 
}



public static JsonObject signCertificatoPades(UtenteDTO utente, String keyWord, boolean lat,  CertificatoDTO certificato) throws TypeOfTransportNotImplementedException, IOException {
	

	ArubaSignServiceServiceStub stub = new ArubaSignServiceServiceStub();
	
	
	PdfsignatureV2E request= new PdfsignatureV2E();
	PdfsignatureV2 pkcs = new PdfsignatureV2();
	
	SignRequestV2  sign = new SignRequestV2();
	
	
	sign.setCertID("AS0");
	
	Auth identity = new Auth();
	identity.setDelegated_domain("faSTI");
	identity.setTypeOtpAuth("faSTI");
	identity.setOtpPwd("dsign");
	identity.setTypeOtpAuth("faSTI");
	
	identity.setUser(utente.getIdFirma());
	
	identity.setDelegated_user("admin.firma");
	identity.setDelegated_password("uBFqc8YYslTG");
	
	sign.setIdentity(identity);
	
	String path = Costanti.PATH_FOLDER+certificato.getMisura().getIntervento().getNomePack()+"\\"+certificato.getNomeCertificato();
	
	File f = new File(path);

	URI uri = f.toURI();	


	javax.activation.DataHandler dh = new DataHandler(uri.toURL());
	
	sign.setBinaryinput(dh);

	sign.setTransport(TypeTransport.BYNARYNET);	

	pkcs.setSignRequestV2(sign);
	pkcs.setPdfprofile(PdfProfile.BASIC);
 	request.setPdfsignatureV2(pkcs);
 	
 	PdfSignApparence apparence = new PdfSignApparence();
	
	
	if(utente.getFile_firma()!=null && !utente.getFile_firma().equals("") && !lat) {
	    PdfReader reader = new PdfReader(path);
	    Integer[] fontPosition = null;
		for(int i = 1;i<=reader.getNumberOfPages();i++) {
			fontPosition = getFontPosition(path, keyWord, i);
			
			if(fontPosition[0] != null && fontPosition[1] != null) {
				apparence.setPage(i);
				break;
			}
		}
				
		
	    System.out.println(Arrays.toString(fontPosition));
	
	    apparence.setImage("C:\\PortalECI\\FileFirme\\"+utente.getFile_firma());
	
	  
	   apparence.setLeftx(fontPosition[0] - 15 );        	
	   apparence.setLefty(fontPosition[1] +10);
	   apparence.setRightx(fontPosition[0] + 70);
	   apparence.setRighty(fontPosition[1]-25);

	  
	    apparence.setImageOnly(true);
	    apparence.setResizeMode(1);
	    pkcs.setApparence(apparence);
	    reader.close();
	}
	
    
     PdfsignatureV2ResponseE response= stub.pdfsignatureV2(request);
     
     JsonObject myObj = new JsonObject();
     		
     if( !response.getPdfsignatureV2Response().get_return().getStatus().equals("KO")) {

     	DataHandler fileReturn=response.getPdfsignatureV2Response().get_return().getBinaryoutput();
     	File targetFile=  new File(path);
     			     			
     	FileUtils.copyInputStreamToFile(fileReturn.getInputStream(), targetFile);
     	myObj.addProperty("success", true);
     }else {
    	 myObj.addProperty("succes", false);
     }

	
	
	return myObj;


}


private static Integer[] getFontPosition(String filePath, final String keyWord, Integer pageNum) throws IOException {
    final Integer[] result = new Integer[2];
    PdfReader pdfReader = new PdfReader(filePath);
    if (pageNum == null) {
        pageNum = pdfReader.getNumberOfPages();
    }
    new PdfReaderContentParser(pdfReader).processContent(pageNum, new RenderListener() {
        public void beginTextBlock() {

        }

        public void renderText(TextRenderInfo textRenderInfo) {
        	
            String text = textRenderInfo.getText();
          //  System.out.println("text is ：" + text);
            if (text != null && text.contains(keyWord)) {
                                     // The abscissa and ordinate of the text in the page
                com.itextpdf.awt.geom.Rectangle2D.Float textFloat = textRenderInfo.getBaseline().getBoundingRectange();
                float x = textFloat.x;
                float y = textFloat.y;
                result[0] = (int) x;
                result[1] = (int) y;
                 //                    System.out.println(String.format("The signature text field absolute position is x:%s, y:%s", x, y));
            }
        }

        public void endTextBlock() {

        }

        public void renderImage(ImageRenderInfo renderInfo) {

        }
    });
    return result;
}



}
