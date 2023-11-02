<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
          <h1 class="pull-left">
        Dettaglio Intervento
        <small></small>
      </h1>
        <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
<div style="clear: both;"></div>

    <!-- Main content -->
    <section class="content">



<div class="row">
        <div class="col-xs-12">
        
        
        
          <div class="box">
            <div class="box-body">

            <div class="row">
<div class="col-xs-12">

<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati Intervento
	<div class="box-tools pull-right">

		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${interventover.id}</a>
                </li>
                <li class="list-group-item">
                  <b>Company</b> <a class="pull-right">${interventover.company.denominazione}</a>
                </li>
                <li class="list-group-item">
                <b>Luogo</b>
                		<c:choose>
						  <c:when test="${interventover.in_sede_cliente == 0}">
								<span class="label label-success pull-right">IN SEDE</span>
						  </c:when>
						  <c:when test="${interventover.in_sede_cliente == 1}">
								<span class="label label-info pull-right">PRESSO CLIENTE</span>
						  </c:when>
						    <c:when test="${interventover.in_sede_cliente == 2}">
								<span class="label label-warning pull-right">ALTRO LUOGO</span>
						  </c:when>
						  <c:otherwise>
						    <span class="label label-info">-</span>
						  </c:otherwise>
						</c:choose> 
                
 
					</li>
					
                <li class="list-group-item">
                  <b>ID Commessa</b> <a class="pull-right">${interventover.commessa}</a>
                </li>
                
                 <li class="list-group-item">
                  <b>Cliente</b> 
                  <a id="nome_sede" class="pull-right" style="padding-right:7px">${interventover.nome_cliente } </a>
                </li>
                <li class="list-group-item">
                  <b>Sede</b> 
                  <a id="nome_sede" class="pull-right" style="padding-right:7px">${interventover.nome_sede } </a>
                </li>
                <li class="list-group-item">
                  <b>Data Creazione</b> <a class="pull-right">
	
			<c:if test="${not empty interventover.data_creazione}">
   				<fmt:formatDate pattern="dd/MM/yyyy" value="${interventover.data_creazione}" />
			</c:if>
		</a>
                </li>
                <li class="list-group-item">
                  <b>Data Prevista</b> <a class="pull-right">
	
			<c:if test="${not empty interventover.data_prevista}">
   				<fmt:formatDate pattern="dd/MM/yyyy" value="${interventover.data_prevista}" />
			</c:if>
		</a>
                </li>
                <li class="list-group-item">
                  <b>Stato</b> <div class="pull-right">
                  
					<c:if test="${interventover.id_stato_intervento == 0}">
						<%-- <a href="#" class="customTooltip" title="Click per chiudere l'Intervento"  onClick="chiudiIntervento('${utl:encryptData(intervento.id)}',0,0)" id="statoa_${intervento.id}"> <span class="label label-info">${intervento.statoIntervento.descrizione}</span></a> --%>
						<a href="#" class="customTooltip" title="Click per chiudere l'Intervento"  onClick="chiudiVerIntervento('${utl:encryptData(interventover.id)}',0,0)" id="statoa_${interventover.id}"> <span class="label label-success">APERTO</span></a>
						
					</c:if>
					
					<c:if test="${interventover.id_stato_intervento == 1}">
						<a href="#" class="customTooltip" title="Click per aprire l'Intervento"  onClick="apriVerIntervento('${utl:encryptData(interventover.id)}',0,0)" id="statoa_${interventover.id}"> <span class="label label-warning">CHIUSO</span></a>
						
					</c:if>
					
					    
				</div>
                </li>
                <li class="list-group-item">
                  <b>Data Chiusura</b> <a class="pull-right">
	
			<c:if test="${not empty interventover.data_chiusura}">
   				<fmt:formatDate pattern="dd/MM/yyyy" value="${interventover.data_chiusura}" />
			</c:if>
		</a>
                </li>
                <li class="list-group-item">
                  <b>Responsabile</b> <a class="pull-right">${interventover.user_creation.nominativo}</a>
                </li>
                <li class="list-group-item">
                  <b>Verificatore</b> <a class="pull-right">${interventover.user_verificazione.nominativo}</a>
                </li>
<%--                 <li class="list-group-item">
                  <b>Riparatore</b> <a class="pull-right">${interventover.user_riparatore.nominativo}</a>
                </li> --%>
        </ul>
        
   
</div>
</div>
</div>
</div>
      
     
      
      <div class="row">
<div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati Pacchetto
	<div class="box-tools pull-right">

		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
               
                <li class="list-group-item">
                  <b>Nome pack</b>  

    <a class="pull-right">${interventover.nome_pack}</a>
		 
                </li>
               <li class="list-group-item">
                  <b>N° Strumenti Generati</b> <a class="pull-right">${interventover.nStrumentiGenerati}</a>
                </li>

                <li class="list-group-item">
                  <b>N° Strumenti Misurati</b> <a class="pull-right">
						<%-- <a href="#" onClick="callAction('strumentiMisurati.do?action=lt&id=${utl:encryptData(intervento.id)}')" class="pull-right customTooltip customlink" title="Click per aprire la lista delle Misure dell'Intervento ${interventover.id}"> ${interventover.nStrumentiMisurati}</a> --%>
					${interventover.nStrumentiMisurati}
				</a>
                </li>
                <li class="list-group-item">
                  <b>N° Strumenti Nuovi Inseriti</b> <a class="pull-right">${interventover.nStrumentiNuovi}</a>
                </li>
               
        <li class="list-group-item">
        <div class="row" id="boxPacchetti">
        <c:if test="${interventover.id_stato_intervento != 2}">
				 <div class="col-xs-12">
 				 <h4>Gestione Pack</h4>
 				 </div>
	        <div class="col-xs-4">
				<button class="btn btn-default pull-left" onClick="callAction('scaricaPacchettoVerificazione.do')"><i class="glyphicon glyphicon-download"></i> Download Pacchetto</button>&nbsp;
			   
			</div>
			<div class="col-xs-4">
			    <span class="btn btn-primary fileinput-button pull-right">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un file...</span>
		        <!-- The file input field used as target for the file upload widget -->
		        		<input accept="application/x-sqlite3,.db"  id="fileupload" type="file" name="files">
		   	 </span>
		    </div>
		    <div class="col-xs-4">
		        <div id="progress" class="progress">
		        	<div class="progress-bar progress-bar-success"></div>
		    	</div>
		    <!-- The container for the uploaded files -->
		    <div id="files" class="files"></div>
	    </div>
   		</c:if>
    </div>
     
        </li>
         <%--       <c:choose>
         <c:when test="${intervento.nStrumentiMisurati > 0 || intervento.nStrumentiNuovi > 0}"> --%>
 				   <li class="list-group-item">
 				   <h4>Download Schede</h4>
 				<button class="btn btn-default " onClick="scaricaSchedaConsegnaModal()"><i class="glyphicon glyphicon-download"></i> Download Scheda Consegna</button>
 				<button class="btn btn-info customTooltip " title="Click per aprire le schede di consegna" onClick="ShowSchedaConsegnaVerificazione('${utl:encryptData(interventover.id)}')"><i class="fa fa-file-text-o"></i> Visualizza Scheda Consegna </button>
   				</li>

       
     <%--  </c:when> --%>
