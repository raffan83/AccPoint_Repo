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
        Creazione Rapporto Tecnico
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
	Informazioni Interventi
	<div class="box-tools pull-right">

		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

<div class="row">
       						<div class="col-xs-12">
       							<div class="nav-tabs-custom">
						            <ul id="mainTabs" class="nav nav-tabs">
						            
						            <c:forEach  items="${interventi}" var="intervento" varStatus="loop">
						      
 <c:if test="${loop.index == 0}"><c:set var = "idFirst" scope = "session" value = "${intervento.id}"/></c:if>
						              <li <c:if test="${loop.index == 0}">class="active"</c:if>><a href="#intervento${intervento.id}" data-toggle="tab" aria-expanded="true"   id="${intervento.id}Tab">Int. ${intervento.id}</a></li>
						               </c:forEach>
						           
						            </ul>
						            <div class="tab-content">
						             <c:forEach  items="${interventi}" var="intervento">
						              	<div <c:if test="${idFirst == intervento.id}">class="tab-pane active"</c:if><c:if test="${idFirst != intervento.id}">class="tab-pane"</c:if> id="intervento${intervento.id}">

									        <div class="row">
												<div class="col-xs-12">
												
												 	<ul class="list-group list-group-unbordered">
               
             
											                <li class="list-group-item">
											                  <b>Data Creazione</b>
											                   <a class="pull-right">
												
																	  	<c:if test="${not empty intervento.dataCreazione}">
															   				<fmt:formatDate pattern="dd/MM/yyyy" value="${intervento.dataCreazione}" />
																		</c:if>  
																	</a>
											                </li>
											                
											                <li class="list-group-item">
											                  <b>Date Intervento</b> <a class="pull-right">
												
											 			   				dal <fmt:formatDate pattern="dd/MM/yyyy" value="${intervento.dataInizio}" /> al <fmt:formatDate pattern="dd/MM/yyyy" value="${intervento.dataFine}" />
											 					</a>
											                </li>
											                
											               
											                <li class="list-group-item">
											                  <b>Responsabile</b> <a class="pull-right">${intervento.user.nominativo}</a>
											                </li>
											                
											                 <li class="list-group-item">
											                  <b>Lista Attività</b>
											                  <div class=" list-group-no-border" >
											                    <c:set var = "values" value = "${fn:split(intervento.idAttivita, '|')}" />
											                   <c:forEach items="${values}" var="it" varStatus="loop"><div class="list-group-item"><a class="">${it}</a></div></c:forEach>
											                   	</div>
											                </li>
											                
											                 
											                <li class="list-group-item">
											                  <b>Scheda Campionamento</b>  
											     						<a href="scaricaSchedaCampionamento.do?action=schedaCampionamento&nomePack=${intervento.nomePack}" id="downloadScheda" class="pull-right btn btn-info"><i class="glyphicon glyphicon-download"></i> Download Scheda</a>
												              	 
													 			<div class="spacer" style="clear: both;"></div>
											                </li>
											                
											        </ul>
												</div>
											</div>

						    			</div> 
						              <!-- /.tab-pane -->
						            
						             </c:forEach>
						            
						            
						            </div>
						            <!-- /.tab-content -->
						          </div>
       						
       						</div>
        				</div>

  
	</div>
</div>
</div>
</div>      
            
      <div class="row">
<div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	Relazione
	<div class="box-tools pull-right">

		<!-- <button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button> -->

	</div>
