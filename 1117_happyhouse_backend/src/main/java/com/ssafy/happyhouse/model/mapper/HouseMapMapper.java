package com.ssafy.happyhouse.model.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.HouseDealDto;
import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.WishListDto;

@Mapper
public interface HouseMapMapper {
	
	List<SidoGugunCodeDto> getSido() throws SQLException;
	List<SidoGugunCodeDto> getGugunInSido(String sido) throws SQLException;
	List<HouseInfoDto> getDongInGugun(String gugun) throws SQLException;
	List<HouseInfoDto> getAptInDong(String gugun) throws SQLException;
	List<HouseInfoDto> getAptInName(String name, String dong) throws SQLException;
	int checkStar(HouseDealDto houseDealDto) throws SQLException;
	List<HouseDealDto> checkUserHouse(String houseName, String dongName) throws SQLException;
	int putUserHouse(WishListDto wishListDto) throws SQLException;
	int plusStar(HouseDealDto houseDealDto) throws SQLException;
	int minusStar(HouseDealDto houseDealDto) throws SQLException;
	int deleteUserHouse(String userid, String aptname, String dongname)throws SQLException;
	List<HouseDealDto> getStarHouse(String userid) throws SQLException;
}
