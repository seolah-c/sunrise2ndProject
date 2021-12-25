package com.sunrise.member.service;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import com.sunrise.member.dao.ImpsbDAO;
import com.sunrise.member.vo.MemberVO;

@Repository
public class ImpsbServiceImpl implements ImpsbService{

	@Inject
	private ImpsbDAO idao;
	
	// 당일 신청 내역 존재 체크
	@Override
	public int chk_Dday_history(MemberVO memberVO) throws Exception {
		int result = idao.chk_Dday_history(memberVO);
		return result;
	}
	
	// 기존 카드 존재 체크 (신규등록 신청 시 )
	@Override
	public int chk_crd_exist(MemberVO memberVO) throws Exception {
		int result = idao.chk_crd_exist(memberVO);
		return result;
	}
	
	// 기존 카드 존재, 미존재 체크 (추가 신청 시)
	@Override
	public int chk_crd_Noexist1(MemberVO memberVO) throws Exception {
		int result = idao.chk_crd_Noexist1(memberVO);
		return result;
	}
	
	// 기존 카드 존재, 미존재 체크 (재발급 신청 시)
	@Override
	public int chk_crd_Noexist(MemberVO memberVO) throws Exception {
		int result = idao.chk_crd_Noexist(memberVO);
		return result;
	}
}
