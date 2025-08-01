<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>

<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
	<%

	UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
	ArrayList<UtenteDTO> listaUtentiarr =(ArrayList<UtenteDTO>)request.getSession().getAttribute("listaUtenti");

	Gson gson = new Gson();
	JsonArray listaUtentiJson = gson.toJsonTree(listaUtentiarr).getAsJsonArray();
	request.setAttribute("listaUtentiJson", listaUtentiJson);
	request.setAttribute("utente", utente);


	//System.out.println("***"+listaUtentiJson);	
	%>
	
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
        Lista Utenti

      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
    <section class="content">

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
	 Lista
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
<div class="row">
<div class="col-lg-12">
<button class="btn btn-primary" onClick="nuovoInterventoFromModal('#modalNuovoUtente')">Nuovo Utente</button><div id="errorMsg" ></div>
</div>
</div>
 <div class="clearfix"></div>
<div class="row" style="margin-top:20px;">
<div class="col-lg-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th>ID</th>
 <th>Username</th>
 <th>e-mail</th>
  <th>Tipo Utente</th>
 <th>Nominativo</th>
 <th>Nome</th>
 <th>Cognome</th>
 <th>Indirizzo</th>
 <th>Comune</th>
 <th>Cap</th>
 <th>Telefono</th>
 <th>Abilitato</th>
 <th>Company</th>
  <th>Descrizione Company</th>
   <th>Cliente</th>
    <th>Sede</th>
    <th>ID Firma</th>
    <th>Area d'interesse</th>
    <th>Ultimo accesso</th>
  <th style="width:120px">Azioni</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaUtenti}" var="utente" varStatus="loop">

	 <tr role="row" id="${utente.id}-${loop.index}">

	<td>${utente.id}</td>
	<td>${utente.user}</td>
	<td>${utente.EMail}</td>
	<td><c:if test="${utente.tipoutente == 1}">Dipendente</c:if>  <c:if test="${utente.tipoutente == 2}"> Cliente</c:if></td>
	<td>${utente.nominativo}</td>
	<td>${utente.nome}</td>
	<td>${utente.cognome}</td>
	<td>${utente.indirizzo}</td>
	<td>${utente.comune}</td>
	<td>${utente.cap}</td>
	
	<td>${utente.telefono}</td>
	<td>
	<c:if test="${utente.abilitato == 0 }">
	NO
	</c:if>
	<c:if test="${utente.abilitato == 1 }">
	SI
	</c:if>
	</td>
	<td>${utente.company.denominazione}</td>
	<td>${utente.descrizioneCompany}</td>
	<td>${utente.idCliente}</td>
	<td>${utente.idSede}</td>
	<td>${utente.idFirma}</td>
	<td>
	<c:if test="${utente.area_interesse == 1 }">Tarature</c:if>
	<c:if test="${utente.area_interesse == 2 }">Rilievi dimensionali</c:if>
	<c:if test="${utente.area_interesse == 3 }">Corsi di Formazione</c:if>
	<c:if test="${utente.area_interesse == 4 }">Verificazione periodica</c:if>
	</td>
	<td> <fmt:formatDate value="${utente.ultimoAccesso}" pattern="dd/MM/yyyy HH:mm:ss" /> </td>
	<td>
	<c:if test="${utente.abilitato == 0}">
			<a href="#" onClick="toggleAbilitaUtente(${utente.id},1)" class="btn btn-success"><i class="fa fa-check-circle"></i></a> 
		</c:if>
		<c:if test="${utente.abilitato == 1}">
			<a href="#" onClick="toggleAbilitaUtente(${utente.id},0)" class="btn customTooltip btn-danger " title="Click per eliminare l'utente"><i class="fa fa-ban"></i></a> 
		</c:if>
		<a  onClick="modalModificaUtente('${utente.tipoutente}','${utente.id}','${utente.user}','${utente.nome}','${utente.cognome.replace('\'','&prime;')}','${utente.indirizzo.replace('\'','&prime;')}','${utente.comune.replace('\'','&prime;')}','${utente.cap}','${utente.EMail}','${utente.telefono}','${utente.company.id}','${utente.idCliente}','${utente.idSede}','${utente.abilitato}','${utente.idFirma}','${utente.trasversale}', '${utente.area_interesse }')" class="btn customTooltip btn-warning" title="Click per modificare l'utente"><i class="fa fa-edit"></i></a> 
		<%-- <a href="#" onClick="modalEliminaUtente('${utente.id}','${utente.nominativo}')" class="btn btn-danger "><i class="fa fa-remove"></i></a>	 --%>
		<c:if test="${utente.cv != null && utente.cv != ''}">
			<a href="#" onClick="callAction('gestioneUtenti.do?action=scaricacv&id=${utente.id}')" class="btn btn-danger "><i class="fa fa-file-pdf-o"></i></a> 
		</c:if>
		
		<c:if test="${utente.abilitato == 1}">
			<a href="#" onClick="inviaEmailAttivazione('${utente.id}')" class="btn btn-primary "><i class="fa fa-send"></i></a> 
		</c:if>
	
	</td>
	</tr>
	
	 
	</c:forEach>
 
	
 </tbody>
 </table>  
 </div>
