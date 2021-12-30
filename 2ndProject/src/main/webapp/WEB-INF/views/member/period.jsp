<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>기간별 입회신청 내역조회 페이지</title>

<style>
.result {
	text-align: left;
}
#top{
	background-color: #fadcf9;
}
#color{
    background-color: #def4fc;
}
</style>
</head>

<script type="text/javascript">
	
	$(document).ready(function() {
		$("#backBtn").on("click", function(){
			location.href="/member";
		})
		
	/* 	$('td[name="name"]').click(function(){
    		var id_check = $(this).attr("id");
    		console.log(id_check);
		});
		
		$('#SEQ3').click(function(){
    		//var id_check = $(this).attr("id");
    		var id_check = $(this).text();
    		console.log(id_check);
		}); */
		
		$(document).on('click', 'td[name="name"]', function() {
			console.log('element with id: ' + this.id + ' has value: ' + this.innerText);
			var RCV_D = this.previousElementSibling.innerText;
			var RCV_SEQ_NO = this.innerText;
			var SSN = this.nextElementSibling.innerText;
			location.href='/member/member/applyview?RCV_D='+RCV_D+'&RCV_SEQ_NO='+RCV_SEQ_NO+'&SSN='+SSN;
		});
		
		
		var formHistory = $("form[name='period']");
		
		// 기간, 신청구분, 주민번호로 조회해서 해당하는 신청내역 불러오기 (기간은 필수, 주민번호 있으면 땡큐/ but 신청구분값만으로는 조회 불가)
		$("#periodChkBtn").on("click", function(){
			console.log("---" + $("#APPL_D2").val());
			
			if($("#APPL_D1").val()=="" || $("#APPL_D2").val()=="") {
				alert("기간을 선택하세요");
				return;
			}
			
			var param = {
					APPL_D1:$("#APPL_D1").val(),
					APPL_D2:$("#APPL_D2").val(),
					APPL_CLAS:$("#APPL_CLAS").val(),
					SSN:$("#SSN").val() 
			};
			
			console.log("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" + $("#SSN").val());
			
			var loop = $("#arraylist tr").length-4;
			for(var i=0; i<loop; i++) {
				$("#arraylist tr:last").remove();
			}
			
			$.ajax({
				//anyne:true,
				url : "period",
				dataType : 'json',
				type : "POST",
				data : JSON.stringify(param),
				//data : param,
				contentType : 'application/json',
				datatype : "text",
				success : function(data) {
					console.log("왓니?");
					
					 for(var i=0; i<data.length; i++) {
						 var insertTr = "";
						  
						  insertTr += "<tr>";
						  insertTr += "<td>" + "" + "</td>";
						  insertTr += "<td>"+data[i].rcv_D +"</td>";
						  insertTr += "<td name=name id=SEQ" + i + ">"+data[i].rcv_SEQ_NO +"</td>";
						  insertTr += "<td>"+data[i].ssn +"</td>";
						  insertTr += "<td>"+data[i].hg_NM +"</td>";
						  insertTr += "<td>"+data[i].eng_NM +"</td>";
						  insertTr += "<td>"+data[i].appl_CLAS +"</td>";
						  insertTr += "<td>"+data[i].brd +"</td>";
						  insertTr += "<td>"+data[i].hdp_NO +"</td>";
						  insertTr += "<td>"+data[i].impsb_CLAS +"</td>";
						  insertTr += "<td>"+data[i].impsb_CD +"</td>";
						  insertTr += "</tr>";
						    
						  $("#arraylist").append(insertTr);
					} 
				}
			})				
		});
	})
	
</script>

<body bgcolor="lightyellow">
	<p align="center">
		<font size="5" color="#5d6fc7"><b> 기간별 입회신청 내역조회 </b></font>
	</p>
	<hr>
	<form name="period" method="post" action="/member/period">
		<table width="100%" border="1" id="arraylist" class="test">
			<tr id="top">
				<td colspan="11">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;기간&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
					<input type="date" id="APPL_D1"> ~ <input type="date" id="APPL_D2">&nbsp;&nbsp;&nbsp;&nbsp; 
						신청구분&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						<select name="APPL_CLAS" id="APPL_CLAS">
							<option selected></option>
							<c:forEach items="${APPL_CLAS}" var="APPL_CLAS">
							<option value="${APPL_CLAS.CODE}">${APPL_CLAS.CODE_NM}</option>
						</c:forEach></select> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							주민번호&nbsp; 
							<input type="text" id="SSN" size="13" id="SSN">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" id="periodChkBtn" value="조회" style="background-color:#b8dec3; border-radius: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;
					<br>
				</td>
			</tr>
			<tr>
				<td colspan="11" id="color">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조회결과<br></td>
			</tr>
			<tr id="color">
				<td></td>
				<td align="center">접수일자</td>
				<td align="center">접수 일련번호</td>
				<td align="center">주민번호</td>
				<td align="center">성명(한글)</td>
				<td align="center">성명(영문)</td>
				<td align="center">신청구분</td>
				<td align="center">브랜드</td>
				<td align="center">핸드폰번호</td>
				<td align="center">불능구분</td>
				<td align="center">불능 사유명</td>
			</tr>
			<tr>
				<td align="center"></td>
				<td align="center"></td>
				<td align="center"></td>
				<td align="center"></td>
				<td align="center"></td>
				<td align="center"></td>
				<td align="center"></td>
				<td align="center"></td>
				<td align="center"></td>
				<td align="center"></td>
				<td align="center"></td>
			</tr>
	
		</table>
		
		<div>
				<p align="center"><input type="reset" value="초기화" style="background-color:#4d7bd6; border-radius: 12px; color:white;">&nbsp;&nbsp;
				<input type=button value="메인으로 이동" id="backBtn" style="background-color:#4d7bd6; border-radius: 12px; color:white;"></p>
			</div>
	</form>
</body>
</html>
