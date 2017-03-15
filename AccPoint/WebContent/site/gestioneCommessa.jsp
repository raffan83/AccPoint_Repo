

<!-- Content Header (Page header) -->
    <%@page import="it.portaleSTI.DTO.CommessaDTO"%>
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
              <%
              ArrayList<CommessaDTO> listaCommesse= (ArrayList<CommessaDTO>)request.getSession().getAttribute("listaCommesse");
              
              %>
              <div onclick="explore('gestioneIntervento.do?idCommessa=<%=listaCommesse.get(0).getID_COMMESSA() %>');"><h3><%=listaCommesse.get(0).getID_COMMESSA() %></h3></div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
      </div>
 
</section>




