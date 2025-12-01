<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Lista Offerte
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Offerte
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">


<!--  <a class="btn btn-primary pull-right" onClick="modalNuovaIntervento()"><i class="fa fa-plus"></i> Nuova Intervento</a> --> 
<a class="btn btn-primary pull-left" onClick="listaClienti()">Lista Clienti</a> 
<a class="btn btn-primary pull-right" onClick="modalNuovaOfferta()"><i class="fa fa-plus"></i> Nuova Offerta</a> 
	<a class="btn btn-primary pull-right" style="margin-right:5px" onClicK="modalNuovoCliente()" ><i class="fa fa-plus"></i> Nuovo Cliente</a>
	<a class="btn btn-primary pull-right" style="margin-right:5px" onClicK="inviaOrdine()" ><i class="fa fa-plus"></i> Invia Ordine</a>


</div>

</div><br>

<div class="row">
<div class="col-xs-12">

<!-- <a class="btn btn-primary pull-right" onclick="$('#modalRapporto').modal()">Crea Rapporto</a> -->

 <div class="col-xs-12" id="divFiltroDate" style="">

						<div class="form-group">
						        <label for="datarange" class="control-label">Filtro Data Offerta:</label>
								<div class="row">
						     		<div class="col-md-3">
						     		<div class="input-group">
				                    		 <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
				                    		<input type="text" class="form-control" id="datarange" name="datarange" value=""/>
				                  	</div>
								    </div>
								     <div class="col-md-9">
 				                      	<button type="button" class="btn btn-info" onclick="filtraDataOfferta()">Filtra </button>
 				            
 				                      	
				                   		  <button class="btn btn-primary btnFiltri" id="btnTutti" onClick="location.reload()">Reset</button> 
 				                
 								</div>
  								</div>
						   </div> 


	</div>


</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabOfferte" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th style="max-width:40px">ID</th>
<th>Numero Offerta</th>
<th>Cliente</th>
<th>Sede</th>
<th>Data</th>
<th>Importo</th>
<th>Utente</th>
<th>Stato</th>
<th>Commessa</th>
<th>Note</th>
<th style="">Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_offerte }" var="offerta" varStatus="loop">
 	
 	<c:if test="${offerta.stato == 1 }">
 	 	<tr id="row_${offerta.id }" style="background-color:#F7F688" class="riga">
</c:if>

 	<c:if test="${offerta.stato == 2 }">
 	 	<tr id="row_${offerta.id }" style="background-color:#90EE90" class="riga">
</c:if>

	<td>${offerta.id }</td>	
	<td>${offerta.n_offerta }</td>	
	
	<td>${offerta.nome_cliente }</td>

	<td>${offerta.nome_sede }</td>
	<td> <fmt:formatDate value="${offerta.data_offerta }" pattern="dd/MM/yyyy" /></td>
	<td class="importo">${offerta.importo }</td>
	<td>${offerta.utente.nominativo }</td>
	<td class="stato"><c:if test="${offerta.stato==1 }"> <!-- <span class="label label-warning"> -->DA APPROVARE<!-- </span> --></c:if>
	<c:if test="${offerta.stato==2 }"> <!-- <span class="label label-success"> -->APPROVATA<!-- </span> --></c:if>
	</td>
	<td></td>
	<td>${offerta.note }</td>
	<td>
<a class="btn btn-info customTooltip" onClicK="dettaglioOfferta('${offerta.id }')" title="Dettaglio offerta"><i class="fa fa-search"></i></a>
<c:if test="${userObj.checkRuolo('AM') || userObj.checkRuolo('VE')}">

<c:if test="${offerta.stato ==1 }">
<a class="btn btn-primary customTooltip" onClicK="modalCambioStato('${offerta.id }', '${offerta.stato}')" title="Cambia stato offerta"><i class="glyphicon glyphicon-refresh"></i></a>
</c:if>
</c:if>
	</td>
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
 
 
 <div class="row">
<div class="col-sm-9">
</div>
<div class="col-sm-3">
<label>Tot. Importi</label>
<input class="form-control" id="tot_importi" readonly>
</div>
</div>
</div>
</div>


</div>

 
</div>
</div>
</div>

</section>

  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler cambiare lo stato dell'offerta?
      	</div>
      <div class="modal-footer">
      <a class="btn btn-primary" onclick="cambiaStatoOfferta()" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>

<form id="formNOfferta" >
 <div id="modalNOfferta" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel"></h4>
      </div>
       <div class="modal-body">       
       <div class="row">
        <div class="col-xs-12">
        <LABEL>
        Inserisci il numero offerta</LABEL>
        </div></div><br>
        <div class="row">
        <div class="col-xs-12">
        <input class="form-control" id="n_offerta" type="text" pattern="^STI_OFF_\d{2}/\d{4}$" title="Formato richiesto: STI_OFF_25/0001" required>
        </div>
       </div>
      
       
      	
      	</div>
      <div class="modal-footer">
      
      <button class="btn btn-primary" type="submit" >Salva</button>
      </div>
    </div>
  </div>

</div>
</form>


  <div id="modalListaClienti" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Lista Clienti</h4>
      </div>
       <div class="modal-body"> 
       
       <table id="tabClienti" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>Cliente</th>
<th>Indirizzo</th>
 </tr></thead>
 
 <tbody>
 

 </tbody>
 </table>  
             
             
      	
      	</div>
      <div class="modal-footer">

		<a class="btn btn-primary" onclick="$('#modalListaClienti').modal('hide')" >Chiudi</a>
      </div>
    </div>
  </div>

</div>


<form id="nuovaOffertaForm" name="nuovaOffertaForm">
<div id="myModalNuovaOfferta" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Offerta</h4>
      </div>
       <div class="modal-body">

       	
              <div class="row">
        
       	<div class="col-sm-3">
       		<label>Cliente</label>
       	</div>
       	 <div class="col-md-6" style="display:none">  
       	 
                  <label>Cliente</label>
               <select name="cliente_appoggio" id="cliente_appoggio" class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required disabled>
                
                      <c:forEach items="${lista_clienti}" var="cliente">
                     
                           <%-- <option value="${utl:encryptData(cliente.__id)}">${cliente.nome}</option> --%>
                           <option value="${cliente.idEncrypted}">${cliente.nome}</option>  
                         
                     </c:forEach>

                  </select> 
                
        </div> 
       	
       	<div class="col-sm-9">      
       	  	
      <input id="cliente" name="cliente" class="form-control" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Sede</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
              <select id="sede" name="sede" class="form-control select2"  data-placeholder="Seleziona Sede..." aria-hidden="true" data-live-search="true" style="width:100%" disabled>
       <option value=""></option>
      	<c:forEach items="${lista_sedi}" var="sd">
      	<%-- <option value="${utl:encryptData(sd.__id)}_${utl:encryptData(sd.id__cliente_)}">${sd.descrizione} - ${sd.indirizzo} - ${sd.comune} (${sd.siglaProvincia}) </option> --%>
      	<option value="${sd.id_encrypted}_${sd.id_cliente_encrypted}">${sd.descrizione} - ${sd.indirizzo} - ${sd.comune} (${sd.siglaProvincia}) </option>
      	</c:forEach>
      
      </select>
       			
       	</div>       	
       </div><br>
       
     <div class="row">
       
       	<div class="col-sm-3">
       		<label>Lista Articoli</label>
       	</div></div><br>
       	 <div class="row">
       	<div class="col-sm-12">      
       	  	
        
   <table id="tabArticoli" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th><!-- <input id="selectAlltabPM" type="checkbox" />  --></th>
 <th>ID Articolo</th>
 <th>Descrizione</th>
  <th>Importo</th>
  <th>Sconto</th>
  <th>Quantit&agrave;</th>
   </tr></thead>
 
 <tbody>
 

 
 <c:forEach items="${lista_articoli}" var="articolo" varStatus="loop">
 

	 <tr role="row" id="${articolo.ID_ANAART}">

