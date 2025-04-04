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
<%@page import="java.util.Date"%>
<%@page import="it.portaleSTI.Util.Utility" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:directive.page import="it.portaleSTI.DTO.ClienteDTO"/>
<jsp:directive.page import="it.portaleSTI.DTO.StrumentoDTO"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
//JsonObject json = (JsonObject)session.getAttribute("myObj");
//JsonArray jsonElem = (JsonArray)json.getAsJsonArray("dataInfo");
//Gson gson = new Gson();
//Type listType = new TypeToken<ArrayList<StrumentoDTO>>(){}.getType();
//ArrayList<StrumentoDTO> listaStrumenti = new Gson().fromJson(jsonElem, listType);


UtenteDTO user = (UtenteDTO)session.getAttribute("userObj");

ArrayList<StrumentoDTO> listaStrumenti=(ArrayList)session.getAttribute("listaStrumenti");
ArrayList<TipoRapportoDTO> listaTipoRapporto = (ArrayList)session.getAttribute("listaTipoRapporto");
ArrayList<TipoStrumentoDTO> listaTipoStrumento = (ArrayList)session.getAttribute("listaTipoStrumento");
ArrayList<StatoStrumentoDTO> listaStatoStrumento = (ArrayList)session.getAttribute("listaStatoStrumento");

ArrayList<LuogoVerificaDTO> listaLuogoVerifica = (ArrayList)session.getAttribute("listaLuogoVerifica");
ArrayList<ClassificazioneDTO> listaClassificazione = (ArrayList)session.getAttribute("listaClassificazione");


String idSede = (String)session.getAttribute("id_Sede");
String idCliente = (String)session.getAttribute("id_Cliente");

%>
<c:set var="ruolo_cm" value="${userObj.checkRuolo('CM') }"></c:set>




         <div class="row">
      <div class="col-sm-12">


        <form class="form-horizontal" id="formNuovoStrumentoGeneral">
        
        
        
        


    <div class="form-group">
    

        <label for="inputEmail" class="col-sm-2 control-label">Cliente:</label>



         <div class="col-sm-10">
    
    	                  <select name="cliente_appoggio_general" id="cliente_appoggio_general"  class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%;display:none" >
							
                  <option value=""></option>
                      <c:forEach items="${listaClientiGeneral}" var="cliente">
                           <option value="${cliente.__id}">${cliente.nome} </option> 
                     </c:forEach>
                  
             
	         
	                  </select>
    
            
                
      
                  <input  name="cliente_general" id="cliente_general"  class="form-control" style="width:100%" >
                 
                  
   
        </div>

  </div>



     <div class="form-group">
                 <label for="inputEmail" class="col-sm-2 control-label">Sede:</label>
                  
                     

         <div class="col-sm-10">
                  <select name="sede_general" id="sede_general" data-placeholder="Seleziona Sede..."  disabled class="form-control select2 classic_select" aria-hidden="true" data-live-search="true" style="width:100%">
               
                    	<option value=""></option>
             			<c:forEach items="${listaSediGeneral}" var="sedi">
             	
                          	 		<option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo} - ${sedi.comune} (${sedi.siglaProvincia})</option>       
                          	     
                          
                     	</c:forEach>
                    
                  </select>
                  
        </div>
