<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<html>
<head>
<title>Main</title>

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<!-- 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
	<style>
		.center{
		    position: absolute;
		    top: 50%;
		    left: 50%;
		    transform: translate(-50%, -50%);
		}
		body{
		background-image : url('https://venturebeat.com/wp-content/uploads/2020/09/GettyImages-520682906-e1619014289419.jpg?fit=750%2C563&strip=all');
		background-size : cover;
		}
		

	</style>
	
</head>
<script type="text/javascript">
	$(document).ready(function(){
		
		$("#applyviewBtn").on("click", function(){
			location.href="member/applyview";
		})
		
		$("#indexBtn").on("click", function(){
			location.href="member/index";
		})

		$("#periodBtn").on("click", function(){
			location.href="member/period";
		})
	
		$("#test").on("click", function(){
			window.open("member/period", "팝업", "width = 500, height = 500, top = 100, left = 200, location = no");
			//location.href="member/period";
		})
	})
	
	
</script>


<body id="background">
<div class="center">
<button type="button" class="btn btn-primary" id="applyviewBtn">입회신청서 등록 페이지</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<button type="button" class="btn btn-primary" id="periodBtn">기간별 입회신청 내역조회</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<button type="button" class="btn btn-primary" id="indexBtn">색인별 내역조회</button>
</div>
<div>
<button type="button" class="btn btn-primary" id="test" style="display: none;"></button>
</div>
</body>
</html>
