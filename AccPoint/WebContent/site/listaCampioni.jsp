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
   <div style="width: 100%;padding:10px;height: 30px;text-align:center" class="testo14">Lista Campioni</Div>
 
  <div style="width: 100%;padding:10px;height: 80px" >

  <table  cellspacing="5px"  cellpadding="0" width="100%">
 <tr>
 <td width="30%">
 <input type="button" class="button" style="margin-left:15px;" value="I Miei Campioni" id="myCMP" />
 <input type="button" class="button" style="margin-left:15px;" value="Tutti i Campioni" id="allCMP" />
 
  </td>
  </tr>
  </table>
  
 </div>
 
 <div id="posTab" style="padding:5px;">

 <table id="tabPM" class="myTab">
 <thead><tr>
 <td>ID</td>
 <th>Proprietario</th>
 <th>Utilizzatore</th>
 <th>Prenotazione</th>
 <th>Nome</th>
 <th>Tipo Campione</th>
 <th>Codice</th>
 <th>Costruttore</th>
 <th>Descrizione</th>
 <th>Stato Campione</th>
 <th>Data Verifica</th>
 <th>Data Scadenza</th>
 </tr></thead>
 
 <tbody>
 
 <%
 ArrayList<CampioneDTO> listaCampioni =(ArrayList<CampioneDTO>)request.getSession().getAttribute("listaCampioni");
 SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
 for(CampioneDTO campione :listaCampioni)
 {
	 %>
	 <tr>

	
    <td><%=campione.getId()%></td>
	<td><%=campione.getProprietario() %></td>
	<td><%=campione.getUtilizzatore() %></td>
		 <%

	
	 if(campione.getStatoPrenotazione()!=null && campione.getStatoPrenotazione().equals("0") && !campione.getStatoCampione().equals("N"))
	 {
		 %>
		 	<td align="center" ><span style="width:100px;height:30px;background-color:yellow;border-radius:15px;font-size:85%;padding:10px;cursor: pointer;">ATTESA</span></td>
		 <% 
	 }
	 
	 if(campione.getStatoPrenotazione()!=null && campione.getStatoPrenotazione().equals("1") && !campione.getStatoCampione().equals("N"))
	 {
		 
		 %>
		 	<td align="center"><span style="width:100px;height:30px;background-color:orange;border-radius:15px;font-size:85%;padding:10px;cursor: pointer;">PRENOTATO</span></td>
		 <% 
	 }
	 
	 if(campione.getStatoCampione().equals("N"))
     {
		 %>
		 <td align="center"><span style="width:100px;height:30px;background-color:red;border-radius:15px;font-size:85%;padding:10px;cursor: pointer;">NON DISPONIBILE</span></td>
		 <%  
	 }
	
	 if(campione.getStatoPrenotazione().equals("null")  && campione.getStatoCampione().equals("S")  )
	 {
		 %>
		 <td align="center"><span style="width:100px;height:30px;background-color:green;border-radius:15px;font-size:85%;padding:10px;cursor: pointer;">DISPONIBILE</span></td>
		 <%  
	 }
%>
	<td><%=campione.getNome() %></td>
	<td><%=campione.getTipoCampione() %></td>
	<td><%=campione.getCodice() %></td>
	<td><%=campione.getCostruttore() %></td>
	<td><%=campione.getDescrizione() %></td>
	<td><%=campione.getStatoCampione() %></td>
	<%String dataVer="";
	  String dataScad="";
	  
	  if(campione.getDataVerifica()!=null)
	  {
		  dataVer= sdf.format(campione.getDataVerifica());
	  }
	  
	  if(campione.getDataScadenza()!=null)
	  {
		  dataScad=  sdf.format(campione.getDataScadenza());
	  }
	  
	%>
	<td><%=dataVer %></td>
	<td><%=dataScad %></td>
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
      ajaxStart: function() {  $body.addClass("loading");    },
       ajaxStop: function() { $body.removeClass("loading"); }    
  });
   
	  
  function DoAction( filename )
  {
	  if(filename!= 'undefined')
	  {
       explore('scaricaCertificato.do');
	  }
	  else
	  {
		  $('#modal11').html("Cartificato non disponibile");
		  $('#modal11').dialog({
          	autoOpen: true,
          	title:"Spiacente",
          	width: "500px",
          });
	  }
	}
  
  function ValCMP( id )
  {
	 $.ajax({
	         type: "POST",
	         url: "valoriCampione.do",
	          data: "idCamp="+id,
	          dataType: "json",
	          
	          success: function( data, textStatus) 
	          {
	            	if(data.success){ 
	                    
	                   	content="<div class=\"testo14\"style=\"height:500px;width:850px;\">"+
	                   	"<table class=\"myTab\">"+
	                   	"<thead><tr style=\"padding:5px;\">"+
	                   	"<th>Valore Nominale</th>"+
	                   	"<th>Valore Taratura</th>"+
	                   	"<th>Incertezza Assoluta</th>"+
	                   	"<th>Incertezza Relativa</th>"+
	                   	"<th>Parametri Taratura</th>"+
	                   	"<th>UM</th>"+
	                   	"<th>Interpolato</th>"+
	                   	"<th>Valore Composto</th>"+
	                   	"<th>Divisione UM</th>"+
	                   	"<th>Tipo Grandezza</th>"+
	                   	"</tr></thead>";
	                   	
	           for(var i=0;i<data.dataInfo.length;i++){
	                   	
	            content+="<tr ><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo[i].valore_nominale+"\" style=\"width:100px;\"></input></td>"+
	    	             "<td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo[i].valore_taratura+"\" style=\"width:70px;\"></input></td>"+
	    	             "<td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo[i].incertezza_assoluta+"\" style=\"width:70px;\"></input></td>"+
	    	             "<td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo[i].incertezza_relativa+"\" style=\"width:70px;\"></input></td>"+
	    	             "<td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo[i].parametri_taratura+"\" style=\"width:70px;\"></input></td>"+
	    	             "<td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo[i].unita_misura+"\" style=\"width:70px;\"></input></td>"+
	    	             "<td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo[i].interpolato+"\" style=\"width:70px;\"></input></td>"+
	    	             "<td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo[i].valore_composto+"\" style=\"width:70px;\"></input></td>"+
	    	             "<td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo[i].divisioneUM+"\" style=\"width:70px;\"></input></td>"+
	    	             "<td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo[i].tipo_grandezza+"\" style=\"width:70px;\"></input></td></tr>";	    	    
	    	            	
	                   	}
	    	             
	                   	content+= "</table></div>";
	    	             
	    	              
	                    
	                    
	                    $('#modal12').html(content);
	                    $('#modal12').dialog({
	                    	autoOpen: true,
	                    	title:"Valori Campione",
	                    	width: "850px",
	                    });
	                    
	                	}
	          }
	 });
	  
  };
	  
  
  
  
    $(document).ready(function() {
    
    	$('#myCMP').click(function(){
    		explore('listaCampioni.do?p=mCMP');
    	});
    	$('#allCMP').click(function(){
    		explore('listaCampioni.do');
    	});
    	
        $('#tabPM').DataTable({
        	"columnDefs": [
        	               { "width": "50px", "targets": 0 },
        	               { "width": "250px", "targets": 1 },
        	               { "width": "250px", "targets": 2 },
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
        
       
        var content="";
        
       $.ajax({
            type: "POST",
            url: "dettaglioCampione.do",
            data: "idCamp="+data[0],
            dataType: "json",
            
            //if received a response from the server
            success: function( data, textStatus) {
            	
            	if(data.success){ 
              
            	var buttonPre="<input type=\"button\" class=\"button\" style=\"margin-left:15px;\" value=\"Prenota\" id=\"pren\" onClick=callAction('prenota.do&id="+data.dataInfo.id+"')/> </td>";
            	var buttonCon="<input type=\"button\" class=\"button\" style=\"margin-left:15px;\" value=\"Controlla Prenotazione\" id=\"pren\" onClick=callAction('controlloPrenotazione.do&id="+data.dataInfo.id+"')/> </td>";	
               	
            	content="<div class=\"testo14\"style=\"height:500px;\">"+
            	 
               	"<table class=\"myTab\" >"+
  			     "<tr><td>Proprietario:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.proprietario+"\"></input></td></tr>"+
	             "<tr><td>Nome:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.nome+"\"></input></td></tr>"+
	             "<tr><td>Tipo Campione:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.tipoCampione+"\"></input></td></tr>"+
	             "<tr><td>Codice:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.codice+"\"></input></td></tr>"+
	             "<tr><td>Matricola:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.matricola+"\"></input></td></tr>"+
	             "<tr><td>Descrizione:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.descrizione+"\"></input></td></tr>"+
	             "<tr><td>Costruttore:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.costruttore+"\"></input></td></tr>"+
	             "<tr><td>Modelllo:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.modello+"\"></input></td></tr>"+
	             "<tr><td>Interpolazione:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.interpolazionePermessa+"\"></input></td></tr>"+
	             "<tr><td>Freq Taratura:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.freqTaraturaMesi+"\"></input></td></tr>"+
	             "<tr><td>Stato Campione:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.statoCampione+"\"></input></td></tr>"+
	             "<tr><td>Data Verifica:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.dataVerifica+"\"></td></tr>"+
	             "<tr><td>Data Scadenza:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.dataScadenza+"\"></input></td></tr>"+
	             "<tr><td>Tipo Verifica:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.tipoVerifica+"\"></input></td></tr>"+
	             "<tr><td>Certificato:</td><td style=\"text-align:center;\"><a href=# OnClick=\"DoAction(\'"+data.dataInfo.filenameCertificato+"\');\">Scarica Certificato</a></td></tr>"+
	             "<tr><td>Numero Certificato:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.numeroCertificato+"\"></input></td></tr>"+
	             "<tr><td>Utilizzatore:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.utilizzatore+"\"></input></td></tr>"+
	             "<tr><td>Data Inizio:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.dataInizioPrenotazione+"\"></input></td></tr>"+
	             "<tr><td>Data Fine:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.dataFinePrenotazione+"\"></input></td></tr>"+
	             "<tr><td colspan=\"2\" style=\"padding:15px;\"><input type=\"button\" id=\"valCmp\"  class=\"button\"  value=\"Valori Campione\" style=\"margin-left:15px;\" onClick=\"ValCMP('"+data.dataInfo.id+"');\" />";
	             if(data.prenotazione)
	             {
	            	 content+=buttonPre;
	             }
	             if(data.controllo)
	             {
	            		 content+=buttonCon;
	             }
	             
	             content+="</tr></table></div>";
	              
                
                
                $('#modal1').html(content);
                $('#modal1').dialog({
                	autoOpen: true,
                	title:"Specifiche Campione",
                	width: "500px",
                })
                
            	}
            }
            });
    });
   
 
    });


  </script>
  <div  class="modal"><!-- Place at bottom of page --></div> 
   <div id="modal1"><!-- Place at bottom of page --></div>
   <div id="modal11"><!-- Place at bottom of page --></div> 
   <div id="modal12"><!-- Place at bottom of page --></div> 
    </body>
    </html>