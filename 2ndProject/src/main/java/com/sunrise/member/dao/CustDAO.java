package com.sunrise.member.dao;

import java.util.List;

import com.sunrise.member.vo.CustVO;
import com.sunrise.member.vo.MemberVO;

public interface CustDAO {
	
	// 신규등록
	// 고객TB 등록 (insert)
	public void insert_cust(MemberVO memberVO) throws Exception;
	
	// 결제TB 등록 (insert)
	public void insert_bill(MemberVO memberVO) throws Exception;
	
	// 카드TB 등록 (insert)
	public void insert_crd(MemberVO memberVO) throws Exception;
	
	// 신청TB 카드번호 (update)
	public void upd_crdNo(MemberVO memberVO) throws Exception;
	
	// RCV_D 값 가져오기
	public MemberVO get_rcv_d(MemberVO memberVO) throws Exception;
	
	// 신청TB에 불능구분, 불능코드 update
	public void upd_imp_status(MemberVO memberVO) throws Exception;
	
	// 고객번호 NEXTVAL
	public String cust_no_seq() throws Exception;
	
	// 카드번호 NEXTVAL
	public String crd_no_seq() throws Exception;
	
	// 하나의 고객번호 공통 insert
	public String comm_custNo(CustVO custVO) throws Exception;
	
	// 고객TB REG_D = 신청TB RCV_D , 최초입회일자 = 접수일자 set 하기
	public String set_init_D(MemberVO memberVO) throws Exception;
	
	
	//추가신규
	// 고객TB 업데이트 (update)
	public void upd_cust_extra(MemberVO memberVO) throws Exception;
	
	// 결제TB 업데이트 (update)
	public void upd_bill_extra(MemberVO memberVO) throws Exception;
	
	// 카드TB 등록 (insert)
	public void insert_crd_extra(MemberVO memberVO) throws Exception;

	// BRD 값 존재여부 확인, 최초등록일자 가져오기
	public List<MemberVO> brdNfst(MemberVO memberVO) throws Exception;
	
	// CRD TB에 이미 생성되어 있는 고객번호 가지고 오기
	public MemberVO get_custNo(MemberVO memberVO) throws Exception;
	
	
	// 재발급
	// BF_CRD_NO 가져오기
	public MemberVO get_BF_CRD_NO(MemberVO memberVO) throws Exception;
	
	// 카드TB 업데이트 (최종카드여부)
	public void upd_crd_renewal(MemberVO memberVO) throws Exception;
	
	// 재발급 카드 정보 카드TB에 등록 (insert)
	public void insert_crd_renewal(MemberVO memberVO) throws Exception;
}