<%--       <c:otherwise >
      <li class="list-group-item">
 				   <h4>Schede di Consegna</h4>
 				
 				<button class="btn btn-info customTooltip " title="Click per aprire le schede di consegna" onClick="showSchedeConsegna('${utl:encryptData(intervento.id)}')"><i class="fa fa-file-text-o"></i> Visualizza Scheda Consegna</button>
   				</li>
      </c:otherwise> 
      </c:choose>
        

 				 
       
           
       
       
       
      </c:if> --%>
     </ul>
    </div>
	</div>
</div>
</div>
      
            
      
      <div class="row">
        <div class="col-xs-12">
 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Strumenti
	<div class="box-tools pull-right">

		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

 <div class="row">
        <div class="col-xs-12">
  <table id="tabStr" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
  
 <thead><tr class="active">
 
  <th>ID</th>   
 <th>Denominazione</th>
 <th>Costruttore</th>
 <th>Modello</th>	
 <th>Matricola</th>
 <th>Tipologia</th>
 <th>Classe</th> 
 <th>Tipo</th>
 <th>Data ultima verifica</th>
 <th>Data prossima verifica</th> 
 <th>Ora prevista</th>
 <th>Luogo</th>
  <th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_strumenti_intervento}" var="strumento_int"> 
 
 
 	<tr role="row" id="${strumento_int.verStrumento.id}">

<td>${strumento_int.verStrumento.id}</td>
<td>${strumento_int.verStrumento.denominazione}</td>
<td>${strumento_int.verStrumento.costruttore}</td>
<td>${strumento_int.verStrumento.modello}</td>
<td>${strumento_int.verStrumento.matricola}</td>
<td>${strumento_int.verStrumento.tipologia.descrizione}</td>
<td>${strumento_int.verStrumento.classe }</td>
<td>${strumento_int.verStrumento.tipo.descrizione }</td>	
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${strumento_int.verStrumento.data_ultima_verifica }" /></td>
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${strumento_int.verStrumento.data_prossima_verifica }" /></td>
<td>${strumento_int.ora_prevista }</td>
<td>
<c:if test="${interventover.in_sede_cliente == 0 }">
IN SEDE
</c:if>
<c:if test="${interventover.in_sede_cliente == 1 }">
PRESSO CLIENTE
</c:if>
<c:if test="${interventover.in_sede_cliente == 2 }">
via ${strumento_int.via } ${strumento_int.civico } ${strumento_int.comune.descrizione }
</c:if>

</td>
<td>
<a class="btn btn-info" onClick="modalDettaglioVerStrumento('${strumento_int.verStrumento.id}','${strumento_int.verStrumento.famiglia_strumento.descrizione }','${strumento_int.verStrumento.freqMesi }','${strumento_int.verStrumento.denominazione }','${strumento_int.verStrumento.costruttore }','${strumento_int.verStrumento.modello }','${strumento_int.verStrumento.matricola }',
	'${strumento_int.verStrumento.classe }','${strumento_int.verStrumento.tipo.id }','${strumento_int.verStrumento.tipo.descrizione }','${strumento_int.verStrumento.data_ultima_verifica }','${strumento_int.verStrumento.data_prossima_verifica }','${strumento_int.verStrumento.um }','${strumento_int.verStrumento.portata_min_C1 }',
	'${strumento_int.verStrumento.portata_max_C1 }','${strumento_int.verStrumento.div_ver_C1 }','${strumento_int.verStrumento.div_rel_C1 }','${strumento_int.verStrumento.numero_div_C1 }',	'${strumento_int.verStrumento.portata_min_C2 }','${strumento_int.verStrumento.portata_max_C2 }',
	'${strumento_int.verStrumento.div_ver_C2 }','${strumento_int.verStrumento.div_rel_C2 }','${strumento_int.verStrumento.numero_div_C2 }','${strumento_int.verStrumento.portata_min_C3 }','${strumento_int.verStrumento.portata_max_C3 }','${strumento_int.verStrumento.div_ver_C3 }',
	'${strumento_int.verStrumento.div_rel_C3 }','${strumento_int.verStrumento.numero_div_C3 }','${strumento_int.verStrumento.anno_marcatura_ce }','${strumento_int.verStrumento.data_messa_in_servizio }','${strumento_int.verStrumento.tipologia.descrizione }')"><i class="fa fa-search"></i></a>

<c:if test="${userObj.checkRuolo('AM') || userObj.checkRuolo('RS')}">
<button class="btn btn-success  customTooltip" title="Riemetti certificato esistente" onClick="getListaCertificatiprecedenti('${strumento_int.verStrumento.id}')"><i class="fa fa-copy"></i></button>
</c:if>
</td>
	</tr>
 
	</c:forEach>
 </tbody>
 </table>  
 
 </div>
 </div>
 </div>
