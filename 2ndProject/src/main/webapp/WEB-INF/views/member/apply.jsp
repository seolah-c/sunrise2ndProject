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
<title>Insert title here</title>
</head>
<body bgcolor="lightyellow">
	<p align="center">
		<font size="4" color="blue"> <b> 회원 입회신청서 </b></font>
	</p>
	<hr>
	<table width="100%" border="1" cellpadding="5" align="center">
		<c:forEach items="${list}" var = "list">
		<tr>
			<td>주민번호</td>
			<td><c:out value="${list.SSN}" /></td>

			<td>접수일자</td>
			<td><c:out value="${list.RCV_D}" /></td>

			<td>접수 일련번호</td>
			<td><c:out value="${list.RCV_SEQ_NO}" /></td>

			<td colspan="2" align="right"><input type="submit" value="조회"></td>
		</tr>

		<tr>
			<td>신청일자</td>
			<td><c:out value="${list.APPL_D}" /></td>

			<td>신청구분</td>
			<td><c:out value="${list.APPL_CLAS}" /></td>

			<td>브랜드</td>
			<td><c:out value="${list.BRD}" /></td>
		</tr>

		<tr>
			<td>성명(한글)</td>
			<td><c:out value="${list.HG_NM}" /></td>

			<td>성명(영문)</td>
			<td><c:out value="${list.ENG_NM}" /></td>

			<td>생년월일</td>
			<td><c:out value="${list.BIRTH_D}" /></td>
		</tr>

		<tr>
			<td>결제일자</td>
			<td><c:out value="${list.STL_DD}" /></td>

			<td>결제방법</td>
			<td><c:out value="${list.STL_MTD}" /></td>

			<td>결제은행</td>
			<td><c:out value="${list.BNK_CD}" /></td>
		</tr>

		<tr>
			<td>결제계좌</td>
			<td><c:out value="${list.STL_ACT}" /></td>
		</tr>

		<tr>
			<td>청구서 발송방법</td>
			<td><c:out value="${list.STMT_SND_MTD}" /></td>

			<td>우편번호</td>
			<td><c:out value="${list.BILLADR_ZIP}" /></td>

			<td>주소</td>
			<td><c:out value="${list.BILLADR_ADR1}" /></td>
		</tr>

		<tr>
			<td>이메일</td>
			<td><c:out value="${list.EMAIL_ADR}" /></td>

			<td>핸드폰 번호</td>
			<td><c:out value="${list.HDP_NO}" /></td>

			<td>비밀번호</td>
			<td><c:out value="${list.SCRT_NO}" /></td>
		</tr>

		<tr>
			<td>불능 구분</td>
			<td><c:out value="${list.IMPSB_CLAS}" />
			</td>

			<td>불능 사유명</td>
			<td><c:out value="${list.IMPSB_CD}" />
			</td>
		</tr>

		<tr>
			<td colspan="7" align="right">
				<button type="button" id="apply">등록</button>&nbsp;&nbsp;
				<button type="button" id="update">수정</button>&nbsp;&nbsp;
				<button type="button" id="reset">초기화</button>
			</td>
		</tr>
		</c:forEach>
	</table>
</body>
</html>