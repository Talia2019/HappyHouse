package com.ssafy.happyhouse.model.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;
import org.json.XML;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.HouseDealDto;
import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.WishListDto;
import com.ssafy.happyhouse.model.mapper.HouseMapMapper;

@Service
public class HappyHouseMapServiceImpl implements HappyHouseMapService {

	
	@Autowired
	private SqlSession sqlSession;
	private HouseMapMapper houseMapMapper;
	
	@Override
	public List<SidoGugunCodeDto> getSido() throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getSido();
	}

	@Override
	public List<SidoGugunCodeDto> getGugunInSido(String sido) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getGugunInSido(sido);
	}

	@Override
	public List<HouseInfoDto> getDongInGugun(String gugun) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getDongInGugun(gugun);
	}

	@Override
	public String getAptInDong(String gugun, String time) throws Exception {
		String SERVICE_URL = "http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev";
		String SERVICE_KEY = "u44MPChIFRDby2KFIAjIZaKd2UzE5VLo0eStZUpzw80TOlqhr7JQpMVWNYTzWtnjyVodAPwD%2B81urU1N7DVv%2FQ%3D%3D";
		StringBuilder urlBuilder = new StringBuilder(SERVICE_URL);
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "=" + SERVICE_KEY);
		urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=1000");
		urlBuilder.append("&" + URLEncoder.encode("LAWD_CD", "UTF-8") + "=" + gugun);
		urlBuilder.append("&" + URLEncoder.encode("DEAL_YMD", "UTF-8") + "=" + time);
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn.getResponseCode());
		BufferedReader rd;
		if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));			
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		JSONObject xmlJSONObj = XML.toJSONObject(sb.toString());
		String jsonPrettyPrintString = xmlJSONObj.toString();
//		System.out.println(jsonPrettyPrintString);
		return jsonPrettyPrintString;
//		return sqlSession.getMapper(HouseMapMapper.class).getAptInDong(dong);
	}

	@Override
	public List<HouseInfoDto> getAptInName(String name, String dong) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getAptInName(name, dong);
	}

	@Override
	public boolean checkStar(HouseDealDto houseDealDto) throws Exception {
		if (houseDealDto.getHouseName() == null) {
			throw new Exception();
		}
		return sqlSession.getMapper(HouseMapMapper.class).checkStar(houseDealDto) == 1;
	}

	@Override
	public boolean putUserHouse(WishListDto wishListDto) throws Exception{
		return sqlSession.getMapper(HouseMapMapper.class).putUserHouse(wishListDto) == 1;
	}

	@Override
	public int checkUserHouse(String houseName, String dongName) throws Exception {
		if (houseName == null) {
			throw new Exception();
		}
		return sqlSession.getMapper(HouseMapMapper.class).checkUserHouse(houseName, dongName).size();
	}

	@Override
	public boolean plusStar(HouseDealDto houseDealDto) throws Exception{
		if (houseDealDto.getHouseDong() == null) {
			throw new Exception();
		}
		return sqlSession.getMapper(HouseMapMapper.class).plusStar(houseDealDto) == 1;
	}

	@Override
	public boolean minusStar(HouseDealDto houseDealDto) throws Exception{
		if (houseDealDto.getHouseDong() == null) {
			throw new Exception();
		}
		return sqlSession.getMapper(HouseMapMapper.class).minusStar(houseDealDto) == 1;
	}

	@Override
	public boolean deleteUserHouse(String userid, String aptdong) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).deleteUserHouse(userid, aptdong) == 1;
	}

	@Override
	public List<HouseDealDto> getStarHouse(String userid) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getStarHouse(userid);
	}
}
