package com.sunrise.member.service;

import java.util.List;



import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sunrise.member.dao.MemberDAO;
import com.sunrise.member.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Inject
	private MemberDAO dao;
	
	// 신청구분 셀렉트 박스 가져오기
	@Override
	public List<MemberVO> getAPPL_CLAS() throws Exception {
		List<MemberVO> APPL_CLAS = dao.getAPPL_CLAS();
		return APPL_CLAS;
	}

	// 브랜드 셀렉트 박스 가져오기
	@Override
	public List<MemberVO> getBRD() throws Exception {
		List<MemberVO> BRD = dao.getBRD();
		return BRD;
	}
	
	// 결제일자 셀렉트 박스 가져오기
	@Override
	public List<MemberVO> getSTL_DD() throws Exception {
		List<MemberVO> STL_DD = dao.getSTL_DD();
		return  STL_DD;
	}
	
	// 결제방법 셀렉트 박스 가져오기
	@Override
	public List<MemberVO> getSTL_MTD() throws Exception {
		List<MemberVO> STL_MTD = dao.getSTL_MTD();
		return STL_MTD;
	}
	
	// 결제은행 셀렉트 박스 가져오기
	@Override
	public List<MemberVO> getBNK_CD() throws Exception {
		List<MemberVO> BNK_CD = dao.getBNK_CD();
		return BNK_CD;
	}
	
	// 청구서 발송방법 셀렉트 박스 가져오기
	@Override
	public List<MemberVO> getSTMT_SND_MTD() throws Exception {
		List<MemberVO> STMT_SND_MTD = dao.getSTMT_SND_MTD();
		return STMT_SND_MTD;
	}
	
	// 신청서 작성
	@Override
	public void apply(MemberVO memberVO) throws Exception {
		dao.apply(memberVO);
	}
	

}
