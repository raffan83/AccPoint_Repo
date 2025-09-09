<%@page import="com.google.gson.JsonArray"%>
<%@page import="it.portaleSTI.Util.Costanti"%>
<%@page import="it.portaleSTI.DTO.PuntoMisuraDTO"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.math.BigDecimal"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%@ page language="java" import="java.util.ArrayList" %>



<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
          <h1 class="pull-left">
        Dettaglio Misura
        <small></small>
      </h1>
    <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            
            <div class="row">
<div class="col-md-6">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati Misura
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${misura.id}</a>
                </li>
                <li class="list-group-item">
                  <b>Data Misura</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${misura.dataMisura}" /></a>
                </li>
                <li class="list-group-item">
                <div class="row">
                <div class="col-md-2">
                  <b>Strumento</b>
                  </div>
                  <div class="col-md-10">
                   <a href="#" onClick="dettaglioStrumentoFromMisura('${utl:encryptData(misura.strumento.__id)}')" class="pull-right customTooltip" title="Click per aprire il dettaglio dello stumento" ><c:out value="${misura.strumento.denominazione} (${misura.strumento.matricola} | ${misura.strumento.codice_interno})"/></a>
                  </div>
                  </div>
                </li>
                <li class="list-group-item">
                  <b>Temperatura</b> <a class="pull-right">
                  <fmt:formatNumber value="${misura.temperatura}" minFractionDigits="3"/>
                  
                  </a>
                </li>
                <li class="list-group-item">
                  <b>Umidità</b> <a class="pull-right">
                   <fmt:formatNumber value="${misura.umidita}" minFractionDigits="3"/></a>
                </li>
                 <li class="list-group-item">
                  <b>Tipo Firma</b> <a class="pull-right">
                   <fmt:formatNumber value="${misura.tipoFirma}" minFractionDigits="0"/></a>
                </li>
                 <c:if test = '${misura.obsoleto == "S"}'>
                <li class="list-group-item">
                  <b>Misura Obsoleta</b> 
                  
					 <a class="pull-right label label-danger">Obsoleta</a>
  				 </li>
  				</c:if>
  				<li class="list-group-item">
                  <b>Stato Ricezione</b> 
                  
					 <a class="pull-right">${misura.statoRicezione.nome}</a>
  				 </li>
  				

					<c:if test="${!user.checkRuolo('CL')}">
						<li class="list-group-item">
		                  <b>Intervento</b> 
		                  
							 <a href="#" class="customTooltip pull-right" title="Click per aprire il dettaglio dell'Intervento" onclick="callAction('gestioneInterventoDati.do?idIntervento=${utl:encryptData(misura.intervento.id)}');">${misura.intervento.id}</a>
		  				 </li>
		  				 
		  				 <li class="list-group-item">
		                  <b>Download Pack</b> 
		                  <a href="#" class="pull-right customTooltip" title="Click per scaricare il pacchetto" onClick="scaricaPacchettoUploaded('${misura.interventoDati.nomePack}')">${misura.interventoDati.nomePack}</a>
		  				 </li>
					<c:if test="${misura.file_allegato!= null && misura.file_allegato!= '' }">
					<li class="list-group-item">
		                  <b>Allegato</b> 
		                  <a target ="_blank" class="pull-right customTooltip" title="Click per scaricare l'allegato" href='scaricaCertificato.do?action=download_allegato&id_misura=${utl:encryptData(misura.id)}'>${misura.file_allegato }</a>
		  				 </li>
		  				 <li class="list-group-item">
		                  <b>Note Allegato</b> 
		                   <a class="pull-right">${misura.note_allegato}</a>
		  				 </li>
					
					</c:if>
					</c:if>

  				       <c:if test="${cert.stato.id == 2 }">
                 <li class="list-group-item">
                  <b>Download Certificato</b> <a target="_blank"   class="btn btn-danger customTooltip pull-right btn-xs" title="Click per scaricare il Cerificato"  href="scaricaCertificato.do?action=certificatoStrumento&nome=${utl:encryptData(cert.nomeCertificato)}&pack=${utl:encryptData(misura.intervento.nomePack)}" >Certificato <i class="fa fa-file-pdf-o"></i></a>
                </li>
                </c:if>
  				 
                
               
        </ul>

