<%@page import="com.google.gson.JsonArray"%>
<%@page import="it.portaleSTI.Util.Costanti"%>
<%@page import="it.portaleSTI.DTO.PuntoMisuraDTO"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.math.BigDecimal"%>
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
        Dettaglio Misura
        <small></small>
      </h1>
    <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
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
	 Dati Relativi al titolare dello strumento
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>Denominazione</b> <a class="pull-right">${cliente.nome}</a>
                </li>
                 <li class="list-group-item">
                  <b>Indirizzo</b> <a class="pull-right">${cliente.indirizzo} - ${cliente.cap } - ${cliente.citta } (${cliente.provincia })</a>
                </li>
                <li class="list-group-item">
                  <b>Partita IVA - Cod. Fiscale</b> <a class="pull-right">${cliente.partita_iva}</a>
                </li>
                <li class="list-group-item">
                  <b>Indirizzo di servizio</b> <a class="pull-right">${sede.indirizzo}</a>
                </li>
				<li class="list-group-item">
                  <b>Telefono</b> <a class="pull-right">${cliente.telefono}</a>
                </li>
                <li class="list-group-item">
                <b>Numero REA</b>
                 <c:if test="${sede!=null && sede.n_REA!=null && sede.n_REA!=''}">
                   <a class="pull-right">${sede.n_REA}</a>
                  </c:if> 
                  <c:if test="${cliente!=null && cliente.numeroREA!=null }">
                   <a class="pull-right">${cliente.numeroREA}</a>
                  </c:if>
                </li>

        </ul>

</div>
</div>
</div>

<div class="col-md-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati realtivi allo strumento sottoposto a verificazione periodica
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>Denominazione</b> <a class="pull-right">${misura.verStrumento.denominazione}</a>
                </li>
                <li class="list-group-item">
                  <b>Tipo</b> <a class="pull-right">${misura.verStrumento.tipologia.descrizione}</a>
                </li>
                 <li class="list-group-item">
                  <b>Costruttore</b> <a class="pull-right">${misura.verStrumento.costruttore}</a>
                </li>
                <li class="list-group-item">
                  <b>Modello</b> <a class="pull-right">${misura.verStrumento.modello}</a>
                </li>
                <li class="list-group-item">
                  <b>Matricola o S/N</b> <a class="pull-right">${misura.verStrumento.matricola}</a>
                </li>
				<li class="list-group-item">
                  <b>Classe di precisione</b> <a class="pull-right">${misura.verStrumento.classe}</a>
                </li>
                <li class="list-group-item">
                  <b>Anno di marcatura CE</b> <a class="pull-right">${misura.verStrumento.anno_marcatura_ce}</a>
                </li>
                <li class="list-group-item">
                  <b>Data messa in servizio</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${misura.verStrumento.data_messa_in_servizio}" /></a>
                </li>
                <li class="list-group-item">
                  <b>Tipo di strumento</b> <a class="pull-right">${misura.verStrumento.tipo.descrizione}</a>
                </li>
                <li class="list-group-item">
                  <b>Unità di misura</b> <a class="pull-right">${misura.verStrumento.um}</a>
                </li>
                <li class="list-group-item">
                  <b>Campioni di lavoro</b> <a class="pull-right">${misura.campioniLavoro}</a>
                </li>
                 <li class="list-group-item">
                  <b>Numero di sigilli usati</b> <a class="pull-right">${misura.numeroSigilli}</a>
                </li>
                <c:if test="${misura.verStrumento.tipo.id == 1 || misura.verStrumento.tipo.id ==2 }">
                	<li class="list-group-item">                
		                <c:choose>
		                <c:when test="${misura.verStrumento.tipo.id == 1}">
		                 <b>Portata massima (Max)</b> <a class="pull-right">${misura.verStrumento.portata_max_C1}</a>
		                </c:when>
		                <c:when test="${misura.verStrumento.tipo.id == 2}">
		                <c:choose>
		               <c:when test="${misura.verStrumento.portata_max_C3 !=null && misura.verStrumento.portata_max_C3>0}">
		               		 <b>Portata massima (Max)</b> <a class="pull-right">${misura.verStrumento.portata_max_C3}</a>
		                </c:when>
		                <c:otherwise>
		                <b>Portata massima (Max)</b> <a class="pull-right">${misura.verStrumento.portata_max_C2}</a>
		                </c:otherwise>
		                 </c:choose>
		                </c:when>		               
		                </c:choose>                 
	                </li>
             
                <li class="list-group-item">
               	 <b>Portata minima (Min)</b> <a class="pull-right">${misura.verStrumento.portata_min_C1}</a>
               </li>
               <c:if test="${misura.verStrumento.tipo.id == 1 }">
               <li class="list-group-item">
               	 <b>Divisione di verifica (e)</b> <a class="pull-right">${misura.verStrumento.div_ver_C1}</a>
               </li>
               <li class="list-group-item">
               	 <b>Divisione reale (d)</b> <a class="pull-right">${misura.verStrumento.div_rel_C1}</a>
               </li>
               <li class="list-group-item">
               	 <b>Numero div. di verif. (n)</b> <a class="pull-right">${misura.verStrumento.numero_div_C1}</a>
               </li>
               </c:if>
   		</c:if>
        </ul>
        
<c:if test="${misura.verStrumento.tipo.id==2 }">
 <b>Dati relativi a ciascuno dei campi di pesatura parziali dello strumento</b>
 <div class="row">
 <div class="col-xs-4">
  <table class="table table-bordered table-hover dataTable table-striped" role="grid" style="width:70%">
 <tbody> 
 	<tr role="row">
		<td>e1</td>
		<td>${misura.verStrumento.div_ver_C1}</td>
	</tr>
	<tr role="row">
		<td>e2</td>
		<td>${misura.verStrumento.div_ver_C2}</td>
	
	</tr>
	<c:if test="${misura.verStrumento.div_ver_C3!=0 }">
	<tr role="row">
		<td>e3</td>
	<td>${misura.verStrumento.div_ver_C3}</td>
	
	</tr>
	</c:if> 
 </tbody>
 </table> 
 
 </div>
 
  <div class="col-xs-4">
  <table  class="table table-bordered table-hover dataTable table-striped" role="grid" style="width:70%">
 <tbody> 
 	<tr role="row">
		<td>d1</td>
		<td>${misura.verStrumento.div_rel_C1}</td>
	</tr>
	<tr role="row">
		<td>d2</td>
		<td>${misura.verStrumento.div_rel_C2}</td>
	
	</tr>
	<c:if test="${misura.verStrumento.div_rel_C3!=0 }">
	<tr role="row">
		<td>d3</td>
	<td>${misura.verStrumento.div_rel_C3}</td>
	
	</tr>
	</c:if> 
 </tbody>
 </table> 
 
 </div>
 
 
  <div class="col-xs-4">
  <table class="table table-bordered table-hover dataTable table-striped" role="grid" style="width:70%">
 <tbody> 
 	<tr role="row">
		<td>n1</td>
		<td>${misura.verStrumento.numero_div_C1}</td>
	</tr>
	<tr role="row">
		<td>n2</td>
		<td>${misura.verStrumento.numero_div_C2}</td>
	
	</tr>
	<c:if test="${misura.verStrumento.numero_div_C3!=0 }">
	<tr role="row">
		<td>n3</td>
	<td>${misura.verStrumento.numero_div_C3}</td>
	
	</tr>
	</c:if> 
 </tbody>
 </table> 
 
 </div>
 
 </div>



