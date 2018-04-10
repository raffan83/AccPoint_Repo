<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
        Dettaglio Pacco
        <small></small>
      </h1>
      
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
	 Dati Pacco
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${pacco.id}</a>
                </li>
                 <li class="list-group-item">
                  <b>Data Lavorazione</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${pacco.data_lavorazione}" /></a>
                </li>
                <li class="list-group-item">
                  <b>Codice Pacco</b> <a class="pull-right">${pacco.codice_pacco}</a>
                </li>
                <li class="list-group-item">
                  <b>Stato</b> <a class="pull-right">${pacco.stato_lavorazione.descrizione}</a>
                </li>
                <li class="list-group-item">
                  <b>Cliente</b> <a class="pull-right">${pacco.nome_cliente}</a>
                </li>
                <li class="list-group-item">
                  <b>Sede</b> <a class="pull-right">${pacco.nome_sede}</a>
                </li>
                <li class="list-group-item">
                  <b>Responsabile</b> <a class="pull-right">${pacco.utente.nominativo} </a>
                </li>
                <li class="list-group-item">
                  <b>Commessa</b> <a class="pull-right">${pacco.commessa} </a>
                </li>
                <c:if test="${pacco.ddt.numero_ddt !=''}">
                <li class="list-group-item">
                  <b>DDT</b> <a href="#" class="pull-right btn customTooltip customlink" title="Click per aprire il dettaglio del DDT" onclick="callAction('gestioneDDT.do?action=dettaglio&id=${pacco.ddt.id}')">${pacco.ddt.numero_ddt} </a>
                </li></c:if>
                
        </ul>

</div>
</div>
</div>
</div>


 <div class="form-group">
 <label>Item Nel Pacco</label>
<table id="tabItems" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th>ID Item</th>
 <th>Tipo</th>
 <th>Denominazione</th>
 <th>Stato</th>
 <th>Quantità</th>
 <th>Note</th>


 </tr></thead>
 
 <tbody id="tbodyitem">
 
  <c:forEach items="${lista_item_pacco}" var="item_pacco" varStatus="loop">
  <tr>
  <c:choose>
  <c:when test="${item_pacco.item.tipo_item.descrizione =='Strumento'}">
  <td><a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio dello strumento" onclick="dettaglioStrumento('${item_pacco.item.id_tipo_proprio}')">${item_pacco.item.id_tipo_proprio}</a></td></c:when>
   <c:otherwise>
    <td>${item_pacco.item.id_tipo_proprio }</td></c:otherwise> </c:choose>
  <td>${item_pacco.item.tipo_item.descrizione }</td>
  <td>${item_pacco.item.descrizione }</td>
  <td>${item_pacco.item.stato.descrizione }</td>
  <td>${item_pacco.quantita}</td>
  <td>${item_pacco.note }</td>
  </tr>
  
  </c:forEach>
 

</tbody>
 </table>
 
 
 </div>




 <button class="btn btn-primary" onClick="modificaPacco()"><i class="fa fa-pencil-square-o"></i> Modifica Pacco</button> 




            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
        

        
 </div>
