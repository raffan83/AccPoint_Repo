

var data,table; 


var items_json = [];



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
				callAction("login.do","#loginForm");		
			}
	}
function Registrazione() {
	var pass = $("#passw").val();
	var cpass = $("#cpassw").val();
	if(pass!="" && pass==cpass){
		callAction("registrazione.do","#registrazione");		
	}else{
		if(pass==""){
			$("#erroMsg").html( '<label class="control-label text-red" for="inputError">Errore Compilare tutti i campi</label>');
		}else{
			$("#erroMsg").html( '<label class="control-label text-red" for="inputError">Errore Conferma Password, accertarsi di aver inserito la stessa Password</label>');
		}
		
	}
	
}
function resetPassword(){
	var username=$('#username').val();
	dataObj = {};
	dataObj.username = username;
	  if(username.length != 0){
		  pleaseWaitDiv = $('#pleaseWaitDialog');
			pleaseWaitDiv.modal();
          $.ajax({
        	  type: "POST",
        	  url: "passwordReset.do?action=resetSend",
        	  data: dataObj,
          dataType: "json",
        	  success: function( data, textStatus) {

        			pleaseWaitDiv.modal('hide');
        		  if(data.success)
        		  { 

        			  $('#report_button').hide();
    				  $('#visualizza_report').hide();
                          	$('#myModalErrorContent').html(data.messaggio);
                          	$('#myModalError').removeClass();
                      		  $('#myModalError').addClass("modal modal-success");
                      		  
                      		  $('#myModalError').modal('show');
                      		 $('#myModalError').on('hidden.bs.modal', function (e) {
                    			  callAction('login.do?action=reset');
                    		  });
                      	 
                       	 
                       
                 		
        		  }else{
        			$('#myModalErrorContent').html(data.messaggio);
  			  	$('#myModalError').removeClass();
  				$('#myModalError').addClass("modal modal-danger");  
  				$('#report_button').show();
  				$('#visualizza_report').show();
				$('#myModalError').modal('show');

        		  }
        		  
        		  
        	
        	  },

        	  error: function(jqXHR, textStatus, errorThrown){
        			pleaseWaitDiv.modal('hide');
				$('#myModalErrorContent').html(textStatus);				 
        		
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");		
				$('#report_button').show();
  				$('#visualizza_report').show();
				$('#myModalError').modal('show');
        
        	  }
          });
	  	}else{
	  		$('#erroMsg').html("Il campo non pu&ograve; essere vuoto"); 
	  	}

}

function changePassword(username,token){
	var password=$('#password').val();
	var repassword=$('#repassword').val();
	dataObj = {};
	dataObj.username = username;
	dataObj.password = password;
	dataObj.token = token;
	  if(password.length != 0 && password == repassword){
		  pleaseWaitDiv = $('#pleaseWaitDialog');
			pleaseWaitDiv.modal();
          $.ajax({
        	  type: "POST",
        	  url: "passwordReset.do?action=resetChange",
        	  data: dataObj,
          dataType: "json",
        	  success: function( data, textStatus) {

        			pleaseWaitDiv.modal('hide');
        		  if(data.success)
        		  { 

        			  $('#report_button').hide();
    				  $('#visualizza_report').hide();
                          	$('#myModalErrorContent').html(data.messaggio);
                          	$('#myModalError').removeClass();
                      		  $('#myModalError').addClass("modal modal-success");
                      		  $('#myModalError').modal('show');
                      		 $('#myModalError').on('hidden.bs.modal', function (e) {
                      			 callAction('login.do?action=reset');
                     		  });
                       	 
                       
                 		
        		  }else{
        			$('#myModalErrorContent').html(data.messaggio);
  			  	$('#myModalError').removeClass();
  				$('#myModalError').addClass("modal modal-danger");  			
  				$('#report_button').show();
  				$('#visualizza_report').show();
  				$('#myModalError').modal('show');
  			

        		  }
        		  
        		  
        	  },

        	  error: function(jqXHR, textStatus, errorThrown){
        			pleaseWaitDiv.modal('hide');
				$('#myModalErrorContent').html(textStatus);
				 
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
  				$('#visualizza_report').show();		
				$('#myModalError').modal('show');
				
		
        
        	  }
          });
	  	}else{
	  		$('#erroMsg').html("Errore inserimento password"); 
	  	}

}

	function inviaRichiesta(event,obj) {
		if (event.keyCode == 13) 
    	 Controllo();
    }
	
