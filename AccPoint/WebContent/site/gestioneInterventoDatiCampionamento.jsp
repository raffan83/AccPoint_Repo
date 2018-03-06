<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

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
    </section>
<div style="clear: both;"></div>

    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            
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
                  <b>ID</b> <a class="pull-right">${interventoCampionamento.id}</a>
                </li>
   
                <li class="list-group-item">
                  <b>Data Creazione</b> <a class="pull-right">
	
		  	<c:if test="${not empty interventoCampionamento.dataCreazione}">
   				<fmt:formatDate pattern="dd/MM/yyyy" value="${interventoCampionamento.dataCreazione}" />
			</c:if>  
		</a>
                </li>
                
                <li class="list-group-item">
                  <b>Date Intervento</b> <a class="pull-right">
	
 			   				dal <fmt:formatDate pattern="dd/MM/yyyy" value="${interventoCampionamento.dataInizio}" /> al <fmt:formatDate pattern="dd/MM/yyyy" value="${interventoCampionamento.dataFine}" />
 					</a>
                </li>
                
                <li class="list-group-item">
                  <b>Stato</b> <a class="pull-right">

    <span class="label label-info">${interventoCampionamento.stato.descrizione}</span>


				</a>
                </li>
                <li class="list-group-item">
                  <b>Responsabile</b> <a class="pull-right">${interventoCampionamento.user.nominativo}</a>
                </li>
                
                 <li class="list-group-item">
                  <b>Lista Attività</b>
                  <div class=" list-group-no-border" >
                    <c:set var = "values" value = "${fn:split(interventoCampionamento.idAttivita, '|')}" />
                   <c:forEach items="${values}" var="it" varStatus="loop"><div class="list-group-item"><a class="">${it}</a></div></c:forEach>
                   	</div>
                </li>
                
                 <li class="list-group-item">
                  <b>Tipo Matrice</b>
                   <a class="pull-right">${interventoCampionamento.tipoMatrice.descrizione}</a> 
                </li>
                
                <li class="list-group-item">
                  <b>Tipo Campionamento</b>
                 <a class="pull-right">${interventoCampionamento.tipologiaCampionamento.descrizione}</a> 
                </li>
                
                 <li class="list-group-item">
                  <b>Tipo Analisi</b>
                 <a class="pull-right">${interventoCampionamento.tipoAnalisi.descrizione}</a> 
                </li>
                
                
        </ul>
        
   
