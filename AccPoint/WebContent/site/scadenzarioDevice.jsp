<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
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

      Scadenzario Device
   
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

	<div class="col-xs-3">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Filtra Data Prossima Attività:</label>
					<div class="col-md-10 input-group" >
						<div class="input-group-addon">
				             <i class="fa fa-calendar"></i>
				        </div>				                  	
						 <input type="text" class="form-control" id="datarange" name="datarange" value=""/> 						    
										                     
  					</div>  								
			 </div>	
			 
			 

	</div>
	
	<div class="col-xs-3">
	
		<label>Filtra Company</label>
         
       	  	
        <select id="company" name="company" data-placeholder="Seleziona company..." class="form-control select2" style="width:100%" >
        
        <option value="0" >TUTTE LE COMPANY</option>
     
        <c:forEach items="${lista_company }" var="cmp">
        
        
        <option value="${cmp.id }">${cmp.ragione_sociale }</option>
       
        </c:forEach>
        
        </select>
	
	</div>
	<div class="col-xs-3">
	
	 <span class="input-group-btn" >
				               <button type="button" class="btn btn-info btn-flat" onclick="filtraDate()" style="margin-top:25px">Cerca</button>
				               <button type="button"  class="btn btn-primary btn-flat" onclick="resetDate()" style="margin-top:25px">Reset Filtri</button>
				             </span>	
	</div>
	<div class="col-xs-3">
	<a class="btn btn-primary pull-right" onClick="$('#modalTestoEmail').modal()"><i class="fa fa-edit"></i> Modifica email di notifica</a>
	</div>


</div>
            
            
              <div id="modalTestoEmail" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica testo email</h4>
      </div>
       <div class="modal-body">    
       <label>Email referenti</label>
       <input class="form-control" id="referenti" style="width:100%" value="${testo_email.referenti}">  
       
       <label>Messaggio</label>
       <textarea class="form-control" id="testo_email" rows="5" style="width:100%">${utl:escapeJS(testo_email.descrizione) }</textarea> 
       
       <label>Messaggio Sollecito</label>
       <textarea class="form-control" id="testo_email_sollecito" rows="5" style="width:100%">${utl:escapeJS(testo_email.sollecito) }</textarea>
      	
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_documento_id">
      <a class="btn btn-primary" onclick="salvaTestoEmail()" >Salva</a>
		<a class="btn btn-primary" onclick="$('#modalTestoEmail').modal('hide')" >Annulla</a>
      </div>
    </div>
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



function salvaTestoEmail(){
	
	dataObj = {}
	dataObj.testo = $('#testo_email').val();
	dataObj.referenti = $('#referenti').val();
	dataObj.sollecito = $('#testo_email_sollecito').val();
	
	callAjax(dataObj, "gestioneDevice.do?action=salva_testo_email");
}


function filtraDate(jspDoc){
	

	
		var startDatePicker = $("#datarange").data('daterangepicker').startDate;
	 	var endDatePicker = $("#datarange").data('daterangepicker').endDate;
	 	var company = $('#company').val();
	 	dataString = "action=scadenzario_table&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + 
	 			endDatePicker.format('YYYY-MM-DD')+"&company="+company;
	 	
	 	 pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();

	 	//callAction("gestioneFormazione.do"+ dataString, false,true);

	 	exploreModal("gestioneDevice.do", dataString, '#calendario');
	 	
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
callAction("gestioneDevice.do?action=scadenzario");

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