</div>
       
     </section>   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">


      </div>
      
      
      <form name="ModificaPaccoForm" method="post" id="ModificaPaccoForm" action="gestionePacco.do?action=new" enctype="multipart/form-data">
         <div id="myModalModificaPacco" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
          
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Pacco</h4>
      </div>
 
       <div class="modal-body" id="myModalDownloadSchedaConsegnaContent">
 
 
     <div class="form-group">
                  <label>Cliente</label>
                  <select name="select1" id="select1" data-placeholder="Seleziona Cliente..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
                  <option value="${pacco.id_cliente }_${pacco.nome_cliente}">${pacco.nome_cliente }</option>
                  <c:if test="${userObj.idCliente != 0}">
                  
                      <c:forEach items="${lista_clienti}" var="cliente">
                       <c:if test="${userObj.idCliente == cliente.__id}">
                           <option value="${cliente.__id}_${cliente.nome}">${cliente.nome}</option> 
                        </c:if>
                     </c:forEach>
                  
                  
                  </c:if>
                 
                  <c:if test="${userObj.idCliente == 0}">
                  <!-- <option value=""></option> -->
                      <c:forEach items="${lista_clienti}" var="cliente">
                           <option value="${cliente.__id}_${cliente.nome}">${cliente.nome}</option> 
                     </c:forEach>
                  
                  
                  </c:if>
                    
                  </select>
        </div> 
        


        
        
         <div class="form-group">
                  <label>Sede</label>
                  <select name="select2" id="select2" data-placeholder="Seleziona Sede"  disabled class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
                    <c:if test="${userObj.idSede != 0}">
                    <option value="${pacco.id_sede }_${pacco.nome_cliente}__${pacco.nome_sede}">${pacco.nome_cliente} - ${pacco.nome_sede }</option>
             			<c:forEach items="${lista_sedi}" var="sedi">
             			  <c:if test="${userObj.idSede == sedi.__id}">
                          	 <option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}__${sedi.indirizzo}">${sedi.descrizione} - ${sedi.indirizzo}</option>     
                          </c:if>                       
                     	</c:forEach>
                     </c:if>
                     
                     <c:if test="${userObj.idSede == 0}">
                    	     <option value=""></option>    
             			<c:forEach items="${lista_sedi}" var="sedi">
             			 	<c:if test="${userObj.idCliente != 0}">
             			 		<c:if test="${userObj.idCliente == sedi.id__cliente_}">
             			 		
                          	 		<option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}__${sedi.indirizzo}">${sedi.descrizione} - ${sedi.indirizzo}</option>       
                          	 	</c:if>      
                          	</c:if>     
                          	<c:if test="${userObj.idCliente == 0}">
                           	 		<option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}__${sedi.indirizzo}">${sedi.descrizione} - ${sedi.indirizzo}</option>
                           	 		
                           	</c:if>                  
                     	</c:forEach>
                     </c:if>
                  </select>
                  
        </div> 
        
<div class="form-group">
 
                  <label>Commessa</label>
     <div class="row" style="margin-down:35px;">    
 <div class= "col-xs-6">             
                  <select name="commessa" id="commessa" data-placeholder="Seleziona Commessa..."  class="form-control select2 pull-left" style="width:100%"  aria-hidden="true" data-live-search="true">
                   <option value=""></option>   
             			<c:forEach items="${lista_commesse}" var="commessa">
                          	 <option value="${commessa.ID_COMMESSA}">${commessa.ID_COMMESSA}</option>   
                     	</c:forEach>
                  </select> 
  </div>
   <div class= "col-xs-6">
                
                  <input type="text" id="commessa_text" name="commessa_text" class="form-control pull-right" value="${pacco.commessa}" style="margin-down:35px;">
   </div>
 </div>
</div>
        

<div class="form-group">
   <div class="row" style="margin-down:35px;">                 
<div class= "col-xs-6">

            <b>Codice Pacco</b><br>
             <a class="pull-center" ><input type="text" class="pull-left form-control" id=codice_pacco name="codice_pacco" value="${pacco.codice_pacco }"style="margin-top:6px;" readonly ></a> 
        </div>
        <div class= "col-xs-6">
	 
         <label class="pull-center">Stato Lavorazione</label> <select name="stato_lavorazione" id="stato_lavorazione" data-placeholder="Seleziona Stato Lavorazione" class="form-control select2-drop"   aria-hidden="true" data-live-search="true">
     		<option value=${pacco.stato_lavorazione.id }>${pacco.stato_lavorazione.descrizione}</option>
                   		<c:forEach items="${lista_stato_lavorazione}" var="stato">
                   		<c:if test="${stato.id != pacco.stato_lavorazione.id}">
                          	 <option value="${stato.id}">${stato.descrizione}</option>    
                          	 </c:if>
                     	</c:forEach>
                  </select>
                  
        </div>
</div >
</div>


  <div class="form-group" >

 <div id="collapsed_box" class="box box-danger box-solid collapsed-box" >
<div class="box-header with-border" >
	 DDT
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-plus"></i></button>

	</div>
