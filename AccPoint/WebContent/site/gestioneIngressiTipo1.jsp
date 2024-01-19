<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

<t:layout title="Gesione Ingressi" bodyClass=" skin-blue-light hold-transition sidebar-mini wysihtml5-supported">




<jsp:attribute name="body_area">

 <div class="wrapper"> 
	
  <t:main-header2  />



  <form id="tipo1Form" name="tipo1Form" method="post">
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
			              
			             Inserire Nominativo *
			              <input type="text" id="nominativo" name="nominativo" class="form-control" required> 
			              
			              </div></div><br>
			              
			              
			              <div class="row">
			              <div class="col-xs-12 ">
			              
			             Inserire Targa *
			              <input type="text" id="targa" name="targa" class="form-control" required>
			              </div></div><br>
			              
			               <div class="row">
			              <div class="col-xs-12 ">
			              
			             Selezionare Tipologia Merce *
			            <select id="tipo_merce" name="tipo_merce" class="form-control select2" data-placeholder="Seleziona tipo merce..." required>
			            <option value=""></option>
			            <option value="1">Merce 1</option>
			            <option value="2">Merce 2</option>
			            <option value="3">Merce 3</option>
			            </select>
			              </div></div><br>
			              
			               <div class="row">
			              <div class="col-xs-12 ">
			              
			             Informazioni di sicurezza
			            <img src="./images/info_sicurezza.jpeg" style="width: 100%">
			         
			              </div></div><br>
			              
			               <div class="row">
			                <div class="col-xs-12 ">
			              
			              <input type="checkbox" id="check_sicurezza" name="tipoIngresso" required value="tipo_1"> <label>Confermo di aver letto le informazioni di sicurezza *</label><br>
			              
			              <!-- <input type="radio"  id="tipo_3" name="tipoIngresso" value="tipo_3"> <label>Prelievo Chiavi</label><br> -->
			              </div></div><br>
			              
			              
			              <div class="row">
			              <div class="col-xs-12 ">
			              * Obbligatoria
			              </div>
			              </div><br>
			              <div class="row">
			              <div class="col-xs-6 ">
			              <button type="button" class="btn btn-primary" style="width:100%" onClick="callAction('gestioneIngressi.do?action=ingresso')" >Indietro</button>
			              </div>
			              <div class="col-xs-6 ">
			              <button type="submit" class="btn btn-primary" style="width:100%" >Invia</button>
			              
			              <input type="hidden" id="tipo_registrazione" name="tipo_registrazione" class="form-control" value="1">
			              </div><br>
			               <div class="col-xs-12 ">
			               <label id="label_error" style="color:red;display:none">Selezionare una tipologia registrazione</label>
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
</jsp:attribute>


<jsp:attribute name="extra_js_footer"> 
<script src = "https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
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
	 
$('.select2').select2()

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
	
	
	

	$('#tipo1Form').on("submit", function(e){
		e.preventDefault();
		
		
		callAjaxForm('#tipo1Form', 'gestioneIngressi.do?action=salva');
	});
	
	</script>

</jsp:attribute>

</t:layout>

