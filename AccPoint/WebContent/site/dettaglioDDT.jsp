<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

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
        Dettaglio DDT
        <small></small>
      </h1>
         <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
         <a class="btn btn-default pull-right" href="#" onClick="tornaItem()" style="margin-right:5px"><i class="fa fa-dashboard"></i> Torna agli Item</a>
         <a class="btn btn-default pull-right" href="#" onClick="tornaMagazzino()" style="margin-right:5px"><i class="fa fa-dashboard"></i> Torna al Magazzino</a>
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">

        <div class="col-xs-12">
          <div class="box">
          
            <div class="box-body">
              
            
            <div class="row">
	   <div class="col-xs-6">
	   <c:if test="${ddt.tipo_ddt.id!=1 }">
<button class="btn btn-danger pull-right" onClick="creaFileDDT('${ddt.numero_ddt}', '${pacco.id}', '${pacco.id_cliente}', '${pacco.id_sede}', '${ddt.id}')">Genera DDT <i class="fa fa-file-pdf-o"></i></button>

</c:if>
<button class="btn btn-primary pull-left" onClick="modificaDDT()">Modifica DDT <i class="fa fa-pencil-square-o"></i></button>
</div></div><br>

<div class="row">
<div class="col-xs-6">


<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati DDT
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body" id="dati_ddt">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${ddt.id}</a>
                    
                </li>
                 <li class="list-group-item">
                  <b>Pacco</b> <a href="#" class="btn customTooltip customlink pull-right" title="Click per aprire il dettaglio del pacco" onclick="dettaglioPacco('${utl:encryptData(pacco.id)}')">PC_${pacco.id}</a>
                <%--   <a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio dello strumento" onclick="dettaglioStrumento('${item_pacco.item.id_tipo_proprio}')">${item_pacco.item.id_tipo_proprio}</a></td></c:when> --%>                    
                </li>
                 <li class="list-group-item">
                  <b>Tipo DDT</b> <a class="pull-right">${ddt.tipo_ddt.descrizione}</a>
                </li>

                <li class="list-group-item">
                <c:choose>
                <c:when test="${ddt.tipo_ddt.id==1 }">
                <b>Mittente</b>
                </c:when>
                <c:otherwise>
                <b>Destinatario</b>
                </c:otherwise>                
                </c:choose>
                  <a class="pull-right">${destinatario}</a>
                </li>
                <li class="list-group-item">
                <c:choose>
                <c:when test="${ddt.tipo_ddt.id==1 }">
                <b>Sede Mittente</b>
                </c:when>
                <c:otherwise>
                <b>Sede Destinatario</b>
                </c:otherwise>                
                </c:choose>
                  <a class="pull-right">${sede_destinatario}</a>
                </li>
                <c:if test="${ddt.tipo_ddt.id==2}">
                   <li class="list-group-item">
                  <b>Destinazione</b> <a class="pull-right">${destinazione}</a>
                </li>
                <li class="list-group-item">
                  <b>Sede Destinazione</b> <a class="pull-right">${sede_destinazione}</a>
                </li> 
				</c:if>

                <li class="list-group-item">
                  <b>Spedizioniere</b> <a class="pull-right">${ddt.spedizioniere}</a>
                </li>
                <li class="list-group-item">
                  <b>Data DDT</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" 
         value="${ddt.data_ddt}" /></a>
                </li>
                <li class="list-group-item">
                  <b>Numero DDT</b> <a class="pull-right">${ddt.numero_ddt} </a>
                </li>
                <li class="list-group-item">
                  <b>Causale</b> <a class="pull-right">${ddt.causale.descrizione} </a>
                </li>
                <li class="list-group-item">
                <c:choose>
                <c:when test="${ddt.tipo_trasporto.id==2 }">
               <b>Tipo Trasporto</b> <a class="pull-right">${ddt.tipo_trasporto.descrizione} - ${ddt.operatore_trasporto } </a>                
                </c:when>
                 <c:otherwise>
                <b>Tipo Trasporto</b> <a class="pull-right">${ddt.tipo_trasporto.descrizione} </a>
                </c:otherwise>
                </c:choose>                  
                </li>
                <li class="list-group-item">
                  <b>Tipo Porto</b> <a class="pull-right">${ddt.tipo_porto.descrizione} </a>
                </li>
                <li class="list-group-item">
                  <b>Aspetto</b> <a class="pull-right">${ddt.aspetto.descrizione} </a>
                </li>
                <li class="list-group-item">
                  <b>Annotazioni</b> <a class="pull-right">${ddt.annotazioni} </a>
                </li>
                <li class="list-group-item">
                  <b>Data Trasporto</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" 
       			  value="${ddt.data_trasporto}" /> </a>
                </li>     

                <li class="list-group-item">
                  <b>N. Colli</b> <a class="pull-right"> ${ddt.colli}  </a>
                </li>       
                <li class="list-group-item">
                  <b>Note</b>  <a class="pull-right">${ddt.note} </a> 
                
                </li>
                 <c:if test="${ddt.link_pdf!='' && ddt.link_pdf!=null}"> 
                <li class="list-group-item" id="link">
                
                   <b>Download</b> 
                  <c:url var="url" value="gestioneDDT.do">  					
  					<c:param name="action" value="download" />
  					<c:param name="id_ddt" value="${utl:encryptData(pacco.ddt.id) }"></c:param>
				  </c:url>
                 
