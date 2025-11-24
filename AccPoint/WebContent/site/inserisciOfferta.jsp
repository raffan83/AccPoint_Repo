<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
         Esempio REST call
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Esempio REST call
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

    <h2>Esempio chiamata REST POST da JSP</h2>

    <button onclick="somma()">Somma 2 + 3</button>

    <p id="risultato" style="margin-top: 20px; font-weight: bold;"></p>

</div><br>

</div>

 
</div>
</div>

</section>
</div>
   <t:dash-footer />
   
  <t:control-sidebar />
</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />

<style>
      .img-container {
            max-width: 200px;
            max-height: 200px;
            overflow: hidden;
        }
        .img-container img {
            width: 100%;
            height: auto;
        }
        
        .table th input {
    min-width: 45px !important;
}

</style>
</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">

function somma() {
    const payload = {
        expr: ["2+3"]
    };
    
    
    
    const dataObj = {
    		"info": {
    			"_postman_id": "ad52f7c9-4def-4f84-8db3-f8424aa5966e",
    			"name": "Clienti",
    			"schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json",
    			"_exporter_id": "33161115"
    		},
    		"item": [
    			{
    				"name": "NCS",
    				"item": [
    					{
    						"name": "Lettura aziende",
    						"request": {
    							"auth": {
    								"type": "basic",
    								"basic": [
    									{
    										"key": "password",
    										"value": "{{NCS_PasswordAgente}}",
    										"type": "string"
    									},
    									{
    										"key": "username",
    										"value": "{{NCS_UtenteAgente}}",
    										"type": "string"
    									}
    								]
    							},
    							"method": "GET",
    							"header": [],
    							"url": {
    								"raw": "{{NCS_baseUrl}}/sync/aziende?data=19700101",
    								"host": [
    									"{{NCS_baseUrl}}"
    								],
    								"path": [
    									"sync",
    									"aziende"
    								],
    								"query": [
    									{
    										"key": "data",
    										"value": "19700101"
    									}
    								]
    							}
    						},
    						"response": []
    					},
    					{
    						"name": "Lettura articoli",
    						"request": {
    							"auth": {
    								"type": "basic",
    								"basic": [
    									{
    										"key": "password",
    										"value": "{{NCS_PasswordAgente}}",
    										"type": "string"
    									},
    									{
    										"key": "username",
    										"value": "{{NCS_UtenteAgente}}",
    										"type": "string"
    									}
    								]
    							},
    							"method": "GET",
    							"header": [],
    							"url": {
    								"raw": "{{NCS_baseUrl}}/sync/articoli?data=19700101",
    								"host": [
    									"{{NCS_baseUrl}}"
    								],
    								"path": [
    									"sync",
    									"articoli"
    								],
    								"query": [
    									{
    										"key": "data",
    										"value": "19700101"
    									}
    								]
    							}
    						},
    						"response": []
    					},
    					{
    						"name": "Lettura pagamenti",
    						"request": {
    							"auth": {
    								"type": "basic",
    								"basic": [
    									{
    										"key": "password",
    										"value": "{{NCS_PasswordAgente}}",
    										"type": "string"
    									},
    									{
    										"key": "username",
    										"value": "{{NCS_UtenteAgente}}",
    										"type": "string"
    									}
    								]
    							},
    							"method": "GET",
    							"header": [],
    							"url": {
    								"raw": "{{NCS_baseUrlTest}}/sync/pagamenti",
    								"host": [
    									"{{NCS_baseUrlTest}}"
    								],
    								"path": [
    									"sync",
    									"pagamenti"
    								]
    							}
    						},
    						"response": []
    					},
    					{
    						"name": "InsertOrdine",
    						"request": {
    							"auth": {
    								"type": "basic",
    								"basic": [
    									{
    										"key": "password",
    										"value": "{{NCS_PasswordAgente}}",
    										"type": "string"
    									},
    									{
    										"key": "username",
    										"value": "{{NCS_UtenteAgente}}",
    										"type": "string"
    									}
    								]
    							},
    							"method": "POST",
    							"header": [],
    							"body": {
    								"mode": "raw",
    								"raw": "{\r\n  \"righe\": [\r\n    {\r\n      \"DESCR\": \"Prodotto di esempio 1\",\r\n      \"ID_ANAART\": \"ART001\",\r\n      \"ID_ORDINE_MOBILE\": \"ORD-MOBILE-12345\",\r\n      \"K2_RIGA\": 1,\r\n      \"PREZZO_APPLICATO\": 85.00,\r\n      \"PREZZO_LISTINO\": 100.00,\r\n      \"QTA\": 5.0,\r\n      \"SCONTO\": 15.0,\r\n      \"SCONTO1\": 10.0,\r\n      \"SCONTO2\": 5.0,\r\n      \"SCONTO3\": 0.0,\r\n      \"SCONTO4\": 0.0,\r\n      \"SCONTO_MAX\": 20.0,\r\n      \"NOTE\": \"Note riga 1\"\r\n    },\r\n    {\r\n      \"DESCR\": \"Prodotto di esempio 2\",\r\n      \"ID_ANAART\": \"ART002\",\r\n      \"ID_ORDINE_MOBILE\": \"ORD-MOBILE-12345\",\r\n      \"K2_RIGA\": 2,\r\n      \"PREZZO_APPLICATO\": 42.50,\r\n      \"PREZZO_LISTINO\": 50.00,\r\n      \"QTA\": 10.0,\r\n      \"SCONTO\": 15.0,\r\n      \"SCONTO1\": 10.0,\r\n      \"SCONTO2\": 5.0,\r\n      \"SCONTO3\": 0.0,\r\n      \"SCONTO4\": 0.0,\r\n      \"SCONTO_MAX\": 20.0,\r\n      \"NOTE\": \"Note riga 2\"\r\n    }\r\n  ],\r\n  \"allegati\": [\r\n    {\r\n      \"ID_ORDINE_MOBILE\": \"ORD-MOBILE-12345\",\r\n      \"FILE_TYPE\": \"application/pdf\",\r\n      \"FILE_ATTACH\": \"BASE64_ENCODED_FILE_CONTENT_HERE\",\r\n      \"FILE_NAME\": \"documento_ordine\",\r\n      \"FILE_EXT\": \"pdf\"\r\n    },\r\n    {\r\n      \"ID_ORDINE_MOBILE\": \"ORD-MOBILE-12345\",\r\n      \"FILE_TYPE\": \"image/jpeg\",\r\n      \"FILE_ATTACH\": \"BASE64_ENCODED_IMAGE_CONTENT_HERE\",\r\n      \"FILE_NAME\": \"foto_prodotto\",\r\n      \"FILE_EXT\": \"jpg\"\r\n    }\r\n  ],\r\n  \"testata\": {\r\n    \"CODAGE\": \"AGE001\",\r\n    \"CODPAG\": \"PAG001\",\r\n    \"CODSPED\": \"SPED001\",\r\n    \"COND_PAG\": \"30 gg Fine Mese\",\r\n    \"DT_CONS\": \"2025-11-20\",\r\n    \"DT_FINE_VALIDITA\": \"2025-12-31\",\r\n    \"DT_ORDINE\": \"2025-11-17\",\r\n    \"ID_ANAGEN\": 12345,\r\n    \"ID_ORDINE_MOBILE\": \"ORD-MOBILE-12345\",\r\n    \"NOTE\": \"Note esterne per il cliente\",\r\n    \"NOTE_INTERNE\": \"Note interne per uso ufficio\",\r\n    \"SCONTO_T\": 10.0,\r\n    \"SP_SPEDIZIONE\": 8.50,\r\n    \"TIPO\": \"ORD\",\r\n    \"USAEMAILORDINE\": 1,\r\n    \"ID_COMPANY\": 1\r\n  }\r\n}",
    								"options": {
    									"raw": {
    										"language": "json"
    									}
    								}
    							},
    							"url": {
    								"raw": "{{NCS_baseUrlTest}}/ordine",
    								"host": [
    									"{{NCS_baseUrlTest}}"
    								],
    								"path": [
    									"ordine"
    								]
    							}
    						},
    						"response": []
    					}
    				]
    			}
    		],
    		"event": [
    			{
    				"listen": "prerequest",
    				"script": {
    					"type": "text/javascript",
    					"packages": {},
    					"requests": {},
    					"exec": [
    						""
    					]
    				}
    			},
    			{
    				"listen": "test",
    				"script": {
    					"type": "text/javascript",
    					"packages": {},
    					"requests": {},
    					"exec": [
    						""
    					]
    				}
    			}
    		],
    		"variable": [
    			{
    				"key": "NCS_PasswordAgente",
    				"value": ""
    			},
    			{
    				"key": "NCS_UtenteAgente",
    				"value": ""
    			},
    			{
    				"key": "NCS_baseUrl",
    				"value": ""
    			},
    			{
    				"key": "NCS_baseUrlTest",
    				"value": ""
    			}
    		]
    	};
    

    var url = "http://localhost:8081/AccPoint/inserisciOfferta.do?action=inserisci";
    //var url = "https://api.mathjs.org/v4/";
    
    fetch(url, {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(dataObj)
    })
    .then(response => response.json())
    .then(data => {
        document.getElementById("risultato").innerText =
            "Risultato della somma: " + data.result;
    })
    .catch(err => {
        document.getElementById("risultato").innerText =
            "Errore: " + err;
    });
}

</script>
  
</jsp:attribute> 
</t:layout>