<td></td>
	<td>${articolo.ID_ANAART}</td>


<td>${articolo.DESCR}</td>
<td>${articolo.importo}</td>
<td></td>
<td></td>
	</tr>
	
	 
	</c:forEach>
 
	
 </tbody>
 </table>  
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       

       	<div class="col-xs-3">
       	<label>Note</label>
       	</div>
       	 	<div class="col-xs-9">
       	<textarea rows="3" style="width:100%" id="note" name="note" class="form-control"></textarea>
       	</div>
       	</div><br>
       
                <div class="row">
       

       	<div class="col-xs-4">
			<span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Carica Immagini ...</span>
				<input accept=".jpg,.png"  id="fileupload_img" name="fileupload_img" type="file" multiple required>
		       
		   	 </span>
		   	</div>
		 <div class="col-xs-8">
		 <label id="label_img"></label>
		 </div> 
       	
       	</div>
   </div>
  		 
      <div class="modal-footer">
      <input type="hidden" id="id_articoli" name="id_articoli">

		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>






</form>





<form id="nuovoClienteForm" name="nuovoClienteForm">
<div id="myModalNuovoCliente" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Cliente</h4>
      </div>
       <div class="modal-body">

       
              <div class="row">
        
       	<div class="col-sm-3">
       		<label>Ragione Sociale</label>
       	</div>

       	
       	<div class="col-sm-9">      
       	  	
      <input id="ragione_sociale" name="ragione_sociale" class="form-control" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Indirizzo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
            <input id="indirizzo" name="indirizzo" class="form-control" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Città</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
            <select id="citta" name="citta" class="form-control select2" data-placeholder="Seleziona Città..." style="width:100%" >
            <option value=""></option>
            <c:forEach items="${lista_comuni }" var="comune">
            <option value="${comune.cap }_${comune.provincia }_${comune.descrizione }_${comune.regione}">${comune.descrizione }</option>
            </c:forEach>
            </select>
       			
       	</div>       	
       </div><br>
       

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cap</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
            <input id="cap" name="cap" class="form-control" style="width:100%" readonly>
       			
       	</div>       	
       </div><br>
       
     
       
           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Provincia</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
           
            <input id="provincia" name="provincia"
       class="form-control"
       style="width:100%;text-transform: uppercase;"
       pattern="[A-Za-z]{2}"
       minlength="2"
       maxlength="2"
       title="Inserisci la sigla di due lettere della provincia (es. RM, MI, NA)" readonly
       >
       			
       	</div>       	
       </div><br>
       
                 <div class="row">
       
       	<div class="col-sm-3">
       		<label>Telefono</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
            <input type="tel"
       id="telefono"
       name="telefono"
       class="form-control"
       style="width:100%;"
       pattern="^(\+39)?\d{6,12}$"
       title="Inserisci un numero di telefono valido (può iniziare con +39 e contenere da 6 a 12 cifre)"
       >
       			
       	</div>       	
       </div><br>
       
       
           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Email</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
   
            <input type="email" 
       id="email" 
       name="email"
       class="form-control"
       style="width:100%;"
       pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
       title="Inserisci un indirizzo email valido (esempio: nome@dominio.it)"
       >
       			
       	</div>       	
       </div><br>
       
           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Partita iva</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="partita_iva" name="partita_iva"
       class="form-control"
       style="width:100%"
       pattern="\d{11}"
       minlength="11"
       maxlength="11"
       title="La Partita IVA deve contenere esattamente 11 cifre numeriche"
       required>
       			
       	</div>       	
       </div><br>
       
              <div class="row">
       
       	<div class="col-sm-3">
       		<label>Codice fiscale</label>
       	</div>
       	<div class="col-sm-9">      
     
           <input id="codice_fiscale" name="codice_fiscale"
       class="form-control"
       style="width:100%; text-transform: uppercase;"
       pattern="[A-Za-z0-9]{11,16}"
       minlength="11"
       maxlength="16"
       title="Il Codice Fiscale può contenere solo numeri e lettere (da 11 a 16 caratteri)"
       >
       			
       	</div>       	
       </div><br>
       
      <div class="row">
  <div class="col-sm-3 d-flex align-items-center">
    <label class="form-check-label me-2" for="toggleSede">
      <strong>Aggiungi Sede</strong>
    </label>
      <div class="col-sm-9">
        <label class="switch">
          <input type="checkbox" id=toggleSede onclick="showHideSede()">
          <span class="slider round"></span>
        </label>
      </div>

  </div>
</div><br>
       
       <div id="content_sede" style="display:none"> 
    
                    <div class="row">
       
       	<div class="col-sm-3">
       		<label>Denominazione Sede</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
            <input id="denominazione_sede" name="denominazione_sede" class="form-control" style="width:100%" >
       			
       	</div>       	
       </div><br>

                           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Indirizzo Sede</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
            <input id="indirizzo_sede" name="indirizzo_sede" class="form-control" style="width:100%" >
       			
       	</div>       	
       </div><br>
                           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Città Sede</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
     
               <select id="citta_sede" name="citta_sede" class="form-control select2" data-placeholder="Seleziona Città..." style="width:100%">
            <option value=""></option>
            <c:forEach items="${lista_comuni }" var="comune">
            <option value="${comune.cap }_${comune.provincia }_${comune.descrizione }_${comune.regione}">${comune.descrizione }</option>
            </c:forEach>
            </select>
       			
       	</div>       	
       </div><br>
                           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cap Sede</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
            <input id="cap_sede" name="cap_sede" class="form-control" style="width:100%" readonly>
       			
       	</div>       	
       </div><br>
       
       
                                  <div class="row">
       
       	<div class="col-sm-3">
       		<label>Provincia Sede</label>
       	</div>
       	<div class="col-sm-9">      
 
            
<input id="provincia_sede" name="provincia_sede"
       class="form-control"
       style="width:100%;text-transform: uppercase;"
       pattern="[A-Za-z]{2}"
       minlength="2"
       maxlength="2"
       title="Inserisci la sigla di due lettere della provincia (es. RM, MI, NA)"
       readonly
       >
       			
       	</div>       	
       </div><br>
               </div>
   </div>
  		 
      <div class="modal-footer">

		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>




</form>







<div id="myModalDettaglioOfferta" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Dettaglio Offerta</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cliente</label>
       	</div>

       	
       	<div class="col-sm-9">      
     
       <input id="cliente_dtl" name="cliente_dtl" class="form-control"  aria-hidden="true"  style="width:100%" readonly>
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Sede</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
              <input id="sede_dtl" name="sede_dtl" class="form-control"  aria-hidden="true"  style="width:100%" readonly>

       	</div>       	
       </div><br>
       
     <div class="row">
       
       	<div class="col-sm-3">
       		<label>Lista Articoli</label>
       	</div></div><br>
       	 <div class="row">
       	<div class="col-sm-12">      
       	  	
        
   <table id="tabDettaglio" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

 <th>ID Articolo</th>
 <th>Descrizione</th>
  <th>Importo</th>
  <th>Quantit&agrave;</th>
   </tr></thead>
 
 <tbody>
 


	
 </tbody>
 </table>  
       			
       	</div>       	
       </div>
                       <div class="row">
                       <div class="col-xs-9">
                       </div>
       

       	<div class="col-xs-3">
       	<label>Importo Tot.</label>
       	<input id="importo_tot" class="form-control pull-right" readonly>
       	</div>
       	</div><br>
       	
       	<div class="row">
       

       	<div class="col-xs-3">
       	<label>Note</label>
       	</div>
       	 	<div class="col-xs-9">
       	<textarea rows="3" style="width:100%" id="note_dtl" name="note_dtl" readonly class="form-control"></textarea>
       	</div>
       	</div><br>
       
       
       
                <div class="row">
       

       	<div class="col-xs-12">
			<label>Immagini offerta (click per il download)</label><br>
			<div id="content_immagini"></div>

