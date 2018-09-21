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
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="it.portaleSTI.Util.Utility" %>
<jsp:directive.page import="it.portaleSTI.DTO.ClienteDTO"/>
<jsp:directive.page import="it.portaleSTI.DTO.StrumentoDTO"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonArray jsonElem = (JsonArray)json.getAsJsonArray("dataInfo");
Gson gson = new Gson();
Type listType = new TypeToken<ArrayList<StrumentoDTO>>(){}.getType();
ArrayList<StrumentoDTO> listaStrumentiFiltrati = new Gson().fromJson(jsonElem, listType);


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
 
 
<button class="btn btn-primary btnFiltri" id="btnTutti" onClick="filtraStrumenti('tutti')" disabled>Visualizza Tutti</button>

 	<%
     for(StatoStrumentoDTO str :listaStatoStrumento)
     {
     	 %> 
     	 <button class="btn btn-primary btnFiltri" id="btnFiltri_<%=str.getId() %>" onClick="filtraStrumenti('<%=str.getNome() %>','<%=str.getId() %>')" ><%=str.getNome() %></button>
  	 <%	 
     }
     %>
	<button class="btn btn-warning" id="downloadfiltrati" onClick="downloadStrumentiFiltrati()" >Download PDF</button>
 
</div>
 <div class="col-xs-12" id="divFiltroDate" style="">

						<div class="form-group">
						        <label for="datarange" class="control-label">Date Filtro:</label>
								<div class="row">
						     		<div class="col-md-3">
						     		<div class="input-group">
				                    		 <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
				                    		<input type="text" class="form-control" id="datarange" name="datarange" value=""/>
				                  	</div>
								    </div>
								     <div class="col-md-9">
 				                      	<button type="button" class="btn btn-info" onclick="filtraStrumentiInScadenza('prossima')">Filtra Prossima Verifica</button>
 				            
 				                      	<button type="button" class="btn btn-info" onclick="filtraStrumentiInScadenza('ultima')">Filtra Ultima Verifica</button>
				                     
				                   		 <button class="btn btn-primary btnFiltri" id="btnTutti" onClick="filtraStrumenti('tutti')">Reset</button>
 				                
 								</div>
  								</div>
						   </div> 


	</div>
 </div>
 <div class="clearfix"></div>
