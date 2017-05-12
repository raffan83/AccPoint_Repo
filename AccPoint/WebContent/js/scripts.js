
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
				callAction("login.do","#loginForm");		
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
            		 			})

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
            		    buttonText: {
            		        today: 'today',
            		        month: 'month'

            		      },
//            			  eventRender: function(event, element, view) {
//         		             return $('<span class=\"badge bg-red bigText\"">' 
//         		             + event.title + 
//         		             '</span>');
//         		         },	 
            		  
            		           eventClick: function(calEvent, jsEvent, view) {

            		        	explore('listaCampioni.do?date='+moment(calEvent.start).format());
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
   
   
   function nuovoInterventoFromModal(divID){
	   if(divID){
		   $( divID ).modal();
	   }else{
	  	$( "#myModal" ).modal();
	   }
	  	   
   }
   
   function saveInterventoFromModal(idCommessa){
	   var str=$('#sede').val();

	  	  if(str.length != 0){
	  		  $('#myModal').modal('hide')
	  		  var dataArr={"sede":str};
	            

	    
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
	          			  	
	          			  var table = $('#tabPM').DataTable();

	          	//"{"id":19,"dataCreazione":"mag 3, 2017","idSede":1,"id_cliente":7011,"nome_sede":"SEDE OPERATIVA","user":{"id":1,"user":"admin","passw":"*F28AA01DCF16C082DC04B36CB2F245431FA0CFED","nominativo":"Amministratore","nome":"Admin - Name","cognome":"Admin - Surname","indirizzo":"Via Tofaro 42/c","comune":"Sora","cap":"03039","EMail":"info@stisrl.com","telefono":"0776181501","idCompany":4132,"tipoutente":"AM"},"idCommessa":"201700001","statoIntervento":{"id":1},"pressoDestinatario":0,"company":{"id":4132,"denominazione":"STI - Sviluppo e Tecnologie Industriali S.r.l","pIva":"01862150602","indirizzo":"Via Tofaro 42/b","comune":"Sora","cap":"03039","mail":"info@stisrl.com","telefono":"0776181501","codAffiliato":"001"},"nomePack":"CM413203052017044229","nStrumentiGenerati":0,"nStrumentiMisurati":0,"nStrumentiNuovi":0,"listaInterventoDatiDTO":[]}"	
	          			intervento = JSON.parse(data.intervento);
	          			  
	          			  if(intervento.pressoDestinatario == 0){
	          				presso = "IN SEDE";
	          			}else if(intervento.pressoDestinatario == 1){
	          				presso = "PRESSO CLIENTE";
	          			}else{
	          				presso = "-";
	          			}
	          			
	          			  var user = intervento.user;
	          			var rowNode =  table.row.add( [
	          			        '<a class="btn" onclick="callAction(\'gestioneInterventoDati.do?idIntervento='+intervento.id+'\');">'+intervento.id+'</a>',
	          			        '<span class="label label-info">'+presso+'</span>',
	          			        intervento.nome_sede,
	          			        moment(intervento.dataCreazione).format(),
	          			        '<span class="label label-info">-</span>',
	          			        user.nome,
	          			      '<a class="btn" onclick="callAction(\'gestioneInterventoDati.do?idIntervento='+intervento.id+'\');"> <i class="fa fa-arrow-right"></i> </a>'
	          			    ] ).draw();
	          			  	
	          		
	          		  }
	          	  },

	          	  error: function(jqXHR, textStatus, errorThrown){
	          	

	          		 $('#errorMsg').html("<h3 class='label label-danger'>"+textStatus+"</h3>");
	          		  //callAction('logout.do');
	          
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

		             	        jsonObj.push(item);
		              		}
	             		
 		 $('#calendario').fullCalendar({
   			header: {
   		        left: 'prev,next today',
   		        center: 'title',
   		        right: 'month,agendaWeek,agendaDay'
   		      },
   		    buttonText: {
   		        today: 'today',
   		        month: 'month',
   		        week: 'week',
   		        day: 'day'
   		      },
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
	            data: "dataIn={campione:"+JSON.stringify(campioneSelected)+",start:"+data.event.start.toISOString()+",end:"+data.event.end.toISOString()+",nota:"+nota+"}",
	            //if received a response from the server
	            success: function( dataResp, textStatus) {
	            
	            	   $(data.container).fullCalendar('renderEvent', {
	           	        start: data.event.start,
	           	        end: data.event.end,
	           	        block: true,
	           	        title: nota,
	           	        color: "#FF0000",
	           	 	    	} );
	                      console.log(event);
	                      $("#noteApp").val('');
	                      $("#emptyPrenotazione").html('');
	                      $("#myModalPrenotazione").modal('hide');
	            	pleaseWaitDiv.modal('hide');
	            },
	            error: function( data, textStatus) {

	                console.log(data);
	                $("#emptyPrenotazione").html('Errore salvataggio');


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
	  var valid=true;
	  var count = $('#tblAppendGrid').appendGrid('getRowCount'), index = '';
      for (var z = 0; z < count; z++) {

        	  var elem1 = $('#tblAppendGrid').appendGrid('getCellCtrl', 'incertezza_assoluta', z);
        	  var elem2 = $('#tblAppendGrid').appendGrid('getCellCtrl', 'incertezza_relativa', z);
        	  if(elem1.value=="" && elem2.value==""){
        		  valid = false;
        	  }
      }
     
	  
	  
	  if($("#formAppGrid").valid() && valid){
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
               		  
               		  $('#myModalSuccess').modal('show');
               		$('#myModalSuccess').on('hidden.bs.modal', function (e) {
               			callAction('listaCampioni.do');
  		 			});
                            	 
                     
               		
      		  }else{
         		  $("#ulError").html("<span class='label label-danger'>Errore salvataggio</span>");


      		  }
        	  pleaseWaitDiv.modal('hide');
          },
          error: function( data, textStatus) {

              console.log(data);
     		  $("#ulError").html("<span class='label label-danger'>Errore salvataggio</span>");



          	pleaseWaitDiv.modal('hide');

          }
          });
	  }else{
		  $("#ulError").html("<span class='label label-danger'>Compilare tutti i campi obbligatori</span>");
		  if(!valid){
			  $("#ulError").html("<span class='label label-danger'>Compilare tutti i campi obbligatori. Insereire Incertezza Assoluta o Incertezza Relativa</span>");
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
	          			  $('#modalNuovoStrumento').modal('hide')
	          			  dataString ="idSede="+ idSede+";"+idCliente;
	          	          exploreModal("listaStrumentiSedeNew.do",dataString,"#posTab",function(data,textStatusb){
	          	        	  $('#errorMsg').html("<h3 class='label label-success' style=\"color:green\">Strumento Salvato con Successo</h3>");
	          	          });
	          			  	
	          		
	          		  }else{
	          			 $('#errorMsg').html("<h3 class='label label-error' style=\"color:green\">Errore Salvataggio Strumento</h3>");
	          		  }
	          	  },

	          	  error: function(jqXHR, textStatus, errorThrown){
	          	

	          		 $('#errorMsg').html("<h3 class='label label-danger'>"+textStatus+"</h3>");
	          		  //callAction('logout.do');
	          
	          	  }
	            });
	  	  	
	  	   
  }
  
  function modificaCampione(idCamampione){
	  
	  var dataObj = {};
	  dataObj.id = idCamampione;
	  dataObj.nome = $("#aggiorna #nome").val();
	  dataObj.tipoCampione = $("#aggiorna #tipoCampione").val();
	  dataObj.codice = $("#aggiorna #codice").val();
	  dataObj.matricola = $("#aggiorna #matricola").val();
	  dataObj.descrizione = $("#aggiorna #descrizione").val();
	  dataObj.costruttore = $("#aggiorna #costruttore").val();
	  dataObj.modello = $("#aggiorna #modello").val();
	  dataObj.interpolazione = $("#aggiorna #interpolazione").val();
	  dataObj.freqTaratura = $("#aggiorna #freqTaratura").val();
	  dataObj.statoCampione = $("#aggiorna #statoCampione").val();
	  dataObj.dataVerifica = $("#aggiorna #dataVerifica").val();
	  dataObj.dataScadenza = $("#aggiorna #dataScadenza").val();
	  dataObj.tipoVerifica = $("#aggiorna #tipoVerifica").val();
	  dataObj.certificato = $("#aggiorna #certificato").val();
	  dataObj.numeroCerificato = $("#aggiorna #numeroCerificato").val();
	  dataObj.utilizzatore = $("#aggiorna #utilizzatore").val();
	  dataObj.dataInizio = $("#aggiorna #dataInizio").val();
	  dataObj.dataFine = $("#aggiorna #dataFine").val();
	 
		
          $.ajax({
        	  type: "POST",
        	  url: "gestiooneCampione.do?action=modifica",
        	  data: dataObj,
        	  dataType: "json",

        	  success: function( data, textStatus) {

        		  if(data.success)
        		  { 
        			  //$('#myModal').modal('hide')
        			  dataString ="";
        	          callAction("listaCampioni.do");
        			  	
        		
        		  }else{
        			 $('#errorModifica').html("<h3 class='label label-error' style=\"color:green\">Errore Salvataggio Strumento</h3>");
        			 
        		  }
        	  },

        	  error: function(jqXHR, textStatus, errorThrown){
        	

        		 $('#errorModifica').html("<h3 class='label label-danger'>"+textStatus+"</h3>");
        		  //callAction('logout.do');
        
        	  }
          });
	  
  }
  function createLDTable(data){
	  
	  var dataSet = [];
	  
	  var jsonData = JSON.parse(data.result.duplicate);
	  
	  for(var i=0 ; i<jsonData.length;i++)
      {

			item = ["<input type='checkbox' value='"+jsonData[i].__id+"'>",jsonData[i].__id,jsonData[i].denominazione];
	 

	        dataSet.push(item);
		}
	  $("#modalListaDuplicati").modal("show");


	  $('#tabLD').DataTable( {
	        data: dataSet,
	        bDestroy: true,
	        columns: [
	            { title: "Check" },
	            { title: "ID" },
	            { title: "Descrizione" }
	        ]
	    } );
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
	  if(ids.lenght>0){
		  var  dataObj = {};
	  	dataObj.ids =""+ ids+"";
	  
		  $.ajax({
	    	  type: "POST",
	    	  url: "caricaPacchetto.do?action=duplicati",
	    	  data: dataObj,
	    	  dataType: "json",
	
	    	  success: function( data, textStatus) {
	
	    		  if(data.success)
	    		  { 
	    			  	$('#modalErrorDiv').html(data.messaggio);
	    			  	$('#myModal').removeClass();
						$('#myModal').addClass("modal modal-danger");
						$('#myModal').modal('show');
						$( "#tabLD" ).html("");
	    			  	
	    		
	    		  }else{

	    			  	$('#modalErrorDiv').html(data.messaggio);
	    			  	$('#myModal').removeClass();
						$('#myModal').addClass("modal modal-danger");
						$('#myModal').modal('show');
						$( "#tabLD" ).html("");
	    		  }
	    	  },
	
	    	  error: function(jqXHR, textStatus, errorThrown){
	    	
	
	    		 $('#errorMsg').html("<h3 class='label label-danger'>"+textStatus+"</h3>");
	    		  //callAction('logout.do');
	    
	    	  }
	      });
	  }
  }
	 
   $(function(){
		pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal('hide');  
   });