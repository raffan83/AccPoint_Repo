<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
        Dettaglio Intervento
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
            <c:if test="${intervento.statoIntervento.id == 1 && userObj.checkPermesso('NUOVO_INTERVENTO_METROLOGIA')}">
			<div class="row">
			<div class="col-xs-12">
				<a class="btn btn-primary pull-right" onClick="modalNuovaMisura()">Nuova Misura</a>
			</div>
			</div>
		</c:if><br>
            
            <div class="row">
<div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati Intervento
	<div class="box-tools pull-right">

		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${intervento.id}</a>
                </li>
                <li class="list-group-item">
                  <b>ID Commessa</b> <a class="pull-right">${intervento.idCommessa}</a>
                </li>
                <li class="list-group-item">
                  <b>Presso</b> <a class="pull-right">
<c:choose>
  <c:when test="${intervento.pressoDestinatario == 0}">
		<span class="label label-success">IN SEDE</span>
  </c:when>
  <c:when test="${intervento.pressoDestinatario == 1}">
		<span class="label label-info">PRESSO CLIENTE</span>
  </c:when>
    <c:when test="${intervento.pressoDestinatario == 2}">
		<span class="label label-warning">MISTO CLIENTE - SEDE</span>
  </c:when>
  <c:otherwise>
    <span class="label label-info">-</span>
  </c:otherwise>
</c:choose> 
   
		</a>
                </li>
                 <li class="list-group-item">
                  <b>Cliente</b> 
                  <a id="nome_sede" class="pull-right" style="padding-right:7px">${intervento.nome_cliente } </a>
                </li>
                <li class="list-group-item">
                  <b>Sede</b> <a class="btn btn-warning pull-right btn-xs" title="Click per modificare la sede" onClick="inserisciSede('${intervento.id}')"><i class="fa fa-edit"></i></a>
                  <a id="nome_sede" class="pull-right" style="padding-right:7px">${intervento.nome_sede } </a>
                </li>
                <li class="list-group-item">
                  <b>Data Creazione</b> <a class="pull-right">
	
			<c:if test="${not empty intervento.dataCreazione}">
   				<fmt:formatDate pattern="dd/MM/yyyy" value="${intervento.dataCreazione}" />
			</c:if>
		</a>
                </li>
                <li class="list-group-item">
                  <b>Stato</b> <div class="pull-right">
                  
					<c:if test="${intervento.statoIntervento.id == 0}">
						<a href="#" class="customTooltip" title="Click per chiudere l'Intervento"  onClick="chiudiIntervento('${utl:encryptData(intervento.id)}',0,0)" id="statoa_${intervento.id}"> <span class="label label-info">${intervento.statoIntervento.descrizione}</span></a>
						
					</c:if>
					
					<c:if test="${intervento.statoIntervento.id == 1}">
						<a href="#" class="customTooltip" title="Click per chiudere l'Intervento"  onClick="chiudiIntervento('${utl:encryptData(intervento.id)}',0,0)" id="statoa_${intervento.id}"> <span class="label label-success">${intervento.statoIntervento.descrizione}</span></a>
						
					</c:if>
					
					<c:if test="${intervento.statoIntervento.id == 2}">
					 <a href="#" class="customTooltip" title="Click per aprire l'Intervento"  onClick="apriIntervento('${utl:encryptData(intervento.id)}',0,0)" id="statoa_${intervento.id}"> <span class="label label-warning">${intervento.statoIntervento.descrizione}</span></a> 
					
					</c:if>
    
				</div>
                </li>
                <li class="list-group-item">
                  <b>Responsabile</b> <a class="pull-right">${intervento.user.nominativo}</a>
                </li>
        </ul>
        
   
</div>
</div>
</div>
</div>
      
      <c:if test="${userCliente == '0'}">
      
      <div class="row">
<div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati Pacchetto
	<div class="box-tools pull-right">

		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
               
                <li class="list-group-item">
                  <b>Nome pack</b>  

    <a class="pull-right">${intervento.nomePack}</a>
		 
                </li>
               <li class="list-group-item">
                  <b>N° Strumenti Genenerati</b> <a class="pull-right">${intervento.nStrumentiGenerati}</a>
                </li>

                <li class="list-group-item">
                  <b>N° Strumenti Misurati</b> <a class="pull-right">
						<a href="#" onClick="callAction('strumentiMisurati.do?action=lt&id=${utl:encryptData(intervento.id)}')" class="pull-right customTooltip customlink" title="Click per aprire la lista delle Misure dell'Intervento ${intervento.id}"> ${intervento.nStrumentiMisurati}</a>

				</a>
                </li>
                <li class="list-group-item">
                  <b>N° Strumenti Nuovi Inseriti</b> <a class="pull-right">${intervento.nStrumentiNuovi}</a>
                </li>
               
        <li class="list-group-item">
        <div class="row" id="boxPacchetti">
        <c:if test="${intervento.statoIntervento.id != 2}">
				 <div class="col-xs-12">
 				 <h4>Gestione Pack</h4>
 				 </div>
	        <div class="col-xs-4">
				<button class="btn btn-default pull-left" onClick="scaricaPacchetto('${intervento.nomePack}')"><i class="glyphicon glyphicon-download"></i> Download Pacchetto</button>&nbsp;
			    <button class="btn btn-info customTooltip " title="Scarica Pacchetto LAT" onClick="scaricaPacchettoLAT('${intervento.nomePack}')"><i class="fa fa-cog"></i> </button>
			</div>
			<div class="col-xs-4">
			    <span class="btn btn-primary fileinput-button pull-right">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un file...</span>
		        <!-- The file input field used as target for the file upload widget -->
		        		<input accept="application/x-sqlite3,.db"  id="fileupload" type="file" name="files">
		   	 </span>
		    </div>
		    <div class="col-xs-4">
		        <div id="progress" class="progress">
		        	<div class="progress-bar progress-bar-success"></div>
		    	</div>
		    <!-- The container for the uploaded files -->
		    <div id="files" class="files"></div>
	    </div>
   		</c:if>
    </div>
     
        </li>
        <c:if test="${intervento.nStrumentiMisurati > 0 || intervento.nStrumentiNuovi > 0}">
 				   <li class="list-group-item">
 				   <h4>Download Schede</h4>
 				<button class="btn btn-default " onClick="scaricaSchedaConsegnaModal()"><i class="glyphicon glyphicon-download"></i> Download Scheda Consegna</button>
 				<button class="btn btn-info customTooltip " title="Click per aprire le schede di consegna" onClick="showSchedeConsegna('${utl:encryptData(intervento.id)}')"><i class="fa fa-file-text-o"></i> </button>
   				</li>
 				   <li class="list-group-item">
 				<button class="btn btn-default " onClick="scaricaListaCampioni('${intervento.id}')"><i class="glyphicon glyphicon-download"></i> Download Lista Campioni</button>
 				

       </li>
       				
 				 
       
           
       
       
       
      </c:if>
     </ul>
    </div>
	</div>