</div>
</div>
</div>
</div>
</div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
 





  


<div id="modalNuovoUtente" class="modal  modal-fullscreen fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Utente</h4>
      </div>
      <form class="form-horizontal"  id="formNuovoUtente" autocomplete="off">
       <div class="modal-body">
       
<div class="nav-tabs-custom">
        <!--     <ul id="mainTabs" class="nav nav-tabs">
              <li class="active"><a href="#nuovoCampione" data-toggle="tab" aria-expanded="true"   id="nuovoCampioneTab">Dettaglio Campione</a></li>
              <li class=""><a href="#nuoviValori" data-toggle="tab" aria-expanded="false"   id="nuoviValoriTab">Valori Campione</a></li>

            </ul> -->
            <div class="tab-content">
              <div class="tab-pane  table-responsive active" id="nuovoUtente">

       <div class="form-group">
          <label for="tipoutente" class="col-sm-2 control-label">Tipo Utente:</label>

         <div class="col-sm-4">
         			   <select class="form-control required" id="tipoutente" name="tipoutente" required>
                       					<option value="">Seleziona tipo Utente</option>
                                           <option value="1">Dipendente</option>
                                           <option value="2">Cliente</option>
                      </select>
     	</div>
     	
   </div>
    
            
                <div class="form-group">
          <label for="user" class="col-sm-2 control-label">Username:</label>

         <div class="col-sm-4">
         			<input class="form-control" id="user" type="text" name="user" value="" required />
     	</div>
     	 <label for="passw" class="col-sm-2 control-label">Password:</label>

         <div class="col-sm-4">
         			<input class="form-control" id="passw" type="text" name="passw" value="" required autocomplete="off" />
     	</div>
   </div>
    
 <div class="form-group">
          <label for="nome" class="col-sm-2 control-label">Abilitato:</label>

         <div class="col-sm-10">
 			<input class="form-control" id="abilitato" type="checkbox" name="abilitato" value="1" />		
     	</div>
   </div>
   
    <div class="form-group">
          <label for="nome" class="col-sm-2 control-label">Trasversale:</label>

         <div class="col-sm-10">
 			<input class="form-control" id="trasversale" type="checkbox" name="trasversale" value="1" />		
     	</div>
   </div>

    <div class="form-group">
          <label for="nome" class="col-sm-2 control-label">Nome:</label>

         <div class="col-sm-10">
         			<input class="form-control" id="nome" type="text" name="nome" value="" required />
         
			
     	</div>
   </div>

   <div class="form-group">
        <label for="cognome" class="col-sm-2 control-label">Cognome:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="cognome" type="text" name="cognome"  value="" required/>
    </div>
    </div>
    
    <div class="form-group">
        <label for="indirizzo" class="col-sm-2 control-label">Indirizzo:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="indirizzo" type="text" name="indirizzo"  value="" required/>
    </div>
    </div>
    <div class="form-group">
        <label for="comune" class="col-sm-2 control-label">Comune:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="comune" type="text" name="comune"  value="" required/>
    </div>
    </div>
    <div class="form-group">
        <label for="cap" class="col-sm-2 control-label">CAP:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="cap" type="text" name="cap"  value="" required/>
    </div>
    </div>
    <div class="form-group">
        <label for="email" class="col-sm-2 control-label">E-mail:</label>
        <div class="col-sm-10">
                      <input class="form-control required" type="email" id="email" type="text" name="email"  value="" required/>
    </div>
    </div>
     <div class="form-group">
        <label for="telefono" class="col-sm-2 control-label">Telefono:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="telefono" type="text" name="telefono"  value="" required/>
    </div>
     </div>
     <div class="form-group">
        <label for="idFirma" class="col-sm-2 control-label">ID Firma:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="idFirma" type="text" name="idFirma"  value=""/>
    </div>
     </div>
       <div class="form-group">
        <label for="comnpany" class="col-sm-2 control-label">Company:</label>
        <div class="col-sm-10">
                     
					   <select class="form-control required select2" id="company" name="company" required>
					  <c:if test="${userObj.isTras() || userObj.checkRuolo('AM')}">    
					   
                       					<option value="">Seleziona una Company</option>
                                            <c:forEach items="${listaCompany}" var="company" varStatus="loop">

 												<option value="${company.id}">${company.denominazione}</option>
	 
											</c:forEach>
                        </c:if>
                        <c:if test="${!userObj.isTras() && !userObj.checkRuolo('AM')}">    
                             <option value="${userObj.company.id}">${userObj.company.denominazione}</option>
                         </c:if>           
                      </select>
                      
                      
    </div>
     </div>
   
   <div id="clienteblock">
         <div class="form-group">
        <label for="cliente" class="col-sm-2 control-label">Cliente:</label>
        <div class="col-sm-10">
                      
			
                      
                      <select id="cliente" data-placeholder="Seleziona Cliente..."  class="form-control select2" aria-hidden="true" data-live-search="true" disabled name="cliente"  >
	                    <option value="">Seleziona un Cliente</option>
	                      <c:forEach items="${listaClienti}" var="cliente">
	                           <option value="${cliente.__id}">${cliente.nome}</option> 
	                     </c:forEach>
	
	                  </select>
                      
                      
    </div>
     </div>
     
          <div class="form-group">
        <label for="sede" class="col-sm-2 control-label">Sede:</label>
        <div class="col-sm-10">
                     
					   <select class="form-control select2" id="sede" name="sede" data-placeholder="Seleziona Sede"  disabled aria-hidden="true" data-live-search="true"  >
                       					<option value="">Seleziona Sede</option>
                                            <c:forEach items="${listaSedi}" var="sedi" varStatus="loop">

 												<option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option>       
	 
											</c:forEach>
                        
                                            
                      </select>
       
                      
                      
    </div>
     
     </div>
    	 </div> 
    	 
    	     <div class="form-group" id="curriculumdiv">
        <label class="col-sm-2 control-label">Area d'interesse:</label>
        <div class="col-sm-10">
              <select class="form-control select2" title="Seleziona area di interesse" id="area_interesse" name="area_interesse">
                      <option value=""></option>
                      <option value="1">Tarature</option>
                      <option value="2">Rilievi dimensionali</option>
                      <option value="3">Corsi di Formazione</option>
                      <option value="4">Verificazione periodica</option>
                      </select>
    </div>
     </div>
    	 
    <div class="form-group" id="curriculumdiv">
        <label for="curriculum" class="col-sm-2 control-label">Curriculum:</label>
        <div class="col-sm-10">
                      <input accept="application/pdf" class="form-control" id="curriculum" type="file" name="curriculum"  value="" />
    </div>
     </div>
     
     

       
	 </div>

              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
        
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
			<span id="ulError" class="pull-left"></span><button type="submit" class="btn btn-danger" >Salva</button>
      </div>
        </form>
    </div>
  </div>
