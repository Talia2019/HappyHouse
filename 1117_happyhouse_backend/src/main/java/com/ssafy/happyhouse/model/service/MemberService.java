package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouse.model.MemberDto;

public interface MemberService {

	public MemberDto login(MemberDto memberDto) throws Exception;
	public MemberDto userInfo(String userid) throws Exception;
	public boolean deleteComment(String userid) throws Exception;
	public boolean deleteBoard(String userid) throws Exception;
	public boolean deleteWishList(String userid) throws Exception;
	public boolean deleteNotice(String userid) throws Exception;
	public boolean deleteMember(String userid) throws Exception;
	public boolean registerMember(MemberDto memberDto) throws Exception;
	public boolean updateMember(MemberDto memberDto) throws Exception;
	public boolean idCheck(String userid) throws Exception;
}
