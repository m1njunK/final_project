package com.bitc.project.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ImageBoardCommentVO {
	
	private int commentNO;
	private int imageBoardBNO;
	private String commentContent;
	private String commenterID;
	private Date commentDate;
	
}
