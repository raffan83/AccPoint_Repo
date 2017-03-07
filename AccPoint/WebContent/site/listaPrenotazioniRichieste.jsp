<%@page import="it.portaleSTI.DTO.PrenotazioneDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
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
 <script  src = "https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
  
  
  </head>
  
  <body>
  <form name="frm" method="post" id="fr" action="#">
   <div style="width: 100%;padding:10px;height: 30px;text-align:center" class="testo14">Lista Richiesta Prenotazioni</Div>
 
  <div style="width: 100%;padding:10px;height: 80px" >

 
  
 </div>
 
 <div id="posTab" style="padding:5px;">

 <table id="tabPM" class="myTab">
 <thead><tr>
 
 <th>ID Prenotazione</th>
 <th>Campione</th>
 <td>Stato</td>
 <th>Proprietario</th>
 <th>Azienda Richiedente</th>
 <th>Utente Richiedente</th>
 <th>Data Richiesta</th>
 <th>Data Gestione</th>
 <th>Data Inizio Prenotazione</th>
 <th>Data Fine Prenotazione</th>
 <th>Note</th>
 </tr></thead>
 
 <tbody>
 
 <%
 ArrayList<PrenotazioneDTO> listaPrenotazioni =(ArrayList<PrenotazioneDTO>)request.getSession().getAttribute("listaPrenotazioni");
 SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
 for(PrenotazioneDTO prenotazione :listaPrenotazioni)
 {
	 %>
	 <tr>

	<td><%=prenotazione.getId() %></td>
    <td><%=prenotazione.getNomeCampione() %></td>
	<td><%=prenotazione.getDescrizioneStatoPrenotazione() %></td>
	<td><%=prenotazione.getNomeCompanyProprietario() %></td>
	<td><%=prenotazione.getNomeCompanyRichiedente() %></td>
	<td><%=prenotazione.getNomeUtenteRichiesta() %></td>
	<td><%=sdf.format(prenotazione.getDataRichiesta())%></td>
	<td><%if(prenotazione.getDataGestione()!=null)
	{ 
		sdf.format(prenotazione.getDataGestione());
	}
	%></td>
	<td><%=sdf.format(prenotazione.getPrenotatoDal()) %></td>
	<td><%=sdf.format(prenotazione.getPrenotatoAl()) %></td>
	<td><%=prenotazione.getNote()%></td>
	</tr>
<% 	 
 } 
 %>
 </tbody>
 </table>  
 </div>
</form>

  <script type="text/javascript">
   
  $body = $("body");
  
  $(document).on({  
      ajaxStart: function() {  $body.addClass("loading"); },
       ajaxStop: function() { $body.removeClass("loading"); }    
  });
   
    $(document).ready(function() {
    	
        $('#tabPM').DataTable({
        	"columnDefs": [
        	               { "width": "50px", "targets": 0 },
        	               { "width": "250px", "targets": 1 },
        	               { "width": "50px", "targets": 2 },
        	               { "width": "150px", "targets": 3 },
        	               { "width": "50px", "targets": 4 },
        	               { "width": "100px", "targets": 5 }
        	             ],
      	       
      	  "scrollY":        "350px",
            "scrollX":        true,
            "scrollCollapse": true,
       	    "paging":   false,
       	   
       	    });
        
    
    $('#posTab').on('click', 'tr', function () {
    	 var table = $('#tabPM').DataTable();
         var data = table.row( this ).data();

 	    $( "#modal" ).dialog({
	        modal: true,
	        width: "400px",
	        buttons: {
	          "Approva": function() {
	            var str=$('#noteApp').val();
	         
	            if(str.length!=0){
	            	
	            
	            $( this ).dialog( "close" );
        
       $.ajax({
            type: "POST",
            url: "gestionePrenotazione.do?param=app",
            data: "dataIn="+data[0]+"|"+str,
            dataType: "json",

            success: function( data, textStatus) {
            	
            	if(data.success)
            	{ 
              
            		$('#modal1').html("<h3 style=\"color:green\">Prenotazione Approvata</h3>");
                
            	}
            },

            error: function(jqXHR, textStatus, errorThrown){
            	alert('error');
              
           }
            });
            
	          
	          }else
	          {
	        	$('#empty').html("Il campo non può essere vuoto"); 
	          }
	           },"Non Approvare": function() 
	          {
	              var str=$('#noteApp').val();
	             
	              if(str.length!=0){  
		            $( this ).dialog( "close" );
	        
	       $.ajax({
	            type: "POST",
	            url: "gestionePrenotazione.do?param=noApp",
	            data: "dataIn="+data[0]+"|"+str,
	            dataType: "json",

	            success: function( data, textStatus) {
	            	
	            	if(data.success)
	            	{ 
	              
	            		$('#modal1').html("<h3 style=\"color:red\">Prenotazione Non Approvata</h3>");
	                
	            	}
	            },
	            
	         
	            error: function(jqXHR, textStatus, errorThrown){
	            	alert('error');
	              
	           }
	            });
	              }else
		          {
		        	$('#empty').html("Il campo non può essere vuoto"); 
		          }
	          }
	        }
	        
	      });
    });
   
 
    });


  </script>
  <div id="modal" class="modal">
  <textarea rows="5" cols="30" id="noteApp"></textarea>
  <span id="empty" class="testo12"></span>
  </div> 
   <div id="modal1"><!-- Place at bottom of page --></div>
   <div id="modal11"><!-- Place at bottom of page --></div> 
   <div id="modal12"><!-- Place at bottom of page --></div> 
    </body>
    </html>