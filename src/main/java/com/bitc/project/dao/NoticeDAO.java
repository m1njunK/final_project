package com.bitc.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.Update;

import com.bitc.project.provider.BoardQueryProvider;
import com.bitc.project.util.SearchCriteria;
import com.bitc.project.util.Criteria;
import com.bitc.project.vo.NoticeVO;

public interface NoticeDAO {

	// 전체 목록 불러오기
	@Select("SELECT * FROM noticeBoard ORDER BY bno DESC limit #{startRow},#{perPageNum}")
	List<NoticeVO> noticeList(Criteria cri);
	// 게시글 하나 불러오기
	@Select("SELECT * FROM noticeBoard WHERE bno=#{bno}")
	NoticeVO readNotice(int bno);
	// 게시글 등록하기
	@Insert("INSERT INTO noticeBoard (title,content,auth,fixedNotice)VALUES(#{title},#{content},#{auth},#{fixedNotice})")
	int newNotice(NoticeVO vo);
	// 게시글 수정하기
	@Update("UPDATE noticeBoard SET title=#{title}, content=#{content}, fixedNotice=#{fixedNotice}, updatedate=now() WHERE bno=#{bno}")
	int updateNotice(NoticeVO vo);
	// 게시글 삭제하기
	@Delete("DELETE FROM noticeBoard WHERE bno=#{bno}")
	int deleteNotice(int bno);
	// 조회수 증가하기
	@Update("UPDATE noticeBoard SET vcnt = vcnt + 1 WHERE bno = #{bno}")
	int updateVcnt(int bno);
	// 좋아요 증가하기
	@Update("UPDATE noticeBoard SET likeCnt = likeCnt + 1 WHERE bno = #{bno}")
	int updateLikeCnt(int bno);
	// 전체 게시글 수
	@Select("SELECT count(*) FROM noticeBoard")
	int totalCount();
	// 고정한 공지사항만 들고오기
	@Select("SELECT * FROM noticeBoard WHERE fixedNotice=true ORDER BY updatedate DESC Limit 0, 5")
	List<NoticeVO> fixedNoticeList();
	
	// 검색 기능이 추가된 게시글 목록
	@SelectProvider(type=BoardQueryProvider.class, method="searchSelectSql")
	List<NoticeVO> searchList(SearchCriteria cri) throws Exception;
	//Search 된 결과의 게시물이 몇개인지 검색
	@SelectProvider(type=BoardQueryProvider.class, method="searchSelectCount")
	int searchListCount(SearchCriteria cri) throws Exception;
	
	
		
	
}