<div class="row" style="margin-top:20px;">
<div class="col-lg-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
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
 						 <th>Costurttore</th>
                       <th>Modello</th>
                        <th>Divisione</th>
                       <th>Campo Misura</th>
                       <td style="width:100px;">Azioni</td>
 </tr></thead>
 
 <tbody>

 <%
 SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
 for(StrumentoDTO strumento :listaStrumentiFiltrati)
 {
	 String classValue="";
	 if(listaStrumentiFiltrati.indexOf(strumento)%2 == 0){
		 
		 classValue = "odd";
	 }else{
		 classValue = "odd";
	 }
	 
	 %>
	 	 <tr class="<%=classValue %> customTooltip" title="Doppio Click per aprire il dettaglio dello Strumento" role="row" id="<%=strumento.get__id() %>">
	 						 <td></td>		
	 								

	 								 <td><%=strumento.get__id()%></td>
	 								 <td id="stato_<%=strumento.get__id() %>"><span class="label
	 								 <% if(strumento.getStato_strumento().getId()==7225){
	 									 out.print("label-warning");
	 								}else if(strumento.getStato_strumento().getId()==7226){
	 									 out.print("label-success");
	 								}else {
	 									 out.print("label-default");
	 								}
	 								%>
                       				"><%=strumento.getStato_strumento().getNome() %></span></td>
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
                    	           <%-- <td><%
                    	             if(strumento.getInterpolazione()!=null){
                    	            	 out.println(strumento.getInterpolazione());
                    	             }
                    	             %></td>  --%>
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
	 									
	 									<%if(strumento.getUltimaMisura()!=null) {%>
	 									<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio dell'ultima Misura"  href="dettaglioMisura.do?idMisura=<%=Utility.encryptData(String.valueOf(strumento.getUltimaMisura().getId())) %>" ><i class="fa fa-tachometer"></i></a>
										<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio dell'ultimo Intervento" onclick="callAction('gestioneInterventoDati.do?idIntervento=<%=strumento.getUltimaMisura().getIntervento().getId()%>')"><i class="fa fa-file-text-o"></i>  </a>
	 									<%} %>
	 								</td>  
	
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
</div>



 <script>

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
	    	   var title = $('#tabPM thead th').eq( $(this).index() ).text();
	    	   if($(this).index()!= 0){
	    		   $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="width:100%" type="text" value="'+columsDatatables[$(this).index()].search.search+'" /></div>');
	    	   }
	    	  
	    	} );

	} );

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
       pageLength: 100,
	      paging: true, 
	      ordering: true,
	      info: true, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	      stateSave: true,
	      order:[[2, "desc"]],
	      columnDefs: [
					   { responsivePriority: 1, targets: 1 },
	                   { responsivePriority: 3, targets: 3 },
	                   { responsivePriority: 4, targets: 4 },
	                   { responsivePriority: 2, targets: 7 },
	                   { responsivePriority: 5, targets: 12 },
	                   { responsivePriority: 6, targets: 22 },
	                   { responsivePriority: 7, targets: 13 },
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
       	
       	
       	

 		});
	   
	   $('#myModal').on('hidden.bs.modal', function (e) {

    	 	$('#dettaglioTab').tab('show');
    	 	$(document.body).css('padding-right', '0px');
    	 	$('body').removeClass('noScroll');
    	});
	   
	 
	   
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
		var total1 = 0;
		$.each(statoStrumentiJson, function(i,val){
			grafico1.labels.push(i);
			dataset1.data.push(val);
			itemHeight1 += 12;
			total1 += val;
		});
		//$(".grafico1").height(itemHeight1);
		 grafico1.datasets = [dataset1];
		 
		 var ctx1 = document.getElementById("grafico1").getContext("2d");;
		
		 if(myChart1!= null){

			 myChart1.destroy();
		 }
		 	var config1 = {

				     data: grafico1,
				     options: {
				    	 responsive: true, 
				    	 maintainAspectRatio: true,
				         
				     }
				 };
			if(Object.keys(statoStrumentiJson).length<5){
				config1.type = "pieLabels";
				config1.options.tooltips = {
			    		 callbacks: {
			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
			    		      // data : the chart data item containing all of the datasets
			    		      label: function(tooltipItem, data) {
			    		    	  var value = data.datasets[0].data[tooltipItem.index];
			                      var label = data.labels[tooltipItem.index];
			                      var percentage =  value / total1 * 100;
			                     
			                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

			    		      }
			    		    }
	  		 		 };
				$('#grafico1').addClass("col-lg-6");
			}else{
				config1.type = "bar";	
				$('#grafico1').removeClass("col-lg-6");
			
			}
		  myChart1 = new Chart(ctx1, config1);
	 
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
		var total2 = 0;
		$.each(tipoStrumentiJson, function(i,val){
			grafico2.labels.push(i);
			dataset2.data.push(val);
			itemHeight2 += 12;
			total2 += val;
		});
		//$(".grafico2").height(itemHeight2);
		 grafico2.datasets = [dataset2];
		 
		 var ctx2 = document.getElementById("grafico2").getContext("2d");;
		 
		 if(myChart2!= null){
			 myChart2.destroy();
		 }
			var config2 = {

				     data: grafico2,
				     options: {
				    	 responsive: true, 
				    	 maintainAspectRatio: true,
				          
				     }
				 };
			if(Object.keys(tipoStrumentiJson).length<5){
				config2.type = "pieLabels";
				config2.options.tooltips = {
			    		 callbacks: {
			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
			    		      // data : the chart data item containing all of the datasets
			    		      label: function(tooltipItem, data) {
			    		    	  var value = data.datasets[0].data[tooltipItem.index];
			                      var label = data.labels[tooltipItem.index];
			                      var percentage =  value / total2 * 100;
			                     
			                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

			    		      }
			    		    }
	  		 		 };
				$('#grafico2').addClass("col-lg-6");
			}else{
				config2.type = "bar";	
				$('#grafico2').removeClass("col-lg-6");
			
			}
		  myChart2 = new Chart(ctx2, config2);
	 
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
		var total3 = 0;
		$.each(denominazioneStrumentiJson, function(i,val){
			grafico3.labels.push(i);
			dataset3.data.push(val);
			itemHeight3 += 12;
			total3 += val;
		});
		$(".grafico3").height(itemHeight3);
		
		
		
		 grafico3.datasets = [dataset3];
		 
		 var ctx3 = document.getElementById("grafico3").getContext("2d");;
		 
		 if(myChart3!= null){
			 myChart3.destroy();
		 }
		 var config3 = {

			     data: grafico3,
			     options: {
			    	 responsive: true, 
			    	 maintainAspectRatio: false,
			         
			     }
			 };
			if(Object.keys(denominazioneStrumentiJson).length<5){
				config3.type = "pieLabels";
				config3.options.tooltips = {
			    		 callbacks: {
			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
			    		      // data : the chart data item containing all of the datasets
			    		      label: function(tooltipItem, data) {
			    		    	  var value = data.datasets[0].data[tooltipItem.index];
			                      var label = data.labels[tooltipItem.index];
			                      var percentage =  value / total3 * 100;
			                     
			                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

			    		      }
			    		    }
	  		 		 };
				$('#grafico3').addClass("col-lg-6");
			}else{
				config3.type = "horizontalBar";	
				$('#grafico3').removeClass("col-lg-6");
			}
		  myChart3 = new Chart(ctx3, config3);
	 
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
		var total4 = 0;
		$.each(freqStrumentiJson, function(i,val){
			grafico4.labels.push(i);
			dataset4.data.push(val);
			itemHeight4 += 12;
			total4 += val;
		});
	//	$(".grafico4").height(itemHeight4);

		
		 grafico4.datasets = [dataset4];
		 
		 var ctx4 = document.getElementById("grafico4").getContext("2d");;

		 if(myChart4!= null){
			 myChart4.destroy();
		 }
		 var config4 = {


			     data: grafico4,
			     options: {
			    	 responsive: true, 
			    	 maintainAspectRatio: true,
			         
			     }
			 };
			if(Object.keys(freqStrumentiJson).length<5){
				config4.type = "pieLabels";
				config4.options.tooltips = {
			    		 callbacks: {
			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
			    		      // data : the chart data item containing all of the datasets
			    		      label: function(tooltipItem, data) {
			    		    	  var value = data.datasets[0].data[tooltipItem.index];
			                      var label = data.labels[tooltipItem.index];
			                      var percentage =  value / total4 * 100;
			                     
			                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

			    		      }
			    		    }
	  		 		 };
				$('#grafico4').addClass("col-lg-6");
			}else{
				config4.type = "horizontalBar";	
				$('#grafico4').removeClass("col-lg-6");
			}
		  myChart4 = new Chart(ctx4, config4);
	 
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
		var total5 = 0;
		$.each(repartoStrumentiJson, function(i,val){
			grafico5.labels.push(i);
			dataset5.data.push(val);
			itemHeight5 += 12;
			total5 += val;
		});
		$(".grafico5").height(itemHeight5);

		
		 grafico5.datasets = [dataset5];
		 
		 var ctx5 = document.getElementById("grafico5").getContext("2d");;
		

		 if(myChart5!= null){
			 myChart5.destroy();
		 }
		 var config5 =  {


			     data: grafico5,
			     options: {
			    	 responsive: true, 
			    	 maintainAspectRatio: false,
			          
			     }
			 };
			if(Object.keys(repartoStrumentiJson).length<5){
				config5.type = "pieLabels";
				config5.options.tooltips = {
			    		 callbacks: {
			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
			    		      // data : the chart data item containing all of the datasets
			    		      label: function(tooltipItem, data) {
			    		    	  var value = data.datasets[0].data[tooltipItem.index];
			                      var label = data.labels[tooltipItem.index];
			                      var percentage =  value / total5 * 100;
			                     
			                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

			    		      }
			    		    }
	  		 		 };
				$('#grafico5').addClass("col-lg-6");
			}else{
				config5.type = "horizontalBar";	
				$('#grafico5').removeClass("col-lg-6");
			}
		  myChart5 = new Chart(ctx5,config5);
	 
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
		var total6 = 0;
		$.each(utilizzatoreStrumentiJson, function(i,val){
			grafico6.labels.push(i);
			dataset6.data.push(val);
			itemHeight6 += 12;
			total6 += val;
		});

		 grafico6.datasets = [dataset6];
		 
		 var ctx6 = document.getElementById("grafico6").getContext("2d");;
		 
		 if(myChart6!= null){
			 myChart6.destroy();
		 }
		 var config6 = {

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
			 };
			if(Object.keys(utilizzatoreStrumentiJson).length<5){
				config6.type = "pieLabels";
				config6.options.tooltips = {
			    		 callbacks: {
			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
			    		      // data : the chart data item containing all of the datasets
			    		      label: function(tooltipItem, data) {
			    		    	  var value = data.datasets[0].data[tooltipItem.index];
			                      var label = data.labels[tooltipItem.index];
			                      var percentage =  value / total6 * 100;
			                     
			                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

			    		      }
			    		    }
	  		 		 };
				$('#grafico6').addClass("col-lg-6");
			}else{
				config6.type = "horizontalBar";	
				$('#grafico6').removeClass("col-lg-6");
			}
		 $(".grafico6").height(itemHeight6);
		  myChart6 = new Chart(ctx6, config6);
	 
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
 dataType = "";
 
 $.fn.dataTableExt.afnFiltering.push(
   function(oSettings, aData, iDataIndex) {
	   console.log(aData);
	   if(dataType == "prossima"){
		   if (aData[9]) {

	    	 	var dd = aData[9].split("/");

	       aData._date = new Date(dd[2],dd[1]-1,dd[0]).getTime();
	       console.log("Prossima:"+minDateFilter);
		   console.log("MIN:"+minDateFilter);
		   console.log("MAX:"+maxDateFilter);
		   console.log("VAL:"+aData._date);
		   console.log( dd);


	     }
		   
	   }else{
		   if (aData[8]) {

	    	 	var dd = aData[8].split("/");

	       aData._date = new Date(dd[2],dd[1]-1,dd[0]).getTime();
	       console.log("Ultima:"+minDateFilter);
		   console.log("MIN:"+minDateFilter);
		   console.log("MAX:"+maxDateFilter);
		   console.log("VAL:"+aData._date);
		   console.log( dd);


	     }
		   
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
 
 function openDownloadDocumenti(id){

		
		var row = table.row('#'+id);
		datax = row.data();

	   if(datax){
 	    	row.child.hide();
	    //	exploreModal("dettaglioStrumento.do","id_str="+datax[1],"#documentiesterni");
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
     	}
    	
    	
    	

		});
	   $('#documentiesterniTab').tab('show');
	   
	   $('#myModal').on('hidden.bs.modal', function (e) {

    	 	$('#dettaglioTab').tab('show');
    	 	$(document.body).css('padding-right', '0px');
    	 	$('body').removeClass('noScroll');
    	});
	   
	   
 }
 
 
 </script>
 
 
 
 