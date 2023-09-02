package com.bitc.project.vo;

import lombok.Data;

@Data
public class ChatVO {
	private int idn;
	private String id;
	private String nname;
	private String chat;
	
	public ChatVO(int idn, String id, String nname) {
		super();
		this.idn = idn;
		this.id = id;
		this.nname = nname;
	}
	
	
}
