package com.bitc.project.util;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageMaker {
	
	private int totalCount;		// 전체 게시물 수
	private int startPage;		// 화면에 보여질 시작 페이지 번호
	private int endPage;		// 화면에 보여질 마지막 페이지 번호
	private int maxPage;		// 전체 페이지에 마지막 페이지 번호
	private int displayPageNum;	// 한번에 보여줄 페이지 번호 개수
	private boolean first;		// 첫페이지 이동 가능 여부
	private boolean last;		// 마지막페이지 이동 가능 여부
	private boolean prev;		// 이전페이지 블럭 존재 여부
	private boolean next;		// 마지막페이지 블럭 존재 여부
	
	protected Criteria cri;		// 요청 페이지 , 한번에 보여줄 게시물 수
	
	public PageMaker() {
		this(new Criteria(),0);
	}
	
	public PageMaker(Criteria cri, int totalCount) {
		this.displayPageNum = 5;
		this.cri = cri;
		this.totalCount = totalCount;
		calcPaging();
	}
	
	private void calcPaging() {
		endPage = (int)Math.ceil(cri.getPage() / (double)displayPageNum)*displayPageNum;
		
		startPage = (endPage - displayPageNum) + 1;
		
		maxPage = (int)Math.ceil(totalCount / (double)cri.getPerPageNum());
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		first = (cri.getPage() != 1) ? true : false;
		last = (cri.getPage() != maxPage) ? true : false;
		prev = (startPage != 1) ? true : false;
		next = (endPage == maxPage) ? false : true;
	}
	
	public void setCri(Criteria cri) {
		this.cri = cri;
		calcPaging();
	}
	
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
		calcPaging();
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcPaging();
	}
	
	
	public String mkQueryStr(int page) {
		UriComponents uriComponents 
			= UriComponentsBuilder.newInstance()
			  .queryParam("page",page)
			  .queryParam("perPageNum", cri.getPerPageNum())
			  .build();
		String query = uriComponents.toUriString();
		return query;
	}
	
}








