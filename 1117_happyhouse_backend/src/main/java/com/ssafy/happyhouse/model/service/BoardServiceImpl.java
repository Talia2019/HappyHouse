package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.BoardDto;
import com.ssafy.happyhouse.model.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
	private BoardMapper boardMapper;
//	@Autowired
//	private SqlSession sqlSession;
    
	@Override
	public List<BoardDto> retrieveBoard() {
		return boardMapper.selectBoard();
//		sqlSession.getMapper(UserMapper.class).registerMember(userDto);
	}

	@Override
	public BoardDto detailBoard(int no) {
		return boardMapper.selectBoardByNo(no);
	}

	@Override
	public boolean writeBoard(BoardDto board) {
		return boardMapper.insertBoard(board) == 1;
	}

	@Override
	public boolean updateBoard(BoardDto board) {
		return boardMapper.updateBoard(board) == 1;
	}

	@Override
	public boolean deleteBoard(int no) {
		return boardMapper.deleteBoard(no) == 1;
	}

}
