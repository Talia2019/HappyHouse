package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.HouseDealDto;
import com.ssafy.happyhouse.model.mapper.WishMapper;

@Service
public class WishServiceImpl implements WishService {

    @Autowired
	private WishMapper wishMapper;
	@Override
	public List<HouseDealDto> topHouseDeal() throws Exception {
		return wishMapper.topHouseDeal();
	}

}
