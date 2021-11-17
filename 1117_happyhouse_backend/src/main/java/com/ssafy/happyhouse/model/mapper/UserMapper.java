package com.ssafy.happyhouse.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.model.UserDto;

public interface UserMapper {

	void registerMember(UserDto userDto) throws Exception;
	UserDto login(Map<String, String> map) throws Exception;
	void updateUser(UserDto userDto) throws Exception;
//	String findPassword(Map<String, String> map) throws Exception;
	String findPassword(@Param("userId")String userId,@Param("name") String name) throws Exception;
	void deleteUser(String id) throws Exception;
	List<UserDto> userList() throws Exception;
	List<UserDto> searchListUser(String keyId) throws Exception;
}