</div>
  


              

    <div class="form-group">
          <label for="inputEmail" class="col-sm-2 control-label">Stato Strumento:</label>

         <div class="col-sm-10">
         
         <select class="form-control classic_select" id="ref_stato_strumento" name="ref_stato_strumento" required style="width:100%">
                      
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
        <label for="inputName" class="col-sm-2 control-label">Altre matricole:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="altre_matricole" type="text" name="altre_matricole" value=""/>
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

                      <select class="form-control classic_select" id="ref_tipo_strumento" name="ref_tipo_strumento" required style="width:100%">
                      
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

                                            <select class="form-control classic_select" id="ref_tipo_rapporto"  name="ref_tipo_rapporto" required style="width:100%">
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
                      <select class="form-control classic_select" id="luogo_verifica"  name="luogo_verifica" required style="width:100%">
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

                       <select class="form-control classic_select" id="classificazione"  name="classificazione" required style="width:100%">
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
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Note tecniche:</label>

    <div class="col-sm-10">
                      <textarea class="form-control" id="note_tecniche"  name="note_tecniche" ></textarea>
    </div>

       </div> 

                <button type="submit" class="btn btn-primary" >Salva</button>
        
     
      </form>
   
   </div>
        </div>     
      <script>
      
  	$('#formNuovoStrumentoGeneral').on('submit',function(e){
	    e.preventDefault();
		nuovoStrumento($('#sede_general').val(), $('#cliente_general').val())
		
		
		$('#myModalError').on('hidden.bs.modal', function(){
			
			if($('#myModalError').hasClass('modal-success')){
				$('#modalNuovoStrumentoGeneral').modal('hide');	
				if(id_cliente!=0){
        			  
        			  dataString ="idSede="+ id_sede+";"+id_cliente;
        			  exploreModal("listaStrumentiSedeNew.do",dataString,"#posTab",function(datab,textStatusb){
           	        	 // $('#errorMsg').html("<h3 class='label label-success' style=\"color:green\">"+data.messaggio+"</h3>");
            	        	  $("#myModalErrorContent").html(data.messaggio);
            	        	  $('#myModalError').addClass("modal modal-success");
     	          			 $("#myModalError").modal();
            	          });
        	          
				}else{
				
					 location.reload()
				}
				
				
				
			}
		}); 

	});
  	
  	
  	 $("#cliente_general").change(function() {
  	    
  	  	  if ($(this).data('options') == undefined) 
  	  	  {
  	  	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
  	  	    $(this).data('options', $('#sede_general option').clone());
  	  	  }
  	  	  
  	  	  var id = $(this).val();
  	  	 
  	  	  var options = $(this).data('options');

  	  	  var opt=[];
  	  	
  	  	  opt.push("<option value = 0>Non Associate</option>");

  	  	   for(var  i=0; i<options.length;i++)
  	  	   {
  	  		var str=options[i].value; 
  	  	
  	  		if(str.substring(str.indexOf("_")+1,str.length)==id)
  	  		{
  	  			
  	  			//if(opt.length == 0){
  	  				
  	  			//}
  	  		
  	  			opt.push(options[i]);
  	  		}   
  	  	   }
  	  	 $("#sede_general").prop("disabled", false);
  	  	 
  	  	  $('#sede_general').html(opt);
  	  	  
  	  	  $("#sede_general").trigger("chosen:updated");
  	  	  
  	  	  //if(opt.length<2 )
  	  	  //{ 
  	  		$("#sede_general").change();  
  	  	  //}
  	  	  
  	  	
  	  	});
  	
  	 
 	var id_sede ="${id_Sede}";
	var id_cliente ="${id_Cliente}";
  	 
    $(document).ready(function() {
        console.log("test")

    	$(".classic_select").select2();
    	
    	
    	
    	$("#sede_general").select2();
    	
    

    	
    	
    	if(id_cliente!=0){
    		 $("#cliente_general").val(id_cliente);
    		 $("#cliente_general").change();
    		 
    		 if(id_sede==0){
    			 $("#sede_general").val(0);
    		 }else{
    			 $("#sede_general").val(id_sede);
    		 }
    		 $("#sede_general").change()
    		 
    	}
    	
    	var ruolo_cm = "${ruolo_cm}";
    	
    	if(ruolo_cm=="true"){
    		 $("#cliente_general").attr("disabled", true);
    		 $("#sede_general").attr("disabled", true);
    	}
    	
    });
  	
	$( "#ref_tipo_rapporto" ).change(function() {

		  if(this.value == 7201 || this.value == 7203){
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
    
    var options_general =  $('#cliente_appoggio_general option').clone();
    function mockDataGen() {
    	  return _.map(options_general, function(i) {		  
    	    return {
    	      id: i.value,
    	      text: i.text,
    	    };
    	  });
    	}
    
    
    function initSelect2Gen(id_input, placeholder) {
  	  if(placeholder==null){
  		  placeholder = "Seleziona Cliente...";
  	  }

    	$(id_input).select2({
    	    data: mockDataGen(),
    	    dropdownParent: $('#modalNuovoStrumentoGeneral'),
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
  	
      </script>
   
