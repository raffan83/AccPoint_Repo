<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
        Lista Strumenti
        <small>Elenco Strumenti Portale</small>
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
  <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
       
          <div class="box">
          <div class="box-header">
             <c:if test="${userObj.idCliente == 0}">  
             
<!--                        	 <div class="box box-danger box-solid">
          	 
<div class="box-header with-border">
	 Filtra Strumenti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

          <div class="row">            
              <div class="form-group">
                <div class="col-xs-4">
            <label>ID</label>
            <input class="form-control" type="text" id="filtro_id_str" name="filtro_id_str">
            </div>
             <div class="col-xs-2">
            <label>Nome Strumento</label>
            <input class="form-control" type="text" id="filtro_denominazione_str" name="filtro_denominazione_str">
            </div>
            <div class="col-xs-2">
            <label>Marca</label>            
            <input class="form-control" type="text" id="filtro_marca_str" name="filtro_marca_str">
            </div>
            <div class="col-xs-2">
            <label>Modello</label>            
            <input class="form-control" type="text" id="filtro_modello_str" name="filtro_modello_str">
            </div> 
            <div class="col-xs-4">
            <label>Matricola</label>            
            <input class="form-control" type="text" id="filtro_matricola_str" name="filtro_matricola_str">
            </div>
            <div class="col-xs-4">
            <label>Cod. Interno</label>            
            <input class="form-control" type="text" id="filtro_codice_interno_str" name="filtro_codice_interno_str">
            </div>
			</div>
           </div><br>
            <div class="row" >        
           <div class="col-xs-12">
            <span class="pull-right">
            <button class="btn btn-info" onClick="filtraStrumentiGenerale()">Filtra</button>
            <button class="btn btn-primary" onClick="resetFiltriGenerale()">Reset</button>
            </span>  
            </div>
            </div>  
          
       
          </div>
  
     
   
      </div>  -->  
       
       
             
             
             
             
             
          	 <div class="box box-danger box-solid">
          	 
