<%@page import="java.util.ArrayList"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<%@page import="it.portaleSTI.DTO.AMOperatoreDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Lista attrezzature in prova
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista attrezzature in prova
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">



<div class="col-xs-12">
<button class="btn btn-primary pull-right" onClick="$('#modalNuovoStrumento').modal()" style="margin-right:5px"><i class="fa fa-plus"></i> Nuova Attrezzatura</button> 
</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabAMStrumenti" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th>ID</th>
<th>Cliente utilizzatore</th>
<th>Sede utilizzatore</th>
<th>Descrizione</th>
<th>Matricola</th>

<th>Tipo</th>
<th>Volume</th>
<th>Velocità sonda</th>
<th>Pressione</th>
<th>Costruttore</th>
<th>Numero di fabbrica</th>


<th>Data Verifica</th>
<th>Data Prossima Verifica</th>
<th>Frequenza</th>
<th>Anno</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_strumenti }" var="strumento" varStatus="loop">
	<tr id="row_${loop.index}" >
	
	<td>${strumento.id }</td>
	<td>${strumento.nomeClienteUtilizzatore }</td>	
	<td>${strumento.nomeSedeUtilizzatore }</td>		
	<td>${strumento.descrizione }</td>
	<td>${strumento.matricola }</td>
	<td>${strumento.tipo }</td>
	<td>${strumento.volume }</td>
	<td>${strumento.sondaVelocita }</td>
	<td>${strumento.pressione }</td>
	<td>${strumento.costruttore }</td>
	<td>${strumento.nFabbrica }</td>

	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${strumento.dataVerifica }" /></td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${strumento.dataProssimaVerifica }" /></td>
	<td>${strumento.frequenza }</td>
	<td>${strumento.anno }</td>
	

	<td align="center">
	<%-- <a class="btn btn-info" onClicK="callAction('gestioneVerIntervento.do?action=dettaglio&id_intervento=${utl:encryptData(intervento.id)}')" title="Click per aprire il dettaglio dell'intervento"><i class="fa fa-arrow-right"></i></a>

	--%>
	
<%-- <a class="btn btn-warning" title="Click per modificare l'intervento" onClick="modificaStrumento('${strumento.id}','${utl:escapeJS(strumento.descrizione)}','${utl:escapeJS(strumento.matricola)}','${utl:escapeJS(strumento.tipo)}','${utl:escapeJS(strumento.volume)}','${utl:escapeJS(strumento.pressione)}','${utl:escapeJS(strumento.costruttore)}','${utl:escapeJS(strumento.nFabbrica)}','<fmt:formatDate pattern="dd/MM/yyyy" value="${strumento.dataVerifica}" />','<fmt:formatDate pattern="dd/MM/yyyy" value="${strumento.dataProssimaVerifica}" />','${utl:escapeJS(strumento.frequenza)}','${utl:escapeJS(strumento.anno)}','${strumento.id_cliente}','${strumento.id_sede}',${utl:escapeJS(utl:toJson(strumento)) })"><i class="fa fa-edit"></i></a> --%>

 <a class="btn btn-warning" title="Click per modificare l'intervento" onClick="modificaStrumento(${utl:escapeJS(utl:toJson(strumento)) })"><i class="fa fa-edit"></i></a>
 <a href="#" class="btn btn-primary customTooltip" title="Click per clonare oggetto in prova" onClick="clona('${strumento.id}')"><i class="fa fa-clone"></i></a>
<a href="#" class="btn btn-primary customTooltip customLink" title="Click per visualizzare gli allegati" onclick="modalAllegati('${strumento.id }')"><i class="fa fa-archive"></i></a>	
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

</section>





<form id="nuovoStrumentoForm">

  <div id="modalNuovoStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Oggetto Prova</h4>
      </div>
       <div class="modal-body">
       
           <div class="row">
    

        <label for="inputEmail" class="col-sm-3 control-label">Cliente:</label>
         <div class="col-sm-9">
    
    	                  <select name="cliente_appoggio_general" id="cliente_appoggio_general"  class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%;display:none" >
							
                  <option value=""></option>
                      <c:forEach items="${lista_clienti}" var="cliente">
                           <option value="${cliente.__id}">${cliente.nome} </option> 
                     </c:forEach>
                  
	                  </select>
    
            
                  <input  name="cliente_general" id="cliente_general"  class="form-control" style="width:100%" >
   
        </div>

  </div><br>
  
       <div class="row">
                 <label for="inputEmail" class="col-sm-3 control-label">Sede:</label>
                  
                     

         <div class="col-sm-9">
                  <select name="sede_general" id="sede_general" data-placeholder="Seleziona Sede..."  disabled class="form-control select2 classic_select" aria-hidden="true" data-live-search="true" style="width:100%">
               
                    	<option value=""></option>
             			<c:forEach items="${lista_sedi}" var="sedi">
             	
                          	 		<option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo} - ${sedi.comune} (${sedi.siglaProvincia})</option>       
                          	     
                          
                     	</c:forEach>
                    
                  </select>
                  
        </div>