//	function callAction(action)
//	{
//		
////		document.forms[0].action=action;
////		document.forms[0].submit();
//	}
	
	function callAction(action,formid,loader)
	{
		if(loader){
			pleaseWaitDiv = $('#pleaseWaitDialog');
			pleaseWaitDiv.modal();
		}
		if(!formid){
			$("#callActionForm").attr("action",action);
			$("#callActionForm").submit();
		}else{
			$(formid).attr("action",action);
			$(formid).submit();
		}
//		document.forms[0].action=action;
//		document.forms[0].submit();
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

	function exploreModal(action,postData,container,callback)
	{

		pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal();
		$.ajax({
            type: "POST",
            url: action,
	        data: postData,

            //if received a response from the server
            success: function( data, textStatus) {
            	pleaseWaitDiv.modal('hide');

            	$(container).html(data);

            	if (typeof callback === "function") {

            	    	callback(data, textStatus);
            	}
            },
            error: function( data, textStatus) {
            	pleaseWaitDiv.modal('hide');

            	$(container).html(data);
            	if (typeof callback === "function") {

        	    	callback(data, textStatus);
        	}

            }
            });
  
	
	}
	
	var promise;
	
	function resetCalendar(container){
    	$(container).fullCalendar( 'destroy');
	}
	function loadCalendar(action,postData,container,callback)
	{

		pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal();
		$.ajax({
            type: "POST",
            dataType: "json",
            url: action,
	        data: postData,

            //if received a response from the server
            success: function( data, textStatus) {
            	pleaseWaitDiv.modal('hide');

            	jsonObj =  data.dataInfo.dataInfo;
            	 $(container).fullCalendar({
            		 	events:jsonObj,
            		 	selectable:true,
            		 	selectHelper: true,
            		 	eventOverlap: false,

            		 	select: function (start, end, jsEvent, view) {
//            		 	    $(container).fullCalendar('renderEvent', {
//            		 	        start: start,
//            		 	        end: end,
//            		 	        block: true,
//            		 	    } );
            		 		if(start.isBefore(moment())) {
            		 	        $(container).fullCalendar('unselect');
            		 	        $("#myModalErrorContent").html("Selezionare un range di date maggiore della data attuale");
            		 	        $("#myModalError").modal();
            		 	       
            		 	        return false;
            		 	    }
            		 		$("#myModalPrenotazione").modal();
            		 		$('#myModalPrenotazione').on('hidden.bs.modal', function (e) {
        	                      $("#noteApp").val('');
        	                      $("#emptyPrenotazione").html('');
            		 			});

            		 		var dataObj = new Object(); 
            		 		var event = new Object();
            		 		event.start = start;
            		 		event.end = end;
            		 		dataObj.event = event;
            		 		dataObj.container = container;
            		 		promise = new Promise(
            		 			    function (resolve, reject) {

            		 			    	resolve(dataObj);

            		 			    }
            		 			);
            		 		
            		 	    $(container).fullCalendar("unselect");
            		 	},
            		 	selectOverlap: function(event) {
            		 		if(event.ranges && event.ranges.length >0) {
            		 		      return (event.ranges.filter(function(range){
            		 		          return (event.start.isBefore(range.end) &&
            		 		                  event.end.isAfter(range.start));
            		 		      }).length)>0;
            		 		    }
            		 		    else {
            		 		      return !!event && event.overlap;
            		 		    }
            		 	},
            			header: {
            		        left: 'prev,next today',
            		        center: 'title',
            		        right: 'month'
            		      },
//            		    buttonText: {
//            		        today: 'today',
//            		        month: 'month'
//
//            		      },
//            			  eventRender: function(event, element, view) {
//         		             return $('<span class=\"badge bg-red bigText\"">' 
//         		             + event.title + 
//         		             '</span>');
//         		         },	 
            		  
            		           eventClick: function(calEvent, jsEvent, view) {

//            		        	   callAction('listaCampioni.do?idCampione='+calEvent.id);
//            		              // alert('Event: ' + moment(calEvent.start).format());              		
//            		             
//            		               $(this).css('border-color', 'red');

            		           },
            		         editable: true,
            		       drop: function (date, allDay) { // this function is called when something is dropped

            		         // retrieve the dropped element's stored Event Object
            		         var originalEventObject = $(this).data('eventObject');

            		         // we need to copy it, so that multiple events don't have a reference to the same object
            		         var copiedEventObject = $.extend({}, originalEventObject);

            		         // assign it the date that was reported
            		         copiedEventObject.start = date;
            		         copiedEventObject.allDay = allDay;
            		         copiedEventObject.backgroundColor = $(this).css("background-color");
            		         copiedEventObject.borderColor = $(this).css("border-color");

            		         // render the event on the calendar
            		         // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
            		         $(container).fullCalendar('renderEvent', copiedEventObject, true);

            		         // is the "remove after drop" checkbox checked?
            		         if ($('#drop-remove').is(':checked')) {
            		           // if so, remove the element from the "Draggable Events" list
            		           $(this).remove();
            		         }

            		       }
            	  }); 
            	
            	
            	
            	//$(container).html(data);

            	if (typeof callback === "function") {

            	    	callback(data, textStatus);
            	}
            },
            error: function( data, textStatus) {
            	pleaseWaitDiv.modal('hide');

            	$(container).html(data);
            	if (typeof callback === "function") {

        	    	callback(data, textStatus);
        	}

            },
            complete: function (data, textStatus){
            	pleaseWaitDiv.modal('hide');

            	if (typeof callback === "function") {

        	    	callback(data, textStatus);
            	}

            }
            });
  
	
	}
	
	function isOverlapping(event){

	    var array = $("#prenotazioneCalendario").fullCalendar('clientEvents');
	    for(i in array){
	    	
	    	var endx = event.end.format("YYYY-MM-DD");
	    	var startx = event.start.format("YYYY-MM-DD");
	    	var endy = array[i].end.format("YYYY-MM-DD");
	    	var starty = array[i].start.format("YYYY-MM-DD");
	    	
	    	
	        if (endx > starty && startx < endy){
	           return true;
	        }
	    }
	    return false;
	}
	

	function aggiungiPrenotazioneCalendario(){
		var startDatePicker = $("#datarangecalendar").data('daterangepicker').startDate;
	 	var endDatePicker = $("#datarangecalendar").data('daterangepicker').endDate;
 		var dataObj = new Object(); 
 		var event = new Object();
 		event.start = startDatePicker.add(1, 'days').utc();
 		event.end = endDatePicker.add(1, 'days').utc();
 		event.allDay = true;
 		dataObj.event = event;
 		dataObj.container = "#prenotazioneCalendario";
		
		if(isOverlapping(event)){
			$("#myModalErrorContent").html("Campione non disponibile nelle date selezionate");
 	        $("#myModalError").modal();
		}else{
		
		$("#myModalPrenotazione").modal();
 		$('#myModalPrenotazione').on('hidden.bs.modal', function (e) {
              $("#noteApp").val('');
              $("#emptyPrenotazione").html('');
 			});
 		
 		promise = new Promise(
 			    function (resolve, reject) {

 			    	resolve(dataObj);

 			    }
 			);
		}

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
  		  var dataArr={"idPrenotazione" :data[0], "nota":str};
            

    
            $.ajax({
          	  type: "POST",
          	  url: "gestionePrenotazione.do?param="+app,
          	  data: "dataIn="+JSON.stringify(dataArr),
          	  dataType: "json",

          	  success: function( data, textStatus) {

          		  
          		  if(data.success)
          		  { 
 
                   		  if(app=="app"){
                   			$('#report_button').hide();
                   			$('#visualizza_report').hide();
                   			 $('#myModalErrorContent').html("Prenotazione Approvata");
                   			$('#myModalError').removeClass();
                      		  $('#myModalError').addClass("modal modal-success");
                      		  $('#myModalError').modal('show');
                      		  $('#myModalError').on('hidden.bs.modal', function (e) {
                      			  callAction('listaPrenotazioniRichieste.do');
                      		  });

                            }else
                            {
                            	$('#myModalErrorContent').html("Prenotazione Non Approvata");
                            	$('#myModalError').removeClass();
                        		  $('#myModalError').addClass("modal modal-warning");
                        		   $('#myModalError').modal('show');
                        		  $('#myModalError').on('hidden.bs.modal', function (e) {
                        			  callAction('listaPrenotazioniRichieste.do');
                        		  });
                            }      	 
                         
                   		
          		  }else{
          			$('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");    
    				$('#report_button').show();
      				$('#visualizza_report').show();
    				$('#myModalError').modal('show');

             	

          		  }
          		  
          		  
          	
          	  },

          	  error: function(jqXHR, textStatus, errorThrown){
          	
          		$('#myModalErrorContent').html(jqXHR.responseJSON.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
  				$('#visualizza_report').show();
				$('#myModalError').modal('show');
				
         	
          
          	  }
            });
  	  	}else{
  	  		$('#empty').html("Il campo non pu&ograve; essere vuoto"); 
  	  	}
  	   
     }
   
   
   function nuovoInterventoFromModal(divID){
	   if(divID){
		   $( divID ).modal();
	   }else{
	  	$( "#myModal" ).modal();
	   }
	  	   
   }
   
   function nuovoInterventoFromModalCampionamento(codiceArticolo){
	  
	   $( "#myModal #codicearticolo" ).val(codiceArticolo);
	   $( "#myModal" ).modal();
	   
	  	   
   }
   
   function saveInterventoFromModal(idCommessa){

	   var str=$('#sede').val();
 
	  	  if(str.length != 0){
	  		  $('#myModal').modal('hide')
	  		  var dataArr={"sede":str};
	            
	  		   pleaseWaitDiv = $('#pleaseWaitDialog');
	  		   pleaseWaitDiv.modal();
	    
	            $.ajax({
	          	  type: "POST",
	          	  url: "gestioneIntervento.do?action=new",
	          	  data: "dataIn="+JSON.stringify(dataArr),
	          	  dataType: "json",

	          	  success: function( data, textStatus) {

	          		  if(data.success)
	          		  { 
	          			  	$('#errorMsg').html("<h3 class='label label-primary' style=\"color:green\">"+textStatus+"</h3>");
	          			  	//callAction("gestioneIntervento.do?idCommessa="+idCommessa);
 	          			  table = $('#tabPM').DataTable();
	          			  $('#tabPM').on( 'page.dt', function () {
	          				$('.customTooltip').tooltipster({
	          			        theme: 'tooltipster-light'
	          			    });
	          			  } );

	          	//"{"id":19,"dataCreazione":"mag 3, 2017","idSede":1,"id_cliente":7011,"nome_sede":"SEDE OPERATIVA","user":{"id":1,"user":"admin","passw":"*F28AA01DCF16C082DC04B36CB2F245431FA0CFED","nominativo":"Amministratore","nome":"Admin - Name","cognome":"Admin - Surname","indirizzo":"Via Tofaro 42/c","comune":"Sora","cap":"03039","EMail":"info@stisrl.com","telefono":"0776181501","idCompany":4132,"tipoutente":"AM"},"idCommessa":"201700001","statoIntervento":{"id":1},"pressoDestinatario":0,"company":{"id":4132,"denominazione":"STI - Sviluppo e Tecnologie Industriali S.r.l","pIva":"01862150602","indirizzo":"Via Tofaro 42/b","comune":"Sora","cap":"03039","mail":"info@stisrl.com","telefono":"0776181501","codAffiliato":"001"},"nomePack":"CM413203052017044229","nStrumentiGenerati":0,"nStrumentiMisurati":0,"nStrumentiNuovi":0,"listaInterventoDatiDTO":[]}"	
	          			intervento = JSON.parse(data.intervento);
	          			  
	          			if(intervento.pressoDestinatario == 0){
	          				presso = "IN SEDE";
	          				pressoclass = "label-success";
	          			}else if(intervento.pressoDestinatario == 1){
	          				presso = "PRESSO CLIENTE";
	          				pressoclass = "label-info";
	          			}else if(intervento.pressoDestinatario == 2){
	          				presso = "MISTO CLIENTE - SEDE";
	          				pressoclass = "label-warning";
	          			}else{
	          				presso = "-";
	          			}
	          			
	          			  var user = intervento.user;
	          			var dataCreazione = moment(intervento.dataCreazione,"MMM DD, YYYY",'it');
	          			var rowNode =  table.row.add( [
	          			        '<a class="btn" onclick="callAction(\'gestioneInterventoDati.do?idIntervento='+intervento.id+'\');">'+intervento.id+'</a>',
	          			        '<span class="label '+pressoclass+'">'+presso+'</span>',
	          			        intervento.nome_sede,dataCreazione.format('DD/MM/YYYY'),
	          			        '<span class="label label-success">APERTO</span>',
	          			        user.nominativo,
	          			      intervento.nomePack,
	          			      '<a class="btn" onclick="callAction(\'gestioneInterventoDati.do?idIntervento='+intervento.id+'\');"> <i class="fa fa-arrow-right"></i> </a>'
	          			    ] ).draw();
	          			  	
	          		
	          		  }else{
	          			$('#myModalErrorContent').html(data.messaggio);
						$('#myModalError').removeClass();
						$('#myModalError').addClass("modal modal-danger");
						$('#report_button').show();
		  				$('#visualizza_report').show();
						$('#myModalError').modal('show');

	          		  }
	          		pleaseWaitDiv.modal('hide');
	          	  },

	          	  error: function(jqXHR, textStatus, errorThrown){
	          		$('#myModalErrorContent').html(errorThrown.message);
	    		  	$('#myModalError').removeClass();
	    			$('#myModalError').addClass("modal modal-danger");
	    			$('#report_button').show();
	  				$('#visualizza_report').show();
	    			$('#myModalError').modal('show');
	    			

	          		 $('#errorMsg').html("<h3 class='label label-danger'>"+textStatus+"</h3>");
	          		  //callAction('logout.do');
	          		pleaseWaitDiv.modal('hide');
	          	  }
	            });
	  	  	}else{
	  	  		$('#empty').html("Il campo non pu&ograve; essere vuoto"); 
	  	  	}
	  	   
   }
   
   function saveInterventoCampionamentoFromModal(idCommessa){

	   var str=$('#sede').val();
	   var codiceArticolo=$('#codicearticolo').val();
	   
	  	  if(str.length != 0 && codiceArticolo.length != 0){
	  		  $('#myModal').modal('hide')
	  		  var dataArr={"sede":str,"codiceArticolo":codiceArticolo};
	            
	  		   pleaseWaitDiv = $('#pleaseWaitDialog');
	  		   pleaseWaitDiv.modal();
	    
	            $.ajax({
	          	  type: "POST",
	          	  url: "gestioneInterventoCampionamento.do?action=new",
	          	  data: "dataIn="+JSON.stringify(dataArr),
	          	  dataType: "json",

	          	  success: function( data, textStatus) {

	          		  if(data.success)
	          		  { 
	          			  	$('#errorMsg').html("<h3 class='label label-primary' style=\"color:green\">"+textStatus+"</h3>");
	          			  	//callAction("gestioneIntervento.do?idCommessa="+idCommessa);
 	          			  table = $('#tabPM').DataTable();
	          			  $('#tabPM').on( 'page.dt', function () {
		          				$('.customTooltip').tooltipster({
		          			        theme: 'tooltipster-light'
		          			    });
		          			  } );
	          	//"{"id":19,"dataCreazione":"mag 3, 2017","idSede":1,"id_cliente":7011,"nome_sede":"SEDE OPERATIVA","user":{"id":1,"user":"admin","passw":"*F28AA01DCF16C082DC04B36CB2F245431FA0CFED","nominativo":"Amministratore","nome":"Admin - Name","cognome":"Admin - Surname","indirizzo":"Via Tofaro 42/c","comune":"Sora","cap":"03039","EMail":"info@stisrl.com","telefono":"0776181501","idCompany":4132,"tipoutente":"AM"},"idCommessa":"201700001","statoIntervento":{"id":1},"pressoDestinatario":0,"company":{"id":4132,"denominazione":"STI - Sviluppo e Tecnologie Industriali S.r.l","pIva":"01862150602","indirizzo":"Via Tofaro 42/b","comune":"Sora","cap":"03039","mail":"info@stisrl.com","telefono":"0776181501","codAffiliato":"001"},"nomePack":"CM413203052017044229","nStrumentiGenerati":0,"nStrumentiMisurati":0,"nStrumentiNuovi":0,"listaInterventoDatiDTO":[]}"	
	          			intervento = JSON.parse(data.intervento);
	          			  
	          			  if(intervento.pressoDestinatario == 0){
	          				presso = "IN SEDE";
	          				pressoclass = "label-success";
	          			}else if(intervento.pressoDestinatario == 1){
	          				presso = "PRESSO CLIENTE";
	          				pressoclass = "label-info";
	          			}else if(intervento.pressoDestinatario == 2){
	          				presso = "MISTO CLIENTE - SEDE";
	          				pressoclass = "label-warning";
	          			}else{
	          				presso = "-";
	          			}
	          			
	          			  var user = intervento.user;
	          			var dataCreazione = moment(intervento.dataCreazione,"MMM DD, YYYY",'it');
	          			var rowNode =  table.row.add( [
	          			        '<a class="btn" onclick="callAction(\'gestioneInterventoDati.do?idIntervento='+intervento.id+'\');">'+intervento.id+'</a>',
	          			        '<span class="label '+pressoclass+'">'+presso+'</span>',
	          			        intervento.nome_sede,dataCreazione.format('DD/MM/YYYY'),
	          			        '<span class="label label-success">APERTO</span>',
	          			        user.nominativo,
	          			      intervento.nomePack,
	          			      '<a class="btn" onclick="callAction(\'gestioneInterventoDati.do?idIntervento='+intervento.id+'\');"> <i class="fa fa-arrow-right"></i> </a>'
	          			    ] ).draw();
	          			  	
	          		
	          		  }else{
	          			$('#myModalErrorContent').html(data.messaggio);
						$('#myModalError').removeClass();
						$('#myModalError').addClass("modal modal-danger");
						$('#report_button').show();
		  				$('#visualizza_report').show();
						$('#myModalError').modal('show');

	          		  }
	          		pleaseWaitDiv.modal('hide');
	          	  },

	          	  error: function(jqXHR, textStatus, errorThrown){
	          	

	          		 $('#errorMsg').html("<h3 class='label label-danger'>"+textStatus+"</h3>");
	          		  //callAction('logout.do');
	          		pleaseWaitDiv.modal('hide');
	          	  }
	            });
	  	  	}else{
	  	  		$('#empty').html("Il campo non pu&ograve; essere vuoto"); 
	  	  	}
	  	   
   }
   
   function scaricaCertificato( idcampione )
   {
 	  if(idcampione!= 'undefined')
 	  {
 		 callAction('scaricaCertificato.do?action=certificatoCampione&idC='+idcampione);
 	  }
 	  else
 	  {

 		  $('#myModalErrorContent').html("Cartificato non disponibile");
 		  $('#myModalError').modal();

 	  }
 	}
   
   
   
   function addCalendarStrumenti(){ 
	   
		   pleaseWaitDiv = $('#pleaseWaitDialog');
		   pleaseWaitDiv.modal();
	   $.ajax({
	          type: "POST",
	          url: "ScadenziarioCreateStrumenti.do",
	          data: "",
	          dataType: "json",
	          
	          //if received a response from the server
	          success: function( data, textStatus) {
	          	
	             	if(data.success)
	              	{
	             		
	             		 jsonObj = [];
		             		for(var i=0 ; i<data.dataInfo.length;i++)
		                    {
		             			var str =data.dataInfo[i].split(";");
		             			item = {};
		             	        item ["title"] = str[1];
		             	        item ["start"] = str[0];
		             	        item ["allDay"] = true;
		             	       item ["backgroundColor"] = "#ffbf00";
		             	      item ["borderColor"] = "#ffbf00";
		             	        jsonObj.push(item);
		              		}
	             		
		 $('#calendario').fullCalendar({
			header: {
		        left: 'prev,next today',
		        center: 'title',
		        right: 'month,agendaWeek,agendaDay'
		      },
//		    buttonText: {
//		        today: 'oggi',
//		        month: 'mese',
//		        week: 'settimana',
//		        day: 'giorno'
//		      },
			  eventRender: function(event, element, view) {
		             return $('<span class=\"badge bg-red bigText\"">' 
		             + event.title + 
		             '</span>');
		         },	 
		  events:jsonObj,
		           eventClick: function(calEvent, jsEvent, view) {

		        	//explore('listaCampioni.do?date='+moment(calEvent.start).format());
		        	
		        	callAction('listaStrumentiCalendario.do?date='+moment(calEvent.start).format());
		              // alert('Event: ' + moment(calEvent.start).format());              		
		             
		               $(this).css('border-color', 'red');

		           },
		         editable: true,
		       drop: function (date, allDay) { // this function is called when something is dropped

		         // retrieve the dropped element's stored Event Object
		         var originalEventObject = $(this).data('eventObject');

		         // we need to copy it, so that multiple events don't have a reference to the same object
		         var copiedEventObject = $.extend({}, originalEventObject);

		         // assign it the date that was reported
		         copiedEventObject.start = date;
		         copiedEventObject.allDay = allDay;
		         copiedEventObject.backgroundColor = $(this).css("background-color");
		         copiedEventObject.borderColor = $(this).css("border-color");

		         // render the event on the calendar
		         // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
		         $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);

		         // is the "remove after drop" checkbox checked?
		         if ($('#drop-remove').is(':checked')) {
		           // if so, remove the element from the "Draggable Events" list
		           $(this).remove();
		         }

		       }
	  }); 
	              	}
	            	pleaseWaitDiv.modal('hide');
		          }
		         });
	  }
 	 
   function addCalendar(){
	   $.ajax({
	          type: "POST",
	          url: "Scadenziario_create.do",
	          data: "",
	          dataType: "json",
	          
	          //if received a response from the server
	          success: function( data, textStatus) {
	          	
	             	if(data.success)
	              	{
	             		
	             		 jsonObj = [];
		             		for(var i=0 ; i<data.dataInfo.length;i++)
		                    {
		             			var str =data.dataInfo[i].split(";");
		             			item = {};
		             	        item ["title"] = str[1];
		             	        item ["start"] = str[0];
		             	        item ["allDay"] = true;
		             	       item ["backgroundColor"] = "#ffbf00";
		             	      item ["borderColor"] = "#ffbf00";
		             	        jsonObj.push(item);
		              		}
	             		
 		 $('#calendario').fullCalendar({
   			header: {
   		        left: 'prev,next today',
   		        center: 'title',
   		        right: 'month,agendaWeek,agendaDay'
   		      },
//   		    buttonText: {
//   		        today: 'today',
//   		        month: 'month',
//   		        week: 'week',
//   		        day: 'day'
//   		      },
   			  eventRender: function(event, element, view) {
		             return $('<span class=\"badge bg-red bigText\"">' 
		             + event.title + 
		             '</span>');
		         },	 
   		  events:jsonObj,
   		           eventClick: function(calEvent, jsEvent, view) {

   		        	//explore('listaCampioni.do?date='+moment(calEvent.start).format());
   		        	
   		        	callAction('listaCampioni.do?date='+moment(calEvent.start).format());
   		              // alert('Event: ' + moment(calEvent.start).format());              		
   		             
   		               $(this).css('border-color', 'red');

   		           },
   		         editable: true,
   		       drop: function (date, allDay) { // this function is called when something is dropped

   		         // retrieve the dropped element's stored Event Object
   		         var originalEventObject = $(this).data('eventObject');

   		         // we need to copy it, so that multiple events don't have a reference to the same object
   		         var copiedEventObject = $.extend({}, originalEventObject);

   		         // assign it the date that was reported
   		         copiedEventObject.start = date;
   		         copiedEventObject.allDay = allDay;
   		         copiedEventObject.backgroundColor = $(this).css("background-color");
   		         copiedEventObject.borderColor = $(this).css("border-color");

   		         // render the event on the calendar
   		         // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
   		         $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);

   		         // is the "remove after drop" checkbox checked?
   		         if ($('#drop-remove').is(':checked')) {
   		           // if so, remove the element from the "Draggable Events" list
   		           $(this).remove();
   		         }

   		       }
   	  }); 
	              	}
		            	
		          }
		         });
 	  }
   
   var campioneSelected=null;
   function prenotazioneFromModal(){
	   promise.then(function (data) { 
			var nota = $("#noteApp").val();
			if(nota!=""){


		   $.ajax({
	            type: "POST",
	            url: "gestionePrenotazione.do?param=pren",
	            dataType: "json",
	            data: "dataIn={'campione':"+JSON.stringify(campioneSelected)+",'start':'"+data.event.start.toISOString()+"','end':'"+data.event.end.toISOString()+"','nota':'"+nota+"'}",
	            //if received a response from the server
	            success: function( dataResp, textStatus) {
	            
	            	   $(data.container).fullCalendar('renderEvent', {
	           	        start: data.event.start,
	           	        end: data.event.end,
	           	        block: true,
	           	        title: nota,
	           	        color: "#ffbf00",
	           	 	    	} );
	                      
	            	   
	                    $("#noteApp").val('');
	                    $("#emptyPrenotazione").html('');
	                    $("#myModalPrenotazione").modal('hide');
	            	pleaseWaitDiv.modal('hide');
	            	
	            	
	            	 if(dataResp.success)
	          		  { 
	            		 $('#report_button').hide();
	       				$('#visualizza_report').hide();
              			 $('#myModalErrorContent').html("Richiesta prenotazione effettuata con successo");
              			$('#myModalError').removeClass();
                 		  $('#myModalError').addClass("modal modal-success");
                 		  $('#myModalError').modal('show');
                 		 
	 
	                         
	                   		
	          		  }else{
	          			$('#myModalErrorContent').html(dataResp.messaggio);
	    			  	$('#myModalError').removeClass();
	    				$('#myModalError').addClass("modal modal-danger");
	    				$('#report_button').show();
	      				$('#visualizza_report').show();
						$('#myModalError').modal('show');

	          		  }
	            	
	            },
	            error: function( data, textStatus) {

	                console.log(data);

	                $('#myModalErrorContent').html('Errore richiesta prenotazione');
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
      				$('#visualizza_report').show();
					$('#myModalError').modal('show');
				

	            	pleaseWaitDiv.modal('hide');

	            }
	            });
		   
		
			}else{
				$("#emptyPrenotazione").html('Inserire una nota');
			}

       });
   }
   function scaricaPacchetti(){


 	
  
   }
   function scaricaPacchetto(filename){

     	callAction('scaricoStrumento.do?filename='+filename);

  }
   function scaricaPacchettoUploaded(filename){

    	callAction('scaricoPackGenerato.do?filename='+filename);

 }
   function scaricaPacchettoCampionamento(filename){

    	callAction('scaricoPacchettoCampionamento.do?filename='+filename);

 }
   
  function enableInput(container){
	  
	  if(container == "#datipersonali"){
		  $("#datipersonali #indirizzoUsr").prop('disabled', false);
		  $("#datipersonali #comuneUsr").prop('disabled', false);
		  $("#datipersonali #capUsr").prop('disabled', false);
		  $("#datipersonali #emailUsr").prop('disabled', false);
		  $("#datipersonali #telUsr").prop('disabled', false);
		  $("#datipersonali #modificaUsr").prop('disabled', true);
		  $("#datipersonali #inviaUsr").prop('disabled', false);

		  
	  }else if(container == "#datiazienda"){

		  $("#datiazienda #indCompany").prop('disabled', false);
		  $("#datiazienda #comuneCompany").prop('disabled', false);
		  $("#datiazienda #capCompany").prop('disabled', false);
		  $("#datiazienda #emailCompany").prop('disabled', false);
		  $("#datiazienda #telCompany").prop('disabled', false);
		  $("#datiazienda #modificaCompany").prop('disabled', true);
		  $("#datiazienda #inviaCompany").prop('disabled', false);
	  }
	  
  }

  function salvaUsr(){
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  
	  var jsonData = {};	  
	  jsonData.indirizzoUsr =  $("#datipersonali #indirizzoUsr").val();
	  jsonData.comuneUsr =  $("#datipersonali #comuneUsr").val();
	  jsonData.capUsr =  $("#datipersonali #capUsr").val();
	  jsonData.emailUsr =  $("#datipersonali #emailUsr").val();
	  jsonData.telUsr =  $("#datipersonali #telUsr").val();
	  
	  $.ajax({
          type: "POST",
          url: "salvaUtente.do",
          data: "dataIn="+JSON.stringify(jsonData),
          //if received a response from the server
          success: function( dataResp, textStatus) {
        	  var dataRsp = JSON.parse(dataResp);
        	  if(dataRsp.success)
      		  {
        		  $("#datipersonali #indirizzoUsr").prop('disabled', true);
        		  $("#datipersonali #comuneUsr").prop('disabled', true);
        		  $("#datipersonali #capUsr").prop('disabled', true);
        		  $("#datipersonali #emailUsr").prop('disabled', true);
        		  $("#datipersonali #telUsr").prop('disabled', true);
        		  $("#datipersonali #modificaUsr").prop('disabled', false);
        		  $("#datipersonali #inviaUsr").prop('disabled', true);
        		  
        		  $("#usrError").html('<h5>Modifica eseguita con successo</h5>');
        		  $("#usrError").addClass("callout callout-success");
      		  }else{
      			$("#usrError").html('<h5>Errore salvataggio Utente</h5>');
      			$("#usrError").addClass("callout callout-danger");
      		  }
        	  pleaseWaitDiv.modal('hide');
          },
          error: function( data, textStatus) {

              console.log(data);
              $("#usrError").html('<h5>Errore salvataggio Utente</h5>');
              $("#usrError").addClass("callout callout-danger");


          	pleaseWaitDiv.modal('hide');

          }
          });
	  
	  
	  

  }
  
  function salvaCompany(){
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  
	  var jsonData = {};	  
	  jsonData.indCompany =  $("#datiazienda #indCompany").val();
	  jsonData.comuneCompany =  $("#datiazienda #comuneCompany").val();
	  jsonData.capCompany =  $("#datiazienda #capCompany").val();
	  jsonData.emailCompany =  $("#datiazienda #emailCompany").val();
	  jsonData.telCompany =  $("#datiazienda #telCompany").val();
	  jsonData.modificaCompany =  $("#datiazienda #modificaCompany").val();
	  jsonData.inviaCompany =  $("#datiazienda #inviaCompany").val();
	  
	  $.ajax({
          type: "POST",
          url: "salvaCompany.do",
          data: "dataIn="+JSON.stringify(jsonData),
          //if received a response from the server
          success: function( dataResp, textStatus) {
        	  var dataRsp = JSON.parse(dataResp);
        	  if(dataRsp.success)
      		  {
        		  $("#datiazienda #indCompany").prop('disabled', true);
        		  $("#datiazienda #comuneCompany").prop('disabled', true);
        		  $("#datiazienda #capCompany").prop('disabled', true);
        		  $("#datiazienda #emailCompany").prop('disabled', true);
        		  $("#datiazienda #telCompany").prop('disabled', true);
        		  $("#datiazienda #modificaCompany").prop('disabled', false);
        		  $("#datiazienda #inviaCompany").prop('disabled', true);
        		  
        		  $("#companyError").html('<h5>Modifica eseguita con successo</h5>');
        		  $("#companyError").addClass("callout callout-success");
      		  }else{
      			$("#companyError").html('<h5>Errore salvataggio Azienda</h5>');
      			$("#companyError").addClass("callout callout-danger");
      		  }
        	  pleaseWaitDiv.modal('hide');
          },
          error: function( data, textStatus) {

              console.log(data);
              $("#companyError").html('<h5>Errore salvataggio Azienda</h5>');
              $("#companyError").addClass("callout callout-danger");


          	pleaseWaitDiv.modal('hide');

          }
          });
	  

	
  }
  
  function saveValoriCampione(idC){
	 // alert($('#tblAppendGrid_unita_misura_1').val());
	//	alert($('#tblAppendGrid_tipo_grandezza_1').val());
	  var valid=true;
	  var count = $('#tblAppendGrid').appendGrid('getRowCount'), index = '';
      for (var z = 0; z < count; z++) {

        	  var elem1 = $('#tblAppendGrid').appendGrid('getCellCtrl', 'incertezza_assoluta', z);
        	  var elem2 = $('#tblAppendGrid').appendGrid('getCellCtrl', 'incertezza_relativa', z);
        	  if(elem1.value=="" && elem2.value==""){
        		  valid = false;
        	  }
      }
     
//      corrispondenze = 0;
//      $('#tblAppendGrid tbody tr').each(function(){
//			var td = $(this).find('td').eq(1);
//			attr = td.attr('id');
//		    valore = $("#" + attr  + " input").val();
//		    
//		    $('#tblAppendGrid tbody tr').each(function(){
//				var td2 = $(this).find('td').eq(1);
//				attr2 = td2.attr('id');
//			    valore2 = $("#" + attr2  + " input").val();
//
//			    if(valore == valore2){
//			    	corrispondenze++;
//			    }
//			    	
//			});
//
//		});
//      validCorr = true;
//	  if(corrispondenze > 0 && $('#interpolato').val()==0){
//		  validCorr = false;
//	  }
//	  
	  var jsonMap = {};
	  $('#tblAppendGrid tbody tr').each(function(){
			var td = $(this).find('td').eq(1);
			attr = td.attr('id');
		    valore = $("#" + attr  + " input").val();

			    if(jsonMap[valore]){
			    	jsonMap[valore] ++;
			    }else{
			    	jsonMap[valore]=1;
			    }


		});
	  validCorr = true;
	  validCorr2 = true;
	  $.each(jsonMap, function() {
		  if(this<2 && $('#interpolato').val()==1){
			  validCorr2 = false;
		  }
		  if(this>1 && $('#interpolato').val()==0){
			  validCorr = false;
		  }
		});
	  
	  
	  if($("#formAppGrid").valid() && valid && validCorr && validCorr2){
		 
	  $.ajax({
          type: "POST",
          url: "modificaValoriCampione.do?view=save&idC="+idC,
          data: $( "#formAppGrid" ).serialize(),
          //if received a response from the server
          success: function( dataResp, textStatus) {
        	  var dataRsp = JSON.parse(dataResp);
        	  if(dataRsp.success)
      		  { 
               		  $("#ulError").html("<span class='label label-danger'>Modifica eseguita con successo</span>");
               		$('#report_button').hide();
      				$('#visualizza_report').hide();
               		  $('#myModalSuccessContent').html("Salvataggio effettuato con successo, click su Chiudi per tornare alla lista dei campioni");
               		  $('#myModalSuccess').addClass("modal modal-success");
               		  $('#myModalSuccess').modal('show');
               		  $('#myModalSuccess').on('hidden.bs.modal', function (e) {
               			  callAction('listaCampioni.do');
               		  });
                            	 
                     
               		
      		  }else{
      			$('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
  				$('#visualizza_report').show();
				$('#myModalError').modal('show');
			
         		
				$("#ulError").html("<span class='label label-danger'>Errore salvataggio</span>");


      		  }
        	  pleaseWaitDiv.modal('hide');
          },
          error: function( data, textStatus) {

              console.log(data);
     		  $("#ulError").html("<span class='label label-danger'>Errore salvataggio</span>");
     		  
     		 $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
  				$('#visualizza_report').show();
				$('#myModalError').modal('show');
				


          	pleaseWaitDiv.modal('hide');

          }
          });
	  }else{
		  $("#ulError").html("<span class='label label-danger'>Compilare tutti i campi obbligatori</span>");
		  if(!valid){
			  $("#ulError").html("<span class='label label-danger'>Compilare tutti i campi obbligatori. Insereire Incertezza Assoluta o Incertezza Relativa</span>");
		  }
		  if(!validCorr){
			  $("#ulError").html("<span class='label label-danger'>I parametri di taratura devono essere univoci.</span>");
		  }
		  if(!validCorr2){
			  $("#ulError").html("<span class='label label-danger'>Lo stesso parametro di taratura deve essere presente almeno 2 volte.</span>");
		  }
	  }
  }
  
  function nuovoStrumento(idSede,idCliente){

	  var ref_stato_strumento=$('#ref_stato_strumento').val();
	  var denominazione=$('#denominazione').val();
	  var codice_interno=$('#codice_interno').val();
	  var costruttore=$('#costruttore').val();
	  var modello=$('#modello').val();
	  var matricola=$('#matricola').val();
	  var risoluzione=$('#risoluzione').val();
	  var campo_misura=$('#campo_misura').val();
	  var ref_tipo_strumento=$('#ref_tipo_strumento').val();
	  var freq_mesi=$('#freq_mesi').val();
	  var dataUltimaVerifica=$('#dataUltimaVerifica').val();
	  var dataProssimaVerifica=$('#dataProssimaVerifica').val();
	  var ref_tipo_rapporto=$('#ref_tipo_rapporto').val();
	  var reparto=$('#reparto').val();
	  var utilizzatore=$('#utilizzatore').val();
	  var note=$('#note').val();
	  var luogo_verifica=$('#luogo_verifica').val();
	  var interpolazione=$('#interpolazione').val();
	  var classificazione=$('#classificazione').val();

	  		
	  		  var dataObj = {};
	          
	  		dataObj.idSede = idSede;
	  		dataObj.idCliente = idCliente;
	  		dataObj.ref_stato_strumento = ref_stato_strumento;
	  		dataObj.denominazione = denominazione;
	  		dataObj.codice_interno = codice_interno;
	  		dataObj.costruttore = costruttore;
	  		dataObj.modello = modello;
	  		dataObj.matricola = matricola;
	  		dataObj.risoluzione = risoluzione;
	  		dataObj.campo_misura = campo_misura;
	  		dataObj.freq_mesi = freq_mesi;
	  		dataObj.dataUltimaVerifica = dataUltimaVerifica;
	  		dataObj.ref_tipo_strumento = ref_tipo_strumento;
	  		dataObj.dataProssimaVerifica = dataProssimaVerifica;
	  		dataObj.ref_tipo_rapporto = ref_tipo_rapporto;
	    
	  		dataObj.reparto = reparto;
	  		dataObj.utilizzatore = utilizzatore;
	  		dataObj.note = note;
	  		dataObj.luogo_verifica = luogo_verifica;
	  		dataObj.interpolazione = interpolazione;
	  		dataObj.classificazione = classificazione;
	  		
	  		
	            $.ajax({
	          	  type: "POST",
	          	  url: "nuovoStrumento.do",
	          	  data: dataObj,
	          	  dataType: "json",

	          	  success: function( data, textStatus) {

	          		  if(data.success)
	          		  { 
	          			$('#report_button').hide();
	      				$('#visualizza_report').hide();
	          			  $('#modalNuovoStrumento').modal('hide');
	          			  dataString ="idSede="+ idSede+";"+idCliente;
	          	          exploreModal("listaStrumentiSedeNew.do",dataString,"#posTab",function(datab,textStatusb){
	          	        	 // $('#errorMsg').html("<h3 class='label label-success' style=\"color:green\">"+data.messaggio+"</h3>");
	          	        	  $("#myModalErrorContent").html(data.messaggio);
	          	        	  $('#myModalError').addClass("modal modal-success");
		          			 $("#myModalError").modal();
	          	          });
	          			  	
	          		
	          		  }else{
	          			// $('#empty').html("<h3 class='label label-error' style=\"color:green\">"+data.messaggio+"</h3>");
	          			 $("#myModalErrorContent").html(data.messaggio);
	          			$('#myModalError').addClass("modal modal-danger");
	          			$('#report_button').show();
	      				$('#visualizza_report').show();
						$('#myModalError').modal('show');

	          		  }
	          	  },

	          	  error: function(jqXHR, textStatus, errorThrown){
	          	

	          		// $('#empty').html("<h3 class='label label-danger'>"+textStatus+"</h3>");
	          		$("#myModalErrorContent").html(textStatus);
	          		$('#myModalError').addClass("modal modal-danger");
	          		$('#report_button').show();
	  				$('#visualizza_report').show();
					$('#myModalError').modal('show');

	          
	          	  }
	            });
	  	  	
	  	   
  }
  
  
//  function nuovoStrumentoFromPacco(idSede,idCliente){
//
//	  var ref_stato_strumento=$('#ref_stato_strumento').val();
//	  var denominazione=$('#denominazione').val();
//	  var codice_interno=$('#codice_interno').val();
//	  var costruttore=$('#costruttore').val();
//	  var modello=$('#modello').val();
//	  var matricola=$('#matricola').val();
//	  var risoluzione=$('#risoluzione').val();
//	  var campo_misura=$('#campo_misura').val();
//	  var ref_tipo_strumento=$('#ref_tipo_strumento').val();
//	  var freq_mesi=$('#freq_mesi').val();
//	  var dataUltimaVerifica=$('#dataUltimaVerifica').val();
//	  var dataProssimaVerifica=$('#dataProssimaVerifica').val();
//	  var ref_tipo_rapporto=$('#ref_tipo_rapporto').val();
//	  var reparto=$('#reparto').val();
//	  var utilizzatore=$('#utilizzatore').val();
//	  var note=$('#note').val();
//	  var luogo_verifica=$('#luogo_verifica').val();
//	  var interpolazione=$('#interpolazione').val();
//	  var classificazione=$('#classificazione').val();
//
//	  		
//	  		  var dataObj = {};
//	          
//	  		dataObj.idSede = idSede;
//	  		dataObj.idCliente = idCliente;
//	  		dataObj.ref_stato_strumento = ref_stato_strumento;
//	  		dataObj.denominazione = denominazione;
//	  		dataObj.codice_interno = codice_interno;
//	  		dataObj.costruttore = costruttore;
//	  		dataObj.modello = modello;
//	  		dataObj.matricola = matricola;
//	  		dataObj.risoluzione = risoluzione;
//	  		dataObj.campo_misura = campo_misura;
//	  		dataObj.freq_mesi = freq_mesi;
//	  		dataObj.dataUltimaVerifica = dataUltimaVerifica;
//	  		dataObj.ref_tipo_strumento = ref_tipo_strumento;
//	  		dataObj.dataProssimaVerifica = dataProssimaVerifica;
//	  		dataObj.ref_tipo_rapporto = ref_tipo_rapporto;
//	    
//	  		dataObj.reparto = reparto;
//	  		dataObj.utilizzatore = utilizzatore;
//	  		dataObj.note = note;
//	  		dataObj.luogo_verifica = luogo_verifica;
//	  		dataObj.interpolazione = interpolazione;
//	  		dataObj.classificazione = classificazione;
//	  		
//	  		
//	            $.ajax({
//	          	  type: "POST",
//	          	  url: "nuovoStrumento.do",
//	          	  data: dataObj,
//	          	  dataType: "json",
//
//	          	  success: function( data, textStatus) {
//
//	          		  if(data.success)
//	          		  { 
//	          			  $('#modalNuovoStrumento').modal('hide');
//	          			
//	          			  dataString = "tipo_item="+"1"+"&id_cliente="+idCliente+"&id_sede="+idSede;
//	          			  exploreModal("listaItem.do",dataString,"#listaItem",function(datab,textStatusb){
//	          				  
//	          				  $("#myModalErrorContent").html(data.messaggio);
//	          	        	  $('#myModalError').addClass("modal modal-success");
//		          			 $("#myModalError").modal();
//	          	 		  
//	          	          });
//	          		  $("#myModalItem").modal('show');
//	          		
//	          		  }else{
//	          			// $('#empty').html("<h3 class='label label-error' style=\"color:green\">"+data.messaggio+"</h3>");
//	          			 $("#myModalErrorContent").html(data.messaggio);
//	          			$('#myModalError').addClass("modal modal-danger");
//	          			 $("#myModalError").modal();
//	          		  }
//	          	  },
//
//	          	  error: function(jqXHR, textStatus, errorThrown){
//	          	
//
//	          		// $('#empty').html("<h3 class='label label-danger'>"+textStatus+"</h3>");
//	          		$("#myModalErrorContent").html(textStatus);
//	          		$('#myModalError').addClass("modal modal-danger");
//         			 $("#myModalError").modal();
//	          
//	          	  }
//	            });
//	  	  	
//	  	   
//  }
  
  
  function nuovoStrumentoFromPacco(idSede,idCliente, id_pacco){

	  var quantita_strumento = $('#quantita_strumento').val();
	  var ref_tipo_strumento=$('#ref_tipo_strumento').val();
	  var freq_mesi=$('#freq_mesi').val();
	  var dataUltimaVerifica=$('#dataUltimaVerifica').val();
	  var dataProssimaVerifica=$('#dataProssimaVerifica').val();
	  var ref_tipo_rapporto=$('#ref_tipo_rapporto').val();
	  var classificazione=$('#classificazione').val();

	  		
	  		  var dataObj = {};
	        
	  		dataObj.id_pacco = id_pacco;	        
	  		dataObj.idSede = idSede;
	  		dataObj.idCliente = idCliente;
	  		dataObj.quantita = quantita_strumento;
	  		dataObj.freq_mesi = freq_mesi;
	  		dataObj.dataUltimaVerifica = dataUltimaVerifica;
	  		dataObj.tipo_strumento = ref_tipo_strumento;
	  		dataObj.dataProssimaVerifica = dataProssimaVerifica;
	  		dataObj.ref_tipo_rapporto = ref_tipo_rapporto;
	  		dataObj.classificazione = classificazione;
	  		
	  		
	            $.ajax({
	          	  type: "POST",
	          	  url: "nuovoStrumento.do?action=nuovo_strumento_pacco",
	          	  data: dataObj,
	          	  dataType: "json",

	          	  success: function( data, textStatus) {

	          		  if(data.success)
	          		  { 
	          			  $('#modalNuovoStrumento').modal('hide');
	          			$('#report_button').hide();
	      				$('#visualizza_report').hide();
	          			  dataString = "tipo_item="+"1"+"&id_cliente="+idCliente+"&id_sede="+idSede;
	          			  exploreModal("listaItem.do",dataString,"#listaItem",function(datab,textStatusb){
	          				  
	          				  $("#myModalErrorContent").html(data.messaggio);
	          	        	  $('#myModalError').addClass("modal modal-success");
		          			 $("#myModalError").modal();
	          	 		  
	          	          });
	          		  $("#myModalItem").modal('show');
	          		
	          		  }else{
	          			// $('#empty').html("<h3 class='label label-error' style=\"color:green\">"+data.messaggio+"</h3>");
	          			 $("#myModalErrorContent").html(data.messaggio);
	          			$('#myModalError').addClass("modal modal-danger");
	          			$('#report_button').show();
	      				$('#visualizza_report').show();
						$('#myModalError').modal('show');

	          		  }
	          	  },

	          	  error: function(jqXHR, textStatus, errorThrown){
	          	

	          		// $('#empty').html("<h3 class='label label-danger'>"+textStatus+"</h3>");
	          		$("#myModalErrorContent").html(textStatus);
	          		$('#myModalError').addClass("modal modal-danger");
	          		$('#report_button').show();
	  				$('#visualizza_report').show();
					$('#myModalError').modal('show');
					
	          
	          	  }
	            });
	  	  	
	  	   
  }
  
  
  function modificaStrumento(idSede,idCliente,idStrumento){

 	  var denominazione=$('#denominazione_mod').val();
	  var codice_interno=$('#codice_interno_mod').val();
	  var costruttore=$('#costruttore_mod').val();
	  var modello=$('#modello_mod').val();
	  var matricola=$('#matricola_mod').val();
	  var risoluzione=$('#risoluzione_mod').val();
	  var campo_misura=$('#campo_misura_mod').val();
	  var ref_tipo_strumento=$('#ref_tipo_strumento_mod').val();
 	  var reparto=$('#reparto_mod').val();
	  var utilizzatore=$('#utilizzatore_mod').val();
	  var note=$('#note_mod').val();
	  var luogo_verifica=$('#luogo_verifica_mod').val();
	  //var interpolazione=$('#interpolazione_mod').val();
	  var classificazione=$('#classificazione_mod').val();

	  		
	  		  var dataObj = {};
	          
	  		dataObj.idSede = idSede;
	  		dataObj.idCliente = idCliente;
 	  		dataObj.denominazione = denominazione;
	  		dataObj.codice_interno = codice_interno;
	  		dataObj.costruttore = costruttore;
	  		dataObj.modello = modello;
	  		dataObj.matricola = matricola;
	  		dataObj.risoluzione = risoluzione;
	  		dataObj.campo_misura = campo_misura;
 	  		dataObj.ref_tipo_strumento = ref_tipo_strumento;
 	    
	  		dataObj.reparto = reparto;
	  		dataObj.utilizzatore = utilizzatore;
	  		dataObj.note = note;
	  		dataObj.luogo_verifica = luogo_verifica;
	  		//dataObj.interpolazione = interpolazione;
	  		dataObj.classificazione = classificazione;
	  		
	  		
	            $.ajax({
	          	  type: "POST",
	          	  url: "modificaStrumento.do?action=salva&id="+idStrumento,
	          	  data: dataObj,
	          	  dataType: "json",

	          	  success: function( data, textStatus) {

	          		  if(data.success)
	          		  { 
	          			  
	          			  dataString ="idSede="+ idSede+";"+idCliente;
	          	          exploreModal("listaStrumentiSedeNew.do",dataString,"#posTab",function(datab,textStatusb){
	          	        	 // $('#errorMsg').html("<h3 class='label label-success' style=\"color:green\">"+data.messaggio+"</h3>");
	          	        	$('#report_button').hide();
	          				$('#visualizza_report').hide();
	          	        	  $('#myModalError').removeClass();
	          				$('#myModalError').addClass("modal modal-success");
	          	        	  $("#myModalErrorContent").html(data.messaggio);
	          	        	$('#myModal').modal('hide');
		          			 $("#myModalError").modal('show');
		          			
	          	          });
	          			  	
	          		
	          		  }else{
	          			// $('#empty').html("<h3 class='label label-error' style=\"color:green\">"+data.messaggio+"</h3>");
	          			 $("#myModalErrorContent").html(data.messaggio);
	          			$('#myModalError').removeClass();
          				$('#myModalError').addClass("modal modal-danger");
          				$('#report_button').show();
          				$('#visualizza_report').show();
						$('#myModalError').modal('show');
						
	          		  }
	          	  },

	          	  error: function(jqXHR, textStatus, errorThrown){
	          	

	          		// $('#empty').html("<h3 class='label label-danger'>"+textStatus+"</h3>");
	          		$("#myModalErrorContent").html(textStatus);
	          		$('#report_button').show();
	  				$('#visualizza_report').show();
					$('#myModalError').modal('show');
					
	          
	          	  }
	            });
	  	  	
	  	   
  }
  function modificaCampione(idCamampione){
	  
	  var form = $('#aggiorna form')[0]; 
	  var formData = new FormData(form);
	  
	 
		var desc = $("#aggiorna #descrizione").val();
          $.ajax({
        	  type: "POST",
        	  url: "gestioneCampione.do?action=modifica&id="+idCamampione,
        	  data: formData,
        	  //dataType: "json",
        	  contentType: false, // NEEDED, DON'T OMIT THIS (requires jQuery 1.6+)
        	  processData: false, // NEEDED, DON'T OMIT THIS
        	  //enctype: 'multipart/form-data',
        	  success: function( data, textStatus) {

        		  if(data.success)
        		  { 
        			  $('#myModal').modal('hide');
        			  callAction("listaCampioni.do");
        			  dataString ="";

        			  	
        		
        		  }else
        		  {
        			$('#errorModifica').html("<h3 class='label label-danger' style=\"color:green\">Errore Salvataggio Campione</h3>");
        			 
        		  }
        	  },

        	  error: function(jqXHR, textStatus, errorThrown){
        	

        		 $('#errorModifica').html("<h3 class='label label-danger'>"+jqXHR.responseJSON.messaggio+"</h3>");
        		  //callAction('logout.do');
        
        	  }
          });
	  
  }
  function toggleFuoriServizio(idStrumento,idSede,idCliente){
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();  
	  $.ajax({
    	  type: "POST",
    	  url: "gestioneStrumento.do?action=toggleFuoriServizio&idStrumento="+idStrumento+"&idSede="+idSede+"&idCliente="+idCliente,
    	  dataType: "json",
    	  success: function( data, textStatus) {

    		  if(data.success)
    		  { 
    			  //callAction("listaStrumentiNew.do");
    			  
    			  stato = $('#stato_'+idStrumento).html();
    			  
    			  if(stato == "In servizio"){
    				  $('#stato_'+idStrumento).html("Fuori servizio");

     			  }else{
    				  $('#stato_'+idStrumento).html("In servizio");


     			  }
    			  //exploreModal("dettaglioStrumento.do","id_str="+datax[0],"#dettaglio");
    			  exploreModal("dettaglioStrumento.do","id_str="+idStrumento,"#dettaglio");
    			  pleaseWaitDiv.modal('hide');  
    			  $('#report_button').hide();
    				$('#visualizza_report').hide();
    			  $("#myModalErrorContent").html("Stato Strumento salvato con successo");
		 	        $("#myModalError").modal();



    		  }else{
    			  pleaseWaitDiv.modal('hide');  
    			  $('#report_button').show();
    				$('#visualizza_report').show();
    			 $("#myModalErrorContent").html("Errore Salvataggio Strumento");
		 	        $("#myModalError").modal();
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    	

    		 $("#myModalErrorContent").html(textStatus);
    		 $('#report_button').show();
				$('#visualizza_report').show();
				$('#myModalError').modal('show');
				
    		  //callAction('logout.do');
    
    	  }
      });
	  
  }
  function generacsv(){
	  
	  var lineArray = [];
	  var lineHeader = "parametri_taratura;valore_nominale;valore_taratura;incertezza_assoluta;incertezza_relativa;divisione_UM;tipo_grandezza;unita_misura;id";
      lineArray.push(index == 0 ? "data:text/csv;charset=utf-8," + lineHeader : lineHeader);
      
	  var count = $('#tblAppendGrid').appendGrid('getRowCount'), index = '';
      for (var z = 0; z < count; z++) {
    	  	  var infoArray = [];
        	  var elem1 = $('#tblAppendGrid').appendGrid('getCellCtrl', 'parametri_taratura', z).value;
        	  var elem2 = $('#tblAppendGrid').appendGrid('getCellCtrl', 'valore_nominale', z).value;
        	  var elem3 = $('#tblAppendGrid').appendGrid('getCellCtrl', 'valore_taratura', z).value;
        	  var elem4 = $('#tblAppendGrid').appendGrid('getCellCtrl', 'incertezza_assoluta', z).value;
        	  var elem5 = $('#tblAppendGrid').appendGrid('getCellCtrl', 'incertezza_relativa', z).value;
        	  var elem6 = $('#tblAppendGrid').appendGrid('getCellCtrl', 'divisione_UM', z).value;
        	  var elem7 = $('#tblAppendGrid').appendGrid('getCellCtrl', 'tipo_grandezza', z).value;
        	  var elem8 = $('#tblAppendGrid').appendGrid('getCellCtrl', 'unita_misura', z).value;
        	  var elem9 = $('#tblAppendGrid').appendGrid('getCellCtrl', 'id', z).value;
        	 
        	  infoArray.push(elem1);
        	  infoArray.push(elem2);
        	  infoArray.push(elem3);
        	  infoArray.push(elem4);
        	  infoArray.push(elem5);
        	  infoArray.push(elem6);
        	  infoArray.push(elem7);
        	  infoArray.push(elem8);
        	  infoArray.push(elem9);
        	  
        	  var line = infoArray.join(";");
    	      lineArray.push(line);
      }
	      

	  var csvContent = lineArray.join("\n");
	  var hiddenElement = document.createElement('a');
	    hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csvContent);
	    hiddenElement.target = '_blank';
	    hiddenElement.download = 'exportData.csv';
	    hiddenElement.click();
  }
  function nuovoCampione(){
	 
	  var form = $('#formNuovoCampione')[0]; 
	  var formData = new FormData(form);
	  
	  
	  var valid=true;
	  var count = $('#tblAppendGrid').appendGrid('getRowCount'), index = '';
      for (var z = 0; z < count; z++) {

        	  var elem1 = $('#tblAppendGrid').appendGrid('getCellCtrl', 'incertezza_assoluta', z);
        	  var elem2 = $('#tblAppendGrid').appendGrid('getCellCtrl', 'incertezza_relativa', z);
        	  if(elem1.value=="" && elem2.value==""){
        		  valid = false;
        	  }
      }
//      corrispondenze = 0;
//      $('#tblAppendGrid tbody tr').each(function(){
//			var td = $(this).find('td').eq(1);
//			attr = td.attr('id');
//		    valore = $("#" + attr  + " input").val();
//		    
//		    $('#tblAppendGrid tbody tr').each(function(){
//				var td2 = $(this).find('td').eq(1);
//				attr2 = td2.attr('id');
//			    valore2 = $("#" + attr2  + " input").val();
//
//			    if(valore == valore2){
//			    	corrispondenze++;
//			    }
//			    	
//			});
//
//		});
//      validCorr = true;
//	  if(corrispondenze >0 && $('#interpolato').val()==0){
//		  validCorr = false;
//	  }
	  
	  var jsonMap = {};
	  
	  
	  $('#tblAppendGrid tbody tr').each(function(){
			var td = $(this).find('td').eq(1);
			attr = td.attr('id');
		    valore = $("#" + attr  + " input").val();
		    if(typeof valore !== "undefined") 
		    {
			    if(jsonMap[valore]){
			    	jsonMap[valore] ++;
			    }else{
			    	jsonMap[valore]=1;
			    }
		    }

		});
	  validCorr = true;
	  validCorr2 = true;
	
	  $.each(jsonMap, function() {
		  if(this<2 && $('#interpolato').val()==1){
			  validCorr2 = false;
		  }
		  if(this>1 && $('#interpolato').val()==0){
			  validCorr = false;
		  }
		});
	  
	  
	  if($("#formNuovoCampione").valid() && valid && validCorr2 && validCorr){
	  
	  var form = $('#formNuovoCampione')[0]; 
	  var formData = new FormData(form);
	  formData.append("datagrid",$( "#formNuovoCampione" ).serialize());
          $.ajax({
        	  type: "POST",
        	  url: "gestioneCampione.do?action=nuovo",
        	  data: formData,
        	  //dataType: "json",
        	  contentType: false, // NEEDED, DON'T OMIT THIS (requires jQuery 1.6+)
        	  processData: false, // NEEDED, DON'T OMIT THIS
        	  //enctype: 'multipart/form-data',
        	  success: function( data, textStatus) {

        		  if(data.success)
        		  { 
        			 // $('#modalNuovoCampione').modal('hide');
        			
        			  //dataString ="";

        			  $('#report_button').hide();
        				$('#visualizza_report').hide();
        			  $('#myModalErrorContent').html(data.messaggio);
        			  	$('#myModalError').removeClass();
        				$('#myModalError').addClass("modal modal-success");
        				$('#myModalError').modal('show');
        			  	
        		
        		  }else{
        			  $('#myModalErrorContent').html(data.messaggio);
        			  	$('#myModalError').removeClass();
        				$('#myModalError').addClass("modal modal-danger");
        				
        				$('#report_button').show();
          				$('#visualizza_report').show();
						$('#myModalError').modal('show');
		
        			 
        		  }
        	  },

        	  error: function(jqXHR, textStatus, errorThrown){
        	

        		 $('#errorModifica').html("<h3 class='label label-danger'>"+textStatus+"</h3>");
        		  //callAction('logout.do');
        
        	  }
          });
	  }else{
		  $("#ulError").html("<span class='label label-danger'>Compilare tutti i campi obbligatori</span>");
		  if(!valid){
			  $("#ulError").html("<span class='label label-danger'>Compilare tutti i campi obbligatori. Insereire Incertezza Assoluta o Incertezza Relativa</span>");
		  }
		  if(!validCorr){
			  $("#ulError").html("<span class='label label-danger'>I parametri di taratura devono essere univoci.</span>");
		  }
		  if(!validCorr2){
			  $("#ulError").html("<span class='label label-danger'>Lo stesso parametro di taratura deve essere presente almeno 2 volte.</span>");
		  }
	  }
  }
  //Gestione Utente
function nuovoUtente(){
	  
	  if($("#formNuovoUtente").valid()){
		  pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();

 
		  var form = $('#formNuovoUtente')[0]; 
		  var formData = new FormData(form);
        $.ajax({
      	  type: "POST",
      	  url: "gestioneUtenti.do?action=nuovo",
      	  data: formData,
      	  contentType: false, // NEEDED, DON'T OMIT THIS (requires jQuery 1.6+)
      	  processData: false, // NEEDED, DON'T OMIT THIS
//      	  dataType: "json",
      	  success: function( data, textStatus) {
      		  
      		  pleaseWaitDiv.modal('hide');
      		  
      		  if(data.success)
      		  { 
      			$('#report_button').hide();
  				$('#visualizza_report').hide();
      			  $("#modalNuovoUtente").modal("hide");
      			  $('#myModalErrorContent').html(data.messaggio);
      			  	$('#myModalError').removeClass();
      				$('#myModalError').addClass("modal modal-success");
      				$('#myModalError').modal('show');
      				
      		
      		  }else{
      			  $('#myModalErrorContent').html(data.messaggio);
      			  	$('#myModalError').removeClass();
      				$('#myModalError').addClass("modal modal-danger");
      				$('#report_button').show();
      				$('#visualizza_report').show();
					$('#myModalError').modal('show');

      			 
      		  }
      	  },

      	  error: function(jqXHR, textStatus, errorThrown){
      		  pleaseWaitDiv.modal('hide');

      		  $('#myModalErrorContent').html(textStatus);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
  				$('#visualizza_report').show();
				$('#myModalError').modal('show');
				
      
      	  }
        });
	  }
		  
//	  var user=$('#user').val();
//	  var passw=$('#passw').val();
//	  var nome=$('#nome').val();
//	  var cognome=$('#cognome').val();
//	  var indirizzo=$('#indirizzo').val();
//	  var comune=$('#comune').val();
//	  var cap=$('#cap').val();
//	  var email=$('#email').val();
//	  var telefono=$('#telefono').val();
//	  var company=$('#company').val();
//	  var cliente=$('#cliente').val();
//	  var sede=$('#sede').val();
//	  var tipoutente=$('#tipoutente').val();
//	  var dataObj = {};
//		
//	  dataObj.user = user;
//	  dataObj.passw = passw;
//	  dataObj.nome = nome;
//	  dataObj.cognome = cognome;
//	  dataObj.indirizzo = indirizzo;
//	  dataObj.comune = comune;
//	  dataObj.cap = cap;
//	  dataObj.email = email;
//	  dataObj.telefono = telefono;
//	  dataObj.company = company;
//	  dataObj.cliente = cliente;
//	  dataObj.sede = sede;
//	  dataObj.tipoutente = tipoutente;
//	  var sList = "";
//
//	  $('#formNuovoUtente input[type=checkbox]').each(function () {
//		  if(this.checked){
//			  if(sList.length>0){
//				  sList += ",";
//			  }
//			  sList += $(this).val();
//		  }
//		  
//		    
//		});
//	  dataObj.ruoli = sList;
//	  
//          $.ajax({
//        	  type: "POST",
//        	  url: "gestioneUtenti.do?action=nuovo",
//        	  data: dataObj,
//        	  dataType: "json",
//        	  success: function( data, textStatus) {
//        		  
//        		  pleaseWaitDiv.modal('hide');
//        		  
//        		  if(data.success)
//        		  { 
//        			 
//
//        			  $("#modalNuovoUtente").modal("hide");
//        			  $('#myModalErrorContent').html(data.messaggio);
//        			  	$('#myModalError').removeClass();
//        				$('#myModalError').addClass("modal modal-success");
//        				$('#myModalError').modal('show');
//        				
//        		
//        		  }else{
//        			  $('#myModalErrorContent').html(data.messaggio);
//        			  	$('#myModalError').removeClass();
//        				$('#myModalError').addClass("modal modal-danger");
//        				$('#myModalError').modal('show');
//        			 
//        		  }
//        	  },
//
//        	  error: function(jqXHR, textStatus, errorThrown){
//        		  pleaseWaitDiv.modal('hide');
//
//        		  $('#myModalErrorContent').html(textStatus);
//  			  	$('#myModalError').removeClass();
//  				$('#myModalError').addClass("modal modal-danger");
//  				$('#myModalError').modal('show');
//        
//        	  }
//          });
//	  }
  }
  
function modificaUtente(){
	  

		  pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
		  
		  
		  
		  var form = $('#formModificaUtente')[0]; 
		  var formData = new FormData(form);
        $.ajax({
      	  type: "POST",
      	  url: "gestioneUtenti.do?action=modifica",
      	  data: formData,
      	  contentType: false, // NEEDED, DON'T OMIT THIS (requires jQuery 1.6+)
      	  processData: false, // NEEDED, DON'T OMIT THIS
//      	  dataType: "json",
      	  success: function( data, textStatus) {
      		  
      		  pleaseWaitDiv.modal('hide');
      		  
      		  if(data.success)
      		  { 
      			$('#report_button').hide();
  				$('#visualizza_report').hide();
      			  $("#modalModificaUtente").modal("hide");
      			  $('#myModalErrorContent').html(data.messaggio);
      			  	$('#myModalError').removeClass();
      				$('#myModalError').addClass("modal modal-success");
      				$('#myModalError').modal('show');
      				
      		
      		  }else{
      			  $('#myModalErrorContent').html(data.messaggio);
      			  	$('#myModalError').removeClass();
      				$('#myModalError').addClass("modal modal-danger");
      				$('#report_button').show();
      				$('#visualizza_report').show();
					$('#myModalError').modal('show');

      			 
      		  }
      	  },

      	  error: function(jqXHR, textStatus, errorThrown){
      		  pleaseWaitDiv.modal('hide');

      		  $('#myModalErrorContent').html(textStatus);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
  				$('#visualizza_report').show();
				$('#myModalError').modal('show');
				
      
      	  }
        });
		  
		  
		  
//
//	  var id=$('#modid').val();
//	  var user=$('#moduser').val();
//	  var passw=$('#modpassw').val();
//	  var nome=$('#modnome').val();
//	  var cognome=$('#modcognome').val();
//	  var indirizzo=$('#modindirizzo').val();
//	  var comune=$('#modcomune').val();
//	  var cap=$('#modcap').val();
//	  var email=$('#modemail').val();
//	  var telefono=$('#modtelefono').val();
//	  var company=$('#modcompany').val();
//	  var tipoutente=$('#modtipoutente').val();
//	  var cliente=$('#modcliente').val();
//	  var sede=$('#modsede').val();
//	  var dataObj = {};
//	  dataObj.id = id;
//	  dataObj.user = user;
//	  dataObj.passw = passw;
//	  dataObj.nome = nome;
//	  dataObj.cognome = cognome;
//	  dataObj.indirizzo = indirizzo;
//	  dataObj.comune = comune;
//	  dataObj.cap = cap;
//	  dataObj.email = email;
//	  dataObj.telefono = telefono;
//	  dataObj.company = company;
//	  dataObj.cliente = cliente;
//	  dataObj.sede = sede;
//	  dataObj.tipoutente = tipoutente;
//        $.ajax({
//      	  type: "POST",
//      	  url: "gestioneUtenti.do?action=modifica",
//      	  data: dataObj,
//      	  dataType: "json",
//      	  success: function( data, textStatus) {
//      		  
//      		  pleaseWaitDiv.modal('hide');
//      		  
//      		  if(data.success)
//      		  { 
//      			
//      			  $("#modalModificaUtente").modal("hide");
//      			  $('#myModalErrorContent').html(data.messaggio);
//      			  	$('#myModalError').removeClass();
//      				$('#myModalError').addClass("modal modal-success");
//      				$('#myModalError').modal('show');
//      				
//      		
//      		  }else{
//      			  $('#myModalErrorContent').html(data.messaggio);
//      			  	$('#myModalError').removeClass();
//      				$('#myModalError').addClass("modal modal-danger");
//      				$('#myModalError').modal('show');
//      			 
//      		  }
//      	  },
//
//      	  error: function(jqXHR, textStatus, errorThrown){
//      		  pleaseWaitDiv.modal('hide');
//
//      		  $('#myModalErrorContent').html(textStatus);
//			  	$('#myModalError').removeClass();
//				$('#myModalError').addClass("modal modal-danger");
//				$('#myModalError').modal('show');
//      
//      	  }
//        });
	  
}


function toggleAbilitaUtente(idutente,abilitato){
	  

	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	 
	  
	  var dataObj = new FormData();
	  dataObj.append("modid",idutente);
	  dataObj.append("modabilitato",abilitato);
  $.ajax({
	  type: "POST",
	  url: "gestioneUtenti.do?action=modifica",
	  data: dataObj,
	  contentType: false, // NEEDED, DON'T OMIT THIS (requires jQuery 1.6+)
  	  processData: false, // NEEDED, DON'T OMIT THIS
	  success: function( data, textStatus) {
		  
		  pleaseWaitDiv.modal('hide');
		  
		  if(data.success)
		  { 
			  $('#report_button').hide();
				$('#visualizza_report').hide();
 			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-success");
				$('#myModalError').modal('show');
				
		
		  }else{
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
  				$('#visualizza_report').show();
				$('#myModalError').modal('show');
			 
				
		  }
	  },

	  error: function(jqXHR, textStatus, errorThrown){
		  pleaseWaitDiv.modal('hide');

		  $('#myModalErrorContent').html(textStatus);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
				$('#visualizza_report').show();
			$('#myModalError').modal('show');

	  }
  });

}


function updateSelectClienti(tipo,tipoutente,companyId,idUtente){
	var dataObj = {};
	if(tipoutente!=1){
		pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal();
	}
	dataObj.tipo = tipo;
	if(tipo=="mod"){
		
		dataObj.utente = idUtente;
		
	}
	dataObj.company = companyId;
	
	$.ajax({
    	  type: "POST",
    	  url: "gestioneUtenti.do?action=clientisedi",
    	  data: dataObj,
    	  dataType: "json",
    	  success: function( data, textStatus) {
    		  
    		  pleaseWaitDiv.modal('hide');
    		  
    		  if(data.success)
    		  { 
    			  $('#report_button').hide();
    				$('#visualizza_report').hide();
    			  	if(tipo=="new"){
    			  		idclienteitem="#cliente";
    			  		idsedeitem="#sede";
    			  		
    			  	}else{
    			  		idclienteitem="#modcliente";
    			  		idsedeitem="#modsede";
    			  		utente =  JSON.parse(data.utente);
    			  	}
    			  	
    			  	optionsClienti = JSON.parse(data.clienti);
    			  	var opt=[];
    			  	
    			  	  opt.push("<option value = 0>Seleziona Cliente</option>");
    		
    			  	$.each(optionsClienti,function(index, value){

    			  	      opt.push("<option value='"+value.__id+"'>"+value.nome+"</option>");
    			  	});
    			  	  
    			  	
    			  	  $(idclienteitem).prop("disabled", false);  			  	 
    			  	  $(idclienteitem).html(opt);  
    			  	 if(tipo=="mod"){
     			  		$(idclienteitem).val(utente.idCliente);
     			  	  }
    			
    			  	
    			  	  
    			  	  
    			  	  
    			  	optionsSedi = JSON.parse(data.sedi);
    			  	var optsedi=[];
    			  	
    			  	optsedi.push("<option value = 0>Non Associato</option>");
    			  	$.each(optionsSedi,function(index, value){

    			  			optsedi.push("<option value='"+value.__id+"_"+value.id__cliente_+"'>"+value.descrizione+" - "+value.indirizzo+"</option>");
      			  	});
    			  	    
    			  	$(idsedeitem).html(optsedi);  
    			  	
    			    $(idclienteitem).trigger("chosen:updated");	  	 
  			  	$(idclienteitem).change();  
 
    				if(tipo=="mod"){
    			  		$(idsedeitem).val(utente.idSede+"_"+utente.idCliente);
    			  	  }

  			  	 $(idsedeitem).trigger("chosen:updated");
  			  	 $(idsedeitem).change();  
    		
    		  }else{
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
      				$('#visualizza_report').show();
					$('#myModalError').modal('show');
    			 
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    		  pleaseWaitDiv.modal('hide');

    		  $('#myModalErrorContent').html(textStatus);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
  				$('#visualizza_report').show();
				$('#myModalError').modal('show');
				
    
    	  }
      });
}


function eliminaUtente(){
	 
	$("#modalEliminaUtente").modal("hide");

	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();

	  var id=$('#idElimina').val();
	  var dataObj = {};
	  dataObj.id = id;


  $.ajax({
	  type: "POST",
	  url: "gestioneUtenti.do?action=elimina",
	  data: dataObj,
	  dataType: "json",
	  success: function( data, textStatus) {
		  
		  pleaseWaitDiv.modal('hide');
		  
		  if(data.success)
		  { 
			
			  $('#report_button').hide();
				$('#visualizza_report').hide();
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-success");
				$('#myModalError').modal('show');
				
		
		  }else{
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
  				$('#visualizza_report').show();
				$('#myModalError').modal('show');
			 
		  }
	  },

	  error: function(jqXHR, textStatus, errorThrown){
		  pleaseWaitDiv.modal('hide');

		  $('#myModalErrorContent').html(textStatus);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
				$('#visualizza_report').show();
			$('#myModalError').modal('show');

	  }
  });

}

  function modalModificaUtente(tipoutente,id,user,nome,cognome,indirizzo,comune,cap,email,telefono,company,cliente,sede,abilitato,idFirma){
	  
	  $('#modtipoutente').val(tipoutente);
	  $('#modtipoutente').change();
	  $('#modid').val(id);
	  $('#moduser').val(user);
	  $('#modnome').val(nome);
	  $('#modcognome').val(cognome);
	  $('#modindirizzo').val(indirizzo);
	  $('#modcomune').val(comune);
	  $('#modcap').val(cap);
	  $('#modemail').val(email);
	  $('#modtelefono').val(telefono);
	  $('#modcompany').val(company);
	  $('#modcompany').change();
	  $('#modcliente').val(cliente);
	  $('#modcliente').change();
	  $('#modsede').val(sede);
	  $('#modsede').change();
	  $('#modidFirma').val(idFirma);
	  if(abilitato==0){
		  $('#modabilitato').iCheck('uncheck');
	  }else{
		  $('#modabilitato').iCheck('check');
	  }
	  $('#modalModificaUtente').modal();
	  
  }
  function modalEliminaUtente(id,nominativo){
	  
	  $('#idElimina').val(id);
	  $('#nominativoElimina').html(nominativo);
	  
	  
	  $('#modalEliminaUtente').modal();
	  
  }
  
  
  
  // Gestione Company
  
function nuovaCompany(){
	  
	  if($("#formNuovaCompany").valid()){
		  pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();

	  
	  var denominazione=$('#denominazione').val();
	  var piva=$('#pIva').val();
	  var indirizzo=$('#indirizzo').val();
	  var comune=$('#comune').val();
	  var cap=$('#cap').val();
	  var email=$('#mail').val();
	  var telefono=$('#telefono').val();
	  var codiceAffiliato=$('#codAffiliato').val();
	  var dataObj = {};
		
	  dataObj.denominazione = denominazione;
	  dataObj.piva = piva;

	  dataObj.indirizzo = indirizzo;
	  dataObj.comune = comune;
	  dataObj.cap = cap;
	  dataObj.email = email;
	  dataObj.telefono = telefono;
	  dataObj.codiceAffiliato = codiceAffiliato;

          $.ajax({
        	  type: "POST",
        	  url: "gestioneCompany.do?action=nuovo",
        	  data: dataObj,
        	  dataType: "json",
        	  success: function( data, textStatus) {
        		  
        		  pleaseWaitDiv.modal('hide');
        		  
        		  if(data.success)
        		  { 

        			  $('#report_button').hide();
        				$('#visualizza_report').hide();
        			  $("#modalNuovaCompany").modal("hide");
        			  $('#myModalErrorContent').html(data.messaggio);
        			  	$('#myModalError').removeClass();
        				$('#myModalError').addClass("modal modal-success");
        				$('#myModalError').modal('show');
        				
        		
        		  }else{
        			  $('#myModalErrorContent').html(data.messaggio);
        			  	$('#myModalError').removeClass();
        				$('#myModalError').addClass("modal modal-danger");
        				$('#report_button').show();
          				$('#visualizza_report').show();
        				$('#myModalError').modal('show');
        			 
        		  }
        	  },

        	  error: function(jqXHR, textStatus, errorThrown){
        		  pleaseWaitDiv.modal('hide');

        		  $('#myModalErrorContent').html(textStatus);
  			  	$('#myModalError').removeClass();
  				$('#myModalError').addClass("modal modal-danger");
  				$('#report_button').show();
  				$('#visualizza_report').show();
  				$('#myModalError').modal('show');
        
        	  }
          });
	  }
  }
  
function modificaCompany(){
	  

		  pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();

	  var id=$('#modid').val();
	  var denominazione=$('#moddenominazione').val();
	  var piva=$('#modpIva').val();
	  var indirizzo=$('#modindirizzo').val();
	  var comune=$('#modcomune').val();
	  var cap=$('#modcap').val();
	  var email=$('#modmail').val();
	  var telefono=$('#modtelefono').val();
	  var codiceAffiliato=$('#modcodAffiliato').val();
	  var email_pec = $('#mod_email_pec').val();
	  var password_pec = $('#mod_password_pec').val();
	  var host_pec = $('#mod_host_pec').val();
	  var porta_pec = $('#mod_porta_pec').val();
	  
	  
	  var dataObj = {};
	  dataObj.modid = id;
	  dataObj.moddenominazione = denominazione;
	  dataObj.modpiva = piva;
	  dataObj.modindirizzo = indirizzo;
	  dataObj.modcomune = comune;
	  dataObj.modcap = cap;
	  dataObj.modemail = email;
	  dataObj.modtelefono = telefono;
	  dataObj.modcodiceAffiliato = codiceAffiliato;
	  dataObj.mod_email_pec = email_pec;
	  dataObj.mod_password_pec = password_pec;
	  dataObj.mod_host_pec = host_pec;
	  dataObj.mod_porta_pec = porta_pec;

        $.ajax({
      	  type: "POST",
      	  url: "gestioneCompany.do?action=modifica",
      	  data: dataObj,
      	  dataType: "json",
      	  success: function( data, textStatus) {
      		  
      		  pleaseWaitDiv.modal('hide');
      		  
      		  if(data.success)
      		  { 
      			
      			$('#report_button').hide();
  				$('#visualizza_report').hide();
      			  $("#modalModificaCompany").modal("hide");
      			  $('#myModalErrorContent').html(data.messaggio);
      			  	$('#myModalError').removeClass();
      				$('#myModalError').addClass("modal modal-success");
      				$('#myModalError').modal('show');
      				
      		
      		  }else{
      			  $('#myModalErrorContent').html(data.messaggio);
      			  	$('#myModalError').removeClass();
      				$('#myModalError').addClass("modal modal-danger");
      				$('#report_button').show();
      				$('#visualizza_report').show();
      				$('#myModalError').modal('show');
      			 
      		  }
      	  },

      	  error: function(jqXHR, textStatus, errorThrown){
      		  pleaseWaitDiv.modal('hide');

      		  $('#myModalErrorContent').html(textStatus);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
  				$('#visualizza_report').show();
				
				$('#myModalError').modal('show');
				
      	  }
        });
	  
}


function eliminaCompany(){
	 
	$("#modalEliminaCompany").modal("hide");

	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();

	  var id=$('#idElimina').val();
	  var dataObj = {};
	  dataObj.id = id;


  $.ajax({
	  type: "POST",
	  url: "gestioneCompany.do?action=elimina",
	  data: dataObj,
	  dataType: "json",
	  success: function( data, textStatus) {
		  
		  pleaseWaitDiv.modal('hide');
		  
		  if(data.success)
		  { 
			
			  $('#report_button').hide();
				$('#visualizza_report').hide();
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-success");
				$('#myModalError').modal('show');
				
		
		  }else{
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
  				$('#visualizza_report').show();
				$('#myModalError').modal('show');
			 
		  }
	  },

	  error: function(jqXHR, textStatus, errorThrown){
		  pleaseWaitDiv.modal('hide');

		  $('#myModalErrorContent').html(textStatus);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
			$('#visualizza_report').show();
			$('#myModalError').modal('show');
			
	  }
  });

}

  function modalModificaCompany(id,denominazione,piva,indirizzo,comune,cap,email,telefono,codAffiliato, email_pec, host_pec, porta_pec){
	  
	  $('#modid').val(id);
	  $('#moddenominazione').val(denominazione);
	  $('#modpIva').val(piva);
	   $('#modindirizzo').val(indirizzo);
	   $('#modcomune').val(comune);
	   $('#modcap').val(cap);
	   $('#modmail').val(email);
	   $('#modtelefono').val(telefono);
	  $('#modcodAffiliato').val(codAffiliato);
	  $('#mod_email_pec').val(email_pec);
	  $('#mod_host_pec').val(host_pec);
	  $('#mod_porta_pec').val(porta_pec);
	  
	  $('#modalModificaCompany').modal();
	  
  }
  function modalEliminaCompany(id,denominazione){
	  
	  $('#idElimina').val(id);
	  $('#denominazioneElimina').html(denominazione);
	  
	  
	  $('#modalEliminaCompany').modal();
	  
  }
  
  
  
//Gestione Ruoli
  function nuovoRuolo(){
  	  
  	  if($("#formNuovoRuolo").valid()){
  		  pleaseWaitDiv = $('#pleaseWaitDialog');
  		  pleaseWaitDiv.modal();

  	  
  	  var sigla=$('#sigla').val();
  	  var descrizione=$('#descrizione').val();

  	  var dataObj = {};
  		
  	  dataObj.sigla = sigla;
  	  dataObj.descrizione = descrizione;


  	  var sList = "";

  	  $('#formNuovoRuolo input[type=checkbox]').each(function () {
  		  if(this.checked){
  			  if(sList.length>0){
  				  sList += ",";
  			  }
  			  sList += $(this).val();
  		  }
  		  
  		    
  		});
  	  dataObj.permessi = sList;
  	  
            $.ajax({
          	  type: "POST",
          	  url: "gestioneRuoli.do?action=nuovo",
          	  data: dataObj,
          	  dataType: "json",
          	  success: function( data, textStatus) {
          		  
          		  pleaseWaitDiv.modal('hide');
          		  
          		  if(data.success)
          		  { 
          			 
          			$('#report_button').hide();
      				$('#visualizza_report').hide();
          			  $("#modalNuovoRuolo").modal("hide");
          			  $('#myModalErrorContent').html(data.messaggio);
          			  	$('#myModalError').removeClass();
          				$('#myModalError').addClass("modal modal-success");
          				$('#myModalError').modal('show');
          				
          		
          		  }else{
          			  $('#myModalErrorContent').html(data.messaggio);
          			  	$('#myModalError').removeClass();
          				$('#myModalError').addClass("modal modal-danger");
          				$('#report_button').show();
          				$('#visualizza_report').show();
          				$('#myModalError').modal('show');
          			 
          		  }
          	  },

          	  error: function(jqXHR, textStatus, errorThrown){
          		  pleaseWaitDiv.modal('hide');

          		  $('#myModalErrorContent').html(textStatus);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
      				$('#visualizza_report').show();
    				$('#myModalError').modal('show');
    				
          
          	  }
            });
  	  }
    }
    
  function modificaRuolo(){
  	  

  		  pleaseWaitDiv = $('#pleaseWaitDialog');
  		  pleaseWaitDiv.modal();

  	  var id=$('#modid').val();
  	  var sigla=$('#modsigla').val();
  	  var descrizione=$('#moddescrizione').val();

  	  var dataObj = {};
  	  dataObj.id = id;
  	  dataObj.sigla = sigla;
  	  dataObj.descrizione = descrizione;
  	 

          $.ajax({
        	  type: "POST",
        	  url: "gestioneRuoli.do?action=modifica",
        	  data: dataObj,
        	  dataType: "json",
        	  success: function( data, textStatus) {
        		  
        		  pleaseWaitDiv.modal('hide');
        		  
        		  if(data.success)
        		  { 
        			  $('#report_button').hide();
        				$('#visualizza_report').hide();
        			  $("#modalModificaRuolo").modal("hide");
        			  $('#myModalErrorContent').html(data.messaggio);
        			  	$('#myModalError').removeClass();
        				$('#myModalError').addClass("modal modal-success");
        				$('#myModalError').modal('show');
        				
        		
        		  }else{
        			  $('#myModalErrorContent').html(data.messaggio);
        			  	$('#myModalError').removeClass();
        				$('#myModalError').addClass("modal modal-danger");
        				$('#report_button').show();
          				$('#visualizza_report').show();
        				$('#myModalError').modal('show');
        			 
        		  }
        	  },

        	  error: function(jqXHR, textStatus, errorThrown){
        		  pleaseWaitDiv.modal('hide');

        		  $('#myModalErrorContent').html(textStatus);
  			  	$('#myModalError').removeClass();
  				$('#myModalError').addClass("modal modal-danger");
  				
				$('#myModalError').modal('show');
				
        
        	  }
          });
  	  
  }


  function eliminaRuolo(){
  	 
  	$("#modalEliminaRuolo").modal("hide");

  	  pleaseWaitDiv = $('#pleaseWaitDialog');
  	  pleaseWaitDiv.modal();

  	  var id=$('#idElimina').val();
  	  var dataObj = {};
  	  dataObj.id = id;


    $.ajax({
  	  type: "POST",
  	  url: "gestioneRuoli.do?action=elimina",
  	  data: dataObj,
  	  dataType: "json",
  	  success: function( data, textStatus) {
  		  
  		  pleaseWaitDiv.modal('hide');
  		  
  		  if(data.success)
  		  { 
  			
  			$('#report_button').hide();
				$('#visualizza_report').hide();
  			  $('#myModalErrorContent').html(data.messaggio);
  			  	$('#myModalError').removeClass();
  				$('#myModalError').addClass("modal modal-success");
  				$('#myModalError').modal('show');
  				
  		
  		  }else{
  			  $('#myModalErrorContent').html(data.messaggio);
  			  	$('#myModalError').removeClass();
  				$('#myModalError').addClass("modal modal-danger");
  				$('#report_button').show();
  				$('#visualizza_report').show();
  				$('#myModalError').modal('show');
  			 
  		  }
  	  },

  	  error: function(jqXHR, textStatus, errorThrown){
  		  pleaseWaitDiv.modal('hide');

  		  $('#myModalErrorContent').html(textStatus);
  		  	$('#myModalError').removeClass();
  			$('#myModalError').addClass("modal modal-danger");
  			$('#report_button').show();
			$('#visualizza_report').show();
			$('#myModalError').modal('show');
			
  	  }
    });

  }

    function modalModificaRuolo(id,sigla,descrizione){
  	  
  	  $('#modid').val(id);
  	  $('#modsigla').val(sigla);
  	  $('#moddescrizione').val(descrizione);

  	  
  	  
  	  $('#modalModificaRuolo').modal();
  	  
    }
    function modalEliminaRuolo(id,descrizione){
  	  
  	  $('#idElimina').val(id);
  	  $('#descrizioneElimina').html(descrizione);
  	  
  	  
  	  $('#modalEliminaRuolo').modal();
  	  
    }
  
    
    
    // Gestione Permessi
    
  function nuovoPermesso(){
  	  
  	  if($("#formNuovoPermesso").valid()){
  		  pleaseWaitDiv = $('#pleaseWaitDialog');
  		  pleaseWaitDiv.modal();

  	  
  	  var descrizione=$('#descrizione').val();
  	  var chiave_permesso=$('#chiave_permesso').val();

  	  var dataObj = {};
  		
  	  dataObj.chiave_permesso = chiave_permesso;
  	  dataObj.descrizione = descrizione;


            $.ajax({
          	  type: "POST",
          	  url: "gestionePermessi.do?action=nuovo",
          	  data: dataObj,
          	  dataType: "json",
          	  success: function( data, textStatus) {
          		  
          		  pleaseWaitDiv.modal('hide');
          		  
          		  if(data.success)
          		  { 
          			 
          			$('#report_button').hide();
      				$('#visualizza_report').hide();
          			  $("#modalNuovoPermesso").modal("hide");
          			  $('#myModalErrorContent').html(data.messaggio);
          			  	$('#myModalError').removeClass();
          				$('#myModalError').addClass("modal modal-success");
          				$('#myModalError').modal('show');
          				
          		
          		  }else{
          			  $('#myModalErrorContent').html(data.messaggio);
          			  	$('#myModalError').removeClass();
          				$('#myModalError').addClass("modal modal-danger");
          				$('#report_button').show();
          				$('#visualizza_report').show();
          				$('#myModalError').modal('show');
          			 
          		  }
          	  },

          	  error: function(jqXHR, textStatus, errorThrown){
          		  pleaseWaitDiv.modal('hide');

          		  $('#myModalErrorContent').html(textStatus);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
      				$('#visualizza_report').show();
    				$('#myModalError').modal('show');
    				          
          	  }
            });
  	  }
    }
    
  function modificaPermesso(){
  	  

  		  pleaseWaitDiv = $('#pleaseWaitDialog');
  		  pleaseWaitDiv.modal();

  	  var id=$('#modid').val();
  	  var descrizione=$('#moddescrizione').val();
  	  var chiave_permesso=$('#modchiavepermesso').val();

  	  
  	  
  	  var dataObj = {};
  	  dataObj.id = id;
  	  dataObj.descrizione = descrizione;
  	  dataObj.chiave_permesso = chiave_permesso;


          $.ajax({
        	  type: "POST",
        	  url: "gestionePermessi.do?action=modifica",
        	  data: dataObj,
        	  dataType: "json",
        	  success: function( data, textStatus) {
        		  
        		  pleaseWaitDiv.modal('hide');
        		  
        		  if(data.success)
        		  { 
        			  $('#report_button').hide();
        				$('#visualizza_report').hide();
        			  $("#modalModificaPermesso").modal("hide");
        			  $('#myModalErrorContent').html(data.messaggio);
        			  	$('#myModalError').removeClass();
        				$('#myModalError').addClass("modal modal-success");
        				$('#myModalError').modal('show');
        				
        		
        		  }else{
        			 
        			  $('#myModalErrorContent').html(data.messaggio);
        			  	$('#myModalError').removeClass();
        				$('#myModalError').addClass("modal modal-danger");
        				$('#report_button').show();
          				$('#visualizza_report').show();
        				$('#myModalError').modal('show');
        			 
        		  }
        	  },

        	  error: function(jqXHR, textStatus, errorThrown){
        		  pleaseWaitDiv.modal('hide');

        		  $('#myModalErrorContent').html(textStatus);
  			  	$('#myModalError').removeClass();
  				$('#myModalError').addClass("modal modal-danger");
  				$('#report_button').show();
  				$('#visualizza_report').show();
				$('#myModalError').modal('show');
				 
        	  }
          });
  	  
  }


  function eliminaPermesso(){
  	 
  	$("#modalEliminaPermessoy").modal("hide");

  	  pleaseWaitDiv = $('#pleaseWaitDialog');
  	  pleaseWaitDiv.modal();

  	  var id=$('#idElimina').val();
  	  var dataObj = {};
  	  dataObj.id = id;


    $.ajax({
  	  type: "POST",
  	  url: "gestionePermessi.do?action=elimina",
  	  data: dataObj,
  	  dataType: "json",
  	  success: function( data, textStatus) {
  		  
  		  pleaseWaitDiv.modal('hide');
  		  
  		  if(data.success)
  		  { 
  			
  			$('#report_button').hide();
				$('#visualizza_report').hide();
  			  $('#myModalErrorContent').html(data.messaggio);
  			  	$('#myModalError').removeClass();
  				$('#myModalError').addClass("modal modal-success");  				
  				$('#myModalError').modal('show');
  				
  		
  		  }else{
  			  $('#myModalErrorContent').html(data.messaggio);
  			  	$('#myModalError').removeClass();
  				$('#myModalError').addClass("modal modal-danger");
  				$('#report_button').show();
  				$('#visualizza_report').show();
  				$('#myModalError').modal('show');
  			 
  		  }
  	  },

  	  error: function(jqXHR, textStatus, errorThrown){
  		  pleaseWaitDiv.modal('hide');

  		  $('#myModalErrorContent').html(textStatus);
  		  	$('#myModalError').removeClass();
  			$('#myModalError').addClass("modal modal-danger");
  			$('#report_button').show();
				$('#visualizza_report').show();
			$('#myModalError').modal('show');
			
  	  }
    });

  }

    function modalModificaPermesso(id,descrizione,chiave_permesso){
  	  
  	  $('#modid').val(id);
  	  $('#moddescrizione').val(descrizione);
  	  $('#modchiavepermesso').val(chiave_permesso);

  	  
  	  
  	  $('#modalModificaPermesso').modal();
  	  
    }
    function modalEliminaPermessoy(id,descrizione){
  	  
  	  $('#idElimina').val(id);
  	  $('#descrizioneElimina').html(descrizione);
  	  
  	  
  	  $('#modalEliminaPermesso').modal();
  	  
    }
    
   
    
    
  
  function checkCodiceCampione(codice){
	  
	  var form = $('#formNuovoCampione')[0]; 
	  var formData = new FormData(form);
	  
	  $.ajax({
    	  type: "POST",
    	  url: "gestioneCampione.do?action=controllaCodice&codice="+codice,

    	  //dataType: "json",
    	  contentType: false, // NEEDED, DON'T OMIT THIS (requires jQuery 1.6+)
    	  processData: false, // NEEDED, DON'T OMIT THIS
    	  data: formData,
    	  //enctype: 'multipart/form-data',
    	  success: function( data, textStatus) {

    		  if(!data.success)
    		  { 
    		
//    			$('#myModalErrorContent').html(data.messaggio);
//      		  	$('#myModalError').removeClass();
//  				$('#myModalError').addClass("modal modal-danger");
//  				$('#myModalError').modal('show');

    			  $("#codiceError").html("* Codice: "+codice+" gi&agrave; utilizzato.");
    			  $("#codice").val("");
    		  }else{
    			  $("#codiceError").html("");
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    	
    	
    		  	$('#myModalErrorContent').html(textStatus);
    		  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
  				$('#visualizza_report').show();
				$('#myModalError').modal('show');
				
    		  
    
    	  }
      });
  }
  
  
  function createLDTable(data){
	 
	  
	  var dataSet = [];
	  
	  if(data.result.duplicate){
		  var jsonData = JSON.parse(data.result.duplicate);
		  
		  for(var i=0 ; i<jsonData.length;i++)
	      {
	
				item = ["<input type='checkbox' value='"+jsonData[i].__id+"'>",jsonData[i].__id,jsonData[i].denominazione];
		 
	
		        dataSet.push(item);
			}
		  $("#modalListaDuplicati").modal("show");
	
	
		  $('#tabLD').DataTable( {
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
		        data: dataSet,
		        bDestroy: true,
		        columns: [
		            { title: "Check" },
		            { title: "ID" },
		            { title: "Descrizione" }
		        ]
		    } );
	  }else{
		  if(data.result.messaggio != ""){
		  		$('#myModalErrorContent').html(data.result.messaggio);
		  		$('#myModalError').removeClass();
		  		$('#myModalError').addClass("modal modal-success");
				$('#myModalError').modal('show');
				
	  		}
//		  else{
//	  			$('#myModalErrorContent').html("Salvato");
//		  		$('#myModal').removeClass();
//		  		$('#myModal').addClass("modal modal-success");
//				$('#myModal').modal('show');
//	  		}
	  }
  }
  function creaCertificato(idCertificato){
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  $.ajax({
    	  type: "POST",
    	  url: "listaCertificati.do?action=creaCertificato&idCertificato="+idCertificato,
    	  dataType: "json",

    	  success: function( data, textStatus) {
    		  pleaseWaitDiv.modal('hide');
    		  if(data.success)
    		  { 

    			  $('#report_button').hide();
    			  $('#visualizza_report').hide();
       	        	 // $('#errorMsg').html("<h3 class='label label-success' style=\"color:green\">"+data.messaggio+"</h3>");
    				  $('#myModalErrorContent').html(data.messaggio);
      			  	$('#myModalError').removeClass();
      				$('#myModalError').addClass("modal modal-success");
      				$('#myModalError').modal('show');
       	         
    		
    		  }else{
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    			  	$('#report_button').show();
      				$('#visualizza_report').show();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#myModalError').modal('show');
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    	
    		 pleaseWaitDiv.modal('hide');
   			$('#myModalErrorContent').html(errorThrown.message);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
				$('#visualizza_report').show();
			$('#myModalError').modal('show');
			

    
    	  }
      });
  }
  function annullaCertificato(idCertificato){
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  $.ajax({
    	  type: "POST",
    	  url: "listaCertificati.do?action=annullaCertificato&idCertificato="+idCertificato,
    	  dataType: "json",

    	  success: function( data, textStatus) {
    		  pleaseWaitDiv.modal('hide');
    		  if(data.success)
    		  { 

    			  $('#report_button').hide();
    				$('#visualizza_report').hide();
       	        	 // $('#errorMsg').html("<h3 class='label label-success' style=\"color:green\">"+data.messaggio+"</h3>");
    				  $('#myModalErrorContent').html(data.messaggio);
      			  	$('#myModalError').removeClass();
      				$('#myModalError').addClass("modal modal-success");
      				$('#myModalError').modal('show');
       	         
    		
    		  }else{
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
      				$('#visualizza_report').show();
    				$('#myModalError').modal('show');
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    	
    		  pleaseWaitDiv.modal('hide');
   			$('#myModalErrorContent').html(errorThrown.message);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
			$('#visualizza_report').show();
			$('#myModalError').modal('show');
			
    	  }
      });
  }
  function validateEmail(email){ 
	  var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	    return re.test(email.toLowerCase());
	}
  function inviaCertificatoPerMail(){
	  $('#myModalSendEmail').modal('hide');
	  idCertificato = $("#idcert").val();
	  email = $("#email").val();
	  if(email != "" && idCertificato != "" && validateEmail(email)){
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  $.ajax({
    	  type: "POST",
    	  url: "listaCertificati.do?action=inviaEmailCertificato&idCertificato="+idCertificato+"&email="+email,
    	  dataType: "json",

    	  success: function( data, textStatus) {
    		  pleaseWaitDiv.modal('hide');
    		  if(data.success)
    		  { 

    			  $('#report_button').hide();
    				$('#visualizza_report').hide();
       	        	 // $('#errorMsg').html("<h3 class='label label-success' style=\"color:green\">"+data.messaggio+"</h3>");
    				  $('#myModalErrorContent').html(data.messaggio);
      			  	$('#myModalError').removeClass();
      				$('#myModalError').addClass("modal modal-success");
      				$('#myModalError').modal('show');
       	         
    		
    		  }else{
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
      				$('#visualizza_report').show();
    				$('#myModalError').modal('show');
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    	
    		  pleaseWaitDiv.modal('hide');
   			$('#myModalErrorContent').html(errorThrown.message);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
			$('#visualizza_report').show();
			$('#myModalError').modal('show');
			
    	  }
      });
  }else{
	  if(!validateEmail(email)){
		  	$("#idcert").val(idCertificato);
		  	$("#email").val(email);
		  	$("#emailDiv").addClass("has-error");
			$('#myModalSendEmail').modal('show')
  		}else{
  			$('#myModalErrorContent').html("Errore Interno, Riprovare.");
	  		$('#myModalError').removeClass();
	  		$('#myModalError').addClass("modal modal-success");
	  		$('#myModalError').modal('show');
  			
  		}
  }
  }
  function inviaEmailCertificato(idCertificato){
	  
	  $("#emailDiv").removeClass("has-error");
	  	$("#idcert").val(idCertificato);
		$('#myModalSendEmail').modal('show');
  }
  
  function firmaCertificato(pin, idCertificato){
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  $.ajax({
    	  type: "POST",
    	  url: "listaCertificati.do?action=firmaCertificato&idCertificato="+idCertificato+"&pin="+pin,
    	  dataType: "json",

    	  success: function( data, textStatus) {
    		  pleaseWaitDiv.modal('hide');
    		  if(data.success)
    		  { 

    			  $('#report_button').hide();
    				$('#visualizza_report').hide();
       	        	 // $('#errorMsg').html("<h3 class='label label-success' style=\"color:green\">"+data.messaggio+"</h3>");
    				  $('#myModalErrorContent').html(data.messaggio);

       	        	 // $('#errorMsg').html("<h3 class='label label-success' style=\"color:green\">"+data.message+"</h3>");
    				//  $('#myModalErrorContent').html(data.messaggio);

      			  	$('#myModalError').removeClass();
      				$('#myModalError').addClass("modal modal-success");
      				$('#myModalError').modal('show');
      				$('#myModalError').on('hidden.bs.modal', function(){
      					filtraCertificati();
      				});
    		
    		  }else{
    			  
    			  if(data.messaggio=="Attenzione! PIN errato!"){
    				  $('#myModalErrorContent').html(data.messaggio);
      			  	$('#myModalError').removeClass();
      				$('#myModalError').addClass("modal modal-danger");
      				$('#report_button').hide();
      				$('#visualizza_report').hide();
      				$('#myModalError').modal('show');
    			  }else{
    				  if(data.errorType!=null){
    					  $('#myModalErrorContent').html(data.messaggio);
    	    			  	$('#myModalError').removeClass();
    	    				$('#myModalError').addClass("modal modal-danger");    	    				
    	    				$('#myModalError').modal('show');
    				  }else{
    				  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
      				$('#visualizza_report').show();
    				$('#myModalError').modal('show');
    				  }
    			  }    				
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    		  pleaseWaitDiv.modal('hide');
   
   			$('#myModalErrorContent').html(errorThrown.message);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
				$('#visualizza_report').show();
			$('#myModalError').modal('show');
			
    
    	  }
      });
  }
  function approvaCertificatiMulti(selezionati){
		
	  $.ajax({
    	  type: "POST",
    	  url: "listaCertificati.do?action=approvaCertificatiMulti",
    	  dataType: "json",
    	  data: "dataIn="+JSON.stringify(selezionati),
    	  success: function( data, textStatus) {
    		  pleaseWaitDiv.modal('hide');
    		  if(data.success)
    		  { 

    			  $('#report_button').hide();
    				$('#visualizza_report').hide();
       	        	 // $('#errorMsg').html("<h3 class='label label-success' style=\"color:green\">"+data.messaggio+"</h3>");
    				$('#myModalErrorContent').html(data.messaggio);
      			  	$('#myModalError').removeClass();
      				$('#myModalError').addClass("modal modal-success");
      				$('#myModalError').modal('show');
       	         
    		
    		  }else{
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#myModalError').modal('show');
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    		  pleaseWaitDiv.modal('hide');
   
   			$('#myModalErrorContent').html(errorThrown.message);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
			$('#visualizza_report').show();
			$('#myModalError').modal('show');
			    
    	  }
      });
  }
  
  function generaCertificatiMulti(selezionati){

	  json = JSON.stringify(selezionati);
	  
	  $('#certificatiMulti').on("submit", function (e) {

		  
		  $('#dataInExport').val(json);
		  

		});
	 	callAction('listaCertificati.do?action=generaCertificatiMulti','#certificatiMulti',false);
	 	 pleaseWaitDiv.modal('hide');
  }
  
  function annullaCertificatiMulti(selezionati){
	
	  $.ajax({
    	  type: "POST",
    	  url: "listaCertificati.do?action=annullaCertificatiMulti",
    	  dataType: "json",
    	  data: "dataIn="+JSON.stringify(selezionati),
    	  success: function( data, textStatus) {
    		  pleaseWaitDiv.modal('hide');
    		  if(data.success)
    		  { 

    			  $('#report_button').hide();
    				$('#visualizza_report').hide();
       	        	 // $('#errorMsg').html("<h3 class='label label-success' style=\"color:green\">"+data.messaggio+"</h3>");
    				  $('#myModalErrorContent').html(data.messaggio);
      			  	$('#myModalError').removeClass();
      				$('#myModalError').addClass("modal modal-success");
      				$('#myModalError').modal('show');
       	         
    		
    		  }else{
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
    				$('#visualizza_report').show();
    				$('#myModalError').modal('show');
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    		  pleaseWaitDiv.modal('hide');
   
   			$('#myModalErrorContent').html(errorThrown.message);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
			$('#visualizza_report').show();
			$('#myModalError').modal('show');
			
    	  }
      });
  }
  
  
  function saveDuplicatiFromModal(){
	  
	  var ids = []; 
	  $( "#tabLD input[type=checkbox]" ).each(function( i ) {
		  if (this.checked) {
              console.log($(this).val()); 
              ids.push(""+this.value);
          }
		 });
	  
	  $("#modalListaDuplicati").modal("hide");
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
		  var  dataObj = {};
	  	dataObj.ids =""+ ids+"";
	  
		  $.ajax({
	    	  type: "POST",
	    	  url: "caricaPacchettoDuplicati.do?",
	    	  data: dataObj,
	    	  dataType: "json",
	
	    	  success: function( data, textStatus) {
		    	
	    		  $('#files').html("");

	    		  pleaseWaitDiv.modal('hide');
	    		  if(data.success)
	    		  { 
	    			  if(data.messaggio != ""){
	    			  		$('#myModalErrorContent').html(data.messaggio);
	    			  		$('#myModalError').removeClass();
	    			  		$('#myModalError').addClass("modal modal-success");
							$('#myModalError').modal('show');
							
	    		  		}
//	    			  else{
//	    		  			$('#myModalErrorContent').html("Salvato");
//	    			  		$('#myModal').removeClass();
//	    			  		$('#myModal').addClass("modal modal-success");
//	    					$('#myModal').modal('show');
//	    		  		}
						$( "#tabLD" ).html("");
						
	    		
	    		  }else{
	    			  	$('#myModalErrorContent').html(data.messaggio);
	    			  	$('#myModalError').removeClass();
						$('#myModalError').addClass("modal modal-danger");
						$('#myModalError').modal('show');
						$( "#tabLD" ).html("");
	    		  }
	    		  $('#progress .progress-bar').css(
		                    'width',
		                    '0%'
		                );
	    	  },
	
	    	  error: function(jqXHR, textStatus, errorThrown){

	    		  pleaseWaitDiv.modal('hide');
	    		  
	    		   $('#myModalErrorContent').html(textStatus);
 			  		$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					$('#report_button').show();
					$('#visualizza_report').show();
					$('#myModalError').modal('show');

					$( "#tabLD" ).html("");
					  $('#progress .progress-bar').css(
			                    'width',
			                    '0%'
			                );
	    	  }
	      });
	  
  }

  function associaRuolo(idRuolo, idUtente){
	  $.ajax({
    	  type: "POST",
    	  url: "gestioneAssociazioniAjax.do?action=associaRuolo&idRuolo="+idRuolo+"&idUtente="+idUtente,
    	  dataType: "json",
    	  success: function( data, textStatus) {
    		  pleaseWaitDiv.modal('hide');
    		  if(data.success)
    		  { 
    			  $('#tabRuoliTr_'+idRuolo).addClass("bg-blue color-palette");
    			  $('#btnAssociaRuolo_'+idRuolo).attr("disabled",true);
    			  $('#btnDisAssociaRuolo_'+idRuolo).attr("disabled",false);
    			  
    		
    		  }else{
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
    	  			$('#visualizza_report').show();
    				$('#myModalError').modal('show');
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    		  pleaseWaitDiv.modal('hide');
   
   			$('#myModalErrorContent').html(errorThrown.message);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
  			$('#visualizza_report').show();
  			
			$('#myModalError').modal('show');
			
    	  }
      });
  }
  function disassociaRuolo(idRuolo, idUtente){
	  $.ajax({
    	  type: "POST",
    	  url: "gestioneAssociazioniAjax.do?action=disassociaRuolo&idRuolo="+idRuolo+"&idUtente="+idUtente,
    	  dataType: "json",
    	  success: function( data, textStatus) {
    		  pleaseWaitDiv.modal('hide');
    		  if(data.success)
    		  { 
    			  $('#tabRuoliTr_'+idRuolo).removeClass("bg-blue color-palette");
    			  $('#btnAssociaRuolo_'+idRuolo).attr("disabled",false);
    			  $('#btnDisAssociaRuolo_'+idRuolo).attr("disabled",true);
    		
    		  }else{
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
    	  			$('#visualizza_report').show();
    				$('#myModalError').modal('show');
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    		  pleaseWaitDiv.modal('hide');
   
   			$('#myModalErrorContent').html(errorThrown.message);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
  			$('#visualizza_report').show();
			$('#myModalError').modal('show');


    
    	  }
      });
  }
  
  function associaUtente(idUtente,idRuolo){
	  $.ajax({
    	  type: "POST",
    	  url: "gestioneAssociazioniAjax.do?action=associaUtente&idRuolo="+idRuolo+"&idUtente="+idUtente,
    	  dataType: "json",
    	  success: function( data, textStatus) {
    		  pleaseWaitDiv.modal('hide');
    		  if(data.success)
    		  { 
    			  $('#tabUtentiTr_'+idUtente).addClass("bg-blue color-palette");
    			  $('#btnAssociaUtente_'+idUtente).attr("disabled",true);
    			  $('#btnDisAssociaUtente_'+idUtente).attr("disabled",false);
    			  
    		
    		  }else{
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#myModalError').modal('show');
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    		  pleaseWaitDiv.modal('hide');
   
   			$('#myModalErrorContent').html(errorThrown.message);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
  			$('#visualizza_report').show();
			$('#myModalError').modal('show');
		
    
    	  }
      });
  }
  function disassociaUtente(idUtente,idRuolo){
	  $.ajax({
    	  type: "POST",
    	  url: "gestioneAssociazioniAjax.do?action=disassociaUtente&idRuolo="+idRuolo+"&idUtente="+idUtente,
    	  dataType: "json",
    	  success: function( data, textStatus) {
    		  pleaseWaitDiv.modal('hide');
    		  if(data.success)
    		  { 
    			  $('#tabUtentiTr_'+idUtente).removeClass("bg-blue color-palette");
    			  $('#btnAssociaUtente_'+idUtente).attr("disabled",false);
    			  $('#btnDisAssociaUtente_'+idUtente).attr("disabled",true);
    		
    		  }else{
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
    	  			$('#visualizza_report').show();
    				$('#myModalError').modal('show');
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    		  pleaseWaitDiv.modal('hide');
   
   			$('#myModalErrorContent').html(errorThrown.message);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
  			$('#visualizza_report').show();
			$('#myModalError').modal('show');
			
    	  }
      });
  }
  
  function associaPermesso(idPermesso,idRuolo){
	  $.ajax({
    	  type: "POST",
    	  url: "gestioneAssociazioniAjax.do?action=associaPermesso&idRuolo="+idRuolo+"&idPermesso="+idPermesso,
    	  dataType: "json",
    	  success: function( data, textStatus) {
    		  pleaseWaitDiv.modal('hide');
    		  if(data.success)
    		  { 
    			  $('#tabPermessiTr_'+idPermesso).addClass("bg-blue color-palette");
    			  $('#btnAssociaPermessi_'+idPermesso).attr("disabled",true);
    			  $('#btnDisAssociaPermessi_'+idPermesso).attr("disabled",false);
    			  
    		
    		  }else{
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
    	  			$('#visualizza_report').show();
    				$('#myModalError').modal('show');
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    		  pleaseWaitDiv.modal('hide');
   
   			$('#myModalErrorContent').html(errorThrown.message);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
  			$('#visualizza_report').show();
			$('#myModalError').modal('show');
			
    	  }
      });
  }
  function disassociaPermesso(idPermesso,idRuolo){
	  $.ajax({
    	  type: "POST",
    	  url: "gestioneAssociazioniAjax.do?action=disassociaPermesso&idRuolo="+idRuolo+"&idPermesso="+idPermesso,
    	  dataType: "json",
    	  success: function( data, textStatus) {
    		  pleaseWaitDiv.modal('hide');
    		  if(data.success)
    		  { 
    			  $('#tabPermessiTr_'+idPermesso).removeClass("bg-blue color-palette");
    			  $('#btnAssociaPermessi_'+idPermesso).attr("disabled",false);
    			  $('#btnDisAssociaPermessi_'+idPermesso).attr("disabled",true);
    		
    		  }else{
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
    	  			$('#visualizza_report').show();
    				$('#myModalError').modal('show');
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    		  pleaseWaitDiv.modal('hide');
   
   			$('#myModalErrorContent').html(errorThrown.message);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
  			$('#visualizza_report').show();
			$('#myModalError').modal('show');
			

    	  }
      });
  }
  
  //Associazioni Magazzino
  
  function associaAccessorio(idAccessorio, idArticolo){
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  quantita = $("#qty_"+idAccessorio).val();
	  
	  $.ajax({
    	  type: "POST",
    	  url: "gestioneAssociazioniArticoliAjax.do?action=associaAccessorio&idAccessorio="+idAccessorio+"&idArticolo="+idArticolo+"&quantita="+quantita,
    	  dataType: "json",
    	  success: function( data, textStatus) {
    		  pleaseWaitDiv.modal('hide');
    		  if(data.success)
    		  { 
    			  $('#tabAccessoriTr_'+idAccessorio).addClass("bg-blue color-palette");
    			  $('#btnAssociaAccessorio_'+idAccessorio).attr("disabled",true);
    			  $('#btnDisAssociaAccessorio_'+idAccessorio).attr("disabled",false);
    			  
    			  $('#tdqy_'+idAccessorio).html(quantita);
    		
    		  }else{
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
    	  			$('#visualizza_report').show();
    				$('#myModalError').modal('show');
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    		  pleaseWaitDiv.modal('hide');
   
   			$('#myModalErrorContent').html(errorThrown.message);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
  			$('#visualizza_report').show();
			$('#myModalError').modal('show');
			

    
    	  }
      });
  }
  function disassociaAccessorio(idAccessorio, idArticolo){
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  $.ajax({
    	  type: "POST",
    	  url: "gestioneAssociazioniArticoliAjax.do?action=disassociaAccessorio&idAccessorio="+idAccessorio+"&idArticolo="+idArticolo,
    	  dataType: "json",
    	  success: function( data, textStatus) {
    		  pleaseWaitDiv.modal('hide');
    		  if(data.success)
    		  { 
    			  $('#tabAccessoriTr_'+idAccessorio).removeClass("bg-blue color-palette");
    			  $('#btnAssociaAccessorio_'+idAccessorio).attr("disabled",false);
    			  $('#btnDisAssociaAccessorio_'+idAccessorio).attr("disabled",true);  			  
    			  $('#tdqy_'+idAccessorio).html('<input id="qty_'+idAccessorio+'" type="number" min="0"  value="1" /> ');
    		
    		  }else{
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
    	  			$('#visualizza_report').show();
    				$('#myModalError').modal('show');
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    		  pleaseWaitDiv.modal('hide');
   
   			$('#myModalErrorContent').html(errorThrown.message);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
  			$('#visualizza_report').show();
			$('#myModalError').modal('show');
			

    	  }
      });
  }
  
  function associaTipologiaDotazione(idTipoDotazione, idArticolo){
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  $.ajax({
    	  type: "POST",
    	  url: "gestioneAssociazioniArticoliAjax.do?action=associaTipologiaDotazione&idTipologiaDotazione="+idTipoDotazione+"&idArticolo="+idArticolo,
    	  dataType: "json",
    	  success: function( data, textStatus) {
    		  pleaseWaitDiv.modal('hide');
    		  if(data.success)
    		  { 
    			  $('#tabDotazioneTr_'+idTipoDotazione).addClass("bg-blue color-palette");
    			  $('#btnAssociaTipologiaDotazione_'+idTipoDotazione).attr("disabled",true);
    			  $('#btnDisAssociaTipologiaDotazione_'+idTipoDotazione).attr("disabled",false);
    			  
    		
    		  }else{
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
    	  			$('#visualizza_report').show();
    				$('#myModalError').modal('show');
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    		  pleaseWaitDiv.modal('hide');
   
   			$('#myModalErrorContent').html(errorThrown.message);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
  			$('#visualizza_report').show();
			$('#myModalError').modal('show');
			    
    	  }
      });
  }
  function disassociaTipologiaDotazione(idTipoDotazione, idArticolo){
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  $.ajax({
    	  type: "POST",
    	  url: "gestioneAssociazioniArticoliAjax.do?action=disassociaTipologiaDotazione&idTipologiaDotazione="+idTipoDotazione+"&idArticolo="+idArticolo,
    	  dataType: "json",
    	  success: function( data, textStatus) {
    		  pleaseWaitDiv.modal('hide');
    		  if(data.success)
    		  { 
    			  $('#tabDotazioneTr_'+idTipoDotazione).removeClass("bg-blue color-palette");
    			  $('#btnAssociaTipologiaDotazione_'+idTipoDotazione).attr("disabled",false);
    			  $('#btnDisAssociaTipologiaDotazione_'+idTipoDotazione).attr("disabled",true);
    		
    		  }else{
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
    	  			$('#visualizza_report').show();
    				$('#myModalError').modal('show');
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    		  pleaseWaitDiv.modal('hide');
   
   			$('#myModalErrorContent').html(errorThrown.message);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
  			$('#visualizza_report').show();
			$('#myModalError').modal('show');
			

    
    	  }
      });
  }
  
  function openDettaglioInterventoModal(tipo,loop){

	  if(tipo == "intervento"){
		  $('#interventiModal'+loop).modal("show");
	  }
	  if(tipo == "interventoDati"){
		  $('#interventiDatiModal'+loop).modal("show");
		 
	  }
  }
  
  function modalEliminaCertificatoCampione(id){
	  
	  $('#idElimina').val(id);
	  $('#modalEliminaCertificatoCampione').modal();
	  
  }
  
  function eliminaCertificatoCampione(){
			  
			  $("#modalEliminaCertificatoCampione").modal("hide");

	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();

	  var id=$('#idElimina').val();
	  var dataObj = {};
	  dataObj.idCert = id;


  $.ajax({
	  type: "POST",
	  url: "scaricaCertificato.do?action=eliminaCertificatoCampione",
	  data: dataObj,
	  dataType: "json",
	  success: function( data, textStatus) {
		  
		  pleaseWaitDiv.modal('hide');
		  
		  if(data.success)
		  { 
			
			  $('#report_button').hide();
	  			$('#visualizza_report').hide();
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-success");
				$('#myModalError').modal('show');
				
		
		  }else{
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
	  			$('#visualizza_report').show();
				$('#myModalError').modal('show');
			 
		  }
	  },

	  error: function(jqXHR, textStatus, errorThrown){
		  pleaseWaitDiv.modal('hide');

		  $('#myModalErrorContent').html(textStatus);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
  			$('#visualizza_report').show();
			$('#myModalError').modal('show');
			

	  }
  });
			  
  }
  
 function modificaValoriCampioneTrigger(umJson, index) {
	  
	  
	  $(".numberfloat").change(function(){

	    	var str = $(this).val();
	    	var res = str.replace(",",".");
	    	$(this).val(res);
	    });
  	$(".incRelativa").change(function(){
  		
  		var str = $(this).val();
	    	var res = str.replace(",",".");
	    	
	    	var thisid = $(this).attr('id');
	    	
	    	var resId = thisid.split("_");
	    	
	    	
	    	
	    	var taratura = $("#tblAppendGrid_valore_taratura_"+resId[3]).val();
	    	if(taratura != 0 && taratura != ""){
	    		Big.DP = 40;
	    		Big.NE = -40
 	    		x = new Big(res);
	    		y = new Big(taratura);
	    		
	    		 var assoluta1 = x.times(y);
 	    		 //alert(assoluta1);
		    	 $("#tblAppendGrid_incertezza_assoluta_"+resId[3]).val(assoluta1);

	    	}
	    	
  	});
  	$("input").change(function(){ 
  		
  		$("#ulError").html("");
  	});
  	$("select").change(function(){ 
  		
  		$("#ulError").html("");
  	});
  	$("input").keydown(function(){ 
  		
  		$("#ulError").html("");
  	});
  	$("select").keydown(function(){ 
  		
  		$("#ulError").html("");
  	});
//
//  	$('.select2MV').select2({
//  	//	placeholder: "Seleziona",
//  		//dropdownCssClass: "select2MVOpt",  		
//  	});
  		
//	$('.tipograndezzeselect').on("change",function(evt){
//  		var str = $(this).attr("id");
//  		var value = $(this).val();
//  		var resId = str.split("_");
//  		var select = $('#tblAppendGrid_unita_misura_'+resId[3]);   
//		select.empty();
//  		if(value!=0 && value!=null){	
//  			var umList = umJson[value];
//  			
//  			for (var j = 0; j < umList.length; j++){       
//  				
//  				
//  				select.append("<option value='" +umList[j].value+ "'>" +umList[j].label+ "</option>");    
//  				break;
//  			}   
//		}
//  		
//  	});
  	
	
		$('#tblAppendGrid_tipo_grandezza_'+index).on("change",function(evt){
	  		var str = $(this).attr("id");
	  		var value = $(this).val();
	  		var resId = str.split("_");
	  		var select = $('#tblAppendGrid_unita_misura_'+resId[3]);   
			select.empty();
	  		if(value!=0 && value!=null){	
	  			var umList = umJson[value];
	  			
	  			for (var j = 0; j < umList.length; j++){       
	  				
	  				
	  				select.append("<option value='" +umList[j].value+ "'>" +umList[j].label+ "</option>");    
	  				
	  			}   
			}
	  		
	  	});
  	

  	
  }
  function dettaglioStrumentoFromMisura(idStrumento){
	  exploreModal("dettaglioStrumento.do","id_str="+idStrumento,"#dettaglio");
	  $( "#myModalDettaglioStrumento" ).modal();
	  $('body').addClass('noScroll');
	}
 
  var arrayListaPuntiJson;
  function openDettaglioPunto(indexArrayPunti, indexPunto){
	  //alert(arrayListaPuntiJson[indexArrayPunti][indexPunto].accettabilita);
	  
	  
	

	  $("#dettaglioPuntoID").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].id);
	  $("#dettaglioPuntoIdTabella").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].id_tabella);
	  $("#dettaglioPuntoOrdine").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].ordine);
	  $("#dettaglioPuntoTipoProva").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].tipoProva);
	  $("#dettaglioPuntoUM").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].um);
	  $("#dettaglioPuntoValoreCampione").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].valoreCampione);
	  $("#dettaglioPuntoValoreMedioCampione").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].valoreMedioCampione);
	  $("#dettaglioPuntoValoreStrumento").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].valoreStrumento);
	  $("#dettaglioPuntoValoreMedioStrumento").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].valoreMedioStrumento);
	  $("#dettaglioPuntoScostamento").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].scostamento);
	  $("#dettaglioPuntoAccettabilita").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].accettabilita);
	  $("#dettaglioPuntoIncertezza").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].incertezza);
	  $("#dettaglioPuntoEsito").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].esito);
	  $("#dettaglioPuntoDescrizioneCampione").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].desc_Campione);
	  $("#dettaglioPuntoDescrizioneParametro").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].desc_parametro);
	  $("#dettaglioPuntoMisura").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].misura);
	  $("#dettaglioPuntoUMCalcolata").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].um_calc);
	  $("#dettaglioPuntoRisoluzioneMisura").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].risoluzione_misura);
	  $("#dettaglioPuntoRisoluzioneCampione").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].risoluzione_campione);
	  $("#dettaglioPuntoFondoScala").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].fondoScala);
	  $("#dettaglioPuntoInterpolazione").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].interpolazione);
	  $("#dettaglioPuntoFM").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].fm);
	  $("#dettaglioPuntoSelConversione").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].selConversione);
	  $("#dettaglioPuntoSelTolleranza").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].selTolleranza);
	  $("#dettaglioPuntoLetturaCampione").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].letturaCampione);
	  $("#dettaglioPuntoPercUtil").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].per_util);
	  $("#dettaglioPuntoDigit").html(arrayListaPuntiJson[indexArrayPunti][indexPunto].dgt);
	  
	  
	  $("#dettaglioPuntoIDmod").val(arrayListaPuntiJson[indexArrayPunti][indexPunto].id);
	  $("#dettaglioPuntoIdTabellamod").val(arrayListaPuntiJson[indexArrayPunti][indexPunto].id_tabella);
	  $("#dettaglioPuntoUMmod").val(arrayListaPuntiJson[indexArrayPunti][indexPunto].um);
	  $("#dettaglioPuntoValoreCampionemod").val(arrayListaPuntiJson[indexArrayPunti][indexPunto].valoreCampione);
	  $("#dettaglioPuntoValoreMedioCampionemod").val(arrayListaPuntiJson[indexArrayPunti][indexPunto].valoreMedioCampione);
	  $("#dettaglioPuntoValoreStrumentomod").val(arrayListaPuntiJson[indexArrayPunti][indexPunto].valoreStrumento);
	  $("#dettaglioPuntoValoreMedioStrumentomod").val(arrayListaPuntiJson[indexArrayPunti][indexPunto].valoreMedioStrumento);
	  $("#dettaglioPuntoScostamentomod").val(arrayListaPuntiJson[indexArrayPunti][indexPunto].scostamento);
	  $("#dettaglioPuntoAccettabilitamod").val(arrayListaPuntiJson[indexArrayPunti][indexPunto].accettabilita);
	  $("#dettaglioPuntoIncertezzamod").val(arrayListaPuntiJson[indexArrayPunti][indexPunto].incertezza);
	  $("#dettaglioPuntoEsitomod").val(arrayListaPuntiJson[indexArrayPunti][indexPunto].esito);
	  $("#dettaglioPuntoMisuramod").val(arrayListaPuntiJson[indexArrayPunti][indexPunto].misura);
	  $("#dettaglioPuntoRisoluzioneMisuramod").val(arrayListaPuntiJson[indexArrayPunti][indexPunto].risoluzione_misura);
	  $("#dettaglioPuntoRisoluzioneCampionemod").val(arrayListaPuntiJson[indexArrayPunti][indexPunto].risoluzione_campione);
	  $("#dettaglioPuntoFondoScalamod").val(arrayListaPuntiJson[indexArrayPunti][indexPunto].fondoScala);
	  $("#dettaglioPuntoInterpolazionemod").val(arrayListaPuntiJson[indexArrayPunti][indexPunto].interpolazione);
	  $("#dettaglioPuntoPercUtilmod").val(arrayListaPuntiJson[indexArrayPunti][indexPunto].per_util);

	  $("#myModalDettaglioPunto").modal();
  }
 
  function modificaPunto(){
	  
	  var dataObj = {};
		
  	  dataObj.id =  $("#dettaglioPuntoIDmod").val();
  	  dataObj.id_tabella =  $("#dettaglioPuntoIdTabellamod").val();
  	  dataObj.um =  $("#dettaglioPuntoUMmod").val();
  	  dataObj.valoreCampione =  $("#dettaglioPuntoValoreCampionemod").val();
  	  dataObj.valoreMedioCampione =  $("#dettaglioPuntoValoreMedioCampionemod").val();
  	  dataObj.valoreStrumento =  $("#dettaglioPuntoValoreStrumentomod").val();
  	  dataObj.valoreMedioStrumento =  $("#dettaglioPuntoValoreMedioStrumentomod").val();
  	  dataObj.scostamento =  $("#dettaglioPuntoScostamentomod").val();
  	  dataObj.accettabilita =  $("#dettaglioPuntoAccettabilitamod").val();
  	  dataObj.incertezza =  $("#dettaglioPuntoIncertezzamod").val();
  	  dataObj.esito =  $("#dettaglioPuntoEsitomod").val();
  	  dataObj.misura =  $("#dettaglioPuntoMisuramod").val();
  	  dataObj.risoluzione_misura =  $("#dettaglioPuntoRisoluzioneMisuramod").val();
  	  dataObj.risoluzione_campione =  $("#dettaglioPuntoRisoluzioneCampionemod").val();
  	  dataObj.fondoScala =  $("#dettaglioPuntoFondoScalamod").val();
  	  dataObj.interpolazione =  $("#dettaglioPuntoInterpolazionemod").val();
  	  dataObj.per_util =  $("#dettaglioPuntoPercUtilmod").val();
	  
      $.ajax({
      	  type: "POST",
      	  url: "gestionePuntoMisura.do?action=salva",
      	  data: dataObj,
      	  dataType: "json",

      	  success: function( data, textStatus) {
      		 $('#myModalDettaglioPunto').modal('hide');
      		  if(data.success)
      		  { 
      			  data.punto = JSON.parse(data.punto);
      			 
       	          callAction("dettaglioMisura.do?idMisura="+data.punto.id_misura)
      			  	
      		
      		  }else{
       			 $("#myModalErrorContent").html(data.messaggio);      			 
     			$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
	  			$('#visualizza_report').show();
				$('#myModalError').modal('show');
				
      			 
      		  }
      	  },

      	  error: function(jqXHR, textStatus, errorThrown){
      	

      		 $("#myModalErrorContent").html(textStatus);      			 
  			$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
	  			$('#visualizza_report').show();
				$('#myModalError').modal('show');
			

      	  }
        });
  	  
  }
  
  
