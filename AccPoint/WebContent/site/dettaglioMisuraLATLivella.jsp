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
    <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
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

  				 
  				 
                
               
        </ul>

</div>
</div>
</div>



<div class="row">
<div class="col-xs-12">
<div class= "col-xs-4">
<label>S. Media Totale</label>
<c:choose>
<c:when test="${lista_pos!=null && lista_neg!=null }">
<input class="form-control" value="${utl:getAverageLivella(lista_pos, lista_neg, 2) }" readonly>
</c:when>
<c:otherwise>
<input class="form-control" value="" readonly>
</c:otherwise>
</c:choose>
</div>

<div class= "col-xs-4">
<label>Dev. Std Totale</label>
<c:choose>
<c:when test="${lista_pos!=null && lista_neg!=null }">
<input class="form-control" value="${utl:getDevStdLivella(lista_pos, lista_neg, 2) }" readonly>
</c:when>
<c:otherwise>
<input class="form-control" value="" readonly>
</c:otherwise>
</c:choose>
</div>


<div class= "col-xs-4">
<label>SCmax</label>
<c:choose>
<c:when test="${lista_pos!=null && lista_neg!=null }">
<input class="form-control" value="${utl:getScMaxLivella(lista_pos, lista_neg) }" readonly>
</c:when>
<c:otherwise>
<input class="form-control" value="" readonly>
</c:otherwise>
</c:choose>
</div>
</div>
</div><br><br>



<div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Semiscala Positiva SX
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
 
 
<table id="tabNeg" class="table table-bordered table-hover dataTable table-striped"  role="grid" width="100%">
 <thead><tr class="active">  
 <th>Tratto</th>
 <th>mm/m</th>
 <th>sec</th>
 <th>P1 Andata</th>
 <th>P1 Ritorno</th>
 <th>P1 Media</th>
 <th>P1 Diff</th>
 <th>P2 Andata</th>
 <th>P2 Ritorno</th>
 <th>P2 Media</th>
 <th>P2 Diff</th>
 <th>Media Tratto 0</th>
 <th>Errore Cumm</th>
 <th>AVG sec</th>
 <th>AVG mm/m</th>
 <th>Div Dex mm/m</th>
 <th>corr bolla mm/m</th>
 <th>corr bolla sec</th>

 </tr></thead>
 
 <tbody>
<c:forEach items="${lista_neg}" var="punto" varStatus="loop">
 <tr role="row">

	<td>${punto.rif_tacca }</td>
	<td>${punto.valore_nominale_tratto }</td>
	<td>${punto.valore_nominale_tratto_sec }</td>
	<td>${punto.p1_andata }</td>
	<td>${punto.p1_ritorno }</td>
	<td>${punto.p1_media }</td>
	<td>${punto.p1_diff }</td>
	<td>${punto.p2_andata }</td>
	<td>${punto.p2_ritorno }</td>
	<td>${punto.p2_media }</td>
	<td>${punto.p2_diff }</td>
	<td>${punto.media }</td>
	<td>${punto.errore_cum }</td>
	<td>${punto.media_corr_sec }</td>
	<td>${punto.media_corr_mm }</td>
	<td>${punto.div_dex }</td>
	<td>${punto.corr_boll_mm }</td>
	<td>${punto.corr_boll_sec }</td>

	</tr>
  
	</c:forEach>


 </tbody>
 </table> 
 
 <div class="row">
<div class="col-xs-12">
<div class="col-xs-4"></div>
<div class="col-xs-4"></div>
<div class="col-xs-4">
<label>S. Media</label>
<c:choose>
<c:when test="${lista_pos!=null }">
<input class="form-control" value="${utl:getAverageLivella(null, lista_neg, 1) }" readonly>
</c:when>
<c:otherwise>
<input class="form-control" value="" readonly>
</c:otherwise>
</c:choose>

<label>Dev. Std.</label>
<c:choose>
<c:when test="${lista_neg!=null }">
<input class="form-control" value="${utl:getDevStdLivella(null, lista_neg, 1) }" readonly>
</c:when>
<c:otherwise>
<input class="form-control" value="" readonly>
</c:otherwise>
</c:choose>

</div>
 </div>
 </div>
</div>
</div>

            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
        
        
        
        
        