</div>
</div>
</div>



<div class="col-xs-12">
  <div class="box box-danger box-solid" >
<div class="box-header with-border">
	 Controllo visivo
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
 
 <div class="row">
 <div class="col-xs-12">
 <table class="table table-condensed">
 <tbody>
 <tr>
 <td>Conduttore di protezione (solo per apparecchiature in classe I)</td>
 <td>
 <c:choose>
 <c:when test="${misura_se.COND_PROT == 'OK'  }">

<div class="lamp lampGreen"></div>
 </c:when>
 <c:otherwise>
 <div class="lamp lampRed"></div> 
 </c:otherwise>
 </c:choose>
</td>
 </tr>
 <tr>
 <td>Involucro e parti meccaniche</td>
 <td>
 
  <c:choose>
 <c:when test="${misura_se.INVOLUCRO == 'OK'  }">

<div class="lamp lampGreen"></div>
 </c:when>
 <c:otherwise>
 <div class="lamp lampRed"></div> 
 </c:otherwise>
 </c:choose>
 </td>
 </tr>
 <tr>
 <td>Parti isolanti / fusibili</td>
 <td>
  <c:choose>
 <c:when test="${misura_se.FUSIBILI == 'OK'  }">

<div class="lamp lampGreen"></div>
 </c:when>
 <c:otherwise>
 <div class="lamp lampRed"></div> 
 </c:otherwise>
 </c:choose>
 </td>
 </tr>
  <tr>
 <td>Connettori e prese</td>
 <td> 
  <c:choose>
 <c:when test="${misura_se.CONNETTORI == 'OK'  }">

<div class="lamp lampGreen"></div>
 </c:when>
 <c:otherwise>
 <div class="lamp lampRed"></div> 
 </c:otherwise>
 </c:choose>
 </td>
 </tr>
  <tr>
 <td>Marchiature</td>
 <td> 
  <c:choose>
 <c:when test="${misura_se.MARCHIATURE == 'OK'  }">

<div class="lamp lampGreen"></div>
 </c:when>
 <c:otherwise>
 <div class="lamp lampRed"></div> 
 </c:otherwise>
 </c:choose>
 </td>
 </tr>
  <tr>
 <td>Altro</td>
 <td> 
  <c:choose>
 <c:when test="${misura_se.ALTRO == 'OK'  }">

<div class="lamp lampGreen"></div>
 </c:when>
 <c:otherwise>
 <div class="lamp lampRed"></div> 
 </c:otherwise>
 </c:choose></td>
 </tr>
 </tbody>
 
 </table>
 </div>
 
 </div>
 
</div>
</div>
</div>

<br><br>


 <div class="col-xs-12">
  <div class="box box-danger box-solid" >
