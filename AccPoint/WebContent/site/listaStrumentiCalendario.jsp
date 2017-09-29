<%@page import="it.portaleSTI.DTO.ClassificazioneDTO"%>
<%@page import="it.portaleSTI.DTO.LuogoVerificaDTO"%>
<%@page import="it.portaleSTI.DTO.StatoStrumentoDTO"%>
<%@page import="it.portaleSTI.DTO.TipoStrumentoDTO"%>
<%@page import="it.portaleSTI.DTO.TipoRapportoDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="it.portaleSTI.DTO.StrumentoDTO"%>
<%@page import="it.portaleSTI.DTO.SedeDTO"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>

<jsp:directive.page import="it.portaleSTI.DTO.ClienteDTO"/>
<jsp:directive.page import="it.portaleSTI.DTO.StrumentoDTO"/>

<% 
JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonArray jsonElem = (JsonArray)json.getAsJsonArray("dataInfo");
Gson gson = new Gson();
Type listType = new TypeToken<ArrayList<StrumentoDTO>>(){}.getType();
ArrayList<StrumentoDTO> listaStrumenti = new Gson().fromJson(jsonElem, listType);

String idSede = (String)session.getAttribute("id_Sede");
String idCliente = (String)session.getAttribute("id_Cliente");

ArrayList<TipoRapportoDTO> listaTipoRapporto = (ArrayList)session.getAttribute("listaTipoRapporto");
ArrayList<TipoStrumentoDTO> listaTipoStrumento = (ArrayList)session.getAttribute("listaTipoStrumento");
ArrayList<StatoStrumentoDTO> listaStatoStrumento = (ArrayList)session.getAttribute("listaStatoStrumento");

ArrayList<LuogoVerificaDTO> listaLuogoVerifica = (ArrayList)session.getAttribute("listaLuogoVerifica");
ArrayList<ClassificazioneDTO> listaClassificazione = (ArrayList)session.getAttribute("listaClassificazione");


%>

<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Lista Strumwenti
        <small>Fai doppio click per entrare nel dettaglio</small>
      </h1>
    </section>

    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">
           </div>
            <div class="box-body">
              <div class="row">
        <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
<div class="row">
<div class="col-lg-12">

 <c:if test="${utente.checkPermesso('INSERIMENTO_CAMPIONE')}"> <button class="btn btn-primary" onClick="nuovoInterventoFromModal('#modalNuovoCampione')">Nuovo Campione</button></c:if><div id="errorMsg" ></div>
</div>
</div>
 <div class="clearfix"></div>
<div class="row" style="margin-top:20px;">
<div class="col-lg-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 						<th>ID</th>
 						<!-- <td>Action</td>		 -->		   
            	       <th>Stato Strumento</th>		   
            		   <th>Denominazione</th>
                       <th>Codice Interno</th>
                       <th>Costurttore</th>
                       <th>Modello</th>
                       <th>Matricola</th>
                       <th>Divisione</th>
                       <th>Campo Misura</th>
                       <th>Tipo Strumento</th>
                       <th>Freq. Verifica</th>
                       <th>Data Ultima Verifica</th>
                       <th>Data Prossima Verifica</th>
                       <th>Reparto</th>
                        <th>Tipo Rapporto</th>
                         <th>Utilizzatore</th>
                          <th>Luogo Verifica</th>
                           <th>Interpolazioone</th>
                            <th>Classificazione</th>
                             <th>Company</th>
                              <th>Data Modifica</th>
                             <th>Utente Modifica</th> 

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaStrumenti}" var="strumento" varStatus="loop">

	 <tr role="row" id="${campione.codice}-${loop.index}" class="customTooltip" title="Doppio Click per aprire il dettaglio del Campione">

	<td>${strumento.__id}</td>
	<td id="stato_${strumento.__id}">${strumento.stato_strumento.nome}</td>

   <td>${strumento.denominazione}</td>
                    	             <td>${strumento.codice_interno}</td>
                    	             <td>${strumento.costruttore}</td>
                    	             <td>${strumento.modello}</td>
                    	             <td>${strumento.matricola}</td>
                    	             <td>${strumento.risoluzione}</td>
                    	             <td>${strumento.campo_misura}</td>
                    	             <td>${strumento.tipo_strumento.nome}</td>

<td>
<c:if test="${not empty strumento.scadenzaDTO}">
<c:if test="${strumento.scadenzaDTO.freq_mesi != 0}">
    
         ${strumento.scadenzaDTO.freq_mesi} 
</c:if>
</c:if></td>
<td>
<c:if test="${not empty strumento.scadenzaDTO}">
<c:if test="${strumento.scadenzaDTO.dataUltimaVerifica != 0}">
   <fmt:formatDate pattern="dd/MM/yyyy" 
         value="${campione.scadenzaDTO.dataUltimaVerifica}" />
