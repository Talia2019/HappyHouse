package com.ssafy.happyhouse.model;

public class CommentDto {
	int commentNo;
	int boardNo;
	String userId;
	String content;
	String regTime;

	public CommentDto() {
		// TODO Auto-generated constructor stub
	}

	public CommentDto(int commentNo, int boardNo, String userId, String content, String regTime) {
		super();
		this.commentNo = commentNo;
		this.boardNo = boardNo;
		this.userId = userId;
		this.content = content;
		this.regTime = regTime;
	}

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegTime() {
		return regTime;
	}

	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}
}