</div>


<div id="modalModificaUtente" class="modal  modal-fullscreen fade" role="dialog" aria-labelledby="myLargeModalLabel" >
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Utente</h4>
      </div>
      <form class="form-horizontal"  id="formModificaUtente" >
       <div class="modal-body">
       
<div class="nav-tabs-custom">
        <!--     <ul id="mainTabs" class="nav nav-tabs">
              <li class="active"><a href="#nuovoCampione" data-toggle="tab" aria-expanded="true"   id="nuovoCampioneTab">Dettaglio Campione</a></li>
              <li class=""><a href="#nuoviValori" data-toggle="tab" aria-expanded="false"   id="nuoviValoriTab">Valori Campione</a></li>

            </ul> -->
            <div class="tab-content">
              <div class="tab-pane  table-responsive active" id="modificaUtente">

         			<input class="form-control" id="modid" name="modid" value="" type="hidden" />
        
             <div class="form-group">
          <label for="modtipoutente" class="col-sm-2 control-label">Tipo Utente:</label>

         <div class="col-sm-4">
         			   <select class="form-control required" id="modtipoutente" name="modtipoutente" required>
                       					<option value="">Seleziona tipo Utente</option>
                                           <option value="1">Dipendente</option>
                                           <option value="2">Cliente</option>
                      </select>
     	</div>
     	
   </div>
            
                <div class="form-group">
          <label for="moduser" class="col-sm-2 control-label">Username:</label>

         <div class="col-sm-4">
         			<input class="form-control" id="moduser" type="text" name="moduser" value=""  />
     	</div>
     	<!--  <label for="modpassw" class="col-sm-2 control-label">Password:</label>

          <div class="col-sm-4">
         			<input class="form-control" id="modpassw" type="password" name="modpassw" value=""  autocomplete="off"/>
     	</div>  -->
     	 <a class="btn btn-primary" onClick="modalCambioPassword()">Cambia Password</a> 
   </div>
    
 <div class="form-group">
          <label for="nome" class="col-sm-2 control-label">Abilitato:</label>

         <div class="col-sm-4">
         
    
 			    <c:if test="${utente.abilitato == 0}">
			<input class="form-control" id="modabilitato" type="checkbox" name="modabilitato" value="1" />
		</c:if>
		<c:if test="${utente.abilitato == 1}">
			<input class="form-control" id="modabilitato" type="checkbox" name="modabilitato" value="1" checked />
		</c:if>
			
     	</div>
     	</div>
     	 <div class="form-group">
          <label for="nome" class="col-sm-2 control-label">Trasversale:</label>

         <div class="col-sm-4">
         
    
 			    <c:if test="${utente.trasversale == 0}">
			<input class="form-control" id="modtrasversale" type="checkbox" name="modtrasversale" value="1" />
		</c:if>
		<c:if test="${utente.trasversale == 1}">
			<input class="form-control" id="modtrasversale" type="checkbox" name="modtrasversale" value="1" checked />
		</c:if>
         			
          			
         
			
     	</div>
   </div>

    <div class="form-group">
          <label for="modnome" class="col-sm-2 control-label">Nome:</label>

         <div class="col-sm-10">
         			<input class="form-control" id="modnome" type="text" name="modnome" value=""  />
         
			
     	</div>
   </div>

   <div class="form-group">
        <label for="modcognome" class="col-sm-2 control-label">Cognome:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="modcognome" type="text" name="modcognome"  value="" />
    </div>
    </div>
    
    <div class="form-group">
        <label for="modindirizzo" class="col-sm-2 control-label">Indirizzo:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="modindirizzo" type="text" name="modindirizzo"  value="" />
    </div>
    </div>
    <div class="form-group">
        <label for="modcomune" class="col-sm-2 control-label">Comune:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="modcomune" type="text" name="modcomune"  value="" />
    </div>
    </div>
    <div class="form-group">
        <label for="modcap" class="col-sm-2 control-label">CAP:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="modcap" type="text" name="modcap"  value="" />
    </div>
    </div>
    <div class="form-group">
        <label for="modemail" class="col-sm-2 control-label">E-mail:</label>
        <div class="col-sm-10">
                      <input class="form-control required" type="modemail" id="modemail" type="text" name="modemail"  value="" />
    </div>
    </div>
     <div class="form-group">
        <label for="modtelefono" class="col-sm-2 control-label">Telefono:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="modtelefono" type="text" name="modtelefono"  value="" />
    </div>
     </div>
  <div class="form-group">
        <label for="modidFirma" class="col-sm-2 control-label">ID Firma:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="modidFirma" type="text" name="modidFirma"  value=""/>
    </div>
     </div>
       <div class="form-group">
        <label for="modcomnpany" class="col-sm-2 control-label">Company:</label>
        <div class="col-sm-10">
                     
					   <select class="form-control required select2" id="modcompany" name="modcompany" >
                       					<option value="">Seleziona una Company</option>
                                            <c:forEach items="${listaCompany}" var="company" varStatus="loop">

 												<option value="${company.id}">${company.denominazione}</option>
	 
											</c:forEach>
                        
                                            
                      </select>
                      
                      
    </div>
     </div>
       <div id="modclienteblock">
         <div class="form-group">
        <label for="modcliente" class="col-sm-2 control-label">Cliente:</label>
        <div class="col-sm-10">
                      <select name="cliente_appoggio" id="cliente_appoggio" class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%;display:none" >
              
                      <c:forEach items="${lista_clienti}" var="cliente">
                     
                           <option value="${cliente.__id}">${cliente.nome}</option> 
                         
                     </c:forEach>

                  </select> 
			
                      <input class="form-control" data-placeholder="Seleziona Cliente..." id="modcliente" name="modcliente" style="width:100%" >
                   <!--    <select id="modcliente" data-placeholder="Seleziona Cliente..."  class="form-control select2" aria-hidden="true" data-live-search="true" name="modcliente" disabled  >
	                    <option value="">Seleziona un Cliente</option>
	                    
	
	                  </select> -->
                      
                      
    </div>
     </div>
     
          <div class="form-group">
        <label for="modsede" class="col-sm-2 control-label">Sede:</label>
        <div class="col-sm-10">
                     
					   <select class="form-control select2" id="modsede" name="modsede" data-placeholder="Seleziona Sede..."  disabled  aria-hidden="true" data-live-search="true"  >
                       					<!-- <option value="">Seleziona Sedell</option>  -->
                                           
                        
                                            
                      </select>
       
                      
                      
    </div>
     </div>
     
        </div> 
        
            	     <div class="form-group" id="curriculumdiv">
        <label class="col-sm-2 control-label">Area d'interesse:</label>
        <div class="col-sm-10">
              <select class="form-control select2" title="Seleziona area di interesse" id="modarea_interesse" name="modarea_interesse" required>
                      <option value=""></option>
                      <option value="1">Tarature</option>
                      <option value="2">Rilievi dimensionali</option>
                      <option value="3">Corsi di Formazione</option>
                      <option value="4">Verificazione periodica</option>
                      </select>
    </div>
     </div>
        
     <div class="form-group" id="modcurriculumdiv">
        <label for="modcurriculum" class="col-sm-2 control-label">Curriculum:</label>
        <div class="col-sm-10">
                      <input accept="application/pdf"  class="form-control" id="modcurriculum" type="file" name="modcurriculum"  value=""/>
    </div>
     </div>
     
     
	 </div>

              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
			<span id="ulError" class="pull-left"></span><button type="submit" class="btn btn-danger" >Salva</button>
      </div>
        </form>
    </div>
  </div>