</div>
</div>
      
            
            
            
              <div class="row">
        <div class="col-xs-12">
 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Log Update Pacchetto
	<div class="box-tools pull-right">

		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

              <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
  <th>ID</th>
 <th>Data Caricamento</th>
 <th>Nome Pack</th>

 <th>Stato</th>
 <th>N° Strumenti Nuovi</th>
 <th>N° Strumenti Misurati</th>
 <td>Responsabile</td>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${intervento.listaInterventoDatiDTO}" var="pack">
 
 	<tr role="row" id="${pack.id}">
<td>${pack.id}</td>
		<td>
			<c:if test="${not empty pack.dataCreazione}">
   				<fmt:formatDate pattern="dd/MM/yyyy"  value="${pack.dataCreazione}" />
			</c:if>
		</td>
		<td>
		
			<c:if test="${pack.stato.id == 3}">
				<a href="#" onClick="scaricaPacchettoUploaded('${pack.nomePack}')">${pack.nomePack}</a>
  			</c:if>
  			<c:if test="${pack.stato.id != 3}">
				${pack.nomePack}
  			</c:if>
		</td>
		
		<td>
		<c:choose>
  <c:when test="${pack.stato.id == 1}">
		<span class="label label-success">${pack.stato.descrizione}</span>
  </c:when>
 <c:when test="${pack.stato.id == 2}">
		<span class="label label-info">${pack.stato.descrizione}</span>
  </c:when>
  <c:when test="${pack.stato.id == 3}">
		<span class="label label-danger">${pack.stato.descrizione}</span>
  </c:when>
  <c:otherwise>
    <span class="label label-info">-</span>
  </c:otherwise>
</c:choose> 
			 
		</td>
		<td>${pack.numStrNuovi}</td>
		<td><a href="#" class="customTooltip customlink" title="Click per aprire la lista delle Misure del pacchetto" onClick="callAction('strumentiMisurati.do?action=li&id=${utl:encryptData(pack.id)}')">${pack.numStrMis}</a></td>
		<td>${pack.utente.nominativo}</td>
	</tr>
 
	</c:forEach>
 </tbody>
 </table>  
 </div>
</div>  
</div>
</div>
</c:if>

  <div class="row">
        <div class="col-xs-12">
        <c:if test="${userCliente != '0'}">
		 <div class="box box-danger box-solid">
		<div class="box-header with-border">
			 Grafici
			<div class="box-tools pull-right">
		
				<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>
		</c:if>
		
		<c:if test="${userCliente == '0'}">
		 <div class="box box-danger box-solid collapsed-box">
		<div class="box-header with-border">
			 Grafici
			<div class="box-tools pull-right">
				<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-plus"></i></button>
		</c:if>
			</div>
		</div>
		<div class="box-body">
			<div id="grafici">
			<div class="row">
				<div class="col-xs-12 grafico1">
					<canvas id="grafico1"></canvas>
				</div>
				<div class="col-xs-12 grafico2" >
					<canvas id="grafico2"></canvas>
				</div>
				<div class="col-xs-12 grafico3">
					<canvas id="grafico3"></canvas>
				</div>
				<div class="col-xs-12 grafico4">
					<canvas id="grafico4"></canvas>
				</div>
				<div class="col-xs-12 grafico5">
					<canvas id="grafico5"></canvas>
				</div>
				<div class="col-xs-12 grafico6">
					<canvas id="grafico6"></canvas>
				</div>
			</div>
		
		</div>
		
		 </div>
		</div>
		</div>  
		</div>
		</div>
          </div>







  <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Messaggio</h4>
      </div>
       <div class="modal-body">
			<div id="modalErrorDiv">
			
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer" id="myModalFooter">
 
        <button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
      </div>
    </div>
  </div>
</div>

