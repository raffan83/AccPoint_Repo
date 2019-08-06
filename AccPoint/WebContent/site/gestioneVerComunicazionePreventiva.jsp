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
        Comunicazione Preventiva       
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
          
          
 <div class="row">
       <div class="col-xs-6">
       <select id="cliente" name="cliente" class="form-control select2"  data-placeholder="Seleziona Cliente..." aria-hidden="true" data-live-search="true" style="width:100%">
       <option value=""></option>
      	<c:forEach items="${lista_clienti}" var="cl">
      	<option value="${cl.__id }">${cl.nome }</option>
      	</c:forEach>
      
      </select>
      </div>
      <div class="col-xs-6">
       <select id="sede" name="sede" class="form-control select2"  data-placeholder="Seleziona Sede..." aria-hidden="true" data-live-search="true" style="width:100%" disabled>
       <option value=""></option>
      	<c:forEach items="${lista_sedi}" var="sd">
      	<option value="${sd.__id}_${sd.id__cliente_}">${sd.descrizione} - ${sd.indirizzo} - ${sd.comune} (${sd.siglaProvincia}) </option>
      	</c:forEach>
      
      </select>
      </div>
       </div>
      

          </div>
            <div class="box-body">

<div class="row">
	<div class="col-xs-12">
	
	 <div id="boxStrumenti" class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Strumenti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
		<div id="posTab">LISTA VUOTA</div>
</div>
</div>



	 <div id="boxLista" class="box box-danger box-solid">
<div class="box-header with-border">
	 Strumenti selezionati
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
		<div id="posTabSelezionati">NESSUNO STRUMENTO SELEZIONATO</div>
</div>
</div>

<div class="row">
<div class="col-xs-12">
<a class="btn btn-primary pull-right" onClick="inviaID()">Salva</a>
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

function inviaID(){

    var row =  document.getElementById('posTabSelezionati').children;
    
    var string = "";
    
    for(var i = 0;i<row.length;i++){
    	var id = row[i].id.split("_")[1];
    	var esito = true;
    	$('#data_'+id).css('border', '1px solid #d2d6de');
    	$('#ora_'+id).css('border', '1px solid #d2d6de');	
    	if($('#data_'+id).val()==''){
    		$('#data_'+id).css('border', '1px solid #f00');
    		esito = false;
    	}
    	if($('#ora_'+id).val()==''){
    		$('#ora_'+id).css('border', '1px solid #f00');
    		esito = false;
    	}
    }
    if(esito){
    	for(var i = 0;i<row.length;i++){
    		var id = row[i].id.split("_")[1];
			string = string + $('#id_'+id).val() + "_"+ $('#data_'+id).val() + "_" +$('#ora_'+id).val()+";"
    	}
		
		callAction('gestioneVerComunicazionePreventiva.do?action=salva&ids='+string);
	}
    
}
  
  
function validateStrumentias(){
	 var esito = false;
	 
	 if($('#n_pezzi').val()==""){
		 $('#n_pezzi').css('border', '1px solid #f00');
		 esito=false;
	 }else{
		 $('#n_pezzi').css('border', '1px solid #d2d6de');	
		 esito = true;
	 }
	 
	 if(esito){
		 salvaImpronta();
	 }

}
  
  $("#cliente").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#sede option').clone());
	  }
	  
	  
	  var selection = $(this).val()	 
	  var id = selection
	  var options = $(this).data('options');

	  var opt=[];
	
	  opt.push("<option value = 0 selected>Non Associate</option>");

	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 
	
		//if(str.substring(str.indexOf("_")+1,str.length)==id)
		if(str.substring(str.indexOf("_")+1, str.length)==id)
		{

			opt.push(options[i]);
		}   
	   }
	 $("#sede").prop("disabled", false);
	 
	  $('#sede').html(opt);
	  
	  $("#sede").trigger("chosen:updated");
	  

		$("#sede").change();  
		
		  var id_cliente = selection.split("_")[0];
		  

		  var opt=[];
			opt.push("");
		   for(var  i=0; i<options.length;i++)
		   {
			   if(str!='' && str.split("_")[1]==id)
				{
					opt.push(options[i]);
				}   
		   } 
		   
		/*    dataString = "action=lista&id_cliente="+$(this).val()+"&id_sede="+$('#sede').val();
		   exploreModal('gestioneVerStrumenti.do',dataString,'#posTab'); */

	});
  
  
  $('#sede').change(function(){
	  
	  dataString = "action=lista_strumenti&id_cliente="+$('#cliente').val()+"&id_sede="+$(this).val();
	   exploreModal('gestioneVerComunicazionePreventiva.do',dataString,'#posTab');
  });
  
  
    
    $(document).ready(function() {
    	
    	$('.select2').select2();
    });
    


    
  </script>
</jsp:attribute> 
</t:layout>

 
 