<div class="row">
<div class="col-xs-2"></div>
 <div class="col-xs-4">
  <table class="table table-bordered table-hover dataTable table-striped" role="grid" style="width:70%">
 <tbody> 
 	<tr role="row">
		<td>Min1 = Min</td>
		<td>${misura.verStrumento.portata_min_C1}</td>
	</tr>
	<tr role="row">
		<td>Min2</td>
		<td>${misura.verStrumento.portata_min_C2}</td>
	
	</tr>
	<c:if test="${misura.verStrumento.portata_min_C3!=0 }">
	<tr role="row">
		<td>Min3</td>
	<td>${misura.verStrumento.portata_min_C3}</td>
	
	</tr>
	</c:if> 
 </tbody>
 </table> 
 
 </div>
 
  <div class="col-xs-4">
  <table class="table table-bordered table-hover dataTable table-striped" role="grid" style="width:70%">
 <tbody> 
 	<tr role="row">
		<td>Max1</td>
		<td>${misura.verStrumento.portata_max_C1}</td>
	</tr>
	<tr role="row">
		<td>Max2</td>
		<td>${misura.verStrumento.portata_max_C2}</td>
	
	</tr>
	<c:if test="${misura.verStrumento.portata_max_C3!=0 }">
	<tr role="row">
		<td>Max3</td>
	<td>${misura.verStrumento.portata_max_C3}</td>
	
	</tr>
	</c:if> 
 </tbody>
 </table> 
 
 </div>
 
 </div>

</c:if>

<c:if test="${misura.verStrumento.tipo.id==3 }">
 <table id="tabCampiPesatura" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">  
	<td></td>
	<th>Campo 1</th>
	<th>Campo 2</th>	
	<th>Campo 3</th>
	
 </tr></thead>
 	
 <tbody> 
 
	<tr role="row">
		<td>Portata massima (Max)</td>
		<td>${misura.verStrumento.portata_max_C1}</td>
		<td>${misura.verStrumento.portata_max_C2}</td>
		<td>${misura.verStrumento.portata_max_C3}</td>
		
	</tr>
	
	<tr role="row">
		<td>Portata minima (Min)</td>
		<td>${misura.verStrumento.portata_min_C1}</td>
		<td>${misura.verStrumento.portata_min_C2}</td>
		<td>${misura.verStrumento.portata_min_C3}</td>
		
	</tr>
	
 	<tr role="row">
		<td>Divisione di verifica (e)</td>
		<td>${misura.verStrumento.div_ver_C1}</td>
		<td>${misura.verStrumento.div_ver_C2}</td>
		<td>${misura.verStrumento.div_ver_C3}</td>
		
	</tr>
	<tr role="row">
		<td>Divisione reale (d)</td>
		<td>${misura.verStrumento.div_rel_C1}</td>
		<td>${misura.verStrumento.div_rel_C2}</td>
		<td>${misura.verStrumento.div_rel_C3}</td>
		
	</tr>
	<tr role="row">
		<td>Numero div. di verif. (n)</td>
		<td>${misura.verStrumento.numero_div_C1}</td>
		<td>${misura.verStrumento.numero_div_C2}</td>
		<td>${misura.verStrumento.numero_div_C3}</td>
		
	</tr>
 </tbody>
 </table> 

</c:if>
  

</div>
</div>
</div>


<div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati relativi alla compilazione dell'Attestato di verificazione periodica
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
<div class="row">
 <div class="col-xs-6">
<ul class="list-group list-group-unbordered">
 <li class="list-group-item">
 	 <b>Registro</b> <a class="pull-right">${misura.id }_${misura.verStrumento.id }</a>
 </li>
 <li class="list-group-item">
 	<b>Data verificazione</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${misura.dataVerificazione}"/></a>
 </li>
  <li class="list-group-item">
 	<b>Procedura di verificazione</b> <a class="pull-right"></a>
 </li>
 </ul>
 </div>
 
  <div class="col-xs-6">
<ul class="list-group list-group-unbordered">
<!--  <li class="list-group-item">
 	 <b>Nel caso di riparazione (con presenza di sigilli provvisori sullo strumento) annotare nome del riparatore e data riparazione</b> 
 </li> -->
 <li class="list-group-item">
 	<b>Nome riparatore</b> <a class="pull-right">${misura.nomeRiparatore}</a>
 </li>
  <li class="list-group-item">
 	<b>Data riparazione</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${misura.dataRiparazione}"/></a>
 </li>
   <li class="list-group-item">
 	<b>Download Certificato</b>
 	<c:if test="${certificato.misura.obsoleta=='N' }">
 	<c:if test="${certificato.stato.id==2 && userObj.checkPermesso('LISTA_CERTIFICATI_TUTTI_METROLOGIA') || certificato.firmato ==1}">
 	<a target="_blank"   class="btn btn-danger customTooltip pull-right btn-xs" title="Click per scaricare il PDF del Certificato"  href="gestioneVerCertificati.do?action=download&&cert_rap=1&id_certificato=${utl:encryptData(certificato.id)}" ><i class="fa fa-file-pdf-o"></i></a>
 	</c:if> 
 	</c:if>
 </li>
   <li class="list-group-item">
 	<b>Download Rapporto</b>
 	<c:if test="${certificato.misura.obsoleta=='N' }">
 	<c:if test="${certificato.stato.id==2 }">
 	<a target="_blank"   class="btn btn-danger customTooltip pull-right btn-xs" title="Click per scaricare il PDF del Rapporto"  href="gestioneVerCertificati.do?action=download&&cert_rap=2&id_certificato=${utl:encryptData(certificato.id)}" ><i class="fa fa-file-pdf-o"></i></a>
 	</c:if>
 	</c:if>
 </li>
 </ul>
 </div>
 
</div>
 </div>

</div>


  </div>
       
 </div>
    
        
        
