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
                  <b>ID</b> <a class="pull-right">${intervento.id}</a>
                </li>
       
					
                <li class="list-group-item">
                  <b>ID Commessa</b> <a class="pull-right">${intervento.idCommessa}</a>
                </li>
                
                 <li class="list-group-item">
                  <b>Cliente</b> 
                  <a id="nome_sede" class="pull-right" style="padding-right:7px">${intervento.nomeCliente } </a>
                </li>
                <li class="list-group-item">
                  <b>Sede</b> <a class="btn btn-warning pull-right btn-xs" title="Click per modificare la sede cliente" onClick="inserisciSede('${intervento.id}')"><i class="fa fa-edit"></i></a>
                  <a id="nome_sede" class="pull-right" style="padding-right:7px">${intervento.nomeSede } </a>
                 
                </li>
                
                 <li class="list-group-item">
                  <b>Cliente Utilizzatore</b> 
                  <a id="nome_sede" class="pull-right" style="padding-right:7px">${intervento.nomeClienteUtilizzatore } </a>
                </li>
                <li class="list-group-item">
                  <b>Sede Utilizzatore</b> <a class="btn btn-warning pull-right btn-xs" title="Click per modificare la sede cliente" onClick="inserisciSedeUtilizzatore('${intervento.id}')"><i class="fa fa-edit"></i></a>
                  <a id="nome_sede" class="pull-right" style="padding-right:7px">${intervento.nomeSedeUtilizzatore } </a>
                </li>
                <li class="list-group-item">
                  <b>Data Intervento</b> <a class="pull-right">
	
			<c:if test="${not empty intervento.dataIntervento}">
   				<fmt:formatDate pattern="dd/MM/yyyy" value="${intervento.dataIntervento}" />
			</c:if>
		</a>
                </li>
            
                <li class="list-group-item">
                  <b>Stato</b> <div class="pull-right">
                  
					<c:if test="${intervento.stato == 0}">
						
						<a href="#" class="customTooltip" title="Click per chiudere l'Intervento"  onClick="cambiaStatoInterventoAM('${intervento.id}',1)" id="statoa_${intervento.id}"> <span class="label label-success">APERTO</span></a>
						
					</c:if>
					
					<c:if test="${intervento.stato == 1}">
						<a href="#" class="customTooltip" title="Click per aprire l'Intervento"  onClick="cambiaStatoInterventoAM('${intervento.id}',0)" id="statoa_${intervento.id}"> <span class="label label-warning">CHIUSO</span></a>
						
					</c:if>
					
					    
				</div>
                </li>
                
                <li class="list-group-item">
                  <b>Operatore</b> <a class="btn btn-warning  pull-right  btn-xs" title="Carica patentino" onclick="modalPatentino('${intervento.operatore.id}','${intervento.operatore.dicituraPatentino}','${intervento.operatore.pathPatentino }','${intervento.operatore.firma }')"><i class="fa fa-file-text-o"></i></a> 
                   <a class="pull-right" style="padding-right:7px">${intervento.operatore.nomeOperatore} </a>
                </li>
              
              
                 <li class="list-group-item">
                  <b>Template Prova</b> <a class="customTooltip pull-right  btn btn-success btn-xs" title="Scarica Template Excel" onclick="callAction('amGestioneInterventi.do?action=scarica_template')"><i class="fa fa-file-excel-o"></i></a>
                </li>
                
                 <li class="list-group-item">
                  <b>Template CAD</b> <a class="customTooltip pull-right  btn btn-danger btn-xs" title="Scarica Template CAD" onclick="callAction('amGestioneInterventi.do?action=scarica_template&isCad=1')"><i class="fa fa-file"></i></a>
                </li>
                
                <b>Note intervento</b><textarea id="note_intervento" class="form-control pull-right" name="note_intervento" rows="2" style="width:100%">${intervento.note }</textarea>
        </ul>
        
   
</div>
</div>
</div>
</div>
      
     
      
            
      
     
      
      
            
            
            
 <div class="row">
        <div class="col-xs-12">
 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Prove
	<div class="box-tools pull-right">

		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
 <div class="row">
        <div class="col-xs-12">
