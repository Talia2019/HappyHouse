package com.ssafy.happyhouse.model;

public class NoticeDto {
	private int noticeNo;
	private String userId;
	private String subject;
	private String content;
	private int hit;
	private String regTime;

	public NoticeDto(int noticeNo, String userId, String subject, String content, int hit, String regTime) {
		super();
		this.noticeNo = noticeNo;
		this.userId = userId;
		this.subject = subject;
		this.content = content;
		this.hit = hit;
		this.regTime = regTime;
	}

	public NoticeDto() {
		// TODO Auto-generated constructor stub
	}

	public int getnoticeNo() {
		return noticeNo;
	}

	public void setnoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
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

	public String getRegTime() {
		return regTime;
	}

	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

}
