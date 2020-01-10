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
<%@page import="it.portaleSTI.DTO.LatPuntoLivellaElettronicaDTO"%>
<%ArrayList<LatPuntoLivellaElettronicaDTO> lista_punti_R = (ArrayList)session.getAttribute("lista_punti_R"); %>


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



<div class="col-xs-12">
  <div class="box box-danger box-solid" >
<div class="box-header with-border">
	 Dettaglio misura
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
 <div class="row"> 
<div class= "col-xs-12">
<div class= "col-xs-4">
<label>Indicazione Iniziale Campione</label>
<c:choose>
<c:when test="${lista_punti_L!=null && lista_punti_L.size()>0 }">
<input class="form-control" value="${lista_punti_L.get(0).indicazione_iniziale.stripTrailingZeros().toPlainString() }" readonly>
</c:when>
<c:otherwise>
<input class="form-control" value="" readonly>
</c:otherwise>
</c:choose>
</div>

<div class= "col-xs-4">
<label>Indicazione Iniziale Corretta</label>
<c:choose>
<c:when test="${lista_punti_L!=null && lista_punti_L.size()>0 }">
<input class="form-control" value="${lista_punti_L.get(0).indicazione_iniziale_corr.stripTrailingZeros().toPlainString() }" readonly>
</c:when>
<c:otherwise>
<input class="form-control" value="" readonly>
</c:otherwise>
</c:choose>
</div>


<div class= "col-xs-4">
<label>Inc. tipo comp. del camp.</label>
<c:choose>
<c:when test="${lista_punti_L!=null && lista_punti_L.size()>0 }">
<input class="form-control" value="${lista_punti_L.get(0).inclinazione_cmp_campione.stripTrailingZeros().toPlainString() }" readonly>
</c:when>
<c:otherwise>
<input class="form-control" value="" readonly>
</c:otherwise>
</c:choose>
</div>
</div>
</div><br>

 <div class="row"> 
