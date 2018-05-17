<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>

<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
	<%
 	UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
 
	ArrayList<CampioneDTO> listaCampioniarr =(ArrayList<CampioneDTO>)request.getSession().getAttribute("listaCampioni");



	Gson gson = new Gson();
	JsonArray listaCampioniJson = gson.toJsonTree(listaCampioniarr).getAsJsonArray();
	request.setAttribute("listaCampioniJson", listaCampioniJson);
	request.setAttribute("utente", utente);
	
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
        Lista Campioni
        <small>Fai doppio click per entrare nel dettaglio</small>
      </h1>
    </section>

    <!-- Main content -->
    <section class="content">


<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">
   	 <c:if test="${userObj.checkPermesso('CAMPIONI_COMPANY_METROLOGIA')}"> 	 
          <button class="btn btn-info" onclick="callAction('listaCampioni.do?p=mCMP');">I miei Campioni</button>
                  </c:if>
          <button class="btn btn-info" onclick="callAction('listaCampioni.do');">Tutti i Campioni</button>
         
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

 <c:if test="${utente.checkPermesso('NUOVO_CAMPIONE_METROLOGIA')}"> <button class="btn btn-primary" onClick="nuovoInterventoFromModal('#modalNuovoCampione')">Nuovo Campione</button></c:if>

 <c:if test="${utente.checkPermesso('ESPORTA_LISTA_CAMPIONI_METROLOGIA')}"><a class="btn btn-primary" href="gestioneCampione.do?action=exportLista">ESPORTA Campioni</a></c:if>

<div id="errorMsg" ></div>
</div>
</div>
 <div class="clearfix"></div>
<div class="row" style="margin-top:20px;">
<div class="col-lg-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <td>ID</td>
 <th>Proprietario</th>
 <th>Utilizzatore</th>
 <th>Nome</th>
 <th>Tipo Campione</th>
 <th>Codice</th>
 <th>Costruttore</th>
 <th>Descrizione</th>
 <th>Data Verifica</th>
 <th>Data Scadenza</th>
 <th>Stato</th>
 <th>Distributore</th>
 <th>Data Acquisto</th>
 <th>Campo di Accettabilità</th>
 <th>Attività Di Taratura</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaCampioni}" var="campione" varStatus="loop">

	 <tr role="row" id="${campione.codice}-${loop.index}" class="customTooltip" title="Doppio Click per aprire il dettaglio del Campione">

	<td>${campione.id}</td>
	<td>${campione.company.denominazione}</td>
	<td>${campione.company_utilizzatore.denominazione}</td>
	<td>${campione.nome}</td>
	<td>${campione.tipo_campione.nome}</td>
	<td>${campione.codice}</td>
	<td>${campione.costruttore}</td>
	<td>${campione.descrizione}</td>

<td>
<c:if test="${not empty campione.dataVerifica}">
   <fmt:formatDate pattern="dd/MM/yyyy" 
         value="${campione.dataVerifica}" />
</c:if></td>
<td>
<c:if test="${not empty campione.dataScadenza}">
   <fmt:formatDate pattern="dd/MM/yyyy" 
         value="${campione.dataScadenza}" />
</c:if></td>
<td align="center"> 
			<c:if test="${campione.statoCampione == 'N'}">
				<span class="label  label-danger">FUORI SERVIZIO</span> 
			</c:if>
			<c:if test="${campione.statoCampione == 'S'}">
				<span class="label  label-success">IN SERVIZIO</span>  
			</c:if>
</td>
<td>${campione.distributore }</td>
<td><fmt:formatDate pattern="dd/MM/yyyy" 
         value="${campione.data_acquisto }" /></td>
<td>${campione.campo_accettabilita }</td>
<td>${campione.attivita_di_taratura }</td>

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
             	
             	<c:if test="${utente.checkPermesso('LISTA_CERTIFICATI_CAMPIONE_VISUAL_METROLOGIA')}">
              	 <li class=""><a href="#certificati" data-toggle="tab" aria-expanded="false"   id="certificatiTab">Lista Certificati Campione</a></li>
               </c:if>
                 	<c:if test="${utente.checkPermesso('C_PRENOTAZIONE_CAMPIONE_METROLOGIA')}">
               
              <li class=""><a href="#prenotazione" data-toggle="tab" aria-expanded="false"   id="prenotazioneTab"> Prenotazioni</a></li>
              </c:if>
               <c:if test="${utente.checkPermesso('MODIFICA_CAMPIONE')}"> <li class=""><a href="#aggiorna" data-toggle="tab" aria-expanded="false"   id="aggiornaTab">Aggiornamento Campione</a></li></c:if>
               
               <li class=""><a href="#registro_eventi" data-toggle="tab" aria-expanded="false"   id="registro_eventiTab"> Registro Eventi</a></li>
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="dettaglio">


    			</div> 

              <!-- /.tab-pane -->
              <div class="tab-pane table-responsive" id="valori">
                

         
			 </div>

              <!-- /.tab-pane -->
	<c:if test="${utente.checkPermesso('LISTA_CERTIFICATI_CAMPIONE_VISUAL_METROLOGIA')}">
			<div class="tab-pane table-responsive" id="certificati">
                

         
			 </div>
