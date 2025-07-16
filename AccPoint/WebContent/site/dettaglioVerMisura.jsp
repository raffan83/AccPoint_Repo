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
        Dettaglio Misura
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
                
                 <li class="list-group-item">
                <b>ID Misura</b>
                 
                   
                 <a class="pull-right"  >${misura.id }</a>
                </li>
                 <li class="list-group-item">
                <b>Intervento</b>
                 
                   
                 <a class=" customTooltip customlink pull-right"  href="gestioneVerIntervento.do?action=dettaglio&id_intervento=${utl:encryptData(misura.verIntervento.id)}" >${misura.verIntervento.id }</a>
                </li>
                 <li class="list-group-item">
                <b>Pacchetto</b>
                 
                   
                 <a class=" pull-right " href="#" onClick="modalListaFile('${misura.verIntervento.nome_pack }')" >${misura.verIntervento.nome_pack}</a>
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
                  <b>Numero di sigilli ripristinati</b> <a class="pull-right">${misura.numeroSigilli}</a>
                </li>
                 <li class="list-group-item">
                  <b>Numero di sigilli presenti</b> <a class="pull-right">${misura.numeroSigilli_presenti}</a>
                </li>
                <li class="list-group-item">
                  <b>Versione software</b> <a class="pull-right">${misura.versione_sw}</a>
                </li>
                <c:if test="${misura.verStrumento.tipo.id == 1 || misura.verStrumento.tipo.id ==2 }">
                	<li class="list-group-item">                
		                <c:choose>
		                <c:when test="${misura.verStrumento.tipo.id == 1}">
		                 <b>Portata massima (Max)</b> <a class="pull-right">${misura.verStrumento.portata_max_C1.stripTrailingZeros().toPlainString()}</a>
		                </c:when>
		                <c:when test="${misura.verStrumento.tipo.id == 2}">
		                <c:choose>
		               <c:when test="${misura.verStrumento.portata_max_C3 !=null && misura.verStrumento.portata_max_C3>0}">
		               		 <b>Portata massima (Max)</b> <a class="pull-right">${misura.verStrumento.portata_max_C3.stripTrailingZeros().toPlainString()}</a>
		                </c:when>
		                <c:otherwise>
		                <b>Portata massima (Max)</b> <a class="pull-right">${misura.verStrumento.portata_max_C2.stripTrailingZeros().toPlainString()}</a>
		                </c:otherwise>
		                 </c:choose>
		                </c:when>		               
		                </c:choose>                 
	                </li>
             
                <li class="list-group-item">
               	 <b>Portata minima (Min)</b> <a class="pull-right">${misura.verStrumento.portata_min_C1.stripTrailingZeros().toPlainString()}</a>
               </li>
               <c:if test="${misura.verStrumento.tipo.id == 1 }">
               <li class="list-group-item">
               	 <b>Divisione di verifica (e)</b> <a class="pull-right">${misura.verStrumento.div_ver_C1.stripTrailingZeros().toPlainString()}</a>
               </li>
               <li class="list-group-item">
               	 <b>Divisione reale (d)</b> <a class="pull-right">${misura.verStrumento.div_rel_C1.stripTrailingZeros().toPlainString()}</a>
               </li>
               <li class="list-group-item">
               	 <b>Numero div. di verif. (n)</b> <a class="pull-right">${misura.verStrumento.numero_div_C1.stripTrailingZeros().toPlainString()}</a>
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
		<td>${misura.verStrumento.div_ver_C1.stripTrailingZeros().toPlainString()}</td>
	</tr>
	<tr role="row">
		<td>e2</td>
		<td>${misura.verStrumento.div_ver_C2.stripTrailingZeros().toPlainString()}</td>
	
	</tr>
	<c:if test="${misura.verStrumento.div_ver_C3!=0 }">
	<tr role="row">
		<td>e3</td>
	<td>${misura.verStrumento.div_ver_C3.stripTrailingZeros().toPlainString()}</td>
	
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
		<td>${misura.verStrumento.div_rel_C1.stripTrailingZeros().toPlainString()}</td>
	</tr>
	<tr role="row">
		<td>d2</td>
		<td>${misura.verStrumento.div_rel_C2.stripTrailingZeros().toPlainString()}</td>
	
	</tr>
	<c:if test="${misura.verStrumento.div_rel_C3!=0 }">
	<tr role="row">
		<td>d3</td>
	<td>${misura.verStrumento.div_rel_C3.stripTrailingZeros().toPlainString()}</td>
	
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
		<td>${misura.verStrumento.numero_div_C1.stripTrailingZeros().toPlainString()}</td>
	</tr>
	<tr role="row">
		<td>n2</td>
		<td>${misura.verStrumento.numero_div_C2.stripTrailingZeros().toPlainString()}</td>
	
	</tr>
	<c:if test="${misura.verStrumento.numero_div_C3!=0 }">
	<tr role="row">
		<td>n3</td>
	<td>${misura.verStrumento.numero_div_C3.stripTrailingZeros().toPlainString()}</td>
	
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
		<td>${misura.verStrumento.portata_min_C1.stripTrailingZeros().toPlainString()}</td>
	</tr>
	<tr role="row">
		<td>Min2</td>
		<td>${misura.verStrumento.portata_min_C2.stripTrailingZeros().toPlainString()}</td>
	
	</tr>
	<c:if test="${misura.verStrumento.portata_min_C3!=0 }">
	<tr role="row">
		<td>Min3</td>
	<td>${misura.verStrumento.portata_min_C3.stripTrailingZeros().toPlainString()}</td>
	
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
		<td>${misura.verStrumento.portata_max_C1.stripTrailingZeros().toPlainString()}</td>
	</tr>
	<tr role="row">
		<td>Max2</td>
		<td>${misura.verStrumento.portata_max_C2.stripTrailingZeros().toPlainString()}</td>
	
	</tr>
	<c:if test="${misura.verStrumento.portata_max_C3!=0 }">
	<tr role="row">
		<td>Max3</td>
	<td>${misura.verStrumento.portata_max_C3.stripTrailingZeros().toPlainString()}</td>
	
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
		<td>${misura.verStrumento.portata_max_C1.stripTrailingZeros().toPlainString()}</td>
		<td>${misura.verStrumento.portata_max_C2.stripTrailingZeros().toPlainString()}</td>
		<td>${misura.verStrumento.portata_max_C3.stripTrailingZeros().toPlainString()}</td>
		
	</tr>
	
	<tr role="row">
		<td>Portata minima (Min)</td>
		<td>${misura.verStrumento.portata_min_C1.stripTrailingZeros().toPlainString()}</td>
		<td>${misura.verStrumento.portata_min_C2.stripTrailingZeros().toPlainString()}</td>
		<td>${misura.verStrumento.portata_min_C3.stripTrailingZeros().toPlainString()}</td>
		
	</tr>
	
 	<tr role="row">
		<td>Divisione di verifica (e)</td>
		<td>${misura.verStrumento.div_ver_C1.stripTrailingZeros().toPlainString()}</td>
		<td>${misura.verStrumento.div_ver_C2.stripTrailingZeros().toPlainString()}</td>
		<td>${misura.verStrumento.div_ver_C3.stripTrailingZeros().toPlainString()}</td>
		
	</tr>
	<tr role="row">
		<td>Divisione reale (d)</td>
		<td>${misura.verStrumento.div_rel_C1.stripTrailingZeros().toPlainString()}</td>
		<td>${misura.verStrumento.div_rel_C2.stripTrailingZeros().toPlainString()}</td>
		<td>${misura.verStrumento.div_rel_C3.stripTrailingZeros().toPlainString()}</td>
		
	</tr>
	<tr role="row">
		<td>Numero div. di verif. (n)</td>
		<td>${misura.verStrumento.numero_div_C1.stripTrailingZeros().toPlainString()}</td>
		<td>${misura.verStrumento.numero_div_C2.stripTrailingZeros().toPlainString()}</td>
		<td>${misura.verStrumento.numero_div_C3.stripTrailingZeros().toPlainString()}</td>
		
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
   <li class="list-group-item">
 	<b>Note attestato</b><textarea id="note_attestato" class="form-control pull-right" name="nome_attestato" rows="1" style="width:100%">${misura.note_attestato }</textarea>
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
 	<c:if test="${certificato.misura.obsoleta=='N'}">
 	<c:if test="${certificato.stato.id==2 && certificato.nomeRapporto!=null }">
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
              <c:if test="${misura.tInizio!=0.0 }">
              <li class="" id="tab7"><a href="#temp_pos" data-toggle="tab" aria-expanded="false"   id="tempPosTab">Temperatura & Posizione</a></li>
              </c:if>
              		<li class="" id="tab2"><a href="#ripetibilita" data-toggle="tab" aria-expanded="false"   id="ripetibilitaTab">Ripetibilità</a></li>
              		<c:if test="${lista_decentramento.get(0).getMassa()!=null }"> 
              		<li class="" id="tab3"><a href="#decentramento" data-toggle="tab" aria-expanded="false"   id="decentramentoTab">Decentramento</a></li>
              		</c:if>
              		<li class="" id="tab4"><a href="#linearita" data-toggle="tab" aria-expanded="false"   id="linearitaTab">Pesatura</a></li>
              		 <c:if test="${misura.verStrumento.tipologia.id==2 }"> 
              		 <c:if test="${lista_accuratezza.get(0).getMassa()!=null }"> 
              		<li class="" id="tab5"><a href="#accuratezza" data-toggle="tab" aria-expanded="false"   id="accuratezzaTab">Accuratezza</a></li>
              		</c:if>              		
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

<c:if test="${checkList.size()>10 }">
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
	<c:if test="${checkList.size()>10}">
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

 </c:if>
	</c:if>
<c:if test="${checkList.size()<=10 && misura.tipoRisposta==0}">
	<fmt:setLocale value="it_IT" />
<fmt:parseDate var="testdate" value="04/07/2022" pattern="dd/MM/yyyy" />


	<c:choose>
	

<c:when test="${misura.dataVerificazione.time gt testdate.time}">

 <tr role="row">
	<td>A) Verificare se lo strumento di misura sottoposto a verificazione è munito dell'ulteriore documentazione indicata nel Decreto di ammissione a verifica (per gli strumenti muniti di bolli di verificazione prima nazionale) oppure nell'Attestazione/Certificazione di esame CE/UE del tipo o di progetto (per gli strumenti conformi alla normativa europea), es. manuale istruzione, manuale di uso e manutenzione, data sheet, eventuali specifiche dei componenti software, ecc.</td>
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
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
	
				 <tr role="row">
	<td>B) Verificare l'esistenza e la corrispondenza sullo strumento di misura delle iscrizioni regolamentari previste nel corrispondente decreto di ammissione a verifica (per gli strumenti muniti di bolli di verificazione prima nazionale</td>
  	<td align="center">
  		<c:if test="${checkList.get(1) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(1) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(1) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>



				 <tr role="row">
	<td>C) Accertare la presenza, integrità, leggibilità e rispondenza ai documenti di omologazione e piani di legalizzazione dello strumento di misura, delle seguenti tipologie di impronte di verificazione prima nazionale, oppure di verificazione prima CEE, oppure di verificazione prima CE, oppure di verifica CE.</td>
  	<td align="center">
  		<c:if test="${checkList.get(2) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(2) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(2) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
 <tr role="row">
	<td>D) Verificare l'esistenza sullo strumento di misura dei sigilli o di altri elementi di protezione in rispondenza a decreto di ammissione a verifica (per gli strumenti muniti di bolli di verificazione prima nazionale);</td>
  	<td align="center">
  		<c:if test="${checkList.get(3) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(3) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(3) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
