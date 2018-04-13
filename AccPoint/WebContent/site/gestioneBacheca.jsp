<%@page import="it.portaleSTI.bo.GestioneTrendBO"%>
<%@page import="it.portaleSTI.DTO.TipoTrendDTO"%>
<%@page import="it.portaleSTI.DTO.TrendDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.CompanyDTO"%>
<%@ page language="java" import="java.util.ArrayList" %>
 <%@page import="com.google.gson.Gson"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

<%

%>

<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
     
     
     <section class="content-header">
      <h1>
        Bacheca
        <small></small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
       </ol>
    </section>
     	 <section class="content">
			<div class="row">
<div class="col-xs-12">
	<div class="box box-danger box-solid">
      <div class="box-header with-border">
	    <h3 class="box-title">Bacheca</h3>
       <div class="box-tools pull-right">
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>  </button>
	         <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
   </div>
  </div>
   <div class="box-body">
   <div class="form-group">
   <button class="btn btn-primary pull-right" id="invia_button" onClick="inviaMessaggio()" disabled>Invia</button>
   </div>
        <div class="form-group">
                  <label>Company</label>
                  <select name="select1" id="select1" data-placeholder="Seleziona Company..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" >
                  <option value=""></option>
                      <c:forEach items="${lista_company}" var="company">
                           <option value="${company.id}">${company.denominazione}</option> 
                     </c:forEach>        
                  </select>
        </div> 
         <label>Destinatario</label>
                <div class="form-group">
                   <select name="select2" id="select2" data-placeholder="Seleziona Destinatario..."  class="form-control select2" multiple aria-hidden="true" data-live-search="true" style="width:100%"  > 
                      <c:forEach items="${lista_destinatari}" var="destinatario">
                           <option value="${destinatario.company.id}_${destinatario.id}__${destinatario.nominativo}">${destinatario.nominativo}</option> 
                     </c:forEach>
                  </select>

        </div> 
        <label>Titolo</label>
                <div class="form-group">
					<input class="form-control" type="text" id="titolo" style="width:100%"><br>
      		</div>
      		
        <label>Testo</label>
                <div class="form-group">
					<textarea id="testo" name="testo" rows="15" cols="80" class="form-control"></textarea>
                 </div>   
        </div> 
        
        
        
 <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index:1070">
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
   
        
   </div>
   </div>
 <!-- /.box-body -->
 
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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/css/bootstrap-select.min.css">

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/js/bootstrap-select.min.js"></script>
 <!-- <script type="text/javascript" src="plugins/selectpicker/bootstrap-select.js"></script> --> 

<script type="text/javascript">



$(document).ready(function() {

	 $(".select2").select2();
	 
	 $('.selectpicker').selectpicker(); 
	$("#select2").select2({
		closeOnSelect: false
	})
	
	var id_company = $("#select1").val();
	
	if(id_company == "0" || id_company ==""){
		
		$("#select2").prop("disabled", true);
		
	}
	

});

 	$('#select2').on('change', function(){

 		var options = $('#select2').val();
 		
 		
 		if(options!=null && options.length>1 && options[0]=="0"){
 			$('#select2').val(options[0]);
 		}
 			
		$("#invia_button").prop("disabled", false);
		});   


var idCliente = ${userObj.idCliente}
var idSede = ${userObj.idSede}

$body = $("body");


$("#select1").change(function() {

  if ($(this).data('options') == undefined) 
  {
    /*Taking an array of all options-2 and kind of embedding it on the select1*/
     $(this).data('options', $('#select2 option').clone());
  }
  
  var selection = $(this).val()
 
  var id = selection;
  
  var options = $(this).data('options');

  var opt=[];

  opt.push("<option value = 0>Tutti</option>");

   for(var  i=0; i<options.length;i++)
   {
	var str=options[i].value; 
	var x = str.substring(0,str.indexOf("_"));
	if(str.substring(0,str.indexOf("_"))==id){
			
		opt.push(options[i]);
	}   
   }
 $("#select2").prop("disabled", false);
 
  $('#select2').html(opt);
  
  $("#select2").trigger("chosen:updated");
  
  //if(opt.length<2 )
  //{ 
	//$("#select2").change();  
  //} 
  

});		 
    
</script>
</jsp:attribute> 
</t:layout>


