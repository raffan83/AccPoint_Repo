
<%@ tag language="java" pageEncoding="UTF-8"%>
<!-- jQuery 2.2.3 -->
<script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="plugins/iCheck/icheck.min.js"></script> 
<script src="js/validator.js" type="text/javascript"></script>


 <script src="js/chosen.jquery.js" type="text/javascript"></script>
 <script src="js/prism.js" type="text/javascript" charset="utf-8"></script>
 
 <script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js" type="text/javascript" charset="utf-8"></script>
 <script src="https://cdn.datatables.net/1.10.13/js/dataTables.bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
 <script src="https://cdn.datatables.net/fixedcolumns/3.2.2/js/dataTables.fixedColumns.min.js"  type="text/javascript" charset="utf-8"></script>
 <script src="https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js"  type="text/javascript" charset="utf-8"></script>
 <script src="https://cdn.datatables.net/responsive/2.1.1/js/responsive.bootstrap.min.js"  type="text/javascript" charset="utf-8"></script>
 
   <script src="https://cdn.datatables.net/buttons/1.2.4/js/dataTables.buttons.min.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
   <script src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.24/build/pdfmake.min.js" type="text/javascript" charset="utf-8"></script>
   <script src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.24/build/vfs_fonts.js" type="text/javascript" charset="utf-8"></script>
   <script src="https://cdn.datatables.net/buttons/1.2.4/js/buttons.html5.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="https://cdn.datatables.net/buttons/1.2.4/js/buttons.colVis.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="https://cdn.datatables.net/buttons/1.2.4/js/buttons.bootstrap.min.js" type="text/javascript" charset="utf-8"></script>

	<script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js'></script>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment-with-locales.min.js'></script>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/locale/it.js'></script>
	<script src="//cdn.datatables.net/plug-ins/1.10.16/sorting/datetime-moment.js"></script>
 	<!-- <script src='plugins/fullcalendar/fullcalendar.min.js'></script> -->
	<script src='plugins/fullcalendar/fullcalendar.js'></script> 
	<!-- <script src='plugins/fullcalendar370/fullcalendar.js'></script>   -->
    <script src='plugins/fullcalendar370/fullcalendar.min.js'></script> 
	<script src='plugins/fullcalendar370/locale/it.js'></script>  
	<script src="plugins/select2/select2.full.min.js"></script>
	<script src="plugins/bignumbers/bignumber.min.js"></script>
	<script src="plugins/bignumbers/big.js"></script>
 	<script src="plugins/js-cookie/js.cookie.js"></script>
	<script src="plugins/tooltipster/dist/js/tooltipster.bundle.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/lodash@4.17.11/lodash.min.js"></script> 
 <script  src = "https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
 

<script src="plugins/iCheck/icheck.js"></script> 
<script src="plugins/datepicker/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.js"></script>
<script language="JavaScript" src="js/customFormSubmit.js"></script>

<!-- <meta http-equiv="cache-control" content="no-cache"> -->

<!--  <script src="js/scripts.js"></script> -->
 
 <script type="text/javascript" charset="utf-8">
document.write('<scr'+'ipt src="js/scripts.js?'+Math.random()+'" type="text/javascript" charset="utf-8"></scr'+'ipt>');
</script>
 
 
<script src="js/app.js"></script>

<script>
  $(function () {
		 $.fn.dataTable.moment( 'DD/MM/YYYY' );
     $('input').iCheck({
      checkboxClass: 'icheckbox_square-blue',
      radioClass: 'iradio_square-blue',
      increaseArea: '20%' // optional
    }); 
    $('#corpoframe').removeClass('loading');
    $('.customTooltip').tooltipster({
        theme: 'tooltipster-light'
    });
    
    $('.sidebar-toggle').on('click', function(e) {
	    	setTimeout(function(){ 
	    		
	    		tables =  $.fn.dataTable.tables({"api":true});	    	 
	    	    tables.columns.adjust().draw();
	    	
	    	}, 510);
	 
       
    });
    
  });
</script>