<%-- 	 <tr role="row">
	<td>E) In caso di presenza di sigillo elettronico con contatore di eventi, accertare la corrispondenza tra l'indicazione di detto contatore e il numero riscontrato, secondo i casi, in occasione dell'ultima verificazione periodica, della verificazione prima o CE oppure dell'ultima rilegalizzazione;</td>
  	<td align="center">
  		<c:if test="${checkList.get(5) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(5) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(5) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr> --%>



	 <tr role="row">
	<td>E) Strumento di misura sottoposto a riparazione (ove siano stati rimossi i sigilli di protezione anche di tipo elettronico) antecedentemente alla prima verificazione periodica.
Se applicabile, procedere con i seguenti punti 1, 2 e 3. 
In caso di non applicabilità, procedere al successivo punto H
1. Verificare presenza della dichiarazione (o sua copia) rilasciata al titolare dello strumento dal riparatore, contenente la descrizione dell'intervento effettuato e dei sigilli provvisori applicati e di cui è stata informata la CCIAA competente per territorio;
2. Verificare la corrispondenza tra i sigilli provvisori applicati sullo strumento dal riparatore e la descrizione della riparazione effettuata annotata sulla dichiarazione di cui al precedente punto G.1.
3. Annotare sul libretto metrologico la dichiarazione di riparazione (o sua copia) rilasciata al titolare dello strumento dal riparatore indicata al precedente punto G.1.</td>
  	<td align="center">
  		<c:if test="${checkList.get(4) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(4) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(4) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
	
		 <tr role="row">
	<td>F) Strumento di misura sottoposto a riparazione (ove siano stati rimossi i sigilli di protezione anche di tipo elettronico) successivamente alla prima verificazione periodica:
Se applicabile, procedere con i seguenti punti 1 e 2.
1. Verificare la presenza dell'annotazione della riparazione effettuata dal riparatore all'interno del libretto metrologico dello strumento di misura;
2. Verificare la corrispondenza tra i sigilli provvisori applicati sullo strumento dal riparatore e la descrizione della riparazione effettuata annotata sul libretto metrologico di cui al precedente punto H.1.</td>
  	<td align="center">
  		<c:if test="${checkList.get(5) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(5) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(5) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
	
		 <tr role="row">
	<td>G) Verificare le condizioni esterne dello strumento, dei dispositivi di comando, regolazione (es. piedini di livello e bolla) e di visualizzazione (es. display, scale graduate);</td>
  	<td align="center">
  		<c:if test="${checkList.get(6) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(6) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(6) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
			 <tr role="row">
	<td>H) Controllare la presenza e lo stato di aggiornamento del libretto metrologico dello strumento sottoposto a verificazione.</td>
  	<td align="center">
  		<c:if test="${checkList.get(7) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(7) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(7) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>


			 <tr role="row">
	<td>I) Rilascio libretto metrologico (art. 4, c.12 DM93/17)</td>
  	<td align="center">
  		<c:if test="${checkList.get(8) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(8) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(8) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
				 <tr role="row">
	<td>L) Compilazione libretto metrologico esistente</td>
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

</c:when>
<c:otherwise>


 <tr role="row">
	<td>A) Verificare se lo strumento di misura sottoposto a verificazione è munito dell'ulteriore documentazione indicata nel Decreto di ammissione a verifica (per gli strumenti muniti di bolli di verificazione prima nazionale) oppure nell'Attestazione/Certificazione di esame CE/UE del tipo o di progetto (per gli strumenti conformi alla normativa europea), es. manuale istruzione, manuale di uso e manutenzione, data sheet, eventuali specifiche dei componenti software, ecc.</td>
  	<td align="center">
  		<c:if test="${checkList.get(1) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(1) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(1) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
	
				 <tr role="row">
	<td>B) Verificare l'esistenza e la corrispondenza sullo strumento di misura delle iscrizioni regolamentari previste nel corrispondente decreto di ammissione a verifica (per gli strumenti muniti di bolli di verificazione prima nazionale</td>
  	<td align="center">
  		<c:if test="${checkList.get(2) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(2) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(2) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>



				 <tr role="row">
	<td>C) Accertare la presenza, integrità, leggibilità e rispondenza ai documenti di omologazione e piani di legalizzazione dello strumento di misura, delle seguenti tipologie di impronte di verificazione prima nazionale, oppure di verificazione prima CEE, oppure di verificazione prima CE, oppure di verifica CE.</td>
  	<td align="center">
  		<c:if test="${checkList.get(3) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(3) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(3) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
 <tr role="row">
	<td>D) Verificare l'esistenza sullo strumento di misura dei sigilli o di altri elementi di protezione in rispondenza a decreto di ammissione a verifica (per gli strumenti muniti di bolli di verificazione prima nazionale);</td>
  	<td align="center">
  		<c:if test="${checkList.get(4) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(4) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(4) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
<%-- 	 <tr role="row">
	<td>E) In caso di presenza di sigillo elettronico con contatore di eventi, accertare la corrispondenza tra l'indicazione di detto contatore e il numero riscontrato, secondo i casi, in occasione dell'ultima verificazione periodica, della verificazione prima o CE oppure dell'ultima rilegalizzazione;</td>
  	<td align="center">
  		<c:if test="${checkList.get(5) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(5) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(5) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr> --%>



	 <tr role="row">
	<td>E) Strumento di misura sottoposto a riparazione (ove siano stati rimossi i sigilli di protezione anche di tipo elettronico) antecedentemente alla prima verificazione periodica.
Se applicabile, procedere con i seguenti punti 1, 2 e 3. 
In caso di non applicabilità, procedere al successivo punto H
1. Verificare presenza della dichiarazione (o sua copia) rilasciata al titolare dello strumento dal riparatore, contenente la descrizione dell'intervento effettuato e dei sigilli provvisori applicati e di cui è stata informata la CCIAA competente per territorio;
2. Verificare la corrispondenza tra i sigilli provvisori applicati sullo strumento dal riparatore e la descrizione della riparazione effettuata annotata sulla dichiarazione di cui al precedente punto G.1.
3. Annotare sul libretto metrologico la dichiarazione di riparazione (o sua copia) rilasciata al titolare dello strumento dal riparatore indicata al precedente punto G.1.</td>
  	<td align="center">
  		<c:if test="${checkList.get(5) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(5) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(5) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
	
		 <tr role="row">
	<td>F) Strumento di misura sottoposto a riparazione (ove siano stati rimossi i sigilli di protezione anche di tipo elettronico) successivamente alla prima verificazione periodica:
Se applicabile, procedere con i seguenti punti 1 e 2.
1. Verificare la presenza dell'annotazione della riparazione effettuata dal riparatore all'interno del libretto metrologico dello strumento di misura;
2. Verificare la corrispondenza tra i sigilli provvisori applicati sullo strumento dal riparatore e la descrizione della riparazione effettuata annotata sul libretto metrologico di cui al precedente punto H.1.</td>
  	<td align="center">
  		<c:if test="${checkList.get(7) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(7) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(7) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
	
		 <tr role="row">
	<td>G) Verificare le condizioni esterne dello strumento, dei dispositivi di comando, regolazione (es. piedini di livello e bolla) e di visualizzazione (es. display, scale graduate);</td>
  	<td align="center">
  		<c:if test="${checkList.get(8) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(8) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(8) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
			 <tr role="row">
	<td>H) Controllare la presenza e lo stato di aggiornamento del libretto metrologico dello strumento sottoposto a verificazione.</td>
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




</c:otherwise>
</c:choose>

			

</c:if>	
	
	
	
		<fmt:setLocale value="it_IT" />
<fmt:parseDate var="testdate" value="04/07/2022" pattern="dd/MM/yyyy" />
	
	<c:if test="${checkList.size()<=10 && misura.tipoRisposta==1}">
	
	
	<c:choose>
	
<%-- 	<fmt:setLocale value="it_IT" />
<fmt:parseDate var="testdate" value="04/07/2022" pattern="dd/MM/yyyy" /> --%>
<c:when test="${misura.dataVerificazione.time gt testdate.time}">
 <tr role="row">
	<td>A) Verificare se lo strumento di misura sottoposto a verificazione è munito dell'ulteriore documentazione indicata nel Decreto di ammissione a verifica (per gli strumenti muniti di bolli di verificazione prima nazionale) oppure nell'Attestazione/Certificazione di esame CE/UE del tipo o di progetto (per gli strumenti conformi alla normativa europea), es. manuale istruzione, manuale di uso e manutenzione, data sheet, eventuali specifiche dei componenti software, ecc.</td>
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
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
	
				 <tr role="row">
	<td>B) Verificare l'esistenza e la corrispondenza sullo strumento di misura delle iscrizioni regolamentari previste nel corrispondente attestazione/Certificazione di esame CE/UE del tipo o di progetto (per gli strumenti conformi alla normativa europea).</td>
  	<td align="center">
  		<c:if test="${checkList.get(1) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(1) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(1) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>



				 <tr role="row">
	<td>C) Accertare la presenza, integrità, leggibilità e rispondenza ai documenti di omologazione e piani di legalizzazione dello strumento di misura, delle seguenti tipologie di impronte di verificazione prima nazionale, oppure di verificazione prima CEE, oppure di verificazione prima CE, oppure di verifica CE.</td>
  	<td align="center">
  		<c:if test="${checkList.get(2) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(2) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(2) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
 <tr role="row">
	<td>D) Verificare l'esistenza sullo strumento di misura dei sigilli o di altri elementi di protezione in rispondenza a Attestazione/Certificazione di esame CE/UE del tipo o di progetto (per gli strumenti conformi alla normativa europea)</td>
  	<td align="center">
  		<c:if test="${checkList.get(3) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(3) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(3) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	 <tr role="row">
	<td>E) In caso di presenza di sigillo elettronico con contatore di eventi, accertare la corrispondenza tra l'indicazione di detto contatore e il numero riscontrato, secondo i casi, in occasione dell'ultima verificazione periodica, della verificazione prima o CE oppure dell'ultima rilegalizzazione;</td>
  	<td align="center">
  		<c:if test="${checkList.get(4) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(4) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(4) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>



	 <tr role="row">
	<td>F) Strumento di misura sottoposto a riparazione (ove siano stati rimossi i sigilli di protezione anche di tipo elettronico) antecedentemente alla prima verificazione periodica.
Se applicabile, procedere con i seguenti punti 1, 2 e 3. 
In caso di non applicabilità, procedere al successivo punto H
1. Verificare presenza della dichiarazione (o sua copia) rilasciata al titolare dello strumento dal riparatore, contenente la descrizione dell'intervento effettuato e dei sigilli provvisori applicati e di cui è stata informata la CCIAA competente per territorio;
2. Verificare la corrispondenza tra i sigilli provvisori applicati sullo strumento dal riparatore e la descrizione della riparazione effettuata annotata sulla dichiarazione di cui al precedente punto G.1.
3. Annotare sul libretto metrologico la dichiarazione di riparazione (o sua copia) rilasciata al titolare dello strumento dal riparatore indicata al precedente punto G.1.</td>
  	<td align="center">
  		<c:if test="${checkList.get(5) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(5) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(5) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
	
		 <tr role="row">
	<td>G) Strumento di misura sottoposto a riparazione (ove siano stati rimossi i sigilli di protezione anche di tipo elettronico) successivamente alla prima verificazione periodica:
