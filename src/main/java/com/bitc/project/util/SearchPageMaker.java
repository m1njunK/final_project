package com.bitc.project.util;

public class SearchPageMaker extends PageMaker{

	public SearchPageMaker() {
		super(new SearchCriteria(),0);
	}
 
	/**
	 * 검색 기능을 포함한 queryString을 완성해서 반환
	 */
	@Override
	public String mkQueryStr(int page) {
		StringBuilder sb = new StringBuilder(super.mkQueryStr(page));
		SearchCriteria searchCri = null;
		if(super.cri instanceof SearchCriteria) {
			searchCri = (SearchCriteria)super.cri;
			if(searchCri.getSearchType() != null && searchCri.getSearchValue() != null) {
				sb.append("&searchType="+searchCri.getSearchType());
				sb.append("&searchValue="+searchCri.getSearchValue());
			}
		}
		return sb.toString();
	}
	
}