</c:if>
              <!-- /.tab-pane -->
  	<c:if test="${utente.checkPermesso('C_PRENOTAZIONE_CAMPIONE_METROLOGIA')}">
              
              <div class="tab-pane" id="prenotazione">
 
					<div class="row" id="prenotazioneRange">
						<div class="col-xs-12">
					 
							 <div class="form-group">
						        <label for="datarangecalendar" class="control-label">Date Ricerca:</label>

						     	<div class="col-md-4 input-group">
						     		<div class="input-group-addon">
				                    		<i class="fa fa-calendar"></i>
				                  	</div>
								    <input type="text" class="form-control" id="datarangecalendar" name="datarangecalendar" value="">
								    <span class="input-group-btn">
				                      	<button type="button" class="btn btn-info btn-flat" onclick="aggiungiPrenotazioneCalendario()">Cerca</button>
				                    </span>
  								</div>
  							  </div>
						   </div>
						</div>
					
				
					<div class="row">
						<div class="col-xs-12">
										<div id="prenotazioneCalendario" ></div>
						</div>
					
					</div>
              </div>
  </c:if>
              <!-- /.tab-pane -->
              <c:if test="${utente.checkPermesso('MODIFICA_CAMPIONE')}"> <div class="tab-pane" id="aggiorna">
              

              </div></c:if>
              
              <div class="tab-pane" id="registro_eventi">
              
              
              </div>
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

                  <textarea class="form-control" rows="3" id="noteApp" placeholder="Scrivi una nota ..."></textarea>
                </div>
        
        
  		<div id="emptyPrenotazione" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="prenotazioneFromModal()"  >Prenota</button>
        <button type="button" class="btn btn-danger"onclick="$('#myModalPrenotazione').modal('hide');"   >Annulla</button>
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
          <select name="interpolazione"  class="form-control required" id="interpolazione" required>
	        <option>1</option>
		    <option>2</option>
		    <option>3</option>
		    <option>4</option>
		    <option>5</option>
		    <option>10</option>
		  </select>

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


                        <input accept="application/pdf" type="file" onChange="validateSize(this)" class="form-control" id="certificato" type="text" name="certificato" required/>
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
        <label for="ente_certificatore" class="col-sm-2 control-label">Ente Certificatore:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="ente_certificatore" type="text" name="ente_certificatore"  value="" readonly/>
    </div>
       </div> 

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
        <label for="distributore" class="col-sm-2 control-label">Distributore:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="distributore" type="text" name="distributore"  value="" />
    </div>
       </div> 
       <div class="form-group">
        <label for="data_acquisto" class="col-sm-2 control-label">Data Acquisto:</label>
        <div class="col-sm-10">
                      <input class="form-control datepicker required" id="data_acquisto" type="text" name="data_acquisto"   value="" data-date-format="dd/mm/yyyy"/>
    </div>
       </div> 
       <div class="form-group">
        <label for="campo_accettabilita" class="col-sm-2 control-label">Campo Di Accettabilità:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="campo_accettabilita" type="text" name="campo_accettabilita"  value="" />
    </div>
       </div> 
       <div class="form-group">
        <label for="attivita_di_taratura" class="col-sm-2 control-label">Attività Di Taratura:</label>
       
        <div class="col-sm-4">

         			<select  class="form-control" id="attivita_di_taratura"  name="attivita_di_taratura" >
						<option value="0">ESTERNA</option>
         				<option value="1">INTERNA</option>
         			
         			</select>
     	</div>
     	<div class="col-sm-6">
     	  <input class="form-control required" id="attivita_di_taratura_text" type="text" name="attivita_di_taratura_text"  value="" />
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

