<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>


<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">

          </div>
            <div class="box-body">
              <div class="row">
        <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 <i class="fa fa-edit"></i>
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body" style="overflow: scroll;">
 
 <form action="" method="post" id="formAppGridAjax">
         <div class="col-xs-6 margin-bottom">
     <div class="form-group">
          <label for="interpolato" class="col-sm-2 control-label">Interpolato:</label>

         <div class="col-sm-4">

         			<select  class="form-control" id="interpolato" type="text" name="interpolato" required>
						
						<c:choose>
						<c:when test="${interpolato.equals('0')}">
						
						<option value="0" selected="selected">NO</option>
         				<option value="1">SI</option>
         			</c:when>
         			<c:otherwise>
         				<option value="0">NO</option>
         				<option value="1" selected="selected">SI</option>
         			</c:otherwise>
         				</c:choose>
         			</select>
     	</div>
         </div>
         
   </div>


   
   
    <div class="col-xs-12 margin-bottom">
<table class="table table-bordered table-hover dataTable table-striped no-footer dtr-inline" id="tblAppendGridAjax">
</table>
</div>
    <div class="col-xs-6">
<%-- <button onClick="saveValoriCampione(${idCamp},'Ajax')" class="btn btn-success"  type="button">Salva</button>
<button class="btn btn-warning" onClick="exportAll()" type="button">Export Dati</button>
 <span class="btn btn-default  btn-file"><span>Upload Dati</span><input type="file"  id="importJsonValue" name="importJsonValue" onChange="importAll()"/></span>
            --%>
<sapn id="ulError"></span>

</div>
 
</form>


</div>
</div>
</div>
</div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
 





 


<div id="myModalSuccess" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Success</h4>
      </div>
       <div class="modal-body" id="myModalPrenotazioneContent" >

      <div class="form-group" id="myModalSuccessContent">

               </div>
        
        
  		<div id="emptyPrenotazione" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline"onclick="$(myModalSuccess).modal('hide');"   >Chiudi</button>

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
    <div class="modal-content">
       <div class="modal-body" id="myModalErrorContent">

        
  		 </div>
      
    </div>
     <div class="modal-footer">
    	<button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
    </div>
  </div>
    </div>

</div>

  </div>

