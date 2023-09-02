package com.bitc.project.vo;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeCommentVO {
	
	private int commentNO;
	private int noticeBNO;
	private String commentContent;
	private String commenterID;
	private Date commentDate;
	
}