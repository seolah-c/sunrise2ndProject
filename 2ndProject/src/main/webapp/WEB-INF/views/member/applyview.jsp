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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>입회신청서 페이지</title>
</head>
<script type="text/javascript">
	$(document).ready(function() {
		// 초기화
		//$("#reset").on("click", function() {
			
		//})
		var formObj = $("form[name='insertForm']");
		$("#apply").on("click", function(){
			
			formObj.attr("action", "apply");
			formObj.attr("method", "post");
			formObj.submit();
		});
	})
	
	

</script>

<body bgcolor="lightyellow">
	<p align="center">
		<font size="4" color="blue"> <b> 회원 입회신청서 </b></font>
	</p>
	<hr>
	<form name="insertForm" method="post" action="/member/apply">
		<table width="100%" border="1" cellpadding="5" align="center">
			<tr>
				<td>주민번호</td>
				<td><input type="text" name="SSN" size="10"></td>

				<td>접수일자</td>
				<td><input type="text" name="RCV_D" size="10"></td>

				<td>접수 일련번호</td>
				<td><input type="text" name="RCV_SEQ_NO" size="10"></td>

				<td colspan="2" align="right"><input type="submit" value="조회"></td>
			</tr>

			<tr>
				<td>신청일자</td>
				<td><input type="date" id="APPL_D" name="APPL_D"></td>

				<td>신청구분</td>
				<td><select name="APPL_CLAS">
						<option selected>:: 신청구분 ::</option>
						<c:forEach items="${APPL_CLAS}" var="APPL_CLAS">
							<option value="${APPL_CLAS.CODE}">${APPL_CLAS.CODE_NM}</option>
						</c:forEach>
				</select></td>

				<td>브랜드</td>
				<td><select name="BRD">
						<option selected>:: 브랜드 ::</option>
						<c:forEach items="${BRD}" var="BRD">
							<option value="${BRD.CODE}">${BRD.CODE_NM}</option>
						</c:forEach>
				</select></td>
			</tr>

			<tr>
				<td>성명(한글)</td>
				<td><input type="text" name="HG_NM" size="10"></td>

				<td>성명(영문)</td>
				<td><input type="text" name="ENG_NM" size="10"></td>

				<td>생년월일</td>
				<td><input type="date" name="BIRTH_D" size="10"></td>
			</tr>

			<tr>
				<td>결제일자</td>
				<td><select name="STL_DD">
						<option selected>:: 결제일자 선택::</option>
						<c:forEach items="${STL_DD}" var="STL_DD">
							<option value="${STL_DD.CODE}">${STL_DD.CODE_NM}</option>
						</c:forEach>
				</select></td>


				<td>결제방법</td>
				<td><select name="STL_MTD">
						<option selected>:: 결제방법 선택 ::</option>
						<c:forEach items="${STL_MTD}" var="STL_MTD">
							<option value="${STL_MTD.CODE}">${STL_MTD.CODE_NM}</option>
						</c:forEach>
				</select></td>

				<td>결제은행</td>
				<td><select name="BNK_CD">
						<option selected>:: 결제은행 ::</option>
						<c:forEach items="${BNK_CD}" var="BNK_CD">
							<option value="${BNK_CD.CODE}">${BNK_CD.CODE_NM}</option>
						</c:forEach>
				</select></td>
			</tr>

			<tr>
				<td>결제계좌</td>
				<td><input type="text" name="STL_ACT" size="10"></td>
			</tr>

			<tr>
				<td>청구서 발송방법</td>
				<td><select name="STMT_SND_MTD">
						<option selected>::청구서 발송방법::</option>
						<c:forEach items="${STMT_SND_MTD}" var="STMT_SND_MTD">
							<option value="${STMT_SND_MTD.CODE}">${STMT_SND_MTD.CODE_NM}</option>
						</c:forEach>
				</select></td>
				
				<td>우편번호</td>
				<td><input type="text" name="BILLADR_ZIP" size="10"></td>

				<td>주소</td>
				<td><input type="text" name="BILLADR_ADR1" size="10"></td>
			</tr>

			<tr>
				<td>이메일</td>
				<td><input type="text" name="EMAIL_ADR" size="10"></td>

				<td>핸드폰 번호</td>
				<td><input type="text" name="HDP_NO" size="10"></td>

				<td>비밀번호</td>
				<td><input type="text" name="SCRT_NO" size="10"></td>
			</tr>

			<tr>
				<td>불능 구분</td>
				<td><input type="text" name="IMPSB_CLAS" size="10" readonly>
				</td>

				<td>불능 사유명</td>
				<td><input type="text" name="IMPSB_CD" size="10" readonly>
				</td>
			</tr>

			<tr>
				<td colspan="7" align="right">
					<button type="button" id="apply">등록</button>&nbsp;&nbsp;
					<button type="button" id="update">수정</button>&nbsp;&nbsp;
					<button type="button" id="reset">초기화</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
