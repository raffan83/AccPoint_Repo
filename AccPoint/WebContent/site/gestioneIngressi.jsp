<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

<t:layout title="Gesione Ingressi" bodyClass=" skin-blue-light hold-transition sidebar-mini wysihtml5-supported">




<jsp:attribute name="body_area">

<!-- <div class="wrapper"> -->
	
  <t:main-header2  />



  <form id="tipoIngressoForm" name="tipoIngressoForm" method="post" action="gestioneIngressi.do?action=tipo_ingresso"onsubmit="return validateForm();">
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
			           
			             <div class="col-xs-12">
			             <h2 style="text-align:center">
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
			              
			              Selezionare tipologia registrazione *
			              </div></div><br>
			              <div class="row">
			                <div class="col-xs-12 ">
			              
			              <input type="radio" id="tipo_1" name="tipoIngresso" value="tipo_1"> <label>Ingresso Autisti</label><br>
			              <input type="radio" id="tipo_2" name="tipoIngresso" value="tipo_2"> <label>Ingresso Ditta Esterna, Visitatori</label><br>
			              <!-- <input type="radio"  id="tipo_3" name="tipoIngresso" value="tipo_3"> <label>Prelievo Chiavi</label><br> -->
			              </div></div><br>
			              <div class="row">
			              <div class="col-xs-12 ">
			              * Obbligatoria
			              </div>
			              </div><br>
			              <div class="row">
			              <div class="col-xs-12 ">
			              <button type="submit" class="btn btn-primary" style="width:100%" >Avanti</button>
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
        
<!-- </div> -->
</jsp:attribute>


<jsp:attribute name="extra_css">
<link rel="stylesheet" href="plugins/vegas/vegas.min.css">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
</jsp:attribute>


<jsp:attribute name="extra_js_footer"> 
<script src = "https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script src="plugins/vegas/vegas.min.js"></script>
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
	 


	  	  $( "input" ).keydown(function() {
	  		//$('#erroMsg').html('');
	  	});
	  	  
	  	$("body").vegas({
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
	  	  
	  	});
	  	  
	  	  
	  	  
	});
	
	
	
	 
/* 	 $('#tipoIngressoForm').on('submit', function(e){
		 e.preventDefault();
		 
		 callAjaxForm('#tipoIngressoForm','gestioneIngressi.do?action=tipo_ingresso');
		
	}); */
	</script>

</jsp:attribute>

</t:layout>

