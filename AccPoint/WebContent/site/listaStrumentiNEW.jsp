<%@page import="it.portaleSTI.DTO.SedeDTO"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<jsp:directive.page import="it.portaleSTI.DTO.ClienteDTO"/>
<jsp:directive.page import="it.portaleSTI.DTO.StrumentoDTO"/>

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


          
    <%List<ClienteDTO> lista=(List<ClienteDTO>)request.getSession().getAttribute("listaClienti"); %>    

    
    
    <div class="form-group">
                  <label>Cliente</label>
                  <select name="select1" id="select1" data-placeholder="Seleziona Cliente..."  class="form-control select2" aria-hidden="true" data-live-search="true">
                    <option value=""></option>
            <%for (int i=0; i<lista.size();i++){%> 
            <option value=<%=lista.get(i).get__id() %>><%=lista.get(i).getNome() %></option>
            <%
            }
            %>
                  </select>
        </div>

  </div>
    <div class="col-xs-6">
    <%List<SedeDTO> listaSedi=(List<SedeDTO>)request.getSession().getAttribute("listaSedi"); %>
 
 
     <div class="form-group">
                  <label>Sede</label>
                  <select name="select2" id="select2" data-placeholder="Seleziona Sede"  disabled class="form-control select2" aria-hidden="true" data-live-search="true">
                    <option value=""></option>
            <%for (int i=0; i<listaSedi.size();i++){%>
            <option value=<%=listaSedi.get(i).get__id()+"_"+listaSedi.get(i).getId__cliente_()%>><%=listaSedi.get(i).getDescrizione()+" - "+listaSedi.get(i).getIndirizzo() %></option>
            <%
            }
            %>
                  </select>
        </div>

  
