<%@ page import="poly.util.CmmUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	String userId = CmmUtil.nvl((String)session.getAttribute("userId"));
	String userGroup = CmmUtil.nvl((String)session.getAttribute("userGroup"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html style="font-family: 'Nanum Gothic', sans-serif;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>급한불 - 서울시 공중화장실 위치 제공</title>
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Cookie">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Nanum+Gothic">
<link rel="stylesheet"
	href="assets/css/Background-Image---Parallax---No-Text.css">
<link rel="stylesheet" href="assets/css/Navigation-with-Button.css">
<link rel="stylesheet" href="assets/css/Pretty-Footer.css">
<link rel="stylesheet" href="assets/css/styles.css">
<style>
@media screen and (max-width: 430px) {
	#navbar-user-text {
		position: relative;
		left: 25%;
	}

	footer {
		position: absolute;
		bottom: 0;
	}
}
</style>
</head>

<body style="font-family: 'Nanum Gothic', sans-serif;">
<% if(userId==""){ %>
 	<jsp:include page="header/default.jsp"></jsp:include>
<% } else if(userGroup.equals("2")) {%>
	<jsp:include page="header/admin.jsp"></jsp:include>
<% } else { %>
	<jsp:include page="header/normal.jsp"></jsp:include>
<% } %>


	<div class="backgroundimages"
		style="background-image: url(/assets/img/main.png);"></div>

	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>

<jsp:include page="footer/footer.jsp"></jsp:include>
</body>
</html>