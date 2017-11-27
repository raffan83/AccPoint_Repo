<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
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


UtenteDTO user = (UtenteDTO)session.getAttribute("userObj");


String idSede = (String)session.getAttribute("id_Sede");
String idCliente = (String)session.getAttribute("id_Cliente");



ArrayList<TipoRapportoDTO> listaTipoRapporto = (ArrayList)session.getAttribute("listaTipoRapporto");
ArrayList<TipoStrumentoDTO> listaTipoStrumento = (ArrayList)session.getAttribute("listaTipoStrumento");
ArrayList<StatoStrumentoDTO> listaStatoStrumento = (ArrayList)session.getAttribute("listaStatoStrumento");

ArrayList<LuogoVerificaDTO> listaLuogoVerifica = (ArrayList)session.getAttribute("listaLuogoVerifica");
ArrayList<ClassificazioneDTO> listaClassificazione = (ArrayList)session.getAttribute("listaClassificazione");


%>
<% if(user.checkPermesso("NUOVO_STRUMENTO_METROLOGIA")){ %>
<div class="row">
<div class="col-lg-12">
<button class="btn btn-primary" onClick="nuovoInterventoFromModal('#modalNuovoStrumento')">Nuovo Strumento</button>
<div id="errorMsg" ></div>
</div>
</div>
<%  } %>
<div style="height:10px;"></div>
<div class="row">
<div class="col-xs-12">
 
 
<button class="btn btn-default btnFiltri" id="btnTutti" onClick="filtraStrumenti('tutti')" disabled>Visualizza Tutti</button>

 	<%
     for(StatoStrumentoDTO str :listaStatoStrumento)
     {
     	 %> 
     	 <button class="btn btn-default btnFiltri" id="btnFiltri_<%=str.getId() %>" onClick="filtraStrumenti('<%=str.getNome() %>','<%=str.getId() %>')" ><%=str.getNome() %></button>
  	 <%	 
     }
     %>

 
</div>
 <div class="col-xs-12" id="divFiltroDate" style="display:none;">
	 
			 <div class="form-group">
						        <label for="datarange" class="control-label">Date Filtro:</label>

						     	<div class="col-md-4 input-group">
						     		<div class="input-group-addon">
				                    		<i class="fa fa-calendar"></i>
				                  	</div>
								    <input type="text" class="form-control" id="datarange" name="datarange" value="">
								    <span class="input-group-btn">
				                      	<button type="button" class="btn btn-info btn-flat" onclick="filtraStrumentiInScadenza()">Filtra</button>
				                    </span>
  								</div>
  								
						   </div>



	</div>
 </div>
 <div class="clearfix"></div>