<div class="row">
<div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Semiscala Positiva DX
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
 
 
<table id="tabPos" class="table table-bordered table-hover dataTable table-striped"  role="grid" width="100%">
 <thead><tr class="active">  
 <th>Tratto</th>
 <th>mm/m</th>
 <th>sec</th>
 <th>P1 Andata</th>
 <th>P1 Ritorno</th>
 <th>P1 Media</th>
 <th>P1 Diff</th>
 <th>P2 Andata</th>
 <th>P2 Ritorno</th>
 <th>P2 Media</th>
 <th>P2 Diff</th>
 <th>Media Tratto 0</th>
 <th>Errore Cumm</th>
 <th>AVG sec</th>
 <th>AVG mm/m</th>
 <th>Div Dex mm/m</th>
 <th>corr bolla mm/m</th>
 <th>corr bolla sec</th>

 </tr></thead>
 
 <tbody>
<c:forEach items="${lista_pos}" var="punto" varStatus="loop">
 <tr role="row">

	<td>${punto.rif_tacca }</td>
	<td>${punto.valore_nominale_tratto }</td>
	<td>${punto.valore_nominale_tratto_sec }</td>
	<td>${punto.p1_andata }</td>
	<td>${punto.p1_ritorno }</td>
	<td>${punto.p1_media }</td>
	<td>${punto.p1_diff }</td>
	<td>${punto.p2_andata }</td>
	<td>${punto.p2_ritorno }</td>
	<td>${punto.p2_media }</td>
	<td>${punto.p2_diff }</td>
	<td>${punto.media }</td>
	<td>${punto.errore_cum }</td>
	<td>${punto.media_corr_sec }</td>
	<td>${punto.media_corr_mm }</td>
	<td>${punto.div_dex }</td>
	<td>${punto.corr_boll_mm }</td>
	<td>${punto.corr_boll_sec }</td>

	</tr>
  
	</c:forEach>


 </tbody>
 </table> 
 
  <div class="row">
<div class="col-xs-12">
<div class="col-xs-4"></div>
<div class="col-xs-4"></div>
<div class="col-xs-4">
<label>S. Media</label>
<c:choose>
<c:when test="${lista_pos!=null }">
<input class="form-control" value="${utl:getAverageLivella(lista_pos, null, 0) }" readonly>
</c:when>
<c:otherwise>
<input class="form-control" value="" readonly>
</c:otherwise>
</c:choose>
<label>Dev. Std.</label>
<c:choose>
<c:when test="${lista_pos!=null }">
<input class="form-control" value="${utl:getDevStdLivella(lista_pos, null, 0) }" readonly>
</c:when>
<c:otherwise>
<input class="form-control" value="" readonly>
</c:otherwise>
</c:choose>

</div>
 </div>
 </div>
 


            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>

 </div>



<div class="col-xs-12">
 <div class="box box-danger box-solid" >
<div class="box-header with-border">
	 Riferimenti e incertezza
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

<div class="row">
<div class="col-xs-12">
<div class="col-xs-4">
<label class="pull-left">Campione di Riferimento</label>
</div>
<div class="col-xs-8">
<input type="text" class="form-control" value="${misura_lat.rif_campione.codice }" readonly></div>
</div>
</div><br>

<div class="row">
<div class="col-xs-12">
<div class="col-xs-4">
<label class="pull-left">Campione di Lavoro</label>
</div>
<div class="col-xs-8">
<input type="text" class="form-control" value="${misura_lat.rif_campione_lavoro.codice }" readonly></div>
</div>
</div><br>


<div class="row">
<div class="col-xs-12">
<div class="col-xs-4">
<label class="pull-left">Stato di conservazione e pulizia</label>
</div>
<div class="col-xs-8">
<input type="text" class="form-control" value="${misura_lat.stato }" readonly></div>
</div>
</div><br>

<div class="row">
<div class="col-xs-12">
<div class="col-xs-4">
<label class="pull-left">Presenze di fitte e ammaccature</label>
</div>
<div class="col-xs-8">
<input type="text" class="form-control" value="${misura_lat.ammaccature }" readonly></div>
</div>
</div><br>


<div class="row">
<div class="col-xs-12">
<div class="col-xs-4">
<label class="pull-left">Presenza di Bolla Trasversale</label>
</div>
<div class="col-xs-8">
<input type="text" class="form-control" value="${misura_lat.bolla_trasversale }" readonly></div>
</div>
</div><br>


<div class="row">
<div class="col-xs-12">
<div class="col-xs-4">
<label class="pull-left">Regolazione e sigilli</label>
</div>
<div class="col-xs-8">
<input type="text" class="form-control" value="${misura_lat.regolazione }" readonly></div>
</div>
</div><br>


