<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   
       <section class="content-header">
      <h1>
        Nuovo Intervento
        <small></small>
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
			          <form id="formNuovoInterventoCampionamento"  method="POST">
				            <div class="form-group">
						        <label for="datarange" class="col-md-2 control-label">Date Campionamento:</label>

						     	<div class="col-md-2 input-group input-daterange">
								    <input type="text" class="form-control" id="datarange" name="datarange" value="">
  								</div>
						   </div>
						   
						   <div class="form-group">
						        <label for="selectTipoCampionamento" class="col-md-2 control-label">Tipo Campionamento:</label>

						     	<div class="col-md-4 input-group input-daterange">
								    <select name="selectTipoCampionamento" id="selectTipoCampionamento" data-placeholder="Seleziona un tipo campionamento..."  class="form-control select2" aria-hidden="true" data-live-search="true" required>
										                    <option value=""></option>
										                      <c:forEach items="${listaTipoCampionamento}" var="tipo">
 	 
										                           			<option value="${tipo.id}">${tipo.codice} - ${tipo.descrizione}</option> 
								 
 										                     </c:forEach>
										
										                  </select>
  								</div>
						   </div>
						   
						   <div class="row">
						   <div class="col-md-8">
						   <c:forEach items="${listaAccessoriAssociati}" var="listaAccessoriAss">
						   <div class="box box-primary">
					            <div class="box-header">
					              <i class="ion ion-clipboard"></i>
					
					              <h3 class="box-title">Lista Accessori - ${listaAccessoriAss.key}</h3>
					
					              <div class="box-tools pull-right">
					            
					              </div>
					            </div>
					            <!-- /.box-header -->
					            <div class="box-body">
					            <div class="col-md-12">
					           		 <table class="table table-striped" id="tableAccessori_${listaAccessoriAss.key}">
										  <thead>
										    <tr>
										
											  <th>Quantità Necessaria</th>
										      <th>Nome</th>
										      <th>Descrizione</th>
										      <th>Quantità Prenotabile</th>
										      <th>Quantità Prenotata</th>
										       <th>Quantità in Magazzino</th>
										       <th></th>
										       <th></th>
										    </tr>
										  </thead>
										  <tbody>
										  <c:set var="artiolis" value="0" />
										  <c:set var="artioliw" value="0" />
										  <c:set var="artiolid" value="0" />
										  <c:forEach items="${listaAccessoriAss.value}" var="accessorio" varStatus="loop">
										  
										  <c:set var="quantitaEffettiva" value="${accessorio.quantitaPrenotata + accessorio.quantitaFisica}" />
										  
										  <c:if test="${accessorio.quantitaFisica >=  accessorio.quantitaNecessaria}"><c:set var="alertcolor" value="success" /> <c:set var="artiolis" value="${artiolis + 1}" /> </c:if>							  
										  <c:if test="${accessorio.quantitaFisica <  accessorio.quantitaNecessaria}"><c:set var="alertcolor" value="warning" /> <c:set var="artioliw" value="${artioliw + 1}" />  </c:if>
										  <c:if test="${quantitaEffettiva <  accessorio.quantitaNecessaria}"><c:set var="alertcolor" value="danger" /> <c:set var="artiolid" value="${artiolid + 1}" /> </c:if>	
										 
										  
										  
										  <tr class="${alertcolor}" id="tr_${accessorio.id}_${listaAccessoriAss.key}">
										  	  
											  <td id="quantitaNecessaria_${accessorio.id}_${listaAccessoriAss.key}">${accessorio.quantitaNecessaria}</td>
										      <td>${accessorio.nome}</td>
										      <td>${accessorio.descrizione}</td>
										      <td>${accessorio.quantitaFisica}</td>
										      <td>${accessorio.quantitaPrenotata}</td>
											
											
												<td>${quantitaEffettiva}</td>
												<td> <c:if test="${accessorio.componibile eq 'S'}"> <button id="aggregaAccessorioButton_${accessorio.id}_${listaAccessoriAss.key}" class="btn btn-xs btn-warning" onClick="aggregaAccessorio(${accessorio.id},'${listaAccessoriAss.key}',0)"><i class="fa fa-fw fa-object-group"></i></button></c:if></td>												
												<td> <button class="btn btn-xs btn-danger" onClick="removeAccessorio(${accessorio.id},'${listaAccessoriAss.key}',0)"><i class="fa fa-fw fa-trash-o"></i></button></td>
										    </tr>
										   
									    </c:forEach>
										    
										   

										  </tbody>
										</table>
					             	   </div>
					             	  <div class="col-md-12">
					             	  	<h4>Aggiungi Accessori Extra</h4>
									   </div>

					             	   <div class="col col-md-12">
					             	   
					             	    <div class="form-group">
										        <label for="datarange" class="col col-lg-2 control-label">Accessorio:</label>
										     	<div class="col col-lg-4 input-group">
														<select name="selectAcccessorio_${listaAccessoriAss.key}" id="selectAcccessorio_${listaAccessoriAss.key}" data-placeholder="Seleziona un accessorio" onChange="handleChangeAccessorio('${listaAccessoriAss.key}')" class="form-control select2" aria-hidden="true" data-live-search="true">
										                    <option value=""></option>
										                      <c:forEach items="${listaAccessori}" var="tipo">
 	 
										                           			<option value="${tipo.id}">${tipo.nome} - ${tipo.descrizione}</option> 
								 
 										                     </c:forEach>
										
										                  </select>				  								
										          </div>
										     </div>    
										    <div class="form-group">
										          <label for="datarange" class="col col-lg-2 control-label">Quantita:</label>
										     	<div class="col col-lg-4 input-group">
														<input class="form-control" name="quantitaNecessaria_${listaAccessoriAss.key}" id="quantitaNecessaria_${listaAccessoriAss.key}" type="number" onChange="handleChangeAccessorio('${listaAccessoriAss.key}')" />			  								
										          </div>
										             </div>
										            <div class="form-group">
										          <div class="col col-lg-2 col-lg-offset-2 input-group">
														<button type="button" class="btm btn-primary" onClick="inviaQuantita('${listaAccessoriAss.key}')" >Aggiungi</button>			  								
										          </div>
										   </div>
					             	   
					             	  
									   </div>
					             	   
					            </div>
					            <!-- /.box-body -->
					         
					      </div>
					</c:forEach>
					 </div>
					  <div class="col-md-4">
					  
					  
						   <div class="box box-solid box-primary">
					            <div class="box-header">
					              <i class="ion ion-clipboard"></i>
					
					              <h3 class="box-title">Lista Accessori Raggruppati</h3>
					
					              <div class="box-tools pull-right">
					            
					              </div>
					            </div>
					            <!-- /.box-header -->
					            <div class="box-body">
					            <div class="col-md-12">
					           		 <table class="table table-striped" id="tableAccessoriRaggruppati">
										  <thead>
										    <tr>
										
											  <th>Quantità Necessaria</th>
										      <th>Nome</th>
										      <th>Descrizione</th>
										      <th>Quantità Prenotabile</th>
							
										     
										    </tr>
										  </thead>
										  <tbody>
										  <c:set var="artiolis" value="0" />
										  <c:set var="artioliw" value="0" />
										  <c:set var="artiolid" value="0" />
										  <c:forEach items="${listaAcc}" var="accessorio" varStatus="loop">
										  
										  <c:set var="quantitaEffettiva" value="${accessorio.quantitaPrenotata + accessorio.quantitaFisica}" />
										  
										  <c:if test="${accessorio.quantitaFisica >=  accessorio.quantitaNecessaria}"><c:set var="alertcolor" value="success" /> <c:set var="artiolis" value="${artiolis + 1}" /> </c:if>							  
										  <c:if test="${accessorio.quantitaFisica <  accessorio.quantitaNecessaria}"><c:set var="alertcolor" value="warning" /> <c:set var="artioliw" value="${artioliw + 1}" />  </c:if>
										  <c:if test="${quantitaEffettiva <  accessorio.quantitaNecessaria}"><c:set var="alertcolor" value="danger" /> <c:set var="artiolid" value="${artiolid + 1}" /> </c:if>	
										 
										  
										  
										  <tr class="${alertcolor}" id="tr_${accessorio.id}_raggruppati">
										  	  
											  <td id="quantitaNecessaria_${accessorio.id}_raggruppati">${accessorio.quantitaNecessaria}</td>
										      <td>${accessorio.nome}</td>
										      <td>${accessorio.descrizione}</td>
										      <td>${accessorio.quantitaFisica}</td>

										   
									    </c:forEach>
										    
										   

										  </tbody>
										</table>
					             	   </div>
		
					            </div>
					            <!-- /.box-body -->
					         
					      </div>

					  </div>
 </div>
 						 <div class="box box-warning">
					            <div class="box-header">
					              <i class="ion ion-clipboard"></i>
					
					              <h3 class="box-title">Lista Dotazioni</h3>
					
					              <div class="box-tools pull-right">
					            
					              </div>
					            </div>
					            <!-- /.box-header -->
					            <div class="box-body">
					            <div class="row">
					            <table id="tableDotazioni" class="table table-responsive table-striped table-bordered">
					            <tbody>
					             	    <c:forEach items="${listaTipologieAssociate}" var="tipologia" varStatus="loop">
					             	    		<tr>
					             	    		<td><label class="form-label col-lg-8">${tipologia.codice} - ${tipologia.descrizione}</label></td>
											  <td>  <div class="form-group">
										                  
										                 <div class="col col-lg-4 input-group">
															<select name="selectTipologiaDotazione[${loop.index}]"  id="selectTipologiaDotazione_${loop.index}"  data-placeholder="Seleziona una dotazione..." onChange="checkDotazioneSelected(this)"  class="form-control select2 dotazioniSelectReq required" aria-hidden="true" data-live-search="true" required>
										                    <option value=""></option>
										                      <c:forEach items="${listaDotazioni}" var="dotazione">
										                           <c:if test="${dotazione.tipologia.id == tipologia.id}">
										                           		
										                           			<option value="${dotazione.id}">${dotazione.modello} - ${dotazione.matricola}${dotazione.targa}</option> 
										                           	
										                           		
										                           </c:if>
										                     </c:forEach>
										
										                  </select>
										                  </div>
										        </div>
										        </td>
										        <td>
										        <button class="btn btn-xs btn-danger" disabled><i class="fa fa-fw fa-trash-o"></i></button>
										        </td>
 										        </tr>
										</c:forEach>
										</tbody>
										
									</table>
									</div>
									<div class="row form-group">
									<div class="col col-lg-2">
										 <label for="datarange" class="control-label">Tipologia Dotazione:</label></td>

										</div>	
										          
 											<div class="col col-lg-4">
														<select name="selectDotazioneSpot" id="selectDotazioneSpot" data-placeholder="Seleziona un tipo di dotazione" class="form-control select2" aria-hidden="true" data-live-search="true">
										                    <option value=""></option>
										                      <c:forEach items="${listaTipologieDotazioni}" var="tipo">
 	 
										                           			<option value="${tipo.id}">${tipo.codice} - ${tipo.descrizione}</option> 
								 
 										                     </c:forEach>
										
										                  </select>				  								
 										     	</div>  
										    	
										
										 
										          <div class="col col-lg-2 col-lg-offset-2 input-group">
														<button type="button" class="btm btn-primary" onClick="aggiungiDotazione()" >Aggiungi</button>			  								
										          </div>
										   
										</div>
										</div>
									

										            
										   
					            </div>
					            <!-- /.box-body -->
					            <div class="box-footer clearfix no-border">
					            		<c:if test="${artioliw == 0 && artiolid == 0}">
									 	<button type="button" class="btn btn-success buttonSalva" onClick="salvaInterventoCampionamento()" >Salva</button>
									 </c:if>
									 <c:if test="${artioliw > 0 && artiolid == 0}">
									 	
									 	<button type="button" class="btn btn-success buttonSalva" onclick="" disabled>Salva</button>
									 	<p><span class="label label-warning labelSalva">Impossibile creare l'intervento, gli articoli presenti in magazzino sono già prenotati</span></p>
									 </c:if>
									 <c:if test="${artiolid > 0}">
									 	
									 	<button type="button" class="btn btn-success buttonSalva" onclick="" disabled>Salva</button>
									 	<p><span class="label label-danger labelSalva" >Impossibile creare l'intervento, mancano degli articoli in magazzino</span>
									 </c:if>
					            </div>
					      </div>
					       



						   
			          </form>
			          
		   			 </div>
		   		</div>
		    </div>
	 	</div>
	 </section>
	 
	 

	 
