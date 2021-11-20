package com.ssafy.happyhouse.model.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.MemberDto;

@Mapper
public interface MemberMapper {

	public MemberDto login(MemberDto memberDto) throws SQLException;
	public MemberDto userInfo(String userid) throws SQLException;
	
	public int idCheck(String checkId) throws Exception;
	public void registerMember(MemberDto memberDto) throws Exception;
	
	public List<MemberDto> listMember() throws Exception;
	public MemberDto getMember(String userId) throws Exception;
	public void updateMember(MemberDto memberDto) throws Exception;
	public void deleteMember(String userId) throws Exception;
}