<div class="row">
<div class="col-xs-12">
<div class="col-xs-4">
<label class="pull-left">Centraggio rispetto all'assse di gravità</label>
</div>
<div class="col-xs-8">
<input type="text" class="form-control" value="${misura_lat.centraggio }" readonly></div>
</div>
</div><br>


<div class="row">
<div class="col-xs-12">
<div class="col-xs-4">
<label class="pull-left">Campo Misura</label>
</div>
<div class="col-xs-8">
<div class="row">
 <div class="col-xs-4"> 
<input type="text" class="form-control" value="${misura_lat.campo_misura }" readonly width="100%"/>
</div>

<label class="pull-left">mm/m</label>
<div class="col-xs-1"></div>
<div class="col-xs-4">
<input type="text" class="form-control" value="${misura_lat.campo_misura_sec }" readonly width="100%"/>
</div>
<label class="pull-left">"</label>
</div>
</div>
</div>
</div><br>


<div class="row">
<div class="col-xs-12">
<div class="col-xs-4">
<label class="pull-left">Sensibilità</label>
</div>
<div class="col-xs-8">
<div class="row">
<div class="col-xs-4">
<input type="text" class="form-control" value="${misura_lat.sensibilita }" readonly width="100%">
</div>

<label class="pull-left">mm/m</label>
</div>
</div>
</div>
</div><br>



<div class="row">
<div class="col-xs-12">
<div class="col-xs-4">
<label class="pull-left">Incertezza associata al riferimento U(Er)</label>
</div>
<div class="col-xs-8">
<div class="row">
<div class="col-xs-4">
<input type="text" class="form-control" value="${misura_lat.incertezza_rif }" readonly width="100%"/>
</div>

<label class="pull-left">mm/m</label>
<div class="col-xs-1"></div>
<div class="col-xs-4">
<input type="text" class="form-control" value="${misura_lat.incertezza_rif_sec }" readonly width="100%"/>
</div>
<label class="pull-left">"</label>
</div>
</div>
</div>
</div><br>


<div class="row">
<div class="col-xs-12">
<div class="col-xs-4">
<label class="pull-left">Incertezza estesa U(Em)</label>
</div>
<div class="col-xs-8">
<div class="row">
<div class="col-xs-4">
<input type="text" class="form-control" value="${misura_lat.incertezza_estesa }" readonly width="100%"/>
</div>

<label class="pull-left">mm/m</label>
<div class="col-xs-1"></div>
<div class="col-xs-4">
<input type="text" class="form-control" value="${misura_lat.incertezza_estesa_sec }" readonly width="100%"/>
</div>
<label class="pull-left">"</label>
</div>
</div>
</div>
</div><br>

<div class="row">
<div class="col-xs-12">
<div class="col-xs-4">
<label class="pull-right">Incertezza da associare al valore medio di una divisione della scala graduata Um</label>
</div>
<div class="col-xs-8">
<div class="row">
<div class="col-xs-4">
<input type="text" class="form-control" value="${misura_lat.incertezza_media }" readonly width="100%"/>
</div>

<label class="pull-left">mm/m</label>

</div>
</div>
</div>
</div><br>


<div class="row">
<div class="col-xs-12">
<div class="col-xs-4">
<label class="pull-left">Note</label>
</div>
<div class="col-xs-8">

<textarea rows="5" style="width:100%" readonly>${misura_lat.note }</textarea>

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
</jsp:attribute>

