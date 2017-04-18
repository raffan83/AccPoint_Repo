<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Lista Strumenti
        <small>Elenco Strumenti Portale</small>
      </h1>
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
                    <option value=""></option>
                      <c:forEach items="${listaClienti}" var="cliente">
                           <option value="${cliente.__id}">${cliente.nome}</option> 
                     </c:forEach>

                  </select>
        </div>

  </div>
    <div class="col-xs-6"> 
 
     <div class="form-group">
                  <label>Sede</label>
                  <select name="select2" id="select2" data-placeholder="Seleziona Sede"  disabled class="form-control select2" aria-hidden="true" data-live-search="true">
                    <option value=""></option>
             <c:forEach items="${listaSedi}" var="sedi">
                           <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option>                            
                     </c:forEach>
                  </select>
        </div>

  
</div>
</div>

      <div class="row">
        <div class="col-xs-12">    
        <button class="btn btn-info" onclick="spd()">Scarica Pacchetto Dati</button> 
        </div>
</div>
          </div>
            <div class="box-body">

<div class="row">
	<div class="col-xs-12">
		<div id="posTab"></div>
</div>
</div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
 





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
 <!--              <li class=""><a href="#valori" data-toggle="tab" aria-expanded="false" onclick="" id="valoriTab">Valori Campione</a></li>
              <li class=""><a href="#prenotazione" data-toggle="tab" aria-expanded="false" onclick="" id="prenotazioneTab">Stato Prenotazione</a></li>
               <li class=""><a href="#aggiorna" data-toggle="tab" aria-expanded="false" onclick="" id="aggiornaTab">Gestione Campione</a></li> -->
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="dettaglio">

    			</div> 

              <!-- /.tab-pane -->
             <!--  <div class="tab-pane" id="valori">
                

         
			 </div> -->

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


</jsp:attribute>

<jsp:attribute name="extra_js_footer">



  <script type="text/javascript">
   
   $body = $("body");

function spd()
	{
	var idCli=$("#select1").val();
	var idsed=$("#select2").val();	
	
	callAction("scaricoPacchettoDirect.do?idC="+idCli+"&idS="+idsed);
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
		

  	   for(var  i=0; i<options.length;i++)
  	   {
  		var str=options[i].value; 
  	
  		if(str.substring(str.indexOf("_")+1,str.length)==id)
  		{
  			
  			if(opt.length == 0){
  				opt.push("<option></option>");
  			}
  		
  			opt.push(options[i]);
  		}   
  	   }
  	 $("#select2").prop("disabled", false);
  	 
  	  $('#select2').html(opt);
  	  
  	  $("#select2").trigger("chosen:updated");
  	  
  	  if(opt.length<2 )
  	  { 
  		$("#select2").change();  
  	  }
  	  
  	
  	});
    
    $(document).ready(function() {
    

    	$(".select2").select2();
    	
    
   /*  $('#posTab').on('click', 'tr', function () {
    	 var table = $('#tabPM').DataTable();
         var data = table.row( this ).data();
        
        
        var content="";
        
        $.ajax({
            type: "POST",
            url: "dettaglioStrumento.do",
            data: "id_str="+data[0],
            dataType: "json",
            
            //if received a response from the server
            success: function( data, textStatus) {
            	
            	if(data.success){ 

               	content="<div class=\"testo14\" style=\"height:500px;\">"+
          
            	"<table class=\"myTab\" cellspacing=\"0\"><tr><td>" +
  				 "<label><span>Stato Strumento:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.ref_stato_strumento+"\"></input></td></tr>"+
  		
  			     "<tr><td>Stato Strumento:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.denominazione+"\"></input></td></tr>"+
	             "<tr><td>Codice Interno:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.codice_interno+"\"></input></td></tr>"+
	             "<tr><td>Costruttore:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.costruttore+"\"></input></td></tr>"+
	             "<tr><td>Modello:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.modello+"\"></input></td></tr>"+
	             "<tr><td>Matricola:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.matricola+"\"></input></td></tr>"+
	             "<tr><td>Risoluzione:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.risoluzione+"\"></input></td></tr>"+
	             "<tr><td>Campo Misura:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.campo_misura+"\"></input></td></tr>"+
	             "<tr><td>Tipo Strumento:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.ref_tipo_strumento+"\"></input></td></tr>"+
	             "<tr><td>Freq verifica:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.scadenzaDto.freq_mesi+"\"></input></td></tr>"+
	             "<tr><td>Ultima Verifica:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.scadenzaDto.dataUltimaVerifica+"\"></input></td></tr>"+
	             "<tr><td>Prossima Verifica:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.scadenzaDto.dataProssimaVerifica+"\"></td></tr>"+
	             "<tr><td>Tipo Rapporto:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.scadenzaDto.ref_tipo_rapporto+"\"></input></td></tr>"+
	             "</table>"+
	             "</div>";
	              
                
                
                $('#modal1').html(content);
                $('#modal1').dialog({
                	autoOpen: true,
                	title:"Specifiche Strumento",
                	width: "500px",
                });
                
            	}
            }
            });
        
       
      
        
    }); */
    
    });
   
    
    $("#select2").change(function(e){
		
          //get the form data using another method 
          var sede = $("#select2").val();
          var cliente = $("#select1").val();
         

          dataString ="idSede="+ sede+";"+cliente;
          exploreModal("listaStrumentiSedeNew.do",dataString,"#posTab",function(data,textStatus){
        	  $('#myModal').on('hidden.bs.modal', function (e) {
             	  	$('#noteApp').val("");
             	 	$('#empty').html("");
             	 	$('body').removeClass('noScroll');
             	})


        		  
        	  
          });

          
    });
    
    
  </script>
</jsp:attribute> 
</t:layout>

 
 