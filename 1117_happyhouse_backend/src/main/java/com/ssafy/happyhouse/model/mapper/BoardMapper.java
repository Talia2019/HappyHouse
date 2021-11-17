package com.ssafy.happyhouse.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.BoardDto;

@Mapper
public interface BoardMapper {

	public List<BoardDto> selectBoard();
	public BoardDto selectBoardByNo(int no);
	public int insertBoard(BoardDto board);
	public int updateBoard(BoardDto board);
	public int deleteBoard(int no);
}
