package com.bitc.project.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class AuthDTO implements Serializable {

	private static final long serialVersionUID = 6493733453001687444L;

	private String u_id; // 사용자
	private String u_auth; // 권한

}
