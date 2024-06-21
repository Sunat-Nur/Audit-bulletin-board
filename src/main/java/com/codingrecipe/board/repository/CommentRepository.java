package com.codingrecipe.board.repository;

import java.util.List;

//import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.codingrecipe.board.vo.CommentDTO;

import lombok.RequiredArgsConstructor;


@Repository
@RequiredArgsConstructor
public class CommentRepository {
	
    private final SqlSessionTemplate sql;
    
    // Constructor for initializing final fields
    @Autowired
    public CommentRepository(SqlSessionTemplate sql) {
        this.sql = sql;
    }

    public void save(CommentDTO commentDTO) {
        sql.insert("Comment.save", commentDTO);
    }

    public List<CommentDTO> findAll(Long boardId) {
        return sql.selectList("Comment.findAll", boardId);
    }
}