<div id="myModalWarning" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="myModalWarningContent">

        
        
  		 </div>
      
    </div>
     <div class="modal-footer">
    	<button type="button" id="actionWarning" class="btn btn-success" data-dismiss="modal">SI</button>
    	<button type="button" class="btn btn-danger" data-dismiss="modal">NO</button>
    </div>
  </div>
    </div>

</div>
<div id="myModalAggregazione" class="modal fade modal-fullscreen" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Lista Accessori Aggregabili</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="myModalAggregazioneContent">
		<table  class="table table-striped" id="myModalAggregazioneAccessorio""> 
			<thead>
					  <tr>
					   <th>Quantità Necessaria</th>
					    <th>Nome</th>
					     <th>Descrizione</th>
					     <th>Capacità Totale Richiesta</th>
					     </tr>
					     </thead>
					     <tbody>
					     
			</tbody>
		
		
		</table>
        <table class="table table-striped" id="tableAggregati">
					<thead>
					  <tr>
					   <th>Quantità Calcolata</th>
					    <th>Nome</th>
					     <th>Descrizione</th>
					     <th>Quantità Disponibile</th>
  					       <th>Capacità</th>
					       <th></th>
					     </tr>
					     </thead>
					     <tbody>
					     
					     </tbody></table>
        
  		 </div>
      
    </div>
     <div class="modal-footer">
     <div class="pull-left">Capacità selezionata:<span id="sommaCapacita"></span></div>
   	<button type="button" id="actionSalvaScelte" class="btn btn-success">Salva</button>
    	<button type="button" class="btn btn-danger" data-dismiss="modal">Chiudi</button> 
    </div>
  </div>
    </div>

