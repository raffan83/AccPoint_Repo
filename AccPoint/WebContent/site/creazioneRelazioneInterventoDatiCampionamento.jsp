<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

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
        Creazione Relazione
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
	Informazioni Intervento
	<div class="box-tools pull-right">

		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
               
             
   
                <li class="list-group-item">
                  <b>Data Creazione</b> <a class="pull-right">
	
		  	<c:if test="${not empty interventoCampionamento.dataCreazione}">
   				<fmt:formatDate pattern="dd/MM/yyyy" value="${interventoCampionamento.dataCreazione}" />
			</c:if>  
		</a>
                </li>
                
                <li class="list-group-item">
                  <b>Date Intervento</b> <a class="pull-right">
	
 			   				dal <fmt:formatDate pattern="dd/MM/yyyy" value="${interventoCampionamento.dataInizio}" /> al <fmt:formatDate pattern="dd/MM/yyyy" value="${interventoCampionamento.dataFine}" />
 					</a>
                </li>
                
               
                <li class="list-group-item">
                  <b>Responsabile</b> <a class="pull-right">${interventoCampionamento.user.nominativo}</a>
                </li>
                
                 <li class="list-group-item">
                  <b>Lista Attività</b>
                  <div class=" list-group-no-border" >
                    <c:set var = "values" value = "${fn:split(interventoCampionamento.idAttivita, '|')}" />
                   <c:forEach items="${values}" var="it" varStatus="loop"><div class="list-group-item"><a class="">${it}</a></div></c:forEach>
                   	</div>
                </li>
                
                 
                <li class="list-group-item">
                  <b>Scheda Campionamento</b>  
     						<a href="scaricaSchedaCampionamento.do?action=schedaCampionamento&nomePack=${interventoCampionamento.nomePack}" id="downloadScheda" class="pull-right btn btn-info"><i class="glyphicon glyphicon-download"></i> Download Scheda</a>
	              	 
		 			<div class="spacer" style="clear: both;"></div>
                </li>
                
              
               
        </ul>
  
	</div>
</div>
</div>
</div>      
            
      <div class="row">
<div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	Relazione
	<div class="box-tools pull-right">

		<!-- <button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button> -->

	</div>
</div>
	<div class="box-body">

                     <textarea id="editor1" name="editor1" rows="30" cols="80">
                                            
                    </textarea>
 
  
	</div>
	<div class="box-footer">

			<button class="btn btn-default pull-right" onClick="salvaRelazione(${interventoCampionamento.id})" >Salva</button>
  
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




  <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
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