//Gestione Accessori
  function nuovoAccessorio(){
  	  
  	  if($("#formNuovoAccessorio").valid()){
  		  pleaseWaitDiv = $('#pleaseWaitDialog');
  		  pleaseWaitDiv.modal();

  	  
  	  var nome=$('#nome').val();
  	  var descrizione=$('#descrizione').val();
  	  var quantita = $("#quantita").val();
  	  var tipologia = $("#tipologia").val();

  	  var dataObj = {};
  		
  	  dataObj.nome = nome;
  	  dataObj.descrizione = descrizione;
  	  dataObj.quantita = quantita;
  	  dataObj.tipologia = tipologia;
  	
  	  var sList = "";

  	  $('#formNuovoAccessorio input[type=checkbox]').each(function () {
  		  if(this.checked){
  			  if(sList.length>0){
  				  sList += ",";
  			  }
  			  sList += $(this).val();
  		  }
  		  
  		    
  		});
  	  dataObj.permessi = sList;
  	  
            $.ajax({
          	  type: "POST",
          	  url: "gestioneAccessori.do?action=nuovo",
          	  data: dataObj,
          	  dataType: "json",
          	  success: function( data, textStatus) {
          		  
          		  pleaseWaitDiv.modal('hide');
          		  
          		  if(data.success)
          		  { 
          			 
          			$('#report_button').hide();
    	  			$('#visualizza_report').hide();
          			  $("#modalNuovoAccessorio").modal("hide");
          			  $('#myModalErrorContent').html(data.messaggio);
          			  	$('#myModalError').removeClass();
          				$('#myModalError').addClass("modal modal-success");
          				$('#myModalError').modal('show');
          				
          		
          		  }else{
          			  $('#myModalErrorContent').html(data.messaggio);
          			  	$('#myModalError').removeClass();
          				$('#myModalError').addClass("modal modal-danger");
          				$('#report_button').show();
        	  			$('#visualizza_report').show();
          				$('#myModalError').modal('show');
          			 
          		  }
          	  },

          	  error: function(jqXHR, textStatus, errorThrown){
          		  pleaseWaitDiv.modal('hide');

          		  $('#myModalErrorContent').html(textStatus);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
    	  			$('#visualizza_report').show();
    				$('#myModalError').modal('show');
    				          
          	  }
            });
  	  }
    }
    
  function modificaAccessorio(){
  	  

  		  pleaseWaitDiv = $('#pleaseWaitDialog');
  		  pleaseWaitDiv.modal();

  	  var id=$('#modid').val();
  	  var sigla=$('#modnome').val();
  	  var descrizione=$('#moddescrizione').val();
  	  var quantita=$("#modquantita").val();
  	  var tipologia = $("#modtipologia").val();
  	
  	  var dataObj = {};
  	  dataObj.id = id;
  	  dataObj.nome = nome;
  	  dataObj.descrizione = descrizione;
  	  dataObj.quantita = quantita;
  	  dataObj.tipologia = tipologia;
  	
          $.ajax({
        	  type: "POST",
        	  url: "gestioneAccessori.do?action=modifica",
        	  data: dataObj,
        	  dataType: "json",
        	  success: function( data, textStatus) {
        		  
        		  pleaseWaitDiv.modal('hide');
        		  
        		  if(data.success)
        		  { 
        			  $('#report_button').hide();
      	  			$('#visualizza_report').hide();
        			  $("#modalModificaAcessorio").modal("hide");
        			  $('#myModalErrorContent').html(data.messaggio);
        			  	$('#myModalError').removeClass();
        				$('#myModalError').addClass("modal modal-success");
        				$('#myModalError').modal('show');
        				
        		
        		  }else{
        			  $('#myModalErrorContent').html(data.messaggio);
        			  	$('#myModalError').removeClass();
        				$('#myModalError').addClass("modal modal-danger");
        				$('#report_button').show();
        	  			$('#visualizza_report').show();
        				$('#myModalError').modal('show');
        			 
        		  }
        	  },

        	  error: function(jqXHR, textStatus, errorThrown){
        		  pleaseWaitDiv.modal('hide');

        		  $('#myModalErrorContent').html(textStatus);
  			  	$('#myModalError').removeClass();
  				$('#myModalError').addClass("modal modal-danger");
  				$('#report_button').show();
	  			$('#visualizza_report').show();
				$('#myModalError').modal('show');
				
        
        	  }
          });
  	  
  }


  function eliminaAccessorio(){
  	 
  	$("#modalEliminaAccessorio").modal("hide");

  	  pleaseWaitDiv = $('#pleaseWaitDialog');
  	  pleaseWaitDiv.modal();

  	  var id=$('#idElimina').val();
  	  var dataObj = {};
  	  dataObj.id = id;


    $.ajax({
  	  type: "POST",
  	  url: "gestioneAccessori.do?action=elimina",
  	  data: dataObj,
  	  dataType: "json",
  	  success: function( data, textStatus) {
  		  
  		  pleaseWaitDiv.modal('hide');
  		  
  		  if(data.success)
  		  { 
  			
  			$('#report_button').hide();
  			$('#visualizza_report').hide();
  			  $('#myModalErrorContent').html(data.messaggio);
  			  	$('#myModalError').removeClass();
  				$('#myModalError').addClass("modal modal-success");
  				$('#myModalError').modal('show');
  				
  		
  		  }else{
  			  $('#myModalErrorContent').html(data.messaggio);
  			  	$('#myModalError').removeClass();
  				$('#myModalError').addClass("modal modal-danger");
  				$('#report_button').show();
	  			$('#visualizza_report').show();
  				$('#myModalError').modal('show');
  			 
  		  }
  	  },

  	  error: function(jqXHR, textStatus, errorThrown){
  		  pleaseWaitDiv.modal('hide');

  		  $('#myModalErrorContent').html(textStatus);
  		  	$('#myModalError').removeClass();
  			$('#myModalError').addClass("modal modal-danger");
  			$('#report_button').show();
  			$('#visualizza_report').show();
  			$('#myModalError').modal('show');

  	  }
    });

  }

  function caricaAccessorio(){
  	  

		  pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();

	  var id=$('#caricoid').val();


	  var quantita=$("#caricoquantita").val();
	  var note=$("#cariconote").val();
	
	  var dataObj = {};
	  dataObj.id = id;
 
	  dataObj.quantita = quantita;
	  dataObj.note = note;
	
      $.ajax({
    	  type: "POST",
    	  url: "gestioneAccessori.do?action=caricoscarico",
    	  data: dataObj,
    	  dataType: "json",
    	  success: function( data, textStatus) {
    		  
    		  pleaseWaitDiv.modal('hide');
    		  
    		  if(data.success)
    		  { 
    			  $('#report_button').hide();
  	  			$('#visualizza_report').hide();
    			  $("#modalModificaAcessorio").modal("hide");
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-success");
    				$('#myModalError').modal('show');
    				
    		
    		  }else{
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
    	  			$('#visualizza_report').show();
    				$('#myModalError').modal('show');
    			 
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    		  pleaseWaitDiv.modal('hide');

    		  $('#myModalErrorContent').html(textStatus);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
	  			$('#visualizza_report').show();
				$('#myModalError').modal('show');
				
    
    	  }
      });
	  
}
  
    function modalModificaAccessorio(id,nome,descrizione,quantita){
  	  
  	  $('#modid').val(id);
  	  $('#modnome').val(nome);
  	  $('#moddescrizione').val(descrizione);
  	  $('#modquantita').val(quantita);

  	  $('#modtipologia').val(tipologia).trigger('change');
  	  $('#modalModificaAccessorio').modal();
  	  
    }
    
    
    function modalCaricoAccessorio(id,nome,descrizione,quantitaFisica,quantitaPrenotata){
    	  
    	  $('#caricoid').val(id);
    	  $('#textnome').text(nome);
    	  $('#textdescrizione').text(descrizione);
    	  $('#textquantitafisica').text(quantitaFisica);
    	  $('#textquantitaprenotata').text(quantitaPrenotata);
    	  

    	  $('#modalCaricoAccessorio').modal();
    	  
      }
    
    
    function modalEliminaAccessorio(id,nome){
  	  
  	  $('#idElimina').val(id);  	  
  	  $('#accessorioElimina').html(nome);
  	  $('#modalEliminaAccessorio').modal();
  	  
    }
  
  
  //Gestione Dotazione
    function nuovaDotazione(){
    	  
    	  if($("#formNuovaDotazione").valid()){
    		  pleaseWaitDiv = $('#pleaseWaitDialog');
    		  pleaseWaitDiv.modal();

    		  var form = $('#formNuovaDotazione')[0]; 
    		  var formData = new FormData(form);
    		  
//    	  var marca=$('#marca').val();
//    	  var modello=$('#modello').val();
//    	  var targa = $("#targa").val();
//    	  var matricola = $("#matricola").val();
//    	  var tipologia = $("#tipologia").val();
    	  
//    	  var dataObj = {};
//    		
//    	  dataObj.marca = marca;
//    	  dataObj.modello = modello;
//    	  dataObj.targa = targa;
//    	  dataObj.matricola = matricola;
//    	  dataObj.tipologia = tipologia;
//    	  
              $.ajax({
            	  type: "POST",
            	  url: "gestioneDotazioni.do?action=nuovo",
            	  data: formData,
            	  contentType: false, // NEEDED, DON'T OMIT THIS (requires jQuery 1.6+)
            	  processData: false, // NEEDED, DON'T OMIT THIS
            	  success: function( data, textStatus) {
            		  
            		  pleaseWaitDiv.modal('hide');
            		  
            		  if(data.success)
            		  { 
            			 
            			  $('#report_button').hide();
          	  			$('#visualizza_report').hide();
            			  $("#modalNuovDotazione").modal("hide");
            			  $('#myModalErrorContent').html(data.messaggio);
            			  	$('#myModalError').removeClass();
            				$('#myModalError').addClass("modal modal-success");
            				$('#myModalError').modal('show');
            				
            		
            		  }else{
            			  $('#myModalErrorContent').html(data.messaggio);
            			  	$('#myModalError').removeClass();
            				$('#myModalError').addClass("modal modal-danger");
            				$('#report_button').show();
            	  			$('#visualizza_report').show();
            				$('#myModalError').modal('show');
            			 
            		  }
            	  },

            	  error: function(jqXHR, textStatus, errorThrown){
            		  pleaseWaitDiv.modal('hide');

            		  $('#myModalErrorContent').html(textStatus);
      			  	$('#myModalError').removeClass();
      				$('#myModalError').addClass("modal modal-danger");
      				$('#report_button').show();
    	  			$('#visualizza_report').show();
    				$('#myModalError').modal('show');
    				
            
            	  }
              });
    	  }
     }
      
    function modificaDotazione(){
    	  

    		  pleaseWaitDiv = $('#pleaseWaitDialog');
    		  pleaseWaitDiv.modal();

//    		  var marca=$('#marca').val();
//        	  var modello=$('#modello').val();
//        	  var targa = $("#targa").val();
//        	  var matricola = $("#matricola").val();
//        	  var tipologia = $("#modtipologia").val();
//        	  
//        	  var dataObj = {};
//        		
//        	  dataObj.marca = marca;
//        	  dataObj.modello = modello;
//        	  dataObj.targa = targa;
//        	  dataObj.matricola = matricola;
//        	  dataObj.tipologia = tipologia;
    		  var form = $('#formModificaDotazione')[0]; 
    		  var formData = new FormData(form);
            $.ajax({
          	  type: "POST",
          	  url: "gestioneDotazioni.do?action=modifica",
          	  data: formData,
          	  contentType: false, // NEEDED, DON'T OMIT THIS (requires jQuery 1.6+)
          	  processData: false, // NEEDED, DON'T OMIT THIS
//          	  dataType: "json",
          	  success: function( data, textStatus) {
          		  
          		  pleaseWaitDiv.modal('hide');
          		  
          		  if(data.success)
          		  { 
          			$('#report_button').hide();
    	  			$('#visualizza_report').hide();
          			  $("#modalModificaDotazione").modal("hide");
          			  $('#myModalErrorContent').html(data.messaggio);
          			  	$('#myModalError').removeClass();
          				$('#myModalError').addClass("modal modal-success");
          				$('#myModalError').modal('show');
          				
          		
          		  }else{
          			  $('#myModalErrorContent').html(data.messaggio);
          			  	$('#myModalError').removeClass();
          				$('#myModalError').addClass("modal modal-danger");
          				$('#report_button').show();
        	  			$('#visualizza_report').show();
          				$('#myModalError').modal('show');
          			 
          		  }
          	  },

          	  error: function(jqXHR, textStatus, errorThrown){
          		  pleaseWaitDiv.modal('hide');

          		  $('#myModalErrorContent').html(textStatus);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
    	  			$('#visualizza_report').show();
    				$('#myModalError').modal('show');

          	  }
            });
    	  
    }


    function eliminaDotazione(){
    	 
    	$("#modalEliminaDotazione").modal("hide");

    	  pleaseWaitDiv = $('#pleaseWaitDialog');
    	  pleaseWaitDiv.modal();

    	  var id=$('#idElimina').val();
    	  var dataObj = {};
    	  dataObj.id = id;


      $.ajax({
    	  type: "POST",
    	  url: "gestioneDotazioni.do?action=elimina",
    	  data: dataObj,
    	  dataType: "json",
    	  success: function( data, textStatus) {
    		  
    		  pleaseWaitDiv.modal('hide');
    		  
    		  if(data.success)
    		  { 
    			
    			  $('#report_button').hide();
  	  			$('#visualizza_report').hide();
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-success");
    				$('#myModalError').modal('show');
    				
    		
    		  }else{
    			  $('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
    	  			$('#visualizza_report').show();
    				$('#myModalError').modal('show');
    			 
    		  }
    	  },

    	  error: function(jqXHR, textStatus, errorThrown){
    		  pleaseWaitDiv.modal('hide');

    		  $('#myModalErrorContent').html(textStatus);
    		  	$('#myModalError').removeClass();
    			$('#myModalError').addClass("modal modal-danger");
    			$('#report_button').show();
	  			$('#visualizza_report').show();
				$('#myModalError').modal('show');
				
    	  }
      });

    }

  
    
      function modalModificaDotazioni(id,marca,modello,tipologia,matricola,targa,schedaTecnica){
    	  
    	  $('#modid').val(id);
    	  $('#modmarca').val(marca);
    	  $('#modmodello').val(modello);
    	  $('#modmatricola').val(matricola);
    	  $('#modtarga').val(targa);
   
    	  $('#modtipologia').val(tipologia).trigger('change');
    	  $('#modalModificaDotazione').modal();
    	  
      }
      
      
      function modalEliminaDotazione(id,modello){
    	  
    	  $('#idElimina').val(id);  	  
    	  $('#dotazioneElimina').html(modello);
    	  $('#modalEliminaDotazione').modal();
    	  
      }
    
     function creaNuovoInterventoCampionamento(selezionati,idCommessa){
    	  
    	 	$.form("gestioneInterventoCampionamento.do?action=nuovoIntervento&idCommessa="+idCommessa, {"ids" : JSON.stringify(selezionati)} , 'POST').submit();
    	 	
     }
 

     function cercaStrumentiInScadenzaClienti(){
    	 	var startDatePicker = $("#datarange").data('daterangepicker').startDate;
    	 	var endDatePicker = $("#datarange").data('daterangepicker').endDate;
    	 	exploreModal("listaSediStrumentiInScadenza.do?dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + endDatePicker.format('YYYY-MM-DD'), "", "#tabellaLista", null);
    	 	//alert(startDatePicker.format('YYYY-MM-DD') + " - " + endDatePicker.format('YYYY-MM-DD'));
     }
     
     function listaStrumentiSede(idSede){
 	 	var dateFrom = $("#datarange").data('daterangepicker').startDate;
	 	var dateTo = $("#datarange").data('daterangepicker').endDate;
 	 	callAction('listaStrumentiCalendario.do?dateFrom='+dateFrom.format('YYYY-MM-DD')+'&dateTo='+dateTo.format('YYYY-MM-DD')+'&idSede='+idSede);
	  }
	  function listaStrumentiCliente(idCliente){
	 	 	var dateFrom = $("#datarange").data('daterangepicker').startDate;
		 	var dateTo = $("#datarange").data('daterangepicker').endDate;
		 	callAction('listaStrumentiCalendario.do?dateFrom='+dateFrom.format('YYYY-MM-DD')+'&dateTo='+dateTo.format('YYYY-MM-DD')+'&idCliente='+idCliente);
	  }
  
	  function filtraStrumenti(filtro,idFiltro){
		 // $("#divFiltroDate").hide();
		  minDateFilter = "";
		  maxDateFilter = "";
		  dataType = "";
		  table.draw();
		  if(filtro=="tutti"){
			  table
		        .columns( 2 )
		        .search( "" )
		        .draw();
			  $(".btnFiltri").prop("disabled",false);
			  $("#btnTutti").prop("disabled",true);
			  $("#inputsearchtable_2").val("");
		  }else {
			  table
		        .columns( 2 )
		        .search( filtro )
		        .draw();
			  $(".btnFiltri").prop("disabled",false);
			  $("#btnFiltri_"+idFiltro).prop("disabled",true);
//			  if(idFiltro == 7226){
//				  $("#divFiltroDate").show();
//				  
//			  }
			  $("#inputsearchtable_2").val(filtro);
		  }
	  }
	  
	     function filtraStrumentiInScadenza(dataTypeStr){
	    	 	var startDatePicker = $("#datarange").data('daterangepicker').startDate;
	    	 	var endDatePicker = $("#datarange").data('daterangepicker').endDate;


	    	 		minDateFilter = new Date(startDatePicker.format('YYYY-MM-DD') ).getTime();

	    	 		maxDateFilter = new Date(endDatePicker.format('YYYY-MM-DD') ).getTime();
	    	 		dataType = dataTypeStr; 
	    	      table.draw();
	    	       
	       }
	     

	  
	  function filtraInterventi(filtro,idFiltro){
		  if(filtro=="tutti"){
			  table
		        .columns( 5 )
		        .search( "" )
		        .draw();
			  $(".btnFiltri").prop("disabled",false);
			  $("#btnTutti").prop("disabled",true);
			  
		  }else {
			  table
		        .columns( 5 )
		        .search( filtro )
		        .draw();
			  $(".btnFiltri").prop("disabled",false);
			  $("#btnFiltri_"+idFiltro).prop("disabled",true);
		  }
	  }
	  
  function chiudiIntervento(idIntervento,datatable,index){
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  var dataObj = {};
	  dataObj.idIntervento = idIntervento;
	  $.ajax({
	    	  type: "POST",
	    	  url: "gestioneIntervento.do?action=chiudi",
	    	  data: dataObj,
	    	  dataType: "json",
	    	  success: function( data, textStatus) {
	    		  
	    		  pleaseWaitDiv.modal('hide');
	    		  $(".ui-tooltip").remove();
	    		  if(data.success)
	    		  { 
	    			  if(datatable == 1){
 	    				  var oTable = $('#tabPM').dataTable();
	    				  oTable.fnUpdate( '<a href="#" class="customTooltip" title="Click per aprire l\'Intervento"  onClick="apriIntervento('+idIntervento+',1,'+index+')" id="statoa_'+idIntervento+'"><span class="label label-warning">CHIUSO</span></a>', index, 4 );
	    			  }else if(datatable == 2){
	    				  var oTable = $('#tabPM').dataTable();
	    				  oTable.fnUpdate( '<a href="#" class="customTooltip" title="Click per aprire l\'Intervento"  onClick="apriIntervento('+idIntervento+',2,'+index+')" id="statoa_'+idIntervento+'"><span class="label label-warning">CHIUSO</span></a>', index, 5 );
	    			  }else{
	    				  $("#statoa_"+idIntervento).html('<a href="#" class="customTooltip" title="Click per aprire l\'Intervento"  onClick="apriIntervento('+idIntervento+',0,'+index+')" id="statoa_'+idIntervento+'"><span class="label label-warning">CHIUSO</span></a>');
	    			  }
	    			 
	    			 
	    			  $('#report_button').hide();
	    	  			$('#visualizza_report').hide();
	    			  $('#myModalErrorContent').html(data.messaggio);
	    			  $("#boxPacchetti").html("");
	    			  	$('#myModalError').removeClass();
	    				$('#myModalError').addClass("modal modal-success");
	    				$('#myModalError').modal('show');

	    		
	    		  }else{
	    			  $('#myModalErrorContent').html(data.messaggio);
	    			  
	    			  	$('#myModalError').removeClass();
	    				$('#myModalError').addClass("modal modal-danger");
	    				$('#report_button').show();
	    	  			$('#visualizza_report').show();
	    				$('#myModalError').modal('show');
	    			 
	    		  }
	    	  },
	
	    	  error: function(jqXHR, textStatus, errorThrown){
	    		  pleaseWaitDiv.modal('hide');
	
	    		  $('#myModalErrorContent').html(textStatus);
	    		  $('#myModalErrorContent').html(data.messaggio);
	    		  	$('#myModalError').removeClass();
	    			$('#myModalError').addClass("modal modal-danger");
	    			$('#report_button').show();
    	  			$('#visualizza_report').show();
					$('#myModalError').modal('show');
						
	    	  }
      });
  }
  
  function apriIntervento(idIntervento,datatable,index){
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  var dataObj = {};
	  dataObj.idIntervento = idIntervento;
	  $.ajax({
	    	  type: "POST",
	    	  url: "gestioneIntervento.do?action=apri",
	    	  data: dataObj,
	    	  dataType: "json",
	    	  success: function( data, textStatus) {
	    		  
	    		  pleaseWaitDiv.modal('hide');
	    		  $(".ui-tooltip").remove();
	    		  if(data.success)
	    		  { 
	    			  if(datatable == 1){
 	    				  var oTable = $('#tabPM').dataTable();
	    				  oTable.fnUpdate( '<a href="#" class="customTooltip" title="Click per chiudere l\'Intervento"  onClick="chiudiIntervento('+idIntervento+',1,'+index+')" id="statoa_'+idIntervento+'"><span class="label label-success">APERTO</span></a>', index, 4 );
	    			  }else if(datatable == 2){
	    				  var oTable = $('#tabPM').dataTable();
	    				  oTable.fnUpdate( '<a href="#" class="customTooltip" title="Click per chiudere l\'Intervento"  onClick="chiudiIntervento('+idIntervento+',2,'+index+')" id="statoa_'+idIntervento+'"><span class="label label-success">APERTO</span></a>', index, 5 );
	    			  }else{
	    				  $("#statoa_"+idIntervento).html('<a href="#" class="customTooltip" title="Click per chiudere l\'Intervento"  onClick="chiudiIntervento('+idIntervento+',0,'+index+')" id="statoa_'+idIntervento+'"><span class="label label-success">APERTO</span></a>');
	    			  }
	    			 
	    			  $('#report_button').hide();
	    	  			$('#visualizza_report').hide();
	    			  $('#myModalErrorContent').html(data.messaggio);
	    			  $("#boxPacchetti").html("");
	    			  	$('#myModalError').removeClass();
	    				$('#myModalError').addClass("modal modal-success");
	    				$('#myModalError').modal('show');

	    		
	    		  }else{
	    			 
	    			  $('#myModalErrorContent').html(data.messaggio);
	    			  	$('#myModalError').removeClass();
	    				$('#myModalError').addClass("modal modal-danger");
	    				$('#report_button').show();
	    	  			$('#visualizza_report').show();
	    				$('#myModalError').modal('show');
	    			 
	    		  }
	    	  },
	
	    	  error: function(jqXHR, textStatus, errorThrown){
	    		  pleaseWaitDiv.modal('hide');
	
	    		  $('#myModalErrorContent').html(textStatus);
	    		  $('#myModalErrorContent').html(data.messaggio);
	    		  	$('#myModalError').removeClass();
	    			$('#myModalError').addClass("modal modal-danger");
	    			$('#report_button').show();
    	  			$('#visualizza_report').show();
					$('#myModalError').modal('show');				
	
	    	  }
      });
  }
  
  function inserisciNuovaSede(nome_sede, id_intervento){
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  var dataObj = {};
	  dataObj.id_intervento = id_intervento;
	  dataObj.nome_sede = nome_sede;
	  $.ajax({
	    	  type: "POST",
	    	  url: "gestioneIntervento.do?action=nuova_sede",
	    	  data: dataObj,
	    	  dataType: "json",
	    	  success: function( data, textStatus) {
	    		  
	    		  pleaseWaitDiv.modal('hide');
	    		  $(".ui-tooltip").remove();
	    		  if(data.success)
	    		  { 

	    			  $("#nome_sede").html(nome_sede);
	    			 
	    			  $('#myModalErrorContent').html(data.messaggio);
	    			  $('#report_button').hide();
	    	  			$('#visualizza_report').hide();
	    			  	$('#myModalError').removeClass();
	    				$('#myModalError').addClass("modal modal-success");
	    				$('#myModalError').modal('show');

	    		
	    		  }else{
	    			  $('#myModalErrorContent').html(data.messaggio);
	    			
	    			  	$('#myModalError').removeClass();
	    				$('#myModalError').addClass("modal modal-danger");
	    				$('#report_button').show();
	    	  			$('#visualizza_report').show();
	    				$('#myModalError').modal('show');
	    			 
	    		  }
	    	  },
	
	    	  error: function(jqXHR, textStatus, errorThrown){
	    		  pleaseWaitDiv.modal('hide');
	
	    		  $('#myModalErrorContent').html(textStatus);
	    		 
	    		  	$('#myModalError').removeClass();
	    			$('#myModalError').addClass("modal modal-danger");
	    			$('#report_button').show();
    	  			$('#visualizza_report').show();
					$('#myModalError').modal('show');
					
	
	    	  }
      });
	  
	  $("#myModalCambiaSede").modal('hide');
	  
  }
  
  function scaricaSchedaConsegnaModal(){
	  $("#myModalDownloadSchedaConsegna").modal('show');
  }
  function creaNuovoPacco(){
	  $("#myModalCreaNuovoPacco").modal('show');
  }
  
  function stripHtml(html){
	    // Create a new div element
	    var temporalDivElement = document.createElement("div");
	    // Set the HTML content with the providen
	    temporalDivElement.innerHTML = html;
	    // Retrieve the text property of the element (cross-browser support)
	    return temporalDivElement.textContent || temporalDivElement.innerText || "";
	}

  function modificaPacco(attivita_json){
	  
	  new_items_json=[];

	  items_json = new_items_json;

	  
	  var tabella = $('#tabItems').DataTable();
	   var data = tabella
	     .rows()
	     .data();
	   
	   if($('#tabItems tbody tr').find("td").eq(1).html()!=null){
			  for(var i =0;i<data.length;i++) {
				  item={};
				    item.id_proprio = stripHtml(data[i][0]);    
				    item.tipo = data[i][1];   
				    item.denominazione = data[i][3];
				    item.stato = data[i][2];
				    item.quantita =data[i][4];
				   var attivita = data[i][5];
				    if(item.tipo=="Strumento"){
				    	item.attivita = '<select id="attivita_item_'+item.id_proprio+'" name="attivita_item_'+item.id_proprio+'" class="form-control select2" style="width:100%"  aria-hidden="true" data-live-search="true">'
				    	item.attivita =	item.attivita + '<option value="">Nessuna</option>';
							attivita_json.forEach(function(att){
								if(att.descrizione!=attivita){
									item.attivita =	item.attivita + '<option value="'+att.id+'">'+att.descrizione+'</option>';
								}else{
									item.attivita =	item.attivita + '<option value="'+att.id+'" selected>'+att.descrizione+'</option>';
								}
							});
				    	//item.attivita = '<input type="text" id="attivita_item_'+item.id_proprio+'" name="attivita_item_'+item.id_proprio+'" value="'+$(this).find("td").eq(5).text()+'" style="width:100%">';
					    item.destinazione = '<input type="text" id="destinazione_item_'+item.id_proprio+'" name="destinazione_item_'+item.id_proprio+'" value="'+data[i][6]+'" style="width:100%">';

			    	   	if(data[i][7]!=""){
			    	   		item.priorita = '<input type="checkbox" id="priorita_item_'+item.id_proprio+'" name="priorita_item_'+item.id_proprio+'" checked>';		    
			    	   	}else{
			    	   		item.priorita = '<input type="checkbox" id="priorita_item_'+item.id_proprio+'" name="priorita_item_'+item.id_proprio+'">';
			    	   	}
			    	    item.matricola = data[i][10];
			    	    item.codice_interno = data[i][11];
				    }else{
				    	item.priorita = "";
				    	item.attivita = "";
				    	item.destinazione = "";
				    }
				    	item.note= '<input type="text" id="note_item_'+item.id_proprio+'" name="note_item_'+item.id_proprio+'" value="'+data[i][8]+'" style="width:100%">';
				    	item.action ='<button class="btn btn-danger" onClick="eliminaEntryItem(\''+item.id_proprio+'\', \''+item.tipo+'\')"><i class="fa fa-trash"></i></button>';
				    	item.id = data[i][12];
				    	items_json.push(item);		    
				 }
			  }
	  
	   
	  var table = $('#tabItem').DataTable();		
	  table.clear().draw();
	  table.rows.add(items_json).draw();
//	  table.rows.add(items_json).draw();
//	  var x = items_json[0].note;
//	  var y = $('#note_item_25431').val();
//	  table.columns().eq( 0 ).each( function ( colIdx ) {
//	  	  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
//	  	      table
//	  	          .column( colIdx )
//	  	          .search( this.value )
//	  	          .draw();
//	  	  } );
//	  	} ); 
//	  table.columns.adjust().draw();
	 
	  items_json.forEach(function(item){
		  
		  $('#attivita_item_'+item.id_proprio).select2();
	  });

	  $("#myModalModificaPacco").modal();
	 
  }
  

  function scaricaSchedaConsegna(idIntervento){
	  callAction("scaricaSchedaConsegna.do?idIntervento="+idIntervento,"#scaricaSchedaConsegnaForm",false);
	  $("#myModalDownloadSchedaConsegna").modal('hide');
  }
  function scaricaListaCampioni(idIntervento){
	  callAction("scaricaListaCampioni.do?idIntervento="+idIntervento,false,false);
  }
  function scaricaSchedaTecnica(idDotazione,nomeFile){
	  callAction("gestioneDotazioni.do?action=scaricaSchedaTecnica&idDotazione="+idDotazione+"&nomeFile="+nomeFile,false,false);
  }
  function showSchedeConsegna(idIntervento){
	  callAction("showSchedeConsegna.do?idIntervento="+idIntervento,false, false);
  }
  
  function scaricaSchedaConsegnaFile(idIntervento, nomefile){
	  callAction("scaricaSchedaConsegnaFile.do?idIntervento="+idIntervento+"&nomefile="+nomefile,false,false);
  }
  function inserisciNuovoPacco(){
	  callAction("gestionePacco.do", "#NuovoPaccoForm", false);
	  $("#myModalCreaNuovoPacco").modal('hide');
  }
  

  
  
  function creaDDTFile(numero_ddt, id_pacco, id_cliente, id_sede, id_ddt){

	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  var dataObj = {};
		dataObj.id_pacco = id_pacco;
		dataObj.numero_ddt = numero_ddt;
		dataObj.id_cliente = id_cliente;
		dataObj.id_sede = id_sede;
		dataObj.id_ddt = id_ddt;

          $.ajax({
        	  type: "POST",
        	  url: "gestioneDDT.do?action=crea_ddt",
        	  data: dataObj,
        	  dataType: "json",

        	  success: function( data, textStatus) {
        		  pleaseWaitDiv.modal('hide');
        		  if(data.success)
        		  { 

        			$('#report_button').hide();
  	  			$('#visualizza_report').hide();
        				  $('#myModalError').removeClass();
        				  $('#myModalErrorContent').html(data.messaggio);
        				 
        	        	  $('#myModalError').addClass("modal modal-success");
	          			 $("#myModalError").modal();


        		  }else{
        			$('#myModalError').removeClass();
        			 $("#myModalErrorContent").html(data.messaggio);
        			$('#myModalError').addClass("modal modal-danger");
        			$('#report_button').show();
  	  			$('#visualizza_report').show();
					$('#myModalError').modal('show');
				
        		  }
        	  },

        	  error: function(jqXHR, textStatus, errorThrown){
        		  pleaseWaitDiv.modal('hide');
        		$("#myModalErrorContent").html(textStatus);
        		$('#myModalError').addClass("modal modal-danger");
        		$('#report_button').show();
	  			$('#visualizza_report').show();			
				$('#myModalError').modal('show');
				
        
        	  }
          });




  }
  
  
  function dettaglioCommessa(id_commessa){

	  dataString = "action=dettaglio_commessa&id_commessa="+id_commessa;
	 // callAction("gestionePacco.do?"+dataString);
	  exploreModal("gestionePacco.do",dataString,"#commessa_body",function(datab,textStatusb){
	  
		 
		if(datab=='{"messaggio":"Errore"}'){
			
			$('#myModalLabel').html("Attenzione!")
			$('#myModalErrorContent').html("Non esiste una commessa con questo ID!");
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#myModalError').modal('show');
			
		}else{
	        
			$('#myModalCommessa').modal();
						
		}

          });
	  
  }
  

  
  function testaPacco(id_pacco){

	  pleaseWaitDiv.modal();
	  var dataObj = {};
		dataObj.id_pacco = id_pacco;
		

          $.ajax({
        	  type: "POST",
        	  url: "gestionePacco.do?action=testa_pacco",
        	  data: dataObj,
        	  dataType: "json",

        	  success: function( data, textStatus) {
        	
        		  if(data.success)
        		  { 
        			  pleaseWaitDiv.modal('hide');
        			$('#report_button').hide();
  	  				$('#visualizza_report').hide();
        				  $('#myModalError').removeClass();
        				  $('#myModalErrorContent').html(data.messaggio);
        				 
        	        	  $('#myModalError').addClass("modal modal-success");
	          			 $("#myModalError").modal();


        		  }else{
        			  
        			  pleaseWaitDiv.modal('hide');
        			$('#myModalError').removeClass();
        			 $("#myModalErrorContent").html(data.messaggio);
        			$('#myModalError').addClass("modal modal-danger");
        			$('#report_button').show();
  	  			$('#visualizza_report').show();
					$('#myModalError').modal('show');
				
        		  }
        	  },

        	  error: function(jqXHR, textStatus, errorThrown){
        		  pleaseWaitDiv.modal('hide');
        		$("#myModalErrorContent").html(textStatus);
        		$('#myModalError').addClass("modal modal-danger");
        		$('#report_button').show();
	  			$('#visualizza_report').show();			
				$('#myModalError').modal('show');
				
        
        	  }
          });




  }
  
  
  function generaPaccoUscita(id_pacco, codice){
	  pleaseWaitDiv.modal();
	  dataString = "?action=pacco_uscita&id_pacco="+id_pacco+"&codice="+codice;
	  
//	  exploreModal("gestionePacco.do",dataString,false,function(datab,textStatusb){
	  callAction("gestionePacco.do"+dataString, false, false);
	  //pleaseWaitDiv.modal('hide');
  //});
	  
	  
  }
  
  
  
function cambiaNotaPacco(id_pacco, nota){
	  
	  var dataObj = {};
		dataObj.id_pacco = id_pacco;
		dataObj.nota = nota;
          $.ajax({
        	  type: "POST",
        	  url: "gestionePacco.do?action=cambia_nota_pacco",
        	  data: dataObj,
        	  dataType: "json",

        	  success: function( data, textStatus) {
        	
        		  if(data.success)
        		  { 

        			$('#report_button').hide();
  	  			$('#visualizza_report').hide();
        				  $('#myModalError').removeClass();        				  
        				  $('#myModalErrorContent').html(data.messaggio);        				
        				 $('#myModalErrorContent').html(data.date);
        	        	  $('#myModalError').addClass("modal modal-success");
	          			 $("#myModalError").modal();
	          			 
	         			$('#myModalError').on('hidden.bs.modal', function(){
	         				 pleaseWaitDiv = $('#pleaseWaitDialog');
	       				  pleaseWaitDiv.modal();
	       				  location.reload();
	       				  //callAction("listaPacchi.do");
	        			});
	          			 

        		  }else{
        			$('#myModalError').removeClass();
        			 $("#myModalErrorContent").html(data.messaggio);
        			$('#myModalError').addClass("modal modal-danger");
        			$('#report_button').show();
  	  			$('#visualizza_report').show();
					$('#myModalError').modal('show');
				
        		  }
        	  },

        	  error: function(jqXHR, textStatus, errorThrown){

        		$("#myModalErrorContent").html(textStatus);
        		$('#myModalError').addClass("modal modal-danger");
        		$('#report_button').show();
	  			$('#visualizza_report').show();			
				$('#myModalError').modal('show');				
        
        	  }
          });
  }
  
  
  function paccoSpedito(id_pacco){
	  
	//var  dataString = "?action=spedito&id_pacco="+id_pacco;
	 // callAction("gestionePacco.do"+dataString, false, false);
	  
  
	  		  var dataObj = {};
	  		dataObj.id_pacco = id_pacco;

	            $.ajax({
	          	  type: "POST",
	          	  url: "gestionePacco.do?action=spedito",
	          	  data: dataObj,
	          	  dataType: "json",

	          	  success: function( data, textStatus) {
	          	
	          		  if(data.success)
	          		  { 
 
	          			$('#report_button').hide();
	    	  			$('#visualizza_report').hide();
	          				  $('#myModalError').removeClass();
	          				  $('#myModalErrorContent').html(data.date);
	          				  $('#myModalLabel').html(data.messaggio);
	          	        	  $('#myModalError').addClass("modal modal-success");
		          			 $("#myModalError").modal();
		          			 
		         			$('#myModalError').on('hidden.bs.modal', function(){
		         				 pleaseWaitDiv = $('#pleaseWaitDialog');
		       				  pleaseWaitDiv.modal();
		       				callAction("listaPacchi.do");
		        			});
		          			 
 
	          		  }else{
	          			$('#myModalError').removeClass();
	          			 $("#myModalErrorContent").html(data.messaggio);
	          			$('#myModalError').addClass("modal modal-danger");
	          			$('#report_button').show();
	    	  			$('#visualizza_report').show();
						$('#myModalError').modal('show');
					
	          		  }
	          	  },

	          	  error: function(jqXHR, textStatus, errorThrown){

	          		$("#myModalErrorContent").html(textStatus);
	          		$('#myModalError').addClass("modal modal-danger");
	          		$('#report_button').show();
    	  			$('#visualizza_report').show();			
					$('#myModalError').modal('show');
					
	          
	          	  }
	            });
	  
	  
  }
  
  
  function chiudiPacchiOrigine(origine){
	  
	  var dataObj = {};
		dataObj.origine = origine;


          $.ajax({
        	  type: "POST",
        	  url: "gestionePacco.do?action=chiudi_origine",
        	  data: dataObj,
        	  dataType: "json",

        	  success: function( data, textStatus) {
        	
        		  if(data.success)
        		  { 

        			$('#report_button').hide();
  	  			$('#visualizza_report').hide();
        				  $('#myModalError').removeClass();
        				  $('#myModalErrorContent').html(data.messaggio);
        				  $('#myModalError').addClass("modal modal-success");
	          			 $("#myModalError").modal();
	          			 
	          			$('#myModalError').on('hidden.bs.modal', function(){
	         				 pleaseWaitDiv = $('#pleaseWaitDialog');
	       				  pleaseWaitDiv.modal();
	       				callAction("listaPacchi.do");
	        			});

        		  }else{
        			$('#myModalError').removeClass();
        			 $("#myModalErrorContent").html(data.messaggio);
        			$('#myModalError').addClass("modal modal-danger");
        				$('#report_button').show();
  	  					$('#visualizza_report').show();
        			
					$('#myModalError').modal('show');
				
        		  }
        	  },

        	  error: function(jqXHR, textStatus, errorThrown){

        		$("#myModalErrorContent").html(textStatus);
        		$('#myModalError').addClass("modal modal-danger");
        		$('#report_button').show();
	  			$('#visualizza_report').show();			
				$('#myModalError').modal('show');
				
        
        	  }
          });

  }
  
  function paccoSpeditoFornitore(id_pacco, fornitore, codice){

		  		  var dataObj = {};
		  		dataObj.id_pacco = id_pacco;
		  		dataObj.fornitore = fornitore;
		  		dataObj.codice = codice;
		  		
		            $.ajax({
		          	  type: "POST",
		          	  url: "gestionePacco.do?action=spedito_fornitore",
		          	  data: dataObj,
		          	  dataType: "json",

		          	  success: function( data, textStatus) {
		          	
		          		  if(data.success)
		          		  { 
		          			$('#report_button').hide();
		    	  			$('#visualizza_report').hide();
		          				  $('#myModalError').removeClass();
		          				  $('#myModalErrorContent').html(data.date);
		          				  $('#myModalLabel').html(data.messaggio);
		          	        	  $('#myModalError').addClass("modal modal-success");
			          			 $("#myModalError").modal();
			          			 
			         			$('#myModalError').on('hidden.bs.modal', function(){
			         				 pleaseWaitDiv = $('#pleaseWaitDialog');
			       				  pleaseWaitDiv.modal();
			       				callAction("listaPacchi.do");
			        			});
			          			 
	 
		          		  }else{
		          			$('#myModalError').removeClass();
		          			 $("#myModalErrorContent").html(data.messaggio);
		          			$('#myModalError').addClass("modal modal-danger");
		          			$('#report_button').show();
		    	  			$('#visualizza_report').show();
		          			 $("#myModalError").modal();
		          		  }
		          	  },

		          	  error: function(jqXHR, textStatus, errorThrown){

		          		$("#myModalErrorContent").html(textStatus);
		          		$('#myModalError').addClass("modal modal-danger");
		          		$('#report_button').show();
	    	  			$('#visualizza_report').show();
						$('#myModalError').modal('show');
						
		          
		          	  }
		            });

	  }

  
  
  function dettaglioPacco(id_pacco){
	  
	  dataString = "?action=dettaglio&id_pacco="+id_pacco;
	  
	  callAction("gestionePacco.do"+dataString, false, false);
	  

  }
  
  function inserisciItemModal(tipo_item,id_cliente, id_sede){
	  

	   dataString = "tipo_item="+tipo_item+"&id_cliente="+id_cliente+"&id_sede="+id_sede;
	  exploreModal("listaItem.do",dataString,"#listaItem",function(datab,textStatusb){

          });
	  $("#myModalItem").modal('show');
	

  }
  

  function nuovoGenerico(){


	  var categoria=$('#categoria').val();
	  var descrizione=$('#descrizione').val();
	  var quantita=$('#quantita').val();
	  
	  		  var dataObj = {};
	  		dataObj.categoria = categoria;
	  		dataObj.descrizione = descrizione;
	  		dataObj.quantita = quantita;

	            $.ajax({
	          	  type: "POST",
	          	  url: "listaItem.do?action=new",
	          	  data: dataObj,
	          	  dataType: "json",

	          	  success: function( data, textStatus) {
	          	
	          		  if(data.success)
	          		  { 
	          			
	          			 $('#modalNuovoGenerico').modal('hide');
	          			  dataString = "tipo_item="+"3";
	          			  exploreModal("listaItem.do",dataString,"#listaItem",function(datab,textStatusb){
	          				  
	          				$('#report_button').hide();
		    	  			$('#visualizza_report').hide();		
	          				  $('#myModalError').removeClass();
	          				  $('#myModalErrorContent').html(data.messaggio);
	          	        	  $('#myModalError').addClass("modal modal-success");
		          			 $("#myModalError").modal();
		          			 
		          			
	          	          });
	          		  }else{
	          			$('#myModalError').removeClass();
	          			 $("#myModalErrorContent").html(data.messaggio);
	          			$('#myModalError').addClass("modal modal-danger");
	          			$('#report_button').show();
	    	  			$('#visualizza_report').show();		
	          			 $("#myModalError").modal();
	          		  }
	          	  },

	          	  error: function(jqXHR, textStatus, errorThrown){

	          		$("#myModalErrorContent").html(textStatus);
	          		$('#myModalError').addClass("modal modal-danger");
	          		$('#report_button').show();
    	  			$('#visualizza_report').show();		
					$('#myModalError').modal('show');
					
	          
	          	  }
	            });
	  	  	
  }
  
  
  function insertEntryItem (id, denominazione, tipo, id_stato, note, priorita, attivita, destinazione, codice_interno, matricola, attivita_json) {
	  
	 $('#listaItemTop').html('');
	  
		esiste=false;
		
  		items_json.forEach( function (item){
  			if(item.id_proprio==id && item.tipo == tipo){
  				if(item.tipo!="Strumento"){
  					item.quantita++;
  				
  					esiste=true;
  					$('#listaItemTop').html( "<font size=\"4\" color=\"red\">Aggiunto " + item.quantita +' '+ denominazione +' con ID '+ id+"</font>");

  					item.note = '<input type="text" id="note_item_'+id+'" name="note_item_'+id+'" value="'+note+'">';
  					if(attivita!=undefined){
  						//item.attivita = '<input type="text" id="attivita_item_'+id+'" name="attivita_item_'+id+'" value="'+attivita+'">';
  						item.attivita = '';
  					}
  					if(destinazione!=undefined){
  						item.destinazione = '<input type="text" id="destinazione_item_'+id+'" name="destinazione_item_'+id+'" value="'+destinazione+'">';
  					}
  		  			if(priorita!=null){
  		  				if(priorita=="1"){	  		  			
  		  					item.priorita = '<input type="checkbox" id="priorita_item_'+id+'" name="priorita_item_'+id+'" checked>'
  		  				}else{
  		  					item.priorita = '<input type="checkbox" id="priorita_item_'+id+'" name="priorita_item_'+id+'">'
  		  				}  			
  		  			}else{
  		  				item.priorita = "";
  		  			}
  				}else{
  						$('#listaItemTop').html( "<font size=\"4\" color=\"red\">Attenzione! Impossibile aggiungere pi&ugrave; volte lo stesso strumento!</font>");
  						esiste=true;
  						item.note = '<input type="text" id="note_item_'+id+'" name="note_item_'+id+'" value="'+note+'">';
  						if(attivita!=undefined){
  							//item.attivita = '<input type="text" id="attivita_item_'+id+'" name="attivita_item_'+id+'" value="'+attivita+'">';
  							item.attivita = '<select id="attivita_item_'+id+'" name="attivita_item_'+id+'" class="form-control select2" style="width:100%"  aria-hidden="true" data-live-search="true">'
  							item.attivita =	item.attivita + '<option value="">Nessuna</option>';
	  						attivita_json.forEach(function(att){
	  							if(att.id!=attivita){
	  								item.attivita =	item.attivita + '<option value="'+att.id+'">'+att.descrizione+'</option>';
	  							}else{
	  								item.attivita =	item.attivita + '<option value="'+att.id+'" selected>'+att.descrizione+'</option>';
	  							}
	  						});
  						}
  						if(destinazione!=undefined){
  							item.destinazione = '<input type="text" id="destinazione_item_'+id+'" name="destinazione_item_'+id+'" value="'+destinazione+'">';
  						}
  			  			if(priorita!=null){
  			  				if(priorita=="1"){	  			  			
  			  					item.priorita = '<input type="checkbox" id="priorita_item_'+id+'" name="priorita_item_'+id+'" checked>'
  			  				}else{
  			  					item.priorita = '<input type="checkbox" id="priorita_item_'+id+'" name="priorita_item_'+id+'">'
  			  				}  			
  			  			}else{
  			  				item.priorita = "";
  			  			}
  				}
  			}
  			
  		});
  		
  		if(!esiste){
  			accessorio={};
  			
  			accessorio.id_proprio=id;
  			accessorio.tipo = tipo;  			
  			accessorio.denominazione=denominazione;
  			accessorio.quantita=1;
  			if(priorita!=null){
  				if(priorita=="1"){	
  			
  					accessorio.priorita = '<input type="checkbox" id="priorita_item_'+id+'" name="priorita_item_'+id+'" checked>'
  				}else{
  					accessorio.priorita = '<input type="checkbox" id="priorita_item_'+id+'" name="priorita_item_'+id+'">'
  				}  			
  			}else{
  				accessorio.priorita = "";
  			}
  			var stato=null;
  			
  			if(id_stato==1){
  				var stato = "In lavorazione";
  			}
  			else if(id_stato==2){
  				var stato = "Lavorato";
  			}
  			else if(id_stato=3){
  				var stato = "Generico";
  			}
  			if(tipo=="Strumento"){
  				
  				accessorio.codice_interno = codice_interno;
  				accessorio.matricola = matricola;
  				
  			}
  			accessorio.stato = stato;
  		 	accessorio.note = '<input type="text" id="note_item_'+id+'" name="note_item_'+id+'" value="'+note+'">';
				if(attivita!=undefined){
	  					//accessorio.attivita = '<input type="text" id="attivita_item_'+id+'" name="attivita_item_'+id+'" value="'+attivita+'">';
	  					accessorio.attivita = '<select id="attivita_item_'+id+'" name="attivita_item_'+id+'" class="select2 form-control" style="width:100%"  aria-hidden="true" data-live-search="true">'
	  					accessorio.attivita =	accessorio.attivita + '<option value="">Nessuna</option>';	
	  					attivita_json.forEach(function(att){
	  							if(att.id!=attivita){
	  								accessorio.attivita =	accessorio.attivita + '<option value="'+att.id+'">'+att.descrizione+'</option>';
	  							}else{
	  								accessorio.attivita =	accessorio.attivita + '<option value="'+att.id+'" selected>'+att.descrizione+'</option>';
	  							}
	  						});
	  					
	  				}else{
	  					accessorio.attivita="";
	  				}
	  				if(destinazione!=undefined){
	  					accessorio.destinazione = '<input type="text" id="destinazione_item_'+id+'" name="destinazione_item_'+id+'" value="'+destinazione+'">';
	  				}else{
	  					accessorio.destinazione="";
	  				}
  			accessorio.action= '<button class="btn btn-danger" onClick="eliminaEntryItem(\''+id+'\', \''+tipo+'\')"><i class="fa fa-trash"></i></button>';
  		
  			items_json.push(accessorio);
  			
  			$('#listaItemTop').html( "<font size=\"4\" color=\"red\">Aggiunto " + accessorio.quantita + ' '+denominazione+' con ID '+ id+"</font><br>");
  			$('#attivita_item_'+id).select2();
  		}
  		
  		

	   var table = $('#tabItem').DataTable();
	  
	   table.clear().draw();
	   
		table.rows.add(items_json).draw();
	    
	    table.columns().eq( 0 ).each( function ( colIdx ) {
	  	  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
	  	      table
	  	          .column( colIdx )
	  	          .search( this.value )
	  	          .draw();
	  	  } );
	  	} ); 
	  		table.columns.adjust().draw();

	  	  items_json.forEach(function(item){
			  $('attivita_item_'+item.id_proprio).select2();
		  });
	}
  
function eliminaEntryItem(id, tipo){
	
	new_items_json=[];
	
	items_json.forEach( function (item){
			if(item.id_proprio && item.id_proprio==id && item.tipo == tipo){
				
			}else{
				new_items_json.push(item);
			}
			
		});
		

	items_json = new_items_json;
	
   var table = $('#tabItem').DataTable();
	
   table.clear().draw();
   
	table.rows.add(items_json).draw();
    
    table.columns().eq( 0 ).each( function ( colIdx ) {
  	  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
  	      table
  	          .column( colIdx )
  	          .search( this.value )
  	          .draw();
  	  } );
  	} ); 
  		table.columns.adjust().draw();
	
	
}
  

