package com.sunrise.member.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sunrise.member.dao.CustDAO;
import com.sunrise.member.vo.CustVO;
import com.sunrise.member.vo.MemberVO;

@Service
public class CustServiceImpl implements CustService {
	
	@Inject
	private CustDAO cdao;
	// 고객TB 등록 (insert)
	@Override
	public void insert_cust(MemberVO memberVO) throws Exception {
		cdao.insert_cust(memberVO);
	}

	// 결제TB 등록 (insert)
	@Override
	public void insert_bill(MemberVO memberVO) throws Exception {
		cdao.insert_bill(memberVO);
	}

	// 카드TB 등록 (insert)
	@Override
	public void insert_crd(MemberVO memberVO) throws Exception {
		cdao.insert_crd(memberVO);
	}
	
	// 신청TB 카드번호 (update)
	@Override
	public void upd_crdNo(MemberVO memberVO) throws Exception {
		cdao.upd_crdNo(memberVO);
	}
	
	// RCV_D 값 가져오기
	@Override
	public MemberVO get_rcv_d(MemberVO memberVO) throws Exception {
		 return cdao.get_rcv_d(memberVO);
	}
	
	// 신청TB에 불능구분, 불능코드 update
	@Override
	public void upd_imp_status(MemberVO memberVO) throws Exception {
		cdao.upd_imp_status(memberVO);
	}
	
	// 고객번호 NEXTVAL
	@Override
	public String cust_no_seq() throws Exception {
		return cdao.cust_no_seq();
	}
	
	// 카드번호 NEXTVAL
	@Override
	public String crd_no_seq() throws Exception {
		return cdao.crd_no_seq();
	}
	
	// 고객TB REG_D = 신청TB RCV_D , 최초입회일자 = 접수일자 set 하기
	@Override
	public String set_init_D(MemberVO memberVO) throws Exception {
		return cdao.set_init_D(memberVO);
	}
	
	// 하나의 고객번호 공통 insert
	@Override
	public String comm_custNo(CustVO custVO) throws Exception {
		return cdao.comm_custNo(custVO);
	}
	
	
	
	//추가신규
	// 고객TB 등록 (insert)
	@Override
	public void upd_cust_extra(MemberVO memberVO) throws Exception {
		cdao.upd_cust_extra(memberVO);
	}

	// 결제TB 등록 (insert)
	@Override
	public void upd_bill_extra(MemberVO memberVO) throws Exception {
		cdao.upd_bill_extra(memberVO);
	}

	// 카드TB 등록 (insert)
	@Override
	public void insert_crd_extra(MemberVO memberVO) throws Exception {
		cdao.insert_crd_extra(memberVO);
	}

	// BRD 값 존재여부 확인, 최초등록일자 가져오기
	@Override
	public List<MemberVO> brdNfst(MemberVO memberVO) throws Exception {
		List<MemberVO> brdNfst = cdao.brdNfst(memberVO);
		return brdNfst;
	}
	
	// CRD TB에 이미 생성되어 있는 고객번호 가지고 오기
	@Override
	public MemberVO get_custNo(MemberVO memberVO) throws Exception {
		 return cdao.get_custNo(memberVO);
	}
	
	
	// 재발급
	// CRD TB에 이미 생성되어 있는 고객번호 가지고 오기
	@Override
	public MemberVO get_BF_CRD_NO(MemberVO memberVO) throws Exception {
		 return cdao.get_BF_CRD_NO(memberVO);
	}
	
	// 카드TB 업데이트 (최종카드여부)
	@Override
	public void upd_crd_renewal(MemberVO memberVO) throws Exception {
		cdao.upd_crd_renewal(memberVO);
	}
	
	// 재발급 카드 정보 카드TB에 등록 (insert)
	@Override
	public void insert_crd_renewal(MemberVO memberVO) throws Exception {
		cdao.insert_crd_renewal(memberVO);
	}
}
