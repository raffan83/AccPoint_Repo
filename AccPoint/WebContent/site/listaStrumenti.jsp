<%@page import="it.portaleSTI.DTO.SedeDTO"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<jsp:directive.page import="it.portaleSTI.DTO.ClienteDTO"/>
<jsp:directive.page import="it.portaleSTI.DTO.StrumentoDTO"/>
<html>
  <head>	
  
  <link href="css/style.css" rel="stylesheet" type="text/css">
  <link rel="stylesheet" href="css/style_css.css">
  <link rel="stylesheet" href="css/prism.css">
  <link rel="stylesheet" href="css/chosen.css">
  <link rel="stylesheet" href="https://cdn.datatables.net/1.10.13/css/dataTables.jqueryui.min.css">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <link href="css/dark_matter.css" rel="stylesheet" type="text/css">
  
 <script type="text/javascript" src="js/scripts.js"></script>
 <script src="//code.jquery.com/jquery-1.12.4.js"></script> 
 <script src="js/chosen.jquery.js" type="text/javascript"></script>
 <script src="js/prism.js" type="text/javascript" charset="utf-8"></script>
 <script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js" type="text/javascript" charset="utf-8"></script>
 <script src="https://cdn.datatables.net/1.10.13/js/dataTables.jqueryui.min.js" type="text/javascript" charset="utf-8"></script>
 <script src="https://cdn.datatables.net/fixedcolumns/3.2.2/js/dataTables.fixedColumns.min.js"  type="text/javascript" charset="utf-8"></script>
<script src = "https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
  

  <style type="text/css" media="all">
    /* fix rtl for demo */
    .chosen-rtl .chosen-drop { left: -9000px; }
  </style> 
  
  </head>
  
  <body>
  <form name="frm" method="post" id="fr" action="#">
   <div style="width: 100%;padding:10px;height: 30px;text-align:center" class="testo14">Lista Strumenti</Div>
 
  <div style="width: 100%;padding:10px;height: 80px" >

  <table  cellspacing="5px"  cellpadding="0" width="100%">
  
  <tr><td style="width:5%;padding: 5px;" class="testo12" >Cliente</td>
  <td class="testo10" align="left" width="30%">
  
  <%List<ClienteDTO> lista=(List<ClienteDTO>)request.getSession().getAttribute("listaClienti"); %>
  <select name="select1" id="select1" data-placeholder="Seleziona Cliente..." class="chosen-select" style="width:350px;" tabindex="2">
            <option value=""></option>
            <%for (int i=0; i<lista.size();i++){%> 
            <option value=<%=lista.get(i).get__id() %>><%=lista.get(i).getNome() %></option>
            <%
            }
            %>
  </select>
  </td>
  <td style="width:5%;padding: 5px" class="testo12" >Sede</td>
  
  <td  class="testo10" align="left" width="30%" >
  
  <%List<SedeDTO> listaSedi=(List<SedeDTO>)request.getSession().getAttribute("listaSedi"); %>
 
  <select name="select2" id="select2" data-placeholder="Seleziona Sede" class="chosen-select" style="width:350px;" tabindex="2" disabled="disabled">
            <option value=""></option>
            <%for (int i=0; i<listaSedi.size();i++){%>
            <option value=<%=listaSedi.get(i).get__id()+"_"+listaSedi.get(i).getId__cliente_()%>><%=listaSedi.get(i).getComune()+" - "+listaSedi.get(i).getIndirizzo() %></option>
            <%
            }
            %>
  </select>
  </td>
<td width="30%">
 <button  class="button_" style="margin-left:20px">+</button>
  <button  class="button_" >-</button>
  </td></tr>
  </table>
 </div>
 
 <div id="posTab" style="padding:5px;"></div>