function cambiaStatoItem(id, stato){
	 
	
	 var dataObj = {};
	 dataObj.id=id;
	 dataObj.stato_attuale=stato;
	 
 $.ajax({
	  type: "POST",
	  url: "gestionePacco.do?action=cambio_stato_strumento",
	  data: dataObj,
	  dataType: "json",
	  success: function( data, textStatus) {
		  

		  if(data.success)
		  { 
		
			  $('#report_button').hide();
	  			$('#visualizza_report').hide();		
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-success");
				$('#myModalError').modal('show');
				$('#myModalError').on("hidden.bs.modal",function(){
					location.reload();
				});
	
			
			
		  }else{
			  
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
	  			$('#visualizza_report').show();		
				$('#myModalError').modal('show');
			 
		  }
	  },

	  error: function(jqXHR, textStatus, errorThrown){
		  
		  $('#myModalErrorContent').html(textStatus);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
  			$('#visualizza_report').show();		
			$('#myModalError').modal('show');
			
	  }
	  
	
 });

 
 
 
}

function showNoteCommessa(id){
	 
	 var dataObj = {};
	 dataObj.id=id;

  $.ajax({
	  type: "POST",
	  url: "gestionePacco.do?action=note_commessa",
	  data: dataObj,
	  dataType: "json",
	  success: function( data, textStatus) {
		  

		  if(data.success)
		  { 
			value = JSON.parse(data.json);
			
			  $('#note_commessa').val(value.NOTE_GEN);
			
		  }else{
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
	  			$('#visualizza_report').show();		
				$('#myModalError').modal('show');
			 
		  }
	  },

	  error: function(jqXHR, textStatus, errorThrown){
		  pleaseWaitDiv.modal('hide');

		  $('#myModalErrorContent').html(textStatus);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
  			$('#visualizza_report').show();		
			$('#myModalError').modal('show');
			
	  }
  });

  
  
  
}

  

  function eliminaSchedaConsegna(id){
		 
		$("#modalEliminaCompany").modal("hide");

		  pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
		  var dataObj = {};
		 dataObj.id=id;

	  $.ajax({
		  type: "POST",
		  url: "eliminaSchedaConsegna.do",
		  data: "id_scheda="+id,
		  dataType: "json",
		  success: function( data, textStatus) {
			  
			  pleaseWaitDiv.modal('hide');
			  
			  if(data.success)
			  { 
				
				 
				  //$('#myModalErrorContent').html(data.messaggio);
				  	//$('#myModalError').removeClass();
					//$('#myModalError').addClass("modal modal-success");
					//$('#myModalError').modal('show');
					location.reload();
			
			  }else{
				  $('#myModalErrorContent').html(data.messaggio);
				  	$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					$('#report_button').show();
    	  			$('#visualizza_report').show();		
					$('#myModalError').modal('show');
				 
			  }
		  },

		  error: function(jqXHR, textStatus, errorThrown){
			  pleaseWaitDiv.modal('hide');

			  $('#myModalErrorContent').html(textStatus);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
	  			$('#visualizza_report').show();		
				$('#myModalError').modal('show');
				
		  }
	  });

	  
	  
	  
	}

  
  
