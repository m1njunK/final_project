package com.bitc.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.project.util.Criteria;
import com.bitc.project.util.SearchCriteria;
import com.bitc.project.vo.FreeBoardVO;
import com.bitc.project.vo.ImageBoardVO;

@Mapper
public interface FreeBoardDAO {

	@Insert("INSERT INTO FreeBoard VALUES(0,#{title},#{content},#{auth},now(),0,0,false,0)")
    int createFreeBoard(FreeBoardVO board);

    @Select("SELECT * FROM FreeBoard WHERE bno = #{bno}")
    FreeBoardVO read(int bno);

    @Select("SELECT * FROM FreeBoard WHERE del = false ORDER BY bno DESC limit #{startRow},#{perPageNum}")
    List<FreeBoardVO> listCriteria(Criteria cri);

    @Select("SELECT count(*) FROM FreeBoard")
    int totalCount();
    
	@Select("SELECT count(*) FROM freeBoard WHERE ${searchType} LIKE CONCAT('%',#{searchValue},'%') AND del = false")
	int searchCount(SearchCriteria cri);

    @Update("UPDATE freeBoard SET vcnt = vcnt + 1 WHERE bno = #{bno}")
    void updateCnt(int bno);
    
    @Update("UPDATE freeBoard SET del = true WHERE bno = #{bno}")
	int remove(int bno);
    
    @Update("UPDATE freeBoard SET title = #{title}, content = #{content} WHERE bno = #{bno}")
    int modify(FreeBoardVO vo);
    
    @Select("SELECT * FROM freeBoard WHERE ${searchType} LIKE CONCAT('%',#{searchValue},'%') AND del = false ORDER BY bno limit #{startRow},#{perPageNum}")
	List<FreeBoardVO> searchList(SearchCriteria cri);
}