<!-- Popup di anteprima -->
<div id="preview_popup" style="display:none; position:absolute; z-index:1000; pointer-events:none;"">
    <img id="preview_img" src="" style="max-width:300px; max-height:300px; border:2px solid #444; border-radius:6px; background:#fff; box-shadow:0 2px 10px rgba(0,0,0,0.3);" />
</div>
		   	</div>
		 
       	
       	</div>
   </div>
  		 
      <div class="modal-footer">
      <input type="hidden" id="id_articoli" name="id_articoli">

		
       
      </div>
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
	<link type="text/css" href="css/bootstrap.min.css" />

<style>
      .img-container {
            max-width: 200px;
            max-height: 200px;
            overflow: hidden;
        }
        .img-container img {
            width: 100%;
            height: auto;
        }
        
        .table th input {
    min-width: 45px !important;
}


 #image-popup{
  position: fixed;
  display: none;
  top: 20px;
  right: 20px;
  width: 400px;
   max-height: calc(100vh - 40px);
  background: #fff;
  border: 1px solid #ccc;
  border-radius: 8px;
  padding: 6px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.25);
  z-index: 9999;
}

#image-popup img{
  width: 100%;
  height: auto;
  display: block;
  border-radius: 6px;
}


.switch {
  position: relative;
  display: inline-block;
  width: 50px;
  height: 28px;
}

.switch input {
  opacity: 0;
  width: 0;
  height: 0;
}

/* Slider */
.slider {
  position: absolute;
  cursor: pointer;
  top: 0; left: 0;
  right: 0; bottom: 0;
  background-color: #ccc;
  transition: .4s;
  border-radius: 28px;
}

.slider:before {
  position: absolute;
  content: "";
  height: 22px;
  width: 22px;
  left: 3px;
  bottom: 3px;
  background-color: white;
  transition: .4s;
  border-radius: 50%;
}

input:checked + .slider {
  background-color: #2196F3;
}

input:checked + .slider:before {
  transform: translateX(22px);
}
#myModalNuovoCliente {
  transform: none !important;
}

</style>
</jsp:attribute>

<jsp:attribute name="extra_js_footer">

<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">


function salvaClienteSede(){
	
	
	var newOption = new Option($('#ragione_sociale').val(), 0, false, false);
	
	

	$('#cliente_appoggio').append(newOption).trigger('change');
	options =  $('#cliente_appoggio option').clone();
	initSelect2('#cliente',null, '#myModalNuovaOfferta');
	
	setTimeout(function() {
		
		$('#cliente').val('0');
		$('#cliente').change()
		
		/* $('#cliente option[value="'+0 +'"]').prop("selected", true) */
		
		$('#myModalNuovoCliente').modal('hide');
		}, 200);
	
	
	

	
	
}


function modalNuovoCliente(){
	
	$('#myModalNuovoCliente').modal();
	
}

function modalNuovaOfferta(){

	  
	  if (!$('#cliente').hasClass('select2-hidden-accessible')) {
	      
			pleaseWaitDiv = $('#pleaseWaitDialog');
			  pleaseWaitDiv.modal();
	callAjax(null, "gestioneVerOfferte.do?action=clienti_sedi", function(data){
	
		if(data.success){
			 var opt_clienti=[];
			 var opt_sedi=[];
		
			 var lista_clienti = data.lista_clienti
			 var lista_sedi = data.lista_sedi
			
		
		
		     for(var i = 0; i<lista_clienti.length;i++){
		 			
			 opt_clienti.push("<option value = '"+lista_clienti[i].idEncrypted+"'>"+lista_clienti[i].nome+"</option>");
			
		     }
		
			 opt_sedi.push(" <option value=''></option>");
		     for(var i = 0; i<lista_sedi.length;i++){
		    	 
		    	 opt_sedi.push("<option value = '"+lista_sedi[i].id_encrypted+"_"+lista_sedi[i].id_cliente_encrypted+"'>"+lista_sedi[i].descrizione +" - "+ lista_sedi[i].indirizzo+ " - "+ lista_sedi[i].comune +" ("+lista_sedi[i].siglaProvincia+")</option>");
				
			     }
		     
			 $('#cliente_appoggio').html(opt_clienti);
			 $('#sede').html(opt_sedi);
			 
			 
			  $('#sede').select2();
			  options =  $('#cliente_appoggio option').clone();
		    	initSelect2('#cliente',null, '#myModalNuovaOfferta');
		    	
		    	
		    	 pleaseWaitDiv.hide();
		    	$('#myModalNuovaOfferta').modal();
		    	
		   
		  	 
		}
		
	});
	
	    }else{
	    	
	    	$('#myModalNuovaOfferta').modal();
	    }

	
}





$('#fileupload_immagine_offerta').change(function(){
	$('#label_immagine_offerta').html($(this).val().split("\\")[2]);
	 
 });


$('#fileupload_carta_circolazione').change(function(){
	$('#label_carta_circolazione').html($(this).val().split("\\")[2]);
	 
 });
 
 
$('#fileupload_immagine_offerta_mod').change(function(){
	$('#label_immagine_offerta_mod').html($(this).val().split("\\")[2]);
	 
 });


$('#fileupload_carta_circolazione_mod').change(function(){
	$('#label_carta_circolazione_mod').html($(this).val().split("\\")[2]);
	 
 });

function eliminaOfferta(){
	
	dataObj = {};
	
	dataObj.id_offerta_elimina = $('#id_offerta_elimina').val();
	
	callAjax(dataObj, "gestioneParcoAuto.do?action=elimina_offerta");
}


var columsDatatables = [];

 $("#tabOfferte").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabOfferte thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabOfferte thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    //	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

		    	if($(this).index() == 0){
	 				$(this).append( '<div><input class="inputsearchtable"  style="width:15px !important" type="text" /></div>');
	 			}else{
	 				$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');	
	 			}
    	  
    	} );
    
    

} );
 
 
 $("#tabArticoli").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	   

	    $('#tabArticoli thead th').each( function () {
	 
	    	  var title = $('#tabArticoli thead th').eq( $(this).index() ).text();
	    	


			    	if($(this).index() > 0){
		 				
		 				$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');	
		 			}
	    	  
	    	} );
	    
	    

	} );
 

 
 
 function showHideSede(){
	 
	 const stato = document.getElementById("toggleSede").checked ? "1" : "0";
	 
	if(stato == "1"){
		$('#content_sede').show()
		$('#denominazione_sede').attr("required", true);
		$('#indirizzo_sede').attr("required", true);
		$('#citta_sede').attr("required", true);
		$('#cap_sede').attr("required", true);
		$('#provincia_sede').attr("required", true);
	}else{
		$('#content_sede').hide()
		$('#denominazione_sede').attr("required", false);
		$('#indirizzo_sede').attr("required", false);
		$('#citta_sede').attr("required", false);
		$('#cap_sede').attr("required", false);
		$('#provincia_sede').attr("required", false);
	}
	 
 }

 