</div>
<div class="box-body">
	<div class= "col-md-4">
	<ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <label>Numero DDT</label> <a class="pull-center"><input type="text" class="form-control" value="${pacco.ddt.numero_ddt}" id="numero_ddt" name="numero_ddt" ></a>
				
				<li class="list-group-item">
	<label>Tipo Trasporto</label><select name="tipo_trasporto" id="tipo_trasporto" data-placeholder="Seleziona Tipo Trasporto" class="form-control select2-drop "  aria-hidden="true" data-live-search="true">	
		<c:forEach items="${lista_tipo_trasporto}" var="tipo_trasporto">
			<option value="${tipo_trasporto.id}">${tipo_trasporto.descrizione}</option>
		</c:forEach>
	</select>
	</li>
	<li class="list-group-item">
	<label>Tipo Porto</label><select name="tipo_porto" id="tipo_porto" data-placeholder="Seleziona Tipo Porto"  class="form-control select2-drop " aria-hidden="true" data-live-search="true">
		<c:forEach items="${lista_tipo_porto}" var="tipo_porto">
			<option value="${tipo_porto.id}">${tipo_porto.descrizione}</option>
		</c:forEach>
	</select>
	</li>
	<li class="list-group-item">
	<label>Tipo DDT</label><select name="tipo_ddt" id="tipo_ddt" data-placeholder="Seleziona Tipo DDT" class="form-control "  aria-hidden="true" data-live-search="true">
		<c:forEach items="${lista_tipo_ddt}" var="tipo_ddt">
			<option value="${tipo_ddt.id}">${tipo_ddt.descrizione}</option>			
		</c:forEach>
	</select>
	</li>
	
			<li class="list-group-item">
          <label>Data DDT</label>    
      
            <div class='input-group date' id='datepicker_ddt'>
               <input type='text' class="form-control input-small" id="data_ddt" name="data_ddt" value="${pacco.ddt.data_ddt }"/>
                <span class="input-group-addon">
                    <span class="fa fa-calendar">
                    </span>
                </span>
           
        </div> 

		</li>
	<li class="list-group-item">
	<label>Aspetto</label><select name="aspetto" id="aspetto" data-placeholder="Seleziona Tipo Aspetto"  class="form-control select2-drop " aria-hidden="true" data-live-search="true">
		<c:forEach items="${lista_tipo_aspetto}" var="aspetto">	
			<option value="${aspetto.id}">${aspetto.descrizione}</option>			
		</c:forEach>
	</select>
	</li>
	</ul>
	
	</div>
	
	<div class= "col-md-4">
	<ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <label>Causale</label> <a class="pull-center"><input type="text" class="form-control" value="${pacco.ddt.causale_ddt }" id="causale" name="causale" ></a>
                
				</li>
				<li class="list-group-item">
                  <label>Destinatario</label> <a class="pull-center"><input type="text" class="form-control" value="${pacco.ddt.nome_destinazione }" id="destinatario" name="destinatario"></a>
				
	</li>
	<li class="list-group-item">
                  <label>Via</label> <a class="pull-center"><input type="text" class="form-control" value="${pacco.ddt.indirizzo_destinazione }" id="via" name="via"></a>
				
			
	</li>
	<li class="list-group-item">
                  <label>Città</label> <a class="pull-center"><input type="text" class="form-control" value="${pacco.ddt.citta_destinazione}" id="citta" name="citta"></a>
				
				
	</li>
	<li class="list-group-item">
                  <label>CAP</label> <a class="pull-center"><input type="text" class="form-control" value="${pacco.ddt.cap_destinazione }" id="cap" name="cap"></a>
				
			
	</li>
	
	<li class="list-group-item">
                  <label>Provincia</label> <a class="pull-center"><input type="text" class="form-control" value="${pacco.ddt.provincia_destinazione }" id="provincia" name="provincia"> </a>
				
				
	</li>
	<li class="list-group-item">
                  <label>Paese</label> <a class="pull-center"><input type="text" class="form-control" value="${pacco.ddt.paese_destinazione }" id="paese" name="paese"></a>
				
				
	</li>

	</ul>
	
	
	
	</div>
	
	<div class= "col-md-4">
	<ul class="list-group list-group-unbordered">
 		<li class="list-group-item">
          <label>Data e Ora Trasporto</label>    

        <div class="input-group date"  id="datetimepicker" >
                     <input type="text" class="form-control date input-small" id="data_ora_trasporto" value="${pacco.ddt.data_trasporto } ${pacco.ddt.ora_trasporto }" name="data_ora_trasporto"/>
            
            <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
        </div>

		</li> 
	

		<li class="list-group-item">
                  <label>Spedizioniere</label> <!-- <a class="pull-center"><input type="text" class="pull-right" id="spedizioniere" name="spedizioniere"> </a> -->
				<select name="spedizioniere" id="spedizioniere" data-placeholder="Seleziona Spedizioniere"  class="form-control select2-drop " aria-hidden="true" data-live-search="true">
		<c:forEach items="${lista_spedizionieri}" var="spedizioniere">
			<option value="${spedizioniere.id}">${spedizioniere.denominazione}</option>
		</c:forEach>
	</select>
				
				
				
	</li>
	<li class="list-group-item">
                  <label>Annotazioni</label> <a class="pull-center"><input type="text" class="form-control" value="${pacco.ddt.annotazioni }" id="annotazioni" name="annotazioni"> </a>
				
				<li class="list-group-item">
	</li>
	
	<li class="list-group-item">
                  <label>Note</label> <a class="pull-center">
				<textarea name="note" form="ModificaPaccoForm"  class="form-control" rows=5 cols = 10></textarea></a>
				<li class="list-group-item">
	</li>
	
		
	</ul>

		        <input id="fileupload" type="file" name="file" class="form-control"/>
	