<script src="plugins/jquery.appendGrid/jquery.appendGrid-1.6.3.js"></script>
	<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
	<script src="plugins/fileSaver/FileSaver.js"></script>
	<script type="text/javascript">


   </script>

  <script type="text/javascript">
	var json = JSON.parse('${listaValoriCampioneJson}');
	
	var umJson = JSON.parse('${listaUnitaMisura}');
	var tgJson = JSON.parse('${listaTipoGrandezza}');
	
 	function selection(i, json_data){
 			
			//$('#select3 option').clone()
			var select = $('#tblAppendGridAjax_tipo_grandezza_'+(i+1));  
			
			//var options = $('#tblAppendGridAjax_tipo_grandezza_'+(i+1) +'option').clone();
			 var opt = $('#tblAppendGridAjax_tipo_grandezza_'+(i+1))[0];
			for(var j=0;j<opt.length;j++){
				
				if(json[i].tipo_grandezza.id != null && opt[j].value==json[i].tipo_grandezza.id.toString()){					

				opt[j].selected = true;
 				$('#tblAppendGridAjax_tipo_grandezza_'+(i+1)).val(opt[j].value).trigger('change');  
				}else if(opt[j].value==json[i].tipo_grandezza.toString()){
					opt[j].selected = true;
	 				$('#tblAppendGridAjax_tipo_grandezza_'+(i+1)).val(opt[j].value).trigger('change');  
				}
			}	
		selection2(i);
	}
 	
 	
 	function selection2(i){
 
			var select = $('#tblAppendGridAjax_unita_misura_'+(i+1));  
			
			var opt = $('#tblAppendGridAjax_unita_misura_'+(i+1))[0];
			for(var j=0;j<opt.length;j++){

				if(json[i].unita_misura.id !=null && opt[j].value==json[i].unita_misura.id.toString()){
					
				opt[j].selected = true;
 				$('#tblAppendGridAjax_unita_misura_'+(i+1)).val(opt[j].value).trigger('change');  
				}else if(opt[j].value==json[i].unita_misura.toString()){
					opt[j].selected = true;
	 				$('#tblAppendGridAjax_tipo_grandezza_'+(i+1)).val(opt[j].value).trigger('change');  
				}
			}
			//$(select).change();  
			  
	}
	 

 	var row_deleted=0;
  
    $(document).ready(function() {
    
    	console.log("test")

    	
    	$('#tblAppendGridAjax').appendGrid({
            //caption: 'Valori Campione',
            //captionTooltip: '',
            initRows: 1,
            hideButtons: {
                remove: false,
                insert:false
            },
            columns: [

					  { name: 'parametri_taratura', display: 'Parametri Taratura', type: 'text',ctrlCss: { width: '100%' , 'min-width':"150px"}, ctrlClass: 'required'  },
                      { name: 'valore_nominale', display: 'Valore Nominale', type: 'text', ctrlClass: 'numberfloat ', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px"} },
                      { name: 'valore_taratura', display: 'Valore Taratura', type: 'text', ctrlClass: 'numberfloat ', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px"}  },
                      { name: 'incertezza_assoluta', display: 'Incertezza Assoluta', type: 'text', ctrlClass: 'numberfloat', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px"} },
                      { name: 'incertezza_relativa', display: 'Incertezza Relativa', type: 'text', ctrlClass: 'numberfloat incRelativa', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px"}  },
                      //  { name: 'interpolato', display: 'Interpolato', type: 'select', ctrlOptions:';0:NO;1:SI', ctrlClass: 'required' , ctrlCss: { 'min-width': '100px'} },
                      // { name: 'valore_composto', display: 'Valore Composto', type: 'select', ctrlOptions:';0:NO;1:SI', ctrlClass: 'required', ctrlCss: { 'min-width': '100px'}  },
                      { name: 'divisione_UM', display: 'Divisione UM', type: 'text', ctrlClass: 'numberfloat required', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px"}  },
                      { name: 'tipo_grandezza', display: 'Tipo Grandezza', type: 'select', ctrlClass: 'required select2MV tipograndezzeselect', ctrlOptions: tgJson, ctrlCss: { 'text-align': 'center', "width":"100%", 'max-width': '150px'}},
                      { name: 'unita_misura', display: 'Unita di Misura', type: 'select', ctrlClass: 'required select2MV', ctrlCss: { 'text-align': 'center', "width":"100%", 'max-width': '150px'}   }, 
                        
                      { name: 'id', type: 'hidden', value: 0 }
                  
                  ] ,
                  customFooterButtons: [
	                     
                      {
                          uiButton: { icons: { primary: 'ui-icon-arrowthickstop-1-s' }, text: false },
                          btnAttr: { title: 'Download Data' },
                          click: function (evt) {
	                        generacsv();
                          }
                      }
                  ],
               	
               	initData : json,
               	
                beforeRowRemove: function (caller, rowIndex) {
                    return confirm('Are you sure to remove this row?');
                },
                afterRowRemoved: function (caller, rowIndex) {
                	$(".ui-tooltip").remove();
                	row_deleted++;
                },
                rowDataLoaded: function (caller, record, addedRowIndex, uniqueIndex) {
                    // Copy data of `Year` from parent row to new added rows
                   
              modificaValoriCampioneTrigger(umJson, addedRowIndex+1,"Ajax");
                    
                    selection(addedRowIndex);
                	 
                },
                afterRowAppended: function (caller, parentRowIndex, addedRowIndex) {
                    // Copy data of `Year` from parent row to new added rows

                	 
                	 modificaValoriCampioneTrigger(umJson, (parseInt(addedRowIndex)+1+row_deleted),"Ajax");
                	$('#tblAppendGridAjax_tipo_grandezza_'+(parseInt(addedRowIndex)+1+row_deleted)).select2();
                	$('#tblAppendGridAjax_unita_misura_'+(parseInt(addedRowIndex)+1+row_deleted)).select2();
                	
                },
      
                afterRowInserted: function (caller, parentRowIndex, addedRowIndex) {
                    // Copy data of `Year` from parent row to new added rows
   
                	 var index = caller.rows.length-2;
                	 modificaValoriCampioneTrigger(umJson, (index+row_deleted),"Ajax");
                	$('#tblAppendGridAjax_tipo_grandezza_'+(index+row_deleted)).select2();
                	$('#tblAppendGridAjax_unita_misura_'+(index+row_deleted)).select2();
                	
                },
        });
    	
    	
    	//modificaValoriCampioneTrigger(umJson);
    	
   $('.select2MV').select2({
  	//	placeholder: "Seleziona",
  		dropdownCssClass: "select2MVOpt",  		
  	});
    	

    	$("#interpolato").change(function(){
    	
    		if($("#interpolato").val()==1){
    			$('#tblAppendGridAjax tbody tr').each(function(){
    			    var td = $(this).find('td').eq(1);
    			    attr = td.attr('id');
    			    $("#" + attr  + " input").val("${campione.codice}");
    			    $("#" + attr  + " input").prop('disabled', false);

    			   // alert(td.attr('id'));
    			})
    		}else{
    			i = 1;
    			$('#tblAppendGridAjax tbody tr').each(function(){
    				var td = $(this).find('td').eq(1);
    				attr = td.attr('id');
    			    $("#" + attr  + " input").val("${campione.codice}"+"_"+i);
    			    $("#" + attr  + " input").prop('disabled', false);
    			    i++;
    			})
    		}
    	});
    });

    

    var validator = $("#formAppGridAjax").validate({
    	
    	onkeyup: false,
    	showErrors: function(errorMap, errorList) {
    	  
    	    this.defaultShowErrors();
    	  },
    	  errorPlacement: function(error, element) {
    		  $("#ulError").html("<span class='label label-danger'>Errore inserimento valori (" + error[0].innerHTML + ")</span>");
    		 }
    });
    
    jQuery.validator.addMethod("numberfloat", function(value, element) {
  	  //return this.optional(element) || /^(-?\d+(?:[\.]\d{1,30})?)$/.test(value);  	  
  	  return this.optional(element) || /^[-+]?[0-9]+[.]?[0-9]*([eE][-+]?[0-9]+)?$/.test(value);
  	
  	}, "Questo campo deve essere un numero");
    
  
    function exportAll(){
    	 	var data = $('#tblAppendGridAjax').appendGrid('getAllValue');
    	 	
    	 	var jsonData = JSON.stringify(data)
    	 	
    	 	var blob = new Blob([jsonData], {type: "application/json;charset=utf-8"});
    	 	window.saveAs(blob, "nuoviValoriCampione.json");
    }
    function importAll(){
	    	var file = document.getElementById('importJsonValue').files[0];
	        if (file && file.type.match('application/json')) {
		   	 	var reader = new FileReader();
		     	reader.readAsText(file);
		     	reader.onload = function(e) {
		         // browser completed reading file - display it

		        		 var values = JSON.parse(e.target.result);
		        	   	
		         		for(var i = 0; i<values.length; i++){
		         			json.push(values[i]);
		         		}
		         		
		        	   	 /* $('#tblAppendGridAjax').appendGrid('load', 
		        	   		values
		        	     ); */
		        	     var x = $('#tblAppendGridAjax').appendGrid('appendRow', values);
		        	    
		        	   	 
		        	 	modificaValoriCampioneTrigger(umJson, null, "Ajax");
		        	 	
		        	 	
		        	 	
		        	 
 		        	 	$( ".tipograndezzeselect" ).each(function( index ) {
		        	 		
		        	 		var str = $(this).attr("id");
		        	  		var value = $(this).val();
		        	  		var resId = str.split("_");
		        	  		var select = $('#tblAppendGridAjax_unita_misura_'+resId[3]);   
		        			select.empty();
		        			
		        	  		if(value!=0 && value != null){	
		        	  			var umList = umJson[value];

		        	  			for (var j = 0; j < umList.length; j++){                 

		        	  				select.append("<option value='" +umList[j].value+ "'>" +umList[j].label+ "</option>");    
		        	  			}   
		        			}
		        	 	}); 
 		        	 	
 		        		 $('.select2MV').select2({
 		 				  	//	placeholder: "Seleziona",
 		 				  		dropdownCssClass: "select2MVOpt",  		
 		 				  	});

		     	};
	   	   
        }else{
        	
        		$("#myModalErrorContent").html("Formato File non supportato, inserire solo file .json esportati da questa tabella");

  		  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#myModalError').modal('show');
				
        }
 
	}
    
    
  </script>

</body>
</html>