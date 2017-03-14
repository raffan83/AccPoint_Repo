

<!-- Content Header (Page header) -->
<%@page import="it.portaleSTI.DTO.InterventoDTO"%>
<%@page import="java.util.ArrayList"%>
    <section class="content-header">
      <h1>

        <small>
		
		</small>
      </h1>
    </section>

    <!-- Main content -->
    <section class="content">

	<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">

            </div>
            <!-- /.box-header -->
            <div class="box-body">
               Intervento Dati <%=request.getSession().getAttribute("intervento")%>
              
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
      </div>
 
</section>




