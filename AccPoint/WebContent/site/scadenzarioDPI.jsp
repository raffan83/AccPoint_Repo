<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">
<c:if test="${id_fornitore!=null }">
<c:set var="id_forn" value="${utl:encryptData(id_fornitore)};"></c:set>
</c:if>
<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   
<!-- Content Header (Page header) -->
    <section class="content-header">
     <h1 class="pull-left">

      Scadenzario Dispositivi
   
      </h1><br><br>
      
        
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            
            <div class="row">

	<div class="col-xs-5">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Filtra Data Scadenza Dispositivi:</label>
					<div class="col-md-10 input-group" >
						<div class="input-group-addon">
				             <i class="fa fa-calendar"></i>
				        </div>				                  	
						 <input type="text" class="form-control" id="datarange" name="datarange" value=""/> 						    
							 <span class="input-group-btn">
				               <button type="button" class="btn btn-info btn-flat" onclick="filtraDate()">Cerca</button>
				               <button type="button" style="margin-left:5px" class="btn btn-primary btn-flat" onclick="resetDate()">Reset Date</button>
				             </span>				                     
  					</div>  								
			 </div>	
			 
			 

	</div>
	<div class="col-xs-7">
	
	</div>


</div>
            


<div class="row">	

	<div class="col-xs-12">
	 <div id="calendario" >
	</div>

	</div>
	
	<input type="hidden" id="data_start">
	<input type="hidden" id="data_end">
</div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
 </div>
</div>


</section>
  </div>
  <!-- /.content-wrapper -->

<form id="modificaDocumentoForm" name="modificaDocumentoForm">
<div id="myModalModificaDocumento" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Documento</h4>
      </div>
            <div class="modal-body">
            
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Committente</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="committente_docum_mod" id="committente_docum_mod" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona committente..." data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_committenti}" var="committente">
                     
                           <option value="${committente.id}">${committente.nome_cliente} - ${committente.indirizzo_cliente }</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>

      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Fornitore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="fornitore_mod" id="fornitore_mod" class="form-control select2" data-placeholder="Seleziona fornitore..." aria-hidden="true" data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_fornitori}" var="fornitore">
                     
                           <option value="${fornitore.id}">${fornitore.ragione_sociale}</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
       
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Associa ai dipendenti</label>
       	</div>
       	<div class="col-sm-9"> 
           <select name="dipendenti_mod" id="dipendenti_mod" class="form-control select2" data-placeholder="Seleziona dipendenti" aria-hidden="true" data-live-search="true" style="width:100%" disabled multiple>
                <option value=""></option>
                      <c:forEach items="${lista_dipendenti}" var="dipendente">
                     
                           <option value="${dipendente.id}">${dipendente.nome} ${dipendente.cognome }</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br> 
             
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Nome Documento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="nome_documento_mod" name="nome_documento_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
              <div class="row">
       
       	<div class="col-sm-3">
       		<label>Numero Documento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="numero_documento_mod" name="numero_documento_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       
                           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo Documento</label>
       	</div>
       	<div class="col-sm-9"> 
           <select name="tipo_documento_mod" id="tipo_documento_mod" class="form-control select2" data-placeholder="Seleziona tipo documento..." aria-hidden="true" data-live-search="true" style="width:100%"  >
                <option value=""></option>
                      <c:forEach items="${lista_tipo_documento}" var="tipo">
                     
                           <option value="${tipo.id}_${tipo.aggiornabile_cl_default}">${tipo.descrizione}</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br> 
       
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Rilascio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <div class='input-group date datepicker' id='datepicker_data_rilascio_mod'>
               <input type='text' class="form-control input-small" id="data_rilascio_mod" name="data_rilascio_mod" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza (mesi)</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="frequenza_mod" name="frequenza_mod" class="form-control" type="number" min="0" step="1" style="width:100%" >
       			
       	</div>       	
       </div><br>
              
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <div class='input-group date datepicker' id='datepicker_data_scadenza'>
               <input type='text' class="form-control input-small" id="data_scadenza_mod" name="data_scadenza_mod" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>
      
      
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Rilasciato</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="rilasciato_mod" name="rilasciato_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
              		<div class="row">
       <div class="col-sm-3">
       <label>Aggiornabile dal cliente</label>
		</div>
		
		<div class="col-sm-9">
       <input type="checkbox" class="form-control" id="aggiornabile_cl_mod" name="aggiornabile_cl_mod">
		</div>
		</div><br>
                    
                    
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>File</label>
       	</div>
       	<div class="col-sm-9">      
			<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.xls,.xlsx,.XLS,.XLSX,.p7m,.doc,.docX,.DOCX,.DOC,.P7M"  id="fileupload_mod" name="fileupload_mod" type="file" ></span><label id="label_file_mod"></label>
       	</div>       	
       </div><br> 


       
       </div>
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="ids_dipendenti_mod" name="ids_dipendenti_mod">
		<input type="hidden" id="ids_dipendenti_dissocia" name="ids_dipendenti_dissocia">
		<input type="hidden" id="id_documento" name="id_documento">
		<input type="hidden" id="fornitore_temp" name="fornitore_temp">
		<input type="hidden" id="aggiornabile_cliente_mod" name="aggiornabile_cliente_mod">

		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>
	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">
