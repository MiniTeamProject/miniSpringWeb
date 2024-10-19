package comment.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import comment.bean.CommentDTO;
import comment.bean.CommentPaging;
import comment.dao.CommentDAO;
import comment.service.CommentService;

@Service
public class CommentServiceImpl implements CommentService {
    @Autowired
    private CommentDAO commentDAO;
    @Autowired
    private CommentPaging commentPaging;
    
    @Override
    public Map<String, Object> getCommentView(int seq, int commentpg) {
    	int ref = seq;
    	int page = commentpg;
        int endNum = 6; // 한 페이지에 표시할 댓글 수
        int startNum = (page * endNum) - endNum;
        
        Map<String, Integer> map = new HashMap<>(); // HashMap 사용
        map.put("startNum", startNum);
        map.put("endNum", endNum);
        map.put("ref", ref);
        
        List<CommentDTO> commentList = commentDAO.getCommentList(map); // 댓글 목록 가져오기
        int totalComments = commentDAO.getTotalComments(ref); // 총 댓글 수 가져오기
        
        // 페이징 처리
        commentPaging.setTotalA(totalComments); // 총 댓글 수 설정
        commentPaging.setCurrentPage(page); // 현재 페이지 설정
        commentPaging.setPageBlock(5); // 페이지 블록 수 설정
        commentPaging.setPageSize(endNum); // 페이지당 댓글 수 설정
        commentPaging.makePagingHTML(); // 페이징 HTML 생성

        Map<String, Object> pagingMap = new HashMap<>(); // HashMap 사용
        pagingMap.put("commentList", commentList); // 댓글 목록 추가
        pagingMap.put("pg", page); // 현재 페이지 정보 추가
        pagingMap.put("commentPaging", commentPaging); // 페이징 정보 추가
        
        return pagingMap; // 결과 반환
    }
    
    @Override
    public boolean writeComment(CommentDTO commentDTO) {
        int result = commentDAO.writeComment(commentDTO); // DAO를 통해 DB에 댓글 추가
        return result > 0; // 성공 시 true, 실패 시 false 반환
    }
    
    @Override
    public boolean deleteComment(Map<String, Object> map) {
    	return commentDAO.deleteComment(map);    	
    }
}