/*  $('#myModalNuovoCliente').on('shown.bs.modal', function () {
	  $('#citta').select2({
	    dropdownParent: $('#myModalNuovoCliente'),
	    width: '100%'
	  });
	  
	  $('#citta_sede').select2({
		    dropdownParent: $('#myModalNuovoCliente'),
		    width: '100%'
		  });
	});
 */

 


	
	
	$(function() {
		  // Salva la funzione originale (una volta sola)
		  var enforceModalFocusFn = $.fn.modal.Constructor.prototype.enforceFocus;

		  // Disattiva lenforceFocus di Bootstrap per tutta la durata della modale
		  $('#myModalNuovoCliente').on('show.bs.modal', function() {
		    $.fn.modal.Constructor.prototype.enforceFocus = function() {};
		  });

		  // Ripristina il comportamento originale quando la modale è chiusa
		  $('#myModalNuovoCliente').on('hidden.bs.modal', function() {
		    $.fn.modal.Constructor.prototype.enforceFocus = enforceModalFocusFn;
		  });

		  // Inizializza le select al momento dellapertura della modale
		  $('#myModalNuovoCliente').on('shown.bs.modal', function() {
		    $('#citta').select2({
		      dropdownParent: $('body'),
		      width: '100%'
		    });
		  });

		  $('#citta_sede').select2({
		        dropdownParent: $('body'),
		        width: '100%'
		      });
		  
		  // Mostra la sezione nascosta e inizializza anche quella Select2
	

		  // Quando si apre un select2, forza il focus sul campo ricerca
		  $(document).on('select2:open', function() {
		    let searchField = document.querySelector('.select2-container--open .select2-search__field');
		    if (searchField) {
		      setTimeout(() => searchField.focus(), 10);
		    }
		  });
		});

$(document).ready(function() {
 
	$('#toggleSede').iCheck('destroy');
	
        $('.dropdown-toggle').dropdown();

/* 	$('#citta').select2({
        dropdownParent: $('#myModalNuovoCliente')
    });	
	 	$('#citta_sede').select2({
        dropdownParent: $('#myModalNuovoCliente')
    });	  */
  		
/*     $('#citta', ).select2({
        dropdownParent: $('#myModalNuovoCliente')
    }); 
     */

     
     var enforceModalFocusFn = $.fn.modal.Constructor.prototype.enforceFocus;

  // Disattiva enforceFocus di Bootstrap (rende cliccabile la searchbox Select2)
  $.fn.modal.Constructor.prototype.enforceFocus = function() {};

  // Inizializza Select2 normalmente
  $('#citta, #citta_sede').select2({
    dropdownParent: $('body'),
    width: '100%'
  });

  // Quando chiudi la modale, puoi ripristinarlo (opzionale)
  $('#myModalNuovoCliente').on('hidden.bs.modal', function() {
    $.fn.modal.Constructor.prototype.enforceFocus = enforceModalFocusFn;
  });

 	     table = $('#tabOfferte').DataTable({
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
 		        "order": [[ 0, "desc" ]],
 			      paging: true, 
 			      ordering: true,
 			      info: true, 
 			      searchable: true, 
 			      targets: 0,
 			      responsive: true,
 			      scrollX: false,
 			      stateSave: true,	
 			           
 			      columnDefs: [
 			    	  
 			    	  { responsivePriority: 1, targets: 5 },
 			    	  
 			    	  
 			               ], 	        
 		  	      buttons: [   
 		  	          {
 		  	            extend: 'colvis',
 		  	            text: 'Nascondi Colonne'  	                   
 		 			  } ]
 			               
 			    });
 		
 		
 	     
  
  		
     
		table.buttons().container().appendTo( '#tabOfferte_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabOfferte').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	tabArticoli = $('#tabArticoli').DataTable({
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
        pageLength: 100,
	      paging: false, 
	      ordering: true,
	      info: true, 
	      searchable: false,
	      searching: false,
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	    stateSave: false,
	    select: {
	      	style:    'multi+shift',
	      	selector: 'td:nth-child(1)'
	  	},
	      columnDefs: [
	    	  { targets: 0,  orderable: false },
              { className: "select-checkbox", targets: 0,  orderable: false }  
	               ]
	     
	               
	    	
	      
	    });
	



	    $('.inputsearchtable').on('click', function(e){
	       e.stopPropagation();    
	    });

	    tabArticoli.columns().eq( 0 ).each( function ( colIdx ) {
  $( 'input', tabArticoli.column( colIdx ).header() ).on( 'keyup', function () {
	  tabArticoli
          .column( colIdx )
          .search( this.value )
          .draw();
  } );
} );  
	    tabArticoli.columns.adjust().draw();
	
	
	    tabDettaglio = $("#tabDettaglio").DataTable({
	        language: {
	            emptyTable: "Nessun dato presente nella tabella",
	            info: "Vista da _START_ a _END_ di _TOTAL_ elementi",
	            infoEmpty: "Vista da 0 a 0 di 0 elementi",
	            infoFiltered: "(filtrati da _MAX_ elementi totali)",
	            infoThousands: ".",
	            lengthMenu: "Visualizza _MENU_ elementi",
	            loadingRecords: "Caricamento...",
	            processing: "Elaborazione...",
	            search: "Cerca:",
	            zeroRecords: "La ricerca non ha portato alcun risultato.",
	            paginate: {
	                first: "Inizio",
	                previous: "Precedente",
	                next: "Successivo",
	                last: "Fine"
	            },
	            aria: {
	                srtAscending: ": attiva per ordinare la colonna in ordine crescente",
	                sortDescending: ": attiva per ordinare la colonna in ordine decrescente"
	            }
	        },
	        pageLength: 25,
	        order: [[0, "desc"]],
	        paging: false,
	        ordering: true,
	        info: true,
	        searchable: false,
	        searching:false,
	        targets: 0,
	        responsive: true,
	        scrollX: false,
	        stateSave: false,
	        columns : [
		    	{"data" : "id_articolo"},  
		    	{"data" : "descrizione"},  
		    	{"data" : "importo"},
		      	{"data" : "quantita"}
		      
		       ],	
	        columnDefs: [
	            { responsivePriority: 1, targets: 1 }
	            
	        ],
	        buttons: [{
	            extend: 'colvis',
	            text: 'Nascondi Colonne'
	        }]
	    });
	    
	    
	    
	    
	    
	    
	    tabClienti = $("#tabClienti").DataTable({
	        language: {
	            emptyTable: "Nessun dato presente nella tabella",
	            info: "Vista da _START_ a _END_ di _TOTAL_ elementi",
	            infoEmpty: "Vista da 0 a 0 di 0 elementi",
	            infoFiltered: "(filtrati da _MAX_ elementi totali)",
	            infoThousands: ".",
	            lengthMenu: "Visualizza _MENU_ elementi",
	            loadingRecords: "Caricamento...",
	            processing: "Elaborazione...",
	            search: "Cerca:",
	            zeroRecords: "La ricerca non ha portato alcun risultato.",
	            paginate: {
	                first: "Inizio",
	                previous: "Precedente",
	                next: "Successivo",
	                last: "Fine"
	            },
	            aria: {
	                srtAscending: ": attiva per ordinare la colonna in ordine crescente",
	                sortDescending: ": attiva per ordinare la colonna in ordine decrescente"
	            }
	        },
	        pageLength: 25,
	        order: [[0, "asc"]],
	        paging: true,
	        ordering: true,
	        info: true,
	        searchable: false,
	        targets: 0,
	        responsive: true,
	        scrollX: false,
	        stateSave: true,
	        columns : [
		    	{"data" : "cliente"},  
		    	{"data" : "indirizzo"}
		      
		       ],	
	        columnDefs: [
	            { responsivePriority: 1, targets: 1 }
	            
	        ],
	        buttons: [{
	            extend: 'colvis',
	            text: 'Nascondi Colonne'
	        }]
	    });
	
	    sommaDati()
});


$('#selectAlltabPM').on('ifChecked', function (ev) {

	
	
	$("#selectAlltabPM").prop('checked', true);
	tabArticoli.rows().deselect();
	var allData = tabArticoli.rows({filter: 'applied'});
	tabArticoli.rows().deselect();
	i = 0;
	tabArticoli.rows({filter: 'applied'}).every( function ( rowIdx, tableLoop, rowLoop ) {
	 
			 this.select();
	   
	    
	} );

	});
$('#selectAlltabPM').on('ifUnchecked', function (ev) {

	
		$("#selectAlltabPM").prop('checked', false);
		tabArticoli.rows().deselect();
		var allData = tabArticoli.rows({filter: 'applied'});
		tabArticoli.rows().deselect();

  	});


 
