package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.BoardParameterDto;
import com.ssafy.happyhouse.model.NoticeDto;
import com.ssafy.happyhouse.model.mapper.NoticeMapper;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
	private NoticeMapper noticeMapper;
    
	@Override
	public boolean writeArticle(NoticeDto noticeDto) throws Exception {
		if(noticeDto.getSubject() == null || noticeDto.getContent() == null) {
			throw new Exception();
		}
		return noticeMapper.writeArticle(noticeDto) == 1;
	}

	@Override
	public List<NoticeDto> listArticle(BoardParameterDto boardParameterDto) throws Exception {
		int start = boardParameterDto.getPg() == 0 ? 0 : (boardParameterDto.getPg() - 1) * boardParameterDto.getSpp();
		boardParameterDto.setStart(start);
		return noticeMapper.listArticle(boardParameterDto);
	}

	@Override
	public NoticeDto getArticle(int articleno) throws Exception {
		return noticeMapper.getArticle(articleno);
	}

	@Override
	public void updateHit(int articleno) throws Exception {
		noticeMapper.updateHit(articleno);
	}

	@Override
	public boolean modifyArticle(NoticeDto noticeDto) throws Exception {
		return noticeMapper.modifyArticle(noticeDto) == 1;
	}

	@Override
	public boolean deleteArticle(int articleno) throws Exception {
		return noticeMapper.deleteArticle(articleno) == 1;
	}

	@Override
	public int getTotalCount(BoardParameterDto boardParameterDto) throws Exception {
		return noticeMapper.getTotalCount(boardParameterDto);
	}

}
