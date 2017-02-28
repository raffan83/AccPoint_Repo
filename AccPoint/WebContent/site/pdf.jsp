
<html>
 <head>	<title>DIGIWEBUNO</title> 
<link href="css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/pdfobject.js"></script>
<style type="text/css">
<!--

#pdf {
	width: 600px;
	height: 800px;
	margin: 2em auto;
	border: 10px solid #6699FF;
}

#pdf p {
   padding: 1em;
}

#pdf object {
   display: block;
   border: solid 1px #666;
}

-->
</style>
<script type="text/javascript">

window.onload = function (){

	var success = new PDFObject({ url: "pdf/sample.pdf" }).embed("pdf");
	
}

function next(path)
{
alert(url)
	var success = new PDFObject({ url: path }).embed("pdf");
}
</script>
  </head>
  <span class="button" onclick="next('pdf/sample1.pdf');">next document</span>
  <body background="images/sfondo.jpg">
	<div id="pdf">It appears you don't have Adobe Reader or PDF support in this web browser. <a href="pdf/sample.pdf">Click here to download the PDF</a></div>
  </body>
 </html>