<c:if test="${motivo!=3 }">      
<div class="row">
<div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	Dati Rapporto
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
<div class="row">
 <div class="col-xs-12">
 <div class="nav-tabs-custom">
            <ul id="mainTabs" class="nav nav-tabs">
              <li class="active" id="tab1"><a href="#check_list" data-toggle="tab" aria-expanded="true"   id="checkListTab">Check List del controllo preliminare</a></li>
              
              <c:if test="${esitoCheck=='1'}">
              		<li class="" id="tab2"><a href="#ripetibilita" data-toggle="tab" aria-expanded="false"   id="ripetibilitaTab">Ripetibilità</a></li>
              		<li class="" id="tab3"><a href="#decentramento" data-toggle="tab" aria-expanded="false"   id="decentramentoTab">Decentramento</a></li>
              		<li class="" id="tab4"><a href="#linearita" data-toggle="tab" aria-expanded="false"   id="linearitaTab">Linearità</a></li>
              		 <c:if test="${misura.verStrumento.tipologia.id==2 }"> 
              		<li class="" id="tab5"><a href="#accuratezza" data-toggle="tab" aria-expanded="false"   id="accuratezzaTab">Accuratezza</a></li>              		
              		<li class="" id="tab6"><a href="#mobilita" data-toggle="tab" aria-expanded="false"   id="mobilitaTab">Mobilità</a></li>
              		 </c:if> 
              </c:if>		 
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="check_list">

    <div class="row">
     <div class="col-xs-12">
          
         
	<table id="tabSC" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th>Tipologia di controllo</th>
 <th>SI</th>
 <th>NO</th>
 <th>N/A</th>
 </tr></thead>
 
 <tbody>

	 <tr role="row">
	<td>Lo strumento sottoposto a verificazione presenta la targhetta con il simbolo della "marcatura CE"?</td>
  	<td align="center">
  		<c:if test="${checkList.get(0) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(0) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(0) == 2}">
  		<b> X</b>
  		</c:if>
  	</td>
	</tr>
	
	
		 <tr role="row">
	<td>Lo strumento sottoposto a verificazione è munito di "Dichiarazione di Conformità CE" con relativo numero di identificazione?</td>
  	<td align="center">
  		<c:if test="${checkList.get(1) == 0}">
  		<b> X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(1) == 1}">
  		<b> X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(1) == 2}">
  		<b> X</b>
  		</c:if>
  	</td>
	</tr>
	
		 <tr role="row">
	<td>Lo strumento sottoposto a verificazione è munito di marcatura metrologica "supplementare M"?</td>
  	<td align="center">
  		<c:if test="${checkList.get(2) == 0}">
  		<b> X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(2) == 1}">
  		<b> X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(2) == 2}">
  		<b> X</b>
  		</c:if>
  	</td>
	</tr>
	
		 <tr role="row">
	<td>Nella targhetta identificativa è presente il nome del fabbricante, la sua denominazione commerciale registrata o il suo marchio registrato?</td>
  	<td align="center">
  		<c:if test="${checkList.get(3) == 0}">
  		<b> X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(3) == 1}">
  		<b> X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(3) == 2}">
  		<b> X</b>
  		</c:if>
  	</td>
	</tr>
	
			 <tr role="row">
	<td>Nella targhetta identificativa è presente la classe di precisione, racchiusa in un ovale o in due lineette orizzontali unite da due semicerchi?</td>
  	<td align="center">
  		<c:if test="${checkList.get(4) == 0}">
  		<b> X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(4) == 1}">
  		<b> X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(4) == 2}">
  		<b> X</b>
  		</c:if>
  	</td>
	</tr>
	
		 <tr role="row">
	<td>Nella targhetta identificativa è presente la portata massima (Max) dello strumento?</td>
  	<td align="center">
  		<c:if test="${checkList.get(5) == 0}">
  		<b> X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(5) == 1}">
  		<b> X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(5) == 2}">
  		<b> X</b>
  		</c:if>
  	</td>
	</tr>
	
		 <tr role="row">
	<td>Nella targhetta identificativa è presente la portata minima (Min) dello strumento?</td>
  	<td align="center">
  		<c:if test="${checkList.get(6) == 0}">
  		<b> X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(6) == 1}">
  		<b> X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(6) == 2}">
  		<b> X</b>
  		</c:if>
  	</td>
	</tr>
	
		 <tr role="row">
	<td>Nella targhetta identificativa è presente la divisione di verifica (e) dello strumento?</td>
  	<td align="center">
  		<c:if test="${checkList.get(7) == 0}">
  		<b> X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(7) == 1}">
  		<b> X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(7) == 2}">
  		<b> X</b>
  		</c:if>
  	</td>
	</tr>
	
		 <tr role="row">
	<td>Nella targhetta identificativa è presente il numero di tipo, di lotto o di serie dello strumento?</td>
  <td align="center">
  		<c:if test="${checkList.get(8) == 0}">
  		<b> X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(8) == 1}">
  		<b> X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(8) == 2}">
  		<b> X</b>
  		</c:if>
  	</td>
	</tr>
	<tr role="row">
	 <td colspan="4"><b>e, se del caso:</b></td> 

	</tr>
	
		 <tr role="row">
	<td>Per gli strumenti costituiti di unità distinte ma associate, è presente il marchio di identificazione su ciascuna unità?</td>
  	<td align="center">
  		<c:if test="${checkList.get(9) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(9) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(9) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
		 <tr role="row">
	<td>La divisione, se è diversa da e, è presente nella forma d=...?</td>
  	<td align="center">
  		<c:if test="${checkList.get(10) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(10) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(10) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
			 <tr role="row">
	<td>È presente l'effetto massimo additivo di tara, nella forma T = + ...?</td>
  	<td align="center">
  		<c:if test="${checkList.get(11) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(11) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(11) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
			 <tr role="row">
	<td>È presente l'effetto massimo sottrattivo di tara, se è diverso da Max, nella forma T = - ...?</td>
  	<td align="center">
  		<c:if test="${checkList.get(12) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(12) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(12) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
			 <tr role="row">
	<td>È presente il carico limite, se è diverso da Max, nella forma Lim ...?</td>
  	<td align="center">
  		<c:if test="${checkList.get(13) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(13) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(13) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
			 <tr role="row">
	<td>Sono presenti i valori limite di temperatura, nella forma ...°C/...°C?</td>
  	<td align="center">
  		<c:if test="${checkList.get(14) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(14) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(14) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
			 <tr role="row">
	<td>È presente il rapporto tra ricettore di peso e di carico?</td>
  	<td align="center">
  		<c:if test="${checkList.get(15) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(15) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(15) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>

 
	
 </tbody>
 </table> 
  </div> 
    </div> 
    <br>
  
  <div class="row">
<div class="col-xs-4">

 </div>
 <div class="col-xs-4">
 <c:if test="${esitoCheck=='1' }">
 <b style="color:red">CONTROLLO PRELIMINARE SUPERATO</b>
 </c:if>
 <c:if test="${esitoCheck== '0' }">
 <b>CONTROLLO PRELIMINARE NON SUPERATO</b>
 </c:if>

 </div>
 <div class="col-xs-4">

 </div>
 </div>

    			 </div>  

              <!-- /.tab-pane -->
              <div class="tab-pane table-responsive" id="ripetibilita">
<c:if test="${misura.verStrumento.tipo.id==3 }">
    <div class="row">
  <div class="col-xs-12">
  <b>Campo 1</b>
  </div>
  </div>
  </c:if>
  
  <div class="row">
  <div class="col-xs-8">
  

 <table id="tabCampo1" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th class="text-center">N° Ripetizione</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">P<br>${misura.verStrumento.um }</th>


 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_ripetibilita}" var="item" varStatus="loop">
<c:if test="${item.campo==1 && item.massa!=null }">
<tr role="row" >
	
<td align="center">${item.numeroRipetizione}</td>
<td align="center">${item.massa }</td>
<td align="center">${item.indicazione}</td>
<td align="center">${item.caricoAgg}</td>
<td align="center">${item.portata}</td>

	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 </table>  
                
</div>  

<div class="col-xs-4">

 <table class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 
 <tbody>

<tr role="row" >
	
