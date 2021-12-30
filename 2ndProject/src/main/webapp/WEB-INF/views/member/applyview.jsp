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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<title>입회신청서 페이지</title>
<style>
		#color{
		    background-color: #def4fc;
		}
		#top{
			background-color: #fadcf9;
		}
		
	</style>
</head>
<script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("form[name='insertForm']");
		
		// 주민번호, 접수일자, 접수 일련번호로 조회해서 해당하는 신청내역 불러오기
		$("#inquiryBtn").on("click", function(){
			if($("#SSN").val()=="" || $("#RCV_D").val()=="") {
				alert("주민번호와 접수일자를 입력하세요");
				return;
			}
			
			var param = {
					SSN:$("#SSN").val(), 
					RCV_D:$("#RCV_D").val(),
					RCV_SEQ_NO:$("#RCV_SEQ_NO").val()
			};
			
			console.log("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" + $("#SSN").val());
			
			$.ajax({
				anyne:true,
				url : "chk_inquiry",
				dataType : 'json',
				type : "POST",
				data : JSON.stringify(param),
				//data : param,
				contentType : 'application/json',
				datatype : "text",
				success : function(data) {
					
					console.log(data.appl_D);
					var test = data.appl_D.substr(0, 4) + "-" + data.appl_D.substr(4, 2)-1 + "-" + data.appl_D.substr(6, 2);
				
					console.log(test + " ---");
					var t = data.appl_D;
					var date = new Date(t.substr(0, 4), t.substr(4, 2)-1, t.substr(6, 2));
					var year = date.getFullYear();
				    var month = ("0" + (1 + date.getMonth())).slice(-2);
				    var day = ("0" + date.getDate()).slice(-2);
					console.log(date);
					console.log(year + "-" +  month + "-" + day);
					$("#APPL_D").val(year + "-" +  month + "-" + day);
				
					var d = data.birth_D;
					var date = new Date(d.substr(0, 4), d.substr(4, 2)-1, d.substr(6, 2));
					var year = date.getFullYear();
				    var month = ("0" + (1 + date.getMonth())).slice(-2);
				    var day = ("0" + date.getDate()).slice(-2);
				    console.log(date);
				    console.log(year + "-" +  month + "-" + day);
					$("#BIRTH_D").val(year + "-" + month + "-" + day);
					
					
					$("#APPL_CLAS").val(data.appl_CLAS);
					$("#BRD").val(data.brd);
					$("#HG_NM").val(data.hg_NM);
					$("#ENG_NM").val(data.eng_NM);
					$("#STL_DD").val(data.stl_DD);
					$("#STL_MTD").val(data.stl_MTD);
					$("#BNK_CD").val(data.bnk_CD);
					$("#STL_ACT").val(data.stl_ACT);
					$("#STMT_SND_MTD").val(data.stmt_SND_MTD);
					$("#BILLADR_ZIP").val(data.billadr_ZIP);
					$("#BILLADR_ADR1").val(data.billadr_ADR1);
					$("#EMAIL_ADR").val(data.email_ADR);
					$("#HDP_NO").val(data.hdp_NO);
					$("#SCRT_NO").val(data.scrt_NO);
					$("#IMPSB_CLAS").val(data.impsb_CLAS);
					$("#IMPSB_CD").val(data.impsb_CD);
					
				}
			})
							
		});
		
		 $("#apply").on("click", function(){
			
			 var id = $("#SSN").val();
			 var SSN = id.search(/^[0-9]{13}$/);
		        var arr = new Array(); // 주민번호 담을 배열
			 if ($("#SSN").val() == "") {
					alert("주민번호를 입력해주세요.");
					$("#SSN").focus();
					return false;
				}

		        // -------------- 주민번호 -------------

		        for (var i=0; i<id.length; i++) {
		            arr[i] = id.charAt(i);
		        } // 주민번호 앞자리를 배열에 순서대로 담는다.

		        var tempSum=0;

		        for (var i=0; i<id.length-1; i++) {
		        	if(i>=9) {
		        		tempSum += arr[i] * (i-7);
		        	} else {
		        		tempSum += arr[i] * (2+i);
		        	}
		            
		        } // 주민번호 검사방법을 적용하여 앞 번호를 모두 계산하여 더함

		        

		        if((11-(tempSum%11))%10!=arr[12]) {
		            alert("올바른 주민번호가 아닙니다.");
		            SSN.value = "";
		            $("#SSN").focus();
		            return false;
		        }
		    
			 
			 var id = $("#HG_NM").val();
			 var HG_NM = id.search(/^[가-힣]+$/);
			 if ($("#HG_NM").val() == "") {
				 	
					alert("이름을 입력해주세요.");
					$("#HG_NM").focus();
					
					return false;
				} 
			 if(HG_NM == '-1') {
				 
					alert("한글로 입력하세요");
					return false;
				}
			 
			 var id = $("#ENG_NM").val();
			 var ENG_NM = id.search(/^[A-Z]+$/);
			 if ($("#ENG_NM").val() == "") {
					alert("영문이름을 입력해주세요.");
					$("#ENG_NM").focus();
					return false;
				}
			 if(ENG_NM == '-1') {
				 alert("영문(대문자)으로 입력하세요");
					return false;
			 }
			 
			 var id = $("#STL_ACT").val();
			 if ($("#STL_ACT").val() == "") {
					alert("결제계좌를 입력해주세요.");
					$("#STL_ACT").focus();
					return false;
				}
			 if (id.length!=13) {
			      alert("계좌번호 13자리를 입력해주세요.");
			      return false;
			    }
			 
			 if ($("#BILLADR_ZIP").val() == "") {
					alert("우편번호를 입력해주세요.");
					$("#BILLADR_ZIP").focus();
					return false;
				}
			 
			 if ($("BILLADR_ADR1").val() == "") {
					alert("주소를 입력해주세요.");
					$("#BILLADR_ADR1").focus();
					return false;
				}
			 
			 var id = $("#EMAIL_ADR").val();
			 var EMAIL_ADR = id.search(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
			 if ($("#EMAIL_ADR").val() == "") {
					alert("이메일을 입력해주세요.");
					$("#EMAIL_ADR").focus();
					return false;
				}
			 if(EMAIL_ADR == '-1') {
				 
					alert("이메일 형식이 올바르지 않습니다");
					return false;
				}
			 
			 var id = $("#HDP_NO").val();
			 var HDP_NO = id.search(/^[0-9]{11}$/);
			 console.log(HDP_NO);
			 if ($("#HDP_NO").val() == "") {
					alert("핸드폰번호를 입력해주세요.");
					$("#HDP_NO").focus();
					return false;
				}
			 if (id.length!=11 || HDP_NO=='-1') {
			      alert("핸드폰번호 11자리를 입력해주세요.(-없이)");
			      return false;
			    }
			
			 var birth = $("#SSN").val().substr(0,6);
			 var midNO = $("#HDP_NO").val().substr(3, 4);
			 var endNO = $("#HDP_NO").val().substr(6);
			 var SCRT_NO = $("#SCRT_NO").val();
			 
			 if(SCRT_NO.indexOf(birth) == 0) {
				 alert("비밀번호에는 생년월일과 중복되는 숫자를 사용할 수 없습니다");
				 return false;
			 }
			 if(SCRT_NO.indexOf(midNO) == 0 || SCRT_NO.indexOf(endNO) == 0) {
				 alert("비밀번호에는 핸드폰 번호 중복 사용할 수 없습니다");
				 return false;
			 }
			
			var reg = /^(?=.*?[0-9]).{8}$/;
			 if ($("#SCRT_NO").val() == "") {
					alert("비밀번호를 입력해주세요.");
					$("#SCRT_NO").focus();
					return false;
				}
			 if(false === reg.test(SCRT_NO)) {
					alert('비밀번호는 8자리 숫자입니다.');
					return false;
				}else if(/(\w)\1\1\1/.test(SCRT_NO) || isContinuedValue(SCRT_NO)){
				 	alert('같은 문자 4번 이상 또는 연속된 숫자를 사용하실 수 없습니다.');
				 	return false;
				 }else {
				 	console.log("통과");
				 }
			 // 연속된 숫자 사용 받는 함수
			 function isContinuedValue(value) {
					console.log("value = " + value);
					var intCnt1 = 0;
					var intCnt2 = 0;
					var temp0 = "";
					var temp1 = "";
					var temp2 = "";
					var temp3 = "";

					for (var i = 0; i < value.length-3; i++) {
						console.log("=========================");
						temp0 = value.charAt(i);
						temp1 = value.charAt(i + 1);
						temp2 = value.charAt(i + 2);
						temp3 = value.charAt(i + 3);

						console.log(temp0)
						console.log(temp1)
						console.log(temp2)
						console.log(temp3)

						if (temp0.charCodeAt(0) - temp1.charCodeAt(0) == 1
						&& temp1.charCodeAt(0) - temp2.charCodeAt(0) == 1
						&& temp2.charCodeAt(0) - temp3.charCodeAt(0) == 1) {
							intCnt1 = intCnt1 + 1;
						}

						if (temp0.charCodeAt(0) - temp1.charCodeAt(0) == -1
						&& temp1.charCodeAt(0) - temp2.charCodeAt(0) == -1
						&& temp2.charCodeAt(0) - temp3.charCodeAt(0) == -1) {
							intCnt2 = intCnt2 + 1;
						}
					}

					console.log(intCnt1 > 0 || intCnt2 > 0);
					return (intCnt1 > 0 || intCnt2 > 0);
				}

			formObj.attr("action", "apply");
			formObj.attr("method", "post");
			formObj.submit();
		});
		 
		 $("#apiBtn").on("click", function(){
			 sample4_execDaumPostcode();
		 })
		 
		 function sample4_execDaumPostcode() {
		        new daum.Postcode({
		        	
		        	oncomplete: function(data) {
		                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

		                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var roadAddr = data.roadAddress; // 도로명 주소 변수
		                var extraRoadAddr = ''; // 참고 항목 변수

		                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                    extraRoadAddr += data.bname;
		                }
		                // 건물명이 있고, 공동주택일 경우 추가한다.
		                if(data.buildingName !== '' && data.apartment === 'Y'){
		                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                }
		                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                if(extraRoadAddr !== ''){
		                    extraRoadAddr = ' (' + extraRoadAddr + ')';
		                }

		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('BILLADR_ZIP').value = data.zonecode;
		                document.getElementById("BILLADR_ADR1").value = roadAddr;
		                //document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
		                
		                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
		                /* if(roadAddr !== ''){
		                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
		                } else {
		                    document.getElementById("sample4_extraAddress").value = '';
		                }

		                var guideTextBox = document.getElementById("guide");
		                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
		                if(data.autoRoadAddress) {
		                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
		                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
		                    guideTextBox.style.display = 'block';

		                } else if(data.autoJibunAddress) {
		                    var expJibunAddr = data.autoJibunAddress;
		                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
		                    guideTextBox.style.display = 'block';
		                } else {
		                    guideTextBox.innerHTML = '';
		                    guideTextBox.style.display = 'none';
		                } */
		            }
		        }).open();
		    }
	})
	