<a class="btn btn-primary pull-right" onClick="nuovaProva()">Nuova Prova</a>
</div>
</div><br>
 <div class="row">
        <div class="col-xs-12">
   <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
  
 <thead><tr class="active">
<%--  <th></th>
  <th style="max-width:65px" class="text-center"></th> --%>
  <th>ID</th>   
 <th>Volume</th>
  <th>Data Prova</th>
  <th>Oggetto Prova</th>

  <th>Matricola</th>
  <th>N. Fabbrica</th>
 <th>Esito</th>	

 <th>Numero Rapporto</th>
 
 <th>Assistente</th>

 <td style="min-width:150px">Azioni</td>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_rapporti}" var="rapporto">
 
 	<tr role="row" id="${rapporto.prova.id}">


 	<td>${rapporto.prova.id}</td>
<td>${rapporto.prova.strumento.volume}</td>
<td> <fmt:formatDate pattern="dd/MM/yyyy"  value="${rapporto.prova.data}" />	</td>
<td>${rapporto.prova.strumento.descrizione}</td>
<td>${rapporto.prova.strumento.matricola}</td>
<td>${rapporto.prova.strumento.nFabbrica}</td>
<td>
<c:if test="${rapporto.prova.esito  == 'POSITIVO'}">
CONFORME A SPECIFICA
</c:if>
<c:if test="${rapporto.prova.esito  == 'NEGATIVO'}">
NON CONFORME A SPECIFICA
</c:if>
</td>

<td>${rapporto.prova.nRapporto }</td>
<td>${rapporto.prova.operatore.nomeOperatore }</td>

<td>
<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio della prova" onClick="callAction('amGestioneInterventi.do?action=dettaglio_prova&id_prova=${utl:encryptData(rapporto.prova.id)}')"><i class="fa fa-search"></i></a>
<c:if test="${rapporto.stato.id == 1}">
<a class="btn btn-warning customTooltip" title="Click per modificare della prova" onClick="modalModificaProva('${rapporto.prova.id}','${rapporto.prova.tipoProva.id}','${rapporto.prova.data}','${rapporto.prova.strumento.id}','${rapporto.prova.campione.id}','${rapporto.prova.operatore.id}','${rapporto.prova.esito}', '${rapporto.prova.filename_excel }','${rapporto.prova.filename_img }','${utl:escapeJS(rapporto.prova.note) }','${utl:escapeJS(rapporto.prova.ubicazione) }')"><i class="fa fa-edit"></i></a>

<c:if test="${rapporto.prova.matrixSpess!=null && rapporto.prova.matrixSpess!=''}">
<a class="btn btn-info customTooltip" title="Click per generare l'anteprima di stampa" onClick="generaCertificatoAM('${utl:encryptData(rapporto.prova.id)}', 1)"><i class="fa fa-print"></i></a>
<a class="btn btn-success customTooltip" title="Click per generare il certificato" onClick="modalYesOrNo('${utl:encryptData(rapporto.prova.id)}')"><i class="fa fa-check"></i></a>
</c:if>
</c:if>


<c:if test="${rapporto.stato.id == 2}">
<a target="_blank"   class="btn btn-danger customTooltip" title="Click per scaricare il Cerificato"  href="amGestioneInterventi.do?action=download_certificato&id_prova=${utl:encryptData(rapporto.prova.id)}" > <i class="fa fa-file-pdf-o"></i></a>
 
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
          
          
      











  