</c:if>
</c:if></td>

<td>
<c:if test="${not empty strumento.scadenzaDTO}">
<c:if test="${strumento.scadenzaDTO.dataProssimaVerifica != 0}">
   <fmt:formatDate pattern="dd/MM/yyyy" 
         value="${campione.scadenzaDTO.dataProssimaVerifica}" />
</c:if>
</c:if></td>

<td>
<c:if test="${not empty strumento.scadenzaDTO}">
<c:if test="${strumento.scadenzaDTO.tipo_rapporto.noneRapporto != 0}">

    ${campione.scadenzaDTO.tipo_rapporto.noneRapporto} 

</c:if>
</c:if></td>
 <td>${strumento.utilizzatore}</td>
<td>
<c:if test="${not empty strumento.luogo}">
    ${strumento.luogo.descrizione} >
</c:if></td>
<td>
<c:if test="${not empty strumento.interpolazione}">
   ${strumento.interpolazione} 
</c:if></td>
 <td>${strumento.classificazione.descrizione}</td>
  <td>${strumento.company.denominazione}</td>
  <td>
<c:if test="${not empty strumento.dataModifica}">
   <fmt:formatDate pattern="dd/MM/yyyy" 
         value="${strumento.dataModifica}" />
</c:if></td>
   <td>
<c:if test="${not empty strumento.userModifica}">
   ${strumento.userModifica}
</c:if></td>

<td>


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
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
 





  <div id="myModal" class="modal fade modal-fullscreen" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Dettagli Campione</h4>
      </div>
       <div class="modal-body">

        <div class="nav-tabs-custom">
            <ul id="mainTabs" class="nav nav-tabs">
              <li class="active"><a href="#dettaglio" data-toggle="tab" aria-expanded="true"   id="dettaglioTab">Dettaglio Campione</a></li>
              <li class=""><a href="#valori" data-toggle="tab" aria-expanded="false"   id="valoriTab">Valori Campione</a></li>
               <li class=""><a href="#certificati" data-toggle="tab" aria-expanded="false"   id="certificatiTab">Lista Certificati Campione</a></li>
              <li class=""><a href="#prenotazione" data-toggle="tab" aria-expanded="false"   id="prenotazioneTab">Controlla Prenotazione</a></li>
               <c:if test="${utente.checkPermesso('MODIFICA_CAMPIONE')}"> <li class=""><a href="#aggiorna" data-toggle="tab" aria-expanded="false"   id="aggiornaTab">Aggiornamento Campione</a></li></c:if>
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="dettaglio">


    			</div> 

              <!-- /.tab-pane -->
              <div class="tab-pane table-responsive" id="valori">
                

         
			 </div>

              <!-- /.tab-pane -->

			<div class="tab-pane table-responsive" id="certificati">
                

         
			 </div>

              <!-- /.tab-pane -->
              
              <div class="tab-pane" id="prenotazione">
              

              </div>
              <!-- /.tab-pane -->
              <c:if test="${utente.checkPermesso('MODIFICA_CAMPIONE')}"> <div class="tab-pane" id="aggiorna">
              

              </div></c:if>
              <!-- /.tab-pane -->
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


<div id="myModalPrenotazione" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Prenotazione</h4>
      </div>
       <div class="modal-body" id="myModalPrenotazioneContent" >

      <div class="form-group">

                  <textarea class="form-control" rows="3" id="noteApp" placeholder="Entra una nota ..."></textarea>
                </div>
        
        
  		<div id="emptyPrenotazione" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="prenotazioneFromModal()"  >Prenota</button>
        <button type="button" class="btn btn-danger"onclick="$(myModalPrenotazione).modal('hide');"   >Annulla</button>
      </div>
    </div>
  </div>
</div>

<c:if test="${utente.checkPermesso('MODIFICA_CAMPIONE')}"> 
<div id="modalNuovoCampione" class="modal  modal-fullscreen fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Campione</h4>
      </div>
      <form class="form-horizontal"  id="formNuovoCampione">
       <div class="modal-body">
       