</div>

<div id="modalEliminaUtente" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="">
		     
			<input class="form-control" id="idElimina" name="idElimina" value="" type="hidden" />
		
			Sei Sicuro di voler eliminare l'utente <span id="nominativoElimina"></span>
        
        
  		 </div>
      
    </div>
    <div class="modal-footer">
    	<button type="button" class="btn btn-default pull-left" data-dismiss="modal">Annulla</button>
    	<button type="button" class="btn btn-danger" onClick="eliminaUtente()">Elimina</button>
    </div>
  </div>
    </div>

</div>



<div id="myModalCambiaPassword" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Password </h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="">
		     <label>Nuova Password</label>
			<input class="form-control" id="mod_passw" name="mod_passw" value="" type="password" autocomplete="new-password"/>
		
			 <label>Conferma Nuova Password</label>
			<input class="form-control" id="conf_modpassw" name="conf_modpassw" value="" type="password" />
        
        
  		 </div>
      
    </div>
    <div class="modal-footer">
    <label id="label_conferma_pass" style="display:none;color:red" class="pull-left"></label>
    	<a  class="btn btn-default pull-right" onClick="controllaPassword()">Salva</a>
    
    </div>
  </div>
    </div>

</div>



<!-- <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
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

</div> -->
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
	<script src="plugins/jquery.appendGrid/jquery.appendGrid-1.6.3.js"></script>
	<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>