<td>Pmax - Pmin</td>
<td>${lista_ripetibilita.get(0).deltaPortata }</td>
<td>${misura.verStrumento.um}</td>
	</tr>
	
	<tr role="row" >
	
<td>MPE (associato al carico di prova)</td>
<td>${lista_ripetibilita.get(0).mpe }</td>
<td>${misura.verStrumento.um}</td>
	</tr>

 
	
 </tbody>
 </table> 
<br>
<b>ESITO: ${lista_ripetibilita.get(0).esito }</b>
</div>
  </div>
  
  
 <c:if test="${misura.verStrumento.tipo.id==3 }"> 

    <div class="row">
  <div class="col-xs-12">
  <b>Campo 2</b>
  </div>
  </div>

  
    <div class="row">
  <div class="col-xs-8">
  
  
 <table id="tabCampo2" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th class="text-center">N° Ripetizione</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">P<br>${misura.verStrumento.um }</th>


 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_ripetibilita}" var="item" varStatus="loop">
<c:if test="${item.campo==2 && item.massa!=null}">
<tr role="row" >
	
<td align="center">${item.numeroRipetizione}</td>
<td align="center">${item.massa }</td>
<td align="center">${item.indicazione}</td>
<td align="center">${item.caricoAgg}</td>
<td align="center">${item.portata}</td>

	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 </table>  
                
</div>  

<div class="col-xs-4">

 <table class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 
 <tbody>

<tr role="row" >
	
<td>Pmax - Pmin</td>
<td>${lista_ripetibilita.get(6).deltaPortata }</td>
<td>${misura.verStrumento.um}</td>
	</tr>
	
	<tr role="row" >
	
<td>MPE (associato al carico di prova)</td>
<td>${lista_ripetibilita.get(6).mpe }</td>
<td>${misura.verStrumento.um}</td>
	</tr>

 
	
 </tbody>
 </table> 
<br>
<b>ESITO: ${lista_ripetibilita.get(6).esito }</b>
</div>
  </div>
  
  
  
    <div class="row">
  <div class="col-xs-12">
  <b>Campo 3</b>
  </div>
  </div>
      <div class="row">
  <div class="col-xs-8">
  
  
 <table id="tabCampo3" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th class="text-center">N° Ripetizione</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">P<br>${misura.verStrumento.um }</th>


 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_ripetibilita}" var="item" varStatus="loop">
<c:if test="${item.campo==3 && item.massa!=null}">
<tr role="row" >
	
<td align="center">${item.numeroRipetizione}</td>
<td align="center">${item.massa }</td>
<td align="center">${item.indicazione}</td>
<td align="center">${item.caricoAgg}</td>
<td align="center">${item.portata}</td>

	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 </table>  
                
</div>  

<div class="col-xs-4">

 <table class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 
 <tbody>

<tr role="row" >
	
<td>Pmax - Pmin</td>
<td>${lista_ripetibilita.get(12).deltaPortata }</td>
<td>${misura.verStrumento.um}</td>
	</tr>
	
	<tr role="row" >
	
<td>MPE (associato al carico di prova)</td>
<td>${lista_ripetibilita.get(12).mpe }</td>
<td>${misura.verStrumento.um}</td>
	</tr>

 
	
 </tbody>
 </table> 
<br>
<b>ESITO: ${lista_ripetibilita.get(12).esito }</b>
</div>
  </div>

  </c:if>
  
  
  
         
			 </div>
			 
<div class="tab-pane table-responsive" id="decentramento">
<c:if test="${misura.verStrumento.tipo.id==3 }">
<div class="row">
<div class="col-xs-12">
<b>Campo 1</b>
</div>
</div>
</c:if>
<div class="row">
<div class="col-xs-4"></div>

<div class="col-xs-4 text-center">
<b>Esempio di ricettore di carico</b><br>
<c:choose>
<c:when test="${lista_decentramento.get(0).tipoRicettore == 0}">
<img class="img" src="./images/tipo_ricettori_carico/tipo_0.png" style="height:70px">
</c:when>
<c:when test="${lista_decentramento.get(0).tipoRicettore == 1}">
<img class="img" src="./images/tipo_ricettori_carico/tipo_1.png" style="height:70px">
</c:when>
<c:otherwise>
<img class="img" src="./images/tipo_ricettori_carico/tipo_2.png" style="height:70px">
</c:otherwise>
</c:choose>
</div>
<div class="col-xs-4"></div>
</div>
<div class="row">
<div class="col-xs-6">


<b>Numero di punti di appoggi del ricettore di carico:
<c:choose>
<c:when test="${lista_decentramento.get(0).puntiAppoggio!=0}"> 
${lista_decentramento.get(0).puntiAppoggio}
</c:when>
<c:when test="${lista_decentramento.get(1).puntiAppoggio!=0}"> 
${lista_decentramento.get(1).puntiAppoggio}
</c:when>
</c:choose>
</b>




</div>

<div class="col-xs-6">

<b>Carico: ${lista_decentramento.get(0).carico} ${misura.verStrumento.um}</b>


</div>
</div>
<br>
<div class="row">
<div class="col-xs-4">
<c:if test="${lista_decentramento.get(0).speciale == 'N'}">
<b>Strumento "Speciale": NO</b>
</c:if>
<c:if test="${lista_decentramento.get(0).speciale == 'S'}">
<b>Strumento "Speciale": SI</b>
</c:if> 
</div>
</div>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th class="text-center">Posizione n°</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th class="text-center">ErCorretto<br>Ec<br>${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_decentramento}" var="item" varStatus="loop">
<c:if test="${item.campo== 1 && item.massa!=null }">
<tr role="row" >

<c:choose>	
<c:when test="${(item.posizione%2) !=  0}">
<td align="center">E0</td>
</c:when>
<c:otherwise>
<td align="center"><fmt:formatNumber value="${item.posizione/2}" maxFractionDigits="0" /></td>
</c:otherwise>
</c:choose>

<td align="center">${item.massa }</td>
<td align="center">${item.indicazione}</td>
<td align="center">${item.caricoAgg}</td>
<td align="center">${item.errore}</td>
<td align="center">${item.erroreCor}</td>
<td align="center">${item.mpe}</td>


	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 </table>  
 <br>
<div class="row">
<div class="col-xs-12">
<b class="pull-right">ESITO: ${lista_decentramento.get(0).esito }</b>
</div>
</div>
<br>




<c:if test="${misura.verStrumento.tipo.id==3 }">
<div class="row">
<div class="col-xs-12">
<b>Campo 2</b>
</div>
</div>

<div class="row">
<div class="col-xs-4"></div>

<div class="col-xs-4 text-center">
<b>Esempio di ricettore di carico</b><br>
<c:choose>
<c:when test="${lista_decentramento.get(10).tipoRicettore == 0}">
<img class="img" src="./images/tipo_ricettori_carico/tipo_0.png" style="height:70px">
</c:when>
<c:when test="${lista_decentramento.get(10).tipoRicettore == 1}">
<img class="img" src="./images/tipo_ricettori_carico/tipo_1.png" style="height:70px">
</c:when>
<c:otherwise>
<img class="img" src="./images/tipo_ricettori_carico/tipo_2.png" style="height:70px">
</c:otherwise>
</c:choose>
</div>
<div class="col-xs-4"></div>
</div>
<div class="row">
<div class="col-xs-6">
<b>Numero di punti di appoggi del ricettore di carico:
<c:choose>
<c:when test="${lista_decentramento.get(10).puntiAppoggio!=0}"> 
${lista_decentramento.get(10).puntiAppoggio}
</c:when>
<c:when test="${lista_decentramento.get(11).puntiAppoggio!=0}"> 
${lista_decentramento.get(11).puntiAppoggio}
</c:when>
</c:choose>
</b>


