<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    


<div class="box box-primary box-solid">
			            <div class="box-header with-border">
			              <h3 class="box-title">Messaggio</h3>
			
			              <div class="box-tools pull-right">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-plus"></i></button>
			              </div>
			            </div>
			            <div class="box-body">
			              <b class="pull-right">Inviato il <fmt:formatDate pattern = "dd/MM/yyyy" value = "${messaggio.data }" /> alle <fmt:formatDate pattern = "HH:mm:ss" value = "${messaggio.data }" /></b> <br>
			              
			            
			            <b>Da:</b> <a class="form-control">${messaggio.utente.nominativo} </a>
			             
			              <b>Oggetto:</b> <a class="form-control">${messaggio.titolo} </a><br>
			            <b>Messaggio:</b> <textarea name="testo" style= "background-color: white" rows="15" cols="80" class="form-control" readonly>${messaggio.testo }</textarea><br>
			              <button class="btn btn-primary pull-right" onClick="callAction('gestioneBacheca.do?action=rispondi&oggetto=${messaggio.titolo}&destinatario=${messaggio.utente.id}&company=${messaggio.company.id}')">Rispondi</button><br>
			            </div>
			            <!-- /.box-body -->
			            
			            
</div>



<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>


 <script type="text/javascript">
 
$("#testo").css(".input-disabled", "background-color:#FFF");


</script>