</div>

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
    	<button type="button" class="btn btn-primary" data-dismiss="modal">Chiudi</button>
    </div>
  </div>
    </div>

</div>
	 	 	 
	 
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
	<script type="text/javascript" src="js/jquery.validate.js"></script>

	<script>
	var accessoriJson = JSON.parse('${listaAccessoriJson}');
	var accessoriAssociatiJson = JSON.parse('${listaAccessoriAssociatiJson}');
	var listaAccAssJson = JSON.parse('${listaAccAssJson}');
  	$(document).ready(function() {
  		
	 	$('input[name="datarange"]').daterangepicker({
		    locale: {
		      format: 'DD/MM/YYYY'
		    }
		}, 
		function(start, end, label) {
		    //alert("A new date range was chosen: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));

			   $( ".dotazioniSelectReq" ).each(function( index ) {
				   $( this ).val(null);
				   $( this ).trigger("change");
				   
				 });
		    
		    
		    
		});
	 	
	 	$(".select2").select2();
	 	 $(".select2").select2({ containerCssClass : "col-lg-12" });    
	 /* 	$(".select2").change(function(e){
			
	          var tipologia = $(".select2").val();
	          
	          var valori = $('select[name="selectTipologiaDotazione[]"]');
  
	    }); */
	    
	 	
    		

		/* $('#tblAppendGrid').appendGrid({
            //caption: 'Valori Campione',
            //captionTooltip: '',
            initRows: 0,
            hideButtons: {
                remove: true,
                insert:true,
                moveUp: true,
                moveDown: true
            },
            columns: [

                      { name: 'quantita_accessorio_extra', display: 'Quantità Necessaria', type: 'number', ctrlClass: 'number required', ctrlCss: { 'text-align': 'center', width: '100%'},onChange: handleChange    },
                      { name: 'accessorio', display: 'Accessorio', type: 'select', ctrlOptions: accessoriJson, ctrlClass: 'required select2 tblAppendGrid_accessorio', ctrlCss: { 'text-align': 'center', "width":"100%"},onChange: handleChange   },
                      { name: 'descrizione_accessorio_extra', display: 'Descrizione', type: 'text', ctrlClass: 'disabled', ctrlCss: { 'text-align': 'center', width: '100%'}    },
                      { name: 'quantita_accessorio_extra_pb', display: 'Quantità Prenotabile', type: 'text', ctrlClass: 'disabled', ctrlCss: { 'text-align': 'center', width: '100%'}    },
                      { name: 'quantita_accessorio_extra_pn', display: 'Quantità Prenotata', type: 'text', ctrlClass: 'disabled', ctrlCss: { 'text-align': 'center', width: '100%'}    },
                      { name: 'quantita_accessorio_extra_m', display: 'Quantità Magazzino', type: 'text', ctrlClass: 'disabled', ctrlCss: { 'text-align': 'center', width: '100%'}    },
                      { name: 'id', type: 'hidden', value: 0 }
                  
                  ] ,
                  initData: [],
               	
                beforeRowRemove: function (caller, rowIndex) {
                    return confirm('Sei sicuro di voler eliminare la riga?');
                },
                afterRowRemoved: function (caller, rowIndex) {
                		$(".ui-tooltip").remove();
                },
                afterRowAppended: function (caller, parentRowIndex, addedRowIndex) {
                    // Copy data of `Year` from parent row to new added rows
                		$(".select2").select2();

                }
        }); */
		   var validator = $("#formNuovoInterventoCampionamento").validate({
			   rules: {
			        'selectTipologiaDotazione[]': {
			            required: true
			        }
			    },
		    	onkeyup: false,
		    	showErrors: function(errorMap, errorList) {
		    	  
		    	    this.defaultShowErrors();
		    	  },
		    	  errorPlacement: function(error, element) {
		    		   
		    		      error.insertBefore(element);
		    		    
		    		  }
		    });
		   
		   jQuery.extend(jQuery.validator.messages, {
			    required: "Campo obbligatorio.",
		   });
		   
		   $('#myModalError').on('hidden.bs.modal', function (e) {
				if($( "#myModalError" ).hasClass( "modal-success" )){
					 var idCommessa =  '${commessa.ID_COMMESSA}';
					callAction('gestioneInterventoCampionamento.do?idCommessa='+idCommessa);
				}
	 		
	  		});
			
	 	
	 });
  	function aggiungiDotazione(){
  		
  		var listaDotazioniJson = JSON.parse('${listaDotazioniJson}');
  		var selected = $("#selectDotazioneSpot").val();
  		var option = '<option value="">Seleziona una dotazione...</option>';
  		var tipologiaCodice=""
  		var tipologiaDescrizione="";
  		$.each(listaDotazioniJson, function(i, item) {

  	
			if(item.idTipologia==selected){
			
				if(!item.matricola){
					item.matricola = "";
				}
				if(!item.targa){
					item.targa = "";
				}
				option += '<option value="'+item.id+'">'+item.modello +' - '+ item.matricola + item.targa +'</option>';
				 if(item.tipologiaCodice!=null){
					 tipologiaCodice = item.tipologiaCodice;
				 }else{
					 tipologiaCodice = "";
				 }
				 if(item.tipologiaDescrizione!=null){
					 tipologiaDescrizione = item.tipologiaDescrizione;
				 }else{
					 tipologiaDescrizione = "";
				 }

			}
  		});
  	 
  		$('#tableDotazioni tr:last-child').after('<tr><td><label class="form-label col-lg-8">'+tipologiaCodice+' - '+tipologiaDescrizione+'</label></td>'+
				  '<td>  <div class="form-group">'+                  
	                 '<div class="col col-lg-4 input-group">'+
						'<select name="selectTipologiaDotazione[]"  data-placeholder="Seleziona una dotazione..." class="form-control select2 dotazioniSelectReq" aria-hidden="true" data-live-search="true" onChange="checkDotazioneSelected(this)" required>'+
	                    option+
	                  '</select>'+
	                  '</div>'+
	       ' </div>'+
	       ' </td><td><button class="btn btn-xs btn-danger" onClick="removeDotazione(this)"><i class="fa fa-fw fa-trash-o"></i></button></td></tr>');
  		
   
  		$('.dotazioniSelectReq').select2();
  		
  		 
  	}
  	function removeDotazione(target){
  		
  		var whichtr = $(target).closest("tr");

  	    whichtr.remove();  
  	    
  	}
  	
  	function checkDotazioneSelected(target){
  		value = $(target).find("option:selected" ).text();
  		exist=0;
  		$("#tableDotazioni tr").each(function() {
  		  $this = $(this);
  		  var selected = $this.find(".dotazioniSelectReq option:selected" ).text();
  		 	if(value==selected && value != ""){
  		 		exist += 1;
  		 	}
  		});
  		
  		if(exist > 1){
  			$("#myModalErrorContent").html("Dotazione già selezionata");
			$("#myModalError").modal();
			$(target).find("option:selected" ).removeAttr("selected");

			$(target).select2();
  		}else{
  			if(value != ""){
	  			sel = $(target).find("option:selected" ).val();
	  			dataRange = $("#datarange").val();
	  			$.ajax({
	  	            type: "POST",
	  	            url: "gestioneInterventoCampionamento.do?action=checkDotazione&idDotazione="+sel+"&dataRange="+dataRange,
	  	            dataType: "json",
	  	            
	  	            //if received a response from the server
	  	            success: function( data, textStatus) {
	  	         		
	  					if(!data.success){
	  						$("#myModalErrorContent").html(data.messaggio);
		  					$("#myModalError").modal();
		  					
		  					 $( target ).val(null);
		  				    $( target ).trigger("change");
	  						
	  					}
	  					pleaseWaitDiv.modal('hide');
	
	  	            },
	  	            error: function( data, textStatus) {
	  	            		$("#myModalErrorContent").html("Errore Check Date Condizioni");
	  					$("#myModalError").modal();
	
	  	            		pleaseWaitDiv.modal('hide');
	  
	  	            }
	  				
	  			});
  			}
  		}
  		
  	}
  	
  	function handleChangeAccessorio(campionamento) {
		quantitaValue = $('#quantitaNecessaria_'+campionamento).val();
		accessorioValue = $('#selectAcccessorio_'+campionamento).val();

		if(quantitaValue != "" && accessorioValue != ""){
			

			var quantitaDisp=0;
			accessoriJson.forEach(function(element) {
				if(element.value == accessorioValue){
				quantitaDisp = element.quantitaFisica;
				quantitaFisica= element.quantitaFisica;
				quantitaPrenotata= element.quantitaPrenotata;
				qm = parseInt(quantitaFisica) + parseInt(quantitaPrenotata);
				descrizione = element.descrizione;
				exist = 0;
				listaAccAssJson.forEach(function(element2) {
					
					if(element.value == element2.id){
						exist = 1;
						quantitaDisp = quantitaDisp - element2.quantitaNecessaria;
						if(parseInt(quantitaDisp)>=parseInt(quantitaValue)){

							/* $("#myModalErrorContent").html("Richiesta ok");
							$("#myModalError").modal(); */

							
						}else if(parseInt(quantitaDisp)>0){
							
							$("#myModalErrorContent").html("La quantita richiesta non è disponibile, in magazzino sono presenti n. "+quantitaDisp+" accessori prenotabili. <br /> Verrà inserita in automatico la quantità disponibile.");
							$("#myModalError").modal();

							$("#quantitaNecessaria_"+campionamento).val(quantitaDisp);


						}else{
							$("#myModalErrorContent").html("La quantita richiesta non è disponibile, in magazzino non sono presenti accessori prenotabili di questo tipo");
							$("#myModalError").modal();
							$("#quantitaNecessaria_"+campionamento).val(0);
							
						}
					}
				
				});
				
				if(exist==0){
					if(parseInt(quantitaDisp)>=parseInt(quantitaValue)){

						/* $("#myModalErrorContent").html("Richiesta ok");
						$("#myModalError").modal(); */

						
					}else if(parseInt(quantitaDisp)>0){
						
						$("#myModalErrorContent").html("La quantita richiesta non è disponibile, in magazzino sono presenti n. "+quantitaDisp+" accessori prenotabili. <br /> Verrà inserita in automatico la quantità disponibile.");
						$("#myModalError").modal();

						$("#quantitaNecessaria_"+campionamento).val(quantitaDisp);


					}else{
						$("#myModalErrorContent").html("La quantita richiesta non è disponibile, in magazzino non sono presenti accessori prenotabili di questo tipo");
						$("#myModalError").modal();
						$("#quantitaNecessaria_"+campionamento).val(0);
						
					}
				}
				
				}
			
			});
		
  			//console.log(accessoriAssociatiJson);
		}
  		
  		
  		
  	}
  	listaDotazioniToSend = {};
