package com.bitc.project.vo;

import lombok.Data;

@Data
public class NoteVO {
	
	private int nno;
    private String from_Id;
    private String to_Id;
    private String content;
    private String title;

}