<div class="row" style="margin-top:20px;">
<div class="col-lg-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 						<th>ID</th>
 						<!-- <td>Azioni</td>		 -->		   
            	       <th>Stato Strumento</th>		   
            		   <th>Denominazione</th>
                       <th>Codice Interno</th>
                     
                       <th>Matricola</th>
            
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
 						 <th>Costurttore</th>
                       <th>Modello</th>
                        <th>Divisione</th>
                       <th>Campo Misura</th>
 </tr></thead>
 
 <tbody>
 
 <%
 SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
 for(StrumentoDTO strumento :listaStrumenti)
 {
	 String classValue="";
	 if(listaStrumenti.indexOf(strumento)%2 == 0){
		 
		 classValue = "odd";
	 }else{
		 classValue = "odd";
	 }
	 
	 %>
	 	 <tr class="<%=classValue %> customTooltip" title="Doppio Click per aprire il dettaglio dello Strumento" role="row" id="<%=strumento.get__id() %>">
	 								
	 								

	 								 <td><%=strumento.get__id()%></td>
	 								 <%-- <td>
	 									<button  class="btn btn-primary" onClick="callAction('strumentiMisurati.do?action=ls&id=<%=strumento.get__id()%>')">Misure</button>
	 									<button  class="btn btn-primary" onClick="toggleFuoriServizio('<%=strumento.get__id()%>')">Cambia Stato</button>
	 								</td> --%>
                       				 <td id="stato_<%=strumento.get__id() %>"><%=strumento.getStato_strumento().getNome() %></td>
                       			     <td><%=strumento.getDenominazione()%></td>
                    	             <td><%=strumento.getCodice_interno() %></td>
                    	            
                    	             
                    	             <td><%=strumento.getMatricola()%></td>
                    	            
                    	             <td><%=strumento.getTipo_strumento().getNome() %></td>
                    	             
                    	             <td><%

                    	             if(strumento.getScadenzaDTO() != null){
                    	            	 if(strumento.getScadenzaDTO().getFreq_mesi() != 0){
                    	            		 out.println(strumento.getScadenzaDTO().getFreq_mesi());
                    	            	 }
                   	            	 
                   	            		 }else{
                   	            	 	%> 
                   	            	 		-
                   	            	 	<%	 
                   	             	  }
                    	             
                    	             %></td>
                    	             <td><%
                    	             if(strumento.getScadenzaDTO()!= null){
                    	            	 if(strumento.getScadenzaDTO().getDataUltimaVerifica() != null){
                    	            		 out.println(sdf.format(strumento.getScadenzaDTO().getDataUltimaVerifica()));
                    	            	 }
                    	            	 
                    	             }else{
                    	            	 %> 
                    	            	 -
                    	            	 <%	 
                    	             }
                    	             
                    	             %></td>
                    	             
                    	             <td><%
                    	             if(strumento.getScadenzaDTO() != null){
                    	            	 if(strumento.getScadenzaDTO().getDataProssimaVerifica() != null){
                    	            		 out.println(sdf.format(strumento.getScadenzaDTO().getDataProssimaVerifica()));
                    	            	 }
                    	            	 
                    	             }else{
                    	            	 %> 
                    	            	 -
                    	            	 <%	 
                    	             }
                    	             
                    	             %></td>
                    	             <td><%=strumento.getReparto()%></td>
                    	             
                    	             <td><%
                    	             if(strumento.getScadenzaDTO() != null){
                    	            	 if(strumento.getScadenzaDTO().getTipo_rapporto().getNoneRapporto() != null){
                    	            		 out.println(strumento.getScadenzaDTO().getTipo_rapporto().getNoneRapporto());
                    	            	 }
                    	            	 
                    	             }else{
                    	            	 %> 
                    	            	 -
                    	            	 <%	 
                    	             }
                    	             %></td>
                    	             
                    	             <td><%=strumento.getUtilizzatore()%></td>
                    	             <td><% 
                    	             if(strumento.getLuogo()!=null){
                    	            	 out.println(strumento.getLuogo().getDescrizione());
                    	            	 
                    	             }
                    	             %></td>
                    	             <td><%
                    	             if(strumento.getInterpolazione()!=null){
                    	            	 out.println(strumento.getInterpolazione());
                    	             }
                    	             %></td>
                    	             <td><%=strumento.getClassificazione().getDescrizione()%></td>
                    	             <td><%=strumento.getCompany().getDenominazione()%></td>
								 <td><%
                    	            	 if(strumento.getDataModifica() != null){
                    	            		 out.println(sdf.format(strumento.getDataModifica()));
                    	        		 }else{
                    	            	 %> 
                    	            	 -
                    	            	 <%	 
                    	             }
                    	             
                    	             %></td>
								<td><%
                    	            	 if(strumento.getUserModifica() != null){
                    	            		 out.println(strumento.getUserModifica().getNominativo());
                    	        		 }else{
                    	            	 %> 
                    	            	 -
                    	            	 <%	 
                    	             }
                    	             
                    	             %></td>
                    	             <td><%=strumento.getCostruttore()%></td>
	  							<td><%=strumento.getModello()%></td>
                    	             <td><%=strumento.getRisoluzione()%></td>
                    	             <td><%=strumento.getCampo_misura()%></td>
	
	</tr>
<% 	 
 } 
 %>
 </tbody>
 </table>  
</div>
</div>

