package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.HouseDealDto;
import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.WishListDto;

public interface HappyHouseMapService {

	List<SidoGugunCodeDto> getSido() throws Exception;
	List<SidoGugunCodeDto> getGugunInSido(String sido) throws Exception;
	List<HouseInfoDto> getDongInGugun(String gugun) throws Exception;
	String getAptInDong(String gugun, String time) throws Exception;
	List<HouseInfoDto> getAptInName(String name, String dong) throws Exception;
	boolean checkStar(HouseDealDto houseDealDto) throws Exception;
	boolean putUserHouse(WishListDto wishListDto) throws Exception;
	int checkUserHouse(String housename, String dongName) throws Exception;
	boolean plusStar(HouseDealDto houseDealDto) throws Exception;
	boolean minusStar(HouseDealDto houseDealDto) throws Exception;
	boolean deleteUserHouse(String userid, String aptdong)throws Exception;
	List<HouseDealDto> getStarHouse(String userid) throws Exception;
	
}
