<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
       Esito Comunicazioni       
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
  <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">

          </div>
            <div class="box-body">
    <div class="row">

<div class="col-xs-6">
	 <label for="provincia" class="control-label">Provincia:</label>
       <select id="provincia" name="provincia" class="form-control select2"  data-placeholder="Seleziona Provincia..." aria-hidden="true" data-live-search="true" style="width:100%">
       <option value=""></option>
      	<c:forEach items="${lista_province}" var="provincia">
      	<option value="${provincia.nome }">${provincia.nome }</option>
      	</c:forEach>
      
      </select>
</div>
	<div class="col-xs-6">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Ricerca Date:</label>
					<div class="col-md-10 input-group" >
						<div class="input-group-addon">
				             <i class="fa fa-calendar"></i>
				        </div>				                  	
						 <input type="text" class="form-control" id="datarange" name="datarange" value=""/> 						    
							 <span class="input-group-btn">
				               <button type="button" class="btn btn-info btn-flat" onclick="filtraComunicazioniPerData()">Cerca</button>
				               <button type="button" style="margin-left:5px" class="btn btn-primary btn-flat" onclick="resetDate()">Reset Date</button>
				             </span>				                     
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
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Strumento</h4>
      </div>
       <div class="modal-body">

        <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#dettaglio" data-toggle="tab" aria-expanded="true" onclick="" id="dettaglioTab">Dettaglio Strumento</a></li>
              <li class=""><a href="#misure" data-toggle="tab" aria-expanded="false" onclick="" id="misureTab">Misure</a></li>
       <!--        <li class=""><a href="#prenotazione" data-toggle="tab" aria-expanded="false" onclick="" id="prenotazioneTab">Stato Prenotazione</a></li>
               <li class=""><a href="#aggiorna" data-toggle="tab" aria-expanded="false" onclick="" id="aggiornaTab">Gestione Campione</a></li> -->
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="dettaglio">

    			</div> 

              <!-- /.tab-pane -->
             
			  <div class="tab-pane" id="misure">
                

         
			 </div> 


              <!-- /.tab-pane -->

             <!--  <div class="tab-pane" id="prenotazione">
              

              </div> -->
              <!-- /.tab-pane -->
              <!-- <div class="tab-pane" id="aggiorna">
              

              </div> -->
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



  <div  class="modal"><!-- Place at bottom of page --></div> 
   <div id="modal1"><!-- Place at bottom of page --></div> 
   
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">
	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/css/bootstrap-timepicker.css">
	 <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/css/bootstrap-timepicker.css"></script> -->
	<link type="text/css" href="css/bootstrap.min.css" />

</jsp:attribute>

<jsp:attribute name="extra_js_footer">

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
 <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/lodash@4.17.11/lodash.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/js/bootstrap-timepicker.js"></script>

   <script src="plugins/iCheck/icheck.js"></script>
  <script src="plugins/iCheck/icheck.min.js"></script> 
  <script type="text/javascript">


  
  function filtraComunicazioniPerData(){		
	  
	  	$('#provincia').siblings(".select2-container").css('border', '0px solid #d2d6de');
		if($('#provincia').val()!=null && $('#provincia').val()!=''){
			
			var startDatePicker = $("#datarange").data('daterangepicker').startDate;
			var endDatePicker = $("#datarange").data('daterangepicker').endDate;
			
			dataString = "?action=crea_file_esito_comunicazione&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + endDatePicker.format('YYYY-MM-DD')+"&provincia="+$('#provincia').val();			 	
			pleaseWaitDiv = $('#pleaseWaitDialog');
			pleaseWaitDiv.modal();

			callAction("gestioneVerComunicazionePreventiva.do"+ dataString, false,true);
		}else{		
			$('#provincia').siblings(".select2-container").css('border', '1px solid #f00');
		}		
	}
	 
	 function resetDate(){
			pleaseWaitDiv = $('#pleaseWaitDialog');
			pleaseWaitDiv.modal();
			callAction('gestioneVerComunicazionePreventiva.do?action=esito_comunicazioni',null,true);

		}
	 
		function formatDate(data){
			
			   var mydate = new Date(data);
			   
			   if(!isNaN(mydate.getTime())){
			   
				   str = mydate.toString("dd/MM/yyyy");
			   }			   
			   return str;	 		
		}
	 
		 $(document).ready(function() {
			 $('.dropdown-toggle').dropdown();
			 $('.select2').select2();
			 
			 $('input[name="datarange"]').daterangepicker({
				    locale: {
				      format: 'DD/MM/YYYY'
				    
				    }
				}, 
				function(start, end, label) {

				});
			 
/* 			 var start = "${dateFromDdt}";
			 var end = "${dateToDdt}";
			 if(start!=null && start!=""){
				 	$('#datarange').data('daterangepicker').setStartDate(formatDate(start));
				 	$('#datarange').data('daterangepicker').setEndDate(formatDate(end));				
		 
				 } */
		 });
    
  </script>
</jsp:attribute> 
</t:layout>

 
 