</div>  
</div>
</div> 
      
      
            
            
            
 <div class="row">
        <div class="col-xs-12">
 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Misure
	<div class="box-tools pull-right">

		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
 <div class="row">
        <div class="col-xs-12">
<a class="btn btn-primary pull-right" onClick="creaComunicazione()">Crea comunicazione</a>
</div>
</div><br>
 <div class="row">
        <div class="col-xs-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
  
 <thead><tr class="active">
 <th></th>
  <th style="max-width:65px" class="text-center"></th>
  <th>ID</th>   
 <th>Strumento</th>
 <th>Matricola</th>
 <th>Data Verificazione</th>
 <th>Tecnico Verificatore</th>	
 <th>Data Scadenza</th>
 <th>Data Riparazione</th>
<%--  <th>Registro</th> --%>
 <th>Numero Rapporto</th>
 <th>Numero Attestato</th>
 
 <th>Obsoleta</th>
 <th>Note Obsolescenza</th> 
 <td style="min-width:150px">Azioni</td>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_misure}" var="misura">
 
 	<tr role="row" id="${misura.id}">
 	<td></td>
 	<td class="select-checkbox"></td>
<td>${misura.id}</td>

<td>${misura.verStrumento.denominazione}</td>
<td>${misura.verStrumento.matricola}</td>
<td> <fmt:formatDate pattern="dd/MM/yyyy"  value="${misura.dataVerificazione}" />	</td>
<td>${misura.tecnicoVerificatore.nominativo }</td>
<td><fmt:formatDate pattern="dd/MM/yyyy"  value="${misura.dataScadenza}" /></td>
<td><fmt:formatDate pattern="dd/MM/yyyy"  value="${misura.dataRiparazione}" /></td>
<%-- <td>${misura.registro }</td> --%>
<td>${misura.numeroRapporto }</td>
<td>${misura.numeroAttestato }</td>
 <td><span class="label bigLabelTable <c:if test="${misura.obsoleta == 'S'}">label-danger</c:if><c:if test="${misura.obsoleta == 'N'}">label-success </c:if>">${misura.obsoleta}</span> </td>
<td>${misura.note_obsolescenza }</td> 
<td>
<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio della misura" onClick="callAction('gestioneVerMisura.do?action=dettaglio&id_misura=${utl:encryptData(misura.id)}')"><i class="fa fa-search"></i></a>

<%-- <a class="btn btn-danger customTooltip" title="Click per generare il certificato" onClick="callAction('gestioneVerMisura.do?action=crea_certificato&id_misura=${utl:encryptData(misura.id)}')"><i class="fa fa-file-pdf-o"></i></a> --%>
<c:if test="${misura.nomeFile_inizio_prova!=null && misura.nomeFile_inizio_prova!=''}">
<a class="btn btn-primary customTooltip" title="Click per scaricare l'immagine di inizio prova" onClick="callAction('gestioneVerMisura.do?action=download_immagine&id_misura=${utl:encryptData(misura.id)}&filename=${misura.nomeFile_inizio_prova}&nome_pack=${misura.verIntervento.nome_pack }')"><i class="fa fa-image"></i></a>
</c:if>
<c:if test="${misura.nomeFile_fine_prova!=null && misura.nomeFile_fine_prova!='' }">

<a class="btn btn-primary customTooltip" title="Click per scaricare l'immagine di fine prova" onClick="callAction('gestioneVerMisura.do?action=download_immagine&id_misura=${utl:encryptData(misura.id)}&filename=${misura.nomeFile_fine_prova}&nome_pack=${misura.verIntervento.nome_pack }')"><i class="fa fa-image"></i></a>
</c:if>
</td>
		
		
	</tr>
 
	</c:forEach>
 </tbody>
 </table>  
 
 </div>
 </div>
 </div>
</div>  
</div>
</div> 


		</div>
		</div>  
		</div>
		
          </div>
          
          
          <div id="myModalDownloadSchedaConsegna" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Scheda Consegna</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="myModalDownloadSchedaConsegnaContent">
 <form name="scaricaSchedaConsegnaForm" method="post" id="scaricaSchedaConsegnaForm" action="#">
        <div class="form-group">
		  <label for="notaConsegna">Consegna di:</label>
		  <textarea class="form-control" rows="5" name="notaConsegna" id="notaConsegna">${defaultNotaConsegna}</textarea>
		</div>
		
		<div class="form-group">
		  <label for="notaConsegna">Cortese Attenzione di:</label>
		  <input class="form-control" id="corteseAttenzione" name="corteseAttenzione" />
		</div>
		
      <fieldset class="form-group">
		  <label for="gridRadios">Stato Intervento:</label>
         <div class="form-check">
          <label class="form-check-label">
            <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios1" value="0" checked="checked">
            CONSEGNA DEFINITIVA
           </label>
        </div>
        <div class="form-check">
          <label class="form-check-label">
            <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios2" value="1">
            STATO AVANZAMENTO
          </label>

      </div>
    </fieldset>	     
</form>   
  		 </div>
      
    </div>
     <div class="modal-footer">

     <button class="btn btn-default pull-left" onClick="scaricaSchedaConsegnaVerificazione('${utl:encryptData(interventover.id)}')"><i class="glyphicon glyphicon-download"></i> Download Scheda Consegna</button>
   
    	
    </div>
  </div>
    </div>

</div>


<div id="myModalDettaglioVerStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalNuovoRilievo">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Dettaglio Strumento</h4>
      </div>
       <div class="modal-body">