<style>
.btn-circle.btn-xl {
    width: 70px;
    height: 70px;
    padding: 10px 16px;
    border-radius: 35px;
    font-size: 24px;
    line-height: 1.33;
}

.btn-circle {
    width: 30px;
    height: 30px;
    padding: 6px 0px;
    border-radius: 15px;
    text-align: center;
    font-size: 12px;
    line-height: 1.42857;
}
</style>
</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/gh/emn178/chartjs-plugin-labels/src/chartjs-plugin-labels.js"></script>

<script type="text/javascript">


function filtraDate(jspDoc){
	

	
		var startDatePicker = $("#datarange").data('daterangepicker').startDate;
	 	var endDatePicker = $("#datarange").data('daterangepicker').endDate;
	 	dataString = "action=scadenzario_table&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + 
	 			endDatePicker.format('YYYY-MM-DD');
	 	
	 	 pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();

	 	//callAction("gestioneFormazione.do"+ dataString, false,true);

	 	exploreModal("gestioneDpi.do", dataString, '#calendario');
	 	
	 	jspDipendenti = false;

	

}


function filtraDateDipendenti(){
	
	$('#vista_dipendenti').attr("disabled", true);
	$('#vista_documenti').attr("disabled", false);
	
	//var id_fornitore = "${id_forn}";
	
	var startDatePicker = $("#datarange").data('daterangepicker').startDate;
 	var endDatePicker = $("#datarange").data('daterangepicker').endDate;
 	dataString = "action=scadenzario_dipendenti&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + 
 			endDatePicker.format('YYYY-MM-DD');
 	
 	 pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();

 	//callAction("gestioneFormazione.do"+ dataString, false,true);

 	exploreModal("gestioneDocumentale.do", dataString, '#calendario');
 	
 	jspDipendenti = true;
 	//exploreModal('gestioneDocumentale.do','action=scadenzario_dipendenti','#calendario')
}



function resetDate(){
pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
callAction("gestioneDocumentale.do?action=scadenzario");

}


function formatDate(data){
	
	   var mydate =  data;
	   
	   if(!isNaN(mydate)){
	   
		var   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}


var jspDipendenti = false;

$(document).ready(function() {
	 

    $('.dropdown-toggle').dropdown();
    $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });    
    
    $('.select2').select2();
    
    
    
    var start = "${dateFrom}";
 	var end = "${dateTo}";

 	$('input[name="datarange"]').daterangepicker({
	    locale: {
	      format: 'DD/MM/YYYY'
	    
	    }
	}, 
	function(start, end, label) {

	});
 	
 	if(start!=null && start!=""){
	 	$('#datarange').data('daterangepicker').setStartDate(formatDate(start));
	 	$('#datarange').data('daterangepicker').setEndDate(formatDate(end));
	
	 }

    
		

	
	
});



$(function () {
	

/* 	var id_fornitore = "${id_forn}";
	
	if(id_fornitore==""){
		addCalendarDocumentale(0);
	}else{
		addCalendarDocumentale(id_fornitore);
	} */
	
	
	
	

	});
	
	
</script>
 
</jsp:attribute> 
</t:layout>