$('#nuovoClienteForm').on('submit', function(e){
	 e.preventDefault();
	 
	 
	 callAjaxForm('#nuovoClienteForm','gestioneVerOfferte.do?action=nuovo_cliente');
});



var righe =[];
 
 $('#nuovaOffertaForm').on('submit', function(e){
	 e.preventDefault();
	 var id_articoli = "";
	 var index = 1;
	 tabArticoli.rows({ selected: true }).every(function () {
 	        var $row = $(this.node());
 	        var id = $row.find('td').eq(1).text().trim(); // Colonna ID
 	        var descrizione =  $row.find('td').eq(2).text()
 	       var quantita = $('#quantita_'+id).val();
 	       var sconto = $('#sconto_'+id).val();
 	       var prezzo =  $row.find('td').eq(3).text()
 	       id_articoli += id +","+quantita+ ";";
 	      
 	       
 	    	righe.push({	
 	    	"DESCR" : descrizione,
 	    	"ID_ANAART" : id,
 	    	"K2_RIGA" : index,
 	    	"QTA" : quantita,
 	    	"PREZZO_APPLICATO" : prezzo,
 	    	"SCONTO" : sconto,
 	    	"ID_ORDINE_MOBILE" : "14"})
 	    	
 	    	index++;
 	    
 	    });
    	
    	$('#id_articoli').val(id_articoli)
    	
    	 

    	
    	
	 /* callAjaxForm('#nuovaOffertaForm','gestioneVerOfferte.do?action=nuova_offerta', function(data){
		 
		 inserisciOffertaMilestone()
	 }); */
	
	 //inserisciOffertaMilestone()
	 
	 inviaOrdine()
});
 
 
 
 
 
 
 function inserisciOffertaMilestone() {

	 testata = {}
	 testata.CODAGE =  "${userObj.codice_agente}";
	 testata.CODPAG= "PAG001",
	 testata.CODSPED= "SPED001",
	 testata.COND_PAG= "30 gg Fine Mese",
	 testata.DT_CONS= "2025-11-20",
	 testata.DT_FINE_VALIDITA= "2025-12-31",
	 testata.DT_ORDINE= "2025-11-17",
	 testata.ID_ANAGEN= 199,
	 testata.ID_ORDINE_MOBILE= "14",
	 testata.NOTE= $('#note').val(),
	 testata.NOTE_INTERNE= $('#note').val(),
	 testata.SCONTO_T= 10.0,
	 testata.SP_SPEDIZIONE= 8.50,
	 testata.TIPO= "ORD",
	 testata.USAEMAILORDINE= 1,
	 testata.ID_COMPANY= 1
	  
	 
	 const payload = {
			    righe: righe,
			    //allegati: allegati,
			    testata: testata
			};
	 
	 
 	    const dataObj = {
	    		
	    		"item": [
	    			    					
	    					{
	    						"name": "InsertOrdine",
	    						"request": {
	    							"auth": {
	    								"type": "basic",
	    								"basic": [
	    									{
	    										"key": "password",
	    										"value": "Akeron2025!",
	    										"type": "string"
	    									},
	    									{
	    										"key": "username",
	    										"value": "age",
	    										"type": "string"
	    									}
	    								]
	    							},
	    							"method": "POST",
	    							"header": [],
	    							"body": {
	    								"mode": "raw",
	    								//"raw": "{\r\n  \"righe\": [\r\n    {\r\n      \"DESCR\": \"Prodotto di esempio 1\",\r\n      \"ID_ANAART\": \"ART001\",\r\n      \"ID_ORDINE_MOBILE\": \"ORD-MOBILE-12345\",\r\n      \"K2_RIGA\": 1,\r\n      \"PREZZO_APPLICATO\": 85.00,\r\n      \"PREZZO_LISTINO\": 100.00,\r\n      \"QTA\": 5.0,\r\n      \"SCONTO\": 15.0,\r\n      \"SCONTO1\": 10.0,\r\n      \"SCONTO2\": 5.0,\r\n      \"SCONTO3\": 0.0,\r\n      \"SCONTO4\": 0.0,\r\n      \"SCONTO_MAX\": 20.0,\r\n      \"NOTE\": \"Note riga 1\"\r\n    },\r\n    {\r\n      \"DESCR\": \"Prodotto di esempio 2\",\r\n      \"ID_ANAART\": \"ART002\",\r\n      \"ID_ORDINE_MOBILE\": \"ORD-MOBILE-12345\",\r\n      \"K2_RIGA\": 2,\r\n      \"PREZZO_APPLICATO\": 42.50,\r\n      \"PREZZO_LISTINO\": 50.00,\r\n      \"QTA\": 10.0,\r\n      \"SCONTO\": 15.0,\r\n      \"SCONTO1\": 10.0,\r\n      \"SCONTO2\": 5.0,\r\n      \"SCONTO3\": 0.0,\r\n      \"SCONTO4\": 0.0,\r\n      \"SCONTO_MAX\": 20.0,\r\n      \"NOTE\": \"Note riga 2\"\r\n    }\r\n  ],\r\n  \"allegati\": [\r\n    {\r\n      \"ID_ORDINE_MOBILE\": \"ORD-MOBILE-12345\",\r\n      \"FILE_TYPE\": \"application/pdf\",\r\n      \"FILE_ATTACH\": \"BASE64_ENCODED_FILE_CONTENT_HERE\",\r\n      \"FILE_NAME\": \"documento_ordine\",\r\n      \"FILE_EXT\": \"pdf\"\r\n    },\r\n    {\r\n      \"ID_ORDINE_MOBILE\": \"ORD-MOBILE-12345\",\r\n      \"FILE_TYPE\": \"image/jpeg\",\r\n      \"FILE_ATTACH\": \"BASE64_ENCODED_IMAGE_CONTENT_HERE\",\r\n      \"FILE_NAME\": \"foto_prodotto\",\r\n      \"FILE_EXT\": \"jpg\"\r\n    }\r\n  ],\r\n  \"testata\": {\r\n    \"CODAGE\": \"AGE001\",\r\n    \"CODPAG\": \"PAG001\",\r\n    \"CODSPED\": \"SPED001\",\r\n    \"COND_PAG\": \"30 gg Fine Mese\",\r\n    \"DT_CONS\": \"2025-11-20\",\r\n    \"DT_FINE_VALIDITA\": \"2025-12-31\",\r\n    \"DT_ORDINE\": \"2025-11-17\",\r\n    \"ID_ANAGEN\": 12345,\r\n    \"ID_ORDINE_MOBILE\": \"ORD-MOBILE-12345\",\r\n    \"NOTE\": \"Note esterne per il cliente\",\r\n    \"NOTE_INTERNE\": \"Note interne per uso ufficio\",\r\n    \"SCONTO_T\": 10.0,\r\n    \"SP_SPEDIZIONE\": 8.50,\r\n    \"TIPO\": \"ORD\",\r\n    \"USAEMAILORDINE\": 1,\r\n    \"ID_COMPANY\": 1\r\n  }\r\n}",
	    								"raw":{"righe": righe, "allegati": allegati, "testata" : testata},
	    								"options": {
	    									"raw": {
	    										"language": "json"
	    									}
	    								}
	    							},
	    							"url": {
	    								"raw": "https://portaletest.ncsnetwork.it/webapi/api/ordine",
	    								"host": [
	    									"https://portaletest.ncsnetwork.it/webapi/api/"
	    								],
	    								"path": [
	    									"ordine"
	    								]
	    							}
	    						},
	    						"response": []
	    					}
	    				],
	    	
	    		"event": [
	    			{
	    				"listen": "prerequest",
	    				"script": {
	    					"type": "text/javascript",
	    					"packages": {},
	    					"requests": {},
	    					"exec": [
	    						""
	    					]
	    				}
	    			},
	    			{
	    				"listen": "test",
	    				"script": {
	    					"type": "text/javascript",
	    					"packages": {},
	    					"requests": {},
	    					"exec": [
	    						""
	    					]
	    				}
	    			}
	    		],
	    		"variable": [
	    			{
	    				"key": "NCS_PasswordAgente",
	    				"value": "Akeron2025!"
	    			},
	    			{
	    				"key": "NCS_UtenteAgente",
	    				"value": "age"
	    			},
	    			{
	    				"key": "NCS_baseUrl",
	    				"value": ""
	    			},
	    			{
	    				"key": "NCS_baseUrlTest",
	    				"value": "https://portaletest.ncsnetwork.it/webapi/api"
	    			}
	    		]
	    	};
	     

	   //var url = "http://localhost:8080/AccPoint/inserisciOfferta.do?action=inserisci";var url = "http://localhost:8080/AccPoint/inserisciOfferta.do?action=inserisci";
	    //var url = "https://api.mathjs.org/v4/";
	   // var url = "https://portaletest.ncsnetwork.it/webapi/api/ordine";
	    var url = "http://localhost:8081/AccPoint/gestioneVerOfferte.do?action=inserisci_offerta_milestone";
	    fetch(url, {
	        method: "POST",
	        headers: {
	            "Content-Type": "application/json"
	        },
	        body: JSON.stringify(payload)
	    })
	    .then(response => response.json())
	    .then(data => {
	        document.getElementById("risultato").innerText =
	            "Risultato della somma: " + data.result;
	    })
	    .catch(err => {
	        document.getElementById("risultato").innerText =
	            "Errore: " + err;
	    });
	}
 
 
 
 
 
 
 
 
 
 
 $("#cliente").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#sede option').clone());
	  }
	  
	  
	  var selection = $(this).val()	 
	  var id = selection
	  var options = $(this).data('options');

	  var opt=[];
	
	  opt.push("<option value = '${non_associate_encrypt}'>Non Associate</option>");

	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 
	
		//if(str.substring(str.indexOf("_")+1,str.length)==id)
		if(str.substring(str.indexOf("_")+1, str.length)==id)
		{

			opt.push(options[i]);
		}   
	   }
	 $("#sede").prop("disabled", false);
	 
	  $('#sede').html(opt);
	  
	  //$("#sede").trigger("chosen:updated");
	  

		//$("#sede").change();  
		
		  var id_cliente = selection.split("_")[0];
		  

		  var opt=[];
			opt.push("");
		   for(var  i=0; i<options.length;i++)
		   {
			   if(str!='' && str.split("_")[1]==id)
				{
					opt.push(options[i]);
				}   
		   } 
		   
		  

	});
 
 
 $("#citta").change(function() {
	 
	 
	 var cap = $(this).val().split("_")[0];
	 var provincia = $(this).val().split("_")[1];
	 
	 if(cap.length==4){
		 cap = "0"+cap
	 }
	$('#cap').val(cap)
	$('#provincia').val(provincia)

	});
 
 $("#citta_sede").change(function() {
	 
	 
	 var cap = $(this).val().split("_")[0];
	 var provincia = $(this).val().split("_")[1];
	 
	$('#cap_sede').val(cap)
	$('#provincia_sede').val(provincia)

	});

 
 
 var options = [];
 function mockData() {
 	  return _.map(options, function(i) {		  
 	    return {
 	      id: i.value,
 	      text: i.text,
 	    };
 	  });
 	}
 	


 function initSelect2(id_input, placeholder, dropDownParent) {

	 if(placeholder==null){
		  placeholder = "Seleziona Cliente...";
	  }
 	$(id_input).select2({
 	    data: mockData(),
 	   dropdownParent: $(dropDownParent),
 	    placeholder: placeholder,
 	    multiple: false,
 	    // query with pagination
 	    query: function(q) {
 	      var pageSize,
 	        results,
 	        that = this;
 	      pageSize = 20; // or whatever pagesize
 	      results = [];
 	      if (q.term && q.term !== '') {
 	        // HEADS UP; for the _.filter function i use underscore (actually lo-dash) here
 	        results = _.filter(x, function(e) {
 	        	
 	          return e.text.toUpperCase().indexOf(q.term.toUpperCase()) >= 0;
 	        });
 	      } else if (q.term === '') {
 	        results = that.data;
 	      }
 	      q.callback({
 	        results: results.slice((q.page - 1) * pageSize, q.page * pageSize),
 	        more: results.length >= q.page * pageSize,
 	      });
 	    },
 	  });
 }

 
 var allegati = [];
 
 $('#fileupload_img').change(function(){
		
	  const files = this.files; // elenco di File oggetti
	    let fileNames = [];
	  

	    for (let i = 0; i < files.length; i++) {
	        fileNames.push(files[i].name);
	    }

	    // Mostra tutti i nomi separati da virgola (o su più righe)
	    $('#label_img').html(fileNames.join('<br>'));
	    
	    const base64Array = [];
	  

	    for (let file of files) {
	        const base64 =  fileToBase64(file);
	        base64Array.push(base64);
	        allegato = {} 
	        allegato.FILE_TYPE = "image/jpeg";
	        allegato.FILE_ATTACH = base64;
	        allegato.FILE_NAME = file.name;
	        allegato.FILE_EXT = "jpg";
	        allegato.FILE_TYPE = "5";
	        allegati.push(allegato)
	    }
	    
	    console.log(base64Array);  
	    
	});
 
 
 function fileToBase64(file) {
	    return new Promise((resolve, reject) => {
	        const reader = new FileReader();
	        reader.onload = () => resolve(reader.result.split(",")[1]); 
	        reader.onerror = reject;
	        reader.readAsDataURL(file);
	    });
	}
 
 $("#tabArticoli").on('select.dt', function (e, dt, type, indexes) {
     if (type === 'row') {
         indexes.forEach(function(index) {
             var row = dt.row(index).node();
             $(row).find('td').each(function(i, cell) {
                 const $cell = $(cell);
                 if (i === 0 || i === 1 || i === 2 || i === 3) return;

                 if (!$cell.data('original-border')) {
                     $cell.data('original-border', $cell.css('border'));
                 }

                 $cell.css('border', '1px solid red');

                 if(i === 4){
                  	var id = $(row)[0].id;
                  	 const input = $('<input id="sconto_'+id+'" class="form-control" style="width:100%" type="number" min="0" step="1" value="15"/>');
 	                        $cell.html(input);	
                  }
                  if(i === 5){
                 	var id = $(row)[0].id;
                 	 const input = $('<input id="quantita_'+id+'" class="form-control" style="width:100%" type="number" min="0" step="1" value="1"/>');
	                        $cell.html(input);	
                 }
         
             });
         });
     }
     
 
 });

 // Deselect row
 $("#tabArticoli").on('deselect.dt', function (e, dt, type, indexes) {
     if (type === 'row') {
         indexes.forEach(function(index) {
             var row = dt.row(index).node();
             $(row).find('td').each(function(i, cell) {
                 const $cell = $(cell);
                 if (i === 0 || i === 1 || i === 2 || i === 3) return;

                 const originalBorder = $cell.data('original-border');
                 if (originalBorder !== undefined) {
                     $cell.css('border', originalBorder);
                     $cell.removeData('original-border');
                 }

                 $cell.text('');
             });
         });
     }
     
 });

 
	$(document).on('mousemove', '.list-group-item', function (e) {
		 
		
		  const popupId ='#image-popup';
		  const imgId =  '#popup-img';

		  const thumbSpan = $(this).find('.option-with-thumb');
		  if (thumbSpan.length > 0) {
		    const largeSrc = thumbSpan.data('large');
		    $(imgId).attr('src', largeSrc);

		    // Coordinate dell'opzione attiva
		    const optionOffset = $(this).offset();
		    const optionHeight = $(this).outerHeight();
		    const popupHeight = 250; // altezza stimata del popup
		    const spaceBelow = $(window).height() - (optionOffset.top + optionHeight);
		    const topPosition = spaceBelow > popupHeight
		      ? optionOffset.top + optionHeight + 5   // sotto
		      : optionOffset.top - popupHeight - 5;   // sopra

		    // Posizione laterale: a destra della select
		    const leftPosition = optionOffset.left + $(this).outerWidth() + 10;

		    $(popupId).css({
		      top: topPosition,
		      left: leftPosition,
		      display: 'block'
		    });
		  }
		});

		$(document).on('mouseleave', '.list-group-item', function () {
		  $('#image-popup_mod, #image-popup').fadeOut(150);
		});
 
 function dettaglioOfferta(id){
	 
	 dataObj = {};
	 dataObj.id = id;
	
	 callAjax(dataObj, "gestioneVerOfferte.do?action=dettaglio_offerta",function(data){
		 
		 if(data.success){

	    	 
			
			 var offerta = data.offerta
			 var lista_articoli = data.lista_articoli
			 var lista_immagini = data.lista_immagini
			
			 $('#cliente_dtl').val(offerta.nome_cliente);
			$('#sede_dtl').val(offerta.nome_sede);
			
			$('#note_dtl').val(offerta.note);
		
			$('#importo_tot').val(offerta.importo);
		  	 var table_data = [];
			  
		     if(lista_articoli!=null){
		 		  for(var i = 0; i<lista_articoli.length;i++){
		 			  var dati = {};
		 			 
		 			  dati.id_articolo = lista_articoli[i].articoloObj.ID_ANAART;
		 			  dati.descrizione = lista_articoli[i].articoloObj.DESCR;
		 			  dati.importo = lista_articoli[i].articoloObj.importo;		
		 			 dati.quantita = lista_articoli[i].quantita;	
		 			  table_data.push(dati);
		 			
		 		  }
		     }
		 		  var tabDettaglio = $('#tabDettaglio').DataTable();
		 		  
		 		 tabDettaglio.clear().draw();
		 		   
		 		tabDettaglio.rows.add(table_data).draw();
		 			
		 		tabDettaglio.columns.adjust().draw();
		 		
		 		 const container = document.getElementById("content_immagini");
		 	    const popup = document.getElementById("preview_popup");
		 	    const popupImg = document.getElementById("preview_img");

		 	   lista_immagini.forEach(img => {
		 	        const thumb = document.createElement("img");
		 	        thumb.src = img.url;
		 	        thumb.alt = img.nome_file;
		 	        thumb.style.width = "100px";
		 	        thumb.style.height = "100px";
		 	        thumb.style.objectFit = "cover";
		 	        thumb.style.margin = "8px";
		 	        thumb.style.cursor = "pointer";
		 	        thumb.style.borderRadius = "6px";
		 	        thumb.style.transition = "transform 0.2s";
		 	        thumb.onmouseenter = (e) => {
		 	            popupImg.src = img.url;
		 	            popup.style.display = "block";
		 	        };
		 	        thumb.onmousemove = (e) => {
		 	            popup.style.left = e.offsetX + 15 + "px";
		 	            popup.style.top = e.offsetY + 15 + "px";
		 	        };
		 	        thumb.onmouseleave = () => {
		 	            popup.style.display = "none";
		 	         
		 	        };
		 	        
		 	       thumb.onclick = () => {
		 	    	   callAction("gestioneVerOfferte.do?action=download_immagine&id_immagine="+img.id)
		 	         
		 	        };
		 	        container.appendChild(thumb);
		 	    });
		 		
		 		$('#myModalDettaglioOfferta').modal()
		 }
		 
	 })
	 
 }
 
 
 
 function listaClienti(){

			pleaseWaitDiv = $('#pleaseWaitDialog');
			  pleaseWaitDiv.modal();
	callAjax(null, "gestioneVerOfferte.do?action=clienti_sedi&indirizzo=1", function(data){
	
		if(data.success){
			 var opt_clienti=[];
			 var opt_sedi=[];
		
			 var lista_clienti = data.lista_clienti
			
			 var table_data = [];
			  
		     if(lista_clienti!=null){
		 		  for(var i = 0; i<lista_clienti.length;i++){
		 			  var dati = {};
		 			 
		 			
		 			  dati.cliente = lista_clienti[i].nome;
		 			  dati.indirizzo = lista_clienti[i].indirizzo +", "+lista_clienti[i].cap+", "+lista_clienti[i].citta+" ("+lista_clienti[i].provincia+")";	
		 			  table_data.push(dati);
		 			
		 		  }
		     }
		 		  var tabClienti = $('#tabClienti').DataTable();
		 		  
		 		 tabClienti.clear().draw();
		 		   
		 		tabClienti.rows.add(table_data).draw();
		 			
		 		tabClienti.columns.adjust().draw();
		
		
		    	
		    	 pleaseWaitDiv.hide();
		    	$('#modalListaClienti').modal();
		    	
		   
		  	 
		}
		
	});
	

	
}
 
 
 $('#myModalDettaglioOfferta').on('hidden.bs.modal', function(){

	 $('#content_immagini').html("");


 })
 
 
  $('#myModalNuovaOfferta').on("hidden.bs.modal", function(){
		  
	
	 var tableArt = $('#tabArticoli').DataTable();
	 tableArt.rows({ search: 'applied' }).deselect();
 });
 
 var id_off;
 function modalCambioStato(id_offerta, stato){
	 
	 id_off = id_offerta;
	 
	 if(stato ==2){
		 $('#myModalYesOrNo').modal()
	 }else{
		 $('#modalNOfferta').modal()
	 }
	 
 }
 
 function cambiaStatoOfferta(){
	 
	 dataObj = {};
	 dataObj.id_offerta = id_off;
	 dataObj.n_offerta = $('#n_offerta').val()
	 
	 callAjax(dataObj, "gestioneVerOfferte.do?action=cambia_stato")
	 
 }
 
 $('#formNOfferta').on("submit", function(e){

	 e.preventDefault();
	 
	 cambiaStatoOfferta()
	 
 })
 
 
 

	$('input[name="datarange"]').daterangepicker({
	    locale: {
	      format: 'DD/MM/YYYY'
	    }
	}, 
	function(start, end, label) {

	});


