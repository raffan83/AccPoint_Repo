<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
      
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            
            <div class="row">
<div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati DDT
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${ddt.id}</a>
                </li>
                 <li class="list-group-item">
                  <b>Tipo DDT</b> <a class="pull-right">${ddt.tipo_ddt.descrizione}</a>
                </li>
                <li class="list-group-item">
                  <b>Destinazione</b> <a class="pull-right">${ddt.nome_destinazione}</a>
                </li>
                <li class="list-group-item">
                  <b>Indirizzo Destinazione</b> <a class="pull-right">via ${ddt.indirizzo_destinazione}, ${ddt.cap_destinazione}, ${ddt.citta_destinazione} (${ddt.provincia_destinazione}) ${ddt.paese_destinazione}</a>
                </li>
                <li class="list-group-item">
                  <b>Spedizioniere</b> <a class="pull-right">${ddt.spedizioniere.denominazione}</a>
                </li>
                <li class="list-group-item">
                  <b>Data DDT</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" 
         value="${ddt.data_ddt}" /></a>
                </li>
                <li class="list-group-item">
                  <b>Numero DDT</b> <a class="pull-right">${ddt.numero_ddt} </a>
                </li>
                <li class="list-group-item">
                  <b>Causale</b> <a class="pull-right">${ddt.causale_ddt} </a>
                </li>
                <li class="list-group-item">
                  <b>Tipo Trasporto</b> <a class="pull-right">${ddt.tipo_trasporto.descrizione} </a>
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
         value="${ddt.data_trasporto}" /> <fmt:formatDate pattern="HH:mm:ss" 
         value="${ddt.ora_trasporto}" /></a>
                </li>              
                <li class="list-group-item">
                  <b>Note</b>  <a class="pull-right">${ddt.note} </a> 
                
                </li>
                <c:if test="${ddt.link_pdf!=''}">
                <li class="list-group-item">
                   <b>Download</b> 
                  <c:url var="url" value="gestioneDDT.do">
  					<c:param name="link_pdf" value="${ddt.link_pdf}" />
  					<c:param name="action" value="download" />
				  </c:url>
                 
<a   class="btn btn-danger customTooltip pull-right  btn-xs"  title="Click per scaricare il DDT"   onClick="callAction('${url}')"><i class="fa fa-file-pdf-o"></i></a>
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
       
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

      </div>
    </div>
  </div>
</div>

  <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Messaggio</h4>
      </div>
       <div class="modal-body">
			<div id="modalErrorDiv">
			
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
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


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
 <script type="text/javascript">
   
    
  </script>
  
</jsp:attribute> 
</t:layout>


 
 
 
 



