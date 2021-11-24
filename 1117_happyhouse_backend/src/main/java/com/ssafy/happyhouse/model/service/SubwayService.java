package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.SubwayDto;

public interface SubwayService {

	List<String> getList(int number) throws Exception;
	SubwayDto getSubway(String number, String name) throws Exception;
	String getGugunCode(String name) throws Exception;

}