<div class="col-xs-12">
        <div class="nav-tabs-custom">
            <ul id="mainTabs" class="nav nav-tabs">
              <li class="active" id="tab1"><a href="#riferimenti_incertezza" data-toggle="tab" aria-expanded="true"   id="riferimenti_incertezzaTab">Riferimenti & Incertezza</a></li>
              		<li class="" id="tab2"><a href="#prova_lineare" data-toggle="tab" aria-expanded="false"   id="prova_lineareTab">Prova Lineare</a></li>
              		<li class="" id="tab3"><a href="#prova_ripetibilita" data-toggle="tab" aria-expanded="false"   id="prova_ripetibilitaTab">Prova Ripetibilità</a></li>
              		<li class="" id="tab4"><a href="#grafico_scostamenti" data-toggle="tab" aria-expanded="false"   id="grafico_scostamentiTab">Grafico Scostamenti</a></li>
              
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="riferimenti_incertezza">
              
               <div class="row"> 
				<div class="col-xs-12">
				<div class="col-xs-3">
				<div class="form-group row">
        			<label for="campione" class="col-sm-5 control-label">Campione di Riferimento</label>
       						 <div class="col-sm-6">
        	             <input type="text" id="campione" class="form-control" value="${misura.misuraLAT.rif_campione.codice }" readonly/>
   						 </div>
     				</div>
     				<div class="form-group row">
        			<label for="campo_misura" class="col-sm-5 control-label">Campo Misura</label>
       						 <div class="col-sm-6">
        	             <input type="text" id="campo_misura" class="form-control" value="${misura.misuraLAT.campo_misura.stripTrailingZeros().toPlainString() }" readonly/>
   						 </div>"
   						 
     				</div>
     				<div class="form-group row">
        			<label for="sensibilita" class="col-sm-5 control-label">Sensibilità</label>
       						 <div class="col-sm-6">
        	             <input type="text" id="sensibilita" class="form-control" value="${misura.misuraLAT.sensibilita.stripTrailingZeros().toPlainString()  }" readonly/>
   						 </div>"
   						 
     				</div>
     				<div class="form-group row">
        			<label for="incertezza_estesa" class="col-sm-5 control-label">Incertezza Estesa U(Em)</label>
       						 <div class="col-sm-6">
        	             <input type="text" id="incertezza_estesa" class="form-control" value="${misura.misuraLAT.incertezza_estesa.stripTrailingZeros().toPlainString()   }" readonly/>
   						 </div>"
   						
     				</div>
     				
				</div>
					
					
				<div class="col-xs-9">
				
				<table id="tabellaRifInc" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
				 <thead><tr class="active">
				 <th>Punto</th>
				 <th>Valore Nominale</th>
				 <th>Inc. Risoluzione</th>
				 <th>Inc. Ripetibilità</th>
				 <th>Inc. Campione</th>
				 <th>Inc. Stab</th>
				 <th>Inc. Estesa</th>				 
				
				 </tr></thead>
				 
				 <tbody>
				 
				 <c:forEach items="${lista_punti_I}" var="punto" varStatus="loop">
				 
				 <tr role="row" >
				 	
				 	<td>${punto.punto }</td>
				 	<td>${punto.valore_nominale.stripTrailingZeros().toPlainString()}</td>
				 	<td>${punto.inc_ris.stripTrailingZeros()  }</td>
				 	<td>${punto.inc_rip.stripTrailingZeros()  }</td>
				 	<td>${punto.inc_cmp.stripTrailingZeros()  }</td>
				 	<td>${punto.inc_stab.stripTrailingZeros()  }</td>
				 	<td>${punto.inc_est.stripTrailingZeros()  }</td>				
					  	
				</tr>
					
					</c:forEach>
				 
					
				 </tbody>
				 </table> 
				
				
				</div>
				
				</div>	
				<div class="col-xs-12">
				<label>Note:</label><textarea rows="5" class="form-control" readonly>${misura.misuraLAT.note }</textarea>
				</div>			
				</div>


    			</div> 

              <!-- /.tab-pane -->
              <div class="tab-pane table-responsive" id="prova_lineare">
              
              <div class="row">
              <div class="col-xs-12">
              <table id="tabellaLinearita" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
				 <thead><tr class="active">
				 <th>Punto</th>
				 <th>Valore Nominale</th>
				 <th>[A] Taratura</th>
				 <th>[A] Campione</th>
				 <th>[R] Taratura</th>
				 <th>[R] Campione</th>
				 <th>[A] Sc. Campione</th>
				 <th>[A] Campione Corretto</th>
				 <th>[R] Sc. Campione</th>
				 <th>[R] Campione Corretto</th>
				 <th>Scost [A]</th>
				 <th>Scost [R]</th>
				 <th>Scost Medio</th>
				 <th>Scost Offset</th>
				 			 
				
				 </tr></thead>
				 
				 <tbody>
				 
				 <c:forEach items="${lista_punti_L}" var="punto" varStatus="loop">
				 
				 <tr role="row" id="riga_${loop.index }">
				 	
				 	<td>${punto.punto }</td>
				 	<td>${punto.valore_nominale.stripTrailingZeros().toPlainString()}</td>
				 	<td>${punto.valore_andata_taratura.stripTrailingZeros().toPlainString()  }</td>
				 	<td>${punto.valore_andata_campione.stripTrailingZeros().toPlainString()  }</td>
				 	<td>${punto.valore_ritorno_taratura.stripTrailingZeros().toPlainString()  }</td>
				 	<td>${punto.valore_ritorno_campione.stripTrailingZeros().toPlainString()  }</td>
				 	<td>${punto.andata_scostamento_campione.stripTrailingZeros().toPlainString()  }</td>				
				 	<td>${punto.andata_correzione_campione.stripTrailingZeros().toPlainString()  }</td>
				 	<td>${punto.ritorno_scostamento_campione.stripTrailingZeros().toPlainString()  }</td>
				 	<td>${punto.ritorno_correzione_campione.stripTrailingZeros().toPlainString()  }</td>
				 	<td>${punto.scostamentoA.stripTrailingZeros().toPlainString()  }</td>
				 	<td>${punto.scostamentoB.stripTrailingZeros().toPlainString()  }</td>
				 	<td>${punto.scostamentoMed.stripTrailingZeros().toPlainString()  }</td>
				 	<td>${punto.scostamentoOff.stripTrailingZeros().toPlainString()  }</td>
					  	
				</tr>
					
					</c:forEach>
				 
					
				 </tbody>
				 </table> 
              
              </div>
              </div>

			 </div>
			 
			 
			 <div class="tab-pane table-responsive" id="prova_ripetibilita">
			 
			  <div class="row">
              <div class="col-xs-12">
              
               <table id="tabellaRipetibilita" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
				 <thead><tr class="active">
				 <th>Punto</th>
				 <th>Valore Nominale</th>	
				 
				 <c:forEach items="${lista_punti_R }" var="lista_punti" varStatus="loop">
				 <th>[A - ${loop.index +1}] Taratura</th>
				 <th>[A - ${loop.index +1}] Campione</th>
				 <th>[R - ${loop.index +1}] Taratura</th>
				 <th>[R - ${loop.index +1}] Campione</th>
				 </c:forEach>		 				
				 <th>Scarto Tipo</th>
				 			 
				 </tr></thead>
				 
				 <tbody>
				 				 
				 <c:forEach items="${lista_punti_R.get(0)}" var="punto" varStatus="loop">
				 <tr role="row" id="row_${loop.index }">				 	
				    <td>${punto.punto }</td>
				 	<td>${punto.valore_nominale.stripTrailingZeros().toPlainString()}</td>
						<c:forEach items="${lista_punti_R}" var="lista_punti_colonna" >
				 			<td>${lista_punti_colonna.get(loop.index).valore_andata_taratura.stripTrailingZeros().toPlainString()}</td>
				 			<td>${lista_punti_colonna.get(loop.index).valore_andata_campione.stripTrailingZeros().toPlainString()}</td>
				 			<td>${lista_punti_colonna.get(loop.index).valore_ritorno_taratura.stripTrailingZeros().toPlainString()}</td>
				 			<td>${lista_punti_colonna.get(loop.index).valore_ritorno_campione.stripTrailingZeros().toPlainString()}</td>
				 		</c:forEach>
				 	<td>${punto.scarto_tipo.stripTrailingZeros().toPlainString()}</td>
				</tr>
					</c:forEach>
					
					
				 </tbody>
				 </table> 
              
              </div>
              </div>
			 
			 
			 </div>

			 <div class="tab-pane table-responsive" id="grafico_scostamenti">
			 
			 	 <div id="grafico" class="chart2" >

			       <canvas id="chart_scostamenti" height="115"></canvas>
			    </div>
			 
			 </div>


              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>

