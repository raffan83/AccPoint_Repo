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
        Nuovo Intervento
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
       <a class="btn btn-default pull-right" onClick="callAction('gestioneVerIntervento.do?action=lista',null,true);" style="margin-right:5px"><i class="fa fa-dashboard"></i> Torna alla lista interventi</a>
    </section>
    <div style="clear: both;"></div>    
  <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">
          
          
 <div class="row">
  <div class="col-md-6" style="display:none">  
                  <label>Cliente</label>
               <select name="cliente_appoggio" id="cliente_appoggio" class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
                
                      <c:forEach items="${lista_clienti}" var="cliente">
                     
                           <option value="${cliente.__id}">${cliente.nome}</option> 
                         
                     </c:forEach>

                  </select> 
                
        </div> 
       <div class="col-xs-6">
       <label>Cliente</label>
        <input id="cliente" name="cliente" class="form-control" style="width:100%">
      <%--  <select id="cliente" name="cliente" class="form-control select2"  data-placeholder="Seleziona Cliente..." aria-hidden="true" data-live-search="true" style="width:100%">
       <option value=""></option>
      	<c:forEach items="${lista_clienti}" var="cl">
      	<option value="${cl.__id }">${cl.nome }</option>
      	</c:forEach>
      
      </select> --%>
      </div>
      <div class="col-xs-6">
      <label>Sede</label>
       <select id="sede" name="sede" class="form-control select2"  data-placeholder="Seleziona Sede..." aria-hidden="true" data-live-search="true" style="width:100%" disabled>
       <option value=""></option>
      	<c:forEach items="${lista_sedi}" var="sd">
      	<option value="${sd.__id}_${sd.id__cliente_}">${sd.descrizione} - ${sd.indirizzo} - ${sd.comune} (${sd.siglaProvincia}) </option>
      	</c:forEach>
      
      </select>
      </div>
       </div><br>
      
   <div class="row">
       <div class="col-xs-6">
       <label>Commessa</label>
      <select class="form-control select2" data-placeholder="Seleziona Commessa..." id="commessa" name="commessa" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_commesse}" var="commessa" varStatus="loop">
       				<option value="${commessa.ID_COMMESSA}*${commessa.ID_ANAGEN}*${commessa.ID_ANAGEN_UTIL}">${commessa.ID_COMMESSA}</option>
       			</c:forEach>
       		</select>
      </div>
      <%--  <div class="col-xs-4">
        <label>Tecnico Riparatore</label>
      <select class="form-control select2" data-placeholder="Seleziona Tecnico Riparatore..." id="tecnico_riparatore" name="tecnico_riparatore" style="width:100%" >
       		<option value=""></option>
       			<c:forEach items="${lista_tecnici}" var="tecnico" varStatus="loop">
       				<option value="${tecnico.id}">${tecnico.nominativo}</option>
       			</c:forEach>
       		</select>
      </div> --%>
      
      <div class="col-xs-6">
       <label>Tecnico Verificatore</label>
      <select class="form-control select2" data-placeholder="Seleziona Tecnico Verificatore..." id="tecnico_verificatore" name="tecnico_verificatore" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_tecnici}" var="tecnico" varStatus="loop">
       				<option value="${tecnico.id}">${tecnico.nominativo}</option>
       			</c:forEach>
       		</select>
      
      
       </div>    
      
 </div><br>
      
        <div class="row">
        <!-- <div class="col-xs-1">
        </div> -->
        <div class="col-xs-6">
       <label>Data Prevista</label>
      <div class='input-group date datepicker' id='datepicker_data_prevista'>
               <input type='text' class="form-control input-small" id="data_prevista" name="data_prevista" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div>  
      </div>
      
      <!-- <div class="col-xs-1">
        </div> -->
      <div class="col-xs-6">
     <label>Luogo</label>
     <select id="luogo" name="luogo" class="form-control select2" style="width:100%">
				  <option value=0>In Sede</option>
				  <option value=1>Presso il Cliente</option>		
				  <option value=2>Altro Luogo</option>		  
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
	
	<link type="text/css" href="css/bootstrap.min.css" />

</jsp:attribute>

<jsp:attribute name="extra_js_footer">

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
 <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/lodash@4.17.11/lodash.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/js/bootstrap-timepicker.js"></script> 
 <script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script src="plugins/iCheck/icheck.js"></script>
  <script src="plugins/iCheck/icheck.min.js"></script> 
  <script type="text/javascript">

