package com.bitc.project.provider;

import org.apache.ibatis.jdbc.SQL;


import com.bitc.project.util.SearchCriteria;

public class BoardQueryProvider {
	
	
	public String searchSelectSql(SearchCriteria cri) {
		SQL sql = new SQL();
		sql.SELECT("*");
		sql.FROM("noticeBoard");
		
		getSearchWhere(cri, sql);
		
		sql.ORDER_BY("bno DESC");
		sql.LIMIT(cri.getStartRow()+", "+cri.getPerPageNum());
		String query = sql.toString();
		return query;
	}
	
	public String searchSelectCount(SearchCriteria cri) {
		SQL sql = new SQL();
		sql.SELECT("count(*)");
		sql.FROM("noticeBoard");
		getSearchWhere(cri, sql);
		return sql.toString();
	}
	
	
	public void getSearchWhere(SearchCriteria cri, SQL sql) {
		
		String titleQuery = "title LIKE CONCAT('%',#{searchValue},'%')";
		String contentQuery = "content LIKE CONCAT('%',#{searchValue},'%')";
		
		String type = cri.getSearchType();
		
		if(type != null 
			&& !type.trim().equals("")) {
			if(type.contains("title")) {
				sql.OR().WHERE(titleQuery);
			}
			if(type.contains("content")) {
				sql.OR().WHERE(contentQuery);
			}
			if(type.contains("all")) {
				sql.OR().WHERE(titleQuery);
				sql.OR().WHERE(contentQuery);
			}
		}
	}
	
	
}