</div>

<div class="col-xs-6">

<b>Carico: ${lista_decentramento.get(10).carico} ${misura.verStrumento.um}</b>


</div>
</div>
<br>
<div class="row">
<div class="col-xs-4">
<c:if test="${lista_decentramento.get(10).speciale == 'N'}">
<b>Strumento "Speciale": NO</b>
</c:if>
<c:if test="${lista_decentramento.get(10).speciale == 'S'}">
<b>Strumento "Speciale": SI</b>
</c:if> 
</div>
</div>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th class="text-center">Posizione n°</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th class="text-center">ErCorretto<br>Ec<br>${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_decentramento}" var="item" varStatus="loop">
<c:if test="${item.campo== 2 && item.massa!=null }">
<tr role="row" >
	
<c:choose>	
<c:when test="${(item.posizione%2) !=  0}">
<td align="center">E0</td>
</c:when>
<c:otherwise>
<td align="center"><fmt:formatNumber value="${item.posizione/2}" maxFractionDigits="0" /></td>
</c:otherwise>
</c:choose>
<td align="center">${item.massa }</td>
<td align="center">${item.indicazione}</td>
<td align="center">${item.caricoAgg}</td>
<td align="center">${item.errore}</td>
<td align="center">${item.erroreCor}</td>
<td align="center">${item.mpe}</td>


	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 </table>  
 <br>
<div class="row">
<div class="col-xs-12">
<b class="pull-right">ESITO: ${lista_decentramento.get(10).esito }</b>
</div>
</div>
<br>


<div class="row">
<div class="col-xs-12">
<b>Campo 3</b>
</div>
</div>

<div class="row">
<div class="col-xs-4"></div>

<div class="col-xs-4 text-center">
<b>Esempio di ricettore di carico</b><br>
<c:choose>
<c:when test="${lista_decentramento.get(20).tipoRicettore == 0}">
<img class="img" src="./images/tipo_ricettori_carico/tipo_0.png" style="height:70px">
</c:when>
<c:when test="${lista_decentramento.get(20).tipoRicettore == 1}">
<img class="img" src="./images/tipo_ricettori_carico/tipo_1.png" style="height:70px">
</c:when>
<c:otherwise>
<img class="img" src="./images/tipo_ricettori_carico/tipo_2.png" style="height:70px">
</c:otherwise>
</c:choose>
</div>
<div class="col-xs-4"></div>
</div>
<div class="row">
<div class="col-xs-6">

<b>Numero di punti di appoggi del ricettore di carico:
<c:choose>
<c:when test="${lista_decentramento.get(20).puntiAppoggio!=0}"> 
${lista_decentramento.get(20).puntiAppoggio}
</c:when>
<c:when test="${lista_decentramento.get(21).puntiAppoggio!=0}"> 
${lista_decentramento.get(21).puntiAppoggio}
</c:when>
</c:choose>
</b>

</div>

<div class="col-xs-6">

<b>Carico: ${lista_decentramento.get(20).carico} ${misura.verStrumento.um}</b>


</div>
</div>
<br>
<div class="row">
<div class="col-xs-4">
<c:if test="${lista_decentramento.get(20).speciale == 'N'}">
<b>Strumento "Speciale": NO</b>
</c:if>
<c:if test="${lista_decentramento.get(20).speciale == 'S'}">
<b>Strumento "Speciale": SI</b>
</c:if> 
</div>
</div>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th class="text-center">Posizione n°</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th class="text-center">ErCorretto<br>Ec<br>${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_decentramento}" var="item" varStatus="loop">
<c:if test="${item.campo== 3 && item.massa!=null }">
<tr role="row" >
	
<c:choose>	
<c:when test="${(item.posizione%2) !=  0}">
<td align="center">E0</td>
</c:when>
<c:otherwise>
<td align="center"><fmt:formatNumber value="${item.posizione/2}" maxFractionDigits="0" /></td>
</c:otherwise>
</c:choose>
<td align="center">${item.massa }</td>
<td align="center">${item.indicazione}</td>
<td align="center">${item.caricoAgg}</td>
<td align="center">${item.errore}</td>
<td align="center">${item.erroreCor}</td>
<td align="center">${item.mpe}</td>


	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 </table>  
 <br>
<div class="row">
<div class="col-xs-12">
<b class="pull-right">ESITO: ${lista_decentramento.get(20).esito }</b>
</div>
</div>
  <br>
</c:if>
</div>			 




<div class="tab-pane table-responsive" id="linearita">
<c:if test="${misura.verStrumento.tipo.id==3 }">
<div class="row">
<div class="col-xs-12">
<b>Campo 1</b>
</div>
</div>
</c:if>
<div class="row">
<div class="col-xs-12 text-center">

<b>Tipo dispositivo di azzeramento: 
<c:if test="${lista_linearita.get(0).tipoAzzeramento == 1}">
Automatico
</c:if>
<c:if test="${lista_linearita.get(0).tipoAzzeramento == 0}">
Non automatico o semiautomatico
</c:if>
</b>


</div>


