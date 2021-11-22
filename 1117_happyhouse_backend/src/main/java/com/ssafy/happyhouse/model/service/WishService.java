package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.HouseDealDto;

public interface WishService {

	List<HouseDealDto> topHouseDeal() throws Exception;

}