</div>
</div>
</div>
</div>
	

 
<div class="form-group">
 <div class="box box-danger box-solid collapsed-box">
<div class="box-header with-border">
	 Item
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-plus"></i></button>

	</div>
</div>
<div class="box-body">	
<div class= "col-md-6">
	<ul class="list-group list-group-unbordered">
                <li class="list-group-item">
	<label>Tipo Item</label>
	<select name="tipo_item" id="tipo_item" data-placeholder="Seleziona Tipo item" class="-control select2-drop form-control"  aria-hidden="true" data-live-search="true">
		<c:forEach items="${lista_tipo_item}" var="tipo_item">
			<option value="${tipo_item.id}">${tipo_item.descrizione}</option>
		</c:forEach>
		
	</select>

	</li>
		
	</ul>

</div>

<div class= "col-md-6">

<button  class="btn btn-primary pull-left" style="margin-top:35px" onClick="inserisciItem()"><i class="fa fa-plus"></i></button>


</div>
</div>
</div>
</div>



 <div class="form-group">
 <label>Item Nel Pacco</label>
 <table id="tabItem" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th>ID Item</th>
 <th>Tipo</th>
 <th>Denominazione</th>
 <th>Quantità</th>
 <th>Stato</th>
 <th>Note</th> 
 <th>Action</th>


 </tr></thead>
 
 <tbody id="tbodymodifica">

</tbody>
 </table> 
 
 
 </div>

</div>


    
     <div class="modal-footer">

		<input type="hidden" class="pull-right" id="json" name="json">
		<input type="hidden" class="pull-right" id="id_pacco" name="id_pacco">
		<input type="hidden" class="pull-right" id="id_ddt" name="id_ddt">
		<input type="hidden" class="pull-right" id ="pdf_path" name="pdf_path" value="${pacco.ddt.link_pdf }">
		<button class="btn btn-default pull-left" onClick="modificaPaccoSubmit()"><i class="glyphicon glyphicon"></i> Modifica Pacco</button>  
        <!-- <button class="btn btn-default pull-left" type="submit"><i class="glyphicon glyphicon"></i> Inserisci Nuovo Pacco</button> -->  
   
    	
    </div>
    </div>
      </div>
    
      </div>

 </form>  
 
   <div id="myModalItem" class="modal fade " role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Lista Item</h4>
      </div>
       <div class="modal-body">
       <div id="listaItemTop"></div><br>
       <div id="listaItem"></div>
			 
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

       
      </div>
    </div>
  </div>
</div>
      
   

  <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabelHeader">Messaggio</h4>
      </div>
       <div class="modal-body">
			<div id="myModalErrorContent">
			
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
      </div>
    </div>
  </div>
