package com.bitc.project.vo;

import java.util.Date;

import lombok.Data;

@Data
public class FreeBoardCommentVO {
	
	private int commentID;
	private int freeBoardBNO;
	private String commentContent;
	private String commenterID;
	private Date commentDate;
	
}
