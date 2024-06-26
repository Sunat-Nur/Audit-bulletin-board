//package com.codingrecipe.board.service;
//
//import com.codingrecipe.board.vo.BoardDTO;
//import com.codingrecipe.board.vo.PageDTO;
//import com.codingrecipe.board.repository.BoardRepository;
//import lombok.RequiredArgsConstructor;
//import org.springframework.stereotype.Service;
//
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//@Service
//@RequiredArgsConstructor
//public class BoardService {
//    private final BoardRepository boardRepository;
//    
//    // Constructor for initializing final fields
//    public BoardService(BoardRepository boardRepository) {
//        this.boardRepository = boardRepository;
//    }
//    
//    public int save(BoardDTO boardDTO) {
//        return boardRepository.save(boardDTO);
//    }
//
//    public List<BoardDTO> findAll() {
//        return boardRepository.findAll();
//    }
//
//    public BoardDTO findById(Long id) {
//        return boardRepository.findById(id);
//    }
//
//    public void updateHits(Long id) {
//        boardRepository.updateHits(id);
//    }
//
//    public void delete(Long id) {
//        boardRepository.delete(id);
//    }
//
//    public void update(BoardDTO boardDTO) {
//        boardRepository.update(boardDTO);
//    }
//
//    int pageLimit = 3; 
//    int blockLimit = 3;
//    public List<BoardDTO> pagingList(int page) {
//        /*
//            1page => 0
//            2page => 3
//            3page => 6
//         */
//        int pagingStart = (page - 1) * pageLimit;
//        Map<String, Integer> pagingParams = new HashMap<>();
//        pagingParams.put("start", pagingStart);
//        pagingParams.put("limit", pageLimit);
//        List<BoardDTO> pagingList = boardRepository.pagingList(pagingParams);
//
//        return pagingList;
//    }
//
//    public PageDTO pagingParam(int page) {
//        int boardCount = boardRepository.boardCount();
//        int maxPage = (int) (Math.ceil((double) boardCount / pageLimit));
//        int startPage = (((int)(Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
//        int endPage = startPage + blockLimit - 1;
//        if (endPage > maxPage) {
//            endPage = maxPage;
//        }
//        PageDTO pageDTO = new PageDTO();
//        pageDTO.setPage(page);
//        pageDTO.setMaxPage(maxPage);
//        pageDTO.setStartPage(startPage);
//        pageDTO.setEndPage(endPage);
//        return pageDTO;
//    }
//}





package com.codingrecipe.board.service;

import com.codingrecipe.board.vo.BoardDTO;
import com.codingrecipe.board.vo.PageDTO;
import com.codingrecipe.board.vo.CommentDTO;
import com.codingrecipe.board.repository.BoardRepository;
import com.codingrecipe.board.repository.CommentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class BoardService {
    private final BoardRepository boardRepository;
    private final CommentRepository commentRepository; // Add CommentRepository dependency
    
    public BoardService(BoardRepository boardRepository, CommentRepository commentRepository) {
        this.boardRepository = boardRepository;
        this.commentRepository = commentRepository;
    }

    public int save(BoardDTO boardDTO) {
        return boardRepository.save(boardDTO);
    }

    public List<BoardDTO> findAll() {
        List<BoardDTO> boardList = boardRepository.findAll();
        for (BoardDTO board : boardList) {
            List<CommentDTO> comments = commentRepository.findAll(board.getId());
            board.setCommentList(comments);
        }
        return boardList;
    }

    public BoardDTO findById(Long id) {
        BoardDTO boardDTO = boardRepository.findById(id);
        List<CommentDTO> comments = commentRepository.findAll(id);
        boardDTO.setCommentList(comments);
        return boardDTO;
    }

    public void updateHits(Long id) {
        boardRepository.updateHits(id);
    }

    public void delete(Long id) {
        boardRepository.delete(id);
    }

    public void update(BoardDTO boardDTO) {
        boardRepository.update(boardDTO);
    }

    int pageLimit = 3; 
    int blockLimit = 3;
    public List<BoardDTO> pagingList(int page) {
        int pagingStart = (page - 1) * pageLimit;
        Map<String, Integer> pagingParams = new HashMap<>();
        pagingParams.put("start", pagingStart);
        pagingParams.put("limit", pageLimit);
        List<BoardDTO> pagingList = boardRepository.pagingList(pagingParams);
        for (BoardDTO board : pagingList) {
            List<CommentDTO> comments = commentRepository.findAll(board.getId());
            board.setCommentList(comments);
        }
        return pagingList;
    }

    public PageDTO pagingParam(int page) {
        int boardCount = boardRepository.boardCount();
        int maxPage = (int) (Math.ceil((double) boardCount / pageLimit));
        int startPage = (((int)(Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
        int endPage = startPage + blockLimit - 1;
        if (endPage > maxPage) {
            endPage = maxPage;
        }
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setMaxPage(maxPage);
        pageDTO.setStartPage(startPage);
        pageDTO.setEndPage(endPage);
        return pageDTO;
    }
}