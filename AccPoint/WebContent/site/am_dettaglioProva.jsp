<%@page import="com.google.gson.JsonArray"%>
<%@page import="it.portaleSTI.Util.Costanti"%>
<%@page import="it.portaleSTI.DTO.PuntoMisuraDTO"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.math.RoundingMode"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        Dettaglio Prova
        <small></small>
      </h1>
    <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            
    <div class="row">
<div class="col-md-12">
<!-- <a class="btn btn-danger" onClick=""></a> -->
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dettaglio Prova
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
         <li class="list-group-item">
                  <b>ID Prova</b> <a class="pull-right">${prova.id}</a>
                </li>
                <li class="list-group-item">
                  <b>ID Intervento</b>  <a class=" customTooltip customlink pull-right"  href="amGestioneInterventi.do?action=dettaglio&id_intervento=${utl:encryptData(prova.intervento.id)}" >${prova.intervento.id }</a>
                </li>
                 <li class="list-group-item">
                  <b>Data Prova</b> <a class="pull-right"><fmt:formatDate pattern = "dd/MM/yyyy" value = "${prova.data }" /></a>
                </li>
                 <li class="list-group-item">
                  <b>Commessa</b> <a class="pull-right">${prova.intervento.idCommessa }</a>
                </li>
                <li class="list-group-item">
                  <b>Cliente</b> <a class="pull-right">${prova.intervento.nomeCliente}</a>
                </li>
                <li class="list-group-item">
                  <b>Sede</b> <a class="pull-right">${prova.intervento.nomeSede}</a>
                </li>
                 <li class="list-group-item">
                  <b>Cliente Utilizzatore</b> <a class="pull-right">${prova.intervento.nomeClienteUtilizzatore}</a>
                </li>
                <li class="list-group-item">
                  <b>Sede Utilizzatore</b> <a class="pull-right">${prova.intervento.nomeSedeUtilizzatore}</a>
                </li>
				

        </ul>

</div>
</div>
</div>

<div class="col-md-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Oggetto in Prova
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
          <li class="list-group-item">
                  <b>ID Oggetto in Prova</b> <a class="pull-right">${prova.strumento.id}</a>
                </li>
                <li class="list-group-item">
                  <b>Matricola</b> <a class="pull-right">${prova.strumento.matricola}</a>
                </li>
                <li class="list-group-item">
                  <b>N. Fabbrica</b> <a class="pull-right">${prova.strumento.nFabbrica}</a>
                </li>
                <li class="list-group-item">
                  <b>Tipo</b> <a class="pull-right">${prova.strumento.tipo}</a>
                </li>
                <li class="list-group-item">
                  <b>Descrizione</b> <a class="pull-right">${prova.strumento.descrizione}</a>
                </li>
                <li class="list-group-item">
                  <b>Pressione</b> <a class="pull-right">${prova.strumento.pressione}</a>
                </li>
                <li class="list-group-item">
                  <b>Volume</b> <a class="pull-right">${prova.strumento.volume}</a>
                </li>
                <li class="list-group-item">
                  <b>Anno</b> <a class="pull-right">${prova.strumento.anno}</a>
                </li>
                <li class="list-group-item">
                  <b>Costruttore</b> <a class="pull-right">${prova.strumento.costruttore}</a>
                </li>
                
                <li class="list-group-item">
                  <b>Zona di riferimento Fondo</b> <a class="pull-right">${prova.strumento.zonaRifFondo}</a>
                </li>
                <li class="list-group-item">
                  <b>Zona di riferimento Fasciame</b> <a class="pull-right">${prova.strumento.zonaRifFasciame}</a>
                </li>
                
                 <li class="list-group-item">
                  <b>Materiale Fondo</b> <a class="pull-right">${prova.strumento.materialeFondo}</a>
                </li>
                <li class="list-group-item">
                  <b>Materiale Fasciame</b> <a class="pull-right">${prova.strumento.materialeFasciame}</a>
                </li>
                <li class="list-group-item">
                  <b>Spessore nominale Fondo</b> <a class="pull-right">${prova.strumento.spessoreFondo}</a>
                </li>
                <li class="list-group-item">
                  <b>Spessore nominale  Fasciame</b> <a class="pull-right">${prova.strumento.spessoreFasciame}</a>
                </li>
                
               
        </ul>
        



