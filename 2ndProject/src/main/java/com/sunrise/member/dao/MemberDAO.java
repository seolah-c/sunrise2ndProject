package com.sunrise.member.dao;

import java.util.List;


import com.sunrise.member.vo.MemberVO;

public interface MemberDAO {
	
	// 신청구분 셀렉트 밗 가져오기
	public List<MemberVO> getAPPL_CLAS() throws Exception;
	
	// 브랜드 셀렉트 박스 가져오기
	public List<MemberVO> getBRD() throws Exception;
	
	// 결제일자 셀렉트 박스 가져오기
	public List<MemberVO> getSTL_DD() throws Exception;
	
	// 결제방법 셀렉트 박스 가져오기
	public List<MemberVO> getSTL_MTD() throws Exception;

	// 결제은행 셀렉트 박스 가져오기
	public List<MemberVO> getBNK_CD() throws Exception;
	
	// 청구서 발송방법 셀렉트 박스 가져오기
	public List<MemberVO> getSTMT_SND_MTD() throws Exception;
	
	// 신청TB 등록 (insert)
	public void apply(MemberVO memberVO) throws Exception;
	
	// 신청TB 조회 결과 값 가지고 오기
	public MemberVO chk_inquiry(MemberVO memberVO) throws Exception;
	
	// 기간별 내역조회 페이지 결과 값 가지고 오기
	public List<MemberVO> period(MemberVO memberVO) throws Exception;
	
	// 색인별 내역조회 페이지 결과 값 가지고 오기
	public List<MemberVO> index(MemberVO memberVO) throws Exception;
}
