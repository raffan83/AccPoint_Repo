
var data,table; 

//$body = $("body");

//$(document).on({ 
	 
  //  ajaxStart: function() { $body.addClass("loading");    },
   //  ajaxStop: function() { $body.removeClass("loading"); }    
//}); 



function Controllo() {
			if ((document.getElementById("user").value == "") || (document.getElementById("pass").value == "")) {

				return false;
			}
			else {
				callAction("login.do");   			
			}
	}
	
		function inviaRichiesta(event,obj) {
		if (event.keyCode == 13) 
    	 Controllo();
    }
	
	
	function callAction(action)
	{
		document.forms[0].action=action;
		document.forms[0].submit();
	}
	
	function explore(action)
	{

		pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal();
		$.ajax({
            type: "POST",
            url: action,
            
            //if received a response from the server
            success: function( data, textStatus) {
            	
            	$('#corpoframe').html(data);

            	pleaseWaitDiv.modal('hide');
            },
            error: function( data, textStatus) {
            	
            	$('#corpoframe').html('Errore Server '+textStatus + "data "+data);

            	pleaseWaitDiv.modal('hide');

            }
            });
  
	
	}

	function exploreModal(action,postData,container)
	{

		pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal();
		$.ajax({
            type: "POST",
            url: action,
	        data: postData,

            //if received a response from the server
            success: function( data, textStatus) {
            	
            	$(container).html(data);

            	pleaseWaitDiv.modal('hide');
            },
            error: function( data, textStatus) {
            	
            	$(container).html(data);
            	pleaseWaitDiv.modal('hide');

            }
            });
  
	
	}
	
	function soloNumeri(campo){
	if(!campo.value.match(/^\d+$/)) {
	alert("Questo campo accetta solo numeri");
	return false;
	}else
	{
	return true;
	}
	}
	

	function IsDate(txtDate){
	
	var result=true
	txtDate=txtDate.value
    try
    {
        if (txtDate.length != 10)
        {
           result=false;
        }
        else if
             (
              
                 isNaN(txtDate.substring(0, 2))       ||
                       txtDate.substring(2, 3) != "/" ||
                 isNaN(txtDate.substring(3, 5))       ||
                       txtDate.substring(5, 6) != "/" ||
                 isNaN(txtDate.substring(6, 10))
             )
        {
            result=false
        }
        else
        {
           result=true;
        }
       
        return result
    }
    catch (e)
    {
        return null;
    }
}

 
   
   
   function approvazioneFromModal(app){
  	  var str=$('#noteApp').val();

  	  if(str.length != 0){
  		  $('#myModal').modal('hide')
  		  var dataArr={"idPrenotazione" :data[0], "note":str};
            

    
            $.ajax({
          	  type: "POST",
          	  url: "gestionePrenotazione.do?param="+app,
          	  data: "dataIn="+JSON.stringify(dataArr),
          	  dataType: "json",

          	  success: function( data, textStatus) {

          		  if(data.success)
          		  { 
          if(app=="app"){
       	   $('#errorMsg').html("<h3 class='label label-primary' style=\"color:green\">Prenotazione Approvata</h3>");
          }else
          {
       	   $('#errorMsg').html("<h3 class='label label-danger'>Prenotazione Non Approvata</h3>");
          }
          			  
            
          		  }
          	  },

          	  error: function(jqXHR, textStatus, errorThrown){
          	
          		  alert('error');
          		  callAction('logout.do');
          
          	  }
            });
  	  	}else{
  	  		$('#empty').html("Il campo non pu&ograve; essere vuoto"); 
  	  	}
  	   
     }
   
   function scaricaCertificato( filename )
   {
 	  if(filename!= 'undefined')
 	  {
        explore('scaricaCertificato.do');
 	  }
 	  else
 	  {

 		  $('#myModalErrorContent').html("Cartificato non disponibile");
 		  $('#myModalError').modal();

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
 	  