minDateFilter = "";
maxDateFilter = "";
dataType = "";

 $.fn.dataTableExt.afnFiltering.push(
		  
 
  function(oSettings, aData, iDataIndex) {
	   console.log(aData);
	   
		if(oSettings.nTable.getAttribute('id') == "tabOfferte"){

				   if (aData[4]) {

			    	 	var dd = aData[4].split("/");

			       aData._date = new Date(dd[2],dd[1]-1,dd[0]).getTime();
			       console.log("Prossima:"+minDateFilter);
				   console.log("MIN:"+minDateFilter);
				   console.log("MAX:"+maxDateFilter);
				   console.log("VAL:"+aData._date);
				   console.log( dd);


			     }
				   
	
			  
		     if (minDateFilter && !isNaN(minDateFilter)) {
		    	 if(isNaN(aData._date)){
		    		 return false;
		     
		     }
		       if (aData._date < minDateFilter) {
		          return false;
		       }
		   		
		     }

		     if (maxDateFilter && !isNaN(maxDateFilter)) {
		    	 if(isNaN(aData._date)){
		    		 return false;
		     
		     }
		       if (aData._date > maxDateFilter) {
		    	  
		         return false;
		       }
		      }

		     
		   }
		  return true;
		}	
	   

); 

 
 
 function filtraDataOfferta(){
 	var startDatePicker = $("#datarange").data('daterangepicker').startDate;
 	var endDatePicker = $("#datarange").data('daterangepicker').endDate;
 	
 	startDatePicker._isUTC =  true;
 	endDatePicker._isUTC =  true;

 		minDateFilter = new Date(startDatePicker.format('YYYY-MM-DD') ).getTime();
 
 		maxDateFilter = new Date(endDatePicker.format('YYYY-MM-DD') ).getTime();
 	
 		
 		var table = $('#tabOfferte').DataTable();
      table.draw();
      
      sommaDati();
       
}
 
 
 
