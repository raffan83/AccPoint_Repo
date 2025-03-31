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
                   <a href="#" onClick="dettaglioStrumentoFromMisura('${misura.strumento.__id}')" class="pull-right customTooltip" title="Click per aprire il dettaglio dello stumento" >${misura.strumento.denominazione} (${misura.strumento.matricola} | ${misura.strumento.codice_interno})</a>
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
		                  <a href="#" class="pull-right customTooltip" title="Click per scaricare il pacchetto" onClick="scaricaPacchettoUploaded('${misura.interventoDati.nomePack}', '${misura.intervento.nomePack }')">${misura.interventoDati.nomePack}</a>
		  				 </li>
		  				 
		  				  <li class="list-group-item">
		                  <b>Registro Laboratorio</b> 
		                  <a class="pull-right">${misura.intervento.id}_${misura.misuraLAT.id }_${misura.strumento.__id}</a>
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
		<c:if test="${misura.file_condizioni_ambientali!= null && misura.file_condizioni_ambientali!= '' }">
					<li class="list-group-item">
		                  <b>Condizioni Ambientali</b> 
		                  <a class="pull-right btn btn-success btn-xs customTooltip" title="Click per scaricare le condizioni ambientali" href='gestioneMisura.do?action=download_condizioni_ambientali&id_misura=${utl:encryptData(misura.id)}'><i class="fa fa-arrow-down small"></i></a>
		  				 </li>

					
					</c:if>
  				 <c:if test='${userObj.checkRuolo("AM") || userObj.checkRuolo("OP") || userObj.checkRuolo("CI")}'>
		
  				 					<c:if test="${misura.indice_prestazione!=null }">
						<li class="list-group-item">
		                  <b>Indice di Prestazione</b> 
		                  
						 <c:if test="${misura.indice_prestazione=='V' }">
								<div class="lamp lampGreen pull-right" style="margin:auto"></div>
								<a class="pull-right" style="margin-right:3px">PERFORMANTE</a>
								</c:if>
								
								<c:if test="${misura.indice_prestazione=='G' }">
								 <div class="lamp lampYellow pull-right"  style="margin:auto"></div>
								 <a class="pull-right"  style="margin-right:3px">STABILE</a> 
								</c:if>
								
								<c:if test="${misura.indice_prestazione=='R' }">
								 <div class="lamp lampRed pull-right" style="margin:auto"></div>
								 <a class="pull-right"  style="margin-right:3px">ALLERTA</a> 
								</c:if>
								
								<c:if test="${misura.indice_prestazione=='X' }">
								<div class="lamp lampNI pull-right" style="margin:auto"></div>
								<a class="pull-right"  style="margin-right:3px">NON IDONEO</a> 
								</c:if>
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
		 
		 <li class=""><a href="#notestrumento" data-toggle="tab" aria-expanded="false" onclick="" id="noteStrumentoTab">Note Strumento</a></li>
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
              			<div class="tab-pane" id="notestrumento">
              			   		

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
</jsp:attribute>

<jsp:attribute name="extra_js_footer">

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
  
 <script type="text/javascript">
 
   
    $(document).ready(function() {
    	
    	 $('a[data-toggle="tab2"]').tab('show');


 		
 		
 		
 		   $('a[data-toggle="tab"]').one('shown.bs.tab', function (e) {


 		       	var  contentID = e.target.id;

 		     	if(contentID == "dettaglioTab"){
 		       		exploreModal("dettaglioStrumento.do","id_str="+${misura.strumento.__id},"#dettaglio");
 		       	}
 		       	if(contentID == "misureTab"){
 		       		exploreModal("strumentiMisurati.do?action=ls&id="+${misura.strumento.__id},"","#misure")
 		       	}
 		       	if(contentID == "modificaTab"){
 		       		exploreModal("modificaStrumento.do?action=modifica&id="+${misura.strumento.__id},"","#modifica")
 		       	}
 		       	if(contentID == "documentiesterniTab"){
 		       		exploreModal("documentiEsterni.do?id_str="+${misura.strumento.__id},"","#documentiesterni")
 		       	//	exploreModal("dettaglioStrumento.do","id_str="+${misura.strumento.__id},"#documentiesterni");
 		       	}
 		       	
 		       	if(contentID == "noteStrumentoTab"){
 		    		
 		       		exploreModal("listaStrumentiSedeNew.do?action=note_strumento&id_str="+${misura.strumento.__id},"","#notestrumento")
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