Se applicabile, procedere con i seguenti punti 1 e 2.
1. Verificare la presenza dell'annotazione della riparazione effettuata dal riparatore all'interno del libretto metrologico dello strumento di misura;
2. Verificare la corrispondenza tra i sigilli provvisori applicati sullo strumento dal riparatore e la descrizione della riparazione effettuata annotata sul libretto metrologico di cui al precedente punto H.1.</td>
  	<td align="center">
  		<c:if test="${checkList.get(6) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(6) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(6) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
	
		 <tr role="row">
	<td>H) Verificare le condizioni esterne dello strumento, dei dispositivi di comando, regolazione (es. piedini di livello e bolla) e di visualizzazione (es. display, scale graduate);</td>
  	<td align="center">
  		<c:if test="${checkList.get(7) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(7) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(7) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
			 <tr role="row">
	<td>I) Rilascio libretto metrologico (art. 4, c.12 DM93/17)</td>
  	<td align="center">
  		<c:if test="${checkList.get(8) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(8) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(8) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
  	
  	
  	
	</tr>





			 <tr role="row">
	<td>L) Compilazione libretto metrologico esistente</td>
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
</c:when>
<c:otherwise>


 <tr role="row">
	<td>A) Verificare se lo strumento di misura sottoposto a verificazione è munito dell'ulteriore documentazione indicata nel Decreto di ammissione a verifica (per gli strumenti muniti di bolli di verificazione prima nazionale) oppure nell'Attestazione/Certificazione di esame CE/UE del tipo o di progetto (per gli strumenti conformi alla normativa europea), es. manuale istruzione, manuale di uso e manutenzione, data sheet, eventuali specifiche dei componenti software, ecc.</td>
  	<td align="center">
  		<c:if test="${checkList.get(1) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(1) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(1) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
	
				 <tr role="row">
	<td>B) Verificare l'esistenza e la corrispondenza sullo strumento di misura delle iscrizioni regolamentari previste nel corrispondente attestazione/Certificazione di esame CE/UE del tipo o di progetto (per gli strumenti conformi alla normativa europea).</td>
  	<td align="center">
  		<c:if test="${checkList.get(2) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(2) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(2) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>



				 <tr role="row">
	<td>C) Accertare la presenza, integrità, leggibilità e rispondenza ai documenti di omologazione e piani di legalizzazione dello strumento di misura, delle seguenti tipologie di impronte di verificazione prima nazionale, oppure di verificazione prima CEE, oppure di verificazione prima CE, oppure di verifica CE.</td>
  	<td align="center">
  		<c:if test="${checkList.get(3) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(3) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(3) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
 <tr role="row">
	<td>D) Verificare l'esistenza sullo strumento di misura dei sigilli o di altri elementi di protezione in rispondenza a Attestazione/Certificazione di esame CE/UE del tipo o di progetto (per gli strumenti conformi alla normativa europea)</td>
  	<td align="center">
  		<c:if test="${checkList.get(4) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(4) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(4) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	




	 <tr role="row">
	<td>E) Strumento di misura sottoposto a riparazione (ove siano stati rimossi i sigilli di protezione anche di tipo elettronico) antecedentemente alla prima verificazione periodica.
Se applicabile, procedere con i seguenti punti 1, 2 e 3. 
In caso di non applicabilità, procedere al successivo punto H
1. Verificare presenza della dichiarazione (o sua copia) rilasciata al titolare dello strumento dal riparatore, contenente la descrizione dell'intervento effettuato e dei sigilli provvisori applicati e di cui è stata informata la CCIAA competente per territorio;
2. Verificare la corrispondenza tra i sigilli provvisori applicati sullo strumento dal riparatore e la descrizione della riparazione effettuata annotata sulla dichiarazione di cui al precedente punto G.1.
3. Annotare sul libretto metrologico la dichiarazione di riparazione (o sua copia) rilasciata al titolare dello strumento dal riparatore indicata al precedente punto G.1.</td>
  	<td align="center">
  		<c:if test="${checkList.get(5) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(5) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(5) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
	
		 <tr role="row">
	<td>F) Strumento di misura sottoposto a riparazione (ove siano stati rimossi i sigilli di protezione anche di tipo elettronico) successivamente alla prima verificazione periodica:
Se applicabile, procedere con i seguenti punti 1 e 2.
1. Verificare la presenza dell'annotazione della riparazione effettuata dal riparatore all'interno del libretto metrologico dello strumento di misura;
2. Verificare la corrispondenza tra i sigilli provvisori applicati sullo strumento dal riparatore e la descrizione della riparazione effettuata annotata sul libretto metrologico di cui al precedente punto H.1.</td>
  	<td align="center">
  		<c:if test="${checkList.get(6) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(6) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(6) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
	
		 <tr role="row">
	<td>G) Verificare le condizioni esterne dello strumento, dei dispositivi di comando, regolazione (es. piedini di livello e bolla) e di visualizzazione (es. display, scale graduate);</td>
  	<td align="center">
  		<c:if test="${checkList.get(7) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(7) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(7) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
	</tr>
	
	
			 <tr role="row">
	<td>H) Controllare la presenza e lo stato di aggiornamento del libretto metrologico dello strumento
sottoposto a verificazione</td>
  	<td align="center">
  		<c:if test="${checkList.get(8) == 0}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(8) == 1}">
  		<b>X</b>
  		</c:if>
  	</td>
  	<td align="center">
  	<c:if test="${checkList.get(8) == 2}">
  		<b>X</b>
  		</c:if>
  	</td>
  	
  	
  	
	</tr>







</c:otherwise>
</c:choose>

<%-- 			 <tr role="row">
	<td>A) Verificare se lo strumento sottoposto a verificazione è munito di Attestazione/Certificazione di esame CE/UE del tipo o di progetto (per gli strumenti conformi alla normativa europea).</td>
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
  		<b>X</b>
  		</c:if>
  	</td>
	</tr> --%>

			

</c:if>	
	
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
              
              <div class="tab-pane table-responsive" id="temp_pos">
              
              <div class="row">
              <div class="col-xs-3">
              <label style="font-size:22px">Temperatura di prova</label>
               </div>
               </div><br>
               
              <div class="row">
              <div class="col-xs-3">
              
              <label class="pull-right">T inizio</label>
            
               
              </div>
              <div class="col-xs-2">
                 <fmt:formatNumber value="${misura.tInizio }" maxFractionDigits="7"  var="tInizio" />
              <input type="text" class="form-control pull-right" disabled value="${tInizio }" >
            
               
              </div>
              <div class="col-xs-1">
              
            
            
               
              </div>
              <div class="col-xs-2">
              <br>
              <%-- <input type="text" class="form-control pull-right" disabled value="${misura.tInizio }" > --%>
             <label >|Ti - Tf| < 5 C°</label>
         
         <fmt:formatNumber value="${(misura.tFine - misura.tInizio) }" maxFractionDigits="7"  var="temperatura" />
         
               <input type="text" class="form-control pull-right"  value='${temperatura }' disabled> 
              </div>
              </div><br>
              
              <div class="row">
              <div class="col-xs-3">
              
              <label class="pull-right">T fine</label>
            
               
              </div>
              <div class="col-xs-2">
              <fmt:formatNumber value="${misura.tFine }" maxFractionDigits="7"  var="tFine" />
              <input type="text" class="form-control pull-right" disabled value="${tFine }"  >
            
               
              </div>
              <div class="col-xs-1">
              
            
            
               
              </div>
              <div class="col-xs-2">
              
              
            
               
              </div>
              </div><br>
              
              
          <div class="row">
              <div class="col-xs-3">
              <label style="font-size:22px">Posizione</label>
               </div>
               </div><br>
               
               
 <div class="row">

              <div class="col-xs-3">
              <label style="margin-top:15px">Posizione organismo (g) / Luogo verificazione (g)</label>
               </div>
               
               <div class="col-xs-2">
              <label>Altezza/m</label>
              <fmt:formatNumber value="${misura.altezza_org }" maxFractionDigits="7"  var="altezza_org" />
              <input type="text" class="form-control pull-right" disabled value="${altezza_org }" >
               </div>
               
               <div class="col-xs-2">
              <label>Latitudine °</label>
               <fmt:formatNumber value="${misura.latitudine_org }" maxFractionDigits="7"  var="latitudine_org" />
              <input type="text" class="form-control pull-right" disabled value="${latitudine_org }" >
               </div>
               
               <div class="col-xs-2">
              <label>g Loc</label>
              <fmt:formatNumber value="${misura.gOrg }" maxFractionDigits="7"  var="gOrg" />
              <input type="text" class="form-control pull-right" disabled value="${gOrg }" >
               </div>
               
               </div><br>
               
               
               
                <div class="row">
              <div class="col-xs-3">
              <label>Posizione utilizzo (g) / Servizio (g)</label>
               </div>
               
                 <div class="col-xs-2">
               <fmt:formatNumber value="${misura.altezza_util }" maxFractionDigits="7"  var="altezza_util" />
              <input type="text" class="form-control pull-right" disabled value="${altezza_util }" >
               </div>
               
               <div class="col-xs-2">
               <fmt:formatNumber value="${misura.latitudine_util }" maxFractionDigits="7"  var="latitudine_util" />
              <input type="text" class="form-control pull-right" disabled value="${latitudine_util }" >
               </div>
               
               <div class="col-xs-2">
               <fmt:formatNumber value="${misura.gUtil }" maxFractionDigits="7"  var="gUtil" />
              <input type="text" class="form-control pull-right" disabled value="${gUtil }" >
               </div>
               
               </div><br><br><br>
               
               
                  
                <div class="row">
              <div class="col-xs-3">
            
               </div>
               
                 <div class="col-xs-2">
              
              <label class="pull-right">Fattore (g)</label>
               </div>
               
               <div class="col-xs-2">
               <fmt:formatNumber value="${misura.gFactor }" maxFractionDigits="7"  var="gFactor" />
              <input type="text" class="form-control pull-right" disabled value="${gFactor }" >
               </div>
               
               <div class="col-xs-2">
        
               </div>
               
               </div><br>

        </div>
              
              
  <div class="tab-pane table-responsive" id="ripetibilita">
<c:if test="${misura.verStrumento.tipo.id==3 }">
    <div class="row">
  <div class="col-xs-12">
  <b>Campo 1</b>
  </div>
  </div>
  </c:if>
  
  
  <c:if test="${misura.verStrumento.tipo.id==2 }">
    <div class="row">
  <div class="col-xs-12">
  <b>Campo secondario</b>
  </div>
  </div>
  </c:if>
  
  <div class="row">
  <div class="col-xs-8">
  

 <table id="tabCampo1" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th class="text-center">N° Ripetizione</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <c:if test="${misura.verStrumento.tipo.id == 4 }">
  <th class="text-center">Posizione<br>Ceq<br>${misura.verStrumento.um }</th>
  <th class="text-center">Carico di equilibrio<br><br>${misura.verStrumento.um }</th>
 </c:if>
  <c:if test="${misura.verStrumento.tipo.id != 4 }">
   <th class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
  </c:if>

 <c:if test="${misura.verStrumento.tipologia.id == 1 && misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 && misura.verStrumento.tipo.id != 4 }">
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 </c:if>
 <th class="text-center">Indicazione P<br>${misura.verStrumento.um }</th>


 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_ripetibilita}" var="item" varStatus="loop">
 
 <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>
 
<c:if test="${item.campo==1 && item.massa!=null }">
<tr role="row" >
	
<td align="center">${item.numeroRipetizione}</td>
<td align="center">${item.massa.stripTrailingZeros().toPlainString()}</td>

<c:if test="${misura.verStrumento.tipo.id ==4}">
<c:choose>
 <c:when test="${item.caricoAgg>0}"> 
 <td align="center">${item.posizione}</td>

</c:when>
<c:otherwise >
<td align="center">/ </td>
</c:otherwise> 

</c:choose>


</c:if>

<c:if test="${misura.verStrumento.tipo.id !=4 }">
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
</c:if>

 <c:if test="${(misura.verStrumento.tipo.id ==4) || (misura.verStrumento.tipologia.id == 1 && misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 )}">
<td align="center">${item.caricoAgg.setScale(risoluzioneBilancia,  3)}</td>
</c:if>

