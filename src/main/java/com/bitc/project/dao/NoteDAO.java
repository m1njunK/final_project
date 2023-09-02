package com.bitc.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.bitc.project.util.Criteria;
import com.bitc.project.vo.NoteVO;

public interface NoteDAO {

	@Insert("INSERT INTO note (from_id, to_id, content, title) VALUES (#{from_Id}, #{to_Id}, #{content}, #{title})")
	void createNote(NoteVO noteVO);

	@Select("SELECT * FROM note WHERE to_id = #{id} limit #{cri.startRow},#{cri.perPageNum}")
    List<NoteVO> noteVOList(@Param("cri")Criteria cri,@Param("id") String id);

    @Select("SELECT * FROM note WHERE nno = #{nno}")
    NoteVO read(int nno);

    @Delete("DELETE FROM note WHERE nno = #{nno}")
    int delete(int nno);

    @Select("SELECT count(*) FROM note WHERE to_id = #{id}")
	int totalCount(String id);
    
    @Insert("INSERT INTO note (from_id, to_id, content, title) VALUES (#{from_Id}, #{to_Id}, #{content}, #{title})")
    void replyNote(NoteVO noteVO);
    
    

	
}