function sommaDati(){
	 
	 var sommaImporti = 0.0;


	  $('.riga').each(function() {
	    var importo = $(this).find('.importo').text().trim(); 
	
		var stato = $(this).find('.stato').text().trim();
		

	      if(stato == "APPROVATA"){
	    	 	      
	      sommaImporti += parseFloat(importo);
	      
	      }
	  });

	  $('#tot_importi').val(sommaImporti);

	 
 }
 
 
function inviaOrdine() {

    const payload = {
        /* righe: [
            {
               "DESCR": "Prodotto di esempio",
                "ID_ANAART": "0625-VER-BIL",
                "K2_RIGA": 1,
                "QTA": 1,
                "PREZZO_APPLICATO": 90,
                "SCONTO": 15,
                "ID_ORDINE_MOBILE": "12"
            }
        ], */
       /*   allegati: [
            {
                
      ID_ORDINE_MOBILE: "12",
      "FILE_TYPE": "application/pdf",
      "FILE_ATTACH": "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CmVuZG9iagoKOSAwIG9iago8PC9UeXBlL0ZvbnQvU3VidHlwZS9UcnVlVHlwZS9CYXNlRm9udC9CQUFBQUErQXJpYWwtQm9sZE1UCi9GaXJzdENoYXIgMAovTGFzdENoYXIgMTEKL1dpZHRoc1s3NTAgNzIyIDYxMCA4ODkgNTU2IDI3NyA2NjYgNjEwIDMzMyAyNzcgMjc3IDU1NiBdCi9Gb250RGVzY3JpcHRvciA3IDAgUgovVG9Vbmljb2RlIDggMCBSCj4+CmVuZG9iagoKMTAgMCBvYmoKPDwKL0YxIDkgMCBSCj4+CmVuZG9iagoKMTEgMCBvYmoKPDwvRm9udCAxMCAwIFIKL1Byb2NTZXRbL1BERi9UZXh0XT4+CmVuZG9iagoKMSAwIG9iago8PC9UeXBlL1BhZ2UvUGFyZW50IDQgMCBSL1Jlc291cmNlcyAxMSAwIFIvTWVkaWFCb3hbMCAwIDU5NSA4NDJdL0dyb3VwPDwvUy9UcmFuc3BhcmVuY3kvQ1MvRGV2aWNlUkdCL0kgdHJ1ZT4+L0NvbnRlbnRzIDIgMCBSPj4KZW5kb2JqCgoxMiAwIG9iago8PC9Db3VudCAxL0ZpcnN0IDEzIDAgUi9MYXN0IDEzIDAgUgo+PgplbmRvYmoKCjEzIDAgb2JqCjw8L1RpdGxlPEZFRkYwMDQ0MDA3NTAwNkQwMDZEMDA3OTAwMjAwMDUwMDA0NDAwNDYwMDIwMDA2NjAwNjkwMDZDMDA2NT4KL0Rlc3RbMSAwIFIvWFlaIDU2LjcgNzczLjMgMF0vUGFyZW50IDEyIDAgUj4+CmVuZG9iagoKNCAwIG9iago8PC9UeXBlL1BhZ2VzCi9SZXNvdXJjZXMgMTEgMCBSCi9NZWRpYUJveFsgMCAwIDU5NSA4NDIgXQovS2lkc1sgMSAwIFIgXQovQ291bnQgMT4+CmVuZG9iagoKMTQgMCBvYmoKPDwvVHlwZS9DYXRhbG9nL1BhZ2VzIDQgMCBSCi9PdXRsaW5lcyAxMiAwIFIKPj4KZW5kb2JqCgoxNSAwIG9iago8PC9BdXRob3I8RkVGRjAwNDUwMDc2MDA2MTAwNkUwMDY3MDA2NTAwNkMwMDZGMDA3MzAwMjAwMDU2MDA2QzAwNjEwMDYzMDA2ODAwNkYwMDY3MDA2OTAwNjEwMDZFMDA2RTAwNjkwMDczPgovQ3JlYXRvcjxGRUZGMDA1NzAwNzIwMDY5MDA3NDAwNjUwMDcyPgovUHJvZHVjZXI8RkVGRjAwNEYwMDcwMDA2NTAwNkUwMDRGMDA2NjAwNjYwMDY5MDA2MzAwNjUwMDJFMDA2RjAwNzIwMDY3MDAyMDAwMzIwMDJFMDAzMT4KL0NyZWF0aW9uRGF0ZShEOjIwMDcwMjIzMTc1NjM3KzAyJzAwJyk+PgplbmRvYmoKCnhyZWYKMCAxNgowMDAwMDAwMDAwIDY1NTM1IGYgCjAwMDAwMTE5OTcgMDAwMDAgbiAKMDAwMDAwMDAxOSAwMDAwMCBuIAowMDAwMDAwMjI0IDAwMDAwIG4gCjAwMDAwMTIzMzAgMDAwMDAgbiAKMDAwMDAwMDI0NCAwMDAwMCBuIAowMDAwMDExMTU0IDAwMDAwIG4gCjAwMDAwMTExNzYgMDAwMDAgbiAKMDAwMDAxMTM2OCAwMDAwMCBuIAowMDAwMDExNzA5IDAwMDAwIG4gCjAwMDAwMTE5MTAgMDAwMDAgbiAKMDAwMDAxMTk0MyAwMDAwMCBuIAowMDAwMDEyMTQwIDAwMDAwIG4gCjAwMDAwMTIxOTYgMDAwMDAgbiAKMDAwMDAxMjQyOSAwMDAwMCBuIAowMDAwMDEyNDk0IDAwMDAwIG4gCnRyYWlsZXIKPDwvU2l6ZSAxNi9Sb290IDE0IDAgUgovSW5mbyAxNSAwIFIKL0lEIFsgPEY3RDc3QjNEMjJCOUY5MjgyOUQ0OUZGNUQ3OEI4RjI4Pgo8RjdENzdCM0QyMkI5RjkyODI5RDQ5RkY1RDc4QjhGMjg+IF0KPj4Kc3RhcnR4cmVmCjEyNzg3CiUlRU9GCg==",
      "FILE_NAME": "documento_ordine.pdf",
      "FILE_EXT": "pdf"
    
            }
        ], */ 
        righe : righe,
        //allegati : allegati,
        testata: {
        	  "CODAGE": "${userObj.codice_agente}",
        	    "CODPAG": "PAG0000000022",
        	    "CODSPED": "1",
        	    "COND_PAG": "30 gg Fine Mese",
        	    "DT_CONS": "2025-11-20",
        	    "DT_FINE_VALIDITA": "2025-12-31",
        	    "DT_ORDINE": "2025-11-17",
        	    "ID_ANAGEN": 76,
        	    "ID_ORDINE_MOBILE": "14",
        	    "NOTE": "Note esterne per il cliente",
        	    "NOTE_INTERNE": "Note interne per uso ufficio",
        	    "SCONTO_T": 10.0,
        	    "SP_SPEDIZIONE": 8.50,
        	    "TIPO": "ORD",
        	    "USAEMAILORDINE": 1,
        	    "ID_COMPANY": 52
        }
    };

    fetch("http://localhost:8081/AccPoint/gestioneVerOfferte.do?action=inserisci_offerta_milestone", {
        method: "POST",
        headers: {"Content-Type": "application/json"},
        body: JSON.stringify(payload)
    })
    .then(r => r.text())
    .then(t => alert(t))
    .catch(e => alert("Errore: " + e));
}
 
  </script>
  
</jsp:attribute> 
</t:layout>