</section>
   
  </div>
  <!-- /.content-wrapper -->
  
  <form id="nuovaProvaForm" name="nuovaProvaForm">
   <div id="modalNuovaProva" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" >
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Prova</h4>
      </div>
       <div class="modal-body">
       <div class="row">
        <div class="col-xs-12">
        
        <div class="row">
       	<div class="col-sm-3">
       		<label>Tipo Prova</label>
       	</div>
       	<div class="col-sm-9">
				<select  id="tipo_prova" name="tipo_prova" class="form-control select2" aria-hidden="true" data-live-search="true" data-placeholder="Seleziona tipo prova..." style="width:100%" required>
				<option value="" ></option>
				<c:forEach items="${lista_tipi_prova}" var="tipo">
				
				<option value="${tipo.id }" >${tipo.descrizione }</option>
					
				</c:forEach>
				</select>
       	</div>
       </div><br>
        
		 <div class="row">
       	<div class="col-sm-3">
       		<label>Oggetto Prova</label>
       	</div>
       	<div class="col-sm-9">
				<select id="strumento" name="strumento" class="form-control select2"
        aria-hidden="true" data-live-search="true"
        data-placeholder="Seleziona strumento..." style="width:100%" required>
    <option value=""></option>
    <c:forEach var="str" items="${lista_strumenti}">
        <c:set var="presente" value="false" />
        
        <c:forEach var="rap" items="${lista_rapporti}">
            <c:if test="${rap.prova.strumento.id == str.id}">
                <c:set var="presente" value="true" />
            </c:if>
        </c:forEach>

        <option value="${str.id}" 
                <c:if test="${presente}">disabled</c:if>>
            ${str.descrizione} - ${str.nFabbrica}
        </option>
    </c:forEach>
</select>
       	</div>
       </div><br>
 
 	<div class="row">
       	<div class="col-sm-3">
       		<label>Campione</label>
       	</div>
       	<div class="col-sm-9">
				<select  id="campione" name="campione" class="form-control select2" aria-hidden="true" data-live-search="true" data-placeholder="Seleziona campione..." style="width:100%" required>
				<option value="" ></option>
				<c:forEach items="${lista_campioni }" var="cmp">
				
				<c:if test="${cmp.statoCampione=='S' }">
				<option value="${cmp.id }" >${cmp.denominazione } - ${cmp.codiceInterno }</option>
					</c:if>
				</c:forEach>
				</select>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Prova</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date datepicker' id='datepicker_data_prova'>
               <input type='text' class="form-control input-small" id="data_prova" name="data_prova" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Ubicazione</label>
       	</div>
       	<div class="col-sm-9">
				<input type="text" class="form-control" id="ubicazione" name="ubicazione"> 
       	</div>
       		
       </div><br>
       
        <div class="row">
       <!-- <div class="col-xs-12"> -->
       <div class="col-xs-4">
			<span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Carica Excel...</span>
				<input accept=".xls,.xlsx,.xlsm,.xlsxm"  id="fileupload_excel" name="fileupload_excel" type="file"  >
		       
		   	 </span>
		   	</div> 
		 <div class="col-xs-8">
		 <label id="label_excel"></label>
		 </div>
		<!-- </div>  -->
		</div><br>
	 
		
		
			<div class="row">
       	<div class="col-sm-3">
       		<label>Assistente</label>
       	</div>
       	<div class="col-sm-9">
				<select  id="operatore" name="operatore" class="form-control select2" aria-hidden="true" data-live-search="true" data-placeholder="Seleziona operatore..." style="width:100%" required>
				<option value="" ></option>
				<c:forEach items="${lista_operatori }" var="op">
				
				<option value="${op.id }" >${op.nomeOperatore }</option>
					
				</c:forEach>
				</select>
       	</div>
       		
       </div><br>
		
		<div class="row">
       	<div class="col-sm-3">
       		<label>Esito</label>
       	</div>
       	<div class="col-sm-9">
				<select  id="esito" name="esito" class="form-control select2" aria-hidden="true" data-live-search="true" data-placeholder="Seleziona esito..." style="width:100%" >
				<option value="" ></option>
				<option value="0" ></option>
				<option value="POSITIVO" >CONFORME A SPECIFICA</option>
				<option value="NEGATIVO" >NON CONFORME A SPECIFICA</option>
			
				</select>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Note</label>
       	</div>
       	<div class="col-sm-9">
				<textarea rows="3" style="width:100%" id="note" name="note"class="form-control" ></textarea>
       	</div>
       </div><br>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      
      <input type="hidden" id="id_intervento" name="id_intervento" value="${intervento.id }">
      
      <button type="submit" class="btn btn-primary">Salva</button>
      <!-- <a class="btn btn-primary pull-right"  style="margin-right:5px"  onClick="$('#modalNuovaProva').modal('hide')">Chiudi</a> -->
      
      </div>
   
  </div>
  </div>
</div>

</form>