function nuovoTrend(){
  	  
  	  if($("#formNuovoTrend").valid()){
  		  pleaseWaitDiv = $('#pleaseWaitDialog');
  		  pleaseWaitDiv.modal();

  	  
  	  var val=$('#val').val();
  	  var data=$('#data').val();
  	  var tipoTrend=$('#tipoTrend').val();
  	  var assex=$('#assex').val();
  	 var company=$('#selectCompany').val();

  	  var dataObj = {};
  		
  	  dataObj.val = val;
  	  dataObj.data = data;
  	  dataObj.tipoTrend = tipoTrend;
  	  dataObj.assex = assex;
  	  dataObj.company = company;

            $.ajax({
          	  type: "POST",
          	  url: "gestioneTrend.do?action=nuovo",
          	  data: dataObj,
          	  dataType: "json",
          	  success: function( data, textStatus) {
          		  
          		  pleaseWaitDiv.modal('hide');
          		  
          		  if(data.success)
          		  { 
          			 
          			$('#report_button').hide();
    	  			$('#visualizza_report').hide();		
          			  $("#modalNuovoTrend").modal("hide");
          			  $('#myModalErrorContent').html(data.messaggio);
          			  	$('#myModalError').removeClass();
          				$('#myModalError').addClass("modal modal-success");
          				$('#myModalError').modal('show');
          				
          		
          		  }else{
          			  $('#myModalErrorContent').html(data.messaggio);
          			  	$('#myModalError').removeClass();
          				$('#myModalError').addClass("modal modal-danger");
          				$('#report_button').show();
	    	  			$('#visualizza_report').show();		
          				$('#myModalError').modal('show');
          			 
          		  }
          	  },

          	  error: function(jqXHR, textStatus, errorThrown){
          		  pleaseWaitDiv.modal('hide');

          		  $('#myModalErrorContent').html(textStatus);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				$('#report_button').show();
    	  			$('#visualizza_report').show();		
    				$('#myModalError').modal('show');
    				
          	  }
            });
  	  }
    }