</div><br>

		<div class="row">
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="descrizione" name="descrizione" style="width:100%" required>  
       	</div>
       </div><br>
       
              <div class="row">
       	<div class="col-sm-3">
       		<label>Matricola</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="matricola" name="matricola" style="width:100%" required>       	
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero di fabbrica</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="numero_fabbrica" name="numero_fabbrica" style="width:100%" required>
       	</div>
       </div><br>
       
         <div class="row">
       	<div class="col-sm-3">
       		<label>Tipo</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="tipo" name="tipo" style="width:100%" required>       	
       	</div>
       </div><br>
       
         <div class="row">
       	<div class="col-sm-3">
       		<label>Pressione</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="pressione" name="pressione" style="width:100%" required>
       	</div>
       </div><br>
       
       
         
       
              <div class="row">
       	<div class="col-sm-3">
       		<label>Volume</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="volume" name="volume" style="width:100%" required>
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Anno</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="anno" name="anno"  type="number" step="1" min="0" style="width:100%" required>
       	</div>
       </div><br>
       
         <div class="row">
       	<div class="col-sm-3">
       		<label>Costruttore</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="costruttore" name="costruttore" style="width:100%" required>
       	</div>
       </div><br>
       
       
         <div class="row">
       	<div class="col-sm-3">
       		<label>Velocità sonda</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="sonda_velocita" name="sonda_velocita" style="width:100%" required>
       	</div>
       </div><br>
       
           
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Frequenza (mesi)</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="frequenza" name="frequenza" style="width:100%" >
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Verifica</label>
       	</div>
       	<div class="col-sm-9">
				<div class='input-group date datepicker' id='datepicker_data_intervento'>
               <input type='text' class="form-control input-small" id="data_verifica" name="data_verifica" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
      
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Prossima Verifica</label>
       	</div>
       	<div class="col-sm-9">
				<div class='input-group date datepicker' id='datepicker_data_intervento'>
               <input type='text' class="form-control input-small" id="data_prossima_verifica" name="data_prossima_verifica" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero porzioni</label>
       	</div>
       	<div class="col-sm-9">
       			<input class="form-control" id="numero_porzioni" name="numero_porzioni" type="number" style="width:10%" required min="0" step="1" >
       	</div>
       </div><br>
       <div class="row">
          	<div class="col-sm-3">
       		<label>Immagine Campione</label>
       	</div>
       	<div class="col-sm-9">
			<!-- Container della select personalizzata -->
			<select class="form-control select2" id="immagine_campione" name="immagine_campione" style="width:100%" data-placeholder="Seleziona immagine campione...">
			<option value=""></option>
			  <c:forEach items="${lista_immagini }" var="immagine">
 <option class="option" value="${immagine.id }">
      ${immagine.descrizione }
     
    </option>
  </c:forEach>
			</select>
			
			

       </div>
       </div><br>
       
       
              <div class="row">
       <div class="col-xs-4">
			<span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Carica Immagine Personalizzata...</span>
				<input accept=".jpg,.png"  id="fileupload_img" name="fileupload_img" type="file" >
		       
		   	 </span>
		   	</div>
		 <div class="col-xs-8">
		 <label id="label_img"></label>
		 </div> 
       </div><br>
               <div class="row">
       	<div class="col-sm-11">
       		<label>Zone di riferimento</label>
       		
       		 <table id="tabZone" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
    <thead>
        <tr>
            <th>Zona</th>
            <th>Materiale</th>
            <th>Spessore</th>
            <th>Indicazione</th>
            <th>Punto inizio</th>
            <th>Punto fine</th>
            <th style="max-width:10px text-align:center"></th>
        </tr>
    </thead>
    <tbody>
        <!-- righe dinamiche -->
    </tbody>