<form id="modificaProvaForm" name="modificaProvaForm">
   <div id="modalModificaProva" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" >
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Prova</h4>
      </div>
       <div class="modal-body">
       <div class="row">
        <div class="col-xs-12">
        
        <div class="row">
       	<div class="col-sm-3">
       		<label>Tipo Prova</label>
       	</div>
       	<div class="col-sm-9">
				<select  id="tipo_prova_mod" name="tipo_prova_mod" class="form-control select2" aria-hidden="true" data-live-search="true" data-placeholder="Seleziona tipo prova..." style="width:100%" required>
				<option value="" ></option>
				<c:forEach items="${lista_tipi_prova}" var="tipo">
				
				<option value="${tipo.id }" >${tipo.descrizione }</option>
					
				</c:forEach>
				</select>
       	</div>
       </div><br>
        
		 <div class="row">
       	<div class="col-sm-3">
       		<label>Oggetto Prova</label>
       	</div>
       	<div class="col-sm-9">
				<select  id="strumento_mod" name="strumento_mod" class="form-control select2" aria-hidden="true" data-live-search="true" data-placeholder="Seleziona strumento..." style="width:100%" required>
				<option value="" ></option>
				<c:forEach items="${lista_strumenti }" var="str">
				
				<option value="${str.id }" >${str.descrizione } - ${str.nFabbrica }</option>
					
				</c:forEach>
				</select>
       	</div>
       </div><br>
 
 	<div class="row">
       	<div class="col-sm-3">
       		<label>Campione</label>
       	</div>
       	<div class="col-sm-9">
				<select  id="campione_mod" name="campione_mod" class="form-control select2" aria-hidden="true" data-live-search="true" data-placeholder="Seleziona campione..." style="width:100%" required>
				<option value="" ></option>
				<c:forEach items="${lista_campioni }" var="cmp">
				
				<c:if test="${cmp.statoCampione=='S' }">
				<option value="${cmp.id }" >${cmp.denominazione } - ${cmp.codiceInterno }</option>
					</c:if>
					
				</c:forEach>
				</select>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Prova</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date datepicker' id='datepicker_data_prova'>
               <input type='text' class="form-control input-small" id="data_prova_mod" name="data_prova_mod" required  >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Ubicazione</label>
       	</div>
       	<div class="col-sm-9">
				<input type="text" class="form-control" id="ubicazione_mod" name="ubicazione_mod"> 
       	</div>
       		
       </div><br>
       
        <div class="row">
       <!-- <div class="col-xs-12"> -->
       <div class="col-xs-4">
			<span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Carica Excel...</span>
				<input accept=".xls,.xlsx,.xlsm,.xlsxm"  id="fileupload_excel_mod" name="fileupload_excel_mod" type="file"  >
		       
		   	 </span>
		   	</div> 
		 <div class="col-xs-8">
		 <label id="label_excel_mod"></label>
		 </div>
		<!-- </div>  -->
		</div><br>
	     
		
		
			<div class="row">
       	<div class="col-sm-3">
       		<label>Assistente</label>
       	</div>
       	<div class="col-sm-9">
				<select  id="operatore_mod" name="operatore_mod" class="form-control select2" aria-hidden="true" data-live-search="true" data-placeholder="Seleziona operatore..." style="width:100%" >
				<option value="" ></option>
				<c:forEach items="${lista_operatori }" var="op">
				
				<option value="${op.id }" >${op.nomeOperatore }</option>
					
				</c:forEach>
				</select>
       	</div>
     
       </div><br>
		
		<div class="row">
       	<div class="col-sm-3">
       		<label>Esito</label>
       	</div>
       	<div class="col-sm-9">
				<select  id="esito_mod" name="esito_mod" class="form-control select2" aria-hidden="true" data-live-search="true" data-placeholder="Seleziona esito..." style="width:100%" >
				<option value="" ></option>
				<option value="0" ></option>
				<option value="POSITIVO" >CONFORME A SPECIFICA</option>
				<option value="NEGATIVO" >NON CONFORME A SPECIFICA</option>
			
				</select>
       	</div>
       </div><br>
       
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Note</label>
       	</div>
       	<div class="col-sm-9">
				<textarea rows="3" class="form-control" style="width:100%" id="note_mod" name="note_mod" ></textarea>
       	</div>
       </div><br>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      
      <input type="hidden" id="id_intervento_mod" name="id_intervento_mod" value="${intervento.id }">
      <input type="hidden" id="id_prova" name="id_prova">
      
      <button type="submit" class="btn btn-primary">Salva</button>
      <!-- <a class="btn btn-primary pull-right"  style="margin-right:5px"  onClick="$('#modalNuovaProva').modal('hide')">Chiudi</a> -->
      
      </div>
   
  </div>
  </div>
