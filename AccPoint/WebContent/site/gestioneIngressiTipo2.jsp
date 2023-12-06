<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

<t:layout title="Gesione Ingressi" bodyClass=" skin-blue-light hold-transition sidebar-mini wysihtml5-supported">




<jsp:attribute name="body_area">

 <div class="wrapper"> 
	
  <t:main-header2  />



  <form id="tipo1Form" name="tipo1Form" method="post" action="gestioneIngressi.do?action=tipo_ingresso"onsubmit="return validateForm();">
 <div class="row">
 <div class="col-xs-12 "></div></div><br><br>
  <div class="row">
  <div class="col-xs-12 ">
   				<div class="col-xs-12 " >
					
					
					<div class="box box-primary">
			            <div class="box-header with-border">
			              <h3 class="box-title"></h3>
			
<!-- 			              <div class="box-tools pull-right">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			                 <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button> 
			              </div> -->
			            </div>
			            <div class="box-body">
			             <div class="row">
			             <div class="col-xs-12 ">
			             <h2>
			             STI SRL - Stabilimento di Sora
			             </h2>
			             </div>
			             </div><br><br>
			             <div class="row">
			              <div class="col-xs-12 ">
			                <img src="./images/immagine_sti.png" style="width: 100%">
			             </div></div><br><br>
			             <div class="row">
			              <div class="col-xs-12 ">
			              
			             Inserire Nome Ditta *
			              <input type="text" id="nome_ditta" name="nome_ditta" class="form-control" required> 
			              
			              </div></div><br>
			              
			                <div class="row">
			              <div class="col-xs-12 ">
			              
			             Inserire Nominativo Visitatore *
			              <input type="text" id="nominativo" name="nominativo" class="form-control" required> 
			              
			              </div></div><br>
			           
			              
			              <div class="row">
			              <div class="col-xs-12 ">
			              
			             Inserire Data Ingresso *
			               <div class="input-group date datepicker" id="datepicker_data_inizio"><input type="text" class="form-control input-small" name="data_ingresso" id="data_ingresso" required><span class="input-group-addon"><span class="fa fa-calendar"></span></span></div>
			              </div></div><br>
			              
			              
			              <div class="row">
			              <div class="col-xs-12 ">
			              
			             Inserire Data Uscita *
			            <div class="input-group date datepicker" id="datepicker_data_inizio"><input type="text" class="form-control input-small" name="data_ingresso" id="data_uscita" required><span class="input-group-addon"><span class="fa fa-calendar"></span></span></div>
			              </div></div><br>
			              
			                <div class="row">
			              <div class="col-xs-12 ">
			              
			             Selezionare Reparto di lavoro *
			            <select id="reparto" name="reparto" class="form-control select2" data-placeholder="Seleziona Reparto..." required>
			            <option value=""></option>
			            <option value="1">Reparto 1</option>
			            <option value="2">Reparto 2</option>
			            <option value="3">Reparto 3</option>
			            </select>
			              </div></div><br>
			              
			               <div class="row">
			              <div class="col-xs-12 ">
			              
			             Selezionare Area / Responsabile *
			            <select id="area" name="area" class="form-control select2" data-placeholder="Seleziona Area/Responsabile..." required>
			            <option value=""></option>
			            <option value="1">Area 1</option>
			            <option value="2">Area 2</option>
			            <option value="3">Area 3</option>
			            </select>
			              </div></div><br>
			              
			                <div class="row">
			              <div class="col-xs-12 ">
			              
			             Selezionare Modalità di ingresso *
			            <select id="modalita_ingresso" name="modalita_ingresso" class="form-control select2" data-placeholder="Seleziona Modalità d'ingresso..." required>
			            <option value=""></option>
			            <option value="1">Modalità 1</option>
			            <option value="2">Modalità 2</option>
			            <option value="3">Modalità 3</option>
			            </select>
			              </div></div><br>
			              
			              <div class="row">
			              <div class="col-xs-12 ">
			              
			             Inserire contatto telefonico *
			            <input type="text" id="targa" name="targa" class="form-control" required>
			            </div>
			            </div>
			            <br>
			              
			              <div class="row">
			              <div class="col-xs-12 ">
			              * Obbligatoria
			              </div>
			              </div><br>
			              <div class="row">
			              <div class="col-xs-6 ">
			              <button type="submit" class="btn btn-primary" style="width:100%" onClick="callAction('gestioneIngressi.do?action=ingresso')" >Indietro</button>
			              </div>
			              <div class="col-xs-6 ">
			              <button type="submit" class="btn btn-primary" style="width:100%" >Invia</button>
			              </div><br>
			               <div class="col-xs-12 ">
			               <label id="label_error" style="color:red;display:none">Compilare le domande obbligatorie!</label>
			               </div>
			             </div>
			             <br><br>
			              <div class="row">
			              <div class="col-xs-12 ">
			              <small>
			               Questo contenuto è creato dal proprietario del modulo. I dati inoltrati verranno inviati al proprietario del modulo. STI Srl non è responsabile per la privacy o le procedure di sicurezza dei propri clienti, incluse quelle del proprietario di questo modulo. Non fornire mai la password.
			               </small>
			              </div>
			              </div>
			            </div>
			            <!-- /.box-body -->
			          </div>
				</div>
				</div>
				</div>
				
  
		
		</form>
        <t:footer/>
 </div> 
</jsp:attribute>


<jsp:attribute name="extra_css">
<!-- <link rel="stylesheet" href="plugins/vegas/vegas.min.css"> -->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <link type="text/css" href="css/bootstrap.min.css" />
</jsp:attribute>


<jsp:attribute name="extra_js_footer"> 
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<!-- <script src="plugins/vegas/vegas.min.js"></script> -->
	<script>
	
	function validateForm() {
		
		$('#label_error').hide();
	    var radioButtons = document.getElementsByName('tipoIngresso');
	    var isChecked = false;

	    for (var i = 0; i < radioButtons.length; i++) {
	        if (radioButtons[i].checked) {
	            isChecked = true;
	            break;
	        }
	    }

	    if (!isChecked) {
	        $('#label_error').show();
	        return false;
	    }

	    return true;
	}
	
	$( document ).ready(function() {
	 
$('.select2').select2();
$('.datepicker').datepicker({
	 format: "dd/mm/yyyy"
}); 

	  	  $( "input" ).keydown(function() {
	  		//$('#erroMsg').html('');
	  	});
	  	  
/* 	  	$("body").vegas({
	  	    slides: [
	  	        { src: "images/bg1.png" },
	  	        { src: "images/bg2.png" },
	  	        { src: "images/bg3.png" },
	  	        { src: "images/bg4.png" },
	  	      	{ src: "images/bg5.png" }
	  	    ],
	  		timer:false,
	  		transitionDuration:3000,
	  		animation: 'random'
	  	  
	  	}); */
	  	  
	  	  
	  	  
	});
	
	
	
	 
/* 	 $('#tipoIngressoForm').on('submit', function(e){
		 e.preventDefault();
		 
		 callAjaxForm('#tipoIngressoForm','gestioneIngressi.do?action=tipo_ingresso');
		
	}); */
	</script>

</jsp:attribute>

</t:layout>