</table>


       	</div>
       	<div class="col-sm-1" style="margin-top:65px">
       	<a  class="btn btn-primary btn-xs" onclick="addRow('')"><i class="fa fa-plus"></i></a>
     </div>
       </div><br>
       
       

  		  <div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
<input type="hidden" id="table_zone" name="table_zone">
        <button type="submit" class="btn btn-danger"  >Salva</button>
      </div>
    </div>
  </div>
</div>
</form>


<form id="modificaStrumentoForm">

  <div id="modalModificaStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Strumento</h4>
      </div>
       <div class="modal-body">
       
        <div class="row">
    

        <label for="inputEmail" class="col-sm-3 control-label">Cliente:</label>
         <div class="col-sm-9">
    
    	                     
            
                  <input  name="cliente_general_mod" id="cliente_general_mod"  class="form-control" style="width:100%" >
   
        </div>

  </div><br>
  
       <div class="row">
                 <label for="inputEmail" class="col-sm-3 control-label">Sede:</label>
                  
                     

         <div class="col-sm-9">
                  <select name="sede_general_mod" id="sede_general_mod" data-placeholder="Seleziona Sede..."  disabled class="form-control select2 classic_select" aria-hidden="true" data-live-search="true" style="width:100%">
               
                    	<option value=""></option>
             			<c:forEach items="${lista_sedi}" var="sedi">
             	
                          	 		<option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo} - ${sedi.comune} (${sedi.siglaProvincia})</option>       
                          	     
                          
                     	</c:forEach>
                    
                  </select>
                  
        </div>
</div><br>

		<div class="row">
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="descrizione_mod" name="descrizione_mod" style="width:100%" required>  
       	</div>
       </div><br>
       
              <div class="row">
       	<div class="col-sm-3">
       		<label>Matricola</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="matricola_mod" name="matricola_mod" style="width:100%" required>       	
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero di fabbrica</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="numero_fabbrica_mod" name="numero_fabbrica_mod" style="width:100%" required>
       	</div>
       </div><br>
       
         <div class="row">
       	<div class="col-sm-3">
       		<label>Tipo</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="tipo_mod" name="tipo_mod" style="width:100%" required>       	
       	</div>
       </div><br>
       
         <div class="row">
       	<div class="col-sm-3">
       		<label>Pressione</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="pressione_mod" name="pressione_mod" style="width:100%" required>
       	</div>
       </div><br>
       
       
         
       
              <div class="row">
       	<div class="col-sm-3">
       		<label>Volume</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="volume_mod" name="volume_mod" style="width:100%" required>
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Anno</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="anno_mod" name="anno_mod"  type="number" step="1" min="0" style="width:100%" required>
       	</div>
       </div><br>
       
         <div class="row">
       	<div class="col-sm-3">
       		<label>Costruttore</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="costruttore_mod" name="costruttore_mod" style="width:100%" required>
       	</div>
       </div><br>
       
              <div class="row">
       	<div class="col-sm-3">
       		<label>Velocità sonda</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="sonda_velocita_mod" name="sonda_velocita_mod" style="width:100%" required>
       	</div>
       </div><br>
       
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Frequenza (mesi)</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="frequenza_mod" name="frequenza_mod" style="width:100%" >
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Verifica</label>
       	</div>
       	<div class="col-sm-9">
				<div class='input-group date datepicker' id='datepicker_data_intervento'>
               <input type='text' class="form-control input-small" id="data_verifica_mod" name="data_verifica_mod" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
      
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Prossima Verifica</label>
       	</div>
       	<div class="col-sm-9">
				<div class='input-group date datepicker' id='datepicker_data_intervento'>
               <input type='text' class="form-control input-small" id="data_prossima_verifica_mod" name="data_prossima_verifica_mod" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
         <div class="row">
       	<div class="col-sm-3">
       		<label>Numero porzioni</label>
       	</div>
       	<div class="col-sm-9">
       			<input class="form-control" id="numero_porzioni_mod" name="numero_porzioni_mod" type="number" style="width:10%" required min="0" step="1" >
       	</div>
       </div><br>
       <div class="row">
          	<div class="col-sm-3">
       		<label>Immagine Campione</label>
       	</div>
       	<div class="col-sm-9">
			<!-- Container della select personalizzata -->
			<select class="form-control select2" id="immagine_campione_mod" name="immagine_campione_mod" style="width:100%" data-placeholder="Seleziona immagine campione...">
			<option value=""></option>
			  <c:forEach items="${lista_immagini }" var="immagine">
 <option class="option" value="${immagine.id }">
      ${immagine.descrizione }
     
    </option>
  </c:forEach>
			</select>
			
			

       </div>
       </div><br>
              <div class="row">
       <div class="col-xs-4">
			<span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Carica Immagine Personalizzata...</span>
				<input accept=".jpg,.png"  id="fileupload_img_mod" name="fileupload_img_mod" type="file" >
		       
		   	 </span>
		   	</div>
		 <div class="col-xs-8">
		 <label id="label_img_mod"></label>
		 </div> 
       </div><br>
        <div class="row">
       	<div class="col-sm-11">
       		<label>Zone di riferimento</label>
       		
       		 <table id="tabZone_mod" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
    <thead>
        <tr>
            <th>Zona</th>
            <th>Materiale</th>
            <th>Spessore</th>
            <th>Indicazione</th>
            <th>Punto inizio</th>
            <th>Punto fine</th>
            <th style="max-width:10px text-align:center"></th>
        </tr>
    </thead>
    <tbody>
        <!-- righe dinamiche -->
    </tbody>