</div>



  <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Strumento</h4>
      </div>
       <div class="modal-body">

        <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#dettaglio" data-toggle="tab" aria-expanded="true" onclick="" id="dettaglioTab">Dettaglio Strumento</a></li>
              <li class=""><a href="#misure" data-toggle="tab" aria-expanded="false" onclick="" id="misureTab">Misure</a></li>
       <!--        <li class=""><a href="#prenotazione" data-toggle="tab" aria-expanded="false" onclick="" id="prenotazioneTab">Stato Prenotazione</a></li> -->
        
 		<c:if test="${userObj.checkPermesso('MODIFICA_STRUMENTO_METROLOGIA')}">
               <li class=""><a href="#modifica" data-toggle="tab" aria-expanded="false" onclick="" id="modificaTab">Modifica Strumento</a></li>
		</c:if>		
		 <li class=""><a href="#documentiesterni" data-toggle="tab" aria-expanded="false" onclick="" id="documentiesterniTab">Documenti esterni</a></li>
             </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="dettaglio">

    			</div> 

              <!-- /.tab-pane -->
             
			  <div class="tab-pane" id="misure">
                

         
			 </div> 


              <!-- /.tab-pane -->


               		<c:if test="${userObj.checkPermesso('MODIFICA_STRUMENTO_METROLOGIA')}">
              
              			<div class="tab-pane" id="modifica">
              

              			</div> 
              		</c:if>		
              		
              		<div class="tab-pane" id="documentiesterni">
              

              			</div> 
              
            </div>
            <!-- /.tab-content -->
          </div>
    
        
        
        
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
       <!--  <button type="button" class="btn btn-primary" onclick="approvazioneFromModal('app')"  >Approva</button>
        <button type="button" class="btn btn-danger"onclick="approvazioneFromModal('noApp')"   >Non Approva</button> -->
      </div>
    </div>
  </div>
</div>



 
   <!-- <div id="modal1">Place at bottom of page</div>  -->

     <div id="errorMsg"><!-- Place at bottom of page --></div> 
  


   
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

<!-- </div> -->
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

  
        <link rel="stylesheet" type="text/css" href="plugins/datetimepicker/bootstrap-datetimepicker.css" /> 
		<link rel="stylesheet" type="text/css" href="plugins/datetimepicker/datetimepicker.css" /> 
</jsp:attribute>

<jsp:attribute name="extra_js_footer">


		
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
		 <script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
		 <script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.js"></script> 
<script type="text/javascript" src="http://www.datejs.com/build/date.js"></script>
 <script type="text/javascript">
 
 function inserisciItem(){
	 $('#listaItemTop').html('');
	 $('#codice_pacco').removeAttr('required');
		var id_cliente = document.getElementById("select1").value;
		var id_sede = document.getElementById("select2").value;
		var tipo_item = document.getElementById("tipo_item").value;
		inserisciItemModal(tipo_item,id_cliente,id_sede);
		};
 
	function modificaPaccoSubmit(){
		
		var json_data = JSON.stringify(items_json);
		var id_pacco= ${pacco.id};
		var id_ddt = ${pacco.ddt.id};
		$('#json').val(json_data);
		$('#id_pacco').val(id_pacco);
		$('#id_ddt').val(id_ddt);
		$('#codice_pacco').attr('required', 'true');
		var esito = validateForm();
		
		if(esito==true){
		document.getElementById("ModificaPaccoForm").submit();
		
		
		}
		else{};
	}

	function validateForm() {
	    var codice_pacco = document.forms["ModificaPaccoForm"]["codice_pacco"].value;
	    var numero_ddt = document.forms["ModificaPaccoForm"]["numero_ddt"].value;
	    var cliente = document.forms["ModificaPaccoForm"]["select1"].value;
	   
	    if (codice_pacco=="" || cliente =="") {
	      
	    	/* $('#collapsed_box').toggleBox(); */
	    	
	    	
	        return false;
	    }else{
	    	return true;
	    }
	}

 	function formatDate(data, container){
	
		   var mydate = new Date(data);
		   
		   if(!isNaN(mydate.getTime())){
		   if(container == '#data_ora_trasporto'){
			 str = mydate.toString("dd/MM/yyyy hh:mm");
		   }else{
			   str = mydate.toString("dd/MM/yyyy");
		   }
	   $(container).val(str );
 	}
	
	}
 
 	
 	
	$("#fileupload").change(function(event){
		
		var fileExtension = 'pdf';
        if ($(this).val().split('.').pop()!= fileExtension) {
        	
        	$('#myModalLabelHeader').html("Attenzione!");
        	
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#myModalErrorContent').html("Inserisci solo pdf!");
			$('#myModalError').modal('show');
        	
			$(this).val("");
        }
		
	});
 	
	
	function dettaglioStrumento(id_strumento){

		$('#myModalLabelHeader').html("");
    	
		$('#myModalError').removeClass();
		$('#myModalError').addClass("modal modal-success");
		$('#myModalError').css("z-index", "1070");
 	    	exploreModal("dettaglioStrumento.do","id_str="+id_strumento,"#dettaglio");
 	    	$( "#myModal" ).modal();
 	    	//$('body').addClass('noScroll');
 
	   $('a[data-toggle="tab"]').one('shown.bs.tab', function (e) {


       	var  contentID = e.target.id;

       	if(contentID == "dettaglioTab"){
       		exploreModal("dettaglioStrumento.do","id_str="+id_strumento,"#dettaglio");
       	}
       	if(contentID == "misureTab"){
       		exploreModal("strumentiMisurati.do?action=ls&id="+id_strumento,"","#misure")
       	}
       	if(contentID == "modificaTab"){
       		exploreModal("modificaStrumento.do?action=modifica&id="+id_strumento,"","#modifica")
       	}
       	if(contentID == "documentiesterniTab"){
       		exploreModal("documentiEsterni.do?id_str="+id_strumento,"","#documentiesterni")
       
       	}
       	
       	
       	

 		});
	   
	   $('#myModal').on('hidden.bs.modal', function (e) {

    	 	$('#dettaglioTab').tab('show');
    	 	
    	});
	   
	}
	
	var columsDatatables1 = [];
	  
	$("#tabItems").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    		columsDatatables1 = state.columns;
	    }
	    
	    $('#tabItems thead th').each( function () {
	    	if(columsDatatables1.length==0 || columsDatatables1[$(this).index()]==null ){columsDatatables1.push({search:{search:""}});}
	    	var title = $('#tabItems thead th').eq( $(this).index() ).text();
	    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables1[$(this).index()].search.search+'" type="text" /></div>');
	    	} );

	} );
	