<script src="plugins/ckeditor/ckeditor.js"></script>

 <script type="text/javascript">
   
 
    $(document).ready(function() { 
    	
 
    	CKEDITOR.replace( 'editor1', {
    		// Define the toolbar: http://docs.ckeditor.com/#!/guide/dev_toolbar
    		// The full preset from CDN which we used as a base provides more features than we need.
    		// Also by default it comes with a 3-line toolbar. Here we put all buttons in a single row.
    		toolbar: [
    			{ name: 'document', items: [ 'Print' ] },
    			{ name: 'clipboard', items: [ 'Undo', 'Redo' ] },
    			{ name: 'styles', items: [ 'Format', 'Font', 'FontSize' ] },
    			{ name: 'basicstyles', items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'CopyFormatting' ] },
    			{ name: 'colors', items: [ 'TextColor', 'BGColor' ] },
    			{ name: 'align', items: [ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ] },
    			{ name: 'links', items: [ 'Link', 'Unlink' ] },
    			{ name: 'paragraph', items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote' ] },
    			{ name: 'insert', items: [ 'Table' ] },
    			{ name: 'tools', items: [ 'Maximize' ] },
    			{ name: 'editing', items: [ 'Scayt' ] }
    		],
    		// Since we define all configuration options here, let's instruct CKEditor to not load config.js which it does by default.
    		// One HTTP request less will result in a faster startup time.
    		// For more information check http://docs.ckeditor.com/#!/api/CKEDITOR.config-cfg-customConfig
    	
    		// Sometimes applications that convert HTML to PDF prefer setting image width through attributes instead of CSS styles.
    		// For more information check:
    		//  - About Advanced Content Filter: http://docs.ckeditor.com/#!/guide/dev_advanced_content_filter
    		//  - About Disallowed Content: http://docs.ckeditor.com/#!/guide/dev_disallowed_content
    		//  - About Allowed Content: http://docs.ckeditor.com/#!/guide/dev_allowed_content_rules
    		disallowedContent: 'img{width,height,float}',
    		extraAllowedContent: 'img[width,height,align]',
    		// Enabling extra plugins, available in the full-all preset: http://ckeditor.com/presets-all
    		extraPlugins: '',
    		/*********************** File management support ***********************/
    		// In order to turn on support for file uploads, CKEditor has to be configured to use some server side
    		// solution with file upload/management capabilities, like for example CKFinder.
    		// For more information see http://docs.ckeditor.com/#!/guide/dev_ckfinder_integration
    		// Uncomment and correct these lines after you setup your local CKFinder instance.
    		// filebrowserBrowseUrl: 'http://example.com/ckfinder/ckfinder.html',
    		// filebrowserUploadUrl: 'http://example.com/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Files',
    		/*********************** File management support ***********************/
    		// Make the editing area bigger than default.
    		height: 800,
    		// An array of stylesheets to style the WYSIWYG area.
    		// Note: it is recommended to keep your own styles in a separate file in order to make future updates painless.
    		contentsCss: [ 'https://cdn.ckeditor.com/4.7.3/full-all/contents.css', 'css/style.css' ],
     		// This is optional, but will let us define multiple different styles for multiple editors using the same CSS file.
    		bodyClass: 'document-editor',
    		// Reduce the list of block elements listed in the Format dropdown to the most commonly used.
    		format_tags: 'p;h1;h2;h3;pre',
    		// Simplify the Image and Link dialog windows. The "Advanced" tab is not needed in most cases.
    		removeDialogTabs: 'image:advanced;link:advanced',
    		// Define the list of styles which should be available in the Styles dropdown list.
    		// If the "class" attribute is used to style an element, make sure to define the style for the class in "mystyles.css"
    		// (and on your website so that it rendered in the same way).
    		// Note: by default CKEditor looks for styles.js file. Defining stylesSet inline (as below) stops CKEditor from loading
    		// that file, which means one HTTP request less (and a faster startup).
    		// For more information see http://docs.ckeditor.com/#!/guide/dev_styles
    		stylesSet: [
			/* Inline Styles */
			{ name: 'Marker', element: 'span', attributes: { 'class': 'marker' } },
			{ name: 'Cited Work', element: 'cite' },
			{ name: 'Inline Quotation', element: 'q' },
			/* Object Styles */
			{
				name: 'Special Container',
				element: 'div',
				styles: {
					padding: '5px 10px',
					background: '#eee',
					border: '1px solid #ccc'
				}
			},
			{
				name: 'Compact table',
				element: 'table',
				attributes: {
					cellpadding: '3',
					cellspacing: '0',
					border: '1',
					bordercolor: '#ccc'
				},
				styles: {
					'border-collapse': 'collapse'
				}
			},
			{ name: 'Borderless Table', element: 'table', styles: { 'border-style': 'hidden', 'background-color': '#E6E6FA' } },
			{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } }
		]
    		
    	} );
    
    		
    });
    function salvaRelazione(id){

    		var objEditor1 = CKEDITOR.instances["editor1"].getData();

    		  var params =  { 'data': objEditor1 };
    	        $.ajax({
    	            type: 'POST',
    	            url: "creazioneRelazioneCampionamento.do?action=gerneraRelazioneCampionamento&idIntervento="+id,
    	            data: params,
    	            dataType: "json",
    	            success: function(data) {
    	                $("#show_tree").html(data);

    	            },
    	            error: function(req, status, error) { }
    	        });
	}
  </script>
</jsp:attribute> 
</t:layout>







