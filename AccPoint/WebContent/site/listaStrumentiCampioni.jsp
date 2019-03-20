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
<%@page import="it.portaleSTI.Util.Utility" %>

<jsp:directive.page import="it.portaleSTI.DTO.ClienteDTO"/>
<jsp:directive.page import="it.portaleSTI.DTO.StrumentoDTO"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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


<div class="row" style="margin-top:20px;">
<div class="col-lg-12">
  <table id="tabStrumentiCampioni" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 							<th></th>
 						<th>ID</th>
 						  
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
                            <!-- <th>Interpolazione</th>  -->
                            <th>Classificazione</th>
                             <th>Company</th>
                              <th>Data Modifica</th>
                             <th>Utente Modifica</th> 
 						 <th>Costruttore</th>
                       <th>Modello</th>
                        <th>Divisione</th>
                       <th>Campo Misura</th>
                        <td style="min-width:100px;">Azioni</td> 
 </tr></thead>
 
 <tbody >

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
	 						 <td></td>		
	 								

	 								 <td><%=strumento.get__id()%></td>
	 								 <%-- <td id="stato_<%=strumento.get__id() %>"><span class="label
	 								 <% if(strumento.getStato_strumento()!=null && strumento.getStato_strumento().getId()==7225){
	 									 out.print("label-warning");
	 								}else if(strumento.getStato_strumento()!=null && strumento.getStato_strumento().getId()==7226){
	 									 out.print("label-success");
	 								}else {
	 									 out.print("label-default");
	 								}
	 								%>
                       				"><%=strumento.getStato_strumento().getNome() %></span></td>  --%>
                       				 <td><%if(strumento.getStato_strumento()!=null){
                       					out.print(strumento.getStato_strumento().getNome());
                       				 }else{
                       					out.print("NULLO");
                       				 } %>
                       				 </td>
                       			     <td><%=strumento.getDenominazione()%></td>
                    	             <td><%=strumento.getCodice_interno()%></td>
                    	            
                    	             
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
                    	             
                    	                <td>
                    	              <button  class="btn btn-primary" onClick="checkMisure('<%=Utility.encryptData(String.valueOf(strumento.get__id()))%>')">Misure</button>
	 									<button  class="btn btn-danger" onClick="openDownloadDocumenti('<%=strumento.get__id()%>')"><i class="fa fa-file-text-o"></i></button>
	 								</td>  
	
	</tr>
<% 	 
 } 
 %>
 </tbody>
 </table>  
 
 
 <input type="hidden" id ="selected">
</div>
</div>

<%-- div id="modalNuovoStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
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
                      <input class="form-control" id="codice_interno" type="text" name="codice_interno" maxlength="22" required value=""/>
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
                      <input class="form-control" id="matricola" type="text" name="matricola" maxlength="22" required  value=""/>
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
<!-- 	                <div class="form-group">
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
    </div> -->
   

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
</div> --%>

<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript">

	var columsDatatables = [];
	 
	$("#tabStrumentiCampioni").on( 'init.dt', function ( e, settings ) {

	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	     $('#tabStrumentiCampioni thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	    	   var title = $('#tabStrumentiCampioni thead th').eq( $(this).index() ).text();
	    	   if($(this).index()!= 0){
	    		   $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="width:100%" type="text" value="'+columsDatatables[$(this).index()].search.search+'" /></div>');
	    	   }
	    	  
	    	} ); 

	} );
	
	

 $(document).ready(function(){
	
	 console.log("test");
 
	 table = $('#tabStrumentiCampioni').DataTable({
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
	      select: true,
	      order:[[2, "desc"]],
	      columnDefs: [
					 /*   { responsivePriority: 1, targets: 1 },
	                   { responsivePriority: 3, targets: 3 },
	                   { responsivePriority: 4, targets: 4 },
	                   { responsivePriority: 2, targets: 7 },
	                   { responsivePriority: 5, targets: 12 },
	                   { responsivePriority: 6, targets: 22 },
	                   { responsivePriority: 7, targets: 13 }, */
	                   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 7 },
	                   { responsivePriority: 4, targets: 3 },	                 
	                   { responsivePriority: 5, targets: 4 },
	                   { responsivePriority: 6, targets: 12 },
	                   { responsivePriority: 7, targets: 22 }, 
	                   { responsivePriority: 8, targets: 13 },
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

	
/* 			$('#tabStrumentiCampioni').on( 'click','tr', function () {

		var id = $(this).attr('id');
		
		$('#strumento').val(id);
   	

		});  */
		
		
		
		
		$('.inputsearchtable').on('click', function(e){
		    e.stopPropagation();    
		 });
		// DataTable
			table = $('#tabStrumentiCampioni').DataTable();
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
   

			
			$('#tabStrumentiCampioni tbody').on( 'click', 'tr', function () {
		        $(this).toggleClass('selected');
		        var x = $(this).find("td").eq(1).text();
		        $('#selected').val($(this).find("td").eq(1).text());
		    } );
			
	});
	
	
	
	
	
	
	
	   
	/*		$('#tabStrumentiCampioni').on( 'click','tr', function () {

  		var id = $(this).attr('id');
  		
  		var row = table.row('#'+id);
  		datax = row.data();

 	   if(datax){
		  // console.log(datax);
 	    	row.child.hide();
 	    	exploreModal("dettaglioStrumento.do","id_str="+datax[1],"#dettaglio");
 	    	$( "#myModal" ).modal();
 	    	$('body').addClass('noScroll');
 	    } 
	  
 	   $('a[data-toggle="tab"]').one('shown.bs.tab', function (e) {


       	var  contentID = e.target.id;

       	if(contentID == "dettaglioTab"){
       		exploreModal("dettaglioStrumento.do","id_str="+datax[1],"#dettaglio");
       	}
       	if(contentID == "misureTab"){
       		exploreModal("strumentiMisurati.do?action=ls&id="+datax[1],"","#misure")
       	}
       	if(contentID == "modificaTab"){
       		exploreModal("modificaStrumento.do?action=modifica&id="+datax[1],"","#modifica")
       	}
       	if(contentID == "documentiesterniTab"){
       		exploreModal("documentiEsterni.do?id_str="+datax[1],"","#documentiesterni")
       	//	exploreModal("dettaglioStrumento.do","id_str="+datax[1],"#documentiesterni");
       	}
       	
       	
       	

 		}); */
	   
/* 	   $('#myModal').on('hidden.bs.modal', function (e) {

    	 	$('#dettaglioTab').tab('show');
    	 	
    	});
	    
	 
	   
  	});
  	    
  	    */
		
  	
  		
    





<%-- 	$('.datepicker').bootstrapDP({
		format: "dd/mm/yyyy",
	    startDate: '-3d'
	});
	 
	
	$('#formNuovoStrumento').on('submit',function(e){
	    e.preventDefault();
		nuovoStrumento(<%= idSede %>,<%= idCliente %>)

	});
	
	

	$('#tabStrumentiCampioni').on( 'page.dt', function () {
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
	    }); --%>
	 



 </script>
 
 
 
 