<div class="box-header with-border">
	 Filtra Strumenti con misura
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

          <div class="row">            
              <div class="form-group">
             <div class="col-xs-2">
            <label>Nome Strumento</label>
            <input class="form-control" type="text" id="filtro_denominazione" name="filtro_denominazione">
            </div>
            <div class="col-xs-2">
            <label>Marca</label>            
            <input class="form-control" type="text" id="filtro_marca" name="filtro_marca">
            </div>
            <div class="col-xs-2">
            <label>Modello</label>            
            <input class="form-control" type="text" id="filtro_modello" name="filtro_modello">
            </div> 
            <div class="col-xs-2">
            <label>Matricola</label>            
            <input class="form-control" type="text" id="filtro_matricola" name="filtro_matricola">
            </div>
            <div class="col-xs-2">
            <label>Cod. Interno</label>            
            <input class="form-control" type="text" id="filtro_codice_interno" name="filtro_codice_interno">
            </div>
            <div class="col-xs-2">
         
            <span class="pull-right"  style="margin-bottom:16px; margin-top:24px">
            <button class="btn btn-info" onClick="filtra()">Filtra</button>
            <button class="btn btn-primary" onClick="resetFiltri()">Reset</button>
            </span>  
           
            </div>  
          
       
          
          </div>
     
       </div>   
       
       </div>
       </div>
       
            
 
       </c:if>  
          
                        <div class="row">
        <div class="col-xs-6">


    <div class="form-group">
    
    	                  <select name="cliente_appoggio" id="cliente_appoggio"  class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%;display:none" >
							<c:if test="${userObj.idCliente != 0}">
                  
                      <c:forEach items="${listaClienti}" var="cliente">
                       <c:if test="${userObj.idCliente == cliente.__id}">
                           <option value="${utl:encryptData(cliente.__id)}">${cliente.nome}</option> 
                        </c:if>
                     </c:forEach>
                  
                  
                  </c:if>
                 
                  <c:if test="${userObj.idCliente == 0}">
                  <option value=""></option>
                      <c:forEach items="${listaClienti}" var="cliente">
                           <option value="${utl:encryptData(cliente.__id)}">${cliente.nome} </option> 
                     </c:forEach>
                  
                  
                  </c:if>
	         
	                  </select>
    
                  <label>Cliente</label>
                  <c:if test="${userObj.idCliente != 0}">
                  <input  name="select1" id="select1"  class="form-control" style="width:100%" value="${utl:encryptData(userObj.idCliente) }">
                  </c:if>
                  <c:if test="${userObj.idCliente == 0 }">
                  <input  name="select1" id="select1"  class="form-control" style="width:100%" >
                  </c:if>
                  
                 <%--  <select name="select1" id="select1" data-placeholder="Seleziona Cliente..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%">
                  <c:if test="${userObj.idCliente != 0}">
                  
                      <c:forEach items="${listaClienti}" var="cliente">
                       <c:if test="${userObj.idCliente == cliente.__id}">
                           <option value="${cliente.__id}">${cliente.nome}</option> 
                        </c:if>
                     </c:forEach>
                  
                  
                  </c:if>
                 
                  <c:if test="${userObj.idCliente == 0}">
                  <option value=""></option>
                      <c:forEach items="${listaClienti}" var="cliente">
                           <option value="${cliente.__id}">${cliente.nome} </option> 
                     </c:forEach>
                  
                  
                  </c:if>
                    
                  </select> --%>
        </div>

  </div>
    <div class="col-xs-6"> 


     <div class="form-group">
                  <label>Sede </label>
                  <select name="select2" id="select2" data-placeholder="Seleziona Sede..."  disabled class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%">
                   <c:if test="${userObj.idSede != 0}">
                   
             			<c:forEach items="${listaSedi}" var="sedi">
             			  <c:if test="${userObj.idSede == sedi.__id}">             			  
                          	  <option value="${utl:encryptData(sedi.__id)}_${utl:encryptData(sedi.id__cliente_)}">${sedi.descrizione} - ${sedi.indirizzo} - ${sedi.comune} (${sedi.siglaProvincia}) </option>      
                          </c:if>                       
                     	</c:forEach>
                     </c:if>
                     
                     <c:if test="${userObj.idSede == 0}">
                    	<option value=""></option>
             			<c:forEach items="${listaSedi}" var="sedi">
             			 	<c:if test="${userObj.idCliente != 0}">             			 	
             			 		<c:if test="${userObj.idCliente == sedi.id__cliente_}">
                          	 		<option value="${utl:encryptData(sedi.__id)}_${utl:encryptData(sedi.id__cliente_)}">${sedi.descrizione} - ${sedi.indirizzo} - ${sedi.comune} (${sedi.siglaProvincia})</option>       
                          	 	</c:if>      
                          	</c:if>     
                          	<c:if test="${userObj.idCliente == 0}">
                           	 		<option value="${utl:encryptData(sedi.__id)}_${utl:encryptData(sedi.id__cliente_)}">${sedi.descrizione} - ${sedi.indirizzo} - ${sedi.comune} (${sedi.siglaProvincia})</option>       
                           	</c:if>                  
                     	</c:forEach>
                     </c:if>
                  </select>
                  
        </div>

  
</div>
</div>
<div class="row">
        <div class="col-xs-12">    
<c:if test="${!userObj.checkRuolo('CL')}">
		
      
        <button class="btn btn-info" onclick="spd()">Scarica Pacchetto Dati</button> 

       


</c:if>		

        <c:if test="${userObj.checkPermesso('NUOVO_STRUMENTO_METROLOGIA')}"> 

<button class="btn btn-primary pull-right" onClick="nuovoStrumentoGeneral()">Nuovo Strumento</button>
<div id="errorMsg" ></div>
</c:if> 
        </div>
</div>
          </div>
            <div class="box-body">