var listaStrumenti = ${listaCampioniJson};

   </script>

  <script type="text/javascript">

	var columsDatatables = [];
	 
	$("#tabPM").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabPM thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	        var title = $('#tabPM thead th').eq( $(this).index() -1 ).text();
	        var search = "";
	        if(columsDatatables[$(this).index()].search.search){
	        		search = columsDatatables[$(this).index()].search.search;
	        }
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+search+'"/></div>');
	    } );

	} );
	
	$('#attivita_di_taratura').change(function(){
		var selection = $('#attivita_di_taratura').val();
		
		if(selection==1){
			$('#attivita_di_taratura_text').val("INTERNA");
			$('#attivita_di_taratura_text').attr("readonly", true);
		}else{
			$('#attivita_di_taratura_text').val("");
			$('#attivita_di_taratura_text').attr("readonly", false);
		}
		
	});
  
    $(document).ready(function() {
    

    	
    	
    	var today = new Date();
    	var dd = today.getDate();
    	var mm = today.getMonth()+1; //January is 0!
    	var yyyy = today.getFullYear();

    	if(dd<10) {
    	    dd = '0'+dd;
    	} 

    	if(mm<10) {
    	    mm = '0'+mm;
    	} 

    	today = dd + '/' + mm + '/' + yyyy;
    	$('input[name="datarangecalendar"]').daterangepicker({
    	    locale: {
    	      format: 'DD/MM/YYYY'
    	    },
    	    "minDate": today
    	}, 
    	function(start, end, label) {
    	      /* startDatePicker = start;
    	      endDatePicker = end; */
    	});
    	

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
	        pageLength: 100,
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
  	                   { responsivePriority: 3, targets: 2 },
  	                   { responsivePriority: 4, targets: 6 },
  	                 { responsivePriority: 5, targets: 10 }
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
  	              /*  ,
  	               {
  	             		text: 'I Miei Strumenti',
                 		action: function ( e, dt, node, config ) {
                 			explore('listaCampioni.do?p=mCMP');
                 		},
                 		 className: 'btn-info removeDefault'
    				},
  	               {
  	             		text: 'Tutti gli Strumenti',
                 		action: function ( e, dt, node, config ) {
                 			explore('listaCampioni.do');
                 		},
                 		 className: 'btn-info removeDefault'
    				} */
  	                         
  	          ]
  	    	
  	      
  	    });
    	
  	table.buttons().container().appendTo( '#tabPM_wrapper .col-sm-6:eq(1)');
  	var indexCampione;
    $('#tabPM').on( 'dblclick','tr', function () {   
           	 //$( "#tabPM tr" ).dblclick(function() {
     		var id = $(this).attr('id');
   
     		indexCampione = id.split('-');
     		var row = table.row('#'+id);
     		datax = row.data();
         
   	    if(datax){
   	    	row.child.hide();
   	    	exploreModal("dettaglioCampione.do","idCamp="+datax[0],"#dettaglio");
   	    	$( "#myModal" ).modal();
   	    	$('body').addClass('noScroll');
   	    }
   	    
   	 	campioneSelected = listaStrumenti[indexCampione[1]];

		 if(listaStrumenti[indexCampione[1]].company.id != '${utente.company.id}')
	     {
			 
			 $('#aggiornaTab').hide();
			
		 }else{
			 $('#aggiornaTab').show();

		 }
   	    
   	    
  		
  		
  	
  		
     	});
     	    
     	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {


        	var  contentID = e.target.id;

        	
        	if(contentID == "dettaglioTab"){
        		$("#myModal").addClass("modal-fullscreen");
        		exploreModal("dettaglioCampione.do","idCamp="+datax[0],"#dettaglio");
        	}
        	if(contentID == "valoriTab"){
        		$("#myModal").addClass("modal-fullscreen");
        		exploreModal("valoriCampione.do","idCamp="+datax[0],"#valori")
        	}
        	if(contentID == "certificatiTab"){
        		$("#myModal").addClass("modal-fullscreen");
        		exploreModal("listaCertificatiCampione.do","idCamp="+datax[0],"#certificati")
        	}
        	 if(contentID == "registro_eventiTab"){
        		  //$("#myModal").addClass("modal-fullscreen"); 
        		 $("#myModal").removeClass("modal-fullscreen");
        			exploreModal("registroEventi.do","idCamp="+datax[0],"#registro_eventi")
        	} 
        	if(contentID == "prenotazioneTab"){
        		$("#myModal").removeClass("modal-fullscreen");

        		 if(listaStrumenti[indexCampione[1]].statoCampione == "N")
        	     {
        	
        			 $("#prenotazioneCalendario").html("CAMPIONE NON DISPONIBILE");
        			 $("#prenotazioneRange").hide();
        			
        		 }else{
        			
        			 
             		//exploreModal("richiestaDatePrenotazioni.do","idCamp="+datax[0],"#prenotazione")

        			loadCalendar("richiestaDatePrenotazioni.do","idCamp="+datax[0],"#prenotazioneCalendario")
        			 $("#prenotazioneRange").show();
        		 }
        		
        		
        	}
        	
        	if(contentID == "aggiornaTab"){
        		$("#myModal").addClass("modal-fullscreen");
        		if(listaStrumenti[indexCampione[1]].company.id != '${utente.company.id}')
        	     {
        		
        			 $('#aggiornaTab').hide();
        			
        		 }else{
        			 $('#aggiornaTab').show();
        			exploreModal("aggiornamentoCampione.do","idCamp="+datax[0],"#aggiorna")
        		 }
        	}
        	
        	
        	

  		});
     	 $('#myModal').on('hidden.bs.modal', function (e) {
     	  	$('#noteApp').val("");
     	 	$('#empty').html("");
     	 	$('#dettaglioTab').tab('show');
     	 	$('body').removeClass('noScroll');
     	 	resetCalendar("#prenotazioneCalendario");
     	});
     	
     	 $('#myModalError').on('hidden.bs.modal', function (e) {
				if($( "#myModalError" ).hasClass( "modal-success" )){
					callAction("listaCampioni.do");
				}
     		
      	});
     	  

  
 
  $('.inputsearchtable').on('click', function(e){
      e.stopPropagation();    
   });
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
    	
	$('#tabPM').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
	  } );
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	})
    	
    	
    	if (!$.fn.bootstrapDP && $.fn.datepicker && $.fn.datepicker.noConflict) {
		   var datepicker = $.fn.datepicker.noConflict();
		   $.fn.bootstrapDP = datepicker;
		}

	$('.datepicker').bootstrapDP({
		format: "dd/mm/yyyy"
	});

	$('#formNuovoCampione').on('submit',function(e){
		
		$("#ulError").html("");
	    e.preventDefault();
	    nuovoCampione();

	});
   
 		    
	    	
	    	var umJson = JSON.parse('${listaUnitaMisura}');
	    	var tgJson = JSON.parse('${listaTipoGrandezza}');
	    	
	    	$('#tblAppendGrid').appendGrid({
	            //caption: 'Valori Campione',
	            //captionTooltip: 'Valori Campione',
	            initRows: 1,
	            hideButtons: {
	                remove: true,
	                insert:true
	            },
	            columns: [
						  { name: 'parametri_taratura', display: 'Parametri Taratura', type: 'text', ctrlClass: 'required', ctrlCss: {  width: '100%' , 'min-width':"150px" }  },        
	                      { name: 'valore_nominale', display: 'Valore Nominale', type: 'text', ctrlClass: 'numberfloat required', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px" } },
	                      { name: 'valore_taratura', display: 'Valore Taratura', type: 'text', ctrlClass: ' numberfloat required', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px" }  },
	                      { name: 'incertezza_assoluta', display: 'Incertezza Assoluta', type: 'text', ctrlClass: 'numberfloat', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px" }  },
	                      { name: 'incertezza_relativa', display: 'Incertezza Relativa', type: 'text', ctrlClass: 'numberfloat incRelativa', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px" }  },
	                    //  { name: 'interpolato', display: 'Interpolato', type: 'select', ctrlOptions:';0:NO;1:SI', ctrlClass: 'required', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px" }  },
	                   //   { name: 'valore_composto', display: 'Valore Composto', type: 'select', ctrlOptions:';0:NO;1:SI', ctrlClass: 'required', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px" }  },
	                      { name: 'divisione_UM', display: 'Divisione UM', type: 'text', ctrlClass: 'numberfloat required', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px" }  },
	                      { name: 'tipo_grandezza', display: 'Tipo Grandezza', type: 'select', ctrlClass: 'required select2MV tipograndezzeselect', ctrlOptions: tgJson, ctrlCss: { 'text-align': 'center', "width":"100%", 'max-width': '150px' }  },
						  { name: 'unita_misura', display: 'Unita di Misura', type: 'select', ctrlClass: 'required select2MV', ctrlCss: { 'text-align': 'center',"width":"100%", 'max-width': '150px' }  },
						  { name: 'id', type: 'hidden', value: 0 }
    
	                  ] ,
	                  customFooterButtons: [
	                     
	                      {
	                          uiButton: { icons: { primary: 'ui-icon-arrowthickstop-1-s' }, text: false },
	                          btnAttr: { title: 'Download Data' },
	                          click: function (evt) {
		                        generacsv();
	                          }
	                      }
	                  ],
	               	
	                beforeRowRemove: function (caller, rowIndex) {
	                    return confirm('Are you sure to remove this row?');
	                },
	                afterRowRemoved: function (caller, rowIndex) {
	                	$(".ui-tooltip").remove();
	                },
	                afterRowAppended: function (caller, parentRowIndex, addedRowIndex) {
	                    // Copy data of `Year` from parent row to new added rows
	                	modificaValoriCampioneTrigger(umJson);

	                }
	        });


	    	
	    	//modificaValoriCampioneTrigger(umJson);
	    	
	    	$("#interpolato").change(function(){
	        	
	    		if($("#interpolato").val()==1){
	    			$('#tblAppendGrid tbody tr').each(function(){
	    			    var td = $(this).find('td').eq(1);
	    			    attr = td.attr('id');
	    			    $("#" + attr  + " input").val($("#codice").val());
	    			    $("#" + attr  + " input").prop('disabled', false);

	    			   // alert(td.attr('id'));
	    			})
	    		}else{
	    			i = 1;
	    			$('#tblAppendGrid tbody tr').each(function(){
	    				var td = $(this).find('td').eq(1);
	    				attr = td.attr('id');
	    			    $("#" + attr  + " input").val($("#codice").val() +"_"+i);
	    			    $("#" + attr  + " input").prop('disabled', false);
	    			    i++;
	    			})
	    		}
	    	});
	    	
	    });


	    var validator = $("#formNuovoCampione").validate({
	    	showErrors: function(errorMap, errorList) {
	    	  
	    	    this.defaultShowErrors();
	    	  },
	    	  errorPlacement: function(error, element) {
	    		  $("#ulError").html("<span class='label label-danger'>Errore inserimento valori ("+error[0].innerHTML+")</span>");
	    		 },
	    		 
	    		    highlight: function(element) {
	    		        $(element).closest('.form-group').addClass('has-error');
	    		        $(element).closest('.ui-widget-content input').addClass('error');
	    		        
	    		    },
	    		    unhighlight: function(element) {
	    		        $(element).closest('.form-group').removeClass('has-error');
	    		        $(element).closest('.ui-widget-content input').removeClass('error');
	    		       
	    		    }
	    });

	
	    jQuery.validator.addMethod("controllocodicecampione", function(value, element) {
	    	  return this.optional(element) || /^[a-zA-Z0-9]*$/.test(value);
	    	}, "Codice non corretto, Inserire solo numeri e lettere");
	    
	    jQuery.validator.addMethod("numberfloat", function(value, element) {
	    	  return this.optional(element) || /^(-?\d+(?:[\.]\d{1,30})?)$/.test(value);
	    	}, "Questo campo deve essere un numero");
	    
	    
	    
	    $("#codice").focusout(function(){
	    	var codice = $("#codice").val();
	    	var regex = /^[a-zA-Z0-9]*$/;
	    	
	    	

	    	if(validator.element( "#codice" )){
	    		checkCodiceCampione(codice);
	    	}else{

		    	if(codice.length>0){
		    		  $("#codiceError").html("Il codice deve contenere solo lettere e numeri");
	
		    	}

	    	}
	    });
	    
	    $("#codice").focusin(function(){
	    	$("#codiceError").html("");
	    });
	    
	    function validateSize(file) {
	    	if(file.files[0]!=undefined){
	    		$('#ente_certificatore').attr("readonly", false);	
	    	
	    }else{
	    	$('#ente_certificatore').attr("readonly", true);	
	    } 
	        var FileSize = file.files[0].size / 1024 / 1024; // in MB
	        if (FileSize > 2) {
	    		$('#myModalErrorContent').html("Il File supera i 2MB, inserire un file più piccolo");
	    	  	$('#myModalError').removeClass();
	    		$('#myModalError').addClass("modal modal-danger");
	    		$('#myModalError').modal('show');
	           $(file).val(''); //for clearing with Jquery
	        } 
	    
	    }

		 $("#myModal").on("hidden.bs.modal", function(){
				
				$(document.body).css('padding-right', '0px');
				
			});
  </script>
</jsp:attribute> 
</t:layout>
  
 