<script type="text/javascript">



   </script>

  <script type="text/javascript">

  function controllaPassword(){
	  
	  $('#label_conferma_pass').hide();
	  
	  var password = $('#mod_passw').val();
	  var conf_password = $('#conf_modpassw').val();
	  var id_utente = $('#modid').val();
	  
	  if(password==conf_password){
		  if(validPassword(password)){
			  cambaPasswordUtente(password, id_utente);
		  }else{
			  $('#label_conferma_pass').html("Attenzione! La password deve contenere solo lettere maiuscole,minuscole e numeri, ed avere una lunghezza superiore a 8 caratteri")
			  $('#label_conferma_pass').show();
		  }
		  
	  }else{
		  $('#label_conferma_pass').html("Errore Conferma Password, accertarsi di aver inserito la stessa Password")
		  $('#label_conferma_pass').show();
	  }
  }
  
  
  function modalCambioPassword(){
	  $('#myModalCambiaPassword').modal()
  }
  
  
	var columsDatatables = [];
	 
	$("#tabPM").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabPM thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	        var title = $('#tabPM thead th').eq( $(this).index() -1 ).text();
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" value="'+columsDatatables[$(this).index()].search.search+'" autocomplete="new-password"/></div>');
	    } );

	} );

  
    $(document).ready(function() {
     	//$(".select2").select2({"width":"100%"});
     	
     	$('#modsede').select2({"width":"100%"});
     	$('#company').select2({"width":"100%"});
    	$('#modcompany').select2({"width":"100%"});
     	$('#sede').select2({"width":"100%"});
     	$('#area_interesse').select2({"width":"100%"});
     	$('#modarea_interesse').select2({"width":"100%"});
     	
     	initSelect2("#cliente");
     	
    	$("#clienteblock").hide();
    	$("#modclienteblock").hide();
    	$("#modcurriculumdiv").show();
    	$("#curriculumdiv").show();
    $("#tipoutente").change(function() {
     		var tipoutente = $("#tipoutente").val();
     		if(tipoutente==1){
     		 	$("#clienteblock").hide();
     		 	$("#curriculumdiv").show();
     		}else{
     		 	$("#clienteblock").show();
     		 	$("#curriculumdiv").hide();
     		}
    });
	$("#modtipoutente").change(function() {
		var tipoutente = $("#modtipoutente").val();
		if(tipoutente==1){
 		 	$("#modclienteblock").hide();
 		 	$("#modcurriculumdiv").show();
 		}else{
 		 	$("#modclienteblock").show();
 		 	$("#modcurriculumdiv").hide();
 		}
     });
	
	$("#company").change(function() {
		var tipoutente = $("#tipoutente").val();
		//if(tipoutente==2){
			var valore = $("#company").val();
			updateSelectClienti("new",tipoutente,valore);
		//}
     });
	$("#modcompany").change(function() {
		var tipoutente = $("#modtipoutente").val();
		//if(tipoutente==2){
			var valore = $("#company").val();
			var idUtente = $("#modid").val();
			updateSelectClienti("mod",tipoutente,valore,idUtente);

 		//}

     });
	
    	$("#cliente").change(function() {
		    
		  	  if ($(this).data('options') == undefined) 
		  	  {
		  	    $(this).data('options', $('#sede option').clone());
		  	  }
		  	  
		  	  var id = $(this).val();
		  	 
		  	  var options = $(this).data('options');
	
		  	  var opt=[];
		  	
		  	  opt.push("<option value = 0>Non Associate</option>");
	
		  	   for(var  i=0; i<options.length;i++)
		  	   {
		  		var str=options[i].value; 
		  	
		  		if(str.substring(str.indexOf("_")+1,str.length)==id)
		  		{
		  		 
		  			opt.push(options[i]);
		  		}   
		  	   }
		  	 $("#sede").prop("disabled", false);
		  	 
		  	  $('#sede').html(opt);
		  	  
		  	  $("#sede").trigger("chosen:updated");
		  	  
		 
		  		$("#sede").change();  
	 
		  	  
		  	
		});
    	 $("#modcliente").change(function() {
		   
    		 
    		 
		  	  if ($(this).data('options') == undefined) 
		  	  {
		  	    $(this).data('options', $('#modsede option').clone());
		  	  }
		  	  
		  	  var id = $(this).val();
		  	 
		  	  var options = $(this).data('options');
	
		  	  var opt=[];
		  	
		  	  opt.push("<option value = 0>Tutte le sedi</option>");
	
		  	   for(var  i=0; i<options.length;i++)
		  	   {
		  		var str=options[i].value; 
		  	
		  		if(str.substring(str.indexOf("_")+1,str.length)==id)
		  		{
		  		 
		  			opt.push(options[i]);
		  		}   
		  	   }
		  	 $("#modsede").prop("disabled", false);
		  	 
		  	  $('#modsede').html(opt);
		  	  
		  	  $("#modsede").trigger("chosen:updated");
		  	  
		 
		  		$("#modsede").change();  
	 
		  		$('#modsede option[value="0"]').attr('selected', true);
		  	
		}); 

    	table = $('#tabPM').DataTable({
    		language: {
  	        	emptyTable : 	"Nessun dato presente nella tabella",
  	        	info	:"Vista da _START_ a _END_ di _TOTAL_ elementi",
  	        	infoEmpty:	"Vista da 0 a 0 di 0 elementi",
  	        	infoFiltered:	"(filtrati da _MAX_ elementi totali)",
  	        	infoPostFix:	"",
  	        infoThousands:	".",
  	        lengthMenu:	"Visualizza _MENU_ elementi",
  	        loadingRecords:	"Caricamento...",
  	        	processing:	"Elaborazione...",
  	        	search:	"Cerca:",
  	        	zeroRecords	:"La ricerca non ha portato alcun risultato.",
  	        	paginate:	{
	  	        	first:	"Inizio",
	  	        	previous:	"Precedente",
	  	        	next:	"Successivo",
	  	        last:	"Fine",
  	        	},
  	        aria:	{
	  	        	srtAscending:	": attiva per ordinare la colonna in ordine crescente",
	  	        sortDescending:	": attiva per ordinare la colonna in ordine decrescente",
  	        }
	        },
	        pageLength: 100,
  	      paging: true, 
  	      ordering: true,
  	      info: true, 
  	      searchable: false, 
  	      targets: 0,
  	      responsive: true,
  	      scrollX: false,
  	    stateSave: true,
  	      columnDefs: [
				       { responsivePriority: 1, targets: 0 },
  	                   { responsivePriority: 2, targets: 1 },
  	                   { responsivePriority: 3, targets: 2 },
  	                   { responsivePriority: 4, targets: 6 },
  	                   { responsivePriority: 5, targets: 19 },
  	                  { responsivePriority: 6, targets: 10 },
  	                { responsivePriority: 7, targets: 11 },
  	               ],
  	     
  	               buttons: [ {
  	                   extend: 'copy',
  	                   text: 'Copia',
  	                   /* exportOptions: {
	                       modifier: {
	                           page: 'current'
	                       }
	                   } */
  	               },{
  	                   extend: 'excel',
  	                   text: 'Esporta Excel',
  	                   /* exportOptions: {
  	                       modifier: {
  	                           page: 'current'
  	                       }
  	                   } */
  	               },
  	               {
  	                   extend: 'colvis',
  	                   text: 'Nascondi Colonne'
  	                   
  	               }
  	              /*  ,
  	               {
  	             		text: 'I Miei Strumenti',
                 		action: function ( e, dt, node, config ) {
                 			explore('listaCampioni.do?p=mCMP');
                 		},
                 		 className: 'btn-info removeDefault'
    				},
  	               {
  	             		text: 'Tutti gli Strumenti',
                 		action: function ( e, dt, node, config ) {
                 			explore('listaCampioni.do');
                 		},
                 		 className: 'btn-info removeDefault'
    				} */
  	                         
  	          ]
  	    	
  	      
  	    });
    	
  	table.buttons().container().appendTo( '#tabPM_wrapper .col-sm-6:eq(1)');
  
 
  $('.inputsearchtable').on('click', function(e){
	    e.stopPropagation();    
	 });
  // DataTable
	table = $('#tabPM').DataTable();
  // Apply the search
  table.columns().eq( 0 ).each( function ( colIdx ) {
      $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
          table
              .column( colIdx )
              .search( this.value )
              .draw();
      } );
  } ); 
  	table.columns.adjust().draw();
    	

	$('#tabPM').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
	  } );
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	})
    	
    	
    	if (!$.fn.bootstrapDP && $.fn.datepicker && $.fn.datepicker.noConflict) {
		   var datepicker = $.fn.datepicker.noConflict();
		   $.fn.bootstrapDP = datepicker;
		}

	$('.datepicker').bootstrapDP({
		format: "dd/mm/yyyy",
	    startDate: '-3d'
	});

	$('#formNuovoUtente').on('submit',function(e){
		
		$("#ulError").html("");
	    e.preventDefault();
	    nuovoUtente();

	});
   
	$('#formModificaUtente').on('submit',function(e){
		
		$("#ulError").html("");
	    e.preventDefault();
	    modificaUtente();

	}); 
	
	
    $("#curriculum").on('change', function(event) {
        var file = event.target.files[0];
    
        if(!file.type.match('application/pdf')) {
            $('#myModalErrorContent').html("Inserire solo file in formato .pdf");
			  	$('#myModalError').removeClass();
  				$('#myModalError').addClass("modal modal-danger");
  				$('#myModalError').modal('show');
            $("#schedaTecnica").val(''); //the tricky part is to "empty" the input file here I reset the form.
            return false;
        }

      
    });
    
    $("#modcurriculum").on('change', function(event) {
        var file = event.target.files[0];
    
        if(!file.type.match('application/pdf')) {
            $('#myModalErrorContent').html("Inserire solo file in formato .pdf");
			  	$('#myModalError').removeClass();
  				$('#myModalError').addClass("modal modal-danger");
  				$('#myModalError').modal('show');
            $("#schedaTecnica").val(''); //the tricky part is to "empty" the input file here I reset the form.
            return false;
        }

      
    });
	
	      
	    });


	    var validator = $("#formNuovoUtente").validate({
	    	showErrors: function(errorMap, errorList) {
	    	  
	    	    this.defaultShowErrors();
	    	  },
	    	  errorPlacement: function(error, element) {
	    		  $("#ulError").html("<span class='label label-danger'>Compilare correttamente tutti i campi</span>");
	    		 },
	    		 
	    		    highlight: function(element) {
	    		        $(element).closest('.form-group').addClass('has-error');
	    		        $(element).closest('.ui-widget-content input').addClass('error');
	    		        
	    		    },
	    		    unhighlight: function(element) {
	    		        $(element).closest('.form-group').removeClass('has-error');
	    		        $(element).closest('.ui-widget-content input').removeClass('error');
	    		       
	    		    }
	    });

	  
	
	
	    $('#myModalError').on('hidden.bs.modal', function (e) {
			if($( "#myModalError" ).hasClass( "modal-success" )){
				 pleaseWaitDiv = $('#pleaseWaitDialog');
				  pleaseWaitDiv.modal();
				callAction("listaUtenti.do");
			}
 		
  		});
	    
	    
	    
	    
	    function mockData() {
	    	var options =  $('#cliente_appoggio option').clone();
	    	  return _.map(options, function(i) {		  
	    	    return {
	    	      id: i.value,
	    	      text: i.text,
	    	    };
	    	  });
	    	}
	    	


	    function initSelect2(id_input) {
	   	 
	

	    	$(id_input).select2({
	    	    data: mockData(),
	    	    placeholder: 'search',
	    	    multiple: false,
	    	    // query with pagination
	     	    query: function(q) {
	    	      var pageSize,
	    	        results,
	    	        that = this;
	    	      pageSize = 20; // or whatever pagesize
	    	      results = [];
	    	      if (q.term && q.term !== '') {
	    	        // HEADS UP; for the _.filter function i use underscore (actually lo-dash) here
	    	        results = _.filter( function(e) {
	    	        	
	    	          return e.text.toUpperCase().indexOf(q.term.toUpperCase()) >= 0;
	    	        });
	    	      } else if (q.term === '') {
	    	        results = that.data;
	    	      }
	    	      q.callback({
	    	        results: results.slice((q.page - 1) * pageSize, q.page * pageSize),
	    	        more: results.length >= q.page * pageSize,
	    	      });
	    	    }, 
	    	  });
	    	
	    	
	    }
	    

  </script>
</jsp:attribute> 
</t:layout>
  
 