<div class="row">
       	<div class="col-sm-3">
       		<label>Famiglia Strumento</label>
       	</div>
       	<div class="col-sm-9">
       	<input class="form-control" id="famiglia_strumento_dtl" name="famiglia_strumento_dtl" style="width:100%" disabled>
       		
       	</div>
       </div><br>
        <div class="row">
       	<div class="col-sm-3">
       		<label>Tipo</label>
       	</div>
       	<div class="col-sm-9">
       	<input class="form-control" id="tipo_ver_strumento_dtl" name="tipo_ver_strumento_dtl" style="width:100%" disabled>
       		
       	</div>
       </div><br>
        <div class="row">
       	<div class="col-sm-3">
       		<label>Tipologia</label>
       	</div>
       	<div class="col-sm-9">
       	 	<input class="form-control" id="tipologia_dtl" name="tipologia_dtl" style="width:100%" disabled>
       		
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Denominazione</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="denominazione_dtl" name="denominazione_dtl" style="width:100%" disabled>       	
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Costruttore</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="costruttore_dtl" name="costruttore_dtl" style="width:100%" disabled>       	
       	</div>
       </div><br>
       
        <div class="row">
        <div class="col-sm-3">
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="modello_dtl" name="modello_dtl" style="width:100%" disabled>       	
       	</div>
       </div><br>
       
       <div class="row">
        <div class="col-sm-3">
       		<label>Matricola</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="matricola_dtl" name="matricola_dtl" style="width:100%" disabled>       	
       	</div>
       </div><br>
       
       <div class="row">
       <div class="col-sm-3">
       		<label>Classe</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" class="form-control" id="classe_dtl" min="1" max="4" name="classe_dtl" style="width:100%" disabled>       	
       	</div>
       </div><br>
       <div class="row">
       <div class="col-sm-3">
       		<label>Unità di misura</label>
       	</div>
       	<div class="col-sm-9">
       	<input class="form-control" id="um_dtl" name="um_dtl" style="width:100%" disabled>    
       		
       		
       	</div>
       </div><br> 
       <div class="row">
       <div class="col-sm-3">
       		<label>Anno marcatura CE</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" class="form-control" id="anno_marcatura_ce_dtl" min="1900" max="2999" step="1" name="anno_marcatura_ce_dtl" style="width:100%" disabled>
       	</div>
       </div><br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Frequenza mesi</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" class="form-control" id="freq_mesi_dtl" min="1900" max="2999" step="1" name="freq_mesi_dtl" style="width:100%" disabled>
        
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data messa in servizio</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date ' id='datepicker_data_messa_in_servizio'>
               <input type='text' class="form-control input-small" id="data_messa_in_servizio_dtl" name="data_messa_in_servizio_dtl" disabled>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Ultima Verifica</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date ' id='datepicker_data_ultima_verifica_mod'>
               <input type='text' class="form-control input-small" id="data_ultima_verifica_dtl" name="data_ultima_verifica_dtl" disabled>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Prossima Verifica</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date ' id='datepicker_data_prossima_verifica_mod'>
               <input type='text' class="form-control input-small" id="data_prossima_verifica_dtl" name="data_prossima_verifica_dtl" disabled>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
         <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Min C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_min_c1_dtl" name="portata_min_c1_dtl" style="-webkit-appearance:none;margin:0;" disabled>
       	</div>
       </div> <br>    
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Max C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_max_c1_dtl" name="portata_max_c1_dtl" disabled>
       	</div>
       </div> <br>   
        <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione di verifica C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_ver_c1_dtl" name="div_ver_c1_dtl" disabled>
       	</div>
       </div> <br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione reale C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_rel_c1_dtl" name="div_rel_c1_dtl" disabled>
       	</div>
       </div> <br> 
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Divisioni C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="numero_div_c1_dtl" name="numero_div_c1_dtl" disabled>
       	</div>
       </div> <br> 
       <div id="multipla_dtl_c2">
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Min C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_min_c2_dtl" name="portata_min_c2_dtl" disabled>
       	</div>
       </div> <br>    
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Max C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_max_c2_dtl" name="portata_max_c2_dtl" disabled>
       	</div>
       </div> <br>   
        <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione di verifica C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_ver_c2_dtl" name="div_ver_c2_dtl" disabled>
       	</div>
       </div> <br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione reale C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_rel_c2_dtl" name="div_rel_c2_dtl" disabled>
       	</div>
       </div> <br> 
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Divisioni C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="numero_div_c2_dtl" name="numero_div_c2_dtl" disabled>
       	</div>
       </div> <br> 
       </div>
       <div id="multipla_dtl_c3">
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Min C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_min_c3_dtl" name="portata_min_c3_dtl" disabled>
       	</div>
       </div> <br>    
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Max C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_max_c3_dtl" name="portata_max_c3_dtl" disabled>
       	</div>
       </div> <br>   
        <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione di verifica C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_ver_c3_dtl" name="div_ver_c3_dtl" disabled>
       	</div>
       </div> <br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione reale C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_rel_c3_dtl" name="div_rel_c3_dtl" disabled>
       	</div>
       </div> <br> 
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Divisioni C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="numero_div_c3_dtl" name="numero_div_c3_dtl" disabled>
       	</div>
       </div> <br> 
                       
        </div>
        
        <div class="row">
       	<div class="col-sm-6">
       		<label>Provvedimenti di Legalizzazione</label>
       	</div>
       	<div class="col-sm-12">
       		<table id="table_legalizzazione_strumento" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Tipo provvedimento</th>
<th>Numero provvedimento</th>
<th>Data provvedimento</th>

<th>Azioni</th>

 </tr></thead>
 
 <tbody>
</tbody>
</table>
       	</div>
       </div> <br> 
        
       </div>

    </div>
  </div>

</div>




  <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Messaggio</h4>
      </div>
       <div class="modal-body">
			<div id="modalErrorDiv">
			
			</div>
   
  		 </div>
      <div class="modal-footer" id="myModalFooter">
 
       
      </div>
    </div>
  </div>
</div>






   <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" style="z-index:10000">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler riemettere il certificato selezionato?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_certificato_riemissione">
      
      <a class="btn btn-primary" onclick="riemettiCertificato($('#id_certificato_riemissione').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>




  <div id="modalListaDuplicati" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" data-keyboard="false" data-backdrop="static" >
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Lista Duplicati</h4>
      </div>
       <div class="modal-body">
        		<h4 class="modal-title" id="myModalLabel">Selezionare le misure da sovrascrivere</h4>
			<div id="listaDuplicati">
			<table id="tabLD" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">

	
			 </table>  
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">


        <button type="button" class="btn btn-danger"onclick="saveVerDuplicatiFromModal()"  >Salva</button>
      </div>
    </div>
  </div>
