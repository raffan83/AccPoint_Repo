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
			          <form id="formNuovoInterventoCampionamento" action="gestioneInterventoCampionamento.do?action=newIntervento" method="POST">
				            <div class="form-group">
						        <label for="datarange" class="col-md-2 control-label">Date Campionamento:</label>

						     	<div class="col-md-2 input-group input-daterange">
								    <input type="text" class="form-control" id="datarange" name="datarange" value="">
  								</div>
						   </div>
						   
						   <div class="box box-primary">
					            <div class="box-header">
					              <i class="ion ion-clipboard"></i>
					
					              <h3 class="box-title">Lista Accessori</h3>
					
					              <div class="box-tools pull-right">
					            
					              </div>
					            </div>
					            <!-- /.box-header -->
					            <div class="box-body">
					            <div class="col-md-12">
					           		 <table class="table table-striped">
										  <thead>
										    <tr>
											  <th>Quantità Necessaria</th>
										      <th>Nome</th>
										      <th>Descrizione</th>
										      <th>Quantità Prenotabile</th>
										      <th>Quantità Prenotata</th>
										       <th>Quantità in Magazzino</th>
										    </tr>
										  </thead>
										  <tbody>
										  <c:set var="artiolis" value="0" />
										  <c:set var="artioliw" value="0" />
										  <c:set var="artiolid" value="0" />
										  <c:forEach items="${listaAccessoriAssociati}" var="accessorio" varStatus="loop">
										  
										  <c:set var="quantitaEffettiva" value="${accessorio.quantitaPrenotata + accessorio.quantitaFisica}" />
										  
										  <c:if test="${accessorio.quantitaFisica >=  accessorio.quantitaNecessaria}"><c:set var="alertcolor" value="success" /> <c:set var="artiolis" value="${artiolis + 1}" /> </c:if>							  
										  <c:if test="${accessorio.quantitaFisica <  accessorio.quantitaNecessaria}"><c:set var="alertcolor" value="warning" /> <c:set var="artioliw" value="${artioliw + 1}" />  </c:if>
										  <c:if test="${quantitaEffettiva <  accessorio.quantitaNecessaria}"><c:set var="alertcolor" value="danger" /> <c:set var="artiolid" value="${artiolid + 1}" /> </c:if>	
										 
										  
										  
										  <tr class="${alertcolor}">
										  	  
											  <td>${accessorio.quantitaNecessaria}</td>
										      <td>${accessorio.nome}</td>
										      <td>${accessorio.descrizione}</td>
										      <td>${accessorio.quantitaFisica}</td>
										      <td>${accessorio.quantitaPrenotata}</td>
											
											
												<td>${quantitaEffettiva}</td>
										    </tr>
										   
									    </c:forEach>
										    
										    

										  </tbody>
										</table>
					             	   </div>
					             	   <div class="col-md-6">
					             	  	 <table class="table table-bordered table-hover dataTable table-striped no-footer dtr-inline" id="tblAppendGrid">
									   	</table>
									   </div>
					             	   
					            </div>
					            <!-- /.box-body -->
					            <div class="box-footer clearfix no-border">

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
					             	    <c:forEach items="${listaTipologieAssociate}" var="tipologia" varStatus="loop">
											    <div class="form-group">
										                  <label class="form-label col-sm-12">${tipologia.codice} - ${tipologia.descrizione}</label>
										                  <select name="selectTipologiaDotazione" id="selectTipologiaDotazione_${loop.index}" data-placeholder="Seleziona una dotazione..."  class="form-control select2" aria-hidden="true" data-live-search="true" required>
										                    <option value=""></option>
										                      <c:forEach items="${listaDotazioni}" var="dotazione">
										                           <c:if test="${dotazione.tipologia.id == tipologia.id}">
										                           		
										                           			<option value="${dotazione.id}">${dotazione.modello} - ${dotazione.matricola}${dotazione.targa}</option> 
										                           	
										                           		
										                           </c:if>
										                     </c:forEach>
										
										                  </select>
										        </div>
										</c:forEach>
					            </div>
					            <!-- /.box-body -->
					            <div class="box-footer clearfix no-border">
					            		<c:if test="${artioliw == 0 && artiolid == 0}">
									 	<button type="submit" class="btn btn-success" onclick="" >Salva</button>
									 </c:if>
									 <c:if test="${artioliw > 0 && artiolid == 0}">
									 	
									 	<button type="button" class="btn btn-success" onclick="" disabled>Salva</button>
									 	<p><span class="label label-warning">Impossibile creare l'intervento, gli articoli presenti in magazzino sono già prenotati</span></p>
									 </c:if>
									 <c:if test="${artiolid > 0}">
									 	
									 	<button type="button" class="btn btn-success" onclick="" disabled>Salva</button>
									 	<p><span class="label label-danger" >Impossibile creare l'intervento, mancano degli articoli in magazzino</span>
									 </c:if>
					            </div>
					      </div>
					       



						   
			          </form>
			          
		   			 </div>
		   		</div>
		    </div>
	 	</div>
	 </section>
	 
	 
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
	<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>

	<script>
  	$(document).ready(function() {
	 	$('input[name="datarange"]').daterangepicker({
		    locale: {
		      format: 'DD/MM/YY'
		    }
		}, 
		function(start, end, label) {
		    //alert("A new date range was chosen: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
		});
	 	
	 	$(".select2").select2();
	 	 $(".select2").select2({ width: '100%' });    
	 /* 	$(".select2").change(function(e){
			
	          var tipologia = $(".select2").val();
	          
	          var valori = $('select[name="selectTipologiaDotazione[]"]');
  
	    }); */
	    
	 	
    		var accessoriJson = JSON.parse('${listaAccessoriJson}');

		$('#tblAppendGrid').appendGrid({
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

                      { name: 'quantita_accessorio_extra', display: 'Quantità', type: 'number', ctrlClass: 'number required', ctrlCss: { 'text-align': 'center', width: '100%'},onChange: handleChange    },
                      { name: 'accessorio', display: 'Accessorio', type: 'select', ctrlOptions: accessoriJson, ctrlClass: 'required select2', ctrlCss: { 'text-align': 'center', "width":"100%"},onChange: handleChange   },
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
        });
		   var validator = $("#formNuovoInterventoCampionamento").validate({
		    	
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
		   
		   
			function handleChange(evt, rowIndex) {
				quantitaValue = $("#tblAppendGrid_quantita_accessorio_extra_"+(rowIndex+1)).val();
				accessorioValue = $("#tblAppendGrid_accessorio_"+(rowIndex+1)).val();
				
				if(evt.target.id == "tblAppendGrid_accessorio_"+(rowIndex+1) ){
					var countAccessorio = 0;
					$('#tblAppendGrid tbody tr').each(function(){
						var td = $(this).find('td').eq(2);
						attr = td.attr('id');
						value = $("#" + attr + " select").val();
					     if(accessorioValue == value){
					    	 countAccessorio++;
					    	 		
					     }
					    
					   
						
						
	
	
					});
					if(countAccessorio > 1){
						$("#myModalErrorContent").html("Accessorio già selezionato. <br /> Modificare la quantità dell'accessorio già inserito.");
						$("#myModalError").modal();
						$("#tblAppendGrid_accessorio_"+(rowIndex+1)).val("");
					}
				}
				
				if(quantitaValue != "" && accessorioValue != ""){
					
					var accessoriAssociatiJson = JSON.parse('${listaAccessoriAssociatiJson}');

					var quantitaDisp=0;
					accessoriJson.forEach(function(element) {
						if(element.value == accessorioValue){
						quantitaDisp = element.qf;
						accessoriAssociatiJson.forEach(function(element2) {
							
							if(element.value == element2.id){
								quantitaDisp = quantitaDisp - element2.quantitaNecessaria;
								
							}
						
						});
						}
					
					});
				
					if(quantitaDisp>=quantitaValue){

					
						
					}else{
						
						$("#myModalErrorContent").html("La quantita richiesta non è disponibile, in magazzino sono presenti n. "+quantitaDisp+" accessori prenotabili. <br /> Verrà inserita in automatico la quantità disponibile.");
						$("#myModalError").modal();

						$("#tblAppendGrid_quantita_accessorio_extra_"+(rowIndex+1)).val(quantitaDisp);
						//$("#tblAppendGrid_quantita_accessorio_extra_"+(rowIndex+1)).addClass("error");
					}
					
					
		  			console.log(accessoriAssociatiJson);
				}
		  		
		  		
		  		
		  	}
	 	
	 });
  	
  
  	</script>
</jsp:attribute> 
</t:layout>


