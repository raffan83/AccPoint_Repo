<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Visualizza PDF</title>
</head>
<body>
    <!-- L'attributo pdfPath viene passato dalla servlet -->
    <iframe src="servePdf?filePath=${pdfPath}" width="100%" height="600px" style="border: none;"></iframe>
</body>
</html>