<div class="box-header with-border">
	 Dettaglio Misura
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
 
 <div class="row">

  <div class="col-xs-6">
  <label> ID PROVA</label>
  <input type="text" class="form-control" style="width:70%" readonly value="${misura_se.getID_PROVA()}">
  </div>
   <div class="col-xs-2">
   <label>DATA E ORA MISURA</label>
    <input type="text" class="form-control" readonly value="${misura_se.getDATA()} ${misura_se.getORA()}">
   </div>
    <div class="col-xs-2">
    <label>CLASSE</label>
     <input type="text" class="form-control" readonly value="${misura_se.getSK()}">
    </div>
     <div class="col-xs-2">
    <label>PARTI APPLICATE</label>
     <input type="text" class="form-control" readonly value="${misura_se.getPARTI_APPLICATE()}">
    </div>

 </div>
 <br>
 <div class="row">
 <div class="col-xs-12">
 <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
				 <thead><tr class="active">
				 <th>Misurazione</th>
				 <th>Valore Misurato</th>
				 <th>Limite Misura</th>
				 <th>Esito</th>
	 
				
				 </tr></thead>
				 
				 <tbody>
							 
				 <tr role="row" >
				 	<td>Valore Resistenza Conduttore di protezione</td>
				 	<td>${misura_se.getR_SL()}</td>
				 	<td>${misura_se.getR_SL_GW() }</td>
				 	<td><c:choose>
 						<c:when test="${utl:returnEsit(misura_se.getR_SL(), misura_se.getR_SL_GW(), 0) =='OK'}">
							<div class="lamp lampGreen"></div>
 						</c:when>
 						<c:when test="${utl:returnEsit(misura_se.getR_SL(), misura_se.getR_SL_GW(), 0) =='KO'}">
							<div class="lamp lampRed"></div>
 						</c:when>
 						<c:otherwise>
 							
						 </c:otherwise>
 						</c:choose>
				 	</td>
				</tr>
				 <tr role="row" >
				 	<td>Valore Resistenza di isolamento</td>
				 	<td>${misura_se.getR_ISO() }</td>
				 	<td>${misura_se.getR_ISO_GW() }</td>
				 	<td><c:choose>
 						<c:when test="${utl:returnEsit(misura_se.getR_ISO(), misura_se.getR_ISO_GW(), 1) =='OK'}">
							<div class="lamp lampGreen"></div>
 						</c:when>
 						<c:when test="${utl:returnEsit(misura_se.getR_ISO(), misura_se.getR_ISO_GW(), 1) =='KO'}">
							<div class="lamp lampRed"></div>
 						</c:when>
 						<c:otherwise>
 						
						 </c:otherwise>
 						</c:choose>
				 	</td>
				</tr>
				<tr role="row" >
				 	<td>Valore Tensione di verifica Resistenza di isolamento</td>
				 	<td>${misura_se.getU_ISO() }</td>
				 	<td>${misura_se.getU_ISO_GW() }</td>
				 	<td><c:choose>
 						<c:when test="${utl:returnEsit(misura_se.getU_ISO(), misura_se.getU_ISO_GW(), 1) =='OK'}">
							<div class="lamp lampGreen"></div>
 						</c:when>
 						<c:when test="${utl:returnEsit(misura_se.getU_ISO(), misura_se.getU_ISO_GW(), 1) =='KO'}">
							<div class="lamp lampRed"></div>
 						</c:when>
 						<c:otherwise>
 							
						 </c:otherwise>
 						</c:choose>
					</td>
				</tr>
				<tr role="row" >
				 	<td>Valore corrente differenziale tra L e N</td>
				 	<td>${misura_se.getI_DIFF() }</td>
				 	<td>${misura_se.getI_DIFF_GW() }</td>
				 	<td>
				 	<c:choose>
 						<c:when test="${utl:returnEsit(misura_se.getI_DIFF(), misura_se.getI_DIFF_GW(), 0) == 'OK'}">
							<div class="lamp lampGreen"></div>
 						</c:when>
 						<c:when test="${utl:returnEsit(misura_se.getI_DIFF(), misura_se.getI_DIFF_GW(), 0) == 'KO'}">
							<div class="lamp lampRed"></div>
 						</c:when>
 						<c:otherwise>
 							
						 </c:otherwise>
 						</c:choose>
					</td>
				</tr>
				
				<tr role="row" >
				 	<td>Valore corrente dispersione involucro</td>
				 	<td>${misura_se.getI_EGA() }</td>
				 	<td>${misura_se.getI_EGA_GW() }</td>
				 	<td>
				 	<c:choose>
 						<c:when test="${utl:returnEsit(misura_se.getI_EGA(), misura_se.getI_EGA_GW(), 0)  == 'OK'}">
							<div class="lamp lampGreen"></div>
 						</c:when>
 						<c:when test="${utl:returnEsit(misura_se.getI_EGA(), misura_se.getI_EGA_GW(), 0)  == 'KO'}">
							<div class="lamp lampRed"></div>
 						</c:when>
 						<c:otherwise>
 							
						 </c:otherwise>
 						</c:choose>
				 	</td>
				</tr>
				<tr role="row" >
				 	<td>Valore corrente dispersione parte applicata</td>
				 	<td>${misura_se.getI_EPA() }</td>
				 	<td>${misura_se.getI_EPA_GW() }</td>
				 	<td>
				 	<c:choose>
 						<c:when test="${utl:returnEsit(misura_se.getI_EPA(), misura_se.getI_EPA_GW(), 0)  == 'OK'}">
							<div class="lamp lampGreen"></div>
 						</c:when>
 						<c:when test="${utl:returnEsit(misura_se.getI_EPA(), misura_se.getI_EPA_GW(), 0)  == 'KO'}">
							<div class="lamp lampRed"></div>
 						</c:when>
 						<c:otherwise>
 							
						 </c:otherwise>
 						</c:choose>
				 	</td>
				</tr>
				<tr role="row" >
				 	<td>Valore corrente AC dispersione involucro metodo diretto (in funzione)</td>
				 	<td>${misura_se.getI_GA() }</td>
				 	<td>${misura_se.getI_GA_GW() }</td>
				 	<td>
				 	<c:choose>
 						<c:when test="${utl:returnEsit(misura_se.getI_GA(), misura_se.getI_GA_GW(), 0)   == 'OK'}">
							<div class="lamp lampGreen"></div>
 						</c:when>
 						<c:when test="${utl:returnEsit(misura_se.getI_GA(), misura_se.getI_GA_GW(), 0)   == 'KO'}">
							<div class="lamp lampRed"></div>
 						</c:when>
 						<c:otherwise>
 						
						 </c:otherwise>
 						</c:choose>
				 	</td>
				</tr>
				<tr role="row" >
				 	<td>Valore corrente AC dispersione involucro metodo diretto (rete invertita)</td>
				 	<td>${misura_se.getI_GA_SFC() }</td>
				 	<td>${misura_se.getI_GA_SFC_GW() }</td>
				 	<td>
				 	<c:choose>
 						<c:when test="${utl:returnEsit(misura_se.getI_GA_SFC(), misura_se.getI_GA_SFC_GW(), 0)   == 'OK'}">
							<div class="lamp lampGreen"></div>
 						</c:when>
 						<c:when test="${utl:returnEsit(misura_se.getI_GA_SFC(), misura_se.getI_GA_SFC_GW(), 0)   == 'KO'}">
							<div class="lamp lampRed"></div>
 						</c:when>
 						<c:otherwise>
 					
						 </c:otherwise>
 						</c:choose>
				 	</td>
				</tr>
				<tr role="row" >
				 	<td>Valore corrente AC dispersione parte applicata (in funzione)</td>
				 	<td>${misura_se.getI_PA_AC() }</td>
				 	<td>${misura_se.getI_PA_AC_GW() }</td>
				 	<td>
				 	<c:choose>
 						<c:when test="${utl:returnEsit(misura_se.getI_PA_AC(), misura_se.getI_PA_AC_GW(), 0)  == 'OK'}">
							<div class="lamp lampGreen"></div>
 						</c:when>
 						<c:when test="${utl:returnEsit(misura_se.getI_PA_AC(), misura_se.getI_PA_AC_GW(), 0)  == 'KO'}">
							<div class="lamp lampRed"></div>
 						</c:when>
 						<c:otherwise>
 							
						 </c:otherwise>
 						</c:choose>
				 	</td>
				</tr>
				<tr role="row" >
				 	<td>Valore corrente DC dispersione parte applicata (in funzione)</td>
				 	<td>${misura_se.getI_PA_DC() }</td>
				 	<td>${misura_se.getI_PA_DC_GW() }</td>
				 	<td>
				 		<c:choose>
 						<c:when test="${utl:returnEsit(misura_se.getI_PA_DC(), misura_se.getI_PA_DC_GW(), 0)  == 'OK'}">
							<div class="lamp lampGreen"></div>
 						</c:when>
 						<c:when test="${utl:returnEsit(misura_se.getI_PA_DC(), misura_se.getI_PA_DC_GW(), 0)  == 'KO'}">
							<div class="lamp lampRed"></div>
 						</c:when>
 						<c:otherwise>
 						
						 </c:otherwise>
 						</c:choose>
				 	</td>
				</tr>
				<tr role="row" >
				 	<td>Tensione di Verifica</td>
				 	<td>${misura_se.getPSPG() }</td>
				 	<td></td>
				 	<td></td>
				</tr>
				<tr role="row" >
				 	<td>Tensione nominale</td>
				 	<td>${misura_se.getUBEZ_GW() }</td>
				 	<td></td>
				 	<td></td>
				</tr>


					
				 </tbody>
				 </table> 

 </div>
 
 </div>
 