<div class="row">
	<div class="col-xs-12">
	
	 <div id="boxLista" class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
		<div id="posTab">LISTA VUOTA</div>
</div>
</div>
</div>
</div>

<div class="row">
	<div class="col-xs-12">
	
	 <div id="boxLista" class="box box-info box-solid collapsed-box boxgrafici" >
<div class="box-header with-border">
	 Grafici
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-plus"></i></button>

	</div>
</div>
<div class="box-body">
		<div id="grafici">
			<div class="row">
			<div class="box box-info box-solid">
			<div class="box-header with-border" style="text-align:center">Strumenti in servizio</div>
				<div class="col-xs-12 grafico1">
				
					<canvas id="grafico1"></canvas>
				</div>
				
				</div>
				<div class="box box-info box-solid">
			<div class="box-header with-border" style="text-align:center">Strumenti per tipologia</div>
				<div class="col-xs-12 grafico2" >
					<canvas id="grafico2"></canvas>
				</div>
				</div>
				<div class="box box-info box-solid">
			<div class="box-header with-border" style="text-align:center">Strumenti per denominazione</div>
				<div class="col-xs-12 grafico3">
					<canvas id="grafico3"></canvas>
				</div>
				</div>
				<div class="box box-info box-solid">
			<div class="box-header with-border" style="text-align:center">Strumenti per frequenza</div>
				<div class="col-xs-12 grafico4">
					<canvas id="grafico4"></canvas>
				</div>
				</div>
				<div class="box box-info box-solid">
			<div class="box-header with-border" style="text-align:center">Strumenti per reparto</div>
				<div class="col-xs-12 grafico5">
					<canvas id="grafico5"></canvas>
				</div>
				</div>
				<div class="box box-info box-solid">
			<div class="box-header with-border" style="text-align:center">Strumenti per utilizzatore</div>
				<div class="col-xs-12 grafico6">
					<canvas id="grafico6"></canvas>
				</div>
				</div>
			</div>
		</div>
</div>
</div>
</div>
</div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
       
        <!-- /.col -->
 
</div>
</div>


<div id="modalNuovoStrumentoGeneral" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Strumento</h4>
      </div>
       <div class="modal-body">
       
       <div id="content_nuovo_strumento"></div>
         		
  		 </div>
      <div class="modal-footer">

      </div>
    </div>
    
    </div>
    </div>



  <div id="myModal" class="modal fade modal-fullscreen" role="dialog" aria-labelledby="myLargeModalLabel">
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
       <!--        <li class=""><a href="#prenotazione" data-toggle="tab" aria-expanded="false" onclick="" id="prenotazioneTab">Stato Prenotazione</a></li> -->
        
 		<c:if test="${userObj.checkPermesso('MODIFICA_STRUMENTO_METROLOGIA')}">
               <li class=""><a href="#modifica" data-toggle="tab" aria-expanded="false" onclick="" id="modificaTab">Modifica Strumento</a></li>
		</c:if>		
		 <li class=""><a href="#documentiesterni" data-toggle="tab" aria-expanded="false" onclick="" id="documentiesterniTab">Documenti esterni</a></li>
		 
		 <li class=""><a href="#notestrumento" data-toggle="tab" aria-expanded="false" onclick="" id="noteStrumentoTab">Note Strumento</a></li>
             </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="dettaglio">

    			</div> 

              <!-- /.tab-pane -->
             
			  <div class="tab-pane" id="misure">
                

         
			 </div> 


              <!-- /.tab-pane -->


               		<c:if test="${userObj.checkPermesso('MODIFICA_STRUMENTO_METROLOGIA')}">
              
              			<div class="tab-pane" id="modifica">
              

              			</div> 
              		</c:if>		
              		
              		<div class="tab-pane" id="documentiesterni">
              

              			</div> 
              			
              			
              			   		<div class="tab-pane" id="notestrumento">
              			   		

              			</div> 
              			
              			
              
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




<div id="modalEliminaDocumentoEsternoStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="">
		     
			<input class="form-control" id="idElimina" name="idElimina" value="" type="hidden" />
		
			Sei Sicuro di voler eliminare il documento?
        
        
  		 </div>
      
    </div>
    <div class="modal-footer">
    	<button type="button" class="btn btn-default pull-left" data-dismiss="modal">Annulla</button>
    	<button type="button" class="btn btn-danger" onClick="eliminaDocumentoEsternoStrumento()">Elimina</button>
    </div>
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


</jsp:attribute>

<jsp:attribute name="extra_js_footer">

 <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.js"></script>
  <script type="text/javascript" src="js/customCharts.js"></script>
 

  <script type="text/javascript">

  
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
  
  
  function filtra(){
	  
	   var nome =$('#filtro_denominazione').val();
	  var marca = $('#filtro_marca').val();
	  var modello = $('#filtro_modello').val(); 
	 // var nome = "";
	//  var marca = "";
	//  var modello = "";
	  var matricola = $('#filtro_matricola').val();
	  var codice_int = $('#filtro_codice_interno').val();
	  
	  if(nome=="" && marca=="" && modello=="" && matricola=="" && codice_int==""){
		  
		  $('#myModalError').addClass("modal-danger");

		  $('#myModalErrorContent').html("Attenzione! Compila almeno un campo di ricerca!");
		  
		  $('#myModalError').modal();
    	   	 	
    	
		  
	  }else{
		  var dataString =  "action=filtra_misure&nome="+nome+ "&marca="+marca +"&modello="+modello +"&matricola="+matricola+"&codice_interno="+codice_int;
			
		  exploreModal("gestioneStrumento.do",dataString,"#posTab",function(data,textStatus){ });
	  }
	  
	  
	 
  }
  
  
function filtraStrumentiGenerale(){
	
	  var id =$('#filtro_id_str').val();
	  var nome =$('#filtro_denominazione_str').val();
	  var marca = $('#filtro_marca_str').val();
	  var modello = $('#filtro_modello_str').val();
	  // var nome = "";
	//  var marca = "";
	//  var modello = "";
	  var matricola = $('#filtro_matricola_str').val();
	  var codice_int = $('#filtro_codice_interno_str').val();
	  
	  var dataString =  "action=filtra_generali&id="+id+"&nome="+nome+ "&marca="+marca +"&modello="+modello +"&matricola="+matricola+"&codice_interno="+codice_int;
	  //var dataString =  "action=filtra_generali&id="+id+"&matricola="+matricola+"&codice_interno="+codice_int;
	  exploreModal("gestioneStrumento.do",dataString,"#posTab",function(data,textStatus){
		  
	  });
	
}
  
  function resetFiltri(){
	  var nome =$('#filtro_denominazione').val("");
	  var marca = $('#filtro_marca').val("");
	  var modello = $('#filtro_modello').val("");
	  var matricola = $('#filtro_matricola').val("");
	  var codice_int = $('#filtro_codice_interno').val("");
	  
  }
  
  function resetFiltriGenerale(){
	  var id = $('#filtro_id_str').val("");
	  var nome =$('#filtro_denominazione_str').val("");
	  var marca = $('#filtro_marca_str').val("");
	  var modello = $('#filtro_modello_str').val("");
	  var matricola = $('#filtro_matricola_str').val("");
	  var codice_int = $('#filtro_codice_interno_str').val("");
	  
  }
  
  var myChart1 = null;
  var myChart2 = null;
  var myChart3 = null;
  var myChart4 = null;
  var myChart5 = null;
  var myChart6 = null;
  
  
  var idCliente = "${utl:encryptData(userObj.idCliente)}";
  var idSede = "${utl:encryptData(userObj.idSede)}";

   $body = $("body");

