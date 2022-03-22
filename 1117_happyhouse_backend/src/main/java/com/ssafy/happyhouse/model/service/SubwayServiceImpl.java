package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.SubwayDto;
import com.ssafy.happyhouse.model.mapper.SubwayMapper;

@Service
public class SubwayServiceImpl implements SubwayService {

    @Autowired
	private SubwayMapper subwayMapper;
    
	@Override
	public List<String> getList(int number) throws Exception {
		return subwayMapper.getList(number);
	}

	@Override
	public SubwayDto getSubway(String number, String name) throws Exception {
		return subwayMapper.getSubway(number, name);
	}

	@Override
	public String getGugunCode(String name) throws Exception {
		return subwayMapper.getGugunCode(name);
	}

}
