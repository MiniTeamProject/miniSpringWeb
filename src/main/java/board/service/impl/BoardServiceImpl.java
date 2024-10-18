package board.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.bean.BoardDTO;
import board.bean.BoardPaging;
import board.dao.BoardDAO;
import board.service.BoardService;

@Service
public class BoardServiceImpl implements BoardService {
    @Autowired
    private BoardDAO boardDAO;
    @Autowired
    private BoardPaging boardPaging;
    
    @Override
    public Map<String, Object> getBoardList(int pg) {
        int page = pg;
        int endNum = 6;
        int startNum = (page * endNum) - endNum;
        
        Map<String, Integer> map = new HashedMap<String, Integer>();
        map.put("startNum", startNum);
        map.put("endNum", endNum);
        
        List<BoardDTO> boardList = boardDAO.getBoardList(map);
        List<BoardDTO> boardHotList = boardDAO.getBoardHotList(map);
        
        //페이징 처리(a태그)
        int totalA = boardDAO.getTotalA();
        
        boardPaging.setTotalA(totalA);
        boardPaging.setCurrentPage(page);
        boardPaging.setPageBlock(5);
        boardPaging.setPageSize(endNum);
        boardPaging.makePagingHTML();
        
        Map<String, Object> pagingMap = new HashedMap<String, Object>();
        pagingMap.put("boardList", boardList);
        pagingMap.put("boardHotList", boardHotList);
        pagingMap.put("pg", page);
        pagingMap.put("boardPaging", boardPaging);
        
        return pagingMap;
    }
    
    @Override
    public int boardWrite(String id, String subject, String content, String category) {
        Map<String, String> map = new HashedMap<String, String>();
        map.put("id", id);
        map.put("subject", subject);
        map.put("content", content);
        map.put("category", category);
        
        return boardDAO.boardWrite(map);
    }
    
    @Override
    public int getRef(String id) {
    	return boardDAO.getRef(id);
    }
    
    @Override
    public List<BoardDTO> getboardView(int seq) {
        return boardDAO.getboardView(seq);
    }
    
    @Override
    public int boardUpdate(String id, String subject, String content, String category, int seq) {
        Map<String, Object> map = new HashedMap<String, Object>();
        map.put("id", id);
        map.put("subject", subject);
        map.put("content", content);
        map.put("category", category);
        map.put("seq", seq);
        return boardDAO.boardUpdate(map);
    }
    
    @Override
    public int boardDelete(Map<String, Object> map) {
        return boardDAO.boardDelete(map);
    }
    
    @Override
    public boolean increaseHit(int seq) {
        int result = boardDAO.increaseHit(seq);
        return result > 0; // 결과가 0보다 크면 성공, 그렇지 않으면 실패
    }
}