</div>
<br>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th class="text-center">Rif.</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th colspan="2" class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
 <th colspan="2" class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th colspan="2" class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th colspan="2" class="text-center">ErCorretto<br>Ec<br>${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>
 <%-- <th class="text-center">Divisione di verifica <br>e associata al carico di prova<br>${misura.verStrumento.um }</th> --%>

 </tr></thead>
 
 <tbody>
 <tr>
 <td></td>
<td></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td></td>
<%-- <td></td> --%>
 </tr>
 <c:forEach items="${lista_linearita}" var="item" varStatus="loop">
<c:if test="${item.campo==1 && item.massa!=null }">
<tr role="row" >
	
<td>${item.riferimento}</td>
<td>${item.massa }</td>
<td>${item.indicazioneSalita}</td>
<td>${item.indicazioneDiscesa}</td>
<td>${item.caricoAggSalita}</td>
<td>${item.caricoAggDiscesa}</td>
<td>${item.erroreSalita}</td>
<td>${item.erroreDiscesa}</td>
<td>${item.erroreCorSalita}</td>
<td>${item.erroreCorDiscesa}</td>
<td>${item.mpe}</td>
<%-- <td>${item.divisione}</td> --%>


	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 </table>  
 <br>
<div class="row">
<div class="col-xs-12">
<b class="pull-right">ESITO: ${lista_linearita.get(0).esito }</b>
</div>
</div>
<br>


<c:if test="${misura.verStrumento.tipo.id==3 }">

<div class="row">
<div class="col-xs-12">
<b>Campo 2</b>
</div>
</div>

<div class="row">
<div class="col-xs-12 text-center">

<b>Tipo dispositivo di azzeramento: 
<c:if test="${lista_linearita.get(6).tipoAzzeramento == 1}">
Automatico
</c:if>
<c:if test="${lista_linearita.get(6).tipoAzzeramento == 0}">
Non automatico o semiautomatico
</c:if>
</b>


</div>


</div>
<br>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th class="text-center">Rif.</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th colspan="2" class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
 <th colspan="2" class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th colspan="2" class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th colspan="2" class="text-center">ErCorretto<br>Ec<br>${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>
 <%-- <th class="text-center">Divisione di verifica <br>e associata al carico di prova<br>${misura.verStrumento.um }</th> --%>

 </tr></thead>
 
 <tbody>
 <tr>
 <td></td>
<td></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td></td>
<%-- <td></td> --%>
 </tr>
 <c:forEach items="${lista_linearita}" var="item" varStatus="loop">
<c:if test="${item.campo==2 && item.massa!=null }">
<tr role="row" >
	
<td>${item.riferimento}</td>
<td>${item.massa }</td>
<td>${item.indicazioneSalita}</td>
<td>${item.indicazioneDiscesa}</td>
<td>${item.caricoAggSalita}</td>
<td>${item.caricoAggDiscesa}</td>
<td>${item.erroreSalita}</td>
<td>${item.erroreDiscesa}</td>
<td>${item.erroreCorSalita}</td>
<td>${item.erroreCorDiscesa}</td>
<td>${item.mpe}</td>
<%-- <td>${item.divisione}</td> --%>


	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 </table>  
 <br>
<div class="row">
<div class="col-xs-12">
<b class="pull-right">ESITO: ${lista_linearita.get(6).esito }</b>
</div>
</div>
<br>





<div class="row">
<div class="col-xs-12">
<b>Campo 3</b>
</div>
</div>

<div class="row">
<div class="col-xs-12 text-center">

<b>Tipo dispositivo di azzeramento: 
<c:if test="${lista_linearita.get(12).tipoAzzeramento == 1}">
Automatico
</c:if>
<c:if test="${lista_linearita.get(12).tipoAzzeramento == 0}">
Non automatico o semiautomatico
</c:if>
</b>


</div>


</div>
<br>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th class="text-center">Rif.</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th colspan="2" class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
 <th colspan="2" class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th colspan="2" class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th colspan="2" class="text-center">ErCorretto<br>Ec<br>${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>
 <%-- <th class="text-center">Divisione di verifica <br>e associata al carico di prova<br>${misura.verStrumento.um }</th> --%>

 </tr></thead>
 
 <tbody>
 <tr>
 <td></td>
<td></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td></td>
<%-- <td></td> --%>
 </tr>
 <c:forEach items="${lista_linearita}" var="item" varStatus="loop">
<c:if test="${item.campo==3 && item.massa!=null }">
<tr role="row" >
	
<td>${item.riferimento}</td>
<td>${item.massa }</td>
<td>${item.indicazioneSalita}</td>
<td>${item.indicazioneDiscesa}</td>
<td>${item.caricoAggSalita}</td>
<td>${item.caricoAggDiscesa}</td>
<td>${item.erroreSalita}</td>
<td>${item.erroreDiscesa}</td>
<td>${item.erroreCorSalita}</td>
<td>${item.erroreCorDiscesa}</td>
<td>${item.mpe}</td>
<%-- <td>${item.divisione}</td> --%>


	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 </table>  
 <br>
<div class="row">
<div class="col-xs-12">
<b class="pull-right">ESITO: ${lista_linearita.get(12).esito }</b>
</div>
</div>
<br>
</c:if>

</div>			 
			 



<div class="tab-pane table-responsive" id="accuratezza">

<c:if test="${misura.verStrumento.tipo.id==3 }">
<div class="row">
<div class="col-xs-12">
<b>Campo 1</b>
</div>
</div>
</c:if>

<div class="row">
<div class="col-xs-12 text-center">


<b>Tipo dispositivo di tara:
<c:if test="${lista_accuratezza.get(0).tipoTara == 0}">
Automatico
</c:if>
<c:if test="${lista_accuratezza.get(0).tipoTara == 1}">
Non automatico o semiautomatico
</c:if>
</b>

</div>


</div>
<br>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th class="text-center">Rif.</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th class="text-center">ErCorretto <br>Ec<br> ${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>

 </tr></thead>
 
 <tbody>

 <c:forEach items="${lista_accuratezza}" var="item" varStatus="loop">
<c:if test="${item.campo == 1 && item.massa!=null }">
<tr role="row" >
	
<td align="center">${item.posizione}</td>
<td align="center">${item.massa }</td>
<td align="center">${item.indicazione}</td>
<td align="center">${item.caricoAgg}</td>
<td align="center">${item.errore}</td>
<td align="center">${item.erroreCor}</td>
<td align="center">${item.mpe}</td>

	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 </table>  
 <br>
<div class="row">
<div class="col-xs-12">
<b class="pull-right">ESITO: ${lista_accuratezza.get(0).esito }</b>
</div>
</div>
<br>

<c:if test="${misura.verStrumento.tipo.id==3 }">

<div class="row">
<div class="col-xs-12">
<b>Campo 2</b>
</div>
</div>


<div class="row">
<div class="col-xs-12 text-center">

<b>Tipo dispositivo di tara:
<c:if test="${lista_accuratezza.get(1).tipoTara == 0}">
Automatico
</c:if>
<c:if test="${lista_accuratezza.get(1).tipoTara == 1}">
Non automatico o semiautomatico
</c:if>
</b>


</div>


</div>
<br>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th class="text-center">Rif.</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th class="text-center">ErCorretto <br>Ec<br> ${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>

 </tr></thead>
 
 <tbody>

 <c:forEach items="${lista_accuratezza}" var="item" varStatus="loop">
<c:if test="${item.campo == 2 && item.massa!=null }">
<tr role="row" >
	
<td align="center">${item.posizione}</td>
<td align="center">${item.massa }</td>
<td align="center">${item.indicazione}</td>
<td align="center">${item.caricoAgg}</td>
<td align="center">${item.errore}</td>
<td align="center">${item.erroreCor}</td>
<td align="center">${item.mpe}</td>

	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 </table>  
 <br>
<div class="row">
<div class="col-xs-12">
<b class="pull-right">ESITO: ${lista_accuratezza.get(1).esito }</b>
</div>
</div>
<br>


<div class="row">
<div class="col-xs-12">
<b>Campo 3</b>
</div>
</div>


<div class="row">
<div class="col-xs-12 text-center">

<b>Tipo dispositivo di tara:
<c:if test="${lista_accuratezza.get(2).tipoTara == 0}">
Automatico
</c:if>
<c:if test="${lista_accuratezza.get(2).tipoTara == 1}">
Non automatico o semiautomatico
</c:if>
</b>


</div>


</div>
<br>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th class="text-center">Rif.</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th class="text-center">ErCorretto <br>Ec<br> ${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>

 </tr></thead>
 
 <tbody>

 <c:forEach items="${lista_accuratezza}" var="item" varStatus="loop">
<c:if test="${item.campo == 3 && item.massa!=null }">
<tr role="row" >
	
<td align="center">${item.posizione}</td>
<td align="center">${item.massa }</td>
<td align="center">${item.indicazione}</td>
<td align="center">${item.caricoAgg}</td>
<td align="center">${item.errore}</td>
<td align="center">${item.erroreCor}</td>
<td align="center">${item.mpe}</td>

	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 </table>  
 <br>
<div class="row">
<div class="col-xs-12">
<b class="pull-right">ESITO: ${lista_accuratezza.get(2).esito }</b>
</div>
</div>
<br>
</c:if>

</div>			 



<div class="tab-pane table-responsive" id="mobilita">

<c:if test="${misura.verStrumento.tipo.id==3 }">
<div class="row">
<div class="col-xs-12">
<b>Campo 1</b>
</div>
</div>
</c:if>


 <c:if test="${lista_mobilita.get(0)!=null && lista_mobilita.get(0).massa!=null }"> 
<div class="row">
<div class="col-xs-12 text-center">

<b>Caso 1)</b> - Strumento ad equilibrio non automatico (con indicazione analogica)


</div>


</div>
<br>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th class="text-center">Carico</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo =<br> 0,4·|MPE carico|<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Indicazione<br>I2<br>${misura.verStrumento.um }</th>
 <th class="text-center">Differenza<br>I2 - I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Div. reale<br>strumento<br> d <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>|I2 - I1| &#8805 d<br>${misura.verStrumento.um }</th>

 </tr></thead>
 
 <tbody>

 <c:forEach items="${lista_mobilita}" var="item" varStatus="loop">
<c:if test="${item.campo==1 && item.caso==1 && item.massa!=null}">
<tr role="row" >
	
<c:if test="${item.carico == 1}">
<td align="center">Min</td>
</c:if>
<c:if test="${item.carico == 2}">
<td align="center">1/2 Max</td>
</c:if>
<c:if test="${item.carico == 3}">
<td align="center">Max</td>
</c:if>

<td align="center">${item.massa }</td>
<td align="center">${item.indicazione}</td>
<td align="center">${item.caricoAgg}</td>
<td align="center">${item.postIndicazione}</td>
<td align="center">${item.differenziale}</td>
<td align="center">${item.divisione}</td>
<td align="center">${item.check_punto}</td>


	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 </table>  
 <br>
<div class="row">
<div class="col-xs-12">
<b class="pull-right">ESITO: ${lista_mobilita.get(0).esito }</b>
</div>
</div>
<br>

 </c:if> 

 <c:if test="${lista_mobilita.get(3)!=null && lista_mobilita.get(3).massa!=null }">
<div class="row">
<div class="col-xs-12 text-center">

<b>Caso 2)</b> - Strumento ad equilibrio automatico o semiautomatico(con indicazione analogica)


</div>


</div>
<br>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th class="text-center">Carico</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo =<br> 0,4·|MPE carico|<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Indicazione<br>I2<br>${misura.verStrumento.um }</th>
 <th class="text-center">Differenza<br>I2 - I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Div. reale<br>strumento<br> d <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>|I2 - I1| &#8805 d<br>${misura.verStrumento.um }</th>

 </tr></thead>
 
 <tbody>

 <c:forEach items="${lista_mobilita}" var="item" varStatus="loop">
<c:if test="${item.campo==1 && item.caso==2 && item.massa!=null}">
<tr role="row" >
	
<c:if test="${item.carico == 1}">
<td align="center">Min</td>
</c:if>
<c:if test="${item.carico == 2}">
<td align="center">1/2 Max</td>
</c:if>
<c:if test="${item.carico == 3}">
<td align="center">Max</td>
</c:if>

<td align="center">${item.massa }</td>
<td align="center">${item.indicazione}</td>
<td align="center">${item.caricoAgg}</td>
<td align="center">${item.postIndicazione}</td>
<td align="center">${item.differenziale}</td>
<td align="center">${item.divisione}</td>
<td align="center">${item.check_punto}</td>


	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 </table>  
 <br>
<div class="row">
<div class="col-xs-12">
<b class="pull-right">ESITO: ${lista_mobilita.get(3).esito }</b>
</div>
</div>
<br>
 </c:if>

<c:if test="${misura.verStrumento.tipo.id==3 }">
 <c:if test="${lista_mobilita.get(6)!=null && lista_mobilita.get(6).massa!=null }">
<div class="row">
<div class="col-xs-12">
<b>Campo 2</b>
</div>
</div>


<div class="row">
<div class="col-xs-12 text-center">

<b>Caso 1)</b> - Strumento ad equilibrio non automatico (con indicazione analogica)


</div>


</div>
<br>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th class="text-center">Carico</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo =<br> 0,4·|MPE carico|<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Indicazione<br>I2<br>${misura.verStrumento.um }</th>
 <th class="text-center">Differenza<br>I2 - I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Div. reale<br>strumento<br> d <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>|I2 - I1| &#8805 d<br>${misura.verStrumento.um }</th>

 </tr></thead>
 
 <tbody>

 <c:forEach items="${lista_mobilita}" var="item" varStatus="loop">
<c:if test="${item.campo==2 && item.caso==1 && item.massa!=null}">
<tr role="row" >
	
<c:if test="${item.carico == 1}">
<td align="center">Min</td>
</c:if>
<c:if test="${item.carico == 2}">
<td align="center">1/2 Max</td>
</c:if>
<c:if test="${item.carico == 3}">
<td align="center">Max</td>
</c:if>

<td align="center">${item.massa }</td>
<td align="center">${item.indicazione}</td>
<td align="center">${item.caricoAgg}</td>
<td align="center">${item.postIndicazione}</td>
<td align="center">${item.differenziale}</td>
<td align="center">${item.divisione}</td>
<td align="center">${item.check_punto}</td>


	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 </table>  
 <br>
<div class="row">
<div class="col-xs-12">
<b class="pull-right">ESITO: ${lista_mobilita.get(6).esito }</b>
</div>
</div>
<br>

</c:if>

 <c:if test="${lista_mobilita.get(9)!=null && lista_mobilita.get(9).massa!=null }">
<div class="row">
<div class="col-xs-12 text-center">

<b>Caso 2)</b> - Strumento ad equilibrio automatico o semiautomatico(con indicazione analogica)


</div>


</div>
<br>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th class="text-center">Carico</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo =<br> 0,4·|MPE carico|<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Indicazione<br>I2<br>${misura.verStrumento.um }</th>
 <th class="text-center">Differenza<br>I2 - I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Div. reale<br>strumento<br> d <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>|I2 - I1| &#8805 d<br>${misura.verStrumento.um }</th>

 </tr></thead>
 
 <tbody>

 <c:forEach items="${lista_mobilita}" var="item" varStatus="loop">
<c:if test="${item.campo==2 && item.caso==2 && item.massa!=null}">
<tr role="row" >
	
<c:if test="${item.carico == 1}">
<td align="center">Min</td>
</c:if>
<c:if test="${item.carico == 2}">
<td align="center">1/2 Max</td>
</c:if>
<c:if test="${item.carico == 3}">
<td align="center">Max</td>
</c:if>

<td align="center">${item.massa }</td>
<td align="center">${item.indicazione}</td>
<td align="center">${item.caricoAgg}</td>
<td align="center">${item.postIndicazione}</td>
<td align="center">${item.differenziale}</td>
<td align="center">${item.divisione}</td>
<td align="center">${item.check_punto}</td>


	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 </table>  
 <br>
<div class="row">
<div class="col-xs-12">
<b class="pull-right">ESITO: ${lista_mobilita.get(9).esito }</b>
</div>
</div>
<br>
</c:if>

 <c:if test="${lista_mobilita.get(12)!=null && lista_mobilita.get(12).massa!=null }">

<div class="row">
<div class="col-xs-12">
<b>Campo 3</b>
</div>
</div>


<div class="row">
<div class="col-xs-12 text-center">

<b>Caso 1)</b> - Strumento ad equilibrio non automatico (con indicazione analogica)


</div>


</div>
<br>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th class="text-center">Carico</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo =<br> 0,4·|MPE carico|<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Indicazione<br>I2<br>${misura.verStrumento.um }</th>
 <th class="text-center">Differenza<br>I2 - I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Div. reale<br>strumento<br> d <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>|I2 - I1| &#8805 d<br>${misura.verStrumento.um }</th>

 </tr></thead>
 
 <tbody>

 <c:forEach items="${lista_mobilita}" var="item" varStatus="loop">
<c:if test="${item.campo==3 && item.caso==1 && item.massa!=null}">
<tr role="row" >
	
<c:if test="${item.carico == 1}">
<td align="center">Min</td>
</c:if>
<c:if test="${item.carico == 2}">
<td align="center">1/2 Max</td>
</c:if>
<c:if test="${item.carico == 3}">
<td align="center">Max</td>
</c:if>

<td align="center">${item.massa }</td>
<td align="center">${item.indicazione}</td>
<td align="center">${item.caricoAgg}</td>
<td align="center">${item.postIndicazione}</td>
<td align="center">${item.differenziale}</td>
<td align="center">${item.divisione}</td>
<td align="center">${item.check_punto}</td>


	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 </table>  
 <br>
<div class="row">
<div class="col-xs-12">
<b class="pull-right">ESITO: ${lista_mobilita.get(12).esito }</b>
</div>
</div>
<br>
</c:if>

 <c:if test="${lista_mobilita.get(15)!=null && lista_mobilita.get(15).massa!=null }">
<div class="row">
<div class="col-xs-12 text-center">

<b>Caso 2)</b> - Strumento ad equilibrio automatico o semiautomatico(con indicazione analogica)


