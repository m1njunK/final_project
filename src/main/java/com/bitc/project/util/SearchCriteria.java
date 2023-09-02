package com.bitc.project.util;

/**
 * 검색 기능이 추가된 
 * 기준 class
 */
public class SearchCriteria extends Criteria{
	/**
	 * 검색 키워드 타입
	 */
	private String searchType;
	/**
	 * 검색 키워드
	 */
	private String searchValue;
	
	 
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchValue() {
		return searchValue;
	}
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	
	@Override
	public String toString() {
		return super.toString()+" SearchCriteria [searchType=" + searchType + ", searchValue=" + searchValue + "]";
	}
	
}