</div>
</div>
</div>
</div>
      
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

    <a class="pull-right">${interventoCampionamento.nomePack}</a>
		 
                </li>
               <li class="list-group-item">
                  <b>Pacchetto caricato</b> <a class="pull-right">
                  <c:if test="${interventoCampionamento.statoUpload == 'N'}">
   					NO
				</c:if>
				 <c:if test="${interventoCampionamento.statoUpload == 'S'}">
   					SI
				</c:if>
                  
                  </a>
                </li>

                <li class="list-group-item">
                  <b>Data Caricamento</b> 
                  <a class="pull-right">
						<c:if test="${not empty interventoCampionamento.dataUpload}">
   							<fmt:formatDate pattern="dd/MM/yyyy" value="${interventoCampionamento.dataUpload}" />
					</c:if>
				</a>
                </li>
                <li class="list-group-item">
                  <b> Utente Caricamento</b>  

    					<a class="pull-right">${interventoCampionamento.userUpload.nominativo}</a>
		 
                </li>
	 <c:if test="${userObj.checkPermesso('DL_SCHEDA_LISTA_METROLOGIA')}"> 	 
                <li class="list-group-item">
                  <b>Scheda Campionamento</b>  
                  <div class="pull-right">
					<c:if test="${interventoCampionamento.statoUpload == 'S'}">
					<div class="btn-group">
    						<a href="scaricaSchedaCampionamento.do?action=schedaCampionamento&nomePack=${interventoCampionamento.nomePack}" id="downloadScheda" class=" btn btn-info customTooltip" title="Click scaricare la scheda di campionamento"><i class="fa fa-download"></i> Download Scheda</a>
              		</div>
              		<div class="btn-group">
	              		<a href="scaricaSchedaCampionamento.do?action=exportSchedaCampionamento&id=${interventoCampionamento.id}" id="exportScheda" class=" btn btn-success customTooltip" title="Click per esportare in excel i dati di campionamento"  ><i class="fa fa-table"></i></a>
	              		</div>	
	              	</c:if>	 
	              	<c:if test="${interventoCampionamento.statoUpload == 'N'}">
	              	
	              	<div class="btn-group">
    						<a id="downloadScheda" class=" btn btn-info" disabled><i class="fa fa-download"></i> Download Scheda</a>
    						</div>
              		<div class="btn-group">
    						<a id="exportScheda" class=" btn btn-success" disabled><i class="fa fa-table"></i></a>
    						</div>
	              	</c:if>	 				
	              	</div>
		 			<div class="spacer" style="clear: both;"></div>
                </li>
                
                 <li class="list-group-item">
                  <b>Crea Relazione</b>  
					<c:if test="${interventoCampionamento.statoUpload == 'S'}">
    						<a href="creazioneRelazioneCampionamento.do?action=relazioneCampionamento&idIntervento=${interventoCampionamento.id}" id="creaRelazione" class="pull-right btn btn-info customTooltip" title="Click per aprire la creazione delle relazione di Campionamento"  ><i class="fa fa-plus-circle"></i> Crea Relazione</a>
	              	</c:if>	 
	              	<c:if test="${interventoCampionamento.statoUpload == 'N'}">
    						<a id="creaRelazione" class="pull-right btn btn-info" disabled><i class="fa fa-plus-circle"></i> Crea Relazione</a>
	              	</c:if>	 				
	              	
		 			<div class="spacer" style="clear: both;"></div>
                </li>
  </c:if>	 
               
        </ul>
     <c:if test="${userObj.checkPermesso('DL_UL_PACK_METROLOGIA')}"> 	 
        <div class="row">
		    <div class="col-xs-4">
				<button class="btn btn-default pull-left customTooltip" title="Click per scaricare il pacchetto per effettuare il campionamento"  onClick="scaricaPacchettoCampionamento('${interventoCampionamento.nomePack}')"><i class="fa fa-download"></i> Download Pacchetto</button>
			</div>
			<div class="col-xs-4">
			    <span class="btn btn-primary fileinput-button pull-right customTooltip" title="Click per caricare il pacchetto modificato" >
			        <i class="fa fa-plus"></i>
			        <span>Seleziona un file...</span>
			        <!-- The file input field used as target for the file upload widget -->
			        <input id="fileupload" type="file" name="files">
		    		</span>
		    </div>
		    <div class="col-xs-4">
		        <div id="progress" class="progress">
		        		<div class="progress-bar progress-bar-success"></div>
		    		</div>
			    <!-- The container for the uploaded files -->
			    <div id="files" class="files"></div>
		    </div>
	    </div>
    </c:if>	 
	</div>
