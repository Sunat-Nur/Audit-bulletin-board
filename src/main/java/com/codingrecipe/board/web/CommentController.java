package com.codingrecipe.board.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.codingrecipe.board.service.CommentService;
import com.codingrecipe.board.vo.CommentDTO;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/comment")
@RequiredArgsConstructor
public class CommentController {

	private final CommentService commentService;

	@Autowired
	public CommentController(CommentService commentService) {
		this.commentService = commentService;
	}

	@PostMapping("/save")
	public List<CommentDTO> save(@ModelAttribute CommentDTO commentDTO) {
		System.out.println("commentDTO = " + commentDTO);
		commentService.save(commentDTO);
		List<CommentDTO> commentDTOList = commentService.findAll(commentDTO.getBoardId());
		return commentDTOList;
	}

	// nested codes

	@GetMapping("/nested")
	public List<CommentDTO> getNestedComments(@RequestParam Long boardId) {
		return commentService.getNestedComments(boardId);
	}

	@GetMapping("/findById")
	public CommentDTO getCommentById(@RequestParam Long id) {
		return commentService.findById(id);
	}

	@PostMapping("/reply")
	public List<CommentDTO> replyToComment(@ModelAttribute CommentDTO commentDTO) {
		System.out.println("Replying to comment = " + commentDTO);
		commentService.save(commentDTO);
		List<CommentDTO> commentDTOList = commentService.findAll(commentDTO.getBoardId());
		return commentDTOList;
	}
}