package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.BoardParameterDto;
import com.ssafy.happyhouse.model.NoticeDto;

public interface NoticeService {

	public boolean writeArticle(NoticeDto noticeDto) throws Exception;
	public List<NoticeDto> listArticle(BoardParameterDto boardParameterDto) throws Exception;
	public NoticeDto getArticle(int articleno) throws Exception;
	public void updateHit(int articleno) throws Exception;
	public boolean modifyArticle(NoticeDto noticeDto) throws Exception;
	public boolean deleteArticle(int articleno) throws Exception;
	public int getTotalCount(BoardParameterDto boardParameterDto) throws Exception;
	
}