</div>
</div>
<form method="post"></form>
      <div class="row">
        <div class="col-xs-12">    
        <button class="btn btn-info" onclick="scaricaPacchetti()">Scarica Pacchetto Dati</button> 
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
        <h4 class="modal-title" id="myModalLabel">Dettagli Campione</h4>
      </div>
       <div class="modal-body">

        <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#dettaglio" data-toggle="tab" aria-expanded="true" onclick="" id="dettaglioTab">Dettaglio Campione</a></li>
              <li class=""><a href="#valori" data-toggle="tab" aria-expanded="false" onclick="" id="valoriTab">Valori Campione</a></li>
              <li class=""><a href="#prenotazione" data-toggle="tab" aria-expanded="false" onclick="" id="prenotazioneTab">Stato Prenotazione</a></li>
               <li class=""><a href="#aggiorna" data-toggle="tab" aria-expanded="false" onclick="" id="aggiornaTab">Gestione Campione</a></li>
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="dettaglio">


    			</div> 

              <!-- /.tab-pane -->
              <div class="tab-pane" id="valori">
                

         
			 </div>

              <!-- /.tab-pane -->

              <div class="tab-pane" id="prenotazione">
              

              </div>
              <!-- /.tab-pane -->
              <div class="tab-pane" id="aggiorna">
              

              </div>
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


 
 


  <script type="text/javascript">
   
   $body = $("body");



    
 
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
    	
    
    $('#posTab').on('click', 'tr', function () {
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
        
       
      
        
    });
    
    });
   
    
    $("#select2").change(function(e){
		
          //get the form data using another method 
          var sede = $("#select2").val();
          var cliente = $("#select1").val();
         
          
          dataString ="idSede="+ sede+";"+cliente;
          exploreModal("listaStrumentiSedeNew.do",dataString,"#posTab",function(data,textStatus){
        	  if(textStatus == "complete"){
        		  $('#tabPM').DataTable({
                	
                	  "scrollY":        "350px",
                      "scrollX":        true,
                      "scrollCollapse": true,
                 	    "paging":   false,
                 	   
                 	    });
        	  }
          });

          //make the AJAX request, dataType is set to json
          //meaning we are expecting JSON data in response from the server
          /* $.ajax({
              type: "POST",
              url: "listaStrumentiSedeNew.do",
              data: dataString,
              dataType: "json",
              
              //if received a response from the server
              success: function( data, textStatus) {
  	
              $("#posTab").html("");
               var content = "<table id=\"tabPM\" class=\"myTab\"  >";

            content +="<thead><tr><th>ID</th>"
            	       +"<th>Stato Strumento</th>"		   
            		   +"<th>Denominazione</th>"
                       +"<th>Codice Interno</th>"
                       +"<th>Costurttore</th>"
                       +"<th>Modello</th>"
                       +"<th>Matricola</th>"
                       +"<th>Risoluzione</th>"
                       +"<th>Campo Misura</th>"
                       +"<th>Tipo Strumento</th>"
                       +"<th>Freq. Verifica</th>"
                       +"<th>Data Ultima Verifica</th>"
                       +"<th>Data Prossima Verifica</th>"
                       +"<th>Tipo Rapporto</th>"
                       
                       +"</tr></thead>";
       
                       
  			   content +="<tbody>";
                  if(data.success){ 
                       for(var i=0 ; i<data.dataInfo.length;i++)
                      {
                    
                       content +="<tr><td>"+data.dataInfo[i].__id+"</td>" +
                       				 "<td>"+data.dataInfo[i].ref_stato_strumento+"</td>"+
                       			     "<td>"+data.dataInfo[i].denominazione+"</td>"+
                    	             "<td>"+data.dataInfo[i].codice_interno+"</td>"+
                    	             "<td>"+data.dataInfo[i].costruttore+"</td>"+
                    	             "<td>"+data.dataInfo[i].modello+"</td>"+
                    	             "<td>"+data.dataInfo[i].matricola+"</td>"+
                    	             "<td>"+data.dataInfo[i].risoluzione+"</td>"+
                    	             "<td>"+data.dataInfo[i].campo_misura+"</td>"+
                    	             "<td>"+data.dataInfo[i].ref_tipo_strumento+"</td>"+
                    	             "<td>"+data.dataInfo[i].scadenzaDto.freq_mesi+"</td>"+
                    	             "<td>"+data.dataInfo[i].scadenzaDto.dataUltimaVerifica+"</td>"+ 
                    	             "<td>"+data.dataInfo[i].scadenzaDto.dataProssimaVerifica+"</td>"+
                    	             "<td>"+data.dataInfo[i].scadenzaDto.ref_tipo_rapporto+"</td>"+
                    	              "</tr>";
                    	             
                    	            
                      }
                    
                       
                   } 
                  
                   else 
                   {
                       $("#tabPM").html("<tr><td>Non ci sono tipo di misura associati</td></tr>");
                   }
                  
                  
                  content +="</tbody>";
                  content += "</table>";
                $("#posTab").append(content);
              },
              
              //If there was no resonse from the server
              error: function(jqXHR, textStatus, errorThrown){
                   console.log("Something really bad happened " + textStatus);
                    $("#tabPM").html(jqXHR.responseText);
              },

              //this is called after the response or error functions are finsihed
              //so that we can take some action
              complete: function(jqXHR, textStatus){
 
                  $('#tabPM').DataTable({
                	  "columns": [
                	              { "width": "50px" },
                	              { "width": "50px" },
                	              { "width": "100px" },
                	              { "width": "50px" },
                	              { "width": "100px" },
                	              { "width": "100px" },
                	              { "width": "50px" },
                	              { "width": "50px" },
                	              { "width": "100px" },
                	              { "width": "50px" },
                	              { "width": "50" },
                	              { "width": "100px" },
                	              { "width": "100px" },
                	              { "width": "50px" }
                	            ],
                	  "scrollY":        "350px",
                      "scrollX":        true,
                      "scrollCollapse": true,
                 	    "paging":   false,
                 	   
                 	    });
              }

          }); */
    });
    
    
  </script>
  <div  class="modal"><!-- Place at bottom of page --></div> 
   <div id="modal1"><!-- Place at bottom of page --></div> 
   
    </section>
    <!-- /.content -->
 