package com.ssafy.happyhouse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssafy.happyhouse.model.HouseDealDto;
import com.ssafy.happyhouse.model.service.WishService;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/wish")
public class WishController {
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";

	@Autowired
	private WishService wishService;

	@ApiOperation(value = "인기 관심순위", notes = "관심순위 수 기준 top 3 반환.", response = List.class)
	@GetMapping("/top")
	public ResponseEntity<List<HouseDealDto>> topArticle() throws Exception {
		return new ResponseEntity<List<HouseDealDto>>(wishService.topHouseDeal(), HttpStatus.OK);
	}

}