<c:if test="${misura.verStrumento.tipo.id !=4 }">
<td align="center">${item.portata.setScale(risoluzioneBilanciaE0, 3)}</td>
</c:if>

<c:if test="${misura.verStrumento.tipo.id ==4 }">

<td align="center">${item.indicazione.setScale(risoluzioneBilanciaE0, 3)}</td>
</c:if>



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
	<c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
<td>Pmax - Pmin</td>
<td>${lista_ripetibilita.get(0).deltaPortata.setScale(risoluzioneBilanciaE0, 3) }</td>
<td>${misura.verStrumento.um}</td>
	</tr>
	
	<tr role="row" >
	
<td>MPE (associato al carico di prova)</td>
<td>${lista_ripetibilita.get(0).mpe.stripTrailingZeros() }</td>
<td>${misura.verStrumento.um}</td>
	</tr>

 
	
 </tbody>
 </table> 
<br>
<b>ESITO: ${lista_ripetibilita.get(0).esito }</b>
</div>
  </div>
  
  
 <c:if test="${misura.verStrumento.tipo.id==3 || misura.verStrumento.tipo.id==2}"> 

    <div class="row">
  <div class="col-xs-12">
  <c:if test="${misura.verStrumento.tipo.id==3}">
  <b>Campo 2</b>
  </c:if>
  <c:if test="${misura.verStrumento.tipo.id==2}">
  <b>Campo principale</b>
  </c:if>
  </div>
  </div>

  
    <div class="row">
  <div class="col-xs-8">
  
  
 <table id="tabCampo2" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
  <th class="text-center">N° Ripetizione</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <c:if test="${misura.verStrumento.tipo.id == 4 }">
  <th class="text-center">Posizione<br>Carico di eq.<br>${misura.verStrumento.um }</th>
  <th class="text-center">Carico equilibrio<br><br>${misura.verStrumento.um }</th>
 </c:if>
  <c:if test="${misura.verStrumento.tipo.id != 4 }">
   <th class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
  </c:if>

 <c:if test="${misura.verStrumento.tipologia.id == 1 && misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 && misura.verStrumento.tipo.id != 4 }">
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 </c:if>
 <th class="text-center">P<br>${misura.verStrumento.um }</th>
 
<%--  <th class="text-center">N° Ripetizione</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">P<br>${misura.verStrumento.um }</th> --%>


 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_ripetibilita}" var="item" varStatus="loop">
 
 <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>
 
<c:if test="${item.campo==2 && item.massa!=null }">
<tr role="row" >
	
<td align="center">${item.numeroRipetizione}</td>
<td align="center">${item.massa.stripTrailingZeros().toPlainString()}</td>

<c:if test="${misura.verStrumento.tipo.id ==4}">
<c:choose>
 <c:when test="${item.caricoAgg>0}"> 
 <td align="center">${item.posizione}</td>

</c:when>
<c:otherwise >
<td align="center">/ </td>
</c:otherwise> 

</c:choose>


</c:if>

<c:if test="${misura.verStrumento.tipo.id !=4 }">
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
</c:if>



 <c:if test="${(misura.verStrumento.tipo.id ==4) || (misura.verStrumento.tipologia.id == 1 && misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 )}">
<td align="center">${item.caricoAgg.setScale(risoluzioneBilancia,  3)}</td>
</c:if>
<c:if test="${misura.verStrumento.tipo.id !=4 }">
<td align="center">${item.portata.setScale(risoluzioneBilanciaE0, 3)}</td>
</c:if>

<c:if test="${misura.verStrumento.tipo.id ==4 }">

<td align="center">${item.indicazione.setScale(risoluzioneBilanciaE0, 3)}</td>
</c:if>

	</tr>
	</c:if>
	</c:forEach>
 
 
<%--  <c:forEach items="${lista_ripetibilita}" var="item" varStatus="loop">
 
  <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>
 
<c:if test="${item.campo==2 && item.massa!=null}">
<tr role="row" >
	
<td align="center">${item.numeroRipetizione}</td>
<td align="center">${item.massa.stripTrailingZeros().toPlainString()}</td>
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
 <c:if test="${misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6}">
<td align="center">${item.caricoAgg.setScale(risoluzioneBilancia,  3)}</td>
</c:if>
<td align="center">${item.portata.setScale(risoluzioneBilanciaE0, 3)}</td>

	</tr>
	</c:if>
	</c:forEach>
  --%>
	
 </tbody>
 </table>  
                
</div>  

<div class="col-xs-4">

 <table class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 
 <tbody>

<tr role="row" >
	 <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
<td>Pmax - Pmin</td>
<td>${lista_ripetibilita.get(6).deltaPortata.setScale(risoluzioneBilanciaE0, 3)  }</td>
<td>${misura.verStrumento.um}</td>
	</tr>
	
	<tr role="row" >
	
<td>MPE (associato al carico di prova)</td>
<td>${lista_ripetibilita.get(6).mpe.stripTrailingZeros() }</td>
<td>${misura.verStrumento.um}</td>
	</tr>

 
	
 </tbody>
 </table> 
<br>
<b>ESITO: ${lista_ripetibilita.get(6).esito }</b>
</div>
  </div>
  
  <c:if test="${item.campo==3 && item.massa!=null}">
  
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
<c:if test="${misura.verStrumento.tipo.id ==4}">
<c:choose>
 <c:when test="${item.caricoAgg>0}"> 
 <td align="center">${item.posizione}</td>

</c:when>
<c:otherwise >
<td align="center">/ </td>
</c:otherwise> 

</c:choose>


</c:if>

<c:if test="${misura.verStrumento.tipo.id !=4 }">
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
</c:if>

 <c:if test="${misura.verStrumento.tipologia.id == 1 && misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 && misura.verStrumento.tipo.id != 4 }">
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 </c:if>
 <th class="text-center">P<br>${misura.verStrumento.um }</th>
 
<%--  <th class="text-center">N° Ripetizione</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">P<br>${misura.verStrumento.um }</th> --%>


 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_ripetibilita}" var="item" varStatus="loop">
 
 <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>
 
<c:if test="${item.campo==3 && item.massa!=null }">
<tr role="row" >
	
<td align="center">${item.numeroRipetizione}</td>
<td align="center">${item.massa.stripTrailingZeros().toPlainString()}</td>

<c:if test="${misura.verStrumento.tipo.id ==4}">
<td align="center">${item.posizione}</td>
</c:if>

<c:if test="${misura.verStrumento.tipo.id !=4 }">
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
</c:if>

 <c:if test="${(misura.verStrumento.tipo.id ==4) || (misura.verStrumento.tipologia.id == 1 && misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 )}">
<td align="center">${item.caricoAgg.setScale(risoluzioneBilancia,  3)}</td>
</c:if>
<c:if test="${misura.verStrumento.tipo.id !=4 }">
<td align="center">${item.portata.setScale(risoluzioneBilanciaE0, 3)}</td>
</c:if>

<c:if test="${misura.verStrumento.tipo.id ==4 }">

<td align="center">${item.indicazione.setScale(risoluzioneBilanciaE0, 3)}</td>
</c:if>

	</tr>
	</c:if>
	</c:forEach>
 
<%--  <c:forEach items="${lista_ripetibilita}" var="item" varStatus="loop">
  <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>
<tr role="row" >
	
<td align="center">${item.numeroRipetizione}</td>
<td align="center">${item.massa.stripTrailingZeros().toPlainString()}</td>
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
 <c:if test="${misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6}">
<td align="center">${item.caricoAgg.setScale(risoluzioneBilancia,  3)}</td>
</c:if>
<td align="center">${item.portata.setScale(risoluzioneBilanciaE0, 3)}</td>

	</tr>

	</c:forEach>
 
	
 --%> </tbody>
 </table>  
                
</div>  

<div class="col-xs-4">

 <table class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 
 <tbody>

<tr role="row" >
	  <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>

<td>Pmax - Pmin</td>
<td>${lista_ripetibilita.get(12).deltaPortata.setScale(risoluzioneBilanciaE0, 3)  }</td>
<td>${misura.verStrumento.um}</td>
	</tr>
	
	<tr role="row" >
	
<td>MPE (associato al carico di prova)</td>
<td>${lista_ripetibilita.get(12).mpe.stripTrailingZeros() }</td>
<td>${misura.verStrumento.um}</td>
	</tr>

 
	
 </tbody>
 </table> 
<br>
<b>ESITO: ${lista_ripetibilita.get(12).esito }</b>
</div>
  </div>
</c:if>
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

<c:if test="${misura.verStrumento.tipo.id==2 }">
<div class="row">
<div class="col-xs-12">
<b>Campo secondario</b>
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
<c:when test="${lista_decentramento.get(0).tipoRicettore == 2}">
<img class="img" src="./images/tipo_ricettori_carico/tipo_2.png" style="height:70px">
</c:when>
<c:when test="${lista_decentramento.get(0).tipoRicettore == 3}">
<img class="img" src="./images/tipo_ricettori_carico/tipo_3.png" style="height:70px">
</c:when>
<c:otherwise>
<img class="img" src="./images/tipo_ricettori_carico/tipo_4.png" style="height:70px">
</c:otherwise>
</c:choose>
</div>
<div class="col-xs-4"></div>
</div>
<div class="row">
<div class="col-xs-6">


<b>Punti di appoggio decentrati:
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
  <c:if test="${misura.verStrumento.tipologia.id == 1 && misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 }">
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 </c:if>
 <th class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th class="text-center">ErCorretto<br>Ec<br>${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_decentramento}" var="item" varStatus="loop">
 

 
<c:if test="${item.campo== 1 && item.massa!=null }">
   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>

<tr role="row" >

<c:choose>	
<c:when test="${(item.posizione%2) !=  0}">
<td align="center">E0</td>
</c:when>
<c:otherwise>
<td align="center"><fmt:formatNumber value="${item.posizione/2}" maxFractionDigits="0" /></td>
</c:otherwise>
</c:choose>

<td align="center">${item.massa.stripTrailingZeros().toPlainString() }</td>
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
 <c:if test="${misura.verStrumento.tipologia.id == 1 && misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 }">
<td align="center">${item.caricoAgg.setScale(risoluzioneBilancia, 3)}</td>
</c:if>
<td align="center">${item.errore.setScale(risoluzioneBilanciaE0, 3)}</td>
<td align="center">${item.erroreCor.setScale(risoluzioneBilanciaE0, 3)}</td>
<td align="center">${item.mpe.stripTrailingZeros()}</td>


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




<c:if test="${misura.verStrumento.tipo.id==3 ||misura.verStrumento.tipo.id==2}">
<div class="row">
<div class="col-xs-12">
<c:if test="${misura.verStrumento.tipo.id==3}">
<b>Campo 2</b>
</c:if>

<c:if test="${misura.verStrumento.tipo.id==2}">
<b>Campo principale</b>
</c:if>


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
<c:when test="${lista_decentramento.get(10).tipoRicettore == 2}">
<img class="img" src="./images/tipo_ricettori_carico/tipo_2.png" style="height:70px">
</c:when>
<c:when test="${lista_decentramento.get(10).tipoRicettore == 3}">
<img class="img" src="./images/tipo_ricettori_carico/tipo_3.png" style="height:70px">
</c:when>
<c:otherwise>
<img class="img" src="./images/tipo_ricettori_carico/tipo_4.png" style="height:70px">
</c:otherwise>
</c:choose>
</div>
<div class="col-xs-4"></div>
</div>
<div class="row">
<div class="col-xs-6">
<b>Punti di appoggio decentrati:
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
  <c:if test="${misura.verStrumento.tipologia.id == 1 && misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 }">
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 </c:if>
 <th class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th class="text-center">ErCorretto<br>Ec<br>${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_decentramento}" var="item" varStatus="loop">
 

 