</div>
</div>
</div> 


       
 </div>
    
        

</div>
</div>
</div>
 </div> 
</section>
</div>

  
  <div id="myModalDettaglioStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Strumento</h4>
      </div>
       <div class="modal-body">

        <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
             <ul class="nav nav-tabs">
              <li class="active"><a href="#dettaglio" data-toggle="tab" aria-expanded="true" onclick="" id="dettaglioTab">Dettaglio Strumento</a></li>
              <li class=""><a href="#misure" data-toggle="tab" aria-expanded="false" onclick="" id="misureTab">Misure</a></li>
       <!--        <li class=""><a href="#prenotazione" data-toggle="tab" aria-expanded="false" onclick="" id="prenotazioneTab">Stato Prenotazione</a></li> -->
        
 		<c:if test="${userObj.checkPermesso('MODIFICA_STRUMENTO_METROLOGIA')}">
               <li class=""><a href="#modifica" data-toggle="tab" aria-expanded="false" onclick="" id="modificaTab">Modifica Strumento</a></li>
		</c:if>		
		 <li class=""><a href="#documentiesterni" data-toggle="tab" aria-expanded="false" onclick="" id="documentiesterniTab">Documenti esterni</a></li>
             </ul>
            </ul>
            <div class="tab-content">
               <div class="tab-pane active" id="dettaglio">

    			</div> 

              <!-- /.tab-pane -->
             
			  <div class="tab-pane" id="misure">
                

         
			 </div> 


              <!-- /.tab-pane -->


               		<c:if test="${userObj.checkPermesso('MODIFICA_STRUMENTO_METROLOGIA')}">
              
              			<div class="tab-pane" id="modifica">
              

              			</div> 
              		</c:if>		
              		
              		<div class="tab-pane" id="documentiesterni">
              

              			</div> 
              </div>  
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
    
        
        
        
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
       <!--  <button type="button" class="btn btn-primary" onclick="approvazioneFromModal('app')"  >Approva</button>
        <button type="button" class="btn btn-danger"onclick="approvazioneFromModal('noApp')"   >Non Approva</button> -->
      </div>
    </div>
  </div>
  
  
   
  </div>
  
  <!-- /.content-wrapper -->

  <t:dash-footer />
  

  <t:control-sidebar />
   