</div>
</div>
</div>


<div class="col-md-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Strumentazione di misura utilizzata
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
         
                <li class="list-group-item">
                  <b>Matricola</b> <a class="pull-right">${prova.campione.matricola}</a>
                </li>
                <li class="list-group-item">
                  <b>Rilevatore out tipo</b> <a class="pull-right">${prova.campione.rilevatoreOut}</a>
                </li>
                <li class="list-group-item">
                  <b>Mezzo accoppiante</b> <a class="pull-right">${prova.campione.mezzoAccoppiante}</a>
                </li>
                  <li class="list-group-item">
                  <b>Blocco riferimento</b> <a class="pull-right">${prova.campione.bloccoRiferimento}</a>
                </li>
                <li class="list-group-item">
                  <b>Costruttore sonda</b> <a class="pull-right">${prova.campione.sondaCostruttore}</a>
                </li>
                <li class="list-group-item">
                  <b>Modello sonda</b> <a class="pull-right">${prova.campione.sondaModello}</a>
                </li>
                <li class="list-group-item">
                  <b>Matricola sonda</b> <a class="pull-right">${prova.campione.sondaMatricola}</a>
                </li>
                <li class="list-group-item">
                  <b>Frequenza sonda</b> <a class="pull-right">${prova.campione.sondaFrequenza}</a>
                </li>
                <li class="list-group-item">
                  <b>Dimensione sonda</b> <a class="pull-right">${prova.campione.sondaDimensione}</a>
                </li>
                <li class="list-group-item">
                  <b>Angolo sonda</b> <a class="pull-right">${prova.campione.sondaAngolo}</a>
                </li>
                <li class="list-group-item">
                  <b>Velocità sonda</b> <a class="pull-right">${prova.strumento.sondaVelocita}</a>
                </li>
                
               
        </ul>
        



</div>
</div>
</div>


<div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati Prova
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
<div class="row">
 <div class="col-xs-6">
		<img src="amGestioneInterventi.do?action=immagine" alt="Immagine della prova" class="img-responsive" style="width: 100%; height: auto;"  />
 </div>
 
  <div class="col-xs-6">
  
<table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
    <thead >
        <tr>
            <th colspan="${fn:length(colonne) + 1}" style="text-align:center">RISULTATI MISURE SPESSIMETRICHE [mm]</th>
        </tr>
        <tr>
            <th style="text-align:center"></th>
            <c:forEach var="col" items="${colonne}">
                <th style="text-align:center">${col}</th>
            </c:forEach>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="riga" items="${matrix_spess}" varStatus="rowStatus">
            <tr>
                <th style="text-align:center">${rowStatus.index + 1}</th>
                <c:forEach var="valore" items="${riga}">
                    <td style="text-align:center"><fmt:formatNumber value="${valore}" pattern="#0.00" /></td>
                </c:forEach>
            </tr>
        </c:forEach>
    </tbody>
</table>
<br>
 <div class="row">

 <div class="col-xs-5">
  <label>Spessore Minimo FASCIAME</label>
 </div>
  <div class="col-xs-5">

 <input class="form-control" readonly type="text" value="${prova.spess_min_fasciame } mm">
 </div>

 
 </div><br>
 <div class="row">

  <div class="col-xs-5">
   <label>Spessore Minimo FONDO SUPERIORE</label>
 </div>
  <div class="col-xs-5">

 <input class="form-control" readonly type="text" value="${prova.spess_min_fondo_sup } mm">
 </div>

 
 </div><br>
 <div class="row">

  <div class="col-xs-5">
   <label>Spessore Minimo FONDO INFERIORE</label>
 </div>
  <div class="col-xs-5">

 <input class="form-control" readonly type="text" value="${prova.spess_min_fondo_inf } mm">
 </div>

 
 </div>

 </div>
 