</div>
	<div class="box-body">
		<div>
			<label>Allega Excel Rapporto Analisi</label>
			<input accept=".xlsx" type="file" class="form-data" name="relazione" id="relazione" multiple>
		</div>
		
		<div>
			<label>Allega Rapporto Laboratorio</label>
			<input accept="application/pdf" type="file" class="form-data" name="relazioneLab" id="relazioneLab">
		</div>
	
		<div>
		
			<label>Laboratorio</label>
	       	<input type="text" class="form-control" id="laboratorio" name="laboratorio" />
	 	</div>
	
		<div>
		
			<label>Conclusioni</label>
	       	<textarea class="form-control" id="editor1" rows="20" name="editor1" ></textarea>
	 	</div>
  
	</div>
	<div class="box-footer">

			<button class="btn btn-default pull-right" onClick="salvaRelazione()" >Genera Nuovo Rapporto</button>
  
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




  <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Messaggio</h4>
      </div>
       <div class="modal-body">
			<div id="myModalErrorContent">
			
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


 
 <script type="text/javascript">
   
 
    $(document).ready(function() { 
    	 $("#relazione").on('change', function(event) {
             var file = event.target.files[0];
         
             if(!file.type.match('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')) {
            	 	$('#myModalErrorContent').html("Inserire solo file in formato xlsx");
   			  	$('#myModalError').removeClass();
   				$('#myModalError').addClass("modal modal-danger");
   				$('#myModalError').modal('show');
                 $("#relazione").val(''); //the tricky part is to "empty" the input file here I reset the form.
                 return false;
             }

           
         });
    	 
    	 $("#relazioneLab").on('change', function(event) {
             var file = event.target.files[0];
         
             if(!file.type.match('application/pdf')) {
                 $('#myModalErrorContent').html("Inserire solo file in formato PDF");
    			  	$('#myModalError').removeClass();
       				$('#myModalError').addClass("modal modal-danger");
       				$('#myModalError').modal('show');
                 $("#relazioneLab").val(''); //the tricky part is to "empty" the input file here I reset the form.
                 return false;
             }

           
         });

         $('#myModalError').on('hidden.bs.modal', function (e) {
				if($( "#myModalError" ).hasClass( "modal-success" )){
					window.location.href = "gestioneInterventoCampionamento.do?idCommessa="+dataJson.idCommessa;
				}
	 		
	  		});
    		
    });
    function salvaRelazione(id){

    		//var objEditor1 = CKEDITOR.instances["editor1"].getData();
    		
    		var objEditor1 = $("#editor1").val();
    		var lab = $("#laboratorio").val();
    		var data = new FormData();
    		data.append('text', objEditor1);
    		data.append('laboratorio', lab);
    		
    		
    		for (var i = 0, f; f = $("#relazione")[0].files[i]; i++) {

    			data.append('relazione', f,"relazione_"+i+".xlsx");


    		}
    		
    		data.append('relazioneLab', $("#relazioneLab")[0].files[0],"relazioneLab.pdf");
    		 pleaseWaitDiv = $('#pleaseWaitDialog');
    		  pleaseWaitDiv.modal();
    		
    	        $.ajax({
    	            type: 'POST',
    	            url: "creazioneRelazioneCampionamento.do?action=generaRelazioneCampionamento&idIntervento="+id,
    	            data: data,
    	            cache: false,
    	            contentType: false,
    	            processData: false,
    	            method: 'POST',
    	            success: function(data) {
    	            	dataJson = JSON.parse(data);
    	           	  	pleaseWaitDiv.modal("hide");
					if(dataJson.success){
						$('#myModalErrorContent').html(dataJson.messaggio);
		   			  	$('#myModalError').removeClass();
		   				$('#myModalError').addClass("modal modal-success");
		   				$('#myModalError').modal('show');
						//window.location.href = "gestioneInterventoCampionamento.do?idCommessa="+dataJson.idCommessa;
 						 
					}else{
						$('#myModalErrorContent').html(dataJson.messaggio);
		   			  	$('#myModalError').removeClass();
		   				$('#myModalError').addClass("modal modal-danger");
		   				$('#myModalError').modal('show');
					}

    	            },
    	            error: function(req, status, error) {
    	           	 	pleaseWaitDiv.modal("hide");
    	            			$('#myModalErrorContent').html(error);
		   			  	$('#myModalError').removeClass();
		   				$('#myModalError').addClass("modal modal-danger");
		   				$('#myModalError').modal('show');
    	            }
    	        });
    	        
    	  
	}
  </script>
</jsp:attribute> 
</t:layout>







