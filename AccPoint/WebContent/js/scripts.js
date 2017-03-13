
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
		 $body = $("body");

		$body.addClass("loading"); 
		
		$.ajax({
            type: "POST",
            url: action,
            
            //if received a response from the server
            success: function( data, textStatus) {
            	
            	$('#corpoframe').html(data);
            	$body.removeClass("loading");
            },
            error: function( data, textStatus) {
            	
            	$('#corpoframe').html('Errore Server '+textStatus + "data "+data);
            	$body.removeClass("loading");
            }
            });
  
		
	if(navigator.appName=="Netscape" && (navigator.userAgent.indexOf('Chrome')>0 || navigator.userAgent.indexOf('Firefox')>0)){	
	//parent.corpoFrame.contentDocument.forms[0].action="/AccPoint/"+action;
	//parent.corpoFrame.contentDocument.forms[0].submit();
		// $('#frcontent').attr('action', "/AccPoint/"+action).submit();

	}
	
	else{
		// $('#frcontent').attr('action', "/AccPoint/"+action).submit();

	//parent.corpoFrame.document.forms[0].action="/AccPoint/"+action;
	//parent.corpoFrame.document.forms[0].submit();
	}
//	if(navigator.appName=="Netscape" && navigator.userAgent.indexOf('Chrome')<0){
//	parent.frames[2].document.forms[0].action="/AccPoint/"+action;
//	parent.frames[2].document.forms[0].submit();
//	}
	
	
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
   
 