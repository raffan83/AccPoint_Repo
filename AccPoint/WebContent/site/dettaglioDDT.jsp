<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
        Dettaglio DDT
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
	   <div class="col-xs-6">
	   <c:if test="${pacco.stato_lavorazione.id!=1 }">
<button class="btn btn-danger pull-right" onClick="creaFileDDT('${ddt.numero_ddt}', '${pacco.id}', '${pacco.id_cliente}', '${pacco.id_sede}', '${ddt.id}')">Genera DDT <i class="fa fa-file-pdf-o"></i></button>

</c:if>
<button class="btn btn-primary pull-left" onClick="modificaDDT()">Modifica DDT <i class="fa fa-pencil-square-o"></i></button>
</div></div><br>

<div class="row">
<div class="col-xs-6">


<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati DDT
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body" id="dati_ddt">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${ddt.id}</a>
                </li>
                 <li class="list-group-item">
                  <b>Tipo DDT</b> <a class="pull-right">${ddt.tipo_ddt.descrizione}</a>
                </li>
                <li class="list-group-item">
                  <b>Destinatario</b> <a class="pull-right">${ddt.nome_destinazione}</a>
                </li>
                <li class="list-group-item">
                  <b>Indirizzo Destinazione</b> <a class="pull-right"> ${ddt.indirizzo_destinazione} ${ddt.cap_destinazione} ${ddt.citta_destinazione} ${ddt.provincia_destinazione} ${ddt.paese_destinazione}</a>
                </li>
                <li class="list-group-item">
                  <b>Spedizioniere</b> <a class="pull-right">${ddt.spedizioniere.denominazione}</a>
                </li>
                <li class="list-group-item">
                  <b>Data DDT</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" 
         value="${ddt.data_ddt}" /></a>
                </li>
                <li class="list-group-item">
                  <b>Numero DDT</b> <a class="pull-right">${ddt.numero_ddt} </a>
                </li>
                <li class="list-group-item">
                  <b>Causale</b> <a class="pull-right">${ddt.causale_ddt} </a>
                </li>
                <li class="list-group-item">
                  <b>Tipo Trasporto</b> <a class="pull-right">${ddt.tipo_trasporto.descrizione} </a>
                </li>
                <li class="list-group-item">
                  <b>Tipo Porto</b> <a class="pull-right">${ddt.tipo_porto.descrizione} </a>
                </li>
                <li class="list-group-item">
                  <b>Aspetto</b> <a class="pull-right">${ddt.aspetto.descrizione} </a>
                </li>
                <li class="list-group-item">
                  <b>Annotazioni</b> <a class="pull-right">${ddt.annotazioni} </a>
                </li>
                <li class="list-group-item">
                  <b>Data Trasporto</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" 
         value="${ddt.data_trasporto}" /> <fmt:formatDate pattern="HH:mm:ss" 
         value="${ddt.ora_trasporto}" /></a>
                </li>     
                <li class="list-group-item">
                  <b>Data Arrivo</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" 
         value="${ddt.data_arrivo}" /> </a>
                </li>           
                <li class="list-group-item">
                  <b>Note</b>  <a class="pull-right">${ddt.note} </a> 
                
                </li>
                 <c:if test="${ddt.link_pdf!='' && ddt.link_pdf!=null}"> 
                <li class="list-group-item" id="link">
                
                   <b>Download</b> 
                  <c:url var="url" value="gestioneDDT.do">
  					<c:param name="filename"  value="${pacco.codice_pacco}" />
  					<c:param name="action" value="download" />
  					<c:param name="link_pdf" value="${ddt.link_pdf }"></c:param>
				  </c:url>
                 
