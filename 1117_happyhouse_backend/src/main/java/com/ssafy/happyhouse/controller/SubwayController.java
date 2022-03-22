package com.ssafy.happyhouse.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.SubwayDto;
import com.ssafy.happyhouse.model.service.SubwayService;

@RestController
@RequestMapping("/subway")
public class SubwayController {
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";

	@Autowired
	private SubwayService subwayService;

	@GetMapping("/list/{number}")
	public ResponseEntity<List<String>> getList(@PathVariable("number") int number) throws Exception {
		return new ResponseEntity<List<String>>(subwayService.getList(number), HttpStatus.OK);
	}

	@GetMapping
	public ResponseEntity<Map<String, Object>> getSubway(@RequestParam("number") String number, @RequestParam("name") String name)
			throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = null;
		try {
			SubwayDto subway = subwayService.getSubway(number, name);
			if(subway != null) {
				resultMap.put("subway", subway);
				resultMap.put("message", SUCCESS);
				status = HttpStatus.ACCEPTED;
			}else {
				resultMap.put("message", FAIL);
				status = HttpStatus.ACCEPTED;	
			}
		} catch (Exception e) {
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}

//	@GetMapping
//	public ResponseEntity<SubwayDto> getSubway(@RequestParam("number") String number, @RequestParam("name") String name)
//			throws Exception {
//		System.out.println(number + " " + name);
//		return new ResponseEntity<SubwayDto>(subwayService.getSubway(number, name), HttpStatus.OK);
//	}

	@GetMapping("/gugun/{name}")
	public ResponseEntity<String> getGugunCode(@PathVariable("name") String name) throws Exception {
		return new ResponseEntity<String>(subwayService.getGugunCode(name), HttpStatus.OK);
	}

}