</div>
</div> 


</div>
</div>
</div>

<br><br>



       
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
 <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.js"></script>
  <script type="text/javascript" src="js/customCharts.js"></script>  
 <script type="text/javascript">

    $(document).ready(function() {
    	    	
    	creaGrafico();
    	var numero_prove = "${lista_punti_R.size()}";
    	
    	
    	$('#tabellaRipetibilita tbody tr').each(function(item){
    		for(var i=0;i<(numero_prove*4);i++){
    			if(i<4){    				
    				$('#row_'+item).find("td").eq(2+i).css("background-color","#F6EC83");
    			}else if(i>=4 && i<8){
    				$('#row_'+item).find("td").eq(2+i).css("background-color","#CEF683");
    			}else if(i>=8 && i<12){
    				$('#row_'+item).find("td").eq(2+i).css("background-color","#A7F2EB");
    			}else if(i>=12 && i<16){
    				$('#row_'+item).find("td").eq(2+i).css("background-color","#FFB4B4");
    			}else if(i>=16 && i<20){
    				$('#row_'+item).find("td").eq(2+i).css("background-color","#E8E8E8");
    			}    			
    		}
    		
    	});
    	
    	$('#tabellaLinearita tbody tr').each(function(item){
    		for(var i=0;i<9;i++){
    			if(i<5){    				
    				$('#riga_'+item).find("td").eq(1+i).css("background-color","#F6EB39");
    			}else if(i>=5 && i<7){
    				$('#riga_'+item).find("td").eq(1+i).css("background-color","#F1311E");
    			}else if(i>=7 && i<9){
    				$('#riga_'+item).find("td").eq(1+i).css("background-color","#1EABF1");
    			} 			
    		}
    		
    	});
    	
    	
    	$('#tabellaRipetibilita').DataTable({
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
         pageLength: 25,
    	      paging: false,                            
    	      ordering: true,
    	      info: true,         
    	      searchable: true, 
    	      targets: 0,
    	      responsive: false,
    	     // scrollX: true,    	      
    	      stateSave: true,

   
    	    });
    	

    $('#tabellaLinearita').DataTable({
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
         pageLength: 25,
    	      paging: false,                            
    	      ordering: true,
    	      info: true,         
    	      searchable: true, 
    	      targets: 0,
    	      responsive: false,
    	     // scrollX: true,    	      
    	      stateSave: true,

   
    	    });
    
    
    $('#tabellaRifInc').DataTable({
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
     pageLength: 25,
	      paging: false,                            
	      ordering: true,
	      info: true,         
	      searchable: true, 
	      targets: 0,
	      responsive: false,
	     // scrollX: true,    	      
	      stateSave: true,


	    });


    	
    	
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
    	
  
     	
     	

	});

    function creaGrafico(){

    	var dati_grafico = JSON.parse('${dati_grafico}');
    	
    	var scostA = dati_grafico.scostA;
    	var scostB = dati_grafico.scostB;
    	var scostM = dati_grafico.scostM;
    	
    	var valori_nominali = dati_grafico.valori_nominali;
    	
    	var ctx = document.getElementById("chart_scostamenti").getContext('2d');
    	var myChart = new Chart(ctx, {
    	    type: 'line',
    	    responsive:false,
    	    maintainAspectRatio: false,
    	    data: {
    	        labels: valori_nominali,
    	        datasets: [{
    	            label: 'Lettura Andata',
    	            data: scostA,    
    	            fill:false,   
    	            backgroundColor: [
		                'rgba(38,87,252,1)'
		            ], 
		            borderColor: [
		                'rgba(38,87,252,1)'
		            ],
    	          
    	            borderWidth: 1
    	        },
	    	     {
    	        	label: 'Lettura Ritorno',
		            data: scostB,	
		            fill:false,		  
		            backgroundColor: [
    	            	'rgba(248,83,230,1)'
		            ], 
    	            borderColor: [
    	                'rgba(248,83,230,1)'
    	            ],  
		            borderWidth: 1
	    	        
    	        },
	    	     {
    	        	label: 'Media',
		            data: scostM,	
		            fill:false,
		            backgroundColor: [
		            	 'rgba(205, 225, 34, 1)'
		            ], 
		            borderColor: [
		                'rgba(205, 225, 34, 1)'
		            ],  
		            borderWidth: 1
	    	        
    	        }
    	        ]
    	    },
    	    
    	    options: {    	    	
    	        scales: {
    	        	xAxes: [{
                        
                        ticks: {
                            //beginAtZero:this.beginzero,
                        	beginAtZero:true
                        }
                    }],
    	            yAxes: [{
    	                ticks: {
    	                    beginAtZero:true
    	                }
    	            }]
    	        }
    	    }
    	});

    }
    

  </script>
  
</jsp:attribute> 
</t:layout>

