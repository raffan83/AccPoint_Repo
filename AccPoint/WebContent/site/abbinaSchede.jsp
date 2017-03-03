<%@page import="it.portaleSTI.DTO.TipoStrumentoDTO"%>
<%@page import="it.portaleSTI.DTO.TipoRapportoDTO"%>
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
  <link rel="stylesheet" href="https://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css">
  
  
 
  <style type="text/css" media="all">
    /* fix rtl for demo */
    .chosen-rtl .chosen-drop { left: -9000px; }
   
table, th, td 
	{
    border: 1px solid black;
    border-collapse: collapse;
    }
	th, td 
	{
	
    padding: 5px;
	}

  </style> 
  </head>
  
  <body>
  <form name="frm" method="post" id="fr" action="#">
  <br>
  
  <table  class="tableFormat" style="width:50%" >
  <tbody>
  <tr><th colspan="2">Abbina</th></tr>
  <tr><td class="testo12" align="left" style="width: 20%;">Tipo Strumento</td>
  <td>
   <%List<TipoStrumentoDTO> lista=(List<TipoStrumentoDTO>)request.getSession().getAttribute("listaTipoStrumento"); %>
  <select name="tpS" id="tpS" data-placeholder="Seleziona Tipo Strumento..." class="chosen-select" style="width:350px;" tabindex="2">
            <option value=""></option>
            <%for (int i=0; i<lista.size();i++){%> 
            <option value=<%=lista.get(i).getId() %>><%=lista.get(i).getNome() %></option>
            <%
            }
            %>
  </select>
  </td>
   <tr><td class="testo12" align="left" width="200px">Tipo Rapporto</td>
   <td>
   <%List<TipoRapportoDTO> listaTPR=(List<TipoRapportoDTO>)request.getSession().getAttribute("listaTipoRapporto"); %>
  <select name="tpR" id="tpR" data-placeholder="Seleziona Tipo Rapporto..." class="chosen-select" style="width:350px;" tabindex="2">
            <option value=""></option>
            <%for (int i=0; i<listaTPR.size();i++){%> 
            <option value=<%=listaTPR.get(i).getId() %>><%=listaTPR.get(i).getNoneRapporto() %></option>
            <%
            }
            %>
  </select>
   </td>
   </tr>
   <tr>
 
   </tr>
  
  </tbody>
  </table>
  <br>
  <table id="tabPM"  class="tableFormat" style=width:50%></table>
   <script type="text/javascript" src="js/scripts.js"></script>
<!--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>-->
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script> 
  <script src="js/chosen.jquery.js" type="text/javascript"></script>
  <script src="js/prism.js" type="text/javascript" charset="utf-8"></script>
<script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js" type="text/javascript" charset="utf-8"></script>
 
 
  <script type="text/javascript">
function controllaPun()
{
	var xhttp;
	
	if (window.XMLHttpRequest) {
	    xhttp = new XMLHttpRequest();
	    } else {
	    // code for IE6, IE5
	    xhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	    var table="<tr><th>Artist</th><th>Title</th></tr>";	
	     var strResponse=this.responseText;	
	     document.getElementById("tabPM").innerHTML =table;
	    }else
	    {
	    	 document.getElementById("demo").innerHTML ="none";
	    }
	  };
	  xhttp.open("POST", "controlloPM.do", true);
	  xhttp.send();
	}
	
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
	  
	  alert('raf-01 marco');
      ajaxStart: function() {  $body.addClass("loading");    },
       ajaxStop: function() { $body.removeClass("loading"); }    
  });
  
  $(document).ready(function() {
	    $('#tabella').DataTable({
	    "paging":   false,
	    "width":"50%"
	    });
	    
	    $("#tpS").change(function(e){

            //get the form data using another method 
            var tps = $("#tpS").val(); 
            dataString ="tpS="+ tps;
            
    
            //make the AJAX request, dataType is set to json
            //meaning we are expecting JSON data in response from the server
            $.ajax({
                type: "POST",
                url: "controlloPM.do",
                data: dataString,
                dataType: "json",
                
                //if received a response from the server
                success: function( data, textStatus) {
                    //our country code was correct so we have some information to display
                     $("#tabPM").html(""); 
                  //   $("#tabPM").append("<table class=sfondodati style=\"width:50%\">");
                    if(data.success){  
                    	 $("#tabPM").append("<tr><th>ID</th><th>Denominazione PM</th></tr>");
                         for(var i=0 ; i<data.dataInfo.length;i++)
                         {
                        	 $("#tabPM").append("<tr><td>"+data.dataInfo[i].id+"</td><td>"+data.dataInfo[i].nome+"</td></tr>" ); 
                         }
                     } 
                     //display error message
                     else {
                         $("#tabPM").html("<tr><td>Non ci sono tipo di misura associati</td></tr>");
                     }
                    $("#tabPM").append("</table>"); 
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
                    //enable the button 
                    $('#myButton').attr("disabled", false);
                }
      
            });        
    });
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
    
  </script>
  </form>
  <div class="modal"><!-- Place at bottom of page --></div>  
    </body>
    </html>