<div id="modalNuovoStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Strumento</h4>
      </div>
       <div class="modal-body">

        <form class="form-horizontal" id="formNuovoStrumento">
              

    <div class="form-group">
          <label for="inputEmail" class="col-sm-2 control-label">Stato Strumento:</label>

         <div class="col-sm-10">
         
         <select class="form-control" id="ref_stato_strumento" name="ref_stato_strumento" required>
                      
                       <option></option>
                                            <%
                                            for(StatoStrumentoDTO str :listaStatoStrumento)
                                            {
                                            	 %> 
                            	            	 <option value="<%=str.getId() %>"><%=str.getNome() %></option>
                            	            	 <%	 
                                            }
                                            %>
                                            
                      </select>
         

     	</div>
   </div>

   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Denominazione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="denominazione" type="text" name="denominazione" required value=""/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Codice Interno:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="codice_interno" type="text" name="codice_interno" required value=""/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Costruttore:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="costruttore" type="text" name="costruttore" required  value=""/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Modello:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="modello" type="text" name="modello" required value=""/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Matricola:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="matricola" type="text" name="matricola" required  value=""/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Divisione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="risoluzione" type="text"  name="risoluzione"  required value=""/>
    </div>
       </div>
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Campo Misura:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="campo_misura" type="text" name="campo_misura" required value=""/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Strumento:</label>
        <div class="col-sm-10">

                      <select class="form-control" id="ref_tipo_strumento" name="ref_tipo_strumento" required>
                      
                       <option></option>
                                            <%
                                            for(TipoStrumentoDTO str :listaTipoStrumento)
                                            {
                                            	 %> 
                            	            	 <option value="<%=str.getId() %>"><%=str.getNome() %></option>
                            	            	 <%	 
                                            }
                                            %>
                                            
                      </select>
    </div>
       </div> 
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Rapporto:</label>
        <div class="col-sm-10">

                                            <select class="form-control" id="ref_tipo_rapporto"  name="ref_tipo_rapporto" required >
                                            <option></option>
                                            <%
                                            for(TipoRapportoDTO rapp :listaTipoRapporto)
                                            {
                                            	 %> 
                            	            	 <option value="<%=rapp.getId() %>"><%=rapp.getNoneRapporto() %></option>
                            	            	 <%	 
                                            }
                                            %>
                                            
                                            </select>
                      
    </div>
       </div> 
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Freq verifica:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="freq_mesi" type="number" max="120" name="freq_mesi"  disabled="disabled" value=""/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Ultima Verifica:</label>
        <div class="col-sm-10">
                      <input class="form-control datepicker" id="dataUltimaVerifica" type="text" name="dataUltimaVerifica" disabled="disabled" value="" data-date-format="dd/mm/yyyy"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Prossima Verifica:</label>
        <div class="col-sm-10">
                      <input class="form-control datepicker" id="dataProssimaVerifica" type="text" name="dataProssimaVerifica" disabled="disabled" value="" data-date-format="dd/mm/yyyy"/>
    </div>
       </div> 
       
       
       
       
                 <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Reparto:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="reparto" type="text" name="reparto" value=""/>
    </div>
       </div> 
       
                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Utilizzatore:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="utilizzatore" type="text" name="utilizzatore"  value=""/>
    </div>
       </div> 

	                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Note:</label>
        <div class="col-sm-10">
                      <textarea class="form-control" id="note" type="text" name="note" value=""></textarea>
    </div>
       </div> 
	
	                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Luogo Verifica:</label>
        <div class="col-sm-10">
                      <select class="form-control" id="luogo_verifica"  name="luogo_verifica" required >
                                            <option></option>
                                            <%
                                            for(LuogoVerificaDTO luogo :listaLuogoVerifica)
                                            {
                                            	 %> 
                            	            	 <option value="<%=luogo.getId() %>"><%=luogo.getDescrizione() %></option>
                            	            	 <%	 
                                            }
                                            %>
                                            
                                            </select>
    </div>
       </div> 
	                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Interpolazione:</label>
        <div class="col-sm-10">

                          <select class="form-control" id="interpolazione"  name="interpolazione" required >
                                            <option></option>
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                            <option value="10">10</option>
                                           
                                            
                                            </select>
    </div>
    </div>
       </div> 

				                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Classificazione:</label>
        <div class="col-sm-10">

                       <select class="form-control" id="classificazione"  name="classificazione" required >
                                            <option></option>
                                            <%
                                            for(ClassificazioneDTO clas :listaClassificazione)
                                            {
                                            	 %> 
                            	            	 <option value="<%=clas.getId() %>"><%=clas.getDescrizione() %></option>
                            	            	 <%	 
                                            }
                                            %>
                                            
                                            </select>
    </div>
       </div> 

       
                <button type="submit" class="btn btn-primary" >Salva</button>
        
     
        </form>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

      </div>
    </div>
  </div>