<c:if test="${item.campo== 2 && item.massa!=null }">

    <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>
<tr role="row" >
	
<c:choose>	
<c:when test="${(item.posizione%2) !=  0}">
<td align="center">E0</td>
</c:when>
<c:otherwise>
<td align="center"><fmt:formatNumber value="${item.posizione/2}" maxFractionDigits="0" /></td>
</c:otherwise>
</c:choose>
<td align="center">${item.massa.stripTrailingZeros().toPlainString() }</td>
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
 <c:if test="${misura.verStrumento.tipologia.id == 1 && misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 }">
<td align="center">${item.caricoAgg.setScale(risoluzioneBilancia, 3)}</td>
</c:if>
<td align="center">${item.errore.setScale(risoluzioneBilanciaE0, 3)}</td>
<td align="center">${item.erroreCor.setScale(risoluzioneBilanciaE0, 3)}</td>
<td align="center">${item.mpe.stripTrailingZeros()}</td>



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

  <c:if test="${item.campo==3 && item.massa!=null}">
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
<c:when test="${lista_decentramento.get(20).tipoRicettore == 2}">
<img class="img" src="./images/tipo_ricettori_carico/tipo_2.png" style="height:70px">
</c:when>
<c:when test="${lista_decentramento.get(20).tipoRicettore == 3}">
<img class="img" src="./images/tipo_ricettori_carico/tipo_3.png" style="height:70px">
</c:when>
<c:otherwise>
<img class="img" src="./images/tipo_ricettori_carico/tipo_4.png" style="height:70px">
</c:otherwise>
</c:choose>
</div>
<div class="col-xs-4"></div>
</div>
<div class="row">
<div class="col-xs-6">

<b>Punti di appoggio decentrati:
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
  <c:if test="${misura.verStrumento.tipologia.id == 1 && misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 }">
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 </c:if>
 <th class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th class="text-center">ErCorretto<br>Ec<br>${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_decentramento}" var="item" varStatus="loop">
 
 
<c:if test="${item.campo== 3 && item.massa!=null }">

   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>
<tr role="row" >
	
<c:choose>	
<c:when test="${(item.posizione%2) !=  0}">
<td align="center">E0</td>
</c:when>
<c:otherwise>
<td align="center"><fmt:formatNumber value="${item.posizione/2}" maxFractionDigits="0" /></td>
</c:otherwise>
</c:choose>
<td align="center">${item.massa.stripTrailingZeros().toPlainString() }</td>
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
 <c:if test="${misura.verStrumento.tipologia.id == 1 && misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 }">
<td align="center">${item.caricoAgg.setScale(risoluzioneBilancia, 3)}</td>
</c:if>
<td align="center">${item.errore.setScale(risoluzioneBilanciaE0, 3)}</td>
<td align="center">${item.erroreCor.setScale(risoluzioneBilanciaE0, 3)}</td>
<td align="center">${item.mpe.stripTrailingZeros()}</td>


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
  
  
</c:if>
</div>			 




<div class="tab-pane table-responsive" id="linearita">
<c:if test="${misura.verStrumento.tipo.id==3 || misura.verStrumento.tipo.id==2}">
<div class="row">
<div class="col-xs-12">
<c:if test="${misura.verStrumento.tipo.id==3 }">
<b>Campo 1</b>
</c:if>
<c:if test="${misura.verStrumento.tipo.id==2 }">
<b>Campo secondario</b>
</c:if>
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
 
 <c:if test="${misura.verStrumento.tipo.id == 4 }">
  <th colspan="2" class="text-center">Posizione <br><br></th>
    <th colspan="2" class="text-center">Carico Equilibrio <br><br>${misura.verStrumento.um }</th>
      <th colspan="2" class="text-center">Indicazione Stimata <br><br>${misura.verStrumento.um }</th>
 
 </c:if>
  <c:if test="${misura.verStrumento.tipo.id != 4 }">
   <th colspan="2" class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
  
  </c:if>
 

  <c:if test="${misura.verStrumento.tipologia.id == 1 && misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 }">
 <th colspan="2" class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 </c:if>
 <th colspan="2" class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th colspan="2" class="text-center">ErCorretto<br>Ec<br>${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>
 <%-- <th class="text-center">Divisione di verifica <br>e associata al carico di prova<br>${misura.verStrumento.um }</th> --%>

 </tr></thead>
 
 <tbody>
 <tr>
 <td></td>
<td></td>
 <c:if test="${misura.verStrumento.tipo.id == 4 }">
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
 
 </c:if>
  <c:if test="${misura.verStrumento.tipo.id != 4 }">
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
</c:if>
 <c:if test="${misura.verStrumento.tipologia.id == 1 && misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 }">
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
</c:if>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td></td>
<%-- <td></td> --%>
 </tr>
 <c:forEach items="${lista_linearita}" var="item" varStatus="loop">
<c:if test="${item.campo==1 && item.massa!=null }">
<c:choose>
<c:when test="${misura.verStrumento.tipologia.id == 1 }">
   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>
</c:when>
<c:otherwise>
   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+2 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+2 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale()+1 }"></c:set>
</c:otherwise>
</c:choose>



<tr role="row" >
	
<td>${item.riferimento}</td>
<td>${item.massa.stripTrailingZeros().toPlainString() }</td>

<c:if test="${misura.verStrumento.tipo.id == 4 }">

<c:choose>
 <c:when test="${item.caricoAggSalita>0}"> 
<td>${item.posizione_salita}</td>

</c:when>
<c:otherwise >
<td align="center">/ </td>
</c:otherwise> 

</c:choose>

<c:choose>
 <c:when test="${item.caricoAggDiscesa>0}"> 
<td>${item.posizione_discesa}</td>

</c:when>
<c:otherwise >
<td align="center">/ </td>
</c:otherwise> 

</c:choose>

<td>${item.caricoAggSalita.setScale(risoluzioneBilancia, 3)}</td>
<td>${item.caricoAggDiscesa.setScale(risoluzioneBilancia, 3)}</td>

<td>${item.indicazioneSalita.setScale(risoluzioneBilancia, 3)}</td>
<td>${item.indicazioneDiscesa.setScale(risoluzioneBilancia, 3)}</td>
</c:if>


<c:if test="${misura.verStrumento.tipo.id != 4 }">
<td>${item.indicazioneSalita.setScale(risoluzioneIndicazione, 3)}</td>
<td>${item.indicazioneDiscesa.setScale(risoluzioneIndicazione, 3)}</td>
</c:if>

 <c:if test="${misura.verStrumento.tipologia.id == 1 && misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 && misura.verStrumento.tipo.id != 4 }">
<td>${item.caricoAggSalita.setScale(risoluzioneBilancia, 3)}</td>
<td>${item.caricoAggDiscesa.setScale(risoluzioneBilancia, 3)}</td>
</c:if>
<td>${item.erroreSalita.setScale(risoluzioneBilanciaE0, 3)}</td>
<td>${item.erroreDiscesa.setScale(risoluzioneBilanciaE0, 3)}</td>

<c:choose>
<c:when test="${item.riferimento == 1 }">
<td>/</td>
<td>/</td>
</c:when>
<c:otherwise>
<td>${item.erroreCorSalita.setScale(risoluzioneBilanciaE0, 3)}</td>
<td>${item.erroreCorDiscesa.setScale(risoluzioneBilanciaE0, 3)}</td>
</c:otherwise>
</c:choose>

<td>${item.mpe.stripTrailingZeros()}</td>
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


<c:if test="${misura.verStrumento.tipo.id==3 || misura.verStrumento.tipo.id==2}">

