package com.sunrise.member.dao;

import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sunrise.member.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	// selectbox 신청구분 받기
	public List<MemberVO> getAPPL_CLAS() throws Exception{
		return sqlSession.selectList("memberMapper.getAPPL_CLAS");
	}
	
	@Override
	// selectbox 브랜드 받기
	public List<MemberVO> getBRD() throws Exception{
		return sqlSession.selectList("memberMapper.getBRD");
	}
	
	@Override
	// selectbox 결제일자 받기
	public List<MemberVO> getSTL_DD() throws Exception{
		return sqlSession.selectList("memberMapper.getSTL_DD");
	}
	
	@Override
	// selectbox 결제방법 받기
	public List<MemberVO> getSTL_MTD() throws Exception{
		return sqlSession.selectList("memberMapper.getSTL_MTD");
	}
	
	@Override
	// selectbox 결제은행 받기
	public List<MemberVO> getBNK_CD() throws Exception{
		return sqlSession.selectList("memberMapper.getBNK_CD");
	}
	
	@Override
	// selectbox 청구서 발송방법 받기
	public List<MemberVO> getSTMT_SND_MTD() throws Exception{
		return sqlSession.selectList("memberMapper.getSTMT_SND_MTD");
	}
	
	// 신청TB 등록
	@Override
	public void apply(MemberVO memberVO) throws Exception {
		sqlSession.insert("memberMapper.apply", memberVO);
	}
	
	// 신청TB 조회 결과 값 가지고 오기
	@Override
	public MemberVO chk_inquiry(MemberVO memberVO) throws Exception {
		return sqlSession.selectOne("memberMapper.chk_inquiry", memberVO);
	}
	
	// 기간별 내역조회 페이지 결과 값 가지고 오기
	@Override
	public List<MemberVO> period(MemberVO memberVO) throws Exception {
		return sqlSession.selectList("memberMapper.period", memberVO);
	}
	
	// 색인별 내역조회 페이지 결과 값 가지고 오기
	@Override
	public List<MemberVO> index(MemberVO memberVO) throws Exception {
		return sqlSession.selectList("memberMapper.index", memberVO);
	}
}