/*  	var columsDatatables2 = [];
	  
 	$("#tabItem").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables2 = state.columns;
	    }
	    $('#tabItem thead th').each( function () {
	     	if(columsDatatables2.length==0 || columsDatatables2[$(this).index()]==null ){columsDatatables2.push({search:{search:""}});}
	    	var title = $('#tabItem thead th').eq( $(this).index() ).text();
	    	$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables2[$(this).index()].search.search+'"/></div>');
	    	} );

	} );   */
	
	$("#commessa").change(function(){
		
		$("#commessa_text").val($("#commessa").val());
		
	});
 
   $(document).ready(function() {

	   var data_ora_trasporto = $('#data_ora_trasporto').val()
	   var data_ddt = $('#data_ddt').val();
	   
	   formatDate(data_ora_trasporto, '#data_ora_trasporto');
	   
	   formatDate(data_ddt, '#data_ddt');

	 
		$('#datetimepicker').datetimepicker({
			format : "dd/mm/yyyy hh:ii",
			startDate : 'today'
		});

		
		$('#datepicker_ddt').datepicker({
			format : "dd/mm/yyyy",
		
		});
	   
 
 table = $('#tabItems').DataTable({
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
     pageLength: 10,
	      paging: true, 
	      ordering: true,
	      info: true, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	      stateSave: true,
	       columnDefs: [
				   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 2 }
	               ], 

	    	
	    });
	


	     $('.inputsearchtable').on('click', function(e){
	       e.stopPropagation();    
	    }); 
//DataTable
table = $('#tabItems').DataTable();
//Apply the search
table.columns().eq( 0 ).each( function ( colIdx ) {
$( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
   table
       .column( colIdx )
       .search( this.value )
       .draw();
} );
} ); 
	table.columns.adjust().draw();
	

$('#tabItems').on( 'page.dt', function () {
	$('.customTooltip').tooltipster({
     theme: 'tooltipster-light'
 });
	
	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	})


});
  


 
table = $('#tabItem').DataTable({
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
 pageLength: 10,
      paging: true, 
      ordering: true,
      info: true, 
      searchable: true, 
      targets: 0,
      responsive: true,
      scrollX: false,
      stateSave: true,
      columns : [
     	 {"data" : "id"},
     	 {"data" : "tipo"},
     	 {"data" : "denominazione"},
     	 {"data" : "quantita"},
     	 {"data" : "stato"},
     	 {"data" : "note"},
     	 {"data" : "action"}
      ],	
         columnDefs: [
			   { responsivePriority: 1, targets: 0 },
                   { responsivePriority: 2, targets: 1 },
                   { responsivePriority: 3, targets: 2 }
               ],  

    	
    });



