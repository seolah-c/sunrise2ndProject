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
 
 .result{
			text-align:left;
		}
</style>
</head>
<h4 align="center">기간별 입회신청 내역조회</h4>
	<body bgcolor="lightyellow">
    
    <hr>
        <table border="1" class="container">
            <tr>
                <td> 기간 </td>
                <td colspan="4"> <input type="text" name="id" size="10"> ~ <input type="text" name="id" size="10"></td>
           
                <td> 신청구분 </td>
                <td><select name="AAPL_CLAS">
				</select> </td>
            
                <td> 주민번호 </td>
                <td> <input type="text" name="SSN"> </td>
          
                <td colspan="2" align="right">
                    <input type="button" value="조회"></td>
            </tr>
            
             <tr>
                <td colspan="11" align="left" class="result"> 조회결과 </td>
            </tr>
            
            <tr>
			<td>접수일자</td>
			<td>접수 일련번호</td>
			<td>주민번호</td>
			<td>성명(한글)</td>
			<td>성명(영문)</td>
			<td>신청구분</td>
			<td>브랜드</td>
			<td>핸드폰번호</td>
			<td>불능구분</td>
			<td>불능 사유명</td>
			</tr>
			<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			</tr>
            
           
            <tr>
                <td colspan="11" align="right">
                    <input type="reset" value="초기화">&nbsp;&nbsp;
                    <input type="button" value="닫기"></td>
            </tr>
        </table>
 </body>
</html>
 