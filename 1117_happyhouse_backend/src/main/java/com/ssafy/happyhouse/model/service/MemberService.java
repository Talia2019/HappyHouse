package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.MemberDto;

public interface MemberService {

	public MemberDto login(MemberDto memberDto) throws Exception;
	public MemberDto userInfo(String userid) throws Exception;
	public int idCheck(String checkId) throws Exception;
	public void registerMember(MemberDto memberDto) throws Exception;
	
	public List<MemberDto> listMember() throws Exception;
	public MemberDto getMember(String userId) throws Exception;
	public void updateMember(MemberDto memberDto) throws Exception;
	public void deleteMember(String userId) throws Exception;
}