/*   	function handleChangeDotazione(indice) {
		dotazioneValue = $('#selectTipologiaDotazione_'+indice).val();
		
		listaDotazioniToSend[indice] = dotazioneValue;

  		
  		
  		
  	}
  	 */
  	var sommaCapacita={};
  	var valoriSelected={};
  	function aggregaAccessorio(accessorio,campionamento,valoreDefault){
  		 sommaCapacita={};
  		 valoriSelected={};
  		 if(valoreDefault == 2){
  			$("#myModalErrorContent").html("Attenzione, si sta modificando un Accessorio già aggregato.");
			$("#myModalError").modal();
  		 }
  			 $('#actionWarning').attr("onclick",'removeAccessorioCall('+accessorio+',"'+campionamento+'",'+valoreDefault+')');

  			 
     		
  		
  			accessorioJson = {};
  			for(var i = accessoriAssociatiJson[campionamento].length -1; i >= 0 ; i--){
				accessoriojjj = accessoriAssociatiJson[campionamento][i];
			    if(accessoriojjj.id == accessorio){
			    		accessorioJson = Object.assign({}, accessoriojjj);
			    	
			    }
			}

  			capacitatotale = accessorioJson.capacita * accessorioJson.quantitaNecessaria;
  			
  			$('#tableAggregati tbody').html("");
  			$('#myModalAggregazioneAccessorio tbody').html('<tr class="default" id="tr_'+accessorioJson.id+'_'+campionamento+'"> <td id="quantitaNecessaria_'+accessorioJson.id+'_'+campionamento+'">'+accessorioJson.quantitaNecessaria+'</td> <td>'+accessorioJson.nome+'</td> <td>'+accessorioJson.descrizione+'</td><td>'+capacitatotale+accessorioJson.unitaMisura+'</td> </tr>');
  			 var listaAccessoriJson = JSON.parse('${listaAccessoriJson}');
  			listaAccessoriJson.shift();
  			listaAccessoriJson.forEach(function(accessoriot) {
  				
  				if(accessoriot.idTipologia == accessorioJson.tipologia.id ){
  					idComponibili = accessorioJson.idComponibili;
  					arrComponibili = idComponibili.split("|");
  					arrComponibili.forEach(function(element) {
  						if(element == accessoriot.id){
  							
  							capacitat = parseInt(accessoriot.capacita);
  							qnec = parseInt(accessorioJson.quantitaNecessaria);
  							capacitaj = parseInt(accessorioJson.capacita);
  							var qnecessaria=Math.floor((capacitaj*qnec)/capacitat);
  							
  				  			$('#tableAggregati tbody').append('<tr class="success" id="tr_'+accessoriot.id+'_'+campionamento+'"> <td id="quantitaNecessaria_'+accessoriot.id+'_'+campionamento+'">'+qnecessaria+'</td> <td>'+accessoriot.nome+'</td> <td>'+accessoriot.descrizione+'</td> <td>'+accessoriot.quantitaFisica+'</td> <td>'+accessoriot.capacita+accessoriot.um+'</td>  <td align="center"><input onChange="calcolaCapacita('+accessoriot.id+','+accessorioJson.id+',\''+campionamento+'\')" id="agg_'+accessoriot.id+'" onCha type="number" /></td>  </tr>');

  	  				  	}
  					});
  				  
  				}
  		});
  			 
  			 $('#myModalAggregazione').modal();
  			$("#sommaCapacita").html('');
  			 $('#actionSalvaScelte').attr("disabled","disabled");
 			 $('#actionSalvaScelte').attr("onclick",'salvaAggregati('+accessorioJson.id+',\''+campionamento+'\')');

  			
  		 
  	 }
  	 
  	
  	
  	 function calcolaCapacita(accessorio,accessorioOld,campionamento){
  		 
  		accessorioJsonOld = {};
			for(var i = accessoriAssociatiJson[campionamento].length -1; i >= 0 ; i--){
			accessoriojjj = accessoriAssociatiJson[campionamento][i];
		    if(accessoriojjj.id == accessorioOld){
		    		accessorioJsonOld = accessoriojjj;
		    	
		    }
		}
  		 
  		accessorioJson = {};
  		var listaAccessoriJson = JSON.parse('${listaAccessoriJson}');
  		listaAccessoriJson.forEach(function(accessoriot) {

		    if(accessoriot.id == accessorio){
		    		accessorioJson = Object.assign({}, accessoriot);
		    	
		    }
		});
		selezionato = parseInt($("#agg_"+accessorio).val());
		if(selezionato == "" || selezionato == null || isNaN(selezionato)){
			selezionato = 0;
		}
		/* TO DO AGGIUNGERE MODALE DI AVVISO */
		if(selezionato>=accessorioJson.quantitaFisica){
			
			$("#myModalErrorContent").html("La quantita richiesta non è disponibile, in magazzino sono presenti n. "+accessorioJson.quantitaFisica+" accessori prenotabili. <br /> Verrà inserita in automatico la quantità disponibile.");
			$("#myModalError").modal();
			
			 $("#agg_"+accessorio).val(accessorioJson.quantitaFisica);
			 selezionato = accessorioJson.quantitaFisica;
		}
		if(selezionato<0){
			
			$("#myModalErrorContent").html("La quantita inserita non può essere negativa.");
			$("#myModalError").modal();
			
			$("#agg_"+accessorio).val(0);
			selezionato = 0;
		}
		
		sommaCapacita[accessorio] = selezionato * accessorioJson.capacita;
		valoriSelected[accessorio]  = selezionato;
		var somma = 0;
		 for (var key in sommaCapacita) {
		      if (sommaCapacita.hasOwnProperty(key)) {

		        somma+=sommaCapacita[key];
		      }
		  }
		 capacitaNecessaria=parseInt(accessorioJsonOld.capacita) * parseInt(accessorioJsonOld.quantitaNecessaria);
		 if(somma>capacitaNecessaria){
		 	$("#sommaCapacita").html(' <a class="text-yellow">'+somma+accessorioJsonOld.unitaMisura+' - LA SCELTA SUPERA LA CAPACITA RICHIESTA</a>');
		 	 $('#actionSalvaScelte').removeAttr("disabled");
		 	
		 }else if(somma<capacitaNecessaria){
			 $("#sommaCapacita").html(' <a class="text-red">'+somma+accessorioJsonOld.unitaMisura+' - LA SCELTA E\' INFERIORE ALLA CAPACITA RICHIESTA</a>');
			 $('#actionSalvaScelte').attr("disabled","disabled");
		 }else if(somma==capacitaNecessaria){
			 $("#sommaCapacita").html(' <a class="text-green">'+somma+accessorioJsonOld.unitaMisura+'</a>');
			 $('#actionSalvaScelte').removeAttr("disabled");
		 }
		
  	 }
  	 
  	 function salvaAggregati(accessorioJson, campionamento){
  		$("#myModalAggregazione").modal("hide");
		removeAccessorio(accessorioJson,campionamento,1);
  		 for (var key in valoriSelected) {
		      if (valoriSelected.hasOwnProperty(key)) {
		        console.log(key + " -> " + valoriSelected[key]);
				
				inviaQuantitaValues(campionamento,key,valoriSelected[key],"2");
		      }
		  }
  		
  	 }
  	 
  	function removeAccessorio(accessorio,campionamento,valoreDefault){
  		 
  		 if(valoreDefault == 0){
  			 $('#actionWarning').attr("onclick",'removeAccessorioCall('+accessorio+',"'+campionamento+'",'+valoreDefault+')');
  			 $('#myModalWarningContent').html("Il valore che si stà rimuovendo è il valore di default inserito dal sistema. Rimuovere?");
  			 $('#myModalWarning').removeClass();
     		 $('#myModalWarning').addClass("modal modal-warning");
  			 $('#myModalWarning').modal();
  			
  		 }else{
  			removeAccessorioCall(accessorio,campionamento,valoreDefault);
  		 }
  	 }
  	 
  	function removeAccessorioCall(accessorio,campionamento,valoreDefault){
  		pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal();
		

		/* $.ajax({
            type: "POST",
            url: "gestioneInterventoCampionamento.do?action=removeAccessorio&idAccessorio="+accessorio+"&campionamento="+campionamento,
            dataType: "json",
            
            //if received a response from the server
            success: function( data, textStatus) {*/
         		
				$("#tr_"+accessorio+"_"+campionamento).remove();
				accessorioDaEliminare = null;
				for(var i = accessoriAssociatiJson[campionamento].length -1; i >= 0 ; i--){
					accessoriojjj = accessoriAssociatiJson[campionamento][i];
				    if(accessoriojjj.id == accessorio){
				    		accessoriAssociatiJson[campionamento].splice(i, 1);
				    		accessorioDaEliminare = accessoriojjj;
				    }
				}
				
				for(var i = listaAccAssJson.length -1; i >= 0 ; i--){
					accessoriojjj = listaAccAssJson[i];
				    if(accessoriojjj.id == accessorio){
				    		if(accessorioDaEliminare.quantitaNecessaria == accessoriojjj.quantitaNecessaria){
				    			listaAccAssJson.splice(i, 1);
				    			$("#tr_"+accessorio+"_raggruppati").remove();
				    		}else{
				    			accessoriojjj.quantitaNecessaria = accessoriojjj.quantitaNecessaria - accessorioDaEliminare.quantitaNecessaria;
				    			$("#quantitaNecessaria_"+accessoriojjj.id+"_raggruppati").html(accessoriojjj.quantitaNecessaria);
				    			if(accessoriojjj.quantitaNecessaria <= accessoriojjj.quantitaFisica){
				    				$("#tr_"+accessoriojjj.id+"_raggruppati").removeClass("warning");
				    				$("#tr_"+accessoriojjj.id+"_raggruppati").addClass("success");
				    			}
				    			
				    		}
				    }
				}
				
				removeBlocco = true;
				listaAccAssJson.forEach(function(element){
					if(accessoriojjj.quantitaNecessaria > accessoriojjj.quantitaFisica){
						removeBlocco=false;
					}
				});
				
				if(removeBlocco){
					
					$(".labelSalva").remove();
					$(".buttonSalva").removeAttr('disabled');
				}
				
				
				pleaseWaitDiv.modal('hide');

        /*    },
            error: function( data, textStatus) {
            		$("#myModalErrorContent").html("Errore Update quantità");
				$("#myModalError").modal();

            		pleaseWaitDiv.modal('hide');
            		//$('#selectAcccessorio').val("");
            		$('#quantitaNecessaria_'+campionamento).val("");
            		
            		accessoriAssociatiJson[campionamento].forEach(function(element) {
        				
        				if(element.id == accessorioValue){
        					exist = 1;
        					element.quantitaNecessaria =  parseInt(element.quantitaNecessaria) -  parseInt(quantitaValue);
        					
        				}
        	 	    }); 
            		

            }
			
		}); */

  	 }
  	
  	
  	
  	function inviaQuantita(campionamento){
  		
  		quantitaValue = $('#quantitaNecessaria_'+campionamento).val();
		accessorioValue = $('#selectAcccessorio_'+campionamento).val();
		inviaQuantitaValues(campionamento,accessorioValue,quantitaValue,"1");
		
  	}
  	function inviaQuantitaValues(campionamento,accessorioValue,quantitaValue,tipoInvio) {
  		/* pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal(); */
		exist = 0;
		negative = 0;
			var accessorioJson ={};
			
			accessoriJson.forEach(function(elementx) {
				if(elementx.id == accessorioValue){
					accessorioJson = Object.assign({}, elementx);

				}
				
			});
			
			accessoriAssociatiJson[campionamento].forEach(function(element) {
				
				if(element.id == accessorioValue){
					exist = 1;
					
					el=parseInt(element.quantitaNecessaria) +  parseInt(quantitaValue);
					if(el<1){
						negative = 1;
					}else{
						element.quantitaNecessaria = el;
						accessorioJson = Object.assign({}, element);
					}
				}
	 	    }); 
			
			if(negative==0 && quantitaValue != null && quantitaValue != "" && accessorioValue != null && accessorioValue != ""){

		            	if(exist == 1){
		            		$("#quantitaNecessaria_"+accessorioJson.id+"_"+campionamento).html(accessorioJson.quantitaNecessaria);
		            		listaAccAssJson.forEach(function(acc){
		            			if(acc.id == accessorioValue){
  		        					
		        					el=parseInt(acc.quantitaNecessaria) +  parseInt(quantitaValue);
		        					if(el<1){
		        						negativeInList = 1;
		        					}else{
		        						acc.quantitaNecessaria =  el;
		        						accessorioJson = Object.assign({}, acc);
		        						$("#quantitaNecessaria_"+accessorioJson.id+"_raggruppati").html(accessorioJson.quantitaNecessaria);
		        						if(accessorioJson.quantitaNecessaria <= accessorioJson.quantitaFisica){
						    				$("#tr_"+accessorioJson.id+"_raggruppati").removeClass("warning");
						    				$("#tr_"+accessorioJson.id+"_raggruppati").addClass("success");
						    			}else{
						    				
						    				$("#tr_"+accessorioJson.id+"_raggruppati").addClass("warning");
						    				$("#tr_"+accessorioJson.id+"_raggruppati").removeClass("success");
						    			}
		        					}
		        				}
		            		});
		            	}else{
		            		existInList = 0;
		            		negativeInList = 0;
		            		listaAccAssJson.forEach(function(acc){
		            			if(acc.id == accessorioValue){
		        					existInList = 1;
		        					
		        					el=parseInt(acc.quantitaNecessaria) +  parseInt(quantitaValue);
		        					if(el<1){
		        						negativeInList = 1;
		        					}else{
		        						acc.quantitaNecessaria =  el;
		        						accessorioJson = Object.assign({}, acc);
		        						$("#quantitaNecessaria_"+accessorioJson.id+"_raggruppati").html(accessorioJson.quantitaNecessaria);
		        					}
		        				}
		            		});
		            		
		            		
		            		if(negative==0){
		            			if(existInList == 0){
		            				accessorioJson.quantitaNecessaria = quantitaValue;
		            				listaAccAssJson.push(Object.assign({}, accessorioJson));
				            		$('#tableAccessoriRaggruppati tr:last').after('<tr class="success" id="tr_'+accessorioJson.id+'_raggruppati"> <td id="quantitaNecessaria_'+accessorioJson.id+'_raggruppati">'+quantitaValue+'</td> <td>'+accessorioJson.nome+'</td> <td>'+accessorioJson.descrizione+'</td> <td>'+accessorioJson.quantitaFisica+'</td>  </tr>');

		            			}
				            		somma = parseInt(accessorioJson.quantitaFisica) + parseInt(accessorioJson.quantitaPrenotata);
				            		if(accessorioJson.componibile="S"){
					            		$('#tableAccessori_'+campionamento+' tr:last').after('<tr class="success" id="tr_'+accessorioJson.id+'_'+campionamento+'"> <td id="quantitaNecessaria_'+accessorioJson.id+'_'+campionamento+'">'+quantitaValue+'</td> <td>'+accessorioJson.nome+'</td> <td>'+accessorioJson.descrizione+'</td> <td>'+accessorioJson.quantitaFisica+'</td> <td>'+accessorioJson.quantitaPrenotata+'</td> <td>'+somma+'</td><td> <button class="btn btn-xs btn-warning" id="aggregaAccessorioButton_'+accessorioJson.id+'_'+campionamento+'"  onClick="aggregaAccessorio('+accessorioJson.id+',\''+campionamento+'\',\''+tipoInvio+'\')"><i class="fa fa-fw fa-object-group"></i></button></td><td> <button class="btn btn-xs btn-danger" onClick="removeAccessorio('+accessorioJson.id+',\''+campionamento+'\',,\''+tipoInvio+'\')"><i class="fa fa-fw fa-trash-o"></i></button></td>  </tr>');
		
				            		}else{
					            		$('#tableAccessori_'+campionamento+' tr:last').after('<tr class="success" id="tr_'+accessorioJson.id+'_'+campionamento+'"> <td id="quantitaNecessaria_'+accessorioJson.id+'_'+campionamento+'">'+quantitaValue+'</td> <td>'+accessorioJson.nome+'</td> <td>'+accessorioJson.descrizione+'</td> <td>'+accessorioJson.quantitaFisica+'</td> <td>'+accessorioJson.quantitaPrenotata+'</td> <td>'+somma+'</td><td> </td><td> <button class="btn btn-xs btn-danger" onClick="removeAccessorio('+accessorioJson.id+',\''+campionamento+'\',,\''+tipoInvio+'\')"><i class="fa fa-fw fa-trash-o"></i></button></td>  </tr>');
		
				            		}
				            		accessoriAssociatiJson[campionamento].push(Object.assign({}, accessorioJson));
		            			
		            		}
		            	}
		            		
		     
		            		$('#quantitaNecessaria_'+campionamento).val("");
		            		
		            		$("aggregaAccessorioButton_"+accessorioJson.id+"_"+campionamento).attr("onclick","aggregaAccessorio('"+accessorioJson.id+"','"+campionamento+"','"+tipoInvio)");
		            		
	
			}
			
			
			console.log(accessoriAssociatiJson[campionamento]);

			pleaseWaitDiv.modal('hide');
  	}
  	var validator;
  	function salvaInterventoCampionamento(){
  		
  		if(validator != null){
  			validator.resetForm();
  		}
  		
  		validator = $("#formNuovoInterventoCampionamento").validate({
  			
	    	onkeyup: false,
	    	showErrors: function(errorMap, errorList) {
	    	  
	    	    this.defaultShowErrors();
	    	  },
	    	  errorPlacement: function(error, element) {
	    		   
	    		      error.insertBefore(element);
	    		    
	    		  }
	    });
	   
	   jQuery.extend(jQuery.validator.messages, {
		    required: "Campo obbligatorio.",
	   });


	   tipoCamp = validator.element( "#selectTipoCampionamento" );


	   
	   $( ".dotazioniSelectReq" ).each(function( index ) {
		   dotazioniSelectReq = true;
		   if($( this ).val() == "" && $( this ).hasClass("required")){
			   dot = validator.element( "#"+$(this).attr('id') );		   
			   dotazioniSelectReq = false;
	
		   }else{
			   if($( this ).val() != "" && $( this ).val() != null ) {
				   console.log($( this ).val());
				   listaDotazioniToSend[index] = $( this ).val();
			   }
		   }
		   
		 });
  		if($("#selectTipoCampionamento").val() != null && $("#selectTipoCampionamento").val() != "" && tipoCamp && dotazioniSelectReq){
			pleaseWaitDiv = $('#pleaseWaitDialog');
			pleaseWaitDiv.modal();
			jsonData = {};
			jsonData["dotazioni"] = listaDotazioniToSend;	
			
			jsonData["date"]  = $("#datarange").val();
			jsonData["selectTipoCampionamento"] =  $("#selectTipoCampionamento").val();
	
			jsonData["accessoriAss"] = listaAccAssJson;	
			
			$.ajax({
	            type: "POST",
	            url: "gestioneInterventoCampionamento.do?action=salvaIntervento",
	            dataType: "json",
	            data: "data="+JSON.stringify(jsonData),
	            //if received a response from the server
	            success: function( data, textStatus) {
	            	
	            	if(data.success){
	            		$('#myModalError').removeClass();
               		  $('#myModalError').addClass("modal modal-success");
               		  
	            		$("#myModalErrorContent").html(data.messaggio);
						$("#myModalError").modal();
	            		pleaseWaitDiv.modal('hide');
	            		
	            		 
	            	}else{
	            		$('#myModalError').removeClass();
               		  $('#myModalError').addClass("modal modal-danger");
               		  
	            		$("#myModalErrorContent").html(data.messaggio);
						$("#myModalError").modal();
		
		            		pleaseWaitDiv.modal('hide');
	            	}
	            },
	            error: function( data, textStatus) {
	            	
	            	 $('#myModalError').removeClass();
           		  $('#myModalError').addClass("modal modal-danger");
	            	
	            		$("#myModalErrorContent").html(data.message);
					$("#myModalError").modal();
	
	            		pleaseWaitDiv.modal('hide');
	            		
	            		
	
	            }
				
			});
  		}else{
			
  			
  		}
		
	}
  	</script>
</jsp:attribute> 
</t:layout>