<div class="row">
<div class="col-xs-12">
<c:if test="${misura.verStrumento.tipo.id==3 }">
<b>Campo 2</b>
</c:if>
<c:if test="${misura.verStrumento.tipo.id==2 }">
<b>Campo principale</b>
</c:if>
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
 
 <c:if test="${misura.verStrumento.tipo.id == 4 }">
  <th colspan="2" class="text-center">Posizione <br><br></th>
    <th colspan="2" class="text-center">Carico Equilibrio <br><br>${misura.verStrumento.um }</th>
      <th colspan="2" class="text-center">Indicazione Stimata <br><br>${misura.verStrumento.um }</th>
 
 </c:if>
  <c:if test="${misura.verStrumento.tipo.id != 4 }">
   <th colspan="2" class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
  
  </c:if>
 

  <c:if test="${misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 }">
 <th colspan="2" class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 </c:if>
 <th colspan="2" class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th colspan="2" class="text-center">ErCorretto<br>Ec<br>${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>
 <%-- <th class="text-center">Divisione di verifica <br>e associata al carico di prova<br>${misura.verStrumento.um }</th> --%>

 </tr></thead>
 
 
<%--  <thead><tr class="active">
 <th class="text-center">Rif.</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th colspan="2" class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
  <c:if test="${misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 }">
 <th colspan="2" class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 </c:if>
 <th colspan="2" class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th colspan="2" class="text-center">ErCorretto<br>Ec<br>${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>
 <th class="text-center">Divisione di verifica <br>e associata al carico di prova<br>${misura.verStrumento.um }</th>

 </tr></thead> --%>
 
 
  <tbody>
 <tr>
 <td></td>
<td></td>
 <c:if test="${misura.verStrumento.tipo.id == 4 }">
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
 
 </c:if>
  <c:if test="${misura.verStrumento.tipo.id != 4 }">
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
</c:if>
 <c:if test="${misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 }">
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
</c:if>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td></td>
<%-- <td></td> --%>
 </tr>
 <c:forEach items="${lista_linearita}" var="item" varStatus="loop">
<c:if test="${item.campo==2 && item.massa!=null }">
   <c:choose>
<c:when test="${misura.verStrumento.tipologia.id == 1 }">
   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>
</c:when>
<c:otherwise>
   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+2 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+2 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale()+1 }"></c:set>
</c:otherwise>
</c:choose>
<tr role="row" >
	
<td>${item.riferimento}</td>
<td>${item.massa.stripTrailingZeros().toPlainString() }</td>

<c:if test="${misura.verStrumento.tipo.id == 4 }">

<c:choose>
 <c:when test="${item.caricoAggSalita>0}"> 
<td>${item.posizione_salita}</td>

</c:when>
<c:otherwise >
<td align="center">/ </td>
</c:otherwise> 

</c:choose>

<c:choose>
 <c:when test="${item.caricoAggDiscesa>0}"> 
<td>${item.posizione_discesa}</td>

</c:when>
<c:otherwise >
<td align="center">/ </td>
</c:otherwise> 

</c:choose>

<td>${item.caricoAggSalita.setScale(risoluzioneBilancia, 3)}</td>
<td>${item.caricoAggDiscesa.setScale(risoluzioneBilancia, 3)}</td>

<td>${item.indicazioneSalita.setScale(risoluzioneIndicazione, 3)}</td>
<td>${item.indicazioneDiscesa.setScale(risoluzioneIndicazione, 3)}</td>
</c:if>


<c:if test="${misura.verStrumento.tipo.id != 4 }">
<td>${item.indicazioneSalita.setScale(risoluzioneIndicazione, 3)}</td>
<td>${item.indicazioneDiscesa.setScale(risoluzioneIndicazione, 3)}</td>
</c:if>

 <c:if test="${misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 && misura.verStrumento.tipo.id != 4 }">
<td>${item.caricoAggSalita.setScale(risoluzioneBilancia, 3)}</td>
<td>${item.caricoAggDiscesa.setScale(risoluzioneBilancia, 3)}</td>
</c:if>
<td>${item.erroreSalita.setScale(risoluzioneBilanciaE0, 3)}</td>
<td>${item.erroreDiscesa.setScale(risoluzioneBilanciaE0, 3)}</td>
<c:choose>
<c:when test="${item.riferimento == 1 }">
<td>/</td>
<td>/</td>
</c:when>
<c:otherwise>
<td>${item.erroreCorSalita.setScale(risoluzioneBilanciaE0, 3)}</td>
<td>${item.erroreCorDiscesa.setScale(risoluzioneBilanciaE0, 3)}</td>
</c:otherwise>
</c:choose>

<td>${item.mpe.stripTrailingZeros()}</td>
<%-- <td>${item.divisione}</td> --%>


	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 
 
<%--  <tbody>
 <tr>
 <td></td>
<td></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
 <c:if test="${misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 }">
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
</c:if>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td></td>
<td></td>
 </tr>
 <c:forEach items="${lista_linearita}" var="item" varStatus="loop">
<c:if test="${item.campo==2 && item.massa!=null }">

   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>


<tr role="row" >
	
<td>${item.riferimento}</td>
<td>${item.massa.stripTrailingZeros().toPlainString() }</td>
<td>${item.indicazioneSalita.setScale(risoluzioneIndicazione, 3)}</td>
<td>${item.indicazioneDiscesa.setScale(risoluzioneIndicazione, 3)}</td>
 <c:if test="${misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 }">
<td>${item.caricoAggSalita.setScale(risoluzioneBilancia, 3)}</td>
<td>${item.caricoAggDiscesa.setScale(risoluzioneBilancia, 3)}</td>
</c:if>
<td>${item.erroreSalita.setScale(risoluzioneBilanciaE0, 3)}</td>
<td>${item.erroreDiscesa.setScale(risoluzioneBilanciaE0, 3)}</td>
<td>${item.erroreCorSalita.setScale(risoluzioneBilanciaE0, 3)}</td>
<td>${item.erroreCorDiscesa.setScale(risoluzioneBilanciaE0, 3)}</td>
<td>${item.mpe.stripTrailingZeros()}</td>
<td>${item.divisione}</td>


	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody> --%>
 </table>  
 <br>
<div class="row">
<div class="col-xs-12">
<b class="pull-right">ESITO: ${lista_linearita.get(6).esito }</b>
</div>
</div>
<br>




  <c:if test="${item.campo==3 && item.massa!=null}">
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
 
 <c:if test="${misura.verStrumento.tipo.id == 4 }">
  <th colspan="2" class="text-center">Posizione <br><br></th>
    <th colspan="2" class="text-center">Carico Equilibrio <br><br>${misura.verStrumento.um }</th>
      <th colspan="2" class="text-center">Indicazione Stimata <br><br>${misura.verStrumento.um }</th>
 
 </c:if>
  <c:if test="${misura.verStrumento.tipo.id != 4 }">
   <th colspan="2" class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
  
  </c:if>
 

  <c:if test="${misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 }">
 <th colspan="2" class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 </c:if>
 <th colspan="2" class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th colspan="2" class="text-center">ErCorretto<br>Ec<br>${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>
 <%-- <th class="text-center">Divisione di verifica <br>e associata al carico di prova<br>${misura.verStrumento.um }</th> --%>

 </tr></thead>
 
<%--  <thead><tr class="active">
 <th class="text-center">Rif.</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th colspan="2" class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
  <c:if test="${misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 }">
 <th colspan="2" class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 </c:if>
 <th colspan="2" class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th colspan="2" class="text-center">ErCorretto<br>Ec<br>${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>
 <th class="text-center">Divisione di verifica <br>e associata al carico di prova<br>${misura.verStrumento.um }</th>

 </tr></thead> --%>
 
 
  <tbody>
 <tr>
 <td></td>
<td></td>
 <c:if test="${misura.verStrumento.tipo.id == 4 }">
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
 
 </c:if>
  <c:if test="${misura.verStrumento.tipo.id != 4 }">
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
</c:if>
 <c:if test="${misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 }">
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
</c:if>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td></td>
<%-- <td></td> --%>
 </tr>
 <c:forEach items="${lista_linearita}" var="item" varStatus="loop">
<c:if test="${item.campo==3 && item.massa!=null }">
<c:choose>
<c:when test="${misura.verStrumento.tipologia.id == 1 }">
   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>
</c:when>
<c:otherwise>
   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+2 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+2 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale()+1 }"></c:set>
</c:otherwise>
</c:choose>
<tr role="row" >
	
<td>${item.riferimento}</td>
<td>${item.massa.stripTrailingZeros().toPlainString() }</td>

<c:if test="${misura.verStrumento.tipo.id == 4 }">

<c:choose>
 <c:when test="${item.caricoAggSalita>0}"> 
<td>${item.posizione_salita}</td>

</c:when>
<c:otherwise >
<td align="center">/ </td>
</c:otherwise> 

</c:choose>

<c:choose>
 <c:when test="${item.caricoAggDiscesa>0}"> 
<td>${item.posizione_discesa}</td>

</c:when>
<c:otherwise >
<td align="center">/ </td>
</c:otherwise> 

</c:choose>

<td>${item.caricoAggSalita.setScale(risoluzioneBilancia, 3)}</td>
<td>${item.caricoAggDiscesa.setScale(risoluzioneBilancia, 3)}</td>

<td>${item.indicazioneSalita.setScale(risoluzioneIndicazione, 3)}</td>
<td>${item.indicazioneDiscesa.setScale(risoluzioneIndicazione, 3)}</td>
</c:if>


<c:if test="${misura.verStrumento.tipo.id != 4 }">
<td>${item.indicazioneSalita.setScale(risoluzioneIndicazione, 3)}</td>
<td>${item.indicazioneDiscesa.setScale(risoluzioneIndicazione, 3)}</td>
</c:if>

 <c:if test="${misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 && misura.verStrumento.tipo.id != 4 }">
<td>${item.caricoAggSalita.setScale(risoluzioneBilancia, 3)}</td>
<td>${item.caricoAggDiscesa.setScale(risoluzioneBilancia, 3)}</td>
</c:if>
<td>${item.erroreSalita.setScale(risoluzioneBilanciaE0, 3)}</td>
<td>${item.erroreDiscesa.setScale(risoluzioneBilanciaE0, 3)}</td>
<c:choose>
<c:when test="${item.riferimento == 1 }">
<td>/</td>
<td>/</td>
</c:when>
<c:otherwise>
<td>${item.erroreCorSalita.setScale(risoluzioneBilanciaE0, 3)}</td>
<td>${item.erroreCorDiscesa.setScale(risoluzioneBilanciaE0, 3)}</td>
</c:otherwise>
</c:choose>

<td>${item.mpe.stripTrailingZeros()}</td>
<%-- <td>${item.divisione}</td> --%>


	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody>
 
 
<%--  <tbody>
 <tr>
 <td></td>
<td></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
 <c:if test="${misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 }">
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
</c:if>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td align="center"><i class="fa fa-arrow-up"></i></td>
<td align="center"><i class="fa fa-arrow-down"></i></td>
<td></td>
<td></td>
 </tr>
 <c:forEach items="${lista_linearita}" var="item" varStatus="loop">
<c:if test="${item.campo==3 && item.massa!=null }">

   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>

<tr role="row" >
	
<td>${item.riferimento}</td>
<td>${item.massa.stripTrailingZeros().toPlainString() }</td>
<td>${item.indicazioneSalita.setScale(risoluzioneIndicazione, 3)}</td>
<td>${item.indicazioneDiscesa.setScale(risoluzioneIndicazione, 3)}</td>
 <c:if test="${misura.verStrumento.classe !=5 && misura.verStrumento.classe!=6 }">
<td>${item.caricoAggSalita.setScale(risoluzioneBilancia, 3)}</td>
<td>${item.caricoAggDiscesa.setScale(risoluzioneBilancia, 3)}</td>
</c:if>
<td>${item.erroreSalita.setScale(risoluzioneBilanciaE0, 3)}</td>
<td>${item.erroreDiscesa.setScale(risoluzioneBilanciaE0, 3)}</td>
<td>${item.erroreCorSalita.setScale(risoluzioneBilanciaE0, 3)}</td>
<td>${item.erroreCorDiscesa.setScale(risoluzioneBilanciaE0, 3)}</td>
<td>${item.mpe.stripTrailingZeros()}</td>
<td>${item.divisione}</td>


	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody> --%>
 </table>  
 <br>
<div class="row">
<div class="col-xs-12">
<b class="pull-right">ESITO: ${lista_linearita.get(12).esito }</b>
</div>
</div>
<br>
</c:if>
</c:if>

</div>			 
			 



<div class="tab-pane table-responsive" id="accuratezza">

<c:if test="${misura.verStrumento.tipo.id==3 || misura.verStrumento.tipo.id==2 }">
<div class="row">
<div class="col-xs-12">
<c:if test="${misura.verStrumento.tipo.id==3 }">
<b>Campo 1</b>
</c:if>
<c:if test="${misura.verStrumento.tipo.id==2 }">
<b>Campo secondario</b>
</c:if>
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
<c:if test="${lista_accuratezza.get(0).tipoTara == 2}">
Non presente
</c:if>
</b>

</div>


</div>
<br>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
<%--  <th class="text-center">Rif.</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th class="text-center">ErCorretto <br>Ec<br> ${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th> --%>
 
 <th class="text-center">Rif.</th>
 <th class="text-center">Indicazione Tara Attiva<br><br>${misura.verStrumento.um }</th> 
 <th class="text-center">Carico effettivo di tara<br><br>${misura.verStrumento.um }</th>
 
 <c:if test="${misura.verStrumento.tipologia.id == 2 }">
  <th class="text-center">Max Valore Tara<br><br>${misura.verStrumento.um }</th>
 </c:if>
 

 <th class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th class="text-center">ErCorretto <br>Ec<br> ${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>

 </tr></thead>
 
 <tbody>

 <c:forEach items="${lista_accuratezza}" var="item" varStatus="loop">
 
 <c:choose>
 <c:when test="${lista_accuratezza.get(0).tipoTara == 2}">
<tr role="row" >
	
<td align="center">N/A</td>
<td align="center">N/A</td>
<td align="center">N/A</td>
 <c:if test="${misura.verStrumento.tipologia.id == 2 }">
 <td align="center">N/A</td>
</c:if>

<td align="center">N/A</td>
<td align="center">N/A</td>
<td align="center">N/A</td>

	</tr>
</c:when>
 <c:otherwise>
 
  
<c:if test="${item.campo == 1 && item.massa!=null }">
   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>
<tr role="row" >
	
<td align="center">${item.posizione}</td>
<td align="center">${item.massa.stripTrailingZeros().toPlainString() }</td>
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
 <c:if test="${misura.verStrumento.tipologia.id == 2 }">
 <td align="center">${item.caricoAgg.setScale(risoluzioneBilancia, 3)}</td>
 </c:if>

<td align="center">${item.errore.setScale(risoluzioneBilanciaE0, 3)}</td>
<td align="center">${item.erroreCor.setScale(risoluzioneBilanciaE0, 3)}</td>
<td align="center">${item.mpe.stripTrailingZeros().toPlainString()}</td>

	</tr>
	</c:if>
 </c:otherwise>
 </c:choose>
 

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

<c:if test="${misura.verStrumento.tipo.id==3 || misura.verStrumento.tipo.id==2}">

<div class="row">
<div class="col-xs-12">
<c:if test="${misura.verStrumento.tipo.id==3 }">
<b>Campo 2</b>
</c:if>
<c:if test="${misura.verStrumento.tipo.id==2 }">
<b>Campo principale</b>
</c:if>
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
<c:if test="${lista_accuratezza.get(1).tipoTara == 2}">
Non presente
</c:if>
</b>


</div>


</div>
<br>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
  <th class="text-center">Rif.</th>
 <th class="text-center">Indicazione Tara Attiva<br><br>${misura.verStrumento.um }</th> 
 <th class="text-center">Carico effettivo di tara<br><br>${misura.verStrumento.um }</th>
 
 <c:if test="${misura.verStrumento.tipo.id == 5 }">
  <th class="text-center">Max Valore Tara<br><br>${misura.verStrumento.um }</th>
 </c:if>
 

 <th class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th class="text-center">ErCorretto <br>Ec<br> ${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>
 
<%--  <th class="text-center">Rif.</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th class="text-center">ErCorretto <br>Ec<br> ${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th> --%>

 </tr></thead>
 
 
  <tbody>

 <c:forEach items="${lista_accuratezza}" var="item" varStatus="loop">
 
  <c:choose>
 <c:when test="${lista_accuratezza.get(1).tipoTara == 2}">
<tr role="row" >
	
<td align="center">N/A</td>
<td align="center">N/A</td>
<td align="center">N/A</td>
 <c:if test="${misura.verStrumento.tipo.id == 5 }">
 <td align="center">N/A</td>
</c:if>

<td align="center">N/A</td>
<td align="center">N/A</td>
<td align="center">N/A</td>

	</tr>
</c:when>
 <c:otherwise>
 
 <c:if test="${item.campo == 2 && item.massa!=null }">
   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>
<tr role="row" >
	
<td align="center">${item.posizione}</td>
<td align="center">${item.massa.stripTrailingZeros().toPlainString() }</td>
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
 <c:if test="${misura.verStrumento.tipo.id == 5 }">
 <td align="center">${item.caricoAgg.setScale(risoluzioneBilancia, 3)}</td>
 </c:if>

<td align="center">${item.errore.setScale(risoluzioneBilanciaE0, 3)}</td>
<td align="center">${item.erroreCor.setScale(risoluzioneBilanciaE0, 3)}</td>
<td align="center">${item.mpe.stripTrailingZeros().toPlainString()}</td>

	</tr>
	</c:if>
 </c:otherwise>
 </c:choose>
 
 

	</c:forEach>
 
	
 </tbody>
 
 <%-- <tbody>

 <c:forEach items="${lista_accuratezza}" var="item" varStatus="loop">
<c:if test="${item.campo == 2 && item.massa!=null }">
   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>

<tr role="row" >
	
<td align="center">${item.posizione}</td>
<td align="center">${item.massa.stripTrailingZeros().toPlainString() }</td>
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
<td align="center">${item.caricoAgg.setScale(risoluzioneBilancia, 3)}</td>
<td align="center">${item.errore.setScale(risoluzioneBilanciaE0, 3)}</td>
<td align="center">${item.erroreCor.setScale(risoluzioneBilanciaE0, 3)}</td>
<td align="center">${item.mpe.stripTrailingZeros().toPlainString()}</td>

	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody> --%>
 </table>  
 <br>
<div class="row">
<div class="col-xs-12">
<b class="pull-right">ESITO: ${lista_accuratezza.get(1).esito }</b>
</div>
</div>
<br>

<c:if test="${item.campo == 3 && item.massa!=null }">
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
<c:if test="${lista_accuratezza.get(2).tipoTara == 2}">
Non presente
</c:if>
</b>


</div>


</div>
<br>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
  <th class="text-center">Rif.</th>
 <th class="text-center">Indicazione Tara Attiva<br><br>${misura.verStrumento.um }</th> 
 <th class="text-center">Carico effettivo di Tara<br><br>${misura.verStrumento.um }</th>
 
 <c:if test="${misura.verStrumento.tipo.id == 5 }">
  <th class="text-center">Max Valore Tara<br><br>${misura.verStrumento.um }</th>
 </c:if>
 

 <th class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th class="text-center">ErCorretto <br>Ec<br> ${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th>
 
<%--  <th class="text-center">Rif.</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Errore<br>E<br>${misura.verStrumento.um }</th>
 <th class="text-center">ErCorretto <br>Ec<br> ${misura.verStrumento.um }</th>
 <th class="text-center">MPE<br>(±)<br>${misura.verStrumento.um }</th> --%>

 </tr></thead>
 
  <tbody>

 <c:forEach items="${lista_accuratezza}" var="item" varStatus="loop">
 
  <c:choose>
 <c:when test="${lista_accuratezza.get(2).tipoTara == 2}">
<tr role="row" >
	
<td align="center">N/A</td>
<td align="center">N/A</td>
<td align="center">N/A</td>
 <c:if test="${misura.verStrumento.tipo.id == 5 }">
 <td align="center">N/A</td>
</c:if>

<td align="center">N/A</td>
<td align="center">N/A</td>
<td align="center">N/A</td>

	</tr>
</c:when>
 <c:otherwise>
 <c:if test="${item.campo == 3 && item.massa!=null }">
   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>
<tr role="row" >
	
<td align="center">${item.posizione}</td>
<td align="center">${item.massa.stripTrailingZeros().toPlainString() }</td>
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
 <c:if test="${misura.verStrumento.tipologia.id == 1 ||misura.verStrumento.tipo.id == 5 }">
 <td align="center">${item.caricoAgg.setScale(risoluzioneBilancia, 3)}</td>
 </c:if>

<td align="center">${item.errore.setScale(risoluzioneBilanciaE0, 3)}</td>
<td align="center">${item.erroreCor.setScale(risoluzioneBilanciaE0, 3)}</td>
<td align="center">${item.mpe.stripTrailingZeros().toPlainString()}</td>

	</tr>
	</c:if>
 
 </c:otherwise>
 </c:choose>
 
 
 

	</c:forEach>
 
	
 </tbody>
 
 <%-- <tbody>

 <c:forEach items="${lista_accuratezza}" var="item" varStatus="loop">
<c:if test="${item.campo == 3 && item.massa!=null }">

   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>
<tr role="row" >
	
<td align="center">${item.posizione}</td>
<td align="center">${item.massa.stripTrailingZeros().toPlainString() }</td>
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
<td align="center">${item.caricoAgg.setScale(risoluzioneBilancia, 3)}</td>
<td align="center">${item.errore.setScale(risoluzioneBilanciaE0, 3)}</td>
<td align="center">${item.erroreCor.setScale(risoluzioneBilanciaE0, 3)}</td>
<td align="center">${item.mpe.stripTrailingZeros().toPlainString()}</td>

	</tr>
	</c:if>
	</c:forEach>
 
	
 </tbody> --%>
 </table>  
 <br>
<div class="row">
<div class="col-xs-12">
<b class="pull-right">ESITO: ${lista_accuratezza.get(2).esito }</b>
</div>
</div>
<br>
</c:if>
</c:if>
</div>			 



<div class="tab-pane table-responsive" id="mobilita">

<c:if test="${misura.verStrumento.tipo.id==3 || misura.verStrumento.tipo.id==2 }">
<div class="row">
<div class="col-xs-12">
<c:if test="${misura.verStrumento.tipo.id==3}">
<b>Campo 1</b>
</c:if>

<c:if test="${misura.verStrumento.tipo.id==2}">
<b>Campo secondario</b>
</c:if>
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
 
 <c:if test="${misura.verStrumento.tipo.id == 4 }">
  <th class="text-center">Indicazione<br>L1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo =<br>|EMT carico|<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Indicazione<br>L2<br>${misura.verStrumento.um }</th>
 <th class="text-center">Differenza<br>L2 - L1<br>${misura.verStrumento.um }</th>
  <th class="text-center">0,7 Carico Aggiuntivo = <br>0,7 |EMT|<br>  <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>L2 - L1 &#8805 0,7 EMT<br>${misura.verStrumento.um }</th>
 
 </c:if>
  
  <c:if test="${misura.verStrumento.tipo.id != 4 }">
  
 <th class="text-center">Indicazione<br>I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo =<br> |EMT carico|<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Indicazione<br>I2<br>${misura.verStrumento.um }</th>
 <th class="text-center">Differenza<br>I2 - I1<br>${misura.verStrumento.um }</th>
<%--  <th class="text-center">Div. reale<br>strumento<br> d <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>|I2 - I1| &#8805 d<br>${misura.verStrumento.um }</th> --%>
  <th class="text-center">0,7 Carico Aggiuntivo = <br>0,7 |EMT|<br>  <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>I2 - I1 &#8805 0,7 EMT<br>${misura.verStrumento.um }</th>
</c:if>
 </tr></thead>
 
 <tbody>

 <c:forEach items="${lista_mobilita}" var="item" varStatus="loop">
<c:if test="${item.campo==1 && item.caso==1 && item.massa!=null}">
   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>

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

<td align="center">${item.massa.stripTrailingZeros().toPlainString() }</td>
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
<td align="center">${item.caricoAgg.setScale(risoluzioneBilancia, 3)}</td>
<td align="center">${item.postIndicazione.setScale(risoluzioneIndicazione, 3)}</td>
<td align="center">${item.differenziale.setScale(risoluzioneBilancia, 3)}</td>
<td align="center">${item.divisione.setScale(risoluzioneBilancia, 3)}</td>
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


 Strumento ad equilibrio automatico o semiautomatico(con indicazione analogica)


</div>


</div>
<br>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 
  <thead><tr class="active">
 <th class="text-center">Carico</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th>
 
 <c:if test="${misura.verStrumento.tipo.id == 4 }">
  <th class="text-center">Indicazione<br>L1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo =<br>|EMT carico|<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Indicazione<br>L2<br>${misura.verStrumento.um }</th>
 <th class="text-center">Differenza<br>L2 - L1<br>${misura.verStrumento.um }</th>
  <th class="text-center">0,7 Carico Aggiuntivo = <br>0,7 |EMT|<br>  <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>L2 - L1 &#8805 0,7 EMT<br>${misura.verStrumento.um }</th>
 
 </c:if>
  
  <c:if test="${misura.verStrumento.tipo.id != 4 }">
  
 <th class="text-center">Indicazione<br>I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo =<br> |EMT carico|<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Indicazione<br>I2<br>${misura.verStrumento.um }</th>
 <th class="text-center">Differenza<br>I2 - I1<br>${misura.verStrumento.um }</th>
<%--  <th class="text-center">Div. reale<br>strumento<br> d <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>|I2 - I1| &#8805 d<br>${misura.verStrumento.um }</th> --%>
  <th class="text-center">0,7 Carico Aggiuntivo = <br>0,7 |EMT|<br>  <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>I2 - I1 &#8805 0,7 EMT<br>${misura.verStrumento.um }</th>
</c:if>
 </tr></thead>
 
<%--  <thead><tr class="active">
 <th class="text-center">Carico</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo =<br> 0,4·|MPE carico|<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Indicazione<br>I2<br>${misura.verStrumento.um }</th>
 <th class="text-center">Differenza<br>I2 - I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Div. reale<br>strumento<br> d <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>|I2 - I1| &#8805 d<br>${misura.verStrumento.um }</th>

 </tr></thead> --%>
 
 <tbody>

 <c:forEach items="${lista_mobilita}" var="item" varStatus="loop">
<c:if test="${item.campo==1 && item.caso==2 && item.massa!=null}">
   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>


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

<td align="center">${item.massa.stripTrailingZeros().toPlainString() }</td>
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
<td align="center">${item.caricoAgg.setScale(risoluzioneBilancia, 3)}</td>
<td align="center">${item.postIndicazione.setScale(risoluzioneIndicazione, 3)}</td>
<td align="center">${item.differenziale.setScale(risoluzioneBilancia, 3)}</td>
<td align="center">${item.divisione.setScale(risoluzioneBilancia, 3)}</td>
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

<c:if test="${misura.verStrumento.tipo.id==3 || misura.verStrumento.tipo.id==2}">
 <c:if test="${lista_mobilita.get(6)!=null && lista_mobilita.get(6).massa!=null }">
<div class="row">
<div class="col-xs-12">
<c:if test="${misura.verStrumento.tipo.id==3}"> 
<b>Campo 2</b>
</c:if>
<c:if test="${misura.verStrumento.tipo.id==2}"> 
<b>Campo principale</b>
</c:if>
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
 <th class="text-center">Carico Aggiuntivo =<br> |EMT carico|<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Indicazione<br>I2<br>${misura.verStrumento.um }</th>
 <th class="text-center">Differenza<br>I2 - I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Div. reale<br>strumento<br> d <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>|I2 - I1| &#8805 d<br>${misura.verStrumento.um }</th>

 </tr></thead> 
 
 <tbody>

 <c:forEach items="${lista_mobilita}" var="item" varStatus="loop">
<c:if test="${item.campo==2 && item.caso==1 && item.massa!=null}">
   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>


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

<td align="center">${item.massa.stripTrailingZeros().toPlainString() }</td>
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
<td align="center">${item.caricoAgg.setScale(risoluzioneBilancia, 3)}</td>
<td align="center">${item.postIndicazione.setScale(risoluzioneIndicazione, 3)}</td>
<td align="center">${item.differenziale.setScale(risoluzioneBilancia, 3)}</td>
<td align="center">${item.divisione.setScale(risoluzioneBilancia, 3)}</td>
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

 Strumento ad equilibrio automatico o semiautomatico(con indicazione analogica)


</div>


</div>
<br>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 
   <thead><tr class="active">
 <th class="text-center">Carico</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th>
 
 <c:if test="${misura.verStrumento.tipo.id == 4 }">
  <th class="text-center">Indicazione<br>L1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo =<br>|EMT carico|<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Indicazione<br>L2<br>${misura.verStrumento.um }</th>
 <th class="text-center">Differenza<br>L2 - L1<br>${misura.verStrumento.um }</th>
  <th class="text-center">0,7 Carico Aggiuntivo = <br>0,7 EMT<br>  <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>|L2 - L1| &#8805 0,7 EMT<br>${misura.verStrumento.um }</th>
 
 </c:if>
  
  <c:if test="${misura.verStrumento.tipo.id != 4 }">
  
 <th class="text-center">Indicazione<br>I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo =<br> |EMT carico|<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Indicazione<br>I2<br>${misura.verStrumento.um }</th>
 <th class="text-center">Differenza<br>I2 - I1<br>${misura.verStrumento.um }</th>
<%--  <th class="text-center">Div. reale<br>strumento<br> d <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>|I2 - I1| &#8805 d<br>${misura.verStrumento.um }</th> --%>
  <th class="text-center">0,7 Carico Aggiuntivo = <br>0,7 EMT<br>  <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>|I2 - I1| &#8805 0,7 EMT<br>${misura.verStrumento.um }</th>
</c:if>
 </tr></thead>
 
 
<%--  <thead><tr class="active">
 <th class="text-center">Carico</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo =<br> 0,4·|MPE carico|<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Indicazione<br>I2<br>${misura.verStrumento.um }</th>
 <th class="text-center">Differenza<br>I2 - I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Div. reale<br>strumento<br> d <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>|I2 - I1| &#8805 d<br>${misura.verStrumento.um }</th>

 </tr></thead> --%>
 
 <tbody>

 <c:forEach items="${lista_mobilita}" var="item" varStatus="loop">
<c:if test="${item.campo==2 && item.caso==2 && item.massa!=null}">

   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>


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

<td align="center">${item.massa.stripTrailingZeros().toPlainString() }</td>
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
<td align="center">${item.caricoAgg.setScale(risoluzioneBilancia, 3)}</td>
<td align="center">${item.postIndicazione.setScale(risoluzioneIndicazione, 3)}</td>
<td align="center">${item.differenziale.setScale(risoluzioneBilancia, 3)}</td>
<td align="center">${item.divisione.setScale(risoluzioneBilancia, 3)}</td>
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
 <th class="text-center">Carico Aggiuntivo =<br> |EMT carico|<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Indicazione<br>I2<br>${misura.verStrumento.um }</th>
 <th class="text-center">Differenza<br>I2 - I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Div. reale<br>strumento<br> d <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>|I2 - I1| &#8805 d<br>${misura.verStrumento.um }</th>

 </tr></thead>
 
 <tbody>

 <c:forEach items="${lista_mobilita}" var="item" varStatus="loop">
<c:if test="${item.campo==3 && item.caso==1 && item.massa!=null}">

   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>


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

<td align="center">${item.massa.stripTrailingZeros().toPlainString() }</td>
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
<td align="center">${item.caricoAgg.setScale(risoluzioneBilancia, 3)}</td>
<td align="center">${item.postIndicazione.setScale(risoluzioneIndicazione, 3)}</td>
<td align="center">${item.differenziale.setScale(risoluzioneBilancia, 3)}</td>
<td align="center">${item.divisione.setScale(risoluzioneBilancia, 3)}</td>
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

 Strumento ad equilibrio automatico o semiautomatico(con indicazione analogica)


</div>


</div>
<br>


 <table  class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 
   <thead><tr class="active">
 <th class="text-center">Carico</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th>
 
 <c:if test="${misura.verStrumento.tipo.id == 4 }">
  <th class="text-center">Indicazione<br>L1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo =<br>|EMT carico|<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Indicazione<br>L2<br>${misura.verStrumento.um }</th>
 <th class="text-center">Differenza<br>L2 - L1<br>${misura.verStrumento.um }</th>
  <th class="text-center">0,7 Carico Aggiuntivo = <br>0,7 EMT<br>  <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>|L2 - L1| &#8805 0,7 EMT<br>${misura.verStrumento.um }</th>
 
 </c:if>
  
  <c:if test="${misura.verStrumento.tipo.id != 4 }">
  
 <th class="text-center">Indicazione<br>I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo =<br> |EMT carico|<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Indicazione<br>I2<br>${misura.verStrumento.um }</th>
 <th class="text-center">Differenza<br>I2 - I1<br>${misura.verStrumento.um }</th>
<%--  <th class="text-center">Div. reale<br>strumento<br> d <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>|I2 - I1| &#8805 d<br>${misura.verStrumento.um }</th> --%>
  <th class="text-center">0,7 Carico Aggiuntivo = <br>0,7 EMT<br>  <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>|I2 - I1| &#8805 0,7 EMT<br>${misura.verStrumento.um }</th>
</c:if>
 </tr></thead>
 
<%--  <thead><tr class="active">
 <th class="text-center">Carico</th>
 <th class="text-center">Massa<br>L<br>${misura.verStrumento.um }</th> 
 <th class="text-center">Indicazione<br>I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Carico Aggiuntivo =<br> 0,4·|MPE carico|<br>&#x0394L<br>${misura.verStrumento.um }</th>
 <th class="text-center">Indicazione<br>I2<br>${misura.verStrumento.um }</th>
 <th class="text-center">Differenza<br>I2 - I1<br>${misura.verStrumento.um }</th>
 <th class="text-center">Div. reale<br>strumento<br> d <br> ${misura.verStrumento.um }</th>
 <th class="text-center">Check<br>|I2 - I1| &#8805 d<br>${misura.verStrumento.um }</th>

 </tr></thead>
  --%>
 <tbody>

 <c:forEach items="${lista_mobilita}" var="item" varStatus="loop">
<c:if test="${item.campo==3 && item.caso==2 && item.massa!=null}">

   <c:set var="risoluzioneBilanciaE0" value="${utl:getE(item.campo, misura.verStrumento, BigDecimal.ZERO).scale()+1 }"></c:set>
 <c:set var="risoluzioneBilancia" value="${utl:getE(item.campo,  misura.verStrumento, item.getMassa()).scale()+1 }"></c:set>
 <c:set var="risoluzioneIndicazione" value="${utl:getE(item.campo, misura.verStrumento,item.getMassa()).scale() }"></c:set>


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

<td align="center">${item.massa.stripTrailingZeros().toPlainString() }</td>
<td align="center">${item.indicazione.setScale(risoluzioneIndicazione, 3)}</td>
<td align="center">${item.caricoAgg.setScale(risoluzioneBilancia, 3)}</td>
<td align="center">${item.postIndicazione.setScale(risoluzioneIndicazione, 3)}</td>
<td align="center">${item.differenziale.setScale(risoluzioneBilancia, 3)}</td>
<td align="center">${item.divisione.setScale(risoluzioneBilancia, 3)}</td>
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
 
 
 $('#note_attestato').change(function(){
	
	 pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  
	  dataObj = {}
	  dataObj.note = $(this).val();
   $.ajax({
 	  type: "POST",
 	  url: "gestioneVerMisura.do?action=note_attestato&id_misura="+${misura.id},
 	data: dataObj,
 	dataType: "json",
 	 
 	  success: function( data, textStatus) {
 		pleaseWaitDiv.modal('hide');
 		  	      		  
 		 
 		
 		  if(!data.success){
 			  
 		  
 			  $('#myModalErrorContent').html("Errone nel salvataggio delle note attestato!");
 			  	$('#myModalError').removeClass();
 				$('#myModalError').addClass("modal modal-danger");
 				$('#report_button').show();
 				$('#visualizza_report').show();
					$('#myModalError').modal('show');	      			 
 		  }
 	  },

 	  error: function(jqXHR, textStatus, errorThrown){
 		  pleaseWaitDiv.modal('hide');

 		  $('#myModalErrorContent').html("Errore nella modifica!");
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
				$('#visualizza_report').show();
				$('#myModalError').modal('show');
				
 
 	  }
   });
	 
 });
 
	function formatDate(data){
		
		   var mydate = new Date(data);
		   
		   if(!isNaN(mydate.getTime())){
		   
			   str = mydate.toString("dd/MM/yyyy HH:mm:ss");
		   }			   
		   return str;	 		
	}
 
 function modalListaFile(filename){	 
	 
	 dataString ="filename="+ filename;
       exploreModal("scaricaPacchettoVerificazione.do?action=lista_file",dataString,null,function(datab,textStatusb){

    	   var result = JSON.parse(datab);
    	   if(result.success){
    		   var lista_file = result.lista_file;
    		   var lista_date = result.lista_date;
    		   if(lista_file.length>0){
    			   var html = '<li class="list-group-item"><div class="row"><div class="col-xs-4"><b>Pacchetto</b></div><div class="col-xs-5"><b class="pull-right" style="margin-right:10px">Ultima modifica</b></div><div class="col-xs-3"> </div></div></li>';    		   
        		   for(var i = 0;i<lista_file.length;i++){
        			   html = html +' <li class="list-group-item"><div class="row"><div class="col-xs-4"><b>'+lista_file[i]+'</b></div><div class="col-xs-5"><b class="pull-right">'+new Date(parseInt(lista_date[i])).toString("dd/MM/yyyy HH:mm:ss")+'</b></div><div class="col-xs-3"> <a class="btn btn-default btn-sm pull-right" href="scaricaPacchettoVerificazione.do?action=download&filename='+lista_file[i]+'" ><i class="fa fa-arrow-down"></i></a></div></div></li>';
        		   }
    		   }else{
    			   var html = '<b>Non sono presenti pacchetti!</b>'
    		   }
				
    	   }
    	  
    	   $('#file_content').html(html);
    	   
     	  $("#myModalFile").modal();
     	  
       });
	 
 }
 
 $('#myModalFile').on('hidden.bs.modal',function(){
	 $(document.body).css('padding-right', '0px');
 });
   
    $(document).ready(function() {
    	
    	$('.dropdown-toggle').dropdown();
    	
			   $('#myModalDettaglioStrumento').on('hidden.bs.modal', function (e) {

		    	 	$('#dettaglioTab').tab('show');
		    	 	$('body').removeClass('noScroll');
		    	 	$(document.body).css('padding-right', '0px');
		    	});
    	

	});


  </script>
  
</jsp:attribute> 
</t:layout>

