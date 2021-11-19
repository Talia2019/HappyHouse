package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.BoardDto;
import com.ssafy.happyhouse.model.BoardParameterDto;
import com.ssafy.happyhouse.model.CommentDto;
import com.ssafy.happyhouse.model.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
	private BoardMapper boardMapper;
    
	@Override
	public boolean writeArticle(BoardDto boardDto) throws Exception {
		if(boardDto.getSubject() == null || boardDto.getContent() == null) {
			throw new Exception();
		}
		return boardMapper.writeArticle(boardDto) == 1;
	}

	@Override
	public List<BoardDto> listArticle(BoardParameterDto boardParameterDto) throws Exception {
		int start = boardParameterDto.getPg() == 0 ? 0 : (boardParameterDto.getPg() - 1) * boardParameterDto.getSpp();
		boardParameterDto.setStart(start);
		return boardMapper.listArticle(boardParameterDto);
	}

	@Override
	public BoardDto getArticle(int articleno) throws Exception {
		return boardMapper.getArticle(articleno);
	}

	@Override
	public void updateHit(int articleno) throws Exception {
		boardMapper.updateHit(articleno);
	}

	@Override
	public boolean modifyArticle(BoardDto boardDto) throws Exception {
		return boardMapper.modifyArticle(boardDto) == 1;
	}

	@Override
	public boolean deleteArticle(int articleno) throws Exception {
//		boardMapper.deleteMemo(articleno);
		return boardMapper.deleteArticle(articleno) == 1;
	}

	@Override
	public int getTotalCount(BoardParameterDto boardParameterDto) throws Exception {
		return boardMapper.getTotalCount(boardParameterDto);
	}

	@Override
	public boolean writeComment(CommentDto commentDto) throws Exception {
		if(commentDto.getContent() == null) {
			throw new Exception();
		}
		return boardMapper.writeComment(commentDto) == 1;
	}

}