</form>

  <script type="text/javascript">
   
  function checkAll(ele) {
	     var checkboxes = document.getElementsByTagName('input');
	     if (ele.checked) {
	         for (var i = 0; i < checkboxes.length; i++) {
	             if (checkboxes[i].type == 'checkbox') {
	                 checkboxes[i].checked = true;
	             }
	         }
	     } else {
	         for (var i = 0; i < checkboxes.length; i++) {
	             console.log(i)
	             if (checkboxes[i].type == 'checkbox') {
	                 checkboxes[i].checked = false;
	             }
	         }
	     }
	 }

  $body = $("body");

  $(document).on({  
      ajaxStart: function() {  $body.addClass("loading");    },
       ajaxStop: function() { $body.removeClass("loading"); }    
  });

  
    var config = {
      '.chosen-select'           : {},
      '.chosen-select-deselect'  : {allow_single_deselect:true},
      '.chosen-select-no-single' : {disable_search_threshold:10},
      '.chosen-select-no-results': {no_results_text:'Oops, elemento non trovato!'},
      '.chosen-select-width'     : {width:"80%"}
    }
    
    for (var selector in config) {
      $(selector).chosen(config[selector]);
    }
    
   
    
 
    $("#select1").change(function() {
    
  	  if ($(this).data('options') == undefined) 
  	  {
  	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
  	    $(this).data('options', $('#select2 option').clone());
  	  }
  	  
  	  var id = $(this).val();
  	 
  	  var options = $(this).data('options');

  	  var opt=[""];
  	  
  	   for(var  i=0; i<options.length;i++)
  	   {
  		var str=options[i].value; 
  		
  		if(str.substring(str.indexOf("_")+1,str.length)==id)
  		{
  			opt.push(options[i]);
  		}   
  	   }
  	 $("#select2").prop("disabled", false);
  	 
  	  $('#select2').html(opt);
  	  
  	  $("#select2").trigger("chosen:updated");
  	  
  	  if(opt.length==2)
  	  {
  		$("#select2").change();  
  	  }
  	  
  	
  	});

	var columsDatatables = [];
	 
	$("#tabPM").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    

	} );
 
    $(document).ready(function() {
    
    	
    
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
          dataString ="idSede="+ sede;
          

          //make the AJAX request, dataType is set to json
          //meaning we are expecting JSON data in response from the server
          $.ajax({
              type: "POST",
              url: "listaStrumentiSede.do",
              data: dataString,
              dataType: "json",
              
              //if received a response from the server
              success: function( data, textStatus) {
  	
              $("#posTab").html("");
               var content = "<table id=\"tabPM\" class=\"myTab\"  >";

            content +="<thead><tr><th ><INPUT type=\"checkbox\" onchange=\"checkAll(this)\" name=\"chk[]\"  style=\"width:50px\"></th>"
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
                    
                       content +="<tr><td><INPUT type=\"checkbox\" name=\"chk\" value="+data.dataInfo[i].__id +" style=\"width:50px\"> </td>" +
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
              
              //capture the request before it was sent to server
              beforeSend: function(jqXHR, settings){
                  //adding some Dummy data to the request
                  settings.data += "&dummyData=whatever";
                  //disable the button until we get the response
                  $('#myButton').attr("disabled", true);
              },
              
              //this is called after the response or error functions are finsihed
              //so that we can take some action
              complete: function(jqXHR, textStatus){
 
                  $('#tabPM').DataTable({
                	  language: {
      	  	        	emptyTable : 	"Nessun dato presente nella tabella",
      	  	        	info	:"Vista da _START_ a _END_ di _TOTAL_ elementi",
      	  	        	infoEmpty:	"Vista da 0 a 0 di 0 elementi",
      	  	        	infoFiltered:	"(filtrati da _MAX_ elementi totali)",
      	  	        	infoPostFix:	"",
      	  	        infoThousands:	".",
      	  	        lengthMenu:	"Visualizza _MENU_ elementi",
      	  	        loadingRecords:	"Caricamento...",
      	  	        	processing:	"Elaborazione...",
      	  	        	search:	"Cerca:",
      	  	        	zeroRecords	:"La ricerca non ha portato alcun risultato.",
      	  	        	paginate:	{
      		  	        	first:	"Inizio",
      		  	        	previous:	"Precedente",
      		  	        	next:	"Successivo",
      		  	        last:	"Fine",
      	  	        	},
      	  	        aria:	{
      		  	        	srtAscending:	": attiva per ordinare la colonna in ordine crescente",
      		  	        sortDescending:	": attiva per ordinare la colonna in ordine decrescente",
      	  	        }
        	        },
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
                	            fixedColumns: true,
                	  "scrollY":        "350px",
                      "scrollX":        true,
                      "scrollCollapse": true,
                 	    "paging":   false,
                 	   
                 	    });
              }

          });
    });
    
    
  </script>
  <div  class="modal"><!-- Place at bottom of page --></div> 
   <div id="modal1"><!-- Place at bottom of page --></div> 
    </body>
    </html>