function nuovoTipoTrend(){
	  
	  if($("#formNuovoTipoTrend").valid()){
		  pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();

	  
	  var descrizione=$('#descrizione').val();
 	  var tipoGrafico=$('#tipoGrafico').val();


	  var dataObj = {};
		
	  dataObj.descrizione = descrizione;
	  dataObj.tipoGrafico = tipoGrafico;


          $.ajax({
        	  type: "POST",
        	  url: "gestioneTrend.do?action=nuovoTipoTrend",
        	  data: dataObj,
        	  dataType: "json",
        	  success: function( data, textStatus) {
        		  
        		  pleaseWaitDiv.modal('hide');
        		  
        		  if(data.success)
        		  { 
        			 
        			  $('#report_button').hide();
	    	  			$('#visualizza_report').hide();		
        			  $("#modalNuovoTipoTrend").modal("hide");
        			  $('#myModalErrorContent').html(data.messaggio);
        			  	$('#myModalError').removeClass();
        				$('#myModalError').addClass("modal modal-success");
        				$('#myModalError').modal('show');
        				
        		
        		  }else{
        			  $('#myModalErrorContent').html(data.messaggio);
        			  	$('#myModalError').removeClass();
        				$('#myModalError').addClass("modal modal-danger");
        				$('#report_button').show();
	    	  			$('#visualizza_report').show();		
        				$('#myModalError').modal('show');
        			 
        		  }
        	  },

        	  error: function(jqXHR, textStatus, errorThrown){
        		  pleaseWaitDiv.modal('hide');

        		  $('#myModalErrorContent').html(textStatus);
  			  	$('#myModalError').removeClass();
  				$('#myModalError').addClass("modal modal-danger");
  				$('#report_button').show();
	  			$('#visualizza_report').show();		
				$('#myModalError').modal('show');
				
        
        	  }
          });
	  }
  }
  
