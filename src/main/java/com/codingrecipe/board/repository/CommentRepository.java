package com.codingrecipe.board.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.codingrecipe.board.vo.CommentDTO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CommentRepository {

	private final SqlSessionTemplate sql;

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

	public CommentDTO findById(Long id) {
		return sql.selectOne("Comment.findById", id);
	}

	// new nested configuration
	
	public List<CommentDTO> selectNestedComments(Long boardId) {
		return sql.selectList("Comment.selectNestedComments", boardId);
	}
}