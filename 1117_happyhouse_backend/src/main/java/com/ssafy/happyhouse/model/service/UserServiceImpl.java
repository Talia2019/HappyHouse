package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.UserDto;
import com.ssafy.happyhouse.model.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void registerMember(UserDto userDto) throws Exception {
		sqlSession.getMapper(UserMapper.class).registerMember(userDto);
	}

	@Override
	public UserDto login(Map<String, String> map) throws Exception {
		return sqlSession.getMapper(UserMapper.class).login(map);
	}

	@Override
	public void updateUser(UserDto userDto) throws Exception {
		sqlSession.getMapper(UserMapper.class).updateUser(userDto);
	}

	@Override
	public String findPassword(String userId, String name) throws Exception {
		return sqlSession.getMapper(UserMapper.class).findPassword(userId, name);
	}

	@Override
	public void delete(String id) throws Exception {
		sqlSession.getMapper(UserMapper.class).deleteUser(id);
	}

	@Override
	public List<UserDto> userList() throws Exception {
		return sqlSession.getMapper(UserMapper.class).userList();
	}

	@Override
	public List<UserDto> searchListUser(String keyId) throws Exception {
		return sqlSession.getMapper(UserMapper.class).searchListUser(keyId);
	}

//	@Override
//	public String findPassword(Map<String, String> map) throws Exception {
//		return sqlSession.getMapper(UserMapper.class).findPassword(map);
//	}
	
}