function spd()
	{
	var idCli=$("#select1").val();
	var idsed=$("#select2").val();	
	var nomeSede=$("#select2 option:selected").text();
	var nomeCliente=$("#select1 option:selected").text();
	
	callAction("scaricoPacchettoDirect.do?idC="+idCli+"&idS="+idsed+"&nomeSede="+nomeSede+"&nomeCliente="+nomeCliente);
	}

 
 
    $("#select1").change(function() {
    
  	  if ($(this).data('options') == undefined) 
  	  {
  	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
  	    $(this).data('options', $('#select2 option').clone());
  	  }
  	  
  	  var id = $(this).val();
  	 
  	  var options = $(this).data('options');

  	  var opt=[];
  	
  	  opt.push("<option value = '${non_associate_encrypt}'>Non Associate</option>");

  	   for(var  i=0; i<options.length;i++)
  	   {
  		var str=options[i].value; 
  	
  		if(str.substring(str.indexOf("_")+1,str.length)==id)
  		{
  			
  			//if(opt.length == 0){
  				
  			//}
  		
  			opt.push(options[i]);
  		}   
  	   }
  	 $("#select2").prop("disabled", false);
  	 
  	  $('#select2').html(opt);
  	  
  	  $("#select2").trigger("chosen:updated");
  	  
  	  //if(opt.length<2 )
  	  //{ 
  		$("#select2").change();  
  	  //}
  	  
  	
  	});
    
    $(document).ready(function() {
    

    	//$(".select2").select2();
    	
    	initSelect2('#select1');
    	
    	$("#select2").select2();
    	
    	if(idCliente != 0 && idSede != 0){
    		 $("#select1").prop("disabled", true);
    		// $('#select1').val(idCliente);
    		// $('#select2').val(idSede+"_"+idCliente);
    		// $("#select1").change();
    		 $('#select2').val(idSede+"_"+idCliente);
    		$("#select2").change();
    	}else if(idCliente != 0 && idSede == 0){
    		 $("#select1").prop("disabled", true);
    		 $("#select2").prop("disabled", false);
    		$("#select1").change();
    	}else{
    	    if( $("#select1").val() != 0 && ($("#select2").val() == 0 || $("#select2").val() == null)){
    	    		$("#select1").change();
        	}else if($("#select1").val() != 0 && $("#select2").val() != 0 ){
        		$("#select2").change();
        		 
     	}
    	    $("#select1").prop("disabled", false);
   		 $("#select2").prop("disabled", true);
    	}

    	
   
    
    	 $(".boxgrafici").hide();
    });
   
    
    $("#select2").change(function(e){
		
          //get the form data using another method 
          var sede = $("#select2").val();
          var cliente = $("#select1").val();
      		resetFiltri();
          if(sede==""){
        	   sede = null;
          }

          dataString ="idSede="+ sede+";"+cliente;
          exploreModal("listaStrumentiSedeNew.do",dataString,"#posTab",function(data,textStatus){
        	  $('#myModal').on('hidden.bs.modal', function (e) {
             	  	$('#noteApp').val("");
             	 	$('#empty').html("");
             	 	$('body').removeClass('noScroll');
             	 	$(document.body).css('padding-right', '0px');
             	});
        	  
 			
        	  $('#myModalError').on('hidden.bs.modal', function (e) {
        		  
        		  var input = $("#uploadSuccess").val();
        		  if(input){
        			  $('#myModal').modal("hide");
						
        		  }

        	   	 	
        	   	 	
        	   	});


        		  
        	  
          });
         
          
    });
    
   
    function nuovoStrumentoGeneral(){
    	
    	
    	exploreModal("listaStrumentiSedeNew.do?action=nuovo_strumento_general&idCliente="+$('#select1').val()+"&idSede="+$('#select2').val(), "", "#content_nuovo_strumento", function(){
    		initSelect2Gen('#cliente_general');
    		$('#modalNuovoStrumentoGeneral').modal()
    		
    	});
    }
    

    
  </script>
</jsp:attribute> 
</t:layout>

 
 