<div class="nav-tabs-custom">
        <!--     <ul id="mainTabs" class="nav nav-tabs">
              <li class="active"><a href="#nuovoCampione" data-toggle="tab" aria-expanded="true"   id="nuovoCampioneTab">Dettaglio Campione</a></li>
              <li class=""><a href="#nuoviValori" data-toggle="tab" aria-expanded="false"   id="nuoviValoriTab">Valori Campione</a></li>

            </ul> -->
            <div class="tab-content">
              <div class="tab-pane  table-responsive active" id="nuovoCampione">


        
              

    <div class="form-group">
          <label for="inputEmail" class="col-sm-2 control-label">Proprietario:</label>

         <div class="col-sm-10">
         			<input class="form-control" id="proprietario" type="text" name="proprietario" disabled="disabled" value="${usrCompany.denominazione}" />
         
			
     	</div>
   </div>

   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Nome:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="nome" type="text" name="nome"  value="" required/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Campione:</label>
        <div class="col-sm-10">
                     
					   <select class="form-control required" id="tipoCampione" name="tipoCampione" required>
                       					<option value="">Seleziona un Tipo Campione</option>
                                            <c:forEach items="${listaTipoCampione}" var="cmp" varStatus="loop">

 												<option value="${cmp.id}">${cmp.nome}</option>
	 
											</c:forEach>
                        
                                            
                      </select>
                      
                      
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Codice:</label>
        <div class="col-sm-10">
                      <input class="form-control required" type="controllocodicecampione" id="codice" type="text" name="codice" value="" required/>
                      <span id="codiceError" class="help-block label label-danger"></span>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Matricola:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="matricola" type="text" name="matricola"  value="" required/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Descrizione:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="descrizione" type="text" name="descrizione"  value="" required/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Costruttore:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="costruttore" type="text" name="costruttore"  value="" required/>
    </div>
       </div>
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Modello:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="modello" type="text" name="modello"  value="" required/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Interpolazione:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="interpolazione" type="number" name="interpolazione"  value="" required/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Frequenza Taratura:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="freqTaratura" type="number" name="freqTaratura"  value="" required/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Stato Campione:</label>
        <div class="col-sm-10">

                        <select class="form-control required" id="statoCampione" name="statoCampione" required>
                      					<option value="">Selezionare Stato</option>
	                                    <option value="S">In Servizio</option>
	 									<option value="N">Fuori Servizio</option>
                            	          
                      </select>
                      
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Data Verifica:</label>
        <div class="col-sm-10">
                      <input class="form-control datepicker required" id="dataVerifica" type="text" name="dataVerifica"  required value="" data-date-format="dd/mm/yyyy"/>

    </div>
       </div> 
       
<!--          <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Data Scadenza:</label>
        <div class="col-sm-10">
                      <input class="form-control datepicker required" id="dataScadenza" type="text" name="dataScadenza"  datepicker required value=""  data-date-format="dd/mm/yyyy"/>                      
    </div>
       </div>  -->
       
<!--          <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Verifica:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="tipoVerifica" type="text" name="tipoVerifica"  maxlength="1" value="" required/>
                      
    </div>
       </div>  -->
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Certificato:</label>
        <div class="col-sm-10">


                        <input type="file" class="form-control" id="certificato" type="text" name="certificato" required/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Numero Certificato:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="numeroCerificato" type="text" name="numeroCerificato"  value="" required/>
    </div>
       </div> 
 <!--        
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Utilizzatore:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="utilizzatore" type="text" name="utilizzatore"  value="" required/>
    </div>
       </div> 
       
        <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Data Inizio:</label>
        <div class="col-sm-10">
                      <input class="form-control datepicker required" id="dataInizio" type="text" name="dataInizio" datepicker  value="" data-date-format="dd/mm/yyyy" required/>

                      
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Data Fine:</label>
        <div class="col-sm-10">
                      <input class="form-control datepicker required" id="dataFine" type="text" name="dataFine"  value=""datepicker  data-date-format="dd/mm/yyyy" required/>

                      
    </div>
       </div>  -->
       

<!--    </form> -->
   
    		<!-- 	</div> 

              /.tab-pane
              <div class="tab-pane table-responsive" id="nuoviValori"> -->
                
 
<!--  <form action="" method="post" id="formAppGrid"> -->


     <div class="form-group">
          <label for="interpolato" class="col-sm-2 control-label">Interpolato:</label>

         <div class="col-sm-4">

         			<select  class="form-control" id="interpolato" type="text" name="interpolato" required>
						<option value="0">NO</option>
         				<option value="1">SI</option>
         			
         			</select>
     	</div>
         </div>

     <div class="form-group">
          <label class="col-sm-12">Valori Campione</label>

         </div>


<table class="table table-bordered table-hover dataTable table-striped no-footer dtr-inline" id="tblAppendGrid">
</table>


 			


    		
    		
        
			 </div>

              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
			<span id="ulError" class="pull-left"></span><button type="submit" class="btn btn-danger" >Salva</button>
      </div>
        </form>
    </div>
  </div>
</div>

</c:if>



<div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="myModalErrorContent">

        
        
  		 </div>
      
    </div>
    <div class="modal-footer">
    	<button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
    </div>
    
  </div>
    </div>

</div>

<div id="modalEliminaCertificatoCampione" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="">
		     
			<input class="form-control" id="idElimina" name="idElimina" value="" type="hidden" />
		
			Sei Sicuro di voler eliminare il certificato?
        
        
  		 </div>
      
    </div>
    <div class="modal-footer">
    	<button type="button" class="btn btn-default pull-left" data-dismiss="modal">Annulla</button>
    	<button type="button" class="btn btn-danger" onClick="eliminaCertificatoCampione()">Elimina</button>
    </div>
  </div>
    </div>