</div>



</section>
   
  </div>
  <!-- /.content-wrapper -->
  
  
   <div id="myModalArchivio" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 9900;">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati provvedimento legalizzazione bilance</h4>
      </div>
       <div class="modal-body">
       <div class="row">
        <div class="col-xs-12">

 

       <div id="tab_allegati_provvedimento"></div>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      <input type="hidden" id="id_provvedimento_allegato" name="id_provvedimento_allegato">
      
      <a class="btn btn-primary pull-right"  style="margin-right:5px"  onClick="$('#myModalArchivio').modal('hide')">Chiudi</a>
      
      </div>
   
  </div>
  </div>
</div>

<div id="myModalStorico" class=" modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <a type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
        <h4 class="modal-title" id="myModalLabelHeader">Seleziona il certificato da riemettere</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-sm-12">
			
      
        
 <table id="table_storico" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th></th>
<th>ID Certificato</th>
<th>ID Misura</th>
<th>Strumento</th>
<th>Matricola</th>
<th>Data misura</th>
<th>Operatore</th>
<th>Commessa</th>

 </tr></thead>
 
 <tbody>
</tbody>
</table>
</div>
		</div>

     
    </div>
          <div class="modal-footer">
 		<a class="btn btn-default pull-right"  style="margin-left:5px"onClick="modalYesOrNo()">Riemetti</a>
 		<a class="btn btn-default pull-right" onClick="$('#myModalStorico').modal('hide')">Chiudi</a>
         
         
         </div>
  </div>
</div>
</div>

	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
<!-- 	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/css/bootstrap-timepicker.css"> -->
	 <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/css/bootstrap-timepicker.css"></script> -->
	<link type="text/css" href="css/bootstrap.min.css" />
</jsp:attribute>

<jsp:attribute name="extra_js_footer">


