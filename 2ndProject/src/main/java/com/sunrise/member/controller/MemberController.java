package com.sunrise.member.controller;

import java.util.List;

import java.util.Locale;
import java.util.Map;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.slf4j.Logger;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sunrise.member.service.CustService;
import com.sunrise.member.service.ImpsbService;
import com.sunrise.member.service.MemberService;
import com.sunrise.member.vo.CustVO;
import com.sunrise.member.vo.MemberVO;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	MemberService service;
	
	@Autowired
	CustService Cservice;
	
	@Autowired
	ImpsbService Iservice;
	
	// 입회신청서 작성 화면
	@RequestMapping(value = "/applyview", method = RequestMethod.GET)
	public void applyview(@RequestParam(value="RCV_D", required=false) String RCV_D, 
						  @RequestParam(value="RCV_SEQ_NO", required=false) String RCV_SEQ_NO,
						  @RequestParam(value="SSN", required=false) String SSN, Locale locale, Model model) throws Exception{
		
		logger.info("이가탄============================================================" + RCV_D + RCV_SEQ_NO + SSN);
		List<MemberVO> APPL_CLAS = service.getAPPL_CLAS();
		System.out.println(APPL_CLAS.get(0).getCODE_NM()+"11111111111111111111111111111111111111");
		List<MemberVO> BRD = service.getBRD();
		List<MemberVO> STL_DD = service.getSTL_DD();
		List<MemberVO> STL_MTD = service.getSTL_MTD();
		List<MemberVO> BNK_CD = service.getBNK_CD();
		List<MemberVO> STMT_SND_MTD = service.getSTMT_SND_MTD();
		
		model.addAttribute("APPL_CLAS", APPL_CLAS); // 신청구분 셀렉트박스
		model.addAttribute("BRD", BRD); // 브랜드 셀렉트박스
		model.addAttribute("STL_DD", STL_DD); // 결제일자 셀렉트박스
		model.addAttribute("STL_MTD", STL_MTD); // 결제방법 셀렉트박스
		model.addAttribute("BNK_CD", BNK_CD); // 결제은행 셀렉트박스
		model.addAttribute("STMT_SND_MTD", STMT_SND_MTD); // 청구서발송방법 셀렉트박스
		System.out.println(APPL_CLAS.get(0).getAPPL_CLAS()+"11111111111111111111111111111111111111");
		model.addAttribute("RCV_D", RCV_D);
		model.addAttribute("RCV_SEQ_NO", RCV_SEQ_NO);
		model.addAttribute("SSN", SSN);
		
	}
	
	// 신청서 "등록"
	@RequestMapping(value = "/apply", method = RequestMethod.POST)
	public String write(MemberVO memberVO) throws Exception {
		String b = memberVO.getBIRTH_D();
		b = b.replaceAll("-", "");
		logger.info("비밀번호쳌------" + memberVO.getSCRT_NO());
		logger.info("apply------" + b);
		memberVO.setBIRTH_D(b);
		//불능체크 함수 호출 if 불능인경우 home으로 가고 else if 능인경우 vocheck호출
		if(!chk_Impsb_code(memberVO)) {//chk_Impsb_code false(능)일경우 vocheck 호출
			vocheck(memberVO);  
		}
		
		return "redirect:/";
	}
	
	
	// 불능체크 함수를 만들죠
	public boolean chk_Impsb_code(MemberVO memberVO) throws Exception {
		//true: 불능, false: 능
		
		// 불능코드 01 : 당일 두번 등록
		if(Iservice.chk_Dday_history(memberVO) > 0) {//조건: 당일 신청 내역 존재 체크 서비스를 호출하여 데이터가 있으면
			service.apply(memberVO);
			MemberVO mem = Cservice.get_rcv_d(memberVO);
			memberVO.setRCV_D(mem.getRCV_D());
			memberVO.setIMPSB_CD("01");
			
			Cservice.upd_imp_status(memberVO);
			System.out.println("들어오는지 안들어오는지--- " + memberVO.getRCV_SEQ_NO());
			return true;
		}
		
		// 불능코드 04 : 카드 이미 소지하고 있음
		else if(Iservice.chk_crd_exist(memberVO) > 0 && memberVO.getAPPL_CLAS().equals("11")) {//조건: 신규 -> 기존 카드 존재 체크 (존재 = 1)
			// count > 0 이면 false , =0 이면 true;
			service.apply(memberVO);
			MemberVO mem = Cservice.get_rcv_d(memberVO);
			memberVO.setRCV_D(mem.getRCV_D());
			memberVO.setIMPSB_CD("04");
			
			Cservice.upd_imp_status(memberVO);
			System.out.println("신규 불능 쳌쳌");
			return true;
		}
		
		// 불능코드 04 : 카드 이미 소지하고 있거나 추가 신규시, 브랜드 중복
		else if(Iservice.chk_crd_exist(memberVO) > 0 && Iservice.chk_crd_Noexist1(memberVO) > 0 && memberVO.getAPPL_CLAS().equals("12")) {
			//조건: 추가신규 -> 기존 카드 존재여부, 브랜드 체크 (카드 있고, 브랜드 다르다)
			service.apply(memberVO);
			MemberVO mem = Cservice.get_rcv_d(memberVO);
			memberVO.setRCV_D(mem.getRCV_D());
			memberVO.setIMPSB_CD("04");
			
			Cservice.upd_imp_status(memberVO);
			System.out.println("추가신규 테스트 아아");
			return true;
		}
		
		// 불능코드 05 : 재발급 신청시, 기존카드 미존재
		else if(Iservice.chk_crd_Noexist1(memberVO) == 0 && memberVO.getAPPL_CLAS().equals("21")) {
			//재발급
			service.apply(memberVO);
			MemberVO mem = Cservice.get_rcv_d(memberVO);
			memberVO.setRCV_D(mem.getRCV_D());
			memberVO.setIMPSB_CD("05");
			
			Cservice.upd_imp_status(memberVO);
			System.out.println("재발급 테스트 아아");
			System.out.println("정신차리세요");
			System.out.println("정신차리세요");
			System.out.println("정신차리세요");
			System.out.println("정신차리세요");
			System.out.println("정신차리세요");
			System.out.println("정신차리세요");
			System.out.println("정신차리세요");
			System.out.println("정신차리세요");
			System.out.println("정신차리세요");
			System.out.println("정신차리세요");
			return true;
		}
		System.out.println("자늬..??");
		//service.apply(memberVO);
		System.out.println("머해..ㅋ..?");
		return false;
	}
	
	// 카드번호 생성 함수를 만들자아
	public String generateCNO(MemberVO memberVO) throws Exception {
		String CNO = "";
		if (memberVO.getBRD().equals("1")) {
			CNO += "531011";
		} else if (memberVO.getBRD().equals("2")) {
			CNO += "490611";
		} else if (memberVO.getBRD().equals("3")) {
			CNO += "356011";
		}
		CNO += Cservice.crd_no_seq();
		
		// [구현] 체크디지트를 생성한다.
		// 1. for문 CNO 길이만큼 loop
		// 2. 만약 현재 index가 홀수이면 각자리에 2를 곱하고, 짝수이면 각자리에 1을 곱한다.(자기자신이다)
		// 3. 두자리가 넘으면 각 자리수를 더한다.  <-- x
		// 4. for문이 다 돌면 모든 수를 더한다(TIP : for문 전에 var tmp 같은걸 생성해서 4번에서 구한 값을 더한다.)
		// 5. 10 - tmp의 값이 체크디지트 값이다.
		int lastNO = 0;
		
		for(int i=0; i<CNO.length(); i++) {
			if(i%2==0) {
				lastNO = lastNO + (CNO.charAt(i) - '0');
			} else if (i%2!=0) {
				int even = (CNO.charAt(i) - '0') * 2;
				if (even>9) {
					int a = (even%10) + (even/10);
					even = a;
				}
				lastNO = lastNO + even;
			}
		}
		lastNO =  10 - (lastNO%10);
		CNO = CNO + lastNO;
		
		
		return CNO;
	}
	
	// 입회신청에서 등록누르면 신청구분에 따른 리턴값
	@RequestMapping(value = "/appl_clas_chk", method = RequestMethod.POST)
	public String vocheck(MemberVO memberVO) throws Exception {//Model model, 
		String result = memberVO.getAPPL_CLAS();
		CustVO custvo = new CustVO();
		
		if (result.equals("11")) {
			System.out.println("제발....");
			// 고객테이블에서 처음 생성된 CUST_NO.SEQ가 결제TB, 카드TB에도 증가 없이 insert 되어야 한다
			String tmp = Cservice.cust_no_seq();
			memberVO.setCUST_NO(tmp);
			memberVO.setCRD_NO(generateCNO(memberVO));
			Cservice.insert_cust(memberVO);
			Cservice.insert_bill(memberVO);
			Cservice.insert_crd(memberVO);
			Cservice.upd_crdNo(memberVO);
			
			return null;
		} 
		else if (result.equals("12")) {
			// 추가신규
			// BRD는 이미 소지하고 있는 카드와 겹쳐서 안되며 한 사람이 최대 3장의 카드를 가질 수 있다 (한 브랜드 중복 신청 불가) - 불능에서 체크
			// 1. BRD 1,2,3 조회 2. 데이터가 있으면(if) return (else if)2-1. 없으면 아래 로직 실행
			// 2-1. 고객 TB에 REG_D = 최초입회일자(신청TB의 접수일자RCV_D)를 가지고 온다
			// 조회에서 가져온 값 set 하기
			// 새로운 카드번호 CRD_NO INSERT
			// member vo 에 가지고 와서 set 하고, 작업(update, insert)
			// 카드 TB에 REG_D = 현 카드 등록일자로 SYSDATE로 받아온다
			// 유효기간(BLD_DUR)은 REG_D + 5년
			
			// 주민번호로 고객정보 가지고 오는 쿼리짜기
			// 카드번호 생성해서 가져오기
			// 최초입회일자 최초신규 날짜를 시간으로 비교해서 제일 옛날꺼 - 신규등록일 때는 일단 오늘로 하고, 추가신규&재발급 일 때는 쿼리문에서 빼라고 하셨는데..?
			//Cservice.brdNfst(memberVO);
			
			//cust_no를 갖고오는 로직, 이전카드번호 갖고오는 로직 select를 만들어야 합니다.
			
			String tmp2 = Cservice.set_init_D(memberVO);
			System.out.println("확인 빨리 체크체크"+ Cservice.set_init_D(memberVO)+ "중간에 뭔가 구분할수 있게");
			
			MemberVO mem = Cservice.get_custNo(memberVO);
			memberVO.setCUST_NO(mem.getCUST_NO());
			memberVO.setCRD_NO(generateCNO(memberVO));
			System.out.println("오랜만에"+ memberVO.getCUST_NO() + "처음같은데");
			//Cservice.upd_cust_extra(memberVO);
			//Cservice.upd_bill_extra(memberVO);
			Cservice.insert_crd_extra(memberVO);
			return null;
		} 
		else if (result.equals("21")) {
			// 재발급은 카드 브랜드 세 개 중 하나라도 가진 사람만 가능
			// 신청인 A 기존 소지 카드 = visa 잃어버려서 재발급 역시 visa 일 때 CRD TB에 업데이트 되어야 하는 것 : 최종카드여부 수정 
			// 재발급 받기 전 카드는 업데이트하고 새로 발급 받는 카드는 insert
			// 전카드번호 가지고 물고있어야 if문 비교 가능
			
			//Cservice.upd_cust_renewal(memberVO);
			//Cservice.upd_bill_renewal(memberVO);
			MemberVO mem = Cservice.get_custNo(memberVO);
			memberVO.setCUST_NO(mem.getCUST_NO());
			memberVO.setCRD_NO(generateCNO(memberVO));
			mem = Cservice.get_BF_CRD_NO(memberVO);
			memberVO.setBF_CRD_NO(mem.getCRD_NO()); 
			System.out.println("오늘은"+ memberVO.getCUST_NO() + "여기" + memberVO.getBF_CRD_NO());
			Cservice.upd_crd_renewal(memberVO);
			Cservice.insert_crd_renewal(memberVO);
			return "forward:/renewal";
		} else
		return "redirect:/home";
	}
	
	// 입회신청서에서 "조회" 버튼 클릭 시 조회내역 화면
	@ResponseBody
	@RequestMapping(value = "chk_inquiry")
	public MemberVO chk_inquiry(@RequestBody Map<String,Object> params) throws Exception{//@RequestBody MemberVO memberVO   
		logger.info("chk_inquiry");
		logger.info("--------------" + params.get("SSN"));
		
		MemberVO memberVO = new MemberVO();
		params.get("SSN");
		memberVO.setSSN((String) params.get("SSN"));
		memberVO.setRCV_D((String) params.get("RCV_D"));
		memberVO.setRCV_SEQ_NO((String) params.get("RCV_SEQ_NO"));
		
		logger.info("-----------------------------" + memberVO.getSSN() + ", " + memberVO.getRCV_D() +", " + memberVO.getRCV_SEQ_NO());
		
		MemberVO items = service.chk_inquiry(memberVO);
		logger.info("멤버브이오============================================================" + memberVO.getRCV_D());
		
		return items;
	}
	
	
	// 기간별 입회신청 내역조회 화면으로 이동
	@RequestMapping(value = "/period", method = RequestMethod.GET)
	public void period(Locale locale, Model model) throws Exception{
		logger.info("period");
		
		List<MemberVO> APPL_CLAS = service.getAPPL_CLAS();
		model.addAttribute("APPL_CLAS", APPL_CLAS); // 신청구분 셀렉트박스
		
	}
	
	// 기간별 입회신청 내역조회 화면에서 "조회" 버튼 클릭 시 조회내역 화면
	@ResponseBody
	@RequestMapping(value = "period")
	public List<MemberVO> period(@RequestBody Map<String,Object> params) throws Exception{  
		logger.info("period");
		logger.info("--------------" + params.get("APPL_D"));
		
		MemberVO memberVO = new MemberVO();
		params.get("APPL_D");
		String tmp = (String)params.get("APPL_D1");
		tmp = tmp.replaceAll("-", "");
		params.get("APPL_D2");
		String tmp2 = (String)params.get("APPL_D2");
		tmp2 = tmp2.replaceAll("-", "");
		memberVO.setAPPL_D1(tmp);
		memberVO.setAPPL_D2(tmp2);
		memberVO.setAPPL_CLAS((String) params.get("APPL_CLAS"));
		memberVO.setSSN((String) params.get("SSN"));
		
		logger.info("-----------------------------" + memberVO.getAPPL_D1() + ", " + memberVO.getAPPL_CLAS() +", " + memberVO.getSSN());
		
		List<MemberVO> history = service.period(memberVO);
		logger.info("멤버브이오============================================================" + memberVO.getSSN());
		
		return history;
	}
	
	
	// 색인별 내역조회 화면으로 이동
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public void index(Locale locale, Model model) throws Exception{
		logger.info("index");
		
	}
	
	// 색인별 내역조회 화면에서 "조회" 버튼 클릭 시 조회내역 화면
	@ResponseBody
	@RequestMapping(value = "index")
	public List<MemberVO> index(@RequestBody Map<String,Object> params) throws Exception{  
		logger.info("index");
		logger.info("--------------" + params.get("HG_NM"));
		
		MemberVO memberVO = new MemberVO();
		memberVO.setHG_NM((String)params.get("HG_NM"));
		memberVO.setBIRTH_D((String)params.get("BIRTH_D"));
		memberVO.setHDP_NO((String)params.get("HDP_NO"));
		
		logger.info("-----------------------------" + memberVO.getHG_NM() + ", " + memberVO.getBIRTH_D() +", " + memberVO.getHDP_NO());
		
		List<MemberVO> cardhistory = service.index(memberVO);
		logger.info("멤버브이오============================================================" + memberVO.getHG_NM());
		
		return cardhistory;
	}
}