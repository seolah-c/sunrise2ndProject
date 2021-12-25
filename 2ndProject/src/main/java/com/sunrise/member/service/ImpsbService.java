package com.sunrise.member.service;

import com.sunrise.member.vo.MemberVO;

public interface ImpsbService {

	// 당일 신청 내역 존재 체크
	public int chk_Dday_history(MemberVO memberVO) throws Exception;
	
	// 기존 카드 존재 체크 (신규등록 신청 시 )
	public int chk_crd_exist(MemberVO memberVO) throws Exception;
	
	// 기존 카드 존재, 미존재 체크 (추가 신청 시)
	public int chk_crd_Noexist1(MemberVO memberVO) throws Exception;
	
	// 기존 카드 존재, 미존재 체크 (재발급 신청 시)
	public int chk_crd_Noexist(MemberVO memberVO) throws Exception;
}
