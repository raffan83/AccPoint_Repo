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
        Lista Strumenti
        <small>Elenco Strumenti Portale</small>
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>

  <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">
          
          
                        <div class="row">
        <div class="col-xs-6">


          

 
    
    <div class="form-group">
                  <label>Cliente</label>
                  <select name="select1" id="select1" data-placeholder="Seleziona Cliente..."  class="form-control select2" aria-hidden="true" data-live-search="true">
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
                    
                  </select>
        </div>

  </div>
    <div class="col-xs-6"> 


     <div class="form-group">
                  <label>Sede</label>
                  <select name="select2" id="select2" data-placeholder="Seleziona Sede"  disabled class="form-control select2" aria-hidden="true" data-live-search="true">
                   <c:if test="${userObj.idSede != 0}">
             			<c:forEach items="${listaSedi}" var="sedi">
             			  <c:if test="${userObj.idSede == sedi.__id}">
                          	 <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo} - ${sedi.comune} (${sedi.siglaProvincia}) </option>     
                          </c:if>                       
                     	</c:forEach>
                     </c:if>
                     
                     <c:if test="${userObj.idSede == 0}">
                    	<option value=""></option>
             			<c:forEach items="${listaSedi}" var="sedi">
             			 	<c:if test="${userObj.idCliente != 0}">
             			 		<c:if test="${userObj.idCliente == sedi.id__cliente_}">
                          	 		<option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo} - ${sedi.comune} (${sedi.siglaProvincia})</option>       
                          	 	</c:if>      
                          	</c:if>     
                          	<c:if test="${userObj.idCliente == 0}">
                           	 		<option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo} - ${sedi.comune} (${sedi.siglaProvincia})</option>       
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
				<div class="col-xs-12 grafico1">
					<canvas id="grafico1"></canvas>
				</div>
				<div class="col-xs-12 grafico2" >
					<canvas id="grafico2"></canvas>
				</div>
				<div class="col-xs-12 grafico3">
					<canvas id="grafico3"></canvas>
				</div>
				<div class="col-xs-12 grafico4">
					<canvas id="grafico4"></canvas>
				</div>
				<div class="col-xs-12 grafico5">
					<canvas id="grafico5"></canvas>
				</div>
				<div class="col-xs-12 grafico6">
					<canvas id="grafico6"></canvas>
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
       <!--        <li class=""><a href="#prenotazione" data-toggle="tab" aria-expanded="false" onclick="" id="prenotazioneTab">Stato Prenotazione</a></li> -->
        
 		<c:if test="${userObj.checkPermesso('MODIFICA_STRUMENTO_METROLOGIA')}">
               <li class=""><a href="#modifica" data-toggle="tab" aria-expanded="false" onclick="" id="modificaTab">Modifica Strumento</a></li>
		</c:if>		
		 <li class=""><a href="#documentiesterni" data-toggle="tab" aria-expanded="false" onclick="" id="documentiesterniTab">Documenti esterni</a></li>
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




<div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body" id="myModalErrorContent" >

       
    
  		 </div>
      <div class="modal-footer">
    	<button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
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
  
  
  var myChart1 = null;
  var myChart2 = null;
  var myChart3 = null;
  var myChart4 = null;
  var myChart5 = null;
  var myChart6 = null;
  
  
  var idCliente = ${userObj.idCliente};
  var idSede = ${userObj.idSede};

 
  
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
  	
  	  opt.push("<option value = 0>Non Associate</option>");

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
    

    	$(".select2").select2();
    	
 
    	
    	if(idCliente != 0 && idSede != 0){
    		 $("#select1").prop("disabled", true);
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
   		 $("#select2").prop("disabled", false);
    	}

    	
   
    
    	 $(".boxgrafici").hide();
    });
   
    
    $("#select2").change(function(e){
		
          //get the form data using another method 
          var sede = $("#select2").val();
          var cliente = $("#select1").val();
         
          if(sede==""){
        	   sede = null;
          }

          dataString ="idSede="+ sede+";"+cliente;
          exploreModal("listaStrumentiSedeNew.do",dataString,"#posTab",function(data,textStatus){
        	  $('#myModal').on('hidden.bs.modal', function (e) {
             	  	$('#noteApp').val("");
             	 	$('#empty').html("");
             	 	$('body').removeClass('noScroll');
             	});
        	  
 			
        	  $('#myModalError').on('hidden.bs.modal', function (e) {
        		  
        		  var input = $("#uploadSuccess").val();
        		  if(input){
        			  $('#myModal').modal("hide");
				
        		  }

        	   	 	
        	   	 	
        	   	});


        		  
        	  
          });
         
          
    });
    
    
  </script>
</jsp:attribute> 
</t:layout>

 
 