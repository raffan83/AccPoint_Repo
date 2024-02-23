<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@page import="java.util.Date"%>
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
        Lista Interventi Rilievi Dimensionali
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
	 Lista Interventi Rilievi Dimensionali
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-md-5">
<label>Cliente</label>

<select class="form-control select2" data-placeholder="Seleziona Cliente..."  aria-hidden="true" data-live-search="true" style="width:100%; display:none" id="cliente_appoggio" name="cliente_appoggio">
	       		<option value=""></option>
	       		<option value="0">TUTTI</option>
       			<c:forEach items="${lista_clienti }" var="cliente" varStatus="loop">
       			       				   			
       				<option value="${cliente.__id}">${cliente.nome }</option>       				
       			
       			</c:forEach>
</select>
<input class="form-control"  style="width:100%" id="cliente" name="cliente" >

</div>


<div class="col-md-5">
<label>Stato</label>


<select class="form-control select2" data-placeholder="Seleziona Stato..."  aria-hidden="true" data-live-search="true" style="width:100%" id="filtro_stato" name="filtro_stato">
	<option value=""></option>

	<option value="0">TUTTI</option>
	<option value="1">APERTI</option>
	<option value="2">CHIUSI</option> 
	
	
	
</select>


</div>


</div><br>


<div id="lista_interventi_rilievi"></div>

</div>
</div>

 
</div>
</div>


<form id="formAllegati" name="formAllegati">
  <div id="myModalAllegati" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-xs-12">
         
       <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un file...</span>

		        <input id="fileupload_pdf" accept=".pdf,.PDF"  type="file" name="fileupload_pdf" class="form-control"/>
		   	 </span>
		   	 <label id="filename_label"></label>
		   	 <input type="hidden" id="id_rilievo" name="id_rilievo">
		   	 
		   	 <br>
       </div>

  		 </div>
  		 </div>
      <div class="modal-footer">

      <a class="btn btn-primary" onClick="validateAllegati()">Salva</a> 
     
      </div>
   
  </div>
  </div>
</div>
</form>

<form id="formAllegatiImg" name="formAllegatiImg">
  <div id="myModalAllegatiImg" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Immagine Frontespizio</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-xs-12">
         
       <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un file...</span>

		        <input id="fileupload_img" accept=".jpg,.gif,.jpeg,.tiff,.png" type="file" name="fileupload_pimg" class="form-control"/>
		   	 </span>
		   	 <label id="filename_label_img"></label>
		   	 <input type="hidden" id="id_rilievo" name="id_rilievo">
		   	 <br>
       </div>

  		 </div>
  		 </div>
      <div class="modal-footer">

      <a class="btn btn-primary" onClick="validateAllegatiImg()">Salva</a>
      </div>
   
  </div>
  </div>
</div>
</form>




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


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>
<script src="plugins/fileSaver/FileSaver.min.js"></script>
<script type="text/javascript">
 

     $(document).ready(function() {

    	 initSelect2('#cliente');
    	$('#filtro_stato').select2();
 
     });
     
     
/*      $(window).on('beforeunload', function() {
    	 document.getElementById("cliente_filtro").selectedIndex = -1;
    	 document.getElementById("filtro_stato").selectedIndex = -1;
    	});  
      */
     
     $('.dropdown-toggle').dropdown();
     

 

	
	

	
 $('#filtro_stato').change(function(){
	
	 var stato_lavorazione = $('#filtro_stato').val();	 
	 var cliente_filtro = $('#cliente').val();
	
	 if(cliente_filtro!=null && cliente_filtro!=''){
		 dataString ="action=filtra_interventi_rilievi&stato="+ stato_lavorazione+"&id_cliente="+cliente_filtro;
	       exploreModal("listaRilieviDimensionali.do",dataString,"#lista_interventi_rilievi",function(datab,textStatusb){
	       });
	 }

	 
 });
 
 
 $('#cliente').change(function(){
		
	 var stato_lavorazione = $('#filtro_stato').val();	 
	 var cliente_filtro = $('#cliente').val();
	
	 if(stato_lavorazione!=null && stato_lavorazione!=''){
		 dataString ="action=filtra_interventi_rilievi&stato="+ stato_lavorazione+"&id_cliente="+cliente_filtro;
	       exploreModal("listaRilieviDimensionali.do",dataString,"#lista_interventi_rilievi",function(datab,textStatusb){
	       });
	 }

	 
 });
 
 

 

 
 var options =  $('#cliente_appoggio option').clone();
 function mockData() {
 	  return _.map(options, function(i) {		  
 	    return {
 	      id: i.value,
 	      text: i.text,
 	    };
 	  });
 	}
 
 
 
 function initSelect2(id_input, placeholder) {
	  if(placeholder==null){
		  placeholder = "Seleziona Cliente...";
	  }

 	$(id_input).select2({
 	    data: mockData(),
 	    placeholder: placeholder,
 	    multiple: false,
 	    // query with pagination
 	    query: function(q) {
 	      var pageSize,
 	        results,
 	        that = this;
 	      pageSize = 20; // or whatever pagesize
 	      results = [];
 	      if (q.term && q.term !== '') {
 	        // HEADS UP; for the _.filter function i use underscore (actually lo-dash) here
 	        results = _.filter(x, function(e) {
 	        	
 	          return e.text.toUpperCase().indexOf(q.term.toUpperCase()) >= 0;
 	        });
 	      } else if (q.term === '') {
 	        results = that.data;
 	      }
 	      q.callback({
 	        results: results.slice((q.page - 1) * pageSize, q.page * pageSize),
 	        more: results.length >= q.page * pageSize,
 	      });
 	    },
 	  });
 	  	
 }
 
 
 
 
  </script>
  
</jsp:attribute> 
</t:layout>


 
 






