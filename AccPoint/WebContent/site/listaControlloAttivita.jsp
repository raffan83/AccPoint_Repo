<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Controllo Attività
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Controllo Attività
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">


<div class="col-xs-3">
	 <label for="utente" class="control-label">Operatore:</label>
       <select id="utente" name="utente" class="form-control select2"  data-placeholder="Seleziona Utente..." aria-hidden="true" data-live-search="true" style="width:100%" disabled>
       <option value=""></option>
       
      	<c:forEach items="${lista_utenti}" var="utente">
      	<option value="${utente.id }" selected>${utente.nominativo }</option>
      	</c:forEach>
      
      </select>
</div>

	<div class="col-xs-5">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Ricerca Date:</label>
					<div class="col-md-10 input-group" >
						<div class="input-group-addon">
				             <i class="fa fa-calendar"></i>
				        </div>				                  	
						 <input type="text" class="form-control" id="datarange" name="datarange" value=""/> 						    
							 <span class="input-group-btn">
				              <!--  <button type="button" class="btn btn-info btn-flat" onclick="filtraMisurePerData()">Cerca</button> -->
				               <button type="button" style="margin-left:5px" class="btn btn-primary btn-flat" onclick="resetFiltri()">Reset Filtri</button>
				             </span>				                     
  					</div>  								
			 </div>	
			 
			 

	</div>

<div class="col-xs-1">
<button class="btn btn-info" style="margin-top:25px" onClick="cercaAssegnazioni()" id="cerca_btn" >Cerca</button>
</div>
</div>

<div id="tabella_controllo"></div>


</div>
<input type="hidden" id="date_from" value="">
<input type="hidden" id="date_to" value="">
 
</div>
</div>


</section>






</div>
   <t:dash-footer />
   
  <t:control-sidebar />
</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />

<style>

span.no-show{
    display: none;
}
span.show-ellipsis:after{
    content: "...";
}
</style>

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">




function resetFiltri(){

	$('#utente').val("");
	$('#utente').change();	
	$('input[name="datarange"]').val("");
	 $('#date_from').val('');
	 $('#date_to').val('');
	 
/* 	 var dataString = "action=cerca&dateFrom=&dateTo=&commessa=&utente=&admin=1";
     exploreModal("gestioneAssegnazioneAttivita.do",dataString,"#tabella_controllo", true); */
     
     callAction('gestioneAssegnazioneAttivita.do?action=controllo_attivita',null,true);
}

function formatDate(data){
	
	if(data!=''){
	   var mydate = new Date(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		   str = mydate.toString("yyyy-MM-dd");
	   }
	}else{
		
	}
	   return str;	 		
}

function cercaAssegnazioni(){
	
	var utente = $('#utente').val();
	var startDatePicker =  $('#date_from').val();
	var endDatePicker = $('#date_to').val();
	
	if(startDatePicker!= '' && endDatePicker!=''){
		var startDatePicker = $("#datarange").data('daterangepicker').startDate;
		var endDatePicker = $("#datarange").data('daterangepicker').endDate;

		dataString = "action=cerca_controllo&admin=0&dateFrom=" + formatDate(startDatePicker) + "&dateTo=" + formatDate(endDatePicker)+"&utente="+utente;	
	}else{
		dataString = "action=cerca_controllo&admin=0&utente="+utente;
		
	}
	
	 exploreModal("gestioneAssegnazioneAttivita.do",dataString,"#tabella_controllo");

	
}


$('input[name="datarange"]').on('apply.daterangepicker', function(ev, picker) {
    $(this).val(picker.startDate.format('DD/MM/YYYY') + ' - ' + picker.endDate.format('DD/MM/YYYY'));
    $('#date_from').val(picker.startDate.format('DD/MM/YYYY'));
    $('#date_to').val(picker.endDate.format('DD/MM/YYYY'));
    //$('#cerca_btn').attr('disabled', false);
});

$('input[name="datarange"]').on('cancel.daterangepicker', function(ev, picker) {
    $(this).val('');
    $('#date_from').val("");
    $('#date_to').val("");
     if($('#utente').val()==''){
   		$('#cerca_btn').attr('disabled', true);	
   	}  
    
});


$('#utente').change(function(){
	
	$('#cerca_btn').attr('disabled', false);
	
});

$(document).ready(function() {
 
	
	 $('input[name="datarange"]').daterangepicker({
		   autoUpdateInput: false,
		     locale: {
		      //format: 'DD/MM/YYYY',
		    	  cancelLabel: 'Clear'
		    } 
		});

	 $('.form-datetime').val("");
	
	 
	 
     $('.dropdown-toggle').dropdown();
     $('.select2').select2();     
     
     cercaAssegnazioni();

/*      var dataString = "action=cerca&dateFrom=&dateTo=&commessa=&utente=&admin=1";
     exploreModal("gestioneAssegnazioneAttivita.do",dataString,"#tabella_filtrata"); */

	
});



 
 
  </script>
  
</jsp:attribute> 
</t:layout>