<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">
<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
<link type="text/css" href="css/bootstrap.min.css" />

<style>
.lamp {
    height: 30px;
    width: 30px;
    border-style: solid;
    border-width: 2px;
    border-radius: 25px;
}
.lampRed {
    background-color: #dd4b39;
}
.lampGreen {
    background-color: green;
}

</style>
</jsp:attribute>

<jsp:attribute name="extra_js_footer">

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
 <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.js"></script>
  <script type="text/javascript" src="js/customCharts.js"></script>  
 <script type="text/javascript">

    $(document).ready(function() {
    	    	
    	$('.dropdown-toggle').dropdown();
    	
    	
    	$('a[data-toggle="tab"]').one('shown.bs.tab', function (e) {


	       	var  contentID = e.target.id;

	     	if(contentID == "dettaglioTab"){
	       		exploreModal("dettaglioStrumento.do","id_str=${utl:encryptData(misura.strumento.__id)}","#dettaglio");
	       	}
	       	if(contentID == "misureTab"){
	       		exploreModal("strumentiMisurati.do?action=ls&id=${utl:encryptData(misura.strumento.__id)}","","#misure")
	       	}
	       	if(contentID == "modificaTab"){
	       		exploreModal("modificaStrumento.do?action=modifica&id="+${misura.strumento.__id},"","#modifica")
	       	}
	       	if(contentID == "documentiesterniTab"){
	       		exploreModal("documentiEsterni.do?id_str="+${misura.strumento.__id},"","#documentiesterni")
	       	//	exploreModal("dettaglioStrumento.do","id_str="+${misura.strumento.__id},"#documentiesterni");
	       	}
	    		
	 		});
		   
		   $('#myModalDettaglioStrumento').on('hidden.bs.modal', function (e) {

	    	 	$('#dettaglioTab').tab('show');
	    	 	$('body').removeClass('noScroll');
	    	 	$(document.body).css('padding-right', '0px');
	    	});
	

 	
 	


    	

    });
    

  </script>
  
</jsp:attribute> 
</t:layout>