<%-- <a   class="btn btn-danger customTooltip pull-right  btn-xs"  title="Click per scaricare il DDT"   onClick="callAction('${url}')"><i class="fa fa-file-pdf-o"></i></a> --%>
<a  target="_blank"  class="btn btn-danger customTooltip pull-right  btn-xs" title="Click per scaricare il DDT"   href="${url}"><i class="fa fa-file-pdf-o fa-sm"></i></a>
                     
                </li>
                </c:if>
         
        </ul>

</div>
</div>
</div>
</div>
             

            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
        

        
 </div>
</div>
       


      <form name="ModificaDdtForm" method="post" id="ModificaDdtForm" action="gestioneDDT.do?action=salva" enctype="multipart/form-data">
         <div id="myModalModificaDdt" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" data-backdrop="static">
          
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica DDT</h4>
      </div>
 
       <div class="modal-body" id="myModalDownloadSchedaConsegnaContent">


<div class="form-group" >

 <div id="collapsed_box" class="box box-danger box-solid collapsed-box" >
<div class="box-header with-border" >
	 DDT
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-plus"></i></button>

	</div>
</div>
<div class="box-body">
<div class="row">
<div class="col-md-12">
<a class="btn btn-primary pull-right disabled" id="conf_button" onClick="importaConfigurazioneDDT()" title="Click per importare la configurazione"><i class="fa fa-arrow-down"></i></a>
</div>
</div>
<div class="row">
<div class="col-md-4">
<label>Numero DDT</label> <a class="pull-center"><input type="text" class="form-control" value="${ddt.numero_ddt}" id="numero_ddt" name="numero_ddt" ></a>
</div>
<div class="col-md-4">
<label>Data DDT</label>    
     
            <span class='date datepicker' id='datepicker_ddt'>
           		<span class="input-group">
               <input type='text' class="form-control input-small" id="data_ddt" name="data_ddt" value="${ddt.data_ddt }"/>
                <span class="input-group-addon">
                    <span class="fa fa-calendar">
                    </span>
                </span>
        </span>
        </span> 

</div>
<div class="col-md-4">
<label>N. Colli</label> <a class="pull-center"><input type="number" class="form-control" id="colli" name="colli"  min=0   value="${ddt.colli }"> </a>
</div>

</div>
<div class="row">
<div class="col-md-12">
 <div  class="box box-danger box-solid" >

<div class="box-body">

<div class="row" id="row_destinazione">
<div class="col-md-4">

<label>Destinazione</label> 
                  <a class="pull-center">