<form id="formNuovaMisura" name="formNuovaMisura">
  <div id="modalNuovaMisura" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Seleziona Tipo Misura</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-xs-12">
       <select class="form-control select2" id="lat_master" data-placeholder="Seleziona Lat Master..." name="lat_master" style="width:100%" required>
       <option value=""></option>
       <c:forEach items="${lista_lat_master }" var="lat_master">
       <option value="${lat_master.id }">${lat_master.descrizione}</option>
       </c:forEach>
       </select>
       </div>
       </div><br>
       <div class="row">
       <div class="col-xs-4">
        <label>Numero Certificato:</label>
       </div>
       <div class="col-xs-8">
       <input type="text" class="form-control" id="nCertificato" name="nCertificato" required>
       </div>
       </div><br>
       <div class="row">
       <div class="col-xs-4">
       <a class="btn btn-primary" onClick="selezionaStrumentoModal()">Seleziona Strumento...</a>
       
       </div>
       <div class="col-xs-8">
		 <label id="label_strumento"></label>
		 
		 </div>
       </div><br>
       <div class="row">
       <!-- <div class="col-xs-12"> -->
       <div class="col-xs-4">
			<span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Carica Excel...</span>
				<input accept=".xls,.xlsx"  id="fileupload_excel" name="fileupload_excel" type="file" required>
		       
		   	 </span>
		   	</div> 
		 <div class="col-xs-8">
		 <label id="label_excel"></label>
		 </div>
		<!-- </div>  -->
		</div><br>
		
		<div class="row">
      <!--  <div class="col-xs-12"> -->
       <div class="col-xs-4">
		   	 <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Carica Certificato...</span>
				<input accept=".pdf,.PDF"  id="fileupload_certificato" name="fileupload_certificato" type="file"  required>
		       
		   	 </span>
   </div> 
		 <div class="col-xs-8">
		 <label id="label_certificato"></label>
		 </div>
		</div> 
		
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer" >
 		<input type="hidden" id="id_intervento" name="id_intervento" value="${intervento.id }">
 		<input type="hidden" readonly id="id_strumento" name="id_strumento" >
 		
        <button  class="btn btn-primary" type="submit">Salva</button>
      </div>
    </div>
  </div>
</div>
</form>

   <div id="modalStrumenti" class="modal fade " role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">SelezionaStrumento</h4>
      </div>
       <div class="modal-body">
       <div id="strumenti_content">
       </div>
       
        

  </div>
  		
  		
      <div class="modal-footer">
	<a  class="btn btn-primary" onClick="selezionaStrumento()">Seleziona</a>
       
      </div>
    </div>
  </div>
 </div>

   <div id="myModalCambiaSede" class="modal fade " role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci il nome della sede</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       
        <div class="form-inline" align="center"> 
      <input style="width:80%"   type="text" class="form-control"   id="nome_sede_new" name="nome_sede_new" value="${intervento.nome_sede}"/>
      <button id="nome_sede_button" class="btn btn-default" style="padding-left:17px" >Salva</button>
	 
 </div> 

  </div>
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

       
      </div>
    </div>
  </div>
</div>



  <div id="modalListaDuplicati" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" data-keyboard="false" data-backdrop="static" >
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">

        <h4 class="modal-title" id="myModalLabel">Lista Duplicati</h4>
      </div>
       <div class="modal-body">
        		<h4 class="modal-title" id="myModalLabel">Selezionare le misure da sovrascrivere</h4>
			<div id="listaDuplicati">
			<table id="tabLD" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">

	
			 </table>  
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">


        <button type="button" class="btn btn-danger"onclick="saveDuplicatiFromModal()"  >Salva</button>
      </div>
    </div>
  </div>
</div>


   <div id="myModalDownloadSchedaConsegna" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Scheda Consegna</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="myModalDownloadSchedaConsegnaContent">
 <form name="scaricaSchedaConsegnaForm" method="post" id="scaricaSchedaConsegnaForm" action="#">
        <div class="form-group">
		  <label for="notaConsegna">Consegna di:</label>
		  <textarea class="form-control" rows="5" name="notaConsegna" id="notaConsegna">${defaultNotaConsegna}</textarea>
		</div>
		
		<div class="form-group">
		  <label for="notaConsegna">Cortese Attenzione di:</label>
		  <input class="form-control" id="corteseAttenzione" name="corteseAttenzione" />
		</div>
		
      <fieldset class="form-group">
		  <label for="gridRadios">Stato Intervento:</label>
         <div class="form-check">
          <label class="form-check-label">
            <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios1" value="0" checked="checked">
            CONSEGNA DEFINITIVA
           </label>
        </div>
        <div class="form-check">
          <label class="form-check-label">
            <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios2" value="1">
            STATO AVANZAMENTO
          </label>

      </div>
    </fieldset>	     
</form>   
  		 </div>
      
    </div>
     <div class="modal-footer">

     <button class="btn btn-default pull-left" onClick="scaricaSchedaConsegna('${intervento.id}')"><i class="glyphicon glyphicon-download"></i> Download Scheda Consegna</button>
   
    	
    </div>
  </div>
    </div>

</div>
  

     <div id="errorMsg"><!-- Place at bottom of page --></div> 
  

</section>
   
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">


</jsp:attribute>

<jsp:attribute name="extra_js_footer">