</div>


</div>
<br>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th class="text-center">Carico</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo =<br> 0,4·|MPE carico|<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Indicazione<br>I2<br>${misura.verStrumento.um }</th>
 <th class="text-center">Differenza<br>I2 - I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Div. reale<br>strumento<br> d <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>|I2 - I1| &#8805 d<br>${misura.verStrumento.um }</th>

 </tr></thead>
 
 <tbody>

 <c:forEach items="${lista_mobilita}" var="item" varStatus="loop">
<c:if test="${item.campo==3 && item.caso==2 && item.massa!=null}">
<tr role="row" >
	
<c:if test="${item.carico == 1}">
<td align="center">Min</td>
</c:if>
<c:if test="${item.carico == 2}">
<td align="center">1/2 Max</td>
</c:if>
<c:if test="${item.carico == 3}">
<td align="center">Max</td>
</c:if>

<td align="center">${item.massa }</td>
<td align="center">${item.indicazione}</td>
<td align="center">${item.caricoAgg}</td>
<td align="center">${item.postIndicazione}</td>
<td align="center">${item.differenziale}</td>
<td align="center">${item.divisione}</td>
<td align="center">${item.check_punto}</td>


	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 </table>  
 <br>
<div class="row">
<div class="col-xs-12">
<b class="pull-right">ESITO: ${lista_mobilita.get(15).esito }</b>
</div>
</div>
<br>