<script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>
<script src="plugins/fileSaver/FileSaver.min.js"></script>
<script type="text/javascript" src="plugins/datejs/date.js"></script>

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<!--    <script src="plugins/iCheck/icheck.js"></script>
  <script src="plugins/iCheck/icheck.min.js"></script>  -->

 <script type="text/javascript">
 
 function riemettiCertificato(id_certificato){
	 
	 var dataObj = {};
	 dataObj.id_certificato = id_certificato;
	 dataObj.id_intervento = ${interventover.id};
	 
	
	  
	  $.ajax({
	    	  type: "POST",
	    	  url: "gestioneVerCertificati.do?action=riemetti_certificato",
	    	  data: dataObj,
	    	  dataType: "json",
	    	  success: function( data, textStatus) {
	    		  
	    		  pleaseWaitDiv.modal('hide');
	    		  $(".ui-tooltip").remove();
	    		  if(data.success)
	    		  { 
	    			 location.reload()

	    		
	    		  }else{
	    			  $('#myModalErrorContent').html("Errore nel salvataggio!");
	    			  
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
 
 
 
 function modalAllegatiProvvedimento(id_provvedimento){

		$('#id_provvedimento_allegato').val(id_provvedimento);
		// $('#tab_archivio').html("");
		 
		 dataString ="action=lista_allegati&id_provvedimento="+ id_provvedimento;
	    exploreModal("gestioneVerLegalizzazioneBilance.do",dataString,null,function(datab,textStatusb){
	    	
	    	var result = JSON.parse(datab);
	    	
	    	if(result.success){
	    		
	    		var lista_allegati = result.lista_allegati;
	    		var html = '<ul class="list-group list-group-bordered">';
	    		if(lista_allegati.length>0){
	    			for(var i= 0; i<lista_allegati.length;i++){
	          			 html= html + '<li class="list-group-item"><div class="row"><div class="col-xs-10"><b>'+lista_allegati[i].nome_file+'</b></div><div class="col-xs-2 pull-right">' 	           
	                   +'<a class="btn btn-danger btn-xs pull-right" onClick="eliminaAllegatoModal(\''+lista_allegati[i].id+'\')"><i class="fa fa-trash"></i></a>'
	       	           +'<a class="btn btn-danger btn-xs  pull-right"style="margin-right:5px" href="gestioneVerLegalizzazioneBilance.do?action=download_allegato&id_allegato='+lista_allegati[i].id+'"><i class="fa fa-arrow-down small"></i></a>'
	       	           +'</div></div></li>';
	          		}
	    		}else{
	    			 html= html + '<li class="list-group-item"> Nessun file allegato allo strumento! </li>';
	    		}
	    		
	    		$("#tab_allegati_provvedimento").html(html+"</ul>");
	    	}
	    	
	    	  $('#myModalArchivio').modal('show');
	    	
	    });
	    
	  
	}

 
 
 
 function modalYesOrNo(){

	 
 var table = $("#table_storico").DataTable();
	 
	 var str = "";
	 
	 
	 $('#table_storico tbody tr').each(function(){
		 if($(this).hasClass("selected")){
			 var td = $(this).find('td').eq(1);
			 str = str+td[0].innerText;
		 }
		
	 });
	 
	if(str == ''){
		$('#myModalErrorContent').html("Nessun certificato selezionato!")
	  	$('#myModalError').removeClass();
		$('#myModalError').addClass("modal modal-danger");	  
		$('#myModalError').modal('show');		
	}else{

		 $('#id_certificato_riemissione').val(str);
		 
		 $('#myModalYesOrNo').modal();
	}
	 
	 
	

 }
 
 
 function getListaCertificatiprecedenti(id_strumento){
	  
	  dataString ="action=certificati_precedenti&id_strumento="+ id_strumento;
	     exploreModal("gestioneVerCertificati.do",dataString,null,function(datab,textStatusb){
	   	  	
	   	  var result =datab;
	   	  
	   	  if(result.success){
	   		 
	   		  var table_data = [];
	   		  
	   		  var lista_certificati = result.lista_certificati;
	   		  
	   		  for(var i = 0; i<lista_certificati.length;i++){
	   			  var dati = {};
	   			   				 
	   			  dati.check="";
	   			  dati.id = lista_certificati[i].id;	   			
	   			  dati.id_misura = lista_certificati[i].misura.id;	   			  
	   			  dati.strumento = lista_certificati[i].misura.verStrumento.denominazione;  
	   			  dati.matricola = lista_certificati[i].misura.verStrumento.matricola;  
	   			  dati.data_misura = lista_certificati[i].misura.dataVerificazione;
	   			  dati.operatore = lista_certificati[i].misura.tecnicoVerificatore.nominativo;
	   			  dati.commessa = lista_certificati[i].misura.verIntervento.commessa
	   			 
	   			  table_data.push(dati);
	   			  
	   		  }
	   		  var t = $('#table_storico').DataTable();
	   		  
	    		   t.clear().draw();
	    		   
	    			t.rows.add(table_data).draw();
	    			t.columns.adjust().draw();
	  			
	  		  $('#myModalStorico').modal();
	  			
	   	  }
	   	  
	   	  $('#myModalStorico').on('shown.bs.modal', function () {
	   		  var t = $('#table_storico').DataTable();
	   		  
	   			t.columns.adjust().draw();
	 			
	   		})
	   	  
	     });
	  
 }
 
 
 
 
 $('#modalListaDuplicati').on('hidden.bs.modal',function(){
	
	 location.reload();
 });
 
 function creaComunicazione(){
	 
	 var table = $("#tabPM").DataTable();
	 
	 var str = "";
	 
	 
	 $('#tabPM tbody tr').each(function(){
		 if($(this).hasClass("selected")){
			 var td = $(this).find('td').eq(2);
			 str = str+td[0].innerText+";"
		 }
		
	 });
	 
	if(str == ''){
		$('#myModalErrorContent').html("Nessuna misura selezionata!")
	  	$('#myModalError').removeClass();
		$('#myModalError').addClass("modal modal-danger");	  
		$('#myModalError').modal('show');		
	}else{
		callAction('gestioneVerComunicazionePreventiva.do?action=crea_comunicazione&ids='+str)	
	}
	 
 }

 

 var columsDatatables1 = [];
 
	$("#tabPM").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    		columsDatatables1 = state.columns;
	    }
	    
	    $('#tabPM thead th').each( function () {
	    	if(columsDatatables1.length==0 || columsDatatables1[$(this).index()]==null ){columsDatatables1.push({search:{search:""}});}
	    	var title = $('#tabPM thead th').eq( $(this).index() ).text();
	    	if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables1[$(this).index()].search.search+'" type="text" /></div>');	
	    	}
	    	else if($(this).index() ==1){
	    	  	$(this).append( '<input class="pull-left" id="checkAll" type="checkbox" />');
	      }
	    	 $('#checkAll').iCheck({
	             checkboxClass: 'icheckbox_square-blue',
	             radioClass: 'iradio_square-blue',
	             increaseArea: '20%' // optional
	           }); 
	       	
	    	} );
	    
	    
	} );
	
	
	 var columsDatatables2 = [];
	 
		$("#tabStr").on( 'init.dt', function ( e, settings ) {
		    var api = new $.fn.dataTable.Api( settings );
		    var state = api.state.loaded();
		 
		    if(state != null && state.columns!=null){
		    		console.log(state.columns);
		    
		    		columsDatatables2 = state.columns;
		    }
		    
		    $('#tabStr thead th').each( function () {
		    	if(columsDatatables2.length==0 || columsDatatables2[$(this).index()]==null ){columsDatatables2.push({search:{search:""}});}
		    	var title = $('#tabStr thead th').eq( $(this).index() ).text();
		    	
			    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables2[$(this).index()].search.search+'" type="text" /></div>');	
		    	
		    	
		       	
		    	} );
		    
		    
		} );
		
		
		function modalDettaglioVerStrumento(id_strumento, famiglia_strumento, freq_mesi, denominazione, costruttore, modello, matricola, classe, id_tipo,tipo, data_ultima_verifica,
				data_prossima_verifica, um, portata_min_c1, portata_max_c1, div_ver_c1, div_rel_c1, numero_div_c1,
				portata_min_c2, portata_max_c2, div_ver_c2, div_rel_c2, numero_div_c2, portata_min_c3, portata_max_c3, div_ver_c3, div_rel_c3, numero_div_c3, anno_marcatura_ce, data_messa_in_servizio,tipologia){
			
			$('#multipla_dtl_c2').hide();
			$('#multipla_dtl_c3').hide();
			$('#denominazione_dtl').val(denominazione);
			$('#freq_mesi_dtl').val(freq_mesi);
			$('#costruttore_dtl').val(costruttore);
			$('#modello_dtl').val(modello);
			$('#matricola_dtl').val(matricola);
			$('#classe_dtl').val(classe);
			$('#anno_marcatura_ce_dtl').val(anno_marcatura_ce);
			$('#data_messa_in_servizio_dtl').val(data_messa_in_servizio);
			$('#tipo_ver_strumento_dtl').val(tipo);
			//$('#tipo_ver_strumento_dtl').change();
			$('#tipologia_dtl').val(tipologia);
		//	$('#tipologia_dtl').change();
			$('#um_dtl').val(um);
			//$('#um_dtl').change();
			$('#famiglia_strumento_dtl').val(famiglia_strumento);
			//$('#famiglia_strumento_dtl').change();
			if(data_ultima_verifica!=null && data_ultima_verifica!=""){
				  $('#data_ultima_verifica_dtl').val(Date.parse(data_ultima_verifica).toString("dd/MM/yyyy"));
			  }
			if(data_prossima_verifica!=null && data_prossima_verifica!=""){
				  $('#data_prossima_verifica_dtl').val(Date.parse(data_prossima_verifica).toString("dd/MM/yyyy"));
			  }
			if(data_messa_in_servizio!=null && data_messa_in_servizio!=""){
				  $('#data_messa_in_servizio_dtl').val(Date.parse(data_messa_in_servizio).toString("dd/MM/yyyy"));
			  }

			$('#portata_min_c1_dtl').val(portata_min_c1);
			$('#portata_max_c1_dtl').val(portata_max_c1);
			$('#div_ver_c1_dtl').val(div_ver_c1);
			$('#div_rel_c1_dtl').val(div_rel_c1);
			$('#numero_div_c1_dtl').val(numero_div_c1);
			
			if(id_tipo!='1'){
				$('#multipla_dtl_c2').show();
				$('#portata_min_c2_dtl').val(portata_min_c2);
				$('#portata_max_c2_dtl').val(portata_max_c2);
				$('#div_ver_c2_dtl').val(div_ver_c2);
				$('#div_rel_c2_dtl').val(div_rel_c2);
				$('#numero_div_c2_dtl').val(numero_div_c2);
				if(portata_max_c3>0){
					$('#multipla_dtl_c3').show();
					$('#portata_min_c3_dtl').val(portata_min_c3);
					$('#portata_max_c3_dtl').val(portata_max_c3);
					$('#div_ver_c3_dtl').val(div_ver_c3);
					$('#div_rel_c3_dtl').val(div_rel_c3);
					$('#numero_div_c3_dtl').val(numero_div_c3);
				}
				
			}
			
			
			creaTabellaLegalizzazione(id_strumento);
				
			$('#myModalDettaglioVerStrumento').modal();
		}
		  function scaricaSchedaConsegnaVerificazione(idIntervento){
			  callAction("scaricaSchedaConsegna.do?action=verificazione&verIntervento="+idIntervento,"#scaricaSchedaConsegnaForm",false);
			  $("#myModalDownloadSchedaConsegna").modal('hide');
		  }
		  
		  function ShowSchedaConsegnaVerificazione(idIntervento){
			  callAction("showSchedeConsegna.do?action=verificazione&idIntervento="+idIntervento,false, false);
		  }
		  
		  
	
    $(document).ready(function() { 
    	
    	
    	$('.select2').select2();
    	
	    	$('#fileupload').fileupload({
	            url: "caricaPacchettoVerificazione.do?id_intervento=${interventover.id}",
	            dataType: 'json',
	            maxNumberOfFiles : 10,
	            singleFileUploads: false,
	            getNumberOfFiles: function () {
	                return this.filesContainer.children()
	                    .not('.processing').length;
	            },
	            start: function(e){
	            	pleaseWaitDiv = $('#pleaseWaitDialog');
	    			pleaseWaitDiv.modal();
	            },
	            add: function(e, data) {
	                var uploadErrors = [];
	                var acceptFileTypes = /(\.|\/)(db)$/i;
	                if(data.originalFiles[0]['name'].length && !acceptFileTypes.test(data.originalFiles[0]['name'])) {
	                    uploadErrors.push('Tipo File non accettato. ');
	                }
	                if(data.originalFiles[0]['size'] > 50000000) {
	                    uploadErrors.push('File troppo grande, dimensione massima 50mb');
	                }
	                if(uploadErrors.length > 0) {
	                	
	                	$('#myModalErrorContent').html(uploadErrors.join("\n"));
						$('#myModalError').removeClass();
						$('#myModalError').addClass("modal modal-danger");
						$('#myModalError').modal('show');
	                } else {
	                    data.submit();
	                }
	        	},
	            done: function (e, data) {
					
	            	pleaseWaitDiv.modal('hide');
	            	
	            	if(data.result.success)
					{
						
	            		/* $('#myModalErrorContent').html(data.result.messaggio);
						$('#myModalError').removeClass();
						$('#myModalError').addClass("modal modal-success");						
						$('#myModalError').modal('show');
						
						$('#myModalError').on('hidden.bs.modal', function(){
							location.reload();
						});
						
						 */
						createVerLDTable(data.result.duplicate, data.result.messaggio);
					
					}else{
						
						$('#myModalErrorContent').html(data.result.messaggio);
						$('#myModalError').removeClass();
						$('#myModalError').addClass("modal modal-danger");
						$('#report_button').show();
	      				$('#visualizza_report').show();
						$('#myModalError').modal('show');						
						
						
						$('#progress .progress-bar').css(
			                    'width',
			                    '0%'
			                );
		               // $('#files').html("ERRORE SALVATAGGIO");
					}
	
	
	            },
	            fail: function (e, data) {
	            	pleaseWaitDiv.modal('hide');
	            	$('#files').html("");
	            	var errorMsg = "";
	                $.each(data.messages, function (index, error) {
	
	                	errorMsg = errorMsg + '<p>ERRORE UPLOAD FILE: ' + error + '</p>';
	           
	
	                });

	                $('#myModalErrorContent').html(errorMsg);
	                
					$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					$('#report_button').show();
      				$('#visualizza_report').show();
					$('#myModalError').modal('show');

					$('#progress .progress-bar').css(
		                    'width',
		                    '0%'
		                );
	            },
	            progressall: function (e, data) {
	                var progress = parseInt(data.loaded / data.total * 100, 10);
	                $('#progress .progress-bar').css(
	                    'width',
	                    progress + '%'
	                );
	
	            }
	        }).prop('disabled', !$.support.fileInput)
	            .parent().addClass($.support.fileInput ? undefined : 'disabled');
	    	
	    	
	    	table = $('#tabPM').DataTable({
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
  	      pageLength: 25,
	    	      paging: true, 
	    	      ordering: true,
	    	      info: true, 
	    	      searchable: false, 
	    	      targets: 0,
	    	      responsive: true,
	    	      scrollX: false,
	    	      stateSave: true,
	    	      order:[[2,'desc']],
	    	      select: {		
	    	    	  
			        	style:    'multi+shift',
			        	selector: 'td:nth-child(2)'
			    	}, 
	    	      columnDefs: [
	    	    	  { className: "select-checkbox", targets: 1,  orderable: false },
					  { responsivePriority: 1, targets: 0 },
	    	          { responsivePriority: 2, targets: 13 }
	    	               ],
	             
	    	               buttons: [ {
	    	                   extend: 'copy',
	    	                   text: 'Copia',
	    	                   /* exportOptions: {
		                       modifier: {
		                           page: 'current'
		                       }
		                   } */
	    	               },{
	    	                   extend: 'excel',
	    	                   text: 'Esporta Excel',
	    	                   /* exportOptions: {
	    	                       modifier: {
	    	                           page: 'current'
	    	                       }
	    	                   } */
	    	               },
	    	               {
	    	                   extend: 'colvis',
	    	                   text: 'Nascondi Colonne'
	    	                   
	    	               }
	    	                         
	    	                          ]
	    	    	
	    	    });
			table.buttons().container().appendTo( '#tabPM_wrapper .col-sm-6:eq(1)');
	 	    $('.inputsearchtable').on('click', function(e){
	 	       e.stopPropagation();    
	 	    });

	table.columns().eq( 0 ).each( function ( colIdx ) {
	  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
	      table
	          .column( colIdx )
	          .search( this.value )
	          .draw();
	  } );
	} ); 
		table.columns.adjust().draw();
		

	$('#tabPM').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		});
	});

		
		
		var tab = $('#tabStr').DataTable({
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
  	      pageLength: 25,
	    	      paging: true, 
	    	      ordering: true,
	    	      info: true, 
	    	      searchable: false, 
	    	      targets: 0,
	    	      responsive: true,
	    	      scrollX: false,
	    	      stateSave: true,
	    	      order:[[0,'desc']],
	    	      
	    	      columnDefs: [
	    	    	 
					  { responsivePriority: 1, targets: 0 },
					  { responsivePriority: 2, targets: 12 },
	    	          
	    	               ],
	             
	    	               buttons: [ {
	    	                   extend: 'copy',
	    	                   text: 'Copia',
	    	                   /* exportOptions: {
		                       modifier: {
		                           page: 'current'
		                       }
		                   } */
	    	               },{
	    	                   extend: 'excel',
	    	                   text: 'Esporta Excel',
	    	                   /* exportOptions: {
	    	                       modifier: {
	    	                           page: 'current'
	    	                       }
	    	                   } */
	    	               },
	    	               {
	    	                   extend: 'colvis',
	    	                   text: 'Nascondi Colonne'
	    	                   
	    	               }
	    	                         
	    	                          ]
	    	    	
	    	    });
		tab.buttons().container().appendTo( '#tabStr_wrapper .col-sm-6:eq(1)');
	 	    $('.inputsearchtable').on('click', function(e){
	 	       e.stopPropagation();    
	 	    });

	 	   tab.columns().eq( 0 ).each( function ( colIdx ) {
	  $( 'input', tab.column( colIdx ).header() ).on( 'keyup', function () {
		  tab
	          .column( colIdx )
	          .search( this.value )
	          .draw();
	  } );
	} ); 
		tab.columns.adjust().draw();
		

	$('#tabStr').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})
	       	 
		
		
		
		
		
		  
		

 
    });  
	
	
	
	tabella_leg_strumento = $('#table_legalizzazione_strumento').DataTable({
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
	        pageLength: 25,
	        "order": [[ 2, "desc" ]],
		      paging: false, 
		      ordering: false,
		      info: false, 
		      searchable: false, 
		      targets: 0,
		      responsive: true,  
		      scrollX: false,
		      stateSave: false,	
		      "searching": false,
		      columns : [

		      	{"data" : "id"},
	
		      	{"data" : "tipo_provvedimento"},
		      	{"data" : "numero_provvedimento"},
		      	{"data" : "data_provvedimento"},

		      	{"data" : "azioni"}
		       ],	
		           
		      columnDefs: [
		    	  
		    	  { responsivePriority: 1, targets: 1 },
		    	
		    	  ],
		    	  
		     	          
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
	
	
   	$('#checkAll').on('ifChecked', function (ev) {

		$("#checkAll").prop('checked', true);
		table.rows().deselect();
		var allData = table.rows({filter: 'applied'});
		table.rows().deselect();
		i = 0;
		table.rows({filter: 'applied'}).every( function ( rowIdx, tableLoop, rowLoop ) {
		    //if(i	<maxSelect){
				 this.select();
		   /*  }else{
		    		tableLoop.exit;
		    }
		    i++; */
		    
		} );
    });  
  	
	$('#checkAll').on('ifUnchecked', function (ev) {

		
			$("#checkAll").prop('checked', false);
			table.rows().deselect();
			var allData = table.rows({filter: 'applied'});
			table.rows().deselect();

	  	});
	
	
	
	
	
	
	t = $('#table_storico').DataTable({
		language: {
	        	emptyTable : 	"Non sono presenti documenti antecedenti",
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
        pageLength: 25,
        "order": [[ 0, "desc" ]],
	      paging: false, 
	      ordering: true,
	      info: false, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,  
	      scrollX: false,
	      stateSave: true,	
	      select: {		
	    	  
	        	style:    'single',
	        	selector: 'td:nth-child(1)'
	    	}, 
	      columns : [
	    	{"data" : "check"},
	      	{"data" : "id"},
	      	{"data" : "id_misura"},
	      	{"data" : "strumento"},
	      	{"data" : "matricola"},
	      	{"data" : "data_misura"},
	      	{"data" : "operatore"},
	      	{"data" : "commessa"}
	       ],	
	           
	      columnDefs: [
	    	  
	    	  { className: "select-checkbox", targets:  0, orderable: false },
	    	  
	    	  
	               ], 	        
  	      buttons: [   
  	          {
  	            extend: 'colvis',
  	            text: 'Nascondi Colonne'  	                   
 			  } ]
	               
	    });
	
	t.buttons().container().appendTo( '#table_storico_wrapper .col-sm-6:eq(1)');
 	    $('.inputsearchtable').on('click', function(e){
 	       e.stopPropagation();    
 	    });

 	     t.columns().eq( 0 ).each( function ( colIdx ) {
  $( 'input', t.column( colIdx ).header() ).on( 'keyup', function () {
      t
          .column( colIdx )
          .search( this.value )
          .draw();
  } );
} );  
	
    });

	
	
   
	
	
	
 	       	 $('#myModalError').on('hidden.bs.modal', function (e) {
	       		if($('#myModalError').hasClass('modal-success')){
	     			location.reload();
	     		 }
	        	}); 

	       	 

	   

  </script>
</jsp:attribute> 
</t:layout>