</script>

<body bgcolor="lightyellow">
	<p align="center">
		<font size="5" color="#5d6fc7"> <b> 회원 입회신청서 </b></font>
	</p>
	<hr>
	<form name="insertForm" method="post" action="/member/apply">
		<table width="100%" border="1" cellpadding="5" align="center">
			<tr height="35px">
				<td align="center" id="top">주민번호</td>
				<td>&nbsp;&nbsp;<input type="text" name="SSN" size="10" id="SSN" value="${SSN}"></td>

				<td align="center" id="top">접수일자</td>
				<td>&nbsp;&nbsp;<input type="text" name="RCV_D" size="10" id="RCV_D" value="${RCV_D}" readonly></td>

				<td align="center" id="top">접수 일련번호</td>
				<td>&nbsp;&nbsp;<input type="text" name="RCV_SEQ_NO" size="10" id="RCV_SEQ_NO" value="${RCV_SEQ_NO}" readonly></td>

				<td colspan="2" align="center" id="top"><input type="button" id="inquiryBtn" value="조회" style="background-color:#b8dec3; border-radius: 12px;"></td>
			</tr>

			<tr height="45px">
				<td align="center" id="color">신청일자</td>
				<td>&nbsp;&nbsp;<input type="date" id="APPL_D" name="APPL_D"></td>

				<td align="center" id="color">신청구분</td>
				<td>&nbsp;&nbsp;<select name="APPL_CLAS" id="APPL_CLAS">
						<option selected>:: 신청구분 ::</option>
						<c:forEach items="${APPL_CLAS}" var="APPL_CLAS">
							<option value="${APPL_CLAS.CODE}">${APPL_CLAS.CODE_NM}</option>
						</c:forEach>
				</select></td>

				<td align="center" id="color">브랜드</td>
				<td colspan="4">&nbsp;&nbsp;<select name="BRD" id="BRD">
						<option selected>:: 브랜드 ::</option>
						<c:forEach items="${BRD}" var="BRD">
							<option value="${BRD.CODE}">${BRD.CODE_NM}</option>
						</c:forEach>
				</select></td>
			</tr>

			<tr height="45px">
				<td align="center" id="color">성명(한글)</td>
				<td>&nbsp;&nbsp;<input type="text" name="HG_NM" size="10" id="HG_NM"></td>

				<td align="center" id="color">성명(영문)</td>
				<td>&nbsp;&nbsp;<input type="text" name="ENG_NM" size="10" id="ENG_NM"></td>

				<td align="center" id="color">생년월일</td>
				<td colspan="4">&nbsp;&nbsp;<input type="date" name="BIRTH_D" size="10" id="BIRTH_D"></td>
			</tr>

			<tr height="35px">
				<td align="center" id="color">결제일자</td>
				<td>&nbsp;&nbsp;<select name="STL_DD"  id="STL_DD">
						<option selected>:: 결제일자 선택::</option>
						<c:forEach items="${STL_DD}" var="STL_DD">
							<option value="${STL_DD.CODE}">${STL_DD.CODE_NM}</option>
						</c:forEach>
				</select></td>


				<td align="center" id="color">결제방법</td>
				<td>&nbsp;&nbsp;<select name="STL_MTD" id="STL_MTD">
						<option selected>:: 결제방법 선택 ::</option>
						<c:forEach items="${STL_MTD}" var="STL_MTD">
							<option value="${STL_MTD.CODE}">${STL_MTD.CODE_NM}</option>
						</c:forEach>
				</select></td>

				<td align="center" id="color">결제은행</td>
				<td colspan="4">&nbsp;&nbsp;<select name="BNK_CD" id="BNK_CD">
						<option selected>:: 결제은행 ::</option>
						<c:forEach items="${BNK_CD}" var="BNK_CD">
							<option value="${BNK_CD.CODE}">${BNK_CD.CODE_NM}</option>
						</c:forEach>
				</select></td>
			</tr>

			<tr height="35px">
				<td align="center" id="color">결제계좌</td>
				<td>&nbsp;&nbsp;<input type="text" name="STL_ACT" size="20" id="STL_ACT"></td>
				<td align="center" id="color">결제계좌 확인여부</td>
				<td colspan="6">&nbsp;&nbsp;<input type="text" name="PRCS_CLAS" size="10" id="PRCS_CLAS"></td>
			</tr>

			<tr height="35px">
				<td align="center" id="color">청구서 발송방법</td>
				<td>&nbsp;&nbsp;<select name="STMT_SND_MTD" id="STMT_SND_MTD">
						<option selected>::청구서 발송방법::</option>
						<c:forEach items="${STMT_SND_MTD}" var="STMT_SND_MTD">
							<option value="${STMT_SND_MTD.CODE}">${STMT_SND_MTD.CODE_NM}</option>
						</c:forEach>
				</select></td>
				
				<td align="center" id="color">우편번호</td>
				<td>&nbsp;&nbsp;<input type="text" name="BILLADR_ZIP" size="10" id="BILLADR_ZIP">
				<button type="button" id="apiBtn">...</button></td>

				<td align="center" id="color">주소</td>
				<td colspan="4">&nbsp;&nbsp;<input type="text" name="BILLADR_ADR1" size="30" id="BILLADR_ADR1"></td>
			</tr>

			<tr height="35px">
				<td align="center" id="color">이메일</td>
				<td>&nbsp;&nbsp;<input type="text" name="EMAIL_ADR" size="20" id="EMAIL_ADR"></td>

				<td align="center" id="color">핸드폰 번호</td>
				<td>&nbsp;&nbsp;<input type="text" name="HDP_NO" size="10" id="HDP_NO"></td>

				<td align="center" id="color">비밀번호</td>
				<td colspan="4">&nbsp;&nbsp;<input type="password" name="SCRT_NO" size="10" id="SCRT_NO"></td>
			</tr>

			<tr height="35px">
				<td align="center" id="color">불능 구분</td>
				<td>&nbsp;&nbsp;<input type="text" name="IMPSB_CLAS" size="10" id="IMPSB_CLAS" readonly>
				</td>

				<td align="center" id="color">불능 사유명</td>
				<td colspan="6">&nbsp;&nbsp;<input type="text" name="IMPSB_CD" size="10" id="IMPSB_CD" readonly>
				</td>
			</tr>

			<tr>
				<td colspan="7" align="center">
					<button type="button" id="apply" style="background-color:#4d7bd6; border-radius: 12px; color:white;">등록</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" id="update" style="background-color:#4d7bd6; border-radius: 12px; color:white;">수정</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="reset" val="" style="background-color:#4d7bd6; border-radius: 12px; color:white;">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