<a   class="btn btn-danger customTooltip pull-right  btn-xs"  title="Click per scaricare il DDT"   onClick="callAction('${url}')"><i class="fa fa-file-pdf-o"></i></a>
                     
                </li>
                </c:if>
         
        </ul>

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
       
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

      </div>
    </div>
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
 
 
 
      <form name="ModificaDdtForm" method="post" id="ModificaDdtForm" action="gestioneDDT.do?action=salva" enctype="multipart/form-data">
         <div id="myModalModificaDdt" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" data-backdrop="static">
          
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica DDT</h4>
      </div>
 
       <div class="modal-body" id="myModalDownloadSchedaConsegnaContent">



  <div class="form-group" >

 <div id="collapsed_box" class="box box-danger box-solid collapsed-box" >
<div class="box-header with-border" >
	 DDT
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-plus"></i></button>

	</div>
</div>
<div class="box-body">
	<div class= "col-md-4">
	<ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <label>Numero DDT</label> <a class="pull-center"><input type="text" class="form-control" value="${ddt.numero_ddt}" id="numero_ddt" name="numero_ddt" ></a>
				
				<li class="list-group-item">
	<label>Tipo Trasporto</label><select name="tipo_trasporto" id="tipo_trasporto" data-placeholder="Seleziona Tipo Trasporto" class="form-control select2-drop "  aria-hidden="true" data-live-search="true">
	<option value="${ddt.tipo_trasporto.id }">${ddt.tipo_trasporto.descrizione}</option>
		<c:forEach items="${lista_tipo_trasporto}" var="tipo_trasporto">
		<c:if test="${tipo_trasporto.id != ddt.tipo_trasporto.id }">
			<option value="${tipo_trasporto.id}">${tipo_trasporto.descrizione}</option>
			</c:if>
		</c:forEach>
	</select>
	</li>
	<li class="list-group-item">
	<label>Tipo Porto</label><select name="tipo_porto" id="tipo_porto" data-placeholder="Seleziona Tipo Porto"  class="form-control select2-drop " aria-hidden="true" data-live-search="true">
	<option value="${ddt.tipo_porto.id }">${ddt.tipo_porto.descrizione}</option>
		<c:forEach items="${lista_tipo_porto}" var="tipo_porto">
		<c:if test="${tipo_porto.id != ddt.tipo_porto.id }">
			<option value="${tipo_porto.id}">${tipo_porto.descrizione}</option>
			</c:if>
		</c:forEach>
	</select>
	</li>
	<li class="list-group-item">
	<label>Tipo DDT</label><select name="tipo_ddt" id="tipo_ddt" data-placeholder="Seleziona Tipo DDT" class="form-control "  aria-hidden="true" data-live-search="true">
	<option value="${ddt.tipo_ddt.id }">${ddt.tipo_ddt.descrizione}</option>
		<c:forEach items="${lista_tipo_ddt}" var="tipo_ddt">
		<c:if test="${tipo_ddt.id != ddt.tipo_ddt.id }">
			<option value="${tipo_ddt.id}">${tipo_ddt.descrizione}</option>
			</c:if>
		</c:forEach>
	</select>
	</li>
	
			<li class="list-group-item">
          <label>Data DDT</label>    
      
            <div class='input-group date' id='datepicker_ddt'>
               <input type='text' class="form-control input-small" id="data_ddt" name="data_ddt" value="${ddt.data_ddt }"/>
                <span class="input-group-addon">
                    <span class="fa fa-calendar">
                    </span>
                </span>
           
        </div> 

		</li>
		
						<li class="list-group-item">
          <label>Data Arrivo</label>    
      
            <div class='input-group date' id='datepicker_arrivo'>
               <input type='text' class="form-control input-small" id="data_arrivo" name="data_arrivo" value="${pacco.ddt.data_arrivo }"/>
                <span class="input-group-addon">
                    <span class="fa fa-calendar">
                    </span>
                </span>
        </div> 

		</li>
	<li class="list-group-item">
	<label>Aspetto</label><select name="aspetto" id="aspetto" data-placeholder="Seleziona Tipo Aspetto"  class="form-control select2-drop " aria-hidden="true" data-live-search="true">
	<option value="${ddt.aspetto.id}">${ddt.aspetto.descrizione}</option>
		<c:forEach items="${lista_tipo_aspetto}" var="aspetto">
		<c:if test="${aspetto.id != ddt.aspetto.id }">
			<option value="${aspetto.id}">${aspetto.descrizione}</option>
			</c:if>
		</c:forEach>
	</select>
	</li>
	</ul>
	
	</div>
	
	<div class= "col-md-4">
	<ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <label>Causale</label> <a class="pull-center"><input type="text" class="form-control" value="${ddt.causale_ddt }" id="causale" name="causale" ></a>
                
				</li>
				<li class="list-group-item">
                  <label>Destinatario</label> <a class="pull-center"><input type="text" class="form-control" value="${ddt.nome_destinazione }" id="destinatario" name="destinatario"></a>
				
	</li>
	<li class="list-group-item">
                  <label>Via</label> <a class="pull-center"><input type="text" class="form-control" value="${ddt.indirizzo_destinazione }" id="via" name="via"></a>
				
			
	</li>
	<li class="list-group-item">
                  <label>Città</label> <a class="pull-center"><input type="text" class="form-control" value="${ddt.citta_destinazione}" id="citta" name="citta"></a>
				
				
	</li>
	<li class="list-group-item">
                  <label>CAP</label> <a class="pull-center"><input type="text" class="form-control" value="${ddt.cap_destinazione }" id="cap" name="cap"></a>
				
			
	</li>
	
	<li class="list-group-item">
                  <label>Provincia</label> <a class="pull-center"><input type="text" class="form-control" value="${ddt.provincia_destinazione }" id="provincia" name="provincia"> </a>
				
				
	</li>
	<li class="list-group-item">
                  <label>Paese</label> <a class="pull-center"><input type="text" class="form-control" value="${ddt.paese_destinazione }" id="paese" name="paese"></a>
				
				
	</li>

	</ul>
	
	
	
	</div>
	
	<div class= "col-md-4">
	<ul class="list-group list-group-unbordered">
 		<li class="list-group-item">
          <label>Data e Ora Trasporto</label>    

        <div class="input-group date"  id="datetimepicker" >
                     <input type="text" class="form-control date input-small" id="data_ora_trasporto" value="${ddt.data_trasporto } ${pacco.ddt.ora_trasporto }" name="data_ora_trasporto"/>
            
            <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
        </div>

		</li> 
	

		<li class="list-group-item">
                  <label>Spedizioniere</label> 
				<select name="spedizioniere" id="spedizioniere" data-placeholder="Seleziona Spedizioniere"  class="form-control select2-drop " aria-hidden="true" data-live-search="true">
				<option value="${ddt.spedizioniere.id}">${ddt.spedizioniere.denominazione}</option>
		<c:forEach items="${lista_spedizionieri}" var="spedizioniere">
		<c:if test="${spedizioniere.id != ddt.spedizioniere.id }">
			<option value="${spedizioniere.id}">${spedizioniere.denominazione}</option>
			</c:if>
		</c:forEach>
	</select>
				
				
				
	</li>
	<li class="list-group-item">
                  <label>Annotazioni</label> <a class="pull-center"><input type="text" class="form-control" value="${ddt.annotazioni }" id="annotazioni" name="annotazioni"> </a>
				
				<li class="list-group-item">
	</li>
	
	<li class="list-group-item">
                  <label>Note</label> <a class="pull-center">
				<textarea name="note" form="ModificaDdtForm"  class="form-control" rows=5 cols = 10></textarea></a>
				<li class="list-group-item">
	</li>
	
		
	</ul>

		        <input id="fileupload" type="file" name="file" class="form-control"/>
	