</c:if>
</c:if>
</div>			 


              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
 
</div>



 
 </div>

            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>

 </div>

</div>
</c:if> 
<div class="row">
<div class="col-xs-12">

<div class="box box-danger box-solid">
<div class="box-header with-border">
	Esito globale
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
 <c:when test="${esito_globale==true && esitoCheck=='1' }">
  <b>ESITO GLOBALE: CONFORME</b>
  </c:when>
  <c:otherwise>
  <b>ESITO GLOBALE: NON CONFORME</b>
  </c:otherwise>
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
  
 <script type="text/javascript">
 
   
    $(document).ready(function() {
    	
    	$('.dropdown-toggle').dropdown();
    	
    	/*		   $('a[data-toggle="tab"]').one('shown.bs.tab', function (e) {


		       	var  contentID = e.target.id;

 		     	if(contentID == "dettaglioTab"){
		       		exploreModal("dettaglioStrumento.do","id_str=","#dettaglio");
		       	}
		       	if(contentID == "misureTab"){
		       		exploreModal("strumentiMisurati.do?action=ls&id=","","#misure")
		       	}
		       	if(contentID == "modificaTab"){
		       		exploreModal("modificaStrumento.do?action=modifica&id=","","#modifica")
		       	}
		       	if(contentID == "documentiesterniTab"){
		       		exploreModal("documentiEsterni.do?id_str=","","#documentiesterni")
	
		       	} 
		    		
		 		});*/
			   
			   $('#myModalDettaglioStrumento').on('hidden.bs.modal', function (e) {

		    	 	$('#dettaglioTab').tab('show');
		    	 	$('body').removeClass('noScroll');
		    	 	$(document.body).css('padding-right', '0px');
		    	});
    	

    	
     	/* tableNeg = $('#tabNeg').DataTable({
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
    	      paging: false, 
    	      ordering: true,
    	      info: false, 
    	      searchable: false, 
    	      searching: false, 
    	      targets: 0,
    	      responsive: false,
    	      scrollX: true,
    	     // scrollY: "450px",
    	      stateSave: false,
    	      columnDefs: [], 	       

    });
     	
     	
     	
     	
     	tableScostNeg = $('#tabScostNeg').DataTable({
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
    	      paging: false, 
    	      ordering: true,
    	      info: false, 
    	      searchable: false,
    	      searching: false,
    	      targets: 0,
    	      responsive: false,
    	      scrollX: false,
    	     // scrollY: "450px",
    	      stateSave: true,
    	      columnDefs: [], 	       

    });
     	
     	
     	tablePos = $('#tabPos').DataTable({
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
    	      paging: false, 
    	      ordering: true,
    	      info: false, 
    	      searchable: false,
    	      searching: false,
    	      targets: 0,
    	      responsive: false,
    	      scrollX: true,
    	     // scrollY: "450px",
    	      stateSave: true,
    	      columnDefs: [], 	       

    });
     	
     	
     	tableScostPos = $('#tabScostPos').DataTable({
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
    	      paging: false, 
    	      ordering: true,
    	      info: false, 
    	      searchable: false,
    	      searching: false,
    	      targets: 0,
    	      responsive: false,
    	      scrollX: false,
    	     // scrollY: "450px",
    	      stateSave: true,
    	      columnDefs: [], 	       

    }); */
     	


     	
     	

	});


  </script>
  
</jsp:attribute> 
</t:layout>