</div>

</form>


<form id="formPatentino" name="formPatentino">

<div id="modalPatentino" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Patentino</h4>
      </div>
       <div class="modal-body">
		<div class="row">
       	<div class="col-sm-3">
       		<label>Dicitura Firma</label>
       	</div>
       	<div class="col-sm-9">
       
               <input type='text' class="form-control input-small" id="dicitura" name="dicitura" required>
             
        </div> 
       	
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Patentino</label>
       	</div>
       	<div class="col-sm-3">
       			<span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Carica Patentino...</span>
				<input accept=".pdf"  id="file_patentino" name="file_patentino" type="file" >
		       
		   	 </span>
		   	</div> 
		 <div class="col-xs-6">
		 <label id="label_patentino"></label>
        </div> 
       
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Firma</label>
       	</div>
       	<div class="col-sm-3">
       			<span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Carica Firma...</span>
				<input accept=".png, .jpg"  id="file_firma" name="file_firma" type="file" >
		       
		   	 </span>
		   	</div> 
		 <div class="col-xs-6">
		 <label id="label_firma"></label>
        </div> 
       
       </div><br>
   
  		 </div>
      <div class="modal-footer" id="myModalFooter">
      <input id="id_operatore" name="id_operatore" type="hidden">
 		
       <button class="btn btn-primary" type="submit">Salva</button>
      </div>
    </div>
  </div>
</div>
</form>
	
	   <div id="myModalCambiaSede" class="modal fade " role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci il nome della sede cliente</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       
        <div class="form-inline" align="center"> 
      <input style="width:80%"   type="text" class="form-control"   id="nome_sede_new" name="nome_sede_new" value="${intervento.nomeSede}"/>
      <button id="nome_sede_button" class="btn btn-default" style="padding-left:17px" >Salva</button>
	 
 </div> 

  </div>
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

       
      </div>
    </div>
  </div>
</div>

	   <div id="myModalCambiaSedeUtilizzatore" class="modal fade " role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci il nome della sede utilizzatore</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       
        <div class="form-inline" align="center"> 
      <input style="width:80%"   type="text" class="form-control"   id="nome_sede_utilizzatore_new" name="nome_sede_utilizzatore_new" value="${intervento.nomeSedeUtilizzatore}"/>
      <button id="nome_sede_utilizzatore_button" class="btn btn-default" style="padding-left:17px" >Salva</button>
	 
 </div> 

  </div>
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

       
      </div>
    </div>
  </div>