<%--                  <c:choose>
                  <c:when test="${pacco.stato_lavorazione.id==4 || pacco.stato_lavorazione.id==5 }">
                    
                  <select class="form-control select2" data-placeholder="Seleziona Destinazione..." id="destinazione" name="destinazione" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_fornitori}" var="fornitore" varStatus="loop">
                  <option value="${fornitore.__id}">${fornitore.nome}</option>
                  </c:forEach>
                  </select>
                  
                  </c:when>
                  <c:otherwise>
                  
                  <select class="form-control select2" data-placeholder="Seleziona Destinazione..." id="destinazione" name="destinazione" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_clienti}" var="cliente" varStatus="loop">
                  <option value="${cliente.__id}">${cliente.nome}</option>
                  </c:forEach> 
                  </select>
                  
                  </c:otherwise>
                  </c:choose>  --%>
<select class="form-control select2" data-placeholder="Seleziona Destinazione..." id="destinazione" name="destinazione" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_clienti}" var="cliente" varStatus="loop">
                  <option value="${cliente.__id}">${cliente.nome}</option>
                  </c:forEach> 
                  </select>
                  </a> 
</div>

<div class="col-md-4">

<label>Sede Destinazione</label> 
                  <a class="pull-center">
                 <c:choose>
                  <c:when test="${pacco.stato_lavorazione.id==4 || pacco.stato_lavorazione.id==5 }">
                    
                  <select class="form-control select2" data-placeholder="Seleziona Sede Destinazione..." id="sede_destinazione" name="sede_destinazione" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_sedi}" var="sedi" varStatus="loop">               	  
               	 	 <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option>
                  </c:forEach>
                  </select>
                                   
                  </c:when>
                  <c:otherwise>
                  
                  <select class="form-control select2" data-placeholder="Seleziona Sede Destinazione..." id="sede_destinazione" name="sede_destinazione" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_sedi}" var="sedi" varStatus="loop">
               	  <%-- <option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}__${sedi.indirizzo}">${sedi.descrizione} - ${sedi.indirizzo}</option> --%>
               	  <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option> 
                  </c:forEach>
                  </select>
                  
                  
                  </c:otherwise>
                  </c:choose> 

                  
                  </a> 
</div>
</div>

<div class="row">
<div class="col-md-4">
<label id="dest_mitt">Destinatario</label> 
                  <a class="pull-center">
                  
                  <select class="form-control select2" data-placeholder="Seleziona Destinatario..." id="destinatario" name="destinatario" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_clienti}" var="cliente" varStatus="loop">
                  <option value="${cliente.__id}">${cliente.nome}</option>
                  </c:forEach> 
                  </select>
                  
                  </a>

</div>
<div class="col-md-4">

<label id="sede_dest_mitt">Sede Destinatario</label> 
                  <a class="pull-center">
                   <c:choose>
                  <c:when test="${pacco.stato_lavorazione.id==4 || pacco.stato_lavorazione.id==5 }">
                    
                  <select class="form-control select2" data-placeholder="Seleziona Sede Destinatario..." id="sede_destinatario" name="sede_destinatario" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_sedi}" var="sedi" varStatus="loop">
               	  <%-- <option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}__${sedi.indirizzo}">${sedi.descrizione} - ${sedi.indirizzo}</option> --%> 
               	  <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option>
                  </c:forEach>
                  </select>
                                   
                  </c:when>
                  <c:otherwise>
                  
                  <select class="form-control select2" data-placeholder="Seleziona Sede Destinatario..." id="sede_destinatario" name="sede_destinatario" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_sedi}" var="sedi" varStatus="loop">
               	  <%-- <option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}__${sedi.indirizzo}">${sedi.descrizione} - ${sedi.indirizzo}</option> --%>  
               	  <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option> 
                  </c:forEach>
                  </select>
                  
                  
                  </c:otherwise>
                  </c:choose> 
                
                  
                  </a> 

</div>
<div class="col-md-2">
<a class="btn btn-primary" style="margin-top:25px" onClick="importaInfoDaCommessa('${pacco.commessa}', 0)">Importa Da Commessa</a>

</div>

</div>

