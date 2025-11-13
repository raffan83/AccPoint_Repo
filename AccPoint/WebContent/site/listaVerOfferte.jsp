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
<th style="">Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_offerte }" var="offerta" varStatus="loop">
 	
 	<c:if test="${offerta.stato == 1 }">
 	 	<tr id="row_${offerta.id }" style="background-color:#F7F688">
</c:if>

 	<c:if test="${offerta.stato == 2 }">
 	 	<tr id="row_${offerta.id }" style="background-color:#90EE90">
</c:if>

	<td>${offerta.id }</td>	
	<td>${offerta.n_offerta }</td>	
	
	<td>${offerta.nome_cliente }</td>

	<td>${offerta.nome_sede }</td>
	<td> <fmt:formatDate value="${offerta.data_offerta }" pattern="dd/MM/yyyy" /></td>
	<td>${offerta.importo }</td>
	<td>${offerta.utente }</td>
	<td><c:if test="${offerta.stato==1 }"> <!-- <span class="label label-warning"> -->DA APPROVARE<!-- </span> --></c:if>
	<c:if test="${offerta.stato==2 }"> <!-- <span class="label label-success"> -->APPROVATA<!-- </span> --></c:if>
	</td>
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


	</tr>
	
	 
	</c:forEach>
 
	
 </tbody>
 </table>  
       			
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
    <div class="modal-dialog modal-md" role="document">
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
    <div class="modal-dialog modal-md" role="document">
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


function modificaOfferta(id_offerta, targa, modello, id_company, km_percorsi, carta_circolazione, portata_max_offerta, immagine_offerta, dispositivo_pedaggio,note, autorizzazione){
	
	$('#id_offerta').val(id_offerta);
	$('#targa_mod').val(targa);
	$('#modello_mod').val(modello);
	$('#company_mod').val(id_company);
	$('#company_mod').change();
	$('#km_percorsi_mod').val(km_percorsi);
	$('#label_carta_circolazione_mod').html(carta_circolazione);
	$('#portata_max_mod').val(portata_max_offerta);
	$('#label_immagine_offerta_mod').html(immagine_offerta);
	$('#dispositivo_pedaggio_mod').val(dispositivo_pedaggio);
	$('#note_mod').val(note)
	$('#autorizzazione_mod').val(autorizzazione)

	$('#myModalModificaOfferta').modal();
}



function modalEliminaOfferta(id_offerta){
	
	
	$('#id_offerta_elimina').val(id_offerta);
	$('#myModalYesOrNo').modal()
	
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
 
 $('#nuovaOffertaForm').on('submit', function(e){
	 e.preventDefault();
	 var id_articoli = "";
	 tabArticoli.rows({ selected: true }).every(function () {
 	        var $row = $(this.node());
 	        var id = $row.find('td').eq(1).text().trim(); // Colonna ID
 	       var quantita = $('#quantita_'+id).val();
 	     	   
 	       id_articoli += id +","+quantita+ ";";
 	    });
    	
    	$('#id_articoli').val(id_articoli)
	 callAjaxForm('#nuovaOffertaForm','gestioneVerOfferte.do?action=nuova_offerta');
	
});
 
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

 $('#fileupload_img').change(function(){
		
	  const files = this.files; // elenco di File oggetti
	    let fileNames = [];

	    for (let i = 0; i < files.length; i++) {
	        fileNames.push(files[i].name);
	    }

	    // Mostra tutti i nomi separati da virgola (o su più righe)
	    $('#label_img').html(fileNames.join('<br>'));
	});
 
 
 
 
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
 
 
  </script>
  
</jsp:attribute> 
</t:layout>