</div>
	
	
	<div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler generare il rapporto?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_prova_rapporto">
      <a class="btn btn-primary" onclick="generaCertificatoAM($('#id_prova_rapporto').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
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
 
 
 

 function cambiaStatoInterventoAM(id_intervento,stato){
	 
 	  pleaseWaitDiv = $('#pleaseWaitDialog');
 	  pleaseWaitDiv.modal();
 	  var dataObj = {};
 	  dataObj.id_intervento = id_intervento;
 	  dataObj.stato = stato;
 	  callAjax(dataObj, "amGestioneInterventi.do?action=cambia_stato_intervento",function(data, textStatus){
 		 pleaseWaitDiv.modal('hide');
		  $(".ui-tooltip").remove();
		  if(data.success)
		  { 
			  if(stato == 1){
				 $("#statoa_"+data.id_intervento).html('<a href="#" class="customTooltip" title="Click per chiudere l\'Intervento"  onClick="cambiaStatoInterventoAM(\''+id_intervento+'\',1)" id="statoa_'+data.id_intervento+'"><span  class="label label-success">APERTO</span></a>');
			  }else{
				 $("#statoa_"+data.id_intervento).html('<a href="#" class="customTooltip" title="Click per aprire l\'Intervento"  onClick="cambiaStatoInterventoAM(\''+id_intervento+'\',0)" id="statoa_'+data.id_intervento+'"><span class="label label-warning">CHIUSO</span></a>');
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
 	  })
 	  
 	
 }

 
 
 
 
 function nuovaProva(){
	 $('#modalNuovaProva').modal();
 }
 
 function modalPatentino(id_operatore, dicitura, filename_patentino, filename_firma){
	 
	 $('#dicitura').val(dicitura);
	 $('#label_patentino').html(filename_patentino)
	 
	 $('#label_firma').html(filename_firma);
	 
	 $('#id_operatore').val(id_operatore);
	 
	 $('#modalPatentino').modal();
 }
 
 

 $('#formPatentino').on('submit', function(e){
	 
	 e.preventDefault()
	 callAjaxForm('#formPatentino','amGestioneInterventi.do?action=salva_patentino');
	 
 })
	 
	 

 
 
 function modalYesOrNo(id_prova){

	 
		$('#id_prova_rapporto').val(id_prova)
		 
		 
		 $('#myModalYesOrNo').modal();
	
	

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
	    	
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables1[$(this).index()].search.search+'" type="text" /></div>');	
	
	    	 $('#checkAll').iCheck({
	             checkboxClass: 'icheckbox_square-blue',
	             radioClass: 'iradio_square-blue',
	             increaseArea: '20%' // optional
	           }); 
	       	
	    	} );
	    
	    
	} );
	

	$('#fileupload_excel').change(function(){
		
		
		$('#label_excel').html($(this).val().split("\\")[2]);
	});
	
$('#fileupload_img').change(function(){
		
		
		$('#label_img').html($(this).val().split("\\")[2]);
	});
	
	
$('#fileupload_excel_mod').change(function(){
	
	
	$('#label_excel_mod').html($(this).val().split("\\")[2]);
});

$('#fileupload_img_mod').change(function(){
	
	
	$('#label_img_mod').html($(this).val().split("\\")[2]);
});


$('#file_patentino').change(function(){
	
	
	$('#label_patentino').html($(this).val().split("\\")[2]);
});

$('#file_firma').change(function(){
	
	
	$('#label_firma').html($(this).val().split("\\")[2]);
});


$('#note_intervento').focusout(function(){
	
	
	 var note = $(this).val();
	 var dataObj = {}
	 dataObj.note = note;
	 dataObj.id_intervento = "${intervento.id}";
	 callAjax(dataObj,"amGestioneInterventi.do?action=note_intervento", function(data){
	
			  if(!data.success){
	 			  
		 		  
	 			  $('#myModalErrorContent').html("Errone nel salvataggio delle note intervento!");
	 			  	$('#myModalError').removeClass();
	 				$('#myModalError').addClass("modal modal-danger");
	 				$('#report_button').show();
	 				$('#visualizza_report').show();
						$('#myModalError').modal('show');	      			 
	 		  }
		 
	 })
});
	
function modalModificaProva(id_prova, id_tipo, data, id_strumento, id_campione, id_operatore, esito, filename_excel, filename_img, note, ubicazione){
	$('#isMod').val(1)
	
	$('#id_prova').val(id_prova);
	$('#tipo_prova_mod').val(id_tipo);
	$('#tipo_prova_mod').change();
	
	$('#strumento_mod').val(id_strumento);
	$('#strumento_mod').change();
	
	$('#campione_mod').val(id_campione);
	$('#campione_mod').change();
	
	$('#operatore_mod').val(id_operatore);
	$('#operatore_mod').change();
	
	$('#esito_mod').val(esito);
	$('#esito_mod').change();
	$('#note_mod').val(note);
	$('#ubicazione_mod').val(ubicazione)
	
	
	if(data!=null && data!=''){
		var date = new Date(data);
		const formattedDate = date.toLocaleDateString('it-IT'); 
		$('#data_prova_mod').val(formattedDate);	
	}
	$('#label_excel_mod').html(filename_excel);
	$('#label_img_mod').html(filename_img);
	
	$('#modalModificaProva').modal()
	
}	