</div>
</div>
</div>
</div>
<div class="row">
<div class= "col-md-4">
	<label>Tipo DDT</label><select name="tipo_ddt" id="tipo_ddt" data-placeholder="Seleziona Tipo DDT" class="form-control "  aria-hidden="true" data-live-search="true">
		<c:forEach items="${lista_tipo_ddt}" var="tipo_ddt">
		<c:choose>
		<c:when test="${tipo_ddt.id==ddt.tipo_ddt.id }">
			<option value="${tipo_ddt.id}" selected>${tipo_ddt.descrizione}</option>		
			</c:when>	
			<c:otherwise>
			<option value="${tipo_ddt.id}">${tipo_ddt.descrizione}</option>
			</c:otherwise>
			</c:choose>
		</c:forEach>
	</select>
</div>
<div class= "col-md-4">
	<label>Aspetto</label><select name="aspetto" id="aspetto" data-placeholder="Seleziona Tipo Aspetto"  class="form-control select2-drop " aria-hidden="true" data-live-search="true">
		<c:forEach items="${lista_tipo_aspetto}" var="aspetto">
		<c:choose>
		<c:when test="${aspetto.id==ddt.aspetto.id }">
			<option value="${aspetto.id}" selected>${aspetto.descrizione}</option>		
			</c:when>	
			<c:otherwise>
			<option value="${aspetto.id}">${aspetto.descrizione}</option>
			</c:otherwise>
			</c:choose>
		</c:forEach>
		
	</select>

	


</div>

<div class= "col-md-4">
	<label>Tipo Porto</label><select name="tipo_porto" id="tipo_porto" data-placeholder="Seleziona Tipo Porto"  class="form-control select2-drop " aria-hidden="true" data-live-search="true">
		<c:forEach items="${lista_tipo_porto}" var="tipo_porto">
		<c:choose>
		<c:when test="${tipo_porto.id==ddt.tipo_porto.id }">
			<option value="${tipo_porto.id}" selected>${tipo_porto.descrizione}</option>
			</c:when>	
			<c:otherwise>
			<option value="${tipo_porto.id}">${tipo_porto.descrizione}</option>
			</c:otherwise>
			</c:choose>
		</c:forEach>


	</select>
</div>
</div>

<div class="row">
<div class="col-md-4">
<label>Tipo Trasporto</label><select name="tipo_trasporto" id="tipo_trasporto" data-placeholder="Seleziona Tipo Trasporto" class="form-control select2-drop "  aria-hidden="true" data-live-search="true">	
		<c:forEach items="${lista_tipo_trasporto}" var="tipo_trasporto">
			<c:choose>
			<c:when test="${tipo_trasporto.id==pacco.ddt.tipo_trasporto.id }">
			<option value="${tipo_trasporto.id}" selected>${tipo_trasporto.descrizione}</option>
			</c:when>
			<c:otherwise>
			<option value="${tipo_trasporto.id}">${tipo_trasporto.descrizione}</option>
			</c:otherwise>
			</c:choose>
		</c:forEach>
	</select>

</div>
<div class="col-md-4">
<label>Causale</label> 
<select name="causale" id="causale" data-placeholder="Seleziona Causale..." class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%">	
		<option value=""></option>
		<c:forEach items="${lista_causali}" var="causale">
			<c:choose>
			<c:when test="${causale.id==pacco.ddt.causale.id }">
			<option value="${causale.id}" selected>${causale.descrizione}</option>
			</c:when>
			<c:otherwise>
			<option value="${causale.id}">${causale.descrizione}</option>
			</c:otherwise>
			</c:choose>
		</c:forEach>
	</select>
</div>
<div class="col-md-4">
<label>Data Trasporto</label>    

 <span class="date datepicker"  id="datepicker_trasporto" > 
        <span class="input-group">
                     <input type="text" class="form-control date input-small" id="data_ora_trasporto" value="${ddt.data_trasporto }" name="data_ora_trasporto"/>
            
            <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
        </span>
         </span> 

</div>


</div>
<div class="row">

<div class="col-md-4">
 <div class="row" id="operatore_section" style="display:none">
<div class="col-md-12" >
<label>Operatore Trasporto</label>
	<input type="text" id="operatore_trasporto" name="operatore_trasporto" class="form-control">
</div>

</div>  
 <label>Annotazioni</label> <a class="pull-center"><input type="text" class="form-control" value="${ddt.annotazioni }" id="annotazioni" name="annotazioni"> </a>
 <div class="row">
