package com.ssafy.happyhouse.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.SubwayDto;

@Mapper
public interface SubwayMapper {

	List<String> getList(int number) throws Exception;
	SubwayDto getSubway(String number, String name) throws Exception;
	String getGugunCode(String name) throws Exception;

}
