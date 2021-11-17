package com.ssafy.happyhouse.model;

import java.util.Date;

public class BoardDto {
	private int boardNo;
	private String userId;
	private String subject;
	private String content;
	private int hit;
	private Date regTime;

	public BoardDto(int boardNo, String userId, String subject, String content, int hit, Date regTime) {
		super();
		this.boardNo = boardNo;
		this.userId = userId;
		this.subject = subject;
		this.content = content;
		this.hit = hit;
		this.regTime = regTime;
	}

	public BoardDto() {
		// TODO Auto-generated constructor stub
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

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public Date getRegTime() {
		return regTime;
	}

	public void setRegTime(Date regTime) {
		this.regTime = regTime;
	}

}
