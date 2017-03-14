

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
               <%
              ArrayList<InterventoDTO> listaInterventi= (ArrayList<InterventoDTO>)request.getSession().getAttribute("listaInterventi");
              
              %>
              
                <div onclick="explore('gestioneInterventoDati.do?idIntervento=<%=listaInterventi.get(0).getId() %>');"><h3><%=listaInterventi.get(0).getId() %></h3></div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
      </div>
 
</section>