function inviaID(){

    var row =  document.getElementById('posTabSelezionati').children;
    
    var string = "";
    var esito = true;
    
    var id_cliente = $('#cliente').val();
    var id_sede = $('#sede').val();
    var commessa = $('#commessa').val();
    var tecnico_verificatore = $('#tecnico_verificatore').val();
    var data_prevista = $('#data_prevista').val();
    var luogo = $('#luogo').val();
    
    $('#cliente').siblings(".select2-container").css('border', '0px solid #d2d6de');
    $('#sede').siblings(".select2-container").css('border', '0px solid #d2d6de');
    $('#commessa').siblings(".select2-container").css('border', '0px solid #d2d6de');
    $('#tecnico_verificatore').siblings(".select2-container").css('border', '0px solid #d2d6de');
    $('#data_prevista').css('border', '1px solid #d2d6de');	
    $('#luogo').siblings(".select2-container").css('border', '0px solid #d2d6de');
    
    
    if(id_cliente==null || id_cliente==''){
    	$('#cliente').siblings(".select2-container").css('border', '1px solid #f00');    
		esito = false;
    }
	if(id_sede==null || id_sede==''){
		$('#sede').siblings(".select2-container").css('border', '1px solid #f00');    
		esito = false;
    }
	if(commessa==null || commessa==''){
		$('#commessa').siblings(".select2-container").css('border', '1px solid #f00');    
		esito = false;
    }
	if(tecnico_verificatore==null || tecnico_verificatore==''){
		$('#tecnico_verificatore').siblings(".select2-container").css('border', '1px solid #f00');    
		esito = false;
    }
	if(data_prevista==null || data_prevista==''){
		$('#data_prevista').css('border', '1px solid #f00');	
    }
	if(luogo==null || luogo==''){
		$('#luogo').siblings(".select2-container").css('border', '1px solid #f00');    
		esito = false;
    }
	
    for(var i = 0;i<row.length;i++){
    	var id = row[i].id.split("_")[1];    	
    	
    	$('#ora_'+id).css('border', '1px solid #d2d6de');
    	$('#via_'+id).css('border', '1px solid #d2d6de');	
    	$('#civico_'+id).css('border', '1px solid #d2d6de');	
    	$('#comune_'+id).siblings(".select2-container").css('border', '0px solid #d2d6de');	
    	
    	if($('#ora_'+id).val()==''){
    		$('#ora_'+id).css('border', '1px solid #f00');
    		esito = false;
    	}
    	if($('#via_'+id).val()==''){
    		$('#via_'+id).css('border', '1px solid #f00');
    		esito = false;
    	}
    	if($('#civico_'+id).val()==''){
    		$('#civico_'+id).css('border', '1px solid #f00');
    		esito = false;
    	}
    	if($('#comune_'+id).val()==''){
    		$('#comune_'+id).siblings(".select2-container").css('border', '1px solid #f00');
    		esito = false;
    	}
    }
    if(esito){
    	for(var i = 0;i<row.length;i++){
    		var id = row[i].id.split("_")[1];			
			var ora = $('#ora_'+id).val();
			
			if(ora!='' && ora.length<5){
				ora = "0"+ora;
			}
			if(luogo!="2"){
				string = string + $('#id_'+id).val() + "_" +ora+";"	;
			}else{
				string = string + $('#id_'+id).val() + "_" + ora + "_" + $('#via_'+id).val() + "_" + $('#civico_'+id).val() + "_" + $('#comune_'+id).val() +";";
			}
    		
    		
    	}		
		
    	salvaComunicazionePreventiva(string, id_cliente, id_sede, commessa, tecnico_verificatore, data_prevista, luogo);
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
		   
		   
		   var options = commessa_options;
			  var opt=[];
				opt.push("");
			   for(var  i=0; i<options.length;i++)
			   {
				var str=options[i].value; 		
				
				if(str.split("*")[1] == id_cliente||str.split("*")[2]==id_cliente)	
				{

					opt.push(options[i]);
				}   
		    
			   } 
			$('#commessa').html(opt);
			$('#commessa').val("");
			$("#commessa").change();
		   
		/*    dataString = "action=lista&id_cliente="+$(this).val()+"&id_sede="+$('#sede').val();
		   exploreModal('gestioneVerStrumenti.do',dataString,'#posTab'); */

	});
  
  
  $('#sede').change(function(){
	  
	  dataString = "action=lista_strumenti&id_cliente="+$('#cliente').val()+"&id_sede="+$(this).val();
	   exploreModal('gestioneVerComunicazionePreventiva.do',dataString,'#posTab');
  });
  
  
  var commessa_options;    
    $(document).ready(function() {
    	$('.datepicker').datepicker({
   		 format: "dd/mm/yyyy"
   	 }); 
    	$('.dropdown-toggle').dropdown();
    	initSelect2('#cliente');
    	$('#sede').select2();
    	$('#commessa').select2();
    	$('#tecnico_verificatore').select2();
    	$('#luogo').select2();
    	
    	
    	commessa_options = $('#commessa option').clone();
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

 
 