</div>


</section>
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
	<script src="plugins/jquery.appendGrid/jquery.appendGrid-1.6.3.js"></script>
	<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>

<script type="text/javascript">

var listaStrumenti = ${listaStrumentiJson};

   </script>

  <script type="text/javascript">


  $(function(){
 	
  
 	 table = $('#tabPM').DataTable({
 	      paging: true, 
 	      ordering: true,
 	      info: true, 
 	      searchable: false, 
 	      targets: 0,
 	      responsive: true,
 	      scrollX: false,
 	      order:[[0, "desc"]],
 	      columnDefs: [
 					   { responsivePriority: 1, targets: 0 },
 	                   { responsivePriority: 3, targets: 2 },
 	                   { responsivePriority: 4, targets: 3 },
 	                   { responsivePriority: 2, targets: 6 },
 	                   { orderable: false, targets: 6 },
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
 	table.buttons().container()
    .appendTo( '#tabPM_wrapper .col-sm-6:eq(1)' );
 	   
 		$('#tabPM').on( 'dblclick','tr', function () {

   		var id = $(this).attr('id');
   		
   		var row = table.row('#'+id);
   		datax = row.data();

 	   if(datax){
  	    	row.child.hide();
  	    	exploreModal("dettaglioStrumento.do","id_str="+datax[0],"#dettaglio");
  	    	$( "#myModal" ).modal();
  	    	$('body').addClass('noScroll');
  	    }
 	   
 	   $('a[data-toggle="tab"]').one('shown.bs.tab', function (e) {


        	var  contentID = e.target.id;


        	if(contentID == "dettaglioTab"){
        		exploreModal("dettaglioStrumento.do","id_str="+datax[0],"#dettaglio");
        	}
        	if(contentID == "misureTab"){
        		exploreModal("strumentiMisurati.do?action=ls&id="+datax[0],"","#misure")
        	}
      
        	
        	
        	

  		});
 	   
 	   
   	});
   	    
   	    
 		
   	
   		
     


 $('#tabPM thead th').each( function () {
    var title = $('#tabPM thead th').eq( $(this).index() ).text();
    $(this).append( '<div><input style="width:100%" type="text" /></div>');
 } );

 // DataTable
 	table = $('#tabPM').DataTable();
 // Apply the search
 table.columns().eq( 0 ).each( function ( colIdx ) {
    $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
        table
            .column( colIdx )
            .search( this.value )
            .draw();
    } );
 } ); 
 	table.columns.adjust().draw();
 	if (!$.fn.bootstrapDP && $.fn.datepicker && $.fn.datepicker.noConflict) {
 		   var datepicker = $.fn.datepicker.noConflict();
 		   $.fn.bootstrapDP = datepicker;
 		}

 	$('.datepicker').bootstrapDP({
 		format: "dd/mm/yyyy",
 	    startDate: '-3d'
 	});
 	 
 	
 	$('#formNuovoStrumento').on('submit',function(e){
 	    e.preventDefault();
 		nuovoStrumento(<%= idSede %>,<%= idCliente %>)

 	});
 	
 	
 	
 	
 	var today = moment();


 	$("#dataUltimaVerifica").attr("value", today.format('DD/MM/YYYY'));
 	
 	$( "#ref_tipo_rapporto" ).change(function() {

 		  if(this.value == 7201){
 			  $("#freq_mesi").attr("disabled", false);
 			  $("#freq_mesi").attr("required", true);
  			  $("#dataProssimaVerifica").attr("required", true);
  			  $("#freq_mesi").val("");
  			  $("#dataProssimaVerifica").val("");

 		  }else{
 			  $("#freq_mesi").attr("disabled", true);
 			  $("#freq_mesi").attr("required", false);
  			  $("#dataProssimaVerifica").attr("required", false);
  			  $("#freq_mesi").val("");
  			  $("#dataProssimaVerifica").val("");
 		  }
  		});
 	$( "#freq_mesi" ).change(function() {

 		  if(this.value > 0){

 			  var futureMonth = moment(today).add(this.value, 'M');
 			  var futureMonthEnd = moment(futureMonth).endOf('month');
 			 
  
 			  $("#dataProssimaVerifica").val(futureMonth.format('DD/MM/YYYY'));
 			  $("#dataProssimaVerifica").attr("required", true);

 		  }else{
 			  $("#freq_mesi").val("");
 		  }
 		});
 	 $('.customTooltip').tooltipster({
 	        theme: 'tooltipster-light'
 	    });
 	
  });

  </script>
</jsp:attribute> 
</t:layout>
  
 
 
 
 