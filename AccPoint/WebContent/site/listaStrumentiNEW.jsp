<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Lista Strumenti
        <small>Elenco Strumenti Portale</small>
      </h1>
    </section>

  <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">
          
          
                        <div class="row">
        <div class="col-xs-6">


          

    
    
    <div class="form-group">
                  <label>Cliente</label>
                  <select name="select1" id="select1" data-placeholder="Seleziona Cliente..."  class="form-control select2" aria-hidden="true" data-live-search="true">
                    <option value=""></option>
                      <c:forEach items="${listaClienti}" var="cliente">
                           <option value="${cliente.__id}">${cliente.nome}</option> 
                     </c:forEach>

                  </select>
        </div>

  </div>
    <div class="col-xs-6"> 
 
     <div class="form-group">
                  <label>Sede</label>
                  <select name="select2" id="select2" data-placeholder="Seleziona Sede"  disabled class="form-control select2" aria-hidden="true" data-live-search="true">
                    <option value=""></option>
             <c:forEach items="${listaSedi}" var="sedi">
                           <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option>                            
                     </c:forEach>
                  </select>
        </div>

  
</div>
</div>

      <div class="row">
        <div class="col-xs-12">    
        <button class="btn btn-info" onclick="spd()">Scarica Pacchetto Dati</button> 
        </div>
</div>
          </div>
            <div class="box-body">

<div class="row">
	<div class="col-xs-12">
	
	 <div id="boxLista" class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
		<div id="posTab">LISTA VUOTA</div>
</div>
</div>
</div>
</div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
 





  <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
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
       <!--        <li class=""><a href="#prenotazione" data-toggle="tab" aria-expanded="false" onclick="" id="prenotazioneTab">Stato Prenotazione</a></li>
               <li class=""><a href="#aggiorna" data-toggle="tab" aria-expanded="false" onclick="" id="aggiornaTab">Gestione Campione</a></li> -->
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="dettaglio">

    			</div> 

              <!-- /.tab-pane -->
             
			  <div class="tab-pane" id="misure">
                

         
			 </div> 


              <!-- /.tab-pane -->

             <!--  <div class="tab-pane" id="prenotazione">
              

              </div> -->
              <!-- /.tab-pane -->
              <!-- <div class="tab-pane" id="aggiorna">
              

              </div> -->
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




<div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body" id="myModalErrorContent" >

       
    
  		 </div>
      <div class="modal-footer">
       <!--  <button type="button" class="btn btn-primary" onclick="approvazioneFromModal('app')"  >Approva</button>
        <button type="button" class="btn btn-danger"onclick="approvazioneFromModal('noApp')"   >Non Approva</button> -->
      </div>
    </div>
  </div>
</div>


 
 
  <div  class="modal"><!-- Place at bottom of page --></div> 
   <div id="modal1"><!-- Place at bottom of page --></div> 
   
    </section>
    <!-- /.content -->
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
   
   $body = $("body");

function spd()
	{
	var idCli=$("#select1").val();
	var idsed=$("#select2").val();	
	var nomeSede=$("#select2 option:selected").text();	
	
	callAction("scaricoPacchettoDirect.do?idC="+idCli+"&idS="+idsed+"&nomeSede="+nomeSede);
	}

    
 
    $("#select1").change(function() {
    
  	  if ($(this).data('options') == undefined) 
  	  {
  	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
  	    $(this).data('options', $('#select2 option').clone());
  	  }
  	  
  	  var id = $(this).val();
  	 
  	  var options = $(this).data('options');

  	  var opt=[];
		

  	   for(var  i=0; i<options.length;i++)
  	   {
  		var str=options[i].value; 
  	
  		if(str.substring(str.indexOf("_")+1,str.length)==id)
  		{
  			
  			if(opt.length == 0){
  				opt.push("<option></option>");
  			}
  		
  			opt.push(options[i]);
  		}   
  	   }
  	 $("#select2").prop("disabled", false);
  	 
  	  $('#select2').html(opt);
  	  
  	  $("#select2").trigger("chosen:updated");
  	  
  	  if(opt.length<2 )
  	  { 
  		$("#select2").change();  
  	  }
  	  
  	
  	});
    
    $(document).ready(function() {
    

    	$(".select2").select2();
    	
    
    
    });
   
    
    $("#select2").change(function(e){
		
          //get the form data using another method 
          var sede = $("#select2").val();
          var cliente = $("#select1").val();
         

          dataString ="idSede="+ sede+";"+cliente;
          exploreModal("listaStrumentiSedeNew.do",dataString,"#posTab",function(data,textStatus){
        	  $('#myModal').on('hidden.bs.modal', function (e) {
             	  	$('#noteApp').val("");
             	 	$('#empty').html("");
             	 	$('body').removeClass('noScroll');
             	})


        		  
        	  
          });

          
    });
    
    
  </script>
</jsp:attribute> 
</t:layout>

 
 