</div>
</div>
</div>      
            
            
            
              <div class="row">
        <div class="col-xs-12">
 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Prenotazioni
	<div class="box-tools pull-right">

		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

				<div class="box box-primary">
					            <div class="box-header">
					              <i class="ion ion-clipboard"></i>
					
					              <h3 class="box-title">Lista Accessori</h3>
					
					              <div class="box-tools pull-right">
					            
					              </div>
					            </div>
					            <!-- /.box-header -->
					            <div class="box-body">
					            <div class="col-md-12">
					           		 <table class="table table-striped" id="tableAccessori">
										  <thead>
										    <tr>
										      <th>Nome</th>
										      <th>Descrizione</th>
 										      <th>Quantità</th>
 										    </tr>
										  </thead>
										  <tbody>
										  <c:set var="artiolis" value="0" />
										  <c:set var="artioliw" value="0" />
										  <c:set var="artiolid" value="0" />
										  <c:forEach items="${listaPrenotazioniAccessori}" var="pren" varStatus="loop">
										 										
										  <tr>
										  	  
										      <td>${pren.accessorio.nome}</td>
										      <td>${pren.accessorio.descrizione}</td>
										      <td>${pren.quantita}</td>
																																    </tr>
										   
									    </c:forEach>
										    
										    

										  </tbody>
										</table>
					             	   </div>
					              
					             	   
					            </div>
					            <!-- /.box-body -->
					         
					      </div>    
					      
					      <div class="box box-danger">
					            <div class="box-header">
					              <i class="ion ion-clipboard"></i>
					
					              <h3 class="box-title">Lista Dotazioni</h3>
					
					              <div class="box-tools pull-right">
					            
					              </div>
					            </div>
					            <!-- /.box-header -->
					            <div class="box-body">
					            <div class="col-md-12">
					           		 <table class="table table-striped" id="tableAccessori">
										  <thead>
										    <tr>
										      <th>Marca</th>
										      <th>Modello</th>
 										      <th>Tipologia</th>
 										      <th>Matricola</th>
 										      <th>Targa</th>
 										    </tr>
										  </thead>
										  <tbody>
										  <c:set var="artiolis" value="0" />
										  <c:set var="artioliw" value="0" />
										  <c:set var="artiolid" value="0" />
										  <c:forEach items="${listaPrenotazioniDotazioni}" var="pren" varStatus="loop">
										 										
										  <tr>
										  	  
										      <td>${pren.dotazione.marca}</td>
										      <td>${pren.dotazione.modello}</td>
										      <td>${pren.dotazione.tipologia.codice} - ${pren.dotazione.tipologia.descrizione}</td>
											  <td>${pren.dotazione.matricola}</td>
											  <td>${pren.dotazione.targa}</td>																				    </tr>
										   
									    </c:forEach>
										    
										    

										  </tbody>
										</table>
					             	   </div>
					              
					             	   
					            </div>
					            <!-- /.box-body -->
					         
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
      <div class="modal-footer">

        <button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
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

 <script type="text/javascript">
   
 
    $(document).ready(function() { 
    	
    	$('#fileupload').fileupload({
            url: "caricaPacchettoCampionamento.do",
            dataType: 'json',
            maxNumberOfFiles : 1,
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
                	$('#modalErrorDiv').html(uploadErrors.join("\n"));
					$('#myModal').removeClass();
					$('#myModal').addClass("modal modal-danger");
					$('#myModal').modal('show');
                } else {
                    data.submit();
                }
        	},
            done: function (e, data) {
				
            	pleaseWaitDiv.modal('hide');
            	
            	if(data.result.success)
				{
            			$('#modalErrorDiv').html(data.result.messaggio);
					$('#myModal').removeClass();
					$('#myModal').addClass("modal modal-success");
					$('#myModal').modal('show');
					
					$("#downloadScheda").removeAttr("disabled");
					$("#downloadScheda").attr("href", "scaricaSchedaCampionamento.do?action=schedaCampionamento&nomePack=${interventoCampionamento.nomePack}");
					
					$("#creaRelazione").removeAttr("disabled");
					$("#creaRelazione").attr("href", "creazioneRelazioneCampionamento.do?action=relazioneCampionamento&idIntervento=${interventoCampionamento.id}");

				}else{
					
					$('#modalErrorDiv').html(data.result.messaggio);
					$('#myModal').removeClass();
					$('#myModal').addClass("modal modal-danger");
					$('#myModal').modal('show');
					$('#progress .progress-bar').css(
		                    'width',
		                    '0%'
		                );

				}


            },
            fail: function (e, data) {
            	pleaseWaitDiv.modal('hide');
            	$('#files').html("");
            	var errorMsg = "";
                $.each(data.messages, function (index, error) {

                	errorMsg = errorMsg + '<p>ERRORE UPLOAD FILE: ' + error + '</p>';
           

                });
                $('#modalErrorDiv').html(errorMsg);
				$('#myModal').removeClass();
				$('#myModal').addClass("modal modal-danger");
				$('#myModal').modal('show');
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
    	
    	$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
    
    
    });

  </script>
</jsp:attribute> 
</t:layout>