/*    $('#tabItem thead th').each( function () {
var title = $('#tabItem thead th').eq( $(this).index() ).text();

$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');
} ) ;*/
/* =======

>>>>>>> branch 'master' of https://github.com/raffan83/AccPoint_Repo.git */
     $('.inputsearchtable').on('click', function(e){
       e.stopPropagation();    
    });    
//DataTable

 table = $('#tabItem').DataTable();
//Apply the search
table.columns().eq( 0 ).each( function ( colIdx ) {
$( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
table
   .column( colIdx )
   .search( this.value )
   .draw();
} );
} ); 
table.columns.adjust().draw(); 


   $('#tabItem').on( 'page.dt', function () {
$('.customTooltip').tooltipster({
 theme: 'tooltipster-light'
}); 

 $('.removeDefault').each(function() {
   $(this).removeClass('btn-default');
})  


}); 
 

$(".select2").select2();

if(idCliente != 0 && idSede != 0){
	 $("#select1").prop("disabled", true);
	$("#select2").change();
}else if(idCliente != 0 && idSede == 0){
	 $("#select1").prop("disabled", true);
	 $("#select2").prop("disabled", false);
	$("#select1").change();
}else{
	clienteSelected =  $("#select1").val();
	sedeSelected = $("#select2").val();
	
	if((clienteSelected != null && clienteSelected != "") && (sedeSelected != null && sedeSelected != "")){
		$("#select2").change();
		 $("#select2").prop("disabled", false);
		 $("#select1").prop("disabled", false);
	}else if((clienteSelected != null && clienteSelected != "") && (sedeSelected == null || sedeSelected == "")){
		$("#select1").change();
		 $("#select1").prop("disabled", false);
		 $("#select2").prop("disabled", false);
	}
}



 });  
   
   
    
   $("#select2").change(function(){
		
		var cliente = $('#select1').val();
		var sede = $('#select2').val();
		
		var str = cliente.split("_");
		
		$('#destinatario').val(str[1]);
		
		if(sede!=null){
			if(sede == "0"){
				$('#via').val("");	
			}else{
			
			var str2 = sede.split("_");
			if(str2[5]!=null){
				$('#via').val(str2[5]);	
			}else{
				var str3 = sede.split("-");
				$('#via').val(str3[2] + str3[3]);	
				}	
			}	
		}
	});
    
   
   var idCliente = ${userObj.idCliente}
   var idSede = ${userObj.idSede}

    $body = $("body");
      

     $("#select1").change(function() {
     
   	  if ($(this).data('options') == undefined) 
   	  {
   	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
   	    $(this).data('options', $('#select2 option').clone());
   	  }
   	  
   	  var selection = $(this).val()
   	 
   	  var id = selection.substring(0,selection.indexOf("_"));
   	  
   	  var options = $(this).data('options');

   	  var id_sede = ${pacco.id_sede };
   	  
   	  var opt=[];
   	

   	  if(${pacco.id_sede}==0){
   		opt.push("<option value = 0>Non Associate</option>");
   	  }else{
		
		opt.push("<option value='${pacco.id_sede}_${pacco.id_cliente}__${pacco.nome_sede}'>${pacco.nome_sede }</option>");
		
		if(id!=${pacco.id_cliente})
			opt.splice(0, 1);
		opt.push("<option value = 0>Non Associate</option>");
   	  }
   	   for(var  i=0; i<options.length;i++)
   	   {
   		var str=options[i].value; 
   	
   		//if(str.substring(str.indexOf("_")+1,str.length)==id)
   		if(str.substring(str.indexOf("_")+1,str.indexOf("__"))==id)
   		{
   			
   			//if(opt.length == 0){
   				
   			//}
   		
   			opt.push(options[i]);
   		}   
   	   }
   	 $("#select2").prop("disabled", false);   	 
   	  $('#select2').html(opt);   	  
   	  $("#select2").trigger("chosen:updated");   	  
   	  //if(opt.length<2 )
   	  //{ 
   		$("#select2").change();  
   	  //}
   	});
     
     
   	 $('#ModificaPaccoForm').on('submit',function(e){
   	 	    e.preventDefault();

   	 	});    
     


</script>
  
</jsp:attribute> 
</t:layout>


 
 
 
 