</table>


       	</div>
       	<div class="col-sm-1" style="margin-top:65px">
       	<a id="addRow" class="btn btn-primary btn-xs" onclick="addRow('_mod')"><i class="fa fa-plus"></i></a>
     </div>
       </div><br>
       
       

  		  <div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
		<input type="hidden" id="id_strumento" name="id_strumento">
		<input type="hidden" id="table_zone_mod" name="table_zone_mod">
        <button type="submit" class="btn btn-danger"  >Salva</button>
      </div>
    </div>
  </div>
</div>
</form>

 <div id="image-popup"><img id="popup-img" src="" /></div> 
 <div id="image-popup_mod"><img id="popup-img_mod" src="" /></div> 

  <div id="myModalAllegati" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati</h4>
      </div>
       <div class="modal-body">
       <div class="row">
        <div class="col-xs-12">
       <div id="tab_allegati"></div>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      </div>
   
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
	<link type="text/css" href="css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/css/bootstrap-timepicker.css"> 
	<style>
	
	


 #image-popup{
  position: fixed;
  display: none;
  top: 20px;
  right: 20px;
  width: 400px;
   max-height: calc(100vh - 40px);
  background: #fff;
  border: 1px solid #ccc;
  border-radius: 8px;
  padding: 6px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.25);
  z-index: 9999;
}

#image-popup_mod{
  position: fixed;
  display: none;
  top: 20px;
  right: 20px;
  width: 400px;
   max-height: calc(100vh - 40px);
  background: #fff;
  border: 1px solid #ccc;
  border-radius: 8px;
  padding: 6px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.25);
  z-index: 9999;
}


#image-popup img{
  width: 100%;
  height: auto;
  display: block;
  border-radius: 6px;
}
#image-popup_mod img{
  width: 100%;
  height: auto;
  display: block;
  border-radius: 6px;
} 


	</style>

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/js/bootstrap-timepicker.js"></script> 
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">


	
	function modificaStrumento(strumento) { 

		$('#id_strumento').val(strumento.id);
		

		  $('#descrizione_mod').val(strumento.descrizione);
		    $('#matricola_mod').val(strumento.matricola);
		    $('#tipo_mod').val(strumento.tipo);
		    $('#volume_mod').val(strumento.volume);

		    $('#pressione_mod').val(strumento.pressione);
		    $('#costruttore_mod').val(strumento.costruttore);
		    $('#numero_fabbrica_mod').val(strumento.nFabbrica);

		    $('#data_verifica_mod').val(strumento.dataVerifica);
		    $('#data_prossima_verifica_mod').val(strumento.dataProssimaVerifica);
		    $('#frequenza_mod').val(strumento.frequenza);
		    $('#anno_mod').val(strumento.anno);
		    $('#sonda_velocita_mod').val(strumento.sondaVelocita);

		    
		    $('#cliente_general_mod').val(strumento.id_cliente);
		    $('#cliente_general_mod').change()
		    
		    if(strumento.id_sede!=0){
		    	$('#sede_general_mod').val(strumento.id_sede+"_"+strumento.id_cliente);
		    }else{
		    	$('#sede_general_mod').val(strumento.id_sede);
		    }
		    
		    $('#numero_porzioni_mod').val(strumento.numero_porzioni);
		    $('#label_img_mod').html(strumento.filename_img)
		    
		    $('#sede_general_mod').change()
		    
		    
		    	initSelect2Gen('#cliente_general_mod', null, '#modalModificaStrumento');
		    
		    
		    var lista_zone = strumento.listaZoneRiferimento.sort(function(a, b) {
		    	  return a.id - b.id;
		    });
	
		    
		    var table = $('#tabZone_mod').DataTable();
		    table.clear();
		    lista_zone.forEach(function(zona) {
		        table.row.add([
		            zona.zonaRiferimento,
		            zona.materiale,
		            zona.spessore,
		            zona.indicazione,
		            zona.punto_intervallo_inizio,
		            zona.punto_intervallo_fine,
		           '<a class="btn btn-danger btn-xs remove-btn" id="'+zona.id+'"><i class="fa fa-minus"></a>'
		        ]);
		    });

		    table.draw();
		    

		
		 $('#modalModificaStrumento').modal()
	}