</div>
</div>
</div>
</div>
	


</div>


    
     <div class="modal-footer">


		<input type="hidden" class="pull-right" id="id_ddt" name="id_ddt">
		<input type="hidden" class="pull-right" id ="pdf_path" name="pdf_path" value="${ddt.link_pdf }">
		<p align='center'><button class="btn btn-default " onClick="modificaDdtSubmit()"><i class="glyphicon glyphicon"></i> Modifica DDT</button></p>  
        
    </div>
    </div>
      </div>
    
      </div>

 </form>
  

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

	<link type="text/css" href="css/bootstrap.min.css" />

        <link rel="stylesheet" type="text/css" href="plugins/datetimepicker/bootstrap-datetimepicker.css" /> 
		<link rel="stylesheet" type="text/css" href="plugins/datetimepicker/datetimepicker.css" /> 
</jsp:attribute>



<jsp:attribute name="extra_js_footer">

		 <script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
		 <script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.js"></script> 
<script type="text/javascript" src="http://www.datejs.com/build/date.js"></script>

 <script type="text/javascript">
 

 function modificaDDT(){
	 
	 $('#collapsed_box').removeClass("collapsed-box");
	 $("#myModalModificaDdt").modal();
	 
 }
 
	function modificaDdtSubmit(){
		
		var id_pacco= ${pacco.id};
		var id_ddt = ${pacco.ddt.id};
		
		$('#id_pacco').val(id_pacco);
		$('#id_ddt').val(id_ddt);
		var pdf = $('#pdf_path').val();
		var esito = validateForm();
		if(esito==true){
		document.getElementById("ModificaDdtForm").submit();
		
		
		}
		else{};
	}

	function validateForm() {
	  
	    var numero_ddt = document.forms["ModificaDdtForm"]["numero_ddt"].value;
	   
	    if (numero_ddt=="") {
	      
	        return false;
	    	
	    }else{
	    	return true;
	    }
	}

 	function formatDate(data, container){
	
		   var mydate = new Date(data);
		   
		   if(!isNaN(mydate.getTime())){
		   if(container == '#data_ora_trasporto'){
			 str = mydate.toString("dd/MM/yyyy hh:mm");
		   }else{
			   str = mydate.toString("dd/MM/yyyy");
		   }
	   $(container).val(str );
 	}
	
	}
 
 	
 	
	$("#fileupload").change(function(event){
		
		var fileExtension = 'pdf';
        if ($(this).val().split('.').pop()!= fileExtension) {
        	
        	$('#myModalLabel').html("Attenzione!");
        	$('#myModalError').css("z-index", "1070");
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#modalErrorDiv').html("Inserisci solo pdf!");
			$('#myModalError').modal('show');
        	
			$(this).val("");
        }
		
	});
 

  $("#myModalError").on("hidden.bs.modal", function () {
	  
	  if($('#myModalError').hasClass("modal-success")){
	  location.reload();
  	}
	    
	}); 
    

 function creaFileDDT(numero_ddt, id_pacco, id_cliente, id_sede, id_ddt){
 	
 	creaDDTFile(numero_ddt,id_pacco, id_cliente, id_sede, id_ddt);
 	
 }
 
 
 $(document).ready(function() {
	 
	  var data_ora_trasporto = $('#data_ora_trasporto').val()
	   var data_ddt = $('#data_ddt').val();
	  var data_arrivo = $('#data_arrivo').val();
	  
	 
	 formatDate(data_ora_trasporto, '#data_ora_trasporto');
	   
	   formatDate(data_ddt, '#data_ddt');
	   formatDate(data_arrivo, '#data_arrivo');
	 
	 	 $('#datetimepicker').datetimepicker({
			format : "dd/mm/yyyy hh:ii"
		});  

		
		$('#datepicker_ddt').datepicker({
			format : "dd/mm/yyyy"
		});
		$('#datepicker_arrivo').datepicker({
			format : "dd/mm/yyyy"
		});
 
		
 });
  </script>
  
</jsp:attribute> 
</t:layout>


 
 