function modalEliminaTrend(id){
	  
	  $('#idElimina').val(id);
	  $('#modalEliminaTrend').modal();
	  
}
function modificaTipoTrend(){
	  
	  if($("#formModificaTipoTrend").valid()){
		  pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();

	  var id=$('#idtipotrend').val(); 
	  var descrizione=$('#descrizionemod').val();
	  var tipoGrafico=$('#tipoGraficomod').val();
	  var attivo=$('#attivomod').val();

	  var dataObj = {};
	  dataObj.id = id;
	  dataObj.descrizione = descrizione;
	  dataObj.tipoGrafico = tipoGrafico;
	  if(attivo == "true"){
		  dataObj.attivo = 1;
	  }else{
		  dataObj.attivo = 0;
	  }

        $.ajax({
      	  type: "POST",
      	  url: "gestioneTrend.do?action=modificaTipoTrend",
      	  data: dataObj,
      	  dataType: "json",
      	  success: function( data, textStatus) {
      		  
      		  pleaseWaitDiv.modal('hide');
      		  
      		  if(data.success)
      		  { 
      			 
      			$('#report_button').hide();
	  			$('#visualizza_report').hide();		
      			  $("#modalModificaTipoTrend").modal("hide");
      			  $('#myModalErrorContent').html(data.messaggio);
      			  	$('#myModalError').removeClass();
      				$('#myModalError').addClass("modal modal-success");
      				$('#myModalError').modal('show');
      				
      		
      		  }else{
      			  $('#myModalErrorContent').html(data.messaggio);
      			  	$('#myModalError').removeClass();
      				$('#myModalError').addClass("modal modal-danger");
      				$('#report_button').show();
    	  			$('#visualizza_report').show();		
      				$('#myModalError').modal('show');
      			 
      		  }
      	  },

      	  error: function(jqXHR, textStatus, errorThrown){
      		  pleaseWaitDiv.modal('hide');

      		  $('#myModalErrorContent').html(textStatus);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
	  			$('#visualizza_report').show();		
				$('#myModalError').modal('show');
				
      	  }
        });
	  }
}
function eliminaTrend(){
	  
	  $("#modalEliminaTrend").modal("hide");

	pleaseWaitDiv = $('#pleaseWaitDialog');
	pleaseWaitDiv.modal();
	
	var id=$('#idElimina').val();
	var dataObj = {};
	dataObj.id = id;
	
	
	$.ajax({
		type: "POST",
		url: "gestioneTrend.do?action=elimina",
		data: dataObj,
		dataType: "json",
		success: function( data, textStatus) {
		
		pleaseWaitDiv.modal('hide');
		
			if(data.success)
			{ 
				$('#report_button').hide();
	  			$('#visualizza_report').hide();		
				 
				  $('#myModalErrorContent').html(data.messaggio);
				  	$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-success");
					$('#myModalError').modal('show');
					
			
			}else{
				  $('#myModalErrorContent').html(data.messaggio);
				  	$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					$('#report_button').show();
    	  			$('#visualizza_report').show();		
					$('#myModalError').modal('show');
				 
			}
		},
		
		error: function(jqXHR, textStatus, errorThrown){
			pleaseWaitDiv.modal('hide');
		
			$('#myModalErrorContent').html(textStatus);
				$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
	  			$('#visualizza_report').show();		
				$('#myModalError').modal('show');
							
			}		
	});
	  
}

function toggleTipoTrend(button,idTipoTrend){
	  
	  $("#modalDisattivoTipoTrend").modal("hide");

	pleaseWaitDiv = $('#pleaseWaitDialog');
	pleaseWaitDiv.modal();
	
 	var dataObj = {};
	dataObj.id = idTipoTrend;
	
	
	$.ajax({
		type: "POST",
		url: "gestioneTrend.do?action=toggleTipoTrend",
		data: dataObj,
		dataType: "json",
		success: function( data, textStatus) {
		
		pleaseWaitDiv.modal('hide');
		
			if(data.success)
			{ 
				
				$('#report_button').hide();
	  			$('#visualizza_report').hide();		
				  $('#myModalErrorContent').html(data.messaggio);
				  	$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-success");
					$('#myModalError').modal('show');
					
			
			}else{
				  $('#myModalErrorContent').html(data.messaggio);
				  	$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					$('#report_button').show();
    	  			$('#visualizza_report').show();		
					$('#myModalError').modal('show');
				 
			}
		},
		
		error: function(jqXHR, textStatus, errorThrown){
			pleaseWaitDiv.modal('hide');
		
			$('#myModalErrorContent').html(textStatus);
				$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
	  			$('#visualizza_report').show();		
				$('#myModalError').modal('show');
				
			
			}		
	});
	  
}
function modalModificaTipoTrend(id,descrizione,tipo_grafico,attivo){
	$('#idtipotrend').val(id);
	$('#descrizionemod').val(descrizione);
	$('#tipoGraficomod').val(tipo_grafico);
	$('#attivomod').attr("value",attivo);
	if(attivo){
		$('#attivomod').iCheck("check");
	}else{
		$('#attivomod').iCheck("uncheck");
	}
	  $('#modalModificaTipoTrend').modal();
}
function modalEliminaDocumentoEsternoStrumento(id){
	  
	  $('#idElimina').val(id);
	  $('#modalEliminaDocumentoEsternoStrumento').modal();
	  
}

function eliminaDocumentoEsternoStrumento(){
			  
			  $("#modalEliminaDocumentoEsternoStrumento").modal("hide");

	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();

	  var id=$('#idElimina').val();
	  var dataObj = {};
	  dataObj.idDoc = id;


$.ajax({
	  type: "POST",
	  url: "scaricaDocumentoEsternoStrumento.do?action=eliminaDocumento",
	  data: dataObj,
	  dataType: "json",
	  success: function( data, textStatus) {
		  
		  pleaseWaitDiv.modal('hide');
		  
		  if(data.success)
		  { 
			
			  $('#report_button').hide();
	  			$('#visualizza_report').hide();		
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-success");
				$('#myModalError').modal('show');
				
		
		  }else{
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
	  			$('#visualizza_report').show();		
				$('#myModalError').modal('show');
			 
		  }
	  },

	  error: function(jqXHR, textStatus, errorThrown){
		  pleaseWaitDiv.modal('hide');

		  $('#myModalErrorContent').html(textStatus);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
  			$('#visualizza_report').show();		
			$('#myModalError').modal('show');
			

	  }
});
			  
}