$('#myModalModificaStrumento').on('hidden.bs.modal',function(){

	
	$(document.body).css('padding-right', '0px');
});



function addRow(mod){
	var table = $('#tabZone'+mod).DataTable();
    table.row.add([
        '<td contenteditable="true"></td>',
        '<td contenteditable="true"></td>',
        '<td contenteditable="true"></td>',
        '<td contenteditable="true"></td>',
        '<td contenteditable="true"></td>',
        '<td contenteditable="true"></td>',
        '<a class="btn btn-danger btn-xs remove-btn"><i class="fa fa-minus"></a>'
    ]).draw(false);
}



$('#tabZone  tbody').on('click', '.remove-btn', function() {
    t.row($(this).parents('tr')).remove().draw();
});


$('#tabZone_mod  tbody').on('click', '.remove-btn', function() {
    t_mod.row($(this).parents('tr')).remove().draw();
});

var columsDatatables = [];

$("#tabAMStrumenti").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabAMStrumenti thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabAMStrumenti thead th').eq( $(this).index() ).text();
    	
    	  
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	
	
	
    	} );
    
    

} );




function formatDate(data){
	
	   var mydate =  Date.parse(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		var   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}


function clona(id_strumento)
{
	dataObj={};
	dataObj.id_strumento = id_strumento;
	
	callAjax(dataObj, "amGestioneStrumenti.do?action=clona")
	
}

function aggiornaDataProssima(mod) {
    var frequenza = parseInt($('#frequenza'+mod).val(), 10);
    var dataVerificaStr = $('#data_verifica'+mod).val(); // formato: dd/MM/yyyy

    if (!isNaN(frequenza) && dataVerificaStr) {
        var parts = dataVerificaStr.split('/');
        var giorno = parseInt(parts[0], 10);
        var mese = parseInt(parts[1], 10) - 1; // JavaScript usa 0-based per i mesi
        var anno = parseInt(parts[2], 10);

        var data = new Date(anno, mese, giorno);
        data.setMonth(data.getMonth() + frequenza);

        var nuovoGiorno = ('0' + data.getDate()).slice(-2);
        var nuovoMese = ('0' + (data.getMonth() + 1)).slice(-2);
        var nuovoAnno = data.getFullYear();

        $('#data_prossima_verifica'+mod).val(nuovoGiorno + '/' + nuovoMese + '/' + nuovoAnno);
    } else {
        $('#data_prossima_verifica'+mod).val('');
    }
}

$('#frequenza_mod, #data_verifica_mod').on('change input', function() {
    aggiornaDataProssima("_mod");
});


$('#frequenza, #data_verifica').on('change input', function() {
    aggiornaDataProssima("");
});


function formatData (data) {
	  if (!data.id|| data.id=="Nessuno") { return data.text; }
	  var id_immagine = data.id.split("_")[0];
	  

	  var $result= $(
			
	  ' <span class="option-with-thumb" data-large="amGestioneInterventi.do?action=immagine&id_immagine='+id_immagine+'">  <span>'+data.text+'</span>   <img class="thumb" src="amGestioneInterventi.do?action=immagine&id_immagine='+id_immagine+'" style="max-height: 20px; margin-left: 10px; border: 1px solid #aaa;" />  </span>'
	  );
	  return $result;
	};

	
	$('#immagine_campione_mod').on('select2:open', function () {
		
		
		  // Aspetta un attimo che il DOM sia pronto
		 const $dropdown = $('.select2-dropdown'); // Questo è il menu visibile
  if ($('#image-popup_mod').length === 0) {
    $dropdown.append('<div id="image-popup_mod"><img id="popup-img_mod" src="" /></div>');
  } else {
    $dropdown.append($('#image-popup_mod')); // sposta se già esiste
  }
		});
	 
	
	$('#immagine_campione_mod').change(function(){
		
		if($(this).val()!=''){
			$('#label_img_mod').html("");
			$('#fileupload_img_mod').val(null);
		}
		
		
	});
	
	
	$('#immagine_campione').on('select2:open', function () {
		  // Aspetta un attimo che il DOM sia pronto
		 const $dropdown = $('.select2-dropdown'); // Questo è il menu visibile
if ($('#image-popup').length === 0) {
  $dropdown.append('<div id="image-popup"><img id="popup-img" src="" /></div>');
} else {
  $dropdown.append($('#image-popup')); // sposta se già esiste
}
		});
	 
	
	$('#immagine_campione').change(function(){
		
		if($(this).val()!=''){
			$('#label_img').html("");
			$('#fileupload_img').val(null);
		}
		
		
	});
	

$(document).ready(function() {
	
	$('#immagine_campione_mod').select2({
		
		templateResult: formatData,
		  templateSelection: formatData
		//  dropdownParent: $('#modalModificaStrumento')
	});
	
	
	$('#immagine_campione').select2({
		
		templateResult: formatData,
		  templateSelection: formatData
		//  dropdownParent: $('#modalNuovoStrumento')
	});  
	
	
	
	$(document).on('mousemove', '.select2-results__option', function (e) {
		  const id = $('.select2-container--open').prev('select').attr('id');
		  const isMod = id === "immagine_campione_mod";
		  const popupId = isMod ? '#image-popup_mod' : '#image-popup';
		  const imgId = isMod ? '#popup-img_mod' : '#popup-img';

		  const thumbSpan = $(this).find('.option-with-thumb');
		  if (thumbSpan.length > 0) {
		    const largeSrc = thumbSpan.data('large');
		    $(imgId).attr('src', largeSrc);

		    // Coordinate dell'opzione attiva
		    const optionOffset = $(this).offset();
		    const optionHeight = $(this).outerHeight();
		    const popupHeight = 250; // altezza stimata del popup
		    const spaceBelow = $(window).height() - (optionOffset.top + optionHeight);
		    const topPosition = spaceBelow > popupHeight
		      ? optionOffset.top + optionHeight + 5   // sotto
		      : optionOffset.top - popupHeight - 5;   // sopra

		    // Posizione laterale: a destra della select
		    const leftPosition = optionOffset.left + $(this).outerWidth() + 10;

		    $(popupId).css({
		      top: topPosition,
		      left: leftPosition,
		      display: 'block'
		    });
		  }
		});

		$(document).on('mouseleave', '.select2-results__option', function () {
		  $('#image-popup_mod, #image-popup').fadeOut(150);
		});
	
/* 	$(document).on('mousemove', '.select2-results__option', function (e) {
		
		  const id = $('.select2-container--open').prev('select').attr('id');
		  const isMod = id === "immagine_campione_mod";
		  const popupId = isMod ? '#image-popup_mod' : '#image-popup';
		  const imgId = isMod ? '#popup-img_mod' : '#popup-img';

		  const thumbSpan = $(this).find('.option-with-thumb');
		  if (thumbSpan.length > 0) {
		    const largeSrc = thumbSpan.data('large');
		    $(imgId).attr('src', largeSrc);
		    $(popupId).fadeIn(150);
		  } */

		/*   // Risali fino al select originale usando l'elemento di focus attivo
		const id = $('.select2-container--open').prev('select').attr('id');
		if(id=="immagine_campione_mod"){
			 const thumbSpan = $(this).find('.option-with-thumb');
			    if (thumbSpan.length > 0) {
			      const largeSrc = thumbSpan.data('large');
			      $('#popup-img_mod').attr('src', largeSrc);
			      $('#image-popup_mod').css({
			        display: 'block',
			        top: e.pageY -450,
			        left: e.pageX -420
			      });
			    }
		}else{
			 const thumbSpan = $(this).find('.option-with-thumb');
			    if (thumbSpan.length > 0) {
			      const largeSrc = thumbSpan.data('large');
			      $('#popup-img').attr('src', largeSrc);
			      $('#image-popup').css({
			        display: 'block',
			        top: e.pageY -450,
			        left: e.pageX -420
			      });
			    }
		} */
	   
	/*   });

	  $(document).on('mouseleave', '.select2-results__option', function () {
		  const id = $('.select2-container--open').prev('select').attr('id');
			if(id=="immagine_campione_mod"){
			    $('#image-popup_mod').hide();
			    $('#popup-img_mod').attr('src', '');
			}else{
			    $('#image-popup').hide();
			    $('#popup-img').attr('src', '');
			}
	
	  }); */

	

	$("#sede_general").select2();
	$("#sede_general_mod").select2();
	
	initSelect2Gen('#cliente_general', null, '#modalNuovoStrumento');

	
	//initSelect2('#cliente_mod');
	//$('#cliente_mod').change();
	$('#sede_mod').select2();

	$('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });
	//$('.datepicker').datepicker('setDate', new Date());
    $('.dropdown-toggle').dropdown();
     



     table = $('#tabAMStrumenti').DataTable({
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
	        "order": [[ 0, "desc" ]],
		      paging: true, 
		      ordering: true,
		      info: true, 
		      searchable: false, 
		      targets: 0,
		      responsive: true,
		      scrollX: false,
		      stateSave: true,	
		
		      columnDefs: [
		    	  
		    	  { responsivePriority: 1, targets: 15 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabAMStrumenti_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabAMStrumenti').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	
	 t = $('#tabZone').DataTable({
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
	      paging: false, 
	      ordering: false,
	      info: false, 
	      searchable: false,
	      searching: false,
	      targets: 0,
	      responsive: false,
	      scrollX: false,
	      stateSave: false,	
	     	columns: [{createdCell: editableCell},{createdCell: editableCell},{createdCell: editableCell},{createdCell: editableCell},{createdCell: editableCell},{createdCell: editableCell},{}]
	               
	    });
	 
	 
	 
	 
	 
	 
	 t_mod = $('#tabZone_mod').DataTable({
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
		      paging: false, 
		      ordering: false,
		      info: false, 
		      searchable: false, 
		      targets: 0,
		      responsive: false,
		      scrollX: false,
		      stateSave: false,	
		      columns: [{createdCell: editableCell_mod},{createdCell: editableCell_mod},{createdCell: editableCell_mod},{createdCell: editableCell_mod},{createdCell: editableCell_mod},{createdCell: editableCell_mod},{}]
		               
		    });
		 
	
});


$('#fileupload_img').change(function(){
	
	
	$('#label_img').html($(this).val().split("\\")[2]);
});

$('#fileupload_img_mod').change(function(){
	
	$('#immagine_campione_mod').val("")
	$('#immagine_campione_mod').change()
	$('#label_img_mod').html($(this).val().split("\\")[2]);
});

const editableCell_mod = function(cell) {
	
	
	  let original

	  cell.setAttribute('contenteditable', true)
	  cell.setAttribute('spellcheck', false)
	  var index = cell._DT_CellIndex;
	  cell.setAttribute('id',""+index.row+""+index.column)	
	   $(cell).css('text-align', 'center');
	  
	  
	  cell.addEventListener('focus', function(e) {
	    original = e.target.textContent

	     $(cell).css('border', '2px solid red');
	    
	  })
	
	   cell.addEventListener('focusout', function(e) {
	    original = stripHtml(e.target.textContent)
	
	    $(cell).css('border', '1px solid #d1d1d1');
	   $(cell).css('border-bottom-width', '0px');
	    $(cell).css('border-left-width', '0px');
	     
	     
	    //$(e.currentTarget).html('<input type="text" value="'+original+'" onChange="salvaModificaQuestionario()">');
	  })
	  
	   cell.addEventListener('blur', function(e) {
	    if (original !== e.target.textContent) {
	      const row = t_mod.row(e.target.parentElement)
	      t_mod.cell(row.index(),e.target.cellIndex).data(e.target.textContent).draw();
	      var x = t_mod.rows().data();
	      //	salvaModificaQuestionario();
	      console.log('Row changed: ', row.data())
	    }
	  }) 
	  
	
	};





	const editableCell = function(cell) {
		
		
		  let original

		  cell.setAttribute('contenteditable', true)
		  cell.setAttribute('spellcheck', false)
		  var index = cell._DT_CellIndex;
		  cell.setAttribute('id',""+index.row+""+index.column)	
		   $(cell).css('text-align', 'center');
		  
		  
		  cell.addEventListener('focus', function(e) {
		    original = e.target.textContent

		     $(cell).css('border', '2px solid red');
		    
		  })
		
		   cell.addEventListener('focusout', function(e) {
		    original = stripHtml(e.target.textContent)
		
		    $(cell).css('border', '1px solid #d1d1d1');
		   $(cell).css('border-bottom-width', '0px');
		    $(cell).css('border-left-width', '0px');
		     
		     
		    //$(e.currentTarget).html('<input type="text" value="'+original+'" onChange="salvaModificaQuestionario()">');
		  })
		  
		   cell.addEventListener('blur', function(e) {
		    if (original !== e.target.textContent) {
		      const row = t.row(e.target.parentElement)
		      t.cell(row.index(),e.target.cellIndex).data(e.target.textContent).draw();
		      var x = t.rows().data();
		      //	salvaModificaQuestionario();
		      console.log('Row changed: ', row.data())
		    }
		  }) 
		  
		
		};
 
 
 $('#modificaStrumentoForm').on("submit", function(e){

	 e.preventDefault();
	 
	 var esito = true;
	 var data = t_mod.rows().data().toArray();

	 data.forEach(function(rowHtml) {
		    // Crea un elemento temporaneo per lavorare sul contenuto HTML
		    var temp = document.createElement('div');
		    temp.innerHTML = rowHtml;

		    var values = temp.innerHTML.split(",");

		    for (var i = 0; i < values.length; i++) {
		      if(values[i].trim() == ""){
		            esito = false;
		            $('#myModalErrorContent').html("Attenzione! Inserisci tutti i dati della zona di riferimento!");
		            $('#myModalError').removeClass().addClass("modal modal-danger");
		            $('#myModalError').modal();
		            return; 
		        }
		    }
		});
	 
	if(esito){
		$('#table_zone_mod').val(JSON.stringify(data))
		 
		 
		 callAjaxForm('#modificaStrumentoForm','amGestioneStrumenti.do?action=modifica');
	}
	
	 
 });
 
 $('#nuovoStrumentoForm').on("submit", function(e){

	 e.preventDefault();
	 var esito = true;
	 var data = t.rows().data().toArray();
	 
		
	  data.forEach(function(rowHtml) {
		    // Crea un elemento temporaneo per lavorare sul contenuto HTML
		    var temp = document.createElement('div');
		    temp.innerHTML = rowHtml;

		    var values = temp.innerHTML.split(",");

		    for (var i = 0; i < values.length; i++) {
		      if(values[i].trim() == ""){
		            esito = false;
		            $('#myModalErrorContent').html("Attenzione! Inserisci tutti i dati della zona di riferimento!");
		            $('#myModalError').removeClass().addClass("modal modal-danger");
		            $('#myModalError').modal();
		            return; 
		        }
		    }
		});
	 
	if(esito){
		
		$('#table_zone').val(JSON.stringify(data))
		
		 callAjaxForm('#nuovoStrumentoForm','amGestioneStrumenti.do?action=nuovo');
	}
	
	 
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
 
function modalAllegati(id_strumento){

   var dataString ="action=allegati&id_strumento="+ id_strumento;
   exploreModal("amGestioneStrumenti.do",dataString,"#tab_allegati",function(datab,textStatusb){
	   $('#myModalAllegati').modal();	   
	   
   });

}


$('#myModalAllegati').on('hidden.bs.modal',function(){
	
	$(document.body).css('padding-right', '0px');
});

 
 $("#cliente_general_mod").change(function() {
	    
 	  if ($(this).data('options') == undefined) 
 	  {
 	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
 	    $(this).data('options', $('#sede_general_mod option').clone());
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
 	 $("#sede_general_mod").prop("disabled", false);
 	 
 	  $('#sede_general_mod').html(opt);
 	  
 	  $("#sede_general_mod").trigger("chosen:updated");
 	  
 	  //if(opt.length<2 )
 	  //{ 
 		$("#sede_general_mod").change();  
 	  //}
 	  
 	
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
 
 
 function initSelect2Gen(id_input, placeholder, modal) {
 	  if(placeholder==null){
 		  placeholder = "Seleziona Cliente...";
 	  }

   	$(id_input).select2({
   	    data: mockDataGen(),
   	    dropdownParent: $(modal),
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
  
</jsp:attribute> 
</t:layout>