<jsp:attribute name="extra_js_footer">

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
  
 <script type="text/javascript">
 
 
	var columsDatatables = [];
	 
	$("#tabNeg").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }

	    
	   	});

	var columsDatatables2 = [];
	
	$("#tabPos").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    		columsDatatables2 = state.columns;
	    }
	    
	   	});
   
    $(document).ready(function() {
    	
    	$('.dropdown-toggle').dropdown();
    	
    	
    	
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
		    		
		 		});
			   
			   $('#myModalDettaglioStrumento').on('hidden.bs.modal', function (e) {

		    	 	$('#dettaglioTab').tab('show');
		    	 	$('body').removeClass('noScroll');
		    	 	$(document.body).css('padding-right', '0px');
		    	});
    	
    	
    	
	    $('#tabNeg thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	    	  var title = $('#tabNeg thead th').eq( $(this).index() ).text();
	    	
	    	  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	
	    	} );
    	
	    $('#tabPos thead th').each( function () {
	     	if(columsDatatables2.length==0 || columsDatatables2[$(this).index()]==null ){columsDatatables2.push({search:{search:""}});}
	    	  var title = $('#tabPos thead th').eq( $(this).index() ).text();
	    	
	    	  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="width=100%" type="text"  value="'+columsDatatables2[$(this).index()].search.search+'"/></div>');
	    	
	    	} );
    	
     	tableNeg = $('#tabNeg').DataTable({
    		language: {
    	        	emptyTable : 	"Nessun dato presente nella tabella",
    	        	info	:"Vista da _START_ a _END_ di _TOTAL_ elementi",
    	        	infoEmpty:	"Vista da 0 a 0 di 0 elementi",
    	        	infoFiltered:	"(filtrati da _MAX_ elementi totali)",
    	        	infoPostFix:	"",
    	        infoThousands:	".",
    	        lengthMenu:	"Visualizza _MENU_ elementi",
    	        loadingRecords:	"Caricamento...",
    	        	processing:	"Elaborazione...",
    	        	search:	"Cerca:",
    	        	zeroRecords	:"La ricerca non ha portato alcun risultato.",
    	        	paginate:	{
      	        	first:	"Inizio",
      	        	previous:	"Precedente",
      	        	next:	"Successivo",
      	        last:	"Fine",
    	        	},
    	        aria:	{
      	        	srtAscending:	": attiva per ordinare la colonna in ordine crescente",
      	        sortDescending:	": attiva per ordinare la colonna in ordine decrescente",
    	        }
            },
            pageLength: 100,          
    	      paging: false, 
    	      ordering: true,
    	      info: true, 
    	      searchable: true, 
    	      targets: 0,
    	      responsive: false,
    	      scrollX: true,
    	     // scrollY: "450px",
    	      stateSave: true,
    	      columnDefs: [], 	       

    });
     	
     	
     	
     	
     	tablePos = $('#tabPos').DataTable({
    		language: {
    	        	emptyTable : 	"Nessun dato presente nella tabella",
    	        	info	:"Vista da _START_ a _END_ di _TOTAL_ elementi",
    	        	infoEmpty:	"Vista da 0 a 0 di 0 elementi",
    	        	infoFiltered:	"(filtrati da _MAX_ elementi totali)",
    	        	infoPostFix:	"",
    	        infoThousands:	".",
    	        lengthMenu:	"Visualizza _MENU_ elementi",
    	        loadingRecords:	"Caricamento...",
    	        	processing:	"Elaborazione...",
    	        	search:	"Cerca:",
    	        	zeroRecords	:"La ricerca non ha portato alcun risultato.",
    	        	paginate:	{
      	        	first:	"Inizio",
      	        	previous:	"Precedente",
      	        	next:	"Successivo",
      	        last:	"Fine",
    	        	},
    	        aria:	{
      	        	srtAscending:	": attiva per ordinare la colonna in ordine crescente",
      	        sortDescending:	": attiva per ordinare la colonna in ordine decrescente",
    	        }
            },
            pageLength: 100,          
    	      paging: false, 
    	      ordering: true,
    	      info: true, 
    	      searchable: true, 
    	      targets: 0,
    	      responsive: false,
    	      scrollX: true,
    	     // scrollY: "450px",
    	      stateSave: true,
    	      columnDefs: [], 	       

    });
     	
     	
     	
     	tableNeg.buttons().container().appendTo( '#tableNeg_wrapper .col-sm-6:eq(1)');
 	    $('.inputsearchtable').on('click', function(e){
 	       e.stopPropagation();    
 	    });
 	   tableNeg.columns().eq( 0 ).each( function ( colIdx ) {
  $( 'input', tableNeg.column( colIdx ).header() ).on( 'keyup', function () {
	  tableNeg
          .column( colIdx )
          .search( this.value )
          .draw();
  } );
} ); 
 	  tableNeg.columns.adjust().draw();
	
	
	
	
	tablePos.buttons().container().appendTo( '#tablePos_wrapper .col-sm-6:eq(1)');
	    $('.inputsearchtable').on('click', function(e){
	       e.stopPropagation();    
	    });
tablePos.columns().eq( 0 ).each( function ( colIdx ) {
$( 'input', tablePos.column( colIdx ).header() ).on( 'keyup', function () {
	tablePos
      .column( colIdx )
      .search( this.value )
      .draw();
} );
} ); 
tablePos.columns.adjust().draw();
     	
     	
     	

	});


  </script>
  
</jsp:attribute> 
</t:layout>