<script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>
<script src="plugins/fileSaver/FileSaver.min.js"></script>
 <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.js"></script>
  <script type="text/javascript" src="js/customCharts.js"></script>
 

 <script type="text/javascript">
 
 
 function modalNuovaMisura(){
	 $('#modalNuovaMisura').modal();
 }
 
 $('#fileupload_certificato').change(function(){
	$('#label_certificato').html($(this).val().split("\\")[2]);
	 
 });
 
 
 $('#fileupload_excel').change(function(){
		$('#label_excel').html($(this).val().split("\\")[2]);
		 
	 });
 

 $('#formNuovaMisura').on('submit',function(e){
	    e.preventDefault();
	    if($('#id_strumento').val()!=null && $('#id_strumento').val()!=''){
	    	submitNuovaMisura();
	    }else{
	    	  $('#myModalErrorContent').html("Attenzione! Nessuno strumento selezionato!");
 			  	$('#myModalError').removeClass();
 				$('#myModalError').addClass("modal modal-danger");	 
 				$('#myModalError').modal('show');
	    }
	});    
 
 
 function selezionaStrumentoModal(){
	 
	 dataString="action=lista_strumenti_campione&id_cliente=${intervento.id_cliente}&id_sede=${intervento.idSede}";
	 
	 exploreModal("listaStrumentiSedeNew.do",dataString,"#strumenti_content")
	 $('#modalStrumenti').modal();
 }
 
 function selezionaStrumento(){
	 $('#id_strumento').val($('#selected').val());
	 $('#modalStrumenti').modal('hide');
	 console.log( $('#id_strumento').val());
	 $('#label_strumento').html("ID Strumento: "+$('#selected').val());
 }
 
 function inserisciSede(id_intervento){
	 
	 $("#myModalCambiaSede").modal();
 }
 
 $("#nome_sede_button").on('click', function(){
	 
	 var nome_sede = $("#nome_sede_new").val();
	 var id_intervento = '${intervento.id}';
	inserisciNuovaSede(nome_sede, id_intervento);	
	 
 })
 
 
 

 
	var statoStrumentiJson = ${statoStrumentiJson};
	var tipoStrumentiJson = ${tipoStrumentiJson};
	var denominazioneStrumentiJson = ${denominazioneStrumentiJson};
	var freqStrumentiJson = ${freqStrumentiJson};
	var repartoStrumentiJson = ${repartoStrumentiJson};
	var utilizzatoreStrumentiJson = ${utilizzatoreStrumentiJson};
 
	var userCliente = ${userCliente};
	
	var myChart1 = null;
	var myChart2 = null;
	var myChart3 = null;
	var myChart4 = null;
	var myChart5 = null;
	var myChart6 = null;
	
	
	var columsDatatables = [];
	 
	$("#tabPM").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    
	    $('#tabPM thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	        var title = $('#tabPM thead th').eq( $(this).index() ).text();
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    } );

	} );
	
	
	
    $(document).ready(function() { 
    	
    	
    	$('.select2').select2();
    	
    
    	
    	if(userCliente == "0"){
	    	$('#fileupload').fileupload({
	            url: "caricaPacchetto.do",
	            dataType: 'json',
	            maxNumberOfFiles : 10,
	            singleFileUploads: false,
	            getNumberOfFiles: function () {
	                return this.filesContainer.children()
	                    .not('.processing').length;
	            },
	            start: function(e){
	            	pleaseWaitDiv = $('#pleaseWaitDialog');
	    			pleaseWaitDiv.modal();
	            },
	            add: function(e, data) {
	                var uploadErrors = [];
	                var acceptFileTypes = /(\.|\/)(db)$/i;
	                if(data.originalFiles[0]['name'].length && !acceptFileTypes.test(data.originalFiles[0]['name'])) {
	                    uploadErrors.push('Tipo File non accettato. ');
	                }
	                if(data.originalFiles[0]['size'] > 10000000) {
	                    uploadErrors.push('File troppo grande, dimensione massima 10mb');
	                }
	                if(uploadErrors.length > 0) {
	                	//$('#files').html(uploadErrors.join("\n"));
	                	$('#myModalErrorContent').html(uploadErrors.join("\n"));
						$('#myModalError').removeClass();
						$('#myModalError').addClass("modal modal-danger");
					//	$('#report_button').show();
	      			//	$('#visualizza_report').show();
						$('#myModalError').modal('show');

	                } else {
	                    data.submit();
	                }
	        	},
	            done: function (e, data) {
					
	            	pleaseWaitDiv.modal('hide');
	            	
	            	if(data.result.success)
					{
						createLDTable(data);
	
						//$('#files').html("SALVATAGGIO EFFETTUATO");
					
					}else{
						
						$('#myModalErrorContent').html(data.result.messaggio);
						$('#myModalError').removeClass();
						$('#myModalError').addClass("modal modal-danger");
						$('#report_button').show();
	      				$('#visualizza_report').show();
						$('#myModalError').modal('show');
						
						
						$('#progress .progress-bar').css(
			                    'width',
			                    '0%'
			                );
		               // $('#files').html("ERRORE SALVATAGGIO");
					}
	
	
	            },
	            fail: function (e, data) {
	            	pleaseWaitDiv.modal('hide');
	            	$('#files').html("");
	            	var errorMsg = "";
	                $.each(data.messages, function (index, error) {
	
	                	errorMsg = errorMsg + '<p>ERRORE UPLOAD FILE: ' + error + '</p>';
	           
	
	                });

	                $('#myModalErrorContent').html(errorMsg);
	                
					$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					$('#report_button').show();
      				$('#visualizza_report').show();
					$('#myModalError').modal('show');

					$('#progress .progress-bar').css(
		                    'width',
		                    '0%'
		                );
	            },
	            progressall: function (e, data) {
	                var progress = parseInt(data.loaded / data.total * 100, 10);
	                $('#progress .progress-bar').css(
	                    'width',
	                    progress + '%'
	                );
	
	            }
	        }).prop('disabled', !$.support.fileInput)
	            .parent().addClass($.support.fileInput ? undefined : 'disabled');
	    	
	    	
	    	table = $('#tabPM').DataTable({
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
	    	      paging: true, 
	    	      ordering: true,
	    	      info: true, 
	    	      searchable: false, 
	    	      targets: 0,
	    	      responsive: true,
	    	      scrollX: false,
	    	      stateSave: true,
	    	      order:[[0,'desc']],
	    	      columnDefs: [
							   { responsivePriority: 1, targets: 0 },
	    	                   { responsivePriority: 3, targets: 2 },
	    	                   { width: "50px", targets: 0 },
	    	                   { width: "100px", targets: 1 },
	    	                   { width: "90px", targets: 3 },
	    	               ],
	             
	    	               buttons: [ {
	    	                   extend: 'copy',
	    	                   text: 'Copia',
	    	                   /* exportOptions: {
		                       modifier: {
		                           page: 'current'
		                       }
		                   } */
	    	               },{
	    	                   extend: 'excel',
	    	                   text: 'Esporta Excel',
	    	                   /* exportOptions: {
	    	                       modifier: {
	    	                           page: 'current'
	    	                       }
	    	                   } */
	    	               },
	    	               {
	    	                   extend: 'colvis',
	    	                   text: 'Nascondi Colonne'
	    	                   
	    	               }
	    	                         
	    	                          ]
	    	    	
	    	      
	    	    });
	    	table.buttons().container()
	        .appendTo( '#tabPM_wrapper .col-sm-6:eq(1)' );
	     	   
	 			/* $('#tabPM').on( 'dblclick','tr', function () {
	
	       		var id = $(this).attr('id');
	       		
	       		var row = table.row('#'+id);
	       		data = row.data();
	           
	     	    if(data){
	     	    	 row.child.hide();
	             	$( "#myModal" ).modal();
	     	    }
	       	}); */
	        
	       	    
	       	 $('#myModal').on('hidden.bs.modal', function (e) {
	
	       	});
	       	 $('#modalListaDuplicati').on('hidden.bs.modal', function (e) {
	       	  	
	       	});
	       	 $('#myModalError').on('hidden.bs.modal', function (e) {
	       		if($('#myModalError').hasClass('modal-success')){
	     			callAction('gestioneInterventoDati.do?idIntervento=${utl:encryptData(intervento.id)}');
	     		 }
	        	});
	       	
	   
	    $('.inputsearchtable').on('click', function(e){
	        e.stopPropagation();    
	     });
	    // DataTable
	  	table = $('#tabPM').DataTable();
	    // Apply the search
	    table.columns().eq( 0 ).each( function ( colIdx ) {
	        $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
	            table
	                .column( colIdx )
	                .search( this.value )
	                .draw();
	        } );
	    } ); 
	    	table.columns.adjust().draw();
	    	$('#tabPM').on( 'page.dt', function () {
				$('.customTooltip').tooltipster({
			        theme: 'tooltipster-light'
			    });
			  } );
	 	    
    	}
    	 
    	//Grafici


    	/* GRAFICO 1*/

    	numberBack1 = Math.ceil(Object.keys(statoStrumentiJson).length/6);
    	if(numberBack1>0){
    		grafico1 = {};
    		grafico1.labels = [];
    		 
    		dataset1 = {};
    		dataset1.data = [];
    		dataset1.label = "# Strumenti in Servizio";
    		
    		
    		
    		
    		
    			dataset1.backgroundColor = [];
    			dataset1.borderColor = [];
    		for (i = 0; i < numberBack1; i++) {
    			newArr = [
    		         'rgba(255, 99, 132, 0.2)',
    		         'rgba(54, 162, 235, 0.2)',
    		         'rgba(255, 206, 86, 0.2)',
    		         'rgba(75, 192, 192, 0.2)',
    		         'rgba(153, 102, 255, 0.2)',
    		         'rgba(255, 159, 64, 0.2)'
    		     ];
    			
    			newArrB = [
    		         'rgba(255,99,132,1)',
    		         'rgba(54, 162, 235, 1)',
    		         'rgba(255, 206, 86, 1)',
    		         'rgba(75, 192, 192, 1)',
    		         'rgba(153, 102, 255, 1)',
    		         'rgba(255, 159, 64, 1)'
    		     ];
    			
    			dataset1.backgroundColor = dataset1.backgroundColor.concat(newArr);
    			dataset1.borderColor = dataset1.borderColor.concat(newArrB);
    		}
    		dataset1.borderWidth = 1;
    		var itemHeight1 = 200;
    		var total1 = 0;
    		$.each(statoStrumentiJson, function(i,val){
    			grafico1.labels.push(i);
    			dataset1.data.push(val);
    			itemHeight1 += 12;
    			total1 += val;
    		});
    		$(".grafico1").height(itemHeight1);
    		 grafico1.datasets = [dataset1];
    		 
    		 var ctx1 = document.getElementById("grafico1").getContext("2d");;
    		
    		 if(myChart1!= null){

    			 myChart1.destroy();
    		 }
    		 var config1 = {
        		     data: grafico1,
        		     options: {
        		    	 responsive: true, 
        		    	 maintainAspectRatio: false,
        		         
        		     }
        		 };
 			if(Object.keys(statoStrumentiJson).length<5){
 				config1.type = "pieLabels";
				$('#grafico1').addClass("col-lg-6");

 			}else{
 				config1.type = "bar";	
 				config1.options.tooltips = {
 			    		 callbacks: {
 			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
 			    		      // data : the chart data item containing all of the datasets
 			    		      label: function(tooltipItem, data) {
 			    		    	  var value = data.datasets[0].data[tooltipItem.index];
 			                      var label = data.labels[tooltipItem.index];
 			                      var percentage =  value / total1 * 100;
 			                     
 			                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

 			    		      }
 			    		    }
 	  		 		 };
 				$('#grafico1').removeClass("col-lg-6");
 			}
    		  myChart1 = new Chart(ctx1, config1);
    	 
    	}else{
    		if(myChart1!= null){
    		 	myChart1.destroy();
    		 }
    	}
    	 /* GRAFICO 2*/
    	 
    	 numberBack2 = Math.ceil(Object.keys(tipoStrumentiJson).length/6);
    	 if(numberBack2>0){
    		 
    	 
    		grafico2 = {};
    		grafico2.labels = [];
    		 
    		dataset2 = {};
    		dataset2.data = [];
    		dataset2.label = "# Strumenti per Tipologia";
    		
    		
     		dataset2.backgroundColor = [ ];
    		dataset2.borderColor = [ ];
    		for (i = 0; i < numberBack2; i++) {
    			newArr = [
    		         'rgba(255, 99, 132, 0.2)',
    		         'rgba(54, 162, 235, 0.2)',
    		         'rgba(255, 206, 86, 0.2)',
    		         'rgba(75, 192, 192, 0.2)',
    		         'rgba(153, 102, 255, 0.2)',
    		         'rgba(255, 159, 64, 0.2)'
    		     ];
    			
    			newArrB = [
    		         'rgba(255,99,132,1)',
    		         'rgba(54, 162, 235, 1)',
    		         'rgba(255, 206, 86, 1)',
    		         'rgba(75, 192, 192, 1)',
    		         'rgba(153, 102, 255, 1)',
    		         'rgba(255, 159, 64, 1)'
    		     ];
    			
    			dataset2.backgroundColor = dataset2.backgroundColor.concat(newArr);
    			dataset2.borderColor = dataset2.borderColor.concat(newArrB);
    		}
    		

    		dataset2.borderWidth = 1;
    		var itemHeight2 = 200;
		var total2 = 0 ;
    		$.each(tipoStrumentiJson, function(i,val){
    			grafico2.labels.push(i);
    			dataset2.data.push(val);
    			itemHeight2 += 12;
    			total2 += val;
    		});
    		$(".grafico2").height(itemHeight2);
    		 grafico2.datasets = [dataset2];
    		 
    		 var ctx2 = document.getElementById("grafico2").getContext("2d");;
    		 
    		 if(myChart2!= null){
    			 myChart2.destroy();
    		 }
			var config2 = {
		     data: grafico2,
		     options: {
		    	 responsive: true, 
		    	 maintainAspectRatio: false,
		         
		     }
		 };
 			if(Object.keys(tipoStrumentiJson).length<5){
 				config2.type = "pieLabels";
 				$('#grafico2').addClass("col-lg-6");
 				config2.options.tooltips = {
 			    		 callbacks: {
 			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
 			    		      // data : the chart data item containing all of the datasets
 			    		      label: function(tooltipItem, data) {
 			    		    	  var value = data.datasets[0].data[tooltipItem.index];
 			                      var label = data.labels[tooltipItem.index];
 			                      var percentage =  value / total2 * 100;
 			                     
 			                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

 			    		      }
 			    		    }
 	  		 		 };
 			}else{
 				config2.type = "bar";	
 				$('#grafico2').removeClass("col-lg-6");
 			
 			}
    		  myChart2 = new Chart(ctx2, config2);
    	 
    	 }else{
    		 if(myChart2!= null){
    			 myChart2.destroy();
    		 }
    	 }
    	 
     	/* GRAFICO 3*/
    	 
    	 numberBack3 = Math.ceil(Object.keys(denominazioneStrumentiJson).length/6);
    	 if(numberBack3>0){
    		 
    	 
    		grafico3 = {};
    		grafico3.labels = [];
    		 
    		dataset3 = {};
    		dataset3.data = [];
    		dataset3.label = "# Strumenti per Denominazione";
    		
    		
     		dataset3.backgroundColor = [ ];
    		dataset3.borderColor = [ ];
    		for (i = 0; i < numberBack3; i++) {
    			newArr = [
    		         'rgba(255, 99, 132, 0.2)',
    		         'rgba(54, 162, 235, 0.2)',
    		         'rgba(255, 206, 86, 0.2)',
    		         'rgba(75, 192, 192, 0.2)',
    		         'rgba(153, 102, 255, 0.2)',
    		         'rgba(255, 159, 64, 0.2)'
    		     ];
    			
    			newArrB = [
    		         'rgba(255,99,132,1)',
    		         'rgba(54, 162, 235, 1)',
    		         'rgba(255, 206, 86, 1)',
    		         'rgba(75, 192, 192, 1)',
    		         'rgba(153, 102, 255, 1)',
    		         'rgba(255, 159, 64, 1)'
    		     ];
    			
    			dataset3.backgroundColor = dataset3.backgroundColor.concat(newArr);
    			dataset3.borderColor = dataset3.borderColor.concat(newArrB);
    		}
    		

    		dataset3.borderWidth = 1;
    		
    		var itemHeight3 = 200;
    		var total3 = 0;
    		$.each(denominazioneStrumentiJson, function(i,val){
    			grafico3.labels.push(i);
    			dataset3.data.push(val);
    			itemHeight3 += 12;	
    			total3 +=val;
    		});
    		$(".grafico3").height(itemHeight3);
    		
    		
    		
    		 grafico3.datasets = [dataset3];
    		 
    		 var ctx3 = document.getElementById("grafico3").getContext("2d");;
    		 
    		 if(myChart3!= null){
    			 myChart3.destroy();
    		 }
			
    		 config3 = {

        		     data: grafico3,
        		     options: {
        		    	 responsive: true, 
        		    	 maintainAspectRatio: false,
        		          
        		     }
        		 };
    		 if(Object.keys(denominazioneStrumentiJson).length<5){
    			 config3.type = "pieLabels";
 				$('#grafico3').addClass("col-lg-6");
 			}else{
 				config3.type = "horizontalBar";	
 				$('#grafico3').removeClass("col-lg-6");
 				config3.options.tooltips = {
 			    		 callbacks: {
 			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
 			    		      // data : the chart data item containing all of the datasets
 			    		      label: function(tooltipItem, data) {
 			    		    	  var value = data.datasets[0].data[tooltipItem.index];
 			                      var label = data.labels[tooltipItem.index];
 			                      var percentage =  value / total3 * 100;
 			                     
 			                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

 			    		      }
 			    		    }
 	  		 		 };
 			}
    		  myChart3 = new Chart(ctx3, config3);
    	 
    	 }else{
    		 if(myChart3!= null){
    			 myChart3.destroy();
    		 }
    	 }
    	 
     /* GRAFICO 4*/
    	 
    	 numberBack4 = Math.ceil(Object.keys(freqStrumentiJson).length/6);
    	 if(numberBack4>0){
    		 
    	 
    		grafico4 = {};
    		grafico4.labels = [];
    		 
    		dataset4 = {};
    		dataset4.data = [];
    		dataset4.label = "# Strumenti per Frequenza";
    		
    		
     		dataset4.backgroundColor = [ ];
    		dataset4.borderColor = [ ];
    		for (i = 0; i < numberBack4; i++) {
    			newArr = [
    		         'rgba(255, 99, 132, 0.2)',
    		         'rgba(54, 162, 235, 0.2)',
    		         'rgba(255, 206, 86, 0.2)',
    		         'rgba(75, 192, 192, 0.2)',
    		         'rgba(153, 102, 255, 0.2)',
    		         'rgba(255, 159, 64, 0.2)'
    		     ];
    			
    			newArrB = [
    		         'rgba(255,99,132,1)',
    		         'rgba(54, 162, 235, 1)',
    		         'rgba(255, 206, 86, 1)',
    		         'rgba(75, 192, 192, 1)',
    		         'rgba(153, 102, 255, 1)',
    		         'rgba(255, 159, 64, 1)'
    		     ];
    			
    			dataset4.backgroundColor = dataset4.backgroundColor.concat(newArr);
    			dataset4.borderColor = dataset4.borderColor.concat(newArrB);
    		}
    		

    		dataset4.borderWidth = 1;
    		var itemHeight4 = 200;
		var total4 = 0;
    		$.each(freqStrumentiJson, function(i,val){
    			grafico4.labels.push(i);
    			dataset4.data.push(val);
    			total4 += val;
    			itemHeight4 += 12;
    		});
    		$(".grafico4").height(itemHeight4);

    		
    		 grafico4.datasets = [dataset4];
    		 
    		 var ctx4 = document.getElementById("grafico4").getContext("2d");;

    		 if(myChart4!= null){
    			 myChart4.destroy();
    		 }
var config4 = {

	     data: grafico4,
	     options: {
	    	 responsive: true, 
	    	 maintainAspectRatio: false,
	          
	     }
	 };
 			if(Object.keys(freqStrumentiJson).length<5){
 				config4.type = "pieLabels";
 				config4.options.tooltips = {
 			    		 callbacks: {
 			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
 			    		      // data : the chart data item containing all of the datasets
 			    		      label: function(tooltipItem, data) {
 			    		    	  var value = data.datasets[0].data[tooltipItem.index];
 			                      var label = data.labels[tooltipItem.index];
 			                      var percentage =  value / total4 * 100;
 			                     
 			                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

 			    		      }
 			    		    }
 	  		 		 };
 				$('#grafico14').addClass("col-lg-6");
 			}else{
 				config4.type = "horizontalBar";	
 				$('#grafico4').removeClass("col-lg-6");
 			
 			}
    		  myChart4 = new Chart(ctx4, config4);
    	 
    	 }else{
    		 if(myChart4!= null){
    			 myChart4.destroy();
    		 }
    	 }
    	 
     /* GRAFICO 5*/
    	 
    	 numberBack5 = Math.ceil(Object.keys(repartoStrumentiJson).length/6);
    	 if(numberBack5>0){
    		 
    	 
    		grafico5 = {};
    		grafico5.labels = [];
    		 
    		dataset5 = {};
    		dataset5.data = [];
    		dataset5.label = "# Strumenti per Reparto";
    		

     		dataset5.backgroundColor = [ ];
    		dataset5.borderColor = [ ];
    		for (i = 0; i < numberBack5; i++) {
    			newArr = [
    		         'rgba(255, 99, 132, 0.2)',
    		         'rgba(54, 162, 235, 0.2)',
    		         'rgba(255, 206, 86, 0.2)',
    		         'rgba(75, 192, 192, 0.2)',
    		         'rgba(153, 102, 255, 0.2)',
    		         'rgba(255, 159, 64, 0.2)'
    		     ];
    			
    			newArrB = [
    		         'rgba(255,99,132,1)',
    		         'rgba(54, 162, 235, 1)',
    		         'rgba(255, 206, 86, 1)',
    		         'rgba(75, 192, 192, 1)',
    		         'rgba(153, 102, 255, 1)',
    		         'rgba(255, 159, 64, 1)'
    		     ];
    			
    			dataset5.backgroundColor = dataset5.backgroundColor.concat(newArr);
    			dataset5.borderColor = dataset5.borderColor.concat(newArrB);
    		}
    		

    		dataset5.borderWidth = 1;
    		var itemHeight5 = 200;
    		var total5 = 0;
    		$.each(repartoStrumentiJson, function(i,val){
    			grafico5.labels.push(i);
    			dataset5.data.push(val);
    			total5 += val;
    			itemHeight5 += 12;
    		});
    		$(".grafico5").height(itemHeight5);

    		
    		 grafico5.datasets = [dataset5];
    		 
    		 var ctx5 = document.getElementById("grafico5").getContext("2d");;
    		

    		 if(myChart5!= null){
    			 myChart5.destroy();
    		 }
    		 var	 config5={
	    		     data: grafico5,
	    		     options: {
	    		    	 	responsive: true, 
	    		    	 	maintainAspectRatio: false
	    		    	 	}
			};
 			if(Object.keys(repartoStrumentiJson).length<5){
 				config5.type = "pieLabels";
 				config5.options.tooltips = {
 			    		 callbacks: {
 			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
 			    		      // data : the chart data item containing all of the datasets
 			    		      label: function(tooltipItem, data) {
 			    		    	  var value = data.datasets[0].data[tooltipItem.index];
 			                      var label = data.labels[tooltipItem.index];
 			                      var percentage =  value / total5 * 100;
 			                     
 			                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

 			    		      }
 			    		    }
 	  		 		 };
 				$('#grafico5').addClass("col-lg-6");
 			}else{
 				config5.type = "horizontalBar";	
 				$('#grafico5').removeClass("col-lg-6");
 			
 			}
    		  myChart5 = new Chart(ctx5, config5);
    	 
    	 }else{
    		 if(myChart5!= null){
    			 myChart5.destroy();
    		 }
    	 }
    	 
     /* GRAFICO 6*/
    	 
    	 numberBack6 = Math.ceil(Object.keys(utilizzatoreStrumentiJson).length/6);
    	 if(numberBack6>0){
    		 
    	 
    		grafico6 = {};
    		grafico6.labels = [];
    		 
    		dataset6 = {};
    		dataset6.data = [];
    		dataset6.label = "# Strumenti Utilizzatore";
    		
    		
     		dataset6.backgroundColor = [ ];
    		dataset6.borderColor = [ ];
    		for (i = 0; i < numberBack6; i++) {
    			newArr = [
    		         'rgba(255, 99, 132, 0.2)',
    		         'rgba(54, 162, 235, 0.2)',
    		         'rgba(255, 206, 86, 0.2)',
    		         'rgba(75, 192, 192, 0.2)',
    		         'rgba(153, 102, 255, 0.2)',
    		         'rgba(255, 159, 64, 0.2)'
    		     ];
    			
    			newArrB = [
    		         'rgba(255,99,132,1)',
    		         'rgba(54, 162, 235, 1)',
    		         'rgba(255, 206, 86, 1)',
    		         'rgba(75, 192, 192, 1)',
    		         'rgba(153, 102, 255, 1)',
    		         'rgba(255, 159, 64, 1)'
    		     ];
    			
    			dataset6.backgroundColor = dataset6.backgroundColor.concat(newArr);
    			dataset6.borderColor = dataset6.borderColor.concat(newArrB);
    		}
    		

    		dataset6.borderWidth = 1;
    		var itemHeight6 = 200;
    		var total6 = 0;
    		$.each(utilizzatoreStrumentiJson, function(i,val){
    			grafico6.labels.push(i);
    			dataset6.data.push(val);
    			total6 += val;
    			itemHeight6 += 12;
    		});

    		 grafico6.datasets = [dataset6];
    		 
    		 var ctx6 = document.getElementById("grafico6").getContext("2d");;
    		 
    		 if(myChart6!= null){
    			 myChart6.destroy();
    		 }


    		 
    		 var	 config6={
		    		     data: grafico6,
		    		     options: {
		    		    	 	responsive: true, 
		    		    	 	maintainAspectRatio: false
		    		    	 	}
				};
    		 
 			if(Object.keys(utilizzatoreStrumentiJson).length<5){

 				$('#grafico6').addClass("col-lg-6");
 				config6.type = "pieLabels";
 				config6.options.tooltips = {
		    		 callbacks: {
		    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
		    		      // data : the chart data item containing all of the datasets
		    		      label: function(tooltipItem, data) {
		    		    	  var value = data.datasets[0].data[tooltipItem.index];
		                      var label = data.labels[tooltipItem.index];
		                      var percentage =  value / total6 * 100;
		                     
		                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

		    		      }
		    		    }
  		 		 };
 			}else{
 				config6.type = "horizontalBar";	
 				$('#grafico6').removeClass("col-lg-6");
 			
 			}
    		 $(".grafico6").height(itemHeight6);
    		  myChart6 = new Chart(ctx6, config6);
    	 
    	 }else{
    		 if(myChart6!= null){
    			 myChart6.destroy();
    		 }
    	 }
    	 
    	 
    	 if(	numberBack1==0 && numberBack2==0 && numberBack3==0 && numberBack4==0 && numberBack5==0 && numberBack6==0){
    		 $(".boxgrafici").hide();
    		 
    	 }else{
    		 $(".boxgrafici").show();
    	 }
    
    });
  </script>
</jsp:attribute> 
</t:layout>







