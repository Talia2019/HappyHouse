package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.UserDto;

public interface UserService {

	void registerMember(UserDto userDto) throws Exception;
	UserDto login(Map<String, String> map) throws Exception;
	void updateUser(UserDto userDto) throws Exception;
//	String findPassword(Map<String, String> map) throws Exception;
	String findPassword(String userId, String name) throws Exception;
	void delete(String id) throws Exception;
	List<UserDto> userList() throws Exception;
	List<UserDto> searchListUser(String keyId) throws Exception;

}
