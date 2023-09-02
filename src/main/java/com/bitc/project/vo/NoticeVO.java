package com.bitc.project.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class NoticeVO {
	private int bno;
	private String title;
	private String content;
	private String auth;
	private Date updatedate;
	private int vcnt;
	private int likeCount;
	private boolean fixedNotice;
	
	// 첨부된 파일 이름 리스트
	private List<String> files;
	
	// 해당 게시글에 추가된 댓글 개수
	private int commentCnt;

}

	