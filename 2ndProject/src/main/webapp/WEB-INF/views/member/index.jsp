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
<title>회원 색인 조회 페이지</title>

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
		$("#backBtn2").on("click", function(){
			location.href="/member";
		})
		
		var formCardHistory = $("form[name='index']");
		
		// 성명, 생년월일, 핸드폰번호로 조회해서 해당하는 카드테이블 내역 불러오기
		$("#indexChkBtn").on("click", function(){
			console.log("---" + $("#HG_NM").val());
			
			var param = {
					HG_NM:$("#HG_NM").val(),
					BIRTH_D:$("#BIRTH_D").val(),
					HDP_NO:$("#HDP_NO").val()
			};
			
			console.log("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" + $("#BIRTH_D").val());
			
			var loop = $("#arraylist tr").length-4;
			for(var i=0; i<loop; i++) {
				$("#arraylist tr:last").remove();
			}
			
			$.ajax({
				//anyne:true,
				url : "index",
				dataType : 'json',
				type : "POST",
				data : JSON.stringify(param),
				//data : param,
				contentType : 'application/json',
				datatype : "text",
				success : function(data) {
					console.log("ㅋㅋㅋㅋㅋㅋㅋ");
					
					 for(var i=0; i<data.length; i++) {
						 var insertTr = "";
			/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////			  
						  insertTr += "<tr>";
						  //insertTr += "<td>" + "" + "</td>";
						  insertTr += "<td>"+data[i].ssn +"</td>";
						  //insertTr += "<td name=name id=SEQ" + i + ">"+data[i].rcv_SEQ_NO +"</td>";
						  insertTr += "<td>"+data[i].hg_NM +"</td>";
						  insertTr += "<td>"+data[i].birth_D +"</td>";
						  insertTr += "<td>"+data[i].hdp_NO +"</td>";
						  insertTr += "<td>"+data[i].bnk_CD +"</td>";
						  insertTr += "<td>"+data[i].stl_ACT +"</td>";
						  insertTr += "<td>"+data[i].bill_ADR1 +"</td>";
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
		<font size="5" color="#5d6fc7"><b> 회원 색인 조회 </b></font>
	</p>
	<hr>
	<form name="index" method="post" action="/member/index">
		<table width="100%" border="1" id="arraylist" class="test">
			<tr id="top">
				<td colspan="11">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;성명&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
					<input type="text" name="HG_NM" size="10" id="HG_NM">&nbsp;&nbsp;&nbsp;&nbsp; 
						생년월일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="date" name="BIRTH_D" size="10" id="BIRTH_D"> 
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							핸드폰 번호&nbsp; 
							<input type="text" id="HDP_NO" size="13" id="HDP_NO">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" id="indexChkBtn" value="조회" style="background-color:#b8dec3; border-radius: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;
					<br>
				</td>
			</tr>
			<tr>
				<td colspan="11" id="color">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조회결과<br></td>
			</tr>
			<tr id="color">
				<td align="center">주민번호</td>
				<td align="center">성명(한글)</td>
				<td align="center">생년월일</td>
				<td align="center">핸드폰 번호</td>
				<td align="center">결제 은행</td>
				<td align="center">결제 계좌</td>
				<td align="center">주소</td>
			</tr>
			<tr>
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
				<input type=button value="메인으로 이동" id="backBtn2" style="background-color:#4d7bd6; border-radius: 12px; color:white;"></p>
			</div>
	</form>
</body>
</html>
