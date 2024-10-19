package comment.controller;

import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import comment.bean.CommentDTO;
import comment.service.CommentService;

@Controller
@RequestMapping("comment")
public class CommentController {
	@Autowired
    private CommentService commentService;
	
    // 댓글 작성 기능
    @RequestMapping(value = "write")
    @ResponseBody // AJAX 요청에 대한 응답을 JSON 형식으로 반환
    public String writeComment(@RequestParam int seq, // 게시글의 시퀀스 번호
					            @RequestParam String id, // 방문자 ID
					            @RequestParam String nickname,
					            @RequestParam String comment) { // 댓글 내용
	
		int ref = seq;
		CommentDTO commentDTO = new CommentDTO();
		commentDTO.setRef(ref); // 게시글 시퀀스 설정
		commentDTO.setId(id); // 방문자 ID 설정
		commentDTO.setNickname(nickname);
		commentDTO.setContent(comment); // 댓글 내용 설정
		
		// 댓글 작성 서비스 호출
		boolean result = commentService.writeComment(commentDTO);
		
		// 결과에 따라 반환 값 설정
		if (result) {
			return "success"; // 댓글 작성 성공
		} else {
			return "fail"; // 댓글 작성 실패
		}
	}
    
    @RequestMapping(value = "commentDelete")
    public String commentDelete(@RequestParam String id, @RequestParam int seq, @RequestParam int pg, @RequestParam int ref) {
    	Map<String, Object> map = new HashedMap<String, Object>();
    	map.put("id", id);
    	map.put("seq", seq);
    	boolean result = commentService.deleteComment(map);
    	
    	System.out.println("댓글 삭제 결과 : " + result);
    	
    	return "redirect:/board/boardView?pg=" + pg + "&seq=" + ref;
    }
}