</div>



 <script>

 $(function(){
	
 
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
	                   { responsivePriority: 5, targets: 11 },
	                   { responsivePriority: 6, targets: 12 },
	                  /*  { orderable: false, targets: 6 }, */
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
       	if(contentID == "modificaTab"){
       		exploreModal("modificaStrumento.do?action=modifica&id="+datax[0],"","#modifica")
       	}
       	
       	
       	

 		});
	   
	   
  	});
  	    
  	    
		
  	
  		
    


$('#tabPM thead th').each( function () {
   var title = $('#tabPM thead th').eq( $(this).index() ).text();
   $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');
} );
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
	
	

	$('#tabPM').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
	  } );
	
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
	 
	 
	//Grafici

	var statoStrumentiJson = <%= request.getSession().getAttribute("statoStrumentiJson") %>;
	var tipoStrumentiJson = <%= request.getSession().getAttribute("tipoStrumentiJson") %>;
	var denominazioneStrumentiJson = <%= request.getSession().getAttribute("denominazioneStrumentiJson") %>;
	var freqStrumentiJson = <%= request.getSession().getAttribute("freqStrumentiJson") %>;
	var repartoStrumentiJson = <%= request.getSession().getAttribute("repartoStrumentiJson") %>;
	var utilizzatoreStrumentiJson = <%= request.getSession().getAttribute("utilizzatoreStrumentiJson") %>;

	/* GRAFICO 1*/

	numberBack1 = Math.ceil(Object.keys(statoStrumentiJson).length/6);
	

	
	
	if(numberBack1>0){
		grafico1 = {};
		grafico1.labels = [];
		 
		dataset1 = {};
		dataset1.data = [];
		dataset1.label = "# Strumenti in Servizio";
		
		
		
		
		
			dataset1.backgroundColor = [];
			dataset1.borderColor = [];
		for (i = 0; i < numberBack1; i++) {
			newArr = [
		         'rgba(255, 99, 132, 0.2)',
		         'rgba(54, 162, 235, 0.2)',
		         'rgba(255, 206, 86, 0.2)',
		         'rgba(75, 192, 192, 0.2)',
		         'rgba(153, 102, 255, 0.2)',
		         'rgba(255, 159, 64, 0.2)'
		     ];
			
			newArrB = [
		         'rgba(255,99,132,1)',
		         'rgba(54, 162, 235, 1)',
		         'rgba(255, 206, 86, 1)',
		         'rgba(75, 192, 192, 1)',
		         'rgba(153, 102, 255, 1)',
		         'rgba(255, 159, 64, 1)'
		     ];
			
			dataset1.backgroundColor = dataset1.backgroundColor.concat(newArr);
			dataset1.borderColor = dataset1.borderColor.concat(newArrB);
		}
		dataset1.borderWidth = 1;
		var itemHeight1 = 200;
		$.each(statoStrumentiJson, function(i,val){
			grafico1.labels.push(i);
			dataset1.data.push(val);
			itemHeight1 += 12;
		});
		//$(".grafico1").height(itemHeight1);
		 grafico1.datasets = [dataset1];
		 
		 var ctx1 = document.getElementById("grafico1").getContext("2d");;
		
		 if(myChart1!= null){

			 myChart1.destroy();
		 }
	
		  myChart1 = new Chart(ctx1, {
		     type: 'bar',
		     data: grafico1,
		     options: {
		    	 responsive: true, 
		    	 maintainAspectRatio: true,
		         scales: {
		             yAxes: [{
		                 ticks: {
		                     beginAtZero:true,
		                     autoSkip: false
		                 }
		             }],
		             xAxes: [{
		                 ticks: {
		                     autoSkip: false
		                 }
		             }]
		         }
		     }
		 });
	 
	}else{
		if(myChart1!= null){
		 	myChart1.destroy();
		 }
	}
	 /* GRAFICO 2*/
	 
	 numberBack2 = Math.ceil(Object.keys(tipoStrumentiJson).length/6);
	 if(numberBack2>0){
		 
	 
		grafico2 = {};
		grafico2.labels = [];
		 
		dataset2 = {};
		dataset2.data = [];
		dataset2.label = "# Strumenti per Tipologia";
		
		
 		dataset2.backgroundColor = [ ];
		dataset2.borderColor = [ ];
		for (i = 0; i < numberBack2; i++) {
			newArr = [
		         'rgba(255, 99, 132, 0.2)',
		         'rgba(54, 162, 235, 0.2)',
		         'rgba(255, 206, 86, 0.2)',
		         'rgba(75, 192, 192, 0.2)',
		         'rgba(153, 102, 255, 0.2)',
		         'rgba(255, 159, 64, 0.2)'
		     ];
			
			newArrB = [
		         'rgba(255,99,132,1)',
		         'rgba(54, 162, 235, 1)',
		         'rgba(255, 206, 86, 1)',
		         'rgba(75, 192, 192, 1)',
		         'rgba(153, 102, 255, 1)',
		         'rgba(255, 159, 64, 1)'
		     ];
			
			dataset2.backgroundColor = dataset2.backgroundColor.concat(newArr);
			dataset2.borderColor = dataset2.borderColor.concat(newArrB);
		}
		

		dataset2.borderWidth = 1;
		var itemHeight2 = 200;

		$.each(tipoStrumentiJson, function(i,val){
			grafico2.labels.push(i);
			dataset2.data.push(val);
			itemHeight2 += 12;

		});
		//$(".grafico2").height(itemHeight2);
		 grafico2.datasets = [dataset2];
		 
		 var ctx2 = document.getElementById("grafico2").getContext("2d");;
		 
		 if(myChart2!= null){
			 myChart2.destroy();
		 }
		 
		  myChart2 = new Chart(ctx2, {
		     type: 'bar',
		     data: grafico2,
		     options: {
		    	 responsive: true, 
		    	 maintainAspectRatio: true,
		         scales: {
		             yAxes: [{
		                 ticks: {
		                     beginAtZero:true,
		                     autoSkip: false
		                 }
		             }],
		             xAxes: [{
		                 ticks: {
		                     autoSkip: false
		                 }
		             }]
		         }
		     }
		 });
	 
	 }else{
		 if(myChart2!= null){
			 myChart2.destroy();
		 }
	 }
	 
 	/* GRAFICO 3*/
	 
	 numberBack3 = Math.ceil(Object.keys(denominazioneStrumentiJson).length/6);
	 if(numberBack3>0){
		 
	 
		grafico3 = {};
		grafico3.labels = [];
		 
		dataset3 = {};
		dataset3.data = [];
		dataset3.label = "# Strumenti per Denominazione";
		
		
 		dataset3.backgroundColor = [ ];
		dataset3.borderColor = [ ];
		for (i = 0; i < numberBack3; i++) {
			newArr = [
		         'rgba(255, 99, 132, 0.2)',
		         'rgba(54, 162, 235, 0.2)',
		         'rgba(255, 206, 86, 0.2)',
		         'rgba(75, 192, 192, 0.2)',
		         'rgba(153, 102, 255, 0.2)',
		         'rgba(255, 159, 64, 0.2)'
		     ];
			
			newArrB = [
		         'rgba(255,99,132,1)',
		         'rgba(54, 162, 235, 1)',
		         'rgba(255, 206, 86, 1)',
		         'rgba(75, 192, 192, 1)',
		         'rgba(153, 102, 255, 1)',
		         'rgba(255, 159, 64, 1)'
		     ];
			
			dataset3.backgroundColor = dataset3.backgroundColor.concat(newArr);
			dataset3.borderColor = dataset3.borderColor.concat(newArrB);
		}
		

		dataset3.borderWidth = 1;
		
		var itemHeight3 = 200;
		$.each(denominazioneStrumentiJson, function(i,val){
			grafico3.labels.push(i);
			dataset3.data.push(val);
			itemHeight3 += 12;

		});
		$(".grafico3").height(itemHeight3);
		
		
		
		 grafico3.datasets = [dataset3];
		 
		 var ctx3 = document.getElementById("grafico3").getContext("2d");;
		 
		 if(myChart3!= null){
			 myChart3.destroy();
		 }
		 
		  myChart3 = new Chart(ctx3, {
		     type: 'horizontalBar',
		     data: grafico3,
		     options: {
		    	 responsive: true, 
		    	 maintainAspectRatio: false,
		         scales: {
		             yAxes: [{
		                 ticks: {
		                     beginAtZero:true,
		                     autoSkip: false,
		                     barThickness : 20
		                 }
		             }],
		             xAxes: [{
		                 ticks: {
		                     autoSkip: false
		                 }
		             }]
		         }
		     }
		 });
	 
	 }else{
		 if(myChart3!= null){
			 myChart3.destroy();
		 }
	 }
	 
 /* GRAFICO 4*/
	 
	 numberBack4 = Math.ceil(Object.keys(freqStrumentiJson).length/6);
	 if(numberBack4>0){
		 
	 
		grafico4 = {};
		grafico4.labels = [];
		 
		dataset4 = {};
		dataset4.data = [];
		dataset4.label = "# Strumenti per Frequenza";
		
		
 		dataset4.backgroundColor = [ ];
		dataset4.borderColor = [ ];
		for (i = 0; i < numberBack4; i++) {
			newArr = [
		         'rgba(255, 99, 132, 0.2)',
		         'rgba(54, 162, 235, 0.2)',
		         'rgba(255, 206, 86, 0.2)',
		         'rgba(75, 192, 192, 0.2)',
		         'rgba(153, 102, 255, 0.2)',
		         'rgba(255, 159, 64, 0.2)'
		     ];
			
			newArrB = [
		         'rgba(255,99,132,1)',
		         'rgba(54, 162, 235, 1)',
		         'rgba(255, 206, 86, 1)',
		         'rgba(75, 192, 192, 1)',
		         'rgba(153, 102, 255, 1)',
		         'rgba(255, 159, 64, 1)'
		     ];
			
			dataset4.backgroundColor = dataset4.backgroundColor.concat(newArr);
			dataset4.borderColor = dataset4.borderColor.concat(newArrB);
		}
		

		dataset4.borderWidth = 1;
		var itemHeight4 = 200;

		$.each(freqStrumentiJson, function(i,val){
			grafico4.labels.push(i);
			dataset4.data.push(val);
			itemHeight4 += 12;
		});
	//	$(".grafico4").height(itemHeight4);

		
		 grafico4.datasets = [dataset4];
		 
		 var ctx4 = document.getElementById("grafico4").getContext("2d");;

		 if(myChart4!= null){
			 myChart4.destroy();
		 }
		 
		  myChart4 = new Chart(ctx4, {

		     type: 'horizontalBar',
		     data: grafico4,
		     options: {
		    	 responsive: true, 
		    	 maintainAspectRatio: true,
		         scales: {
		             yAxes: [{
		                 ticks: {
		                     beginAtZero:true,
		                     autoSkip: false,
		                     barThickness : 20
		                 }
		             }],
		             xAxes: [{
		                 ticks: {
		                     autoSkip: false
		                 }
		             }]
		         }
		     }
		 });
	 
	 }else{
		 if(myChart4!= null){
			 myChart4.destroy();
		 }
	 }
	 
 /* GRAFICO 5*/
	 
	 numberBack5 = Math.ceil(Object.keys(repartoStrumentiJson).length/6);
	 if(numberBack5>0){
		 
	 
		grafico5 = {};
		grafico5.labels = [];
		 
		dataset5 = {};
		dataset5.data = [];
		dataset5.label = "# Strumenti per Reparto";
		

 		dataset5.backgroundColor = [ ];
		dataset5.borderColor = [ ];
		for (i = 0; i < numberBack5; i++) {
			newArr = [
		         'rgba(255, 99, 132, 0.2)',
		         'rgba(54, 162, 235, 0.2)',
		         'rgba(255, 206, 86, 0.2)',
		         'rgba(75, 192, 192, 0.2)',
		         'rgba(153, 102, 255, 0.2)',
		         'rgba(255, 159, 64, 0.2)'
		     ];
			
			newArrB = [
		         'rgba(255,99,132,1)',
		         'rgba(54, 162, 235, 1)',
		         'rgba(255, 206, 86, 1)',
		         'rgba(75, 192, 192, 1)',
		         'rgba(153, 102, 255, 1)',
		         'rgba(255, 159, 64, 1)'
		     ];
			
			dataset5.backgroundColor = dataset5.backgroundColor.concat(newArr);
			dataset5.borderColor = dataset5.borderColor.concat(newArrB);
		}
		

		dataset5.borderWidth = 1;
		var itemHeight5 = 200;
		$.each(repartoStrumentiJson, function(i,val){
			grafico5.labels.push(i);
			dataset5.data.push(val);
			itemHeight5 += 12;
		});
		$(".grafico5").height(itemHeight5);

		
		 grafico5.datasets = [dataset5];
		 
		 var ctx5 = document.getElementById("grafico5").getContext("2d");;
		

		 if(myChart5!= null){
			 myChart5.destroy();
		 }
		 
		  myChart5 = new Chart(ctx5, {

		     type: 'horizontalBar',
		     data: grafico5,
		     options: {
		    	 responsive: true, 
		    	 maintainAspectRatio: false,
		         scales: {
		             yAxes: [{
		                 ticks: {
		                     beginAtZero:true,
		                     autoSkip: false,
		                     barThickness : 20
		                 }
		             }],
		             xAxes: [{
		                 ticks: {
		                     autoSkip: false
		                 }
		             }]
		         }
		     }
		 });
	 
	 }else{
		 if(myChart5!= null){
			 myChart5.destroy();
		 }
	 }
	 
 /* GRAFICO 6*/
	 
	 numberBack6 = Math.ceil(Object.keys(utilizzatoreStrumentiJson).length/6);
	 if(numberBack6>0){
		 
	 
		grafico6 = {};
		grafico6.labels = [];
		 
		dataset6 = {};
		dataset6.data = [];
		dataset6.label = "# Strumenti Utilizzatore";
		
		
 		dataset6.backgroundColor = [ ];
		dataset6.borderColor = [ ];
		for (i = 0; i < numberBack6; i++) {
			newArr = [
		         'rgba(255, 99, 132, 0.2)',
		         'rgba(54, 162, 235, 0.2)',
		         'rgba(255, 206, 86, 0.2)',
		         'rgba(75, 192, 192, 0.2)',
		         'rgba(153, 102, 255, 0.2)',
		         'rgba(255, 159, 64, 0.2)'
		     ];
			
			newArrB = [
		         'rgba(255,99,132,1)',
		         'rgba(54, 162, 235, 1)',
		         'rgba(255, 206, 86, 1)',
		         'rgba(75, 192, 192, 1)',
		         'rgba(153, 102, 255, 1)',
		         'rgba(255, 159, 64, 1)'
		     ];
			
			dataset6.backgroundColor = dataset6.backgroundColor.concat(newArr);
			dataset6.borderColor = dataset6.borderColor.concat(newArrB);
		}
		

		dataset6.borderWidth = 1;
		var itemHeight6 = 200;
		$.each(utilizzatoreStrumentiJson, function(i,val){
			grafico6.labels.push(i);
			dataset6.data.push(val);
			itemHeight6 += 12;
		});

		 grafico6.datasets = [dataset6];
		 
		 var ctx6 = document.getElementById("grafico6").getContext("2d");;
		 
		 if(myChart6!= null){
			 myChart6.destroy();
		 }
		 $(".grafico6").height(itemHeight6);
		  myChart6 = new Chart(ctx6, {
		     type: 'horizontalBar',
		     data: grafico6,
		     
		     options: {
		    	 responsive: true, 
		    	 maintainAspectRatio: false,
		         scales: {
		             yAxes: [{
		                 ticks: {
		                     beginAtZero:true,
		                     autoSkip: true,
		                     barThickness : 100
		                 }
		             }],
		             xAxes: [{
		                 ticks: {
		                     autoSkip: true
		                 }
		             }]
		         }
		     }
		 });
	 
	 }else{
		 if(myChart6!= null){
			 myChart6.destroy();
		 }
	 }
	 
	 if(	numberBack1==0 && numberBack2==0 && numberBack3==0 && numberBack4==0 && numberBack5==0 && numberBack6==0){
		 $(".boxgrafici").hide();
		 
	 }else{
		 $(".boxgrafici").show();
	 }
	 
	 
	 
		$('input[name="datarange"]').daterangepicker({
		    locale: {
		      format: 'DD/MM/YYYY'
		    }
		}, 
		function(start, end, label) {
		      /* startDatePicker = start;
		      endDatePicker = end; */
		});
 });

 
//Date range filter
 minDateFilter = "";
 maxDateFilter = "";

 $.fn.dataTableExt.afnFiltering.push(
   function(oSettings, aData, iDataIndex) {

     if (typeof aData._date == 'undefined') {

    	 	var dd = aData[8].split("/");

       aData._date = new Date(dd[2],dd[1]-1,dd[0]).getTime();



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

     return true;
   }
 );
 
 </script>
 
 
 
 