function filtraCertificati(){
 

	  var cliente=$('#selectCliente').val();
	  var tipologia=$('#selectFiltri').val();
   
	  if(cliente!=null && tipologia != null && tipologia != "" && cliente != ""){
		  	dataString ="cliente="+ cliente
	        exploreModal("listaCertificati.do?action="+tipologia,dataString,"#tabellCertificati",function(datab,textStatusb){
	
	          });

	  }
}








  function assistenza(user,password){
	  
  }
  
   $(function(){
		pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal('hide');  
   });

   
   function inviaMessaggio(){
	   
	   var id_company=$('#select1').val();
	   var destinatario = $('#select2').val();
	   var titolo = $("#titolo").val();
	   if(titolo == ""){
		   titolo = "Nessun Oggetto";
	   }
	   
	   var testo = $("#testo").val();
	   
		  var dataObj = {};
		  dataObj.id_company = id_company;
		  dataObj.destinatario = destinatario;
		  dataObj.titolo = titolo;
		  dataObj.testo = testo;


	$.ajax({
		  type: "POST",
		  url: "gestioneBacheca.do?action=salva",
		  data: dataObj,
		  dataType: "json",
		  success: function( data, textStatus) {
			  
			  pleaseWaitDiv.modal('hide');
			  
			  if(data.success)
			  { 
				  $('#report_button').hide();
				  $('#visualizza_report').hide();
				  $('#myModalErrorContent').html(data.messaggio);
				  	$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-success");
					$('#myModalError').modal('show');
					
			
			  }else{
				  $('#myModalErrorContent').html(data.messaggio);
				  	$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					$('#report_button').show();
					$('#visualizza_report').show();
					$('#myModalError').modal('show');
					
				 
			  }
		  },

		  error: function(jqXHR, textStatus, errorThrown){
			  pleaseWaitDiv.modal('hide');

			  $('#myModalErrorContent').html("Errore nell'invio del messaggio!");
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
				$('#visualizza_report').show();
				$('#myModalError').modal('show');
				


		  }
	});
	   
   }
   
   
   function dettaglioMessaggio(id_messaggio, letto){
	   
	   dataString = "action=dettaglio_messaggio&id_messaggio="+id_messaggio;
		
		  exploreModal("gestioneBacheca.do",dataString,"#messaggio_body",function(datab,textStatusb){
			 
			if(datab=='{"messaggio":"Errore"}'){
				
				$('#myModalErrorContent').html("Errore nella visualizzazione del messaggio!");
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#myModalError').modal('show');

			}else{

				if(letto==0){
		        segnaMessaggioLetto(id_messaggio);
				}
		     
				$('#myModalMessaggio').modal();
							
			}

	          });
	   
   }
   
   function segnaMessaggioLetto(id_messaggio){
	   
		  var dataObj = {};
		dataObj.id_messaggio = id_messaggio;
		
	$.ajax({
		  type: "POST",
		  url: "gestioneBacheca.do?action=letto",
		  data: dataObj,
		  dataType: "json",
		  success: function( data, textStatus) {
			
			  json = JSON.parse(data.json);
			  
			  json_tabs = [];
			  $.each(json, function(i,v) {
				  json_var={};
				
				  if(v.letto_da_me==1){
					  json_var.mittente = v.utente.nominativo;
					  
					  var date = new Date(v.data);
					  var day = (date.getDate()<10?'0':'')+date.getDate();
					  var month = (date.getMonth()<10?'0':'')+(date.getMonth() +1);
					  var year = date.getFullYear();
					  var hour = (date.getHours()<10?'0':'')+date.getHours();
					  var min = (date.getMinutes()<10?'0':'')+date.getMinutes();
					  var sec = (date.getSeconds()<10?'0':'')+date.getSeconds();
					  json_var.data = day+'/'+month+'/'+year+ ' '+ hour +':'+min+':'+sec;
					  json_var.oggetto = '<a href=# class="mailbox-name" onClick="dettaglioMessaggio(\''+v.id+'\',\''+v.letto_da_me+'\')">'+v.titolo+'</a>';
					  
					  json_tabs.push(json_var);
					 
					  
				  }else{

					  json_var.mittente = '<b><span style="color:red">'+v.utente.nominativo+'</span></b>';
					  
					  var date = new Date(v.data);
					  var day =  (date.getDate()<10?'0':'')+date.getDate();
					  var month = (date.getMonth()<10?'0':'')+(date.getMonth() +1);
					  var year = date.getFullYear();
					  var hour = (date.getHours()<10?'0':'')+date.getHours();
					  var min = (date.getMinutes()<10?'0':'')+date.getMinutes();
					  var sec = (date.getSeconds()<10?'0':'')+date.getSeconds();
					  json_var.data =  '<b><span style="color:red">'+day+'/'+month+'/'+year+ ' '+ hour +':'+min+':'+sec+'</span></b>';
					  json_var.oggetto = '<b><a href=# class="mailbox-name" style="color:red" onClick="dettaglioMessaggio(\''+v.id+'\',\''+v.letto_da_me+'\')">'+v.titolo+'</a></b>';
					
					  json_tabs.push(json_var);
					  
				  }
		  });

			  json_tabs.reverse();
			   var table = $('#tabBacheca').DataTable();
			  
			   table.clear().draw();
			   
				table.rows.add(json_tabs).draw();
			    
			    table.columns().eq( 0 ).each( function ( colIdx ) {
			  	  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
			  	      table
			  	          .column( colIdx )
			  	          .search( this.value )
			  	          .draw();
			  	  } );
			  	} ); 

		  },

		  error: function(jqXHR, textStatus, errorThrown){
			  pleaseWaitDiv.modal('hide');

			 
			

		  }
	});
	   
   }
   
   
   function accettazione(accettati, non_accettati, note_acc,note_non_acc, id_pacco){
	   
	   var dataObj = {};
		dataObj.accettati = accettati;
		dataObj.non_accettati = non_accettati;
		dataObj.id_pacco = id_pacco
		dataObj.note_acc = note_acc;
		dataObj.note_non_acc = note_non_acc;
	  $.ajax({
         type: "POST",
         url: "gestionePacco.do?action=accettazione",
         data: dataObj,
         dataType: "json",
         //if received a response from the server
         success: function( data, textStatus) {
       	  //var dataRsp = JSON.parse(dataResp);
        	 pleaseWaitDiv.modal('hide');
    	if(data.success){	 
   		  $('#modalModificaPin').modal('toggle');
   		  $('#report_button').hide();
				$('#visualizza_report').hide();
				$('#myModalErrorContent').html(data.messaggio);

			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-success");
				$('#myModalError').modal('show');
    	}else{	
        	 
        	 $('#myModalErrorContent').html(data.messaggio);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");	  
			$('#report_button').show();
			$('#visualizza_report').show();
			$('#myModalError').modal('show');
			$('#pin').val("");
		
     		  }
         },
         error: function( data, textStatus) {

       	  $('#myModalErrorContent').html(data.messaggio);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");	  
			$('#report_button').show();
				$('#visualizza_report').show();
				$('#myModalError').modal('show');

         }
         });

	   
   }
   
   function eliminaAllegato(id_allegato, id_pacco){
		  
//	   dataString = id_allegato;
//	   exploreModal("gestionePacco.do?action=elimina_allegato", id_allegato, "#tabAllegati", null);
//	 	
//	   
//	   
//   		}

		pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal();
		
		
		var dataObj = {};
		dataObj.id_allegato = id_allegato;
		dataObj.id_pacco = id_pacco;
		
		
		$.ajax({
			type: "POST",
			url: "gestionePacco.do?action=elimina_allegato",
			data: dataObj,
			dataType: "json",
			success: function( data, textStatus) {
			
			pleaseWaitDiv.modal('hide');
			
				if(data.success)
				{ 	
					  json = JSON.parse(data.json);
					  json_tabs = [];
					  if(json.length>0){
						 
					  $.each(json, function(i,v) {
						  json_var={};
						  
							  json_var.allegato = v.allegato;
							  json_var.action = '<a   class="btn btn-primary customTooltip pull-right  btn-xs"  title="Click per scaricare l\'allegato"   onClick="callAction(gestionePacco.do?action=download_allegato&allegato='+v.allegato+'&codice_pacco='+v.pacco.codice_pacco+')"><i class="fa fa-arrow-down"></i></a><a   class="btn btn-danger customTooltip pull-right  btn-xs"  title="Click per eliminare l\'allegato"   onClick="eliminaAllegato(\''+v.id+'\',\''+v.pacco.id+'\')"><i class="fa fa-trash"></i></a>';
							  json_tabs.push(json_var);
					  });
			  }	  
					  var table = $('#tabAllegati').DataTable();		
					  
					   table.clear().draw();
					   
						table.rows.add(json_tabs).draw();
					    
					    table.columns().eq( 0 ).each( function ( colIdx ) {
					  	  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
					  	      table
					  	          .column( colIdx )
					  	          .search( this.value )
					  	          .draw();
					  	  } );
					  	} ); 
					  		table.columns.adjust().draw();
				}
			},
			
			error: function(jqXHR, textStatus, errorThrown){
				pleaseWaitDiv.modal('hide');
			
				$('#myModalErrorContent').html("Errore nell'eliminazione del messaggio!");
					$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					$('#myModalError').modal('show');

				$('#report_button').show();
				$('#visualizza_report').show();
				}		
		});
		  
	}
   

   function sendReport(container){
	   
	   //$(container).modal('hide');
	  // $(container).find('#report_button').remove();
		$.ajax({
			type: "POST",
			url: "inviaReport.do",
		
			dataType: "json",
			success: function( data, textStatus) {
			
			pleaseWaitDiv.modal('hide');
			
				if(data.success)
				{ 	
					$('#report_button').hide();
					$('#visualizza_report').hide();
					$('#myModalErrorContent').html("Report inviato correttamente!");
					$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-success");
					$('#myModalError').modal('show');
				
					  
				}else{
					 $('#myModalErrorContent').html(data.messaggio);
					  	$('#myModalError').removeClass();
						$('#myModalError').addClass("modal modal-danger");
						$('#report_button').show();
						$('#visualizza_report').show();
						$('#myModalError').modal('show');
					
				}
			},
			
			error: function(jqXHR, textStatus, errorThrown){
				pleaseWaitDiv.modal('hide');
			
				$('#myModalErrorContent').html(textStatus);
				$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
				$('#visualizza_report').show();
				$('#myModalError').modal('show');

				
				}		
		});
   }
   function checkMisure(idStr){

 		$.ajax({
			type: "POST",
			url: 'strumentiMisurati.do?action=lmcheck&id='+idStr,
		
			dataType: "json",
			success: function( data, textStatus) {
			
			pleaseWaitDiv.modal('hide');
			
				if(data.success)
				{ 	
					  
					 callAction('strumentiMisurati.do?action=lm&id='+idStr);
				
					  
				}else{
					
					pleaseWaitDiv.modal('hide');
					
					$('#myModalErrorContent').html("Nessuna Misura presente per questo strumento");
					$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-warning");
				
	 				$('#myModalError').modal('show');
				
				}
			},
			
			error: function(jqXHR, textStatus, errorThrown){
				pleaseWaitDiv.modal('hide');
				$('#myModalErrorContent').html("Errore nell'invio del report!");
				$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
				$('#visualizza_report').show();
				$('#myModalError').modal('show');
				
	
				}		
		});
	  
   }
   

   function nuovaManutenzione(index, id_campione){
		 
		  var form = $('#formNuovaManutenzione')[0]; 
		  var formData = new FormData(form);

	          $.ajax({
	        	  type: "POST",
	        	  url: "registroEventi.do?action=manutenzione&index="+index+"&idCamp="+id_campione,
	        	  data: formData,
	        	  //dataType: "json",
	        	  contentType: false, // NEEDED, DON'T OMIT THIS (requires jQuery 1.6+)
	        	  processData: false, // NEEDED, DON'T OMIT THIS
	        	  //enctype: 'multipart/form-data',
	        	  success: function( data, textStatus) {

	        		  if(data.success)
	        		  { 
	        			  $('#report_button').hide();
							$('#visualizza_report').hide();
	        			  $('#myModalErrorContent').html(data.messaggio);
	        			  	$('#myModalError').removeClass();
	        				$('#myModalError').addClass("modal modal-success");
	        				$('#myModalError').modal('show');
	        				

	        		  }else{
	        			  $('#myModalErrorContent').html("Errore nell'inserimento della manutenzione!");
	        			  	$('#myModalError').removeClass();
	        				$('#myModalError').addClass("modal modal-danger");	  
	        				$('#report_button').show();
							$('#visualizza_report').show();
							$('#myModalError').modal('show');
							

	        		  }
	        	  },

	        	  error: function(jqXHR, textStatus, errorThrown){
	        	
	        		  $('#myModalErrorContent').html(data.messaggio);
	  				$('#myModalError').removeClass();
	  				$('#myModalError').addClass("modal modal-danger");
	  				$('#report_button').show();
					$('#visualizza_report').show();
	  				$('#myModalError').modal('show');
	  				
	  			
	        	  }
	          });
		 
   }	  

   function filtraCommesse(filtro){
		  if(filtro=="tutte"){
			  table
		        .columns( 4 )
		        .search( "" )
		        .draw();
			  $(".btnFiltri").prop("disabled",false);
			  $("#btnTutti").prop("disabled",true);
			  $("#inputsearchtable_4").val("");
		  }else {
			  table
		        .columns( 4 )
		        .search( filtro )
		        .draw();
			  $(".btnFiltri").prop("disabled",false);
			  $("#btnFiltri_"+filtro).prop("disabled",true);
			  $("#inputsearchtable_4").val(filtro);
		  }

	  }
   

   function filtraPacchi(filtro){
		  if(filtro=="tutti"){
			  table
		        .columns( 10 )
		        .search( "" )
		        .draw();
			  $(".btnFiltri").prop("disabled",false);
			  $("#btnTutti").prop("disabled",true);
			  $("#inputsearchtable_10").val("");
		  }else {
			  table
		        .columns( 10 )
		        .search( filtro )
		        .draw();
			  $(".btnFiltri").prop("disabled",false);
			  $("#btnFiltri_"+filtro).prop("disabled",true);
			  $("#inputsearchtable_10").val(filtro);
		  }

	  }

   
   function downloadStrumentiFiltrati(){
	   
	   console.log(table.rows( { filter : 'applied'} ).data().toArray()); 
	   data = table.rows( { filter : 'applied'} ).data().toArray();
	   var stringid = "";
	   data.forEach(function(row, i) {
		   //console.log(row[1])
		   if(i!=0){
			   stringid+=";";
		   }
		   stringid+=""+row[1];
		   
		 });
	   
//	   var stringColumns = "";
//	   table.columns().every( function () {
//		    var visibility = this.visible();
//		  
//			   if(stringColumns!=""){
//				   stringColumns+=";";
//			   }
//			   if(visibility && this.toArray()[0] != 0){
//				   stringColumns+=""+this.toArray()[0];
//
//			   }
//			 
//		} );

	   cliente = $("#select1 option:selected").text();
	   sede = $("#select2 option:selected").text();
	   if(sede == "Non Associate"){
		   sede = "";
	   }
	 	$.form("gestioneStrumento.do?action=pdffiltrati", {"idstrumenti" : stringid,  "cliente" : cliente, "sede" : sede }, 'POST').submit();

	   
//	   $.ajax({
//			type: "POST",
//			url: 'gestioneStrumento.do?action=pdffiltrati',
//			data: {"idstrumenti":stringid},
// 			success: function( data, textStatus) {
//			
//			pleaseWaitDiv.modal('hide');
//			
//				if(data.success)
//				{ 	
//					  
//
//				
//					  
//				}else{
//					
//					pleaseWaitDiv.modal('hide');
//					
//					$('#myModalErrorContent').html(data.messaggio);
//					$('#myModalError').removeClass();
//					$('#myModalError').addClass("modal modal-warning");
//	 				$('#myModalError').modal('show');
//				
//				}
//			},
//			
//			error: function(jqXHR, textStatus, errorThrown){
//				pleaseWaitDiv.modal('hide');
//			
//				$('#myModalErrorContent').html("Nessuna Misura presente per questo strumento");
//				$('#myModalError').removeClass();
//				$('#myModalError').addClass("modal modal-warning");
//				$('#myModalError').modal('show');
//			
//			
//				
//				}		
//		});
	   
	   
   }
 
   
   function inviaEmailAttivazione(idUser){
		
 			pleaseWaitDiv = $('#pleaseWaitDialog');
			pleaseWaitDiv.modal();
 
		var dataObj = {};
		dataObj.idUser = idUser;
		
		$.ajax({
	    	  type: "POST",
	    	  url: "gestioneUtenti.do?action=inviaEmailAttivazione",
	    	  data: dataObj,
	    	  dataType: "json",
	    	  success: function( data, textStatus) {
	    		  
	    		  pleaseWaitDiv.modal('hide');
	    		  
	    		  if(data.success)
	    		  {
	    			  $('#report_button').hide();
						$('#visualizza_report').hide();
	    			  $('#myModalErrorContent').html(data.messaggio);
	    			  	$('#myModalError').removeClass();
	    				$('#myModalError').addClass("modal modal-success");
	    				
						$('#myModalError').modal('show');
	    		  }else{
	    			  $('#myModalErrorContent').html(data.messaggio);
	    			  	$('#myModalError').removeClass();
	    				$('#myModalError').addClass("modal modal-danger");
	    				$('#report_button').show();
						$('#visualizza_report').show();
						$('#myModalError').modal('show');
	    			 
	    		  }
	    	  },

	    	  error: function(jqXHR, textStatus, errorThrown){
	    		  pleaseWaitDiv.modal('hide');

	    		  $('#myModalErrorContent').html(textStatus);
				  	$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					$('#report_button').show();
					$('#visualizza_report').show();
					$('#myModalError').modal('show');
						    
	    	  }
	      });
}
   
   function visualizzaReport(){
	   
	   callAction("visualizzaReport.do");
   }
 
   
   function modificaSingoloValoreCampione(id_campione, id_val_cam){
	   dataString ="idC="+id_campione + "&id_val_cam="+ id_val_cam;
      
	   
	   exploreModal("modificaValoriCampione.do?view=single_edit", dataString, "#modificaSingoloValCampioneModalContent");
	   $('#id_valore_campione').val(id_val_cam);
//	   $('#modificaSingoloValCampioneModal').css('overflow', 'hidden');
	   $('#modificaSingoloValCampioneModal').modal();
	   
   }

   
   function salvaSingoloValoreCampione(id_val_cam, idC){
	   
	  
	   if($("#formModificaAppGrid").valid()){
	   $.ajax({
	          type: "POST",
	          url: "modificaValoriCampione.do?view=salva_singolo_valore&id_val_cam="+id_val_cam +"&idC="+idC ,
	          data: $( "#formModificaAppGrid" ).serialize(),
	          //if received a response from the server
	          success: function( dataResp, textStatus) {
	        	  var data = JSON.parse(dataResp);
	        	  if(data.success)
	      		  { 
	               		  $("#ulError").html("<span class='label label-danger'>Modifica eseguita con successo</span>");
	               		$('#report_button').hide();
	      				$('#visualizza_report').hide();
	               		  $('#myModalErrorContent').html(data.messaggio);
	               		  $('#myModalError').addClass("modal modal-success");
	               		  $('#myModalError').modal('show');

	      		  }else{
	      			$('#myModalErrorContent').html(data.messaggio);
				  	$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					$('#report_button').show();
	  				$('#visualizza_report').show();
					$('#myModalError').modal('show');
					         		
					$("#ulError").html("<span class='label label-danger'>Errore salvataggio</span>");

	      		  }
	        	  pleaseWaitDiv.modal('hide');
	          },
	          error: function( data, textStatus) {

	              console.log(data);
	     		  $("#ulError").html("<span class='label label-danger'>Errore salvataggio</span>");
	     		  
	     		 $('#myModalErrorContent').html(data.messaggio);
				  	$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					$('#report_button').show();
	  				$('#visualizza_report').show();
					$('#myModalError').modal('show');

	          	pleaseWaitDiv.modal('hide');

	          }
	          });
		  }else{
			  $("#ulError").html("<span class='label label-danger'>Compilare tutti i campi obbligatori</span>");

		  }
	   
   }
   
   function modificaTabellaDB(index, azione){
	  
		  var form = $('#modificaTabellaForm')[0]; 
		  var formData = new FormData(form);

	          $.ajax({
	        	  type: "POST",
	        	  url: "gestioneTabelle.do?action=modifica&index="+index+"&azione="+azione,
	        	  data: formData,
	        	  //dataType: "json",
	        	  contentType: false, // NEEDED, DON'T OMIT THIS (requires jQuery 1.6+)
	        	  processData: false, // NEEDED, DON'T OMIT THIS
	        	  //enctype: 'multipart/form-data',
	        	  success: function( data, textStatus) {

	        		  if(data.success)
	        		  { 
	        			  $('#report_button').hide();
							$('#visualizza_report').hide();
							$('#myModalErrorContent').html(data.messaggio);
	        			  	$('#myModalError').removeClass();
	        				$('#myModalError').addClass("modal modal-success");
	        				$('#myModalError').modal('show');
	        				
	        		  }else{
	        			 
	        			  $('#myModalErrorContent').html(data.messaggio);
	        			  	$('#myModalError').removeClass();
	        				$('#myModalError').addClass("modal modal-danger");	  
	        				$('#report_button').show();
							$('#visualizza_report').show();
							$('#myModalError').modal('show');
							

	        		  }
	        	  },

	        	  error: function(jqXHR, textStatus, errorThrown){
	        	
	        		 
	        		  $('#myModalErrorContent').html(data.messaggio);
	  				$('#myModalError').removeClass();
	  				$('#myModalError').addClass("modal modal-danger");
	  				$('#report_button').show();
					$('#visualizza_report').show();
	  				$('#myModalError').modal('show');
	  				
	  			
	        	  }
	          });
		 
}	  
   
   function modificaPinFirma(nuovo_pin, pin_attuale, firma_documento){
		  pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();

		  var dataObj = {};
			dataObj.nuovo_pin = nuovo_pin;
			if(pin_attuale!=null){
			dataObj.pin_attuale = pin_attuale;
			}
			dataObj.firma_documento = firma_documento
			
		  $.ajax({
	          type: "POST",
	          url: "salvaUtente.do?action=modifica_pin",
	          data: dataObj,
	          dataType: "json",
	          //if received a response from the server
	          success: function( data, textStatus) {
	        	  //var dataRsp = JSON.parse(dataResp);
	        	  if(data.success)
	      		  {        		
	        		  pleaseWaitDiv.modal('hide');
	        		 
	        		  $('#modalModificaPin').modal('toggle');
	        		  $('#report_button').hide();
						$('#visualizza_report').hide();
						$('#myModalErrorContent').html(data.messaggio);
						if(data.pin!=null){
							pin0=data.pin;
						}
						
						
      			  	$('#myModalError').removeClass();
      				$('#myModalError').addClass("modal modal-success");
      				$('#myModalError').modal('show');
      				
 
	      		  }else{
	      			 pleaseWaitDiv.modal('hide');
//	      			$("#usrError").html('<h5>Attenzione! il PIN inserito non &egrave; associato all\'utente corrente!</h5>');
//	      			$("#usrError").addClass("callout callout-danger");
	      			 $('#modalModificaPin').modal('toggle');
	      			 $('#myModalErrorContent').html(data.messaggio);
     			  	$('#myModalError').removeClass();
     				$('#myModalError').addClass("modal modal-danger");	  
     				//$('#report_button').show();
						//$('#visualizza_report').show();
						$('#myModalError').modal('show');
	      			
	      		  }
	        	 
	          },
	          error: function( data, textStatus) {

	              console.log(data);
	              ('#myModalErrorContent').html(data.messaggio);
   			  	$('#myModalError').removeClass();
   				$('#myModalError').addClass("modal modal-danger");	  
   				$('#report_button').show();
						$('#visualizza_report').show();
						$('#myModalError').modal('show');

	          	pleaseWaitDiv.modal('hide');

	          }
	          });

	  }
   
   function verificaPinFirma(pin, filename){
		  pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();

		  var dataObj = {};
			dataObj.pin = pin;
		  $.ajax({
	          type: "POST",
	          url: "firmaDocumento.do?action=checkPIN",
	          data: dataObj,
	          dataType: "json",
	          //if received a response from the server
	          success: function( data, textStatus) {
	        	  //var dataRsp = JSON.parse(dataResp);
	        	  if(data.success)
	      		  {  
	        		  pleaseWaitDiv.modal('hide');
	      		  
	        		  firmaDocumento(filename);
	      		  }else{
	      			pleaseWaitDiv.modal('hide');
	      			$('#pin').val("");
	      			
	      			$('#myModalErrorContent').html(data.messaggio);
    			  	$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-danger");
    				if(data.num_error!=1){
    				$('#report_button').show();
					$('#visualizza_report').show();
    				}
    				$('#myModalError').modal('show');
    				
    				
	      		  }
	          },
	          error: function( data, textStatus) {

	        	  $('#myModalErrorContent').html(data.messaggio);
  			  	$('#myModalError').removeClass();
  				$('#myModalError').addClass("modal modal-danger");	  
  				$('#report_button').show();
					$('#visualizza_report').show();
					$('#myModalError').modal('show');


	          	pleaseWaitDiv.modal('hide');

	          }
	          });

	  }
   
   function firmaDocumento(filename){
		 
		  var dataObj = {};
			dataObj.filename = filename;
		  $.ajax({
	          type: "POST",
	          url: "firmaDocumento.do?action=firma",
	          data: dataObj,
	          dataType: "json",
	          //if received a response from the server
	          success: function( data, textStatus) {
	        	  //var dataRsp = JSON.parse(dataResp);
	        	  if(data.success)
	      		  {  
	        		 callAction('firmaDocumento.do?action=download&filename='+filename);
	        		  
	      		  }else{
	      			
	      			$('#myModalErrorContent').html(data.messaggio);
 			  	$('#myModalError').removeClass();
 				$('#myModalError').addClass("modal modal-danger");	  
 				$('#myModalError').modal('show');
 				$('#pin').val("");
 			
	      		  }
	          },
	          error: function( data, textStatus) {

	        	  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");	  
				$('#report_button').show();
					$('#visualizza_report').show();
					$('#myModalError').modal('show');

	          }
	          });

	  }

   function cercaOrigini(id_item){
		 
		  var dataObj = {};
			dataObj.id_item = id_item;
		  $.ajax({
	          type: "POST",
	          url: "listaItem.do?action=cerca_origini",
	          data: dataObj,
	          dataType: "json",
	          //if received a response from the server
	          success: function( data, textStatus) {
	        	  //var dataRsp = JSON.parse(dataResp);
	        	  if(data.success)
	      		  {  
	        				pacchi_origine = JSON.parse(data.pacchi_origine_json);
	        				$('#pacco_origine').find('option').remove();
	        				$('#pacco_origine').append('<option value=""></option>');
	        				pacchi_origine.forEach(function(item){
	        					$('#pacco_origine').append('<option value="'+item.origine+'">'+item.origine+'</option>');

	        				});
	        				$('#pacco_origine').select2();
	        				
	        				 $('#pacco_origine').attr('disabled', false);
	        		  
	      		  }else{
	      			
	      			$('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");	  
				$('#report_button').show();
				$('#visualizza_report').show();
				$('#myModalError').modal('show');
				
			
	      		  }
	          },
	          error: function( data, textStatus) {

	        	  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");	  
				$('#report_button').show();
				$('#visualizza_report').show();
					$('#myModalError').modal('show');

	          }
	          });

	  }
   
   
   function creaStoricoItem(origine, id_item){
		 
		  var dataObj = {};
			dataObj.origine = origine;
			dataObj.id_item = id_item;
		  $.ajax({
	          type: "POST",
	          url: "listaItem.do?action=storico_item",
	          data: dataObj,
	          dataType: "json",
	          //if received a response from the server
	          success: function( data, textStatus) {
	        	  //var dataRsp = JSON.parse(dataResp);
	        	  if(data.success)
	      		  {  
	        		  $('#grafico_storico').css("margin-top", "0px");
	        				pacchi = JSON.parse(data.lista_pacchi_json);

	        				var date=[];
	        				var lab= [];
	        			
	        				if(pacchi!=null){
	        					pacchi.forEach(function(idx){
	        					if(idx.stato_lavorazione.id==1||idx.stato_lavorazione.id==5){	        						
	        					
	        						date.push(Date.parse(idx.data_arrivo));
	        					    lab.push(idx.stato_lavorazione.descrizione);		        							        					
	        					}
	        					else {
	        						
	        						date.push(Date.parse(idx.data_spedizione));    
		        					lab.push(idx.stato_lavorazione.descrizione);		        				
	        					}
	        					
	        				});
	        				}
	        				var ctx = document.getElementById("chart_storico").getContext('2d');
	        				var myChart = new Chart(ctx, {
	        				    type: 'line',
	        				    responsive:true,
	        				    maintainAspectRatio: true,
	        				    data: {
	        				       
	        				        labels: lab,
	        				        datasets: [{
	        				            label: 'Storico',
	        				            data: date,
	        				            steppedLine:true,
	        				            backgroundColor: [	        				               
	        				                'rgba(54, 162, 235, 0.2)'
	        				            ],
	        				            borderColor: [	        				                
	        				                'rgba(54, 162, 235, 1)'
	        				            ],
	        				            borderWidth: 1
	        				        }]
	        				    },
	        				    options: {
	        				        scales: {
	        				        	xAxes: [{	        			                    
	        			                    ticks: {	
	        			                    	autoSkip: false
	        			                    }
	        			                }],
	        				            yAxes: [{
	        				                ticks: {
	        				                    beginAtZero:false,
	        				                    callback: function(label, index, labels) {
	        				                        var date = new Date(label);
	        				                        
	        				                        var day = (date.getDate()<10?'0':'')+date.getDate();
	        				                        var month = (date.getMonth()<10?'0':'')+(date.getMonth() +1);
	        				                        var year = date.getFullYear();

	        				                        return day + '/' + month  + '/' + year;	        				                              
	        				                        }	        				                    
	        				                },
	        				                afterBuildTicks: function(humdaysChart) {    
	        				                    humdaysChart.ticks = date;   
	        				                  }
	        				            }],

	        				        },
        				            tooltips: {
	        				            callbacks: {
	        				            	label: function(tooltipItem, data) {
	        				            		var date = new Date(tooltipItem.yLabel);
        				                        
        				                        var day = (date.getDate()<10?'0':'')+date.getDate();
        				                        var month = (date.getMonth()<10?'0':'')+(date.getMonth() +1);
        				                        var year = date.getFullYear();

        				                        return day + '/' + month  + '/' + year;	
	        				                  }
	        				            }
	        				            }
	        				    }
	        				});
	        		  
	      		  }else{
	      			
	      			$('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");	  
				$('#myModalError').modal('show');
				
			
	      		  }
	          },
	          error: function( data, textStatus) {

	        	  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");	  
				$('#report_button').show();
					$('#visualizza_report').show();
					$('#myModalError').modal('show');

	          }
	          });

	  }
   
   function importaInfoDaCommessa(id_commessa, flag){
	   pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
	   var dataObj = {};
		dataObj.id_commessa = id_commessa;
	  $.ajax({
         type: "POST",
         url: "gestionePacco.do?action=importa_da_commessa",
         data: dataObj,
         dataType: "json",
         //if received a response from the server
         success: function( data, textStatus) {
       	  //var dataRsp = JSON.parse(dataResp);
       	  if(data.success)
     		  {  
       		  var id_destinatario = data.id_destinatario;
       		  var sede_destinatario = data.id_sede_destinatario;
       		  var id_destinazione = data.id_destinazione;
       		  var sede_destinazione = data.id_sede_destinazione;
       		  var nome_cliente = data.nome_cliente;
       		  var nome_sede_cliente = data.nome_sede_cliente;
       		  if(flag==0){
       			  	$('#select1').val(id_destinatario+"_"+nome_cliente);
       			  	$('#select1').change();
       			  	if(nome_sede_cliente!=""){
       			  		$('#select2 option[value="'+sede_destinatario+"_"+id_destinatario+"__"+nome_sede_cliente+'"]').attr("selected", true);
       			  	}else{
       			  		$('#select2 option[value=0]').attr("selected", true);
       			  	}
       				$('#destinatario').val(id_destinatario);
       				$('#destinatario').change();       				
       				$('#sede_destinatario option[value="'+sede_destinatario+"_"+id_destinatario+'"]').attr("selected", true);       				
       				$('#destinazione').val(id_destinazione);
       				$('#destinazione').change();
       				//$('#sede_destinazione').val(sede_destinazione+"_"+id_destinazione);
       				$('#sede_destinazione option[value="'+sede_destinazione+"_"+id_destinazione+'"]').attr("selected", true);    
       		  }else{
       			$('#select1').val(id_destinatario+"_"+nome_cliente);
   			  	$('#select1').change();
   			 if(nome_sede_cliente!=""){
			  		$('#select2 option[value="'+sede_destinatario+"_"+id_destinatario+"__"+nome_sede_cliente+'"]').attr("selected", true);
			  	}else{
			  		$('#select2 option[value=0]').attr("selected", true);
			  	}
   			 
				$('#destinatario_ddt').val(id_destinatario);
   				$('#destinatario_ddt').change();       				
   				$('#sede_destinatario_ddt option[value="'+sede_destinatario+"_"+id_destinatario+'"]').attr("selected", true);       				
   				$('#destinazione_ddt').val(id_destinazione);
   				$('#destinazione_ddt').change();
   				
   				$('#sede_destinazione_ddt option[value="'+sede_destinazione+"_"+id_destinazione+'"]').attr("selected", true);  
//       			  	$('#destinatario_ddt').val(id_destinatario);
//       			  	$('#destinatario_ddt').change();
//     				$('#destinazione_ddt').val(id_destinazione);   
//     				$('#destinazione_ddt').change();
//     				$('#sede_destinatario_ddt').val(sede_destinatario+"_"+id_destinatario);
//     				$('#sede_destinatario_ddt').change();
//     				$('#sede_destinazione_ddt').val(sede_destinazione+"_"+id_destinazione);
       		  }
       			
       			 pleaseWaitDiv.modal('hide');
     		  }else{
     			
     			 pleaseWaitDiv.modal('hide');
     			$('#myModalErrorContent').html(data.messaggio);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");	  
			//$('#report_button').show();
			//$('#visualizza_report').show();
			$('#myModalError').modal('show');
			
		
     		  }
         },
         error: function( data, textStatus) {
        	 pleaseWaitDiv.modal('hide');
       	  $('#myModalErrorContent').html(data.messaggio);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");	  
			$('#report_button').show();
			$('#visualizza_report').show();
				$('#myModalError').modal('show');

         }
         });
	   
   }