<div class="col-md-12" >
<label>Magazzino</label>
	<select id="magazzino" name="magazzino" class="form-control">
	<option value="Principale">Principale</option>
	</select>
</div>
</div>
</div>
<div class="col-md-4">

<label>Spedizioniere</label> 
<a class="pull-center"><input type="text" class="form-control" value="${ddt.spedizioniere }" id="spedizioniere" name="spedizioniere"> </a>

 <div class="row">
<div class="col-md-12" >
<label>Peso (Kg)</label>
	<input type="text" id="peso" name="peso" class="form-control" value="${ddt.peso }">
</div>

</div> 
</div>
<div class="col-md-4">
 <div class="row">
<div class="col-md-12" >
<label>Account Spedizioniere</label>
<input type="text" id="account" name="account" class="form-control" value="${pacco.ddt.account }"/> 
</div>

</div> 
<label>Cortese Attenzione</label>
	<input type="text" id="cortese_attenzione" name="cortese_attenzione" class="form-control" value="${ddt.cortese_attenzione }">

</div>
</div>
<div class= "row">
<div class="col-md-6">
<label>Note DDT</label>
<select  id= tipo_note_ddt data-placeholder="Seleziona Note..." class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%">	
	<option value=""></option>
		<c:forEach items="${lista_note_ddt}" var="nota_ddt">
			<option value="${nota_ddt.descrizione}">${nota_ddt.descrizione}</option>
		</c:forEach>
	</select>

</div>
<div class="col-md-2">
<a class="btn btn-primary" id="addNotaButton" onClick="aggiungiNotaDDT($('#tipo_note_ddt').val())" style="margin-top:25px"><i class="fa fa-plus"></i></a>
</div>
<div class="col-md-4">
<label>Allega File</label>
 <input id="fileupload_pdf" type="file" name="file" class="form-control"/>
</div>
</div><br>
<div class= "row">
 <div class="col-md-12">
 <a class="pull-center">
	<textarea name="note" form="ModificaDdtForm" id="note" class="form-control" rows=3 style="width:100%">${ddt.note }</textarea></a> 
 
 </div>

</div>

</div>
</div>
</div>
	


</div>


    
     <div class="modal-footer">

		<input type="hidden" class="pull-right" id="configurazione_ddt" name="configurazione_ddt" > 
		<input type="hidden" class="pull-right" id="id_ddt" name="id_ddt">
		<input type="hidden" class="pull-right" id ="pdf_path" name="pdf_path" value="${ddt.link_pdf }">
		<!-- <p align='center'><button class="btn btn-default " onClick="modificaDdtSubmit()"><i class="glyphicon glyphicon"></i> Modifica DDT</button></p> -->  
		<!-- <p align='center'><button class="btn btn-default " onClick="modalConfigurazione()"><i class="glyphicon glyphicon"></i> Modifica DDT</button></p> -->
		<p align='center'><button class="btn btn-default " onClick="chooseSubmit()"><i class="glyphicon glyphicon"></i> Modifica DDT</button></p>
        
    </div>
    </div>
      </div>
    
      </div>

 </form>
  
  
  
        <div id="myModalSaveStato" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Salva Configurazione</h4>
      </div>
       <div class="modal-body">
       Vuoi salvare la configurazione del DDT per la sede selezionata?
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
		<button class="btn btn-primary"  id = "yes_button" onClick="salvaConfigurazione(1)">SI</button>
		<button class="btn btn-primary"  id = "no_button"  onClick="salvaConfigurazione(0)">NO</button>
       
      </div>
    </div>
  </div>
</div>

     <div id="errorMsg"><!-- Place at bottom of page --></div> 
  

</section>
   
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link type="text/css" href="css/bootstrap.min.css" />

        <link rel="stylesheet" type="text/css" href="plugins/datetimepicker/bootstrap-datetimepicker.css" /> 
		<link rel="stylesheet" type="text/css" href="plugins/datetimepicker/datetimepicker.css" /> 
</jsp:attribute>