</div><br>
<div class="row">

<div class="col-xs-12">
<label>Note Prova</label>
<textarea rows="3" style="width:100%" class="form-control">${prova.note }</textarea>

</div>
</div>
 </div>

</div>


  </div>
       
 </div>
    
        
        

<div class="row">
<div class="col-xs-12">

<div class="box box-danger box-solid">
<div class="box-header with-border">
	Esito Verifica
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
 <div class="row">
 <div class="col-xs-4">
 </div>
 <div class="col-xs-4 text-center">
 
 <c:choose>
 <c:when test="${prova.esito=='POSITIVO' }">
  <b>ESITO DELLA VERIFICA: CONFORME A SPECIFICA</b>
  </c:when>
  <c:when test="${prova.esito=='NEGATIVO' }">
  <b>ESITO GLOBALE: NON CONFORME A SPECIFICA</b>
  </c:when>
 </c:choose>

 </div>
 <div class="col-xs-4">
 </div>
 
 
 </div>


 </div>

</div>

</div>
</div>


</div>
</div>
 </div> 
 </div>
</section>
</div>


  <div id="myModalFile" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Lista upload</h4>
      </div>
       <div class="modal-body">
			<div id="file_content">
			
			</div>
   
  		 </div>
      <div class="modal-footer" id="myModalFooter">
 
       
      </div>
    </div>
  </div>
</div>

  
  <div id="myModalDettaglioStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Strumento</h4>
      </div>
       <div class="modal-body">

        <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
            
              <li class="active"><a href="#dettaglio" data-toggle="tab" aria-expanded="true" onclick="" id="dettaglioTab">Dettaglio Strumento</a></li>
              <li class=""><a href="#misure" data-toggle="tab" aria-expanded="false" onclick="" id="misureTab">Misure</a></li>
       <!--        <li class=""><a href="#prenotazione" data-toggle="tab" aria-expanded="false" onclick="" id="prenotazioneTab">Stato Prenotazione</a></li> -->
        
 		<c:if test="${userObj.checkPermesso('MODIFICA_STRUMENTO_METROLOGIA')}">
               <li class=""><a href="#modifica" data-toggle="tab" aria-expanded="false" onclick="" id="modificaTab">Modifica Strumento</a></li>
		</c:if>		
		 <li class=""><a href="#documentiesterni" data-toggle="tab" aria-expanded="false" onclick="" id="documentiesterniTab">Documenti esterni</a></li>
           
            </ul>
            <div class="tab-content">
               <div class="tab-pane active" id="dettaglio">

    			</div> 

              <!-- /.tab-pane -->
             
			  <div class="tab-pane" id="misure">
                

         
			 </div> 


              <!-- /.tab-pane -->


               		<c:if test="${userObj.checkPermesso('MODIFICA_STRUMENTO_METROLOGIA')}">
              
              			<div class="tab-pane" id="modifica">
              

              			</div> 
              		</c:if>		
              		
              		<div class="tab-pane" id="documentiesterni">
              

              			</div> 
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
  
  <!-- /.content-wrapper -->

  <t:dash-footer />
  

  <t:control-sidebar />
   


<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">
<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
<link type="text/css" href="css/bootstrap.min.css" />
</jsp:attribute>

<jsp:attribute name="extra_js_footer">

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
 	<script type="text/javascript" src="plugins/datejs/date.js"></script>
  
 <script type="text/javascript">
 
 
 
	function formatDate(data){
		
		   var mydate = new Date(data);
		   
		   if(!isNaN(mydate.getTime())){
		   
			   str = mydate.toString("dd/MM/yyyy HH:mm:ss");
		   }			   
		   return str;	 		
	}
 
 



  </script>
  
</jsp:attribute> 
</t:layout>

