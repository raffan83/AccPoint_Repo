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
		
		$.ajax({
            type: "POST",
            url: action,
            
            //if received a response from the server
            success: function( data, textStatus) {
            	
            	$('#corpoframe').html(data);

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
	

	function logout(action)
	{
	if(navigator.appName=="Netscape"){
	parent.corpoFrame.contentDocument.forms[0].action="/AccPoint/"+action
	parent.corpoFrame.contentDocument.forms[0].submit();
	}else
	{
	parent.corpoFrame.document.forms[0].action="/AccPoint/"+action
	parent.corpoFrame.document.forms[0].submit();
	}
	}
	
	
	function callActionRemote(path,action)
	{
		document.forms[0].action="/AccPoint/"+path+"/"+action 
		document.forms[0].submit();
	}
	
	function menu(){
		var element=document.getElementById("menu").getElementsByTagName('td');
		
			
			if(element[1].style.display=="block")
			{
			for(i=1; i <element.length; i++){
					element[i].style.display="none";
			}
			}
			else
			{
			for(i=0; i <element.length; i++){
					element[i].style.display="block";
			}
			}
	}
	
	function nascondi(id)
	{
	document.getElementById(id).style.display="none";
	}
	
	function refreshContainer()
	{
	var element=document.getElementById("dittaSelezionata")
		callAction('refreshContainer')
	}
	function refreshContainerOut()
	{
	var element=document.getElementById("dittaSelezionata")
		callAction('refreshContainerOut')
	}
	
	function confermaInserimentoScatola()
	{
	var element=document.getElementById("idContainer")
	
		var conf=confirm('Creazione Container '+element.value)
		
		return conf
	}
	
	function confermaInserimentoDoc()
	{
	var element=document.getElementById("documento")
	var cont=document.getElementById("containerSelezionato")
	
	
		var conf=confirm('CheckIn documento '+element.value+' del contenitore '+cont.value);
				
		return conf
	}
	
	function confermaEliminazioneModello()
	{

		var conf=confirm('Sei sicuro di voler eliminare il Modello ?');
				
		return conf
	}
	
	function validaModello()
	{	
	var flag=true
	
	var stringaErrore="";
	
	var nomeModello=document.getElementById("nomeModello")
	var campo1=document.getElementById("campo1")
	var campo1Text=document.getElementById("campo1Text")
	var campo2=document.getElementById("campo2")
	var campo2Text=document.getElementById("campo2Text")
	var campo3=document.getElementById("campo3")
	var campo3Text=document.getElementById("campo3Text")
	var campo4=document.getElementById("campo4")
	var campo4Text=document.getElementById("campo4Text")
	var campo5=document.getElementById("campo5")
	var campo5Text=document.getElementById("campo5Text")
	var campo6=document.getElementById("campo6")
	var campo6Text=document.getElementById("campo6Text")
	var campo7=document.getElementById("campo7")
	var campo7Text=document.getElementById("campo7Text")
	var campo8=document.getElementById("campo8")
	var campo8Text=document.getElementById("campo8Text")
	
	if(nomeModello.value.length==0)
	{
		 stringaErrore="Nome Modello Assente";
		 flag = false
	}

    if(campo1Text.value.length==0 && nomeModello.value.length!=0)
	{
		 stringaErrore="Bisogna valorizzare almeno il campo 1";
		 flag= false;
	}
	
	if(campo1Text.value.length==0 && campo1.value!=0)
	{
		 stringaErrore=stringaErrore+"\n"+"Campo 1 non valorizzato";
		 flag = false
	}	
	
	if(campo1Text.value.length!=0 && campo1.value==0)
	{
		 stringaErrore=stringaErrore+"\n"+"Tipo Campo 1 non valorizzato";
		 flag = false
	}	
	
	
	
	if(campo2Text.value.length==0 && campo2.value!=0)
	{
		 stringaErrore=stringaErrore+"\n"+"Campo 2 non valorizzato";
		 flag = false
	}	
	
	if(campo2Text.value.length!=0 && campo2.value==0)
	{
		 stringaErrore=stringaErrore+"\n"+"Tipo Campo 2 non valorizzato";
		 flag = false
	}	
	
	if(campo3Text.value.length==0 && campo3.value!=0)
	{
		 stringaErrore=stringaErrore+"\n"+"Campo 3 non valorizzato";
		 flag = false
	}	
	
	if(campo3Text.value.length!=0 && campo3.value==0)
	{
		 stringaErrore=stringaErrore+"\n"+"Tipo Campo 3 non valorizzato";
		 flag = false
	}	
	
	if(campo4Text.value.length==0 && campo4.value!=0)
	{
		 stringaErrore=stringaErrore+"\n"+"Campo 4 non valorizzato";
		 flag = false
	}	
	
	if(campo4Text.value.length!=0 && campo4.value==0)
	{
		 stringaErrore=stringaErrore+"\n"+"Tipo Campo 4 non valorizzato";
		 flag = false
	}	
	
	if(campo5Text.value.length==0 && campo5.value!=0)
	{
		 stringaErrore=stringaErrore+"\n"+"Campo 5 non valorizzato";
		 flag = false
	}	
	
	if(campo5Text.value.length!=0 && campo5.value==0)
	{
		 stringaErrore=stringaErrore+"\n"+"Tipo Campo 5 non valorizzato";
		 flag = false
	}	
	
	if(campo6Text.value.length==0 && campo6.value!=0)
	{
		 stringaErrore=stringaErrore+"\n"+"Campo 6 non valorizzato";
		 flag = false
	}	
	
	if(campo6Text.value.length!=0 && campo6.value==0)
	{
		 stringaErrore=stringaErrore+"\n"+"Tipo Campo 6 non valorizzato";
		 flag = false
	}	
	
	if(campo7Text.value.length==0 && campo7.value!=0)
	{
		 stringaErrore=stringaErrore+"\n"+"Campo 7 non valorizzato";
		 flag = false
	}	
	
	if(campo7Text.value.length!=0 && campo7.value==0)
	{
		 stringaErrore=stringaErrore+"\n"+"Tipo Campo 7 non valorizzato";
		 flag = false
	}	
	
	if(campo8Text.value.length==0 && campo8.value!=0)
	{
		 stringaErrore=stringaErrore+"\n"+"Campo 8 non valorizzato";
		 flag = false
	}	
	
	if(campo8Text.value.length!=0 && campo8.value==0)
	{
		 stringaErrore=stringaErrore+"\n"+"Tipo Campo 8 non valorizzato";
		 flag = false
	}	
	
		if(flag)
		{
		return true
		}
		else
		{
		alert(stringaErrore)
		return false;
		}
				
		
	}
	
	function confermaInserimentoDocOut()
	{
	var element=document.getElementById("documento")
	var cont=document.getElementById("containerSelezionato")
	
		var conf=confirm('CheckOut documento '+element.value+' del contenitore '+cont.value)
		
		return conf
	}
	
	function visualizza(id)
	{
	document.getElementById(id).style.display="block";
	}
	
	function controllaCampiInsDitta()
	{
		var nomeDitta=document.getElementById('nomeDitta');
		var pIva=document.getElementById('pIva');
		var codiceDitta=document.getElementById('codiceDitta');
		var error=""
		
		var soloLettere = new RegExp("[^a-z][^A-Z]");
		var soloNumeri	= new RegExp("^[0-9]+$");
		
		if ((nomeDitta.value== "") || (pIva.value== "")  || (codiceDitta.value== "")) {
				alert("Tutti i campi sono obbligatori");
				return false;
			}
			if (pIva.value.length!=11 || !pIva.value.match(soloNumeri)) {	
				alert("P IVA non corretta");
				return false;
			}
	
				
			 else if (!codiceDitta.value.match(soloNumeri)){
				alert("Il codice Ditta deve essere un codice numerico");
				return false;
			}
			else{
			return true;		
	}
	}
	
	function controllaTabellaExport(){
	 var record="";
	          var tag = document.getElementById('tabellaExport').getElementsByTagName('input');
			 	
				for(i=0; i <tag.length; i++){
					if(tag[i].type == "radio"){
						if(tag[i].checked==true){
						record=tag[i].value;
						}
					}
			}
			
			if(record==""){
			alert("Devi necessariamente selezionare un record");
			return false;
			}
			else
			{
			return true;
			}
	}
	
	
	
	
	function controllaCampiInsForn()
	{
		var valoreDitta=document.getElementById('dittaSelezionata');
		var pIva=document.getElementById('pIva');
		var nomeFornitore=document.getElementById('nomeFornitore');
		var sottoconto=document.getElementById('sottoconto');
		
		var soloLettere = new RegExp("[^a-z][^A-Z]");
		var soloNumeri	= new RegExp("^[0-9]+$");
		
			return true;		
	
	}
	function controllaDittaSel()
	{
	var valoreDitta=document.getElementById('dittaSel');
	if(valoreDitta.value=="00000")
	{
	alert("Devi selezionare una Ditta");
	return false;
	}
	else
	{
	return true;
	}
	}
	
	function checkField()
	{
	
	var valoreDitta=document.getElementById('nomeSoc');
	if(valoreDitta.value=="")
	{
	alert("Devi selezionare una Ditta");
	return false;
	}
	else
	{
	return true;
	}
	}
	function controllaEsportazioneLotto()
	{
	var checkCS=document.getElementById("cs").value;
	var checkDMS=document.getElementById("dms").value;
	
				if(checkCS!="on" && checkDMS!="on")
				{
				alert("Devi selezionare una tipologia di Export")
				return false;
				}	
		var record="";
	          var tag = document.getElementById('tabellaLotti').getElementsByTagName('input');
			 	
				for(i=0; i <tag.length; i++){
					if(tag[i].type == "radio"){
						if(tag[i].checked==true){
						record=tag[i].value;
						}
					}
			}
			
			if(record==""){
			alert("Devi necessariamente selezionare un Lotto");
			return false;
			}
	
	return true;
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
	
	function pressEnter()
	{
		alert('ok');
	}
	
	function controlloInsOp(data, numero)
	{
		var result=true;
		var str="";
		if(IsDate(data) == false || IsDate(data) == null)
		{
			result=false;
			str="- Data Errata"+ "\n"
		}
		if(numero=="0")
		{
			result=false;
			str=str+"\n- Eseguire Refresh numero"
		}
		
		if(str!="")
		{
		alert(str)
		}
		return result;
	}

	function IsDate(txtDate)
{
	
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

function controlloBatchSelezionata()
{
	var batchSel=document.getElementById("batchSelezionata");
	
	if(batchSel.value=="00000")
	{
	alert('Devi Selezionare almeno una Batch')
	
	}
	else
	{
	callAction('insDatiOperDaBatchCore')
	}
	
}
 function controlloInsDaBatch()
 {
 	var ckClass=document.getElementById('cClass');
 	var ckScan=document.getElementById('cScan');
 	var ckVal=document.getElementById('cVal');
 	var ckVer=document.getElementById('cVer');
 	var ckRis=document.getElementById('cRis');
 	var ckVar=document.getElementById('cVar');
 	

 	if(ckClass.checked==false && ckScan.checked==false && ckVal.checked==false && ckVer.checked==false && ckRis.checked==false && ckVar.checked==false)
 	{
 		alert('Devi selezionare almeno un attività') 		
 	}
 	else
 	{
 		
 		callAction('insDatiOperatoreDaBatchINS')
 	}
 }  
 
 function keyCheck(eventObj, obj)
{
var keyCode

// Check For Browser Type
if (document.all){ 
keyCode=eventObj.keyCode
}
else{
keyCode=eventObj.which
}
var str=obj.value

if(keyCode==46){ 
if (str.indexOf(".")>0){
return false
}
}

if((keyCode<48 || keyCode >58) && keyCode!=8){ // Allow only integers and decimal points
return false
}

return true
}

function isDateVal(dateStr) { 

    var datePat = /^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/; 
    var matchArray = dateStr.match(datePat); 

    if (matchArray == null) { 
        alert("inserire una data valida gg/mm/aaaa"); 
        return false; 
    } 

    month = matchArray[3]; 
    day = matchArray[1]; 
    year = matchArray[5]; 

    if (month < 1 || month > 12) { 
        alert("I mesi devono essere compresi tra 1 e 12"); 
        return false; 
    } 

    if (day < 1 || day > 31) { 
        alert("I giorni devono essere compresi tra 1 e 31"); 
        return false; 
    } 

    if ((month==4 || month==6 || month==9 || month==11) && day==31) { 
        alert("Il Mese "+month+" non ha 31 giorni!") 
        return false; 
    } 

    if (month == 2) { 
        var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)); 
        if (day > 29 || (day==29 && !isleap)) { 
            alert("Febbraio " + year + " non ha " + day + " giorni!"); 
            return false; 
        } 
    } 
    return true; 
} 

   function controlloInsDatiOperatore()
   {

   var error=""
   var result=true;
   var date=document.getElementById('date').value;
   var ditta=document.getElementById('dittaSelezionata').value;
   var attivita=document.getElementById('attivitaSelezionata').value;
   var doc=document.getElementById('nDocumenti').value;
   var pag=document.getElementById('nPagine').value;
   var time=document.getElementById('durata').value;
   

  if(ditta=="00000")
  {
   error=error+ "- Selezionare Ditta \n";
   
   result=false;
  } 
   if(attivita=="00000")
  {
   error=error+ "- Selezionare Attivita \n";
   
   result=false;
  } 
  
  if( isDateVal(date)==false)
  {
  	result=false
  }
 		
  if(doc=="" || doc=="0")
  {
   error=error+"- Il campo Documenti va valorizzato (>0) \n";
   result=false;
  }
  
  if(pag=="")
  {
  	error=error+"- Il campo Pagine va valorizzato almeno con 0 \n";
   result=false;
  }
   if(time=="" || time=="0")
  {
  	error=error+"- Il campo Durata va valorizzato (>0) \n";
   result=false;
  }
   
   if(result==true)
   {
  	callAction('insDatiOperCore')
   }
   else
   {
   alert(error)
   }
   }