<jsp:attribute name="extra_js_footer">

		 <script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
		 <script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>

 <script type="text/javascript">
 
	function aggiungiNotaDDT(nota){
		if(nota!=""){
			$('#note').append(nota+ " ");
		}
	}

	function salvaConfigurazione(si_no){

		if(si_no==1){
			modificaDdtSubmit(1);
		}else{
			modificaDdtSubmit(0);
		}

}
	
 	
	function importaConfigurazioneDDT(){
		
		 var lista_save_stato = '${lista_save_stato_json}';
		  var id_cliente = $('#destinazione').val();
		  var id_sede = $('#sede_destinazione').val().split('_')[0];
		  
		  if(lista_save_stato!=null && lista_save_stato!=''){
		  var save_stato_json = JSON.parse(lista_save_stato);
		  
		  save_stato_json.forEach(function(item){
		  	
			  if(id_cliente==item.id_cliente && id_sede ==item.id_sede){
				  $('#spedizioniere').val(item.spedizioniere);
				  $('#account').val(item.account);
				  $('#cortese_attenzione').val(item.ca);
				  $('#tipo_porto').val(item.tipo_porto);
				  $('#aspetto').val(item.aspetto);				  
			  }
		  
		  
		  });
		  }
	} 
	
	
 	function modalConfigurazione(){

			if($('#numero_ddt').val()!=null && $('#numero_ddt').val()!=""){
				var esito = validateForm();
				if(esito){
					$('#myModalSaveStato').modal();
				}
			}else{
				modificaDdtSubmit(0);
			}
		 		
	}
	
	
 	function destinazioneBox(){
		
 		
		var destinatario = "${ddt.id_destinatario}";
		var sede_destinatario = "${ddt.id_sede_destinatario}";
		var destinazione = "${ddt.id_destinazione}";
		var sede_destinazione = "${ddt.id_sede_destinazione}";
		
 		if(destinatario!=null && destinatario !=''&& destinatario !=0){
			$('#destinatario option[value=""]').remove();
		}
		if(sede_destinatario!=null && sede_destinatario !=''){
			$('#sede_destinatario option[value=""]').remove();
		}
		if(destinazione!=null && destinazione !=''&& destinazione !=0){
			$('#destinazione option[value=""]').remove();
			
		}
		if(sede_destinazione!=null && sede_destinazione !=''){
			$('#sede_destinazione option[value=""]').remove();
		} 
		
			
		$('#destinatario option[value="'+destinatario+'"]').attr("selected", true);		
		$('#destinatario').change();
		$('#sede_destinatario option[value="'+sede_destinatario+'_'+destinatario+'"]').attr("selected", true);		
		$('#destinazione option[value="'+destinazione+'"]').attr("selected", true);	
		$('#destinazione').change();
		$('#sede_destinazione option[value="'+sede_destinazione+'_'+destinazione+'"]').attr("selected", true);
		 $('#sede_destinazione').change();
	} 
 	
	function tornaMagazzino(){
		  pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
		  callAction('listaPacchi.do');
	}
	
	
	function tornaItem(){
		pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
		  callAction('listaItem.do?action=lista');
	}
	
	function chooseSubmit(){
		if($('#tipo_ddt').val()==1){
			modificaDdtSubmit(0);
		}else{
			modalConfigurazione();
		}
	}

	  $('#sede_destinazione').change(function(){
		  $('#conf_button').addClass("disabled");
		  if($('#tipo_ddt').val() != 1){
		  var id_cliente = $('#destinazione').val();
		  var id_sede = $('#sede_destinazione').val().split('_')[0];
		  var lista_save_stato = '${lista_save_stato_json}';
		 
		  
 		  if(lista_save_stato!=null && lista_save_stato!=''){
		 	 var save_stato_json = JSON.parse(lista_save_stato);
		  
		  	save_stato_json.forEach(function(item){
		  	
			  if(id_cliente==item.id_cliente && id_sede ==item.id_sede){
				  $('#conf_button').removeClass("disabled");
			  }
		  
		  
		 	 });
		 
		  }

		  }
	  });
 	
 function modificaDDT(){
	 
	 pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal('show');
	
	
	 $('#collapsed_box').removeClass("collapsed-box");
	 $("#myModalModificaDdt").modal('show');
	 destinazioneBox();
	 pleaseWaitDiv.modal('hide');
	 
 }
 
 $('#tipo_trasporto').change(function(){
		
	 var sel =  $('#tipo_trasporto').val();
	 if(sel==2){
		 $('#operatore_section').show();
	 }else{
		 $('#operatore_trasporto').val("");
		 $('#operatore_section').hide();
	 }
	 
 });
 
	function modificaDdtSubmit(configurazione){
		
		var id_pacco= ${pacco.id};
		var id_ddt = ${pacco.ddt.id};
		
		$('#id_pacco').val(id_pacco);
		$('#id_ddt').val(id_ddt);
		$('#configurazione_ddt').val(configurazione);
		var pdf = $('#pdf_path').val();
		var esito = validateForm();
		if(esito==true){
		document.getElementById("ModificaDdtForm").submit();
		
		
		}
		else{};
	}

	function validateForm() {
	  
	    var numero_ddt = document.forms["ModificaDdtForm"]["numero_ddt"].value;
	    $('#data_ddt').css('border', '1px solid #d2d6de');
	    if (numero_ddt=="") {	
	    	$('#myModalError').removeClass();
			$("#myModalErrorContent").html("Attenzione! inserisci il numero del DDT!");
			$('#myModalError').addClass("modal modal-danger");   
			$('#myModalError').modal('show');
	        return false;	    	
	    }
	    
	    if($('#data_ddt').val()!=''&&!isDate($('#data_ddt').val())){
	    	
	    	$('#data_ddt').css('border', '1px solid #f00');
			$('#myModalError').removeClass();
			$("#myModalErrorContent").html("Attenzione! Formato data errato!");
			$('#myModalError').addClass("modal modal-danger");   
			$('#myModalError').modal('show');
			return false;
	    }	    
	    	return true;
	    
	}

 	function formatDate(data, container){
	
		   var mydate = new Date(data);
		   
		   if(!isNaN(mydate.getTime())){
		   if(container == '#data_ora_trasporto'){
			 str = mydate.toString("dd/MM/yyyy");
		   }else{
			   str = mydate.toString("dd/MM/yyyy");
		   }
	   $(container).val(str );
 	}
	
	}
 
 	
 	
	$("#fileupload").change(function(event){
		
		var fileExtension = 'pdf';
        if ($(this).val().split('.').pop()!= fileExtension) {
        	
        	$('#myModalLabel').html("Attenzione!");
        	$('#myModalError').css("z-index", "1070");
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#myModalErrorContent').html("Inserisci solo pdf!");
			$('#myModalError').modal('show');
        	
			$(this).val("");
        }
		
	});
 

  $("#myModalError").on("hidden.bs.modal", function () {
	  
	  if($('#myModalError').hasClass("modal-success")){
	  location.reload();
  	}
	    
	}); 
    

 function creaFileDDT(numero_ddt, id_pacco, id_cliente, id_sede, id_ddt){
 	
 	creaDDTFile(numero_ddt,id_pacco, id_cliente, id_sede, id_ddt);
 	
 }
 
 $('#tipo_ddt').on('change', function(){
	
	 if($('#tipo_ddt').val()==1){
		 $('#dest_mitt').html("Mittente");
		 $('#sede_dest_mitt').html("Sede Mittente");
		 $('#row_destinazione').hide();
		 $('#sede_destinazione').change();
	 }else{
		  $('#dest_mitt').html("Destinatario");
		  $('#sede_dest_mitt').html("Sede Destinatario");
		  $('#row_destinazione').show();
		  $('#sede_destinazione').change();
	 }
	 
 });
 
 
 $(document).ready(function() {
	 
	
	 $('.select2').select2();
//	$('#sede_destinazione').change();
	 
	  var data_ora_trasporto = $('#data_ora_trasporto').val()
	   var data_ddt = $('#data_ddt').val();
	  var data_arrivo = $('#data_arrivo').val();
	  
	  var tipo_ddt=${ddt.tipo_ddt.id};
	  
	  if(tipo_ddt==1){
		  $('#dest_mitt').html("Mittente");
		  $('#sede_dest_mitt').html("Sede Mittente");
		  $('#row_destinazione').hide();
	  }else{
		  $('#dest_mitt').html("Destinatario");
		  $('#sede_dest_mitt').html("Sede Destinatario");
		  $('#row_destinazione').show();
	  }
	 
	 formatDate(data_ora_trasporto, '#data_ora_trasporto');
	   
	   formatDate(data_ddt, '#data_ddt');
	   formatDate(data_arrivo, '#data_arrivo');
	 
	  
 $('.datepicker').datepicker({
		format : "dd/mm/yyyy"
	});
		
 });
 
 
 
 $("#destinatario").change(function() {         
	  if ($(this).data('options') == undefined) 
	  {
	   
	    $(this).data('options', $('#sede_destinatario option').clone());
	  }
	  
	  var id = $(this).val();
	  var options = $(this).data('options');
	//  var id_sede = ${pacco.ddt.id_sede_destinazione };      	  
	  var opt=[];      	
	  opt.push("<option value = 0 >Non associate</option>");
	   for(var  i=0; i<options.length;i++)
	   {
		   
		var str=options[i].value.split("_");       		
		if(str[1]==id)
		{
			opt.push(options[i]);      			
		}   
	   }
	 $("#sede_destinatario").prop("disabled", false);   	 
	  $('#sede_destinatario').html(opt);   	  
	  $("#sede_destinatario").trigger("chosen:updated");   	  
		//$("#sede_destinatario").change();  
	});

$("#destinazione").change(function() {    
  

  
	  if ($(this).data('options') == undefined) 
	  {
	    
	    $(this).data('options', $('#sede_destinazione option').clone());
	  }
	var id2 = $(this).val();
	var id = null;
	if($(this).val()!=""){
		id = $(this).val().split("_");
	}else{
		id=$(this).val();
	}
	
	  var options = $(this).data('options');
	  var id_sede = ${pacco.id_sede };      	  
	  var opt=[];      	

	opt.push("<option value = 0>Non Associate</option>");
	  
	   for(var  i=0; i<options.length;i++)
	   {
		var str=[]
	str=options[i].value.split("_");       		
	if(str[1]==id[0])
		{
			opt.push(options[i]);      			
		}   
	   }
	 $("#sede_destinazione").prop("disabled", false);   	 
	  $('#sede_destinazione').html(opt);   	  
	  $("#sede_destinazione").trigger("chosen:updated");   	  
		$("#sede_destinazione").change();  
	}); 
 
 
	 $('#ModificaDdtForm').on('submit',function(e){
	 	    e.preventDefault();

	 	});   
	 
	 
		function isDate(ExpiryDate) { 
	   	    var objDate,  // date object initialized from the ExpiryDate string 
	   	        mSeconds, // ExpiryDate in milliseconds 
	   	        day,      // day 
	   	        month,    // month 
	   	        year;     // year    	    
	    	    if (ExpiryDate.length !== 10) { 
	   	        return false; 
	   	    }  
	   	    
	   	    if (ExpiryDate.substring(2, 3) !== '/' || ExpiryDate.substring(5, 6) !== '/') { 
	   	        return false; 
	   	    } 
	   	  
	   		day = ExpiryDate.substring(0, 2) - 0; 
	   	    month = ExpiryDate.substring(3, 5) - 1; 
	   	    year = ExpiryDate.substring(6, 10) - 0; 
	   	    
	   	    if (year < 1000 || year > 3000) { 
	   	        return false; 
	   	    } 
	   	    mSeconds = (new Date(year, month, day)).getTime(); 
	   	  
	   	    objDate = new Date(); 
	   	    objDate.setTime(mSeconds); 
	   	    
	   	    if (objDate.getFullYear() !== year || 
	   	        objDate.getMonth() !== month || 
	   	        objDate.getDate() !== day) { 
	   	        return false; 
	   	    } 
	   	  
	   	    return true; 
	   	}
	 
	 
  </script>
  
</jsp:attribute> 
</t:layout>


 
 