$('#esito').change(function(){
	
	if($(this).val() == "POSITIVO"){
		$('#note').val("NON SI RILEVANO SPESSORI INFERIORI A QUELLI MINIMI AMMISSIBILI / NOMINALI DICHIARATI DAL COSTRUTTORE")
	}else if($(this).val() == "NEGATIVO"){
		$('#note').val("SI RILEVANO SPESSORI INFERIORI A QUELLI MINIMI AMMISSIBILI / NOMINALI DICHIARATI DAL COSTRUTTORE");
	}else if($(this).val() == "0"){
		$('#note_mod').val("");
	}
	
});

$('#esito_mod').change(function(){
	
	if($(this).val() == "POSITIVO"){
		$('#note_mod').val("NON SI RILEVANO SPESSORI INFERIORI A QUELLI MINIMI AMMISSIBILI / NOMINALI DICHIARATI DAL COSTRUTTORE")
	}else if($(this).val() == "NEGATIVO"){
		$('#note_mod').val("SI RILEVANO SPESSORI INFERIORI A QUELLI MINIMI AMMISSIBILI / NOMINALI DICHIARATI DAL COSTRUTTORE");
	}else if($(this).val() == "0"){
		$('#note_mod').val("");
	}
	
});

function generaCertificatoAM(id_prova, isAnteprima){
	
	dataObj={};
	dataObj.id_prova = id_prova;
	dataObj.isAnteprima = isAnteprima;
	pleaseWaitDiv.modal()
	
	if(isAnteprima!=null && isAnteprima ==1){
		
		var newTab = window.open('', '_blank');
		callAjax(dataObj, "amGestioneInterventi.do?action=genera_certificato", function(data) {
			
			if (data.success) {
				var url = "amGestioneInterventi.do?action=download_certificato&isAnteprima=1&id_prova=" + id_prova;

				newTab.location.href = url;
			} else {

				newTab.close();
			}
		});
	}else{
		callAjax(dataObj, "amGestioneInterventi.do?action=genera_certificato")
	}
	
	
}
	
    $(document).ready(function() { 
    	
    	
    	$('.select2').select2();
    	$('.datepicker').datepicker({
   		 format: "dd/mm/yyyy"
   	 });
    
	var dataIntervento = '${intervento.dataIntervento}';
    var dateParts = dataIntervento.split(' ')[0];
    var parts = dateParts.split('-'); 
    var formattedDate = parts[2] + '/' + parts[1] + '/' + parts[0];
    $('#data_prova').val(formattedDate);
    	 
	    	
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
	    	      order:[[0,'desc']],
	    	  
	    	      columnDefs: [
	    	   
					  { responsivePriority: 1, targets: 0 },
	    	          { responsivePriority: 2, targets: 9 }
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
	
	
	
	
	
	
	
	
    });

    function inserisciSede(id_intervento){

   	 $("#myModalCambiaSede").modal();
   
    }
    function inserisciSedeUtilizzatore(id_intervento){

      	 $("#myModalCambiaSedeUtilizzatore").modal();
      
       }
    
	
    $("#nome_sede_button").on('click', function(){
   	 
   	 var nome_sede = $("#nome_sede_new").val();
   	 var id_intervento = '${intervento.id}';
   	inserisciNuovaSedeAM(nome_sede, id_intervento,1);	
   	 
    })
    
    $("#nome_sede_utilizzatore_button").on('click', function(){
   	 
   	 var nome_sede = $("#nome_sede_utilizzatore_new").val();
   	 var id_intervento = '${intervento.id}';
   	inserisciNuovaSedeAM(nome_sede, id_intervento,2);	
   	 
    })
	
	
	
 	       	 $('#myModalError').on('hidden.bs.modal', function (e) {
	       		if($('#myModalError').hasClass('modal-success')){
	     			location.reload();
	     		 }
	        	}); 

	       	 
 	        $('#nuovaProvaForm').on("submit", function(e){

 	      	 e.preventDefault();
 	      	 
 	      	 callAjaxForm('#nuovaProvaForm','amGestioneInterventi.do?action=nuova_prova');
 	      	 
 	       });
 	       
 	       $('#modificaProvaForm').on("submit", function(e){

 	 	      	 e.preventDefault();
 	 	      	 
 	 	      	 callAjaxForm('#modificaProvaForm','amGestioneInterventi.do?action=modifica_prova');
 	 	      	 
 	 	       });

  </script>
</jsp:attribute> 
</t:layout>







