package board.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import board.bean.BoardDTO;
import board.service.BoardService;
import comment.bean.CommentDTO;
import comment.service.CommentService;
import image.service.ImageService;
import user.service.UserService;

@Controller
@RequestMapping("board")
public class BoardController {
    @Autowired
    private BoardService boardService;
    
    @Autowired
    private CommentService commentService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private ImageService imageService;
    
    @RequestMapping(value = "boardMain", method = RequestMethod.GET)
    public ModelAndView boardMain(@RequestParam(required = false, defaultValue = "1") String pg) {
        ModelAndView modelAndView = new ModelAndView();
        Map<String, Object> pagingMap = boardService.getBoardList(Integer.parseInt(pg));
        
        List<BoardDTO> checkValue = (List<BoardDTO>) pagingMap.get("boardList");
        // 각 게시물의 이미지 URL을 저장할 리스트 생성
        List<String> imgSrcList = new ArrayList<>();
        
		for (BoardDTO board : checkValue) {
		    String content = board.getContent(); // BoardDTO 객체에서 content 값 추출
//		    System.out.println("Content: " + content); 

	        // 정규 표현식을 사용하여 <img ... > 태그를 추출
	        Pattern imgPattern = Pattern.compile("<img[^>]*src=[\"']([^\"']*)[\"'][^>]*>");
	        Matcher matcher = imgPattern.matcher(content);
	        
	        if (matcher.find()) {
	            String imgSrc = matcher.group(1); // img 태그 안의 src 값 추출
	            imgSrcList.add(imgSrc); // 리스트에 이미지 URL 추가
//	            System.out.println("imgSrc: " + imgSrc);
	        } else {
	            imgSrcList.add(""); // 이미지가 없을 경우 빈 문자열 추가
	        }
		    
		}
		
	    // boardHotList 처리
	    List<BoardDTO> hotBoardList = (List<BoardDTO>) pagingMap.get("boardHotList");
	    List<String> hotImgSrcList = new ArrayList<>();
	    
	    for (BoardDTO board : hotBoardList) {
	        String content = board.getContent(); // BoardDTO 객체에서 content 값 추출
	        System.out.println("Hot Content: " + content); 

	        // 정규 표현식을 사용하여 <img ... > 태그를 추출
	        Pattern imgPattern = Pattern.compile("<img[^>]*src=[\"']([^\"']*)[\"'][^>]*>");
	        Matcher matcher = imgPattern.matcher(content);
	        
	        if (matcher.find()) {
	            String imgSrc = matcher.group(1); // img 태그 안의 src 값 추출
	            hotImgSrcList.add(imgSrc); // 리스트에 이미지 URL 추가
//	            System.out.println("Hot imgSrc: " + imgSrc);
	        } else {
	            hotImgSrcList.add(""); // 이미지가 없을 경우 빈 문자열 추가
	        }
	    }
        
	    if (checkValue == null || checkValue.isEmpty()) {
	        modelAndView.addObject("fail", "fail");
//	        System.out.println("모델 값 : " + modelAndView.getModel().get("fail"));
	    } else {
	        modelAndView.addObject("boardList", checkValue);
	        modelAndView.addObject("boardHotList", pagingMap.get("boardHotList"));
	        modelAndView.addObject("pg", pagingMap.get("pg"));
	        modelAndView.addObject("boardPaging", pagingMap.get("boardPaging"));
	        modelAndView.addObject("imgSrcList", imgSrcList); // 리스트를 모델에 추가
	        modelAndView.addObject("hotImgSrcList", hotImgSrcList); // boardHotList 이미지 URL 리스트 추가
	        modelAndView.setViewName("board/boardMain");
	    }
        
        return modelAndView; 
    }
    
    @RequestMapping(value = "boardWriteForm", method = RequestMethod.GET)
    public ModelAndView boardWriteForm(/*@RequestParam("id") String id*/) {
        ModelAndView modelAndView = new ModelAndView();
        
        modelAndView.setViewName("board/boardWriteForm");
        
        return modelAndView;
    }
    
    @RequestMapping(value = "boardWrite", method = RequestMethod.POST)
    @ResponseBody
    public String boardWrite(@RequestParam("subject") String subject,
				             @RequestParam("content") String content,
				             @RequestParam("category") String category,
				             @RequestParam("id") String id,
				             @RequestParam(value = "imageUrls[]", required = false) List<String> imageUrls,
				             @RequestParam(value = "imageFileNames[]", required = false) List<String> imageFileNames,
				             @RequestParam(value = "imageOriginalFileNames[]", required = false) List<String> imageOriginalFileNames) {
        
        // 게시물 저장 로직
//        System.out.println("제목: " + subject);
//        System.out.println("내용: " + content);
//        System.out.println("카테고리: " + category);
//        System.out.println("아이디: " + id);
//        System.out.println("업로드된 이미지 URL: " + imageUrls);
//        System.out.println("업로드된 이미지 파일 이름: " + imageFileNames);
//        System.out.println("업로드된 이미지 원본 파일 이름: " + imageOriginalFileNames);
//        
//        System.out.println("imageFileNames : " + imageFileNames);
//        
        // 이미지 URL을 포함한 게시물 저장 로직 구현
        int result = boardService.boardWrite(id, subject, content, category);
        
        if(result > 0) {
        	if(imageFileNames != null) {
        		userService.updateTotalWrite(id);
        		for (String imageFileName : imageFileNames) {
//                    System.out.println("업로드된 이미지 URL: " + imageFileName);
                    int seq = boardService.getRef(id);
                    imageService.updateRef(imageFileName, seq);
//                    System.out.println("이미지 ref 1증가 : " + imageFileName);
                }
//        		System.out.println("이미지 작성글 1증가");
        	} else {
//        		System.out.println("이미지 작성글 그대로");
        		return "success";
        	}  
        } else {
//        	System.out.println("글작성 실패");
        	return "fail";
        }
        
        return "success";
    }
    
    @RequestMapping(value = "boardView")
    public ModelAndView boardView(@RequestParam("pg") int pg, @RequestParam("seq") int seq, @RequestParam(required = false, defaultValue = "1") int commentpg) {
        ModelAndView modelAndView = new ModelAndView();
        List<BoardDTO> list = boardService.getboardView(seq);
        //댓글 목록과 페이징 정보 가져오기
        Map<String, Object> pagingMap = commentService.getCommentView(seq, commentpg);
        
        modelAndView.addObject("list", list);
        modelAndView.addObject("commentList", pagingMap.get("commentList")); // 댓글 리스트
        modelAndView.addObject("commentPaging", pagingMap.get("commentPaging")); // 댓글 페이징 정보
        modelAndView.addObject("commentPg", commentpg); // 댓글 페이지 정보
        modelAndView.addObject("pg", pg);
        modelAndView.setViewName("board/boardView");
        
        return modelAndView;
    }
    
     @RequestMapping(value = "boardUpdateForm")
     public ModelAndView boardUpdateForm(@RequestParam("seq") int seq, @RequestParam("pg") int pg) {
         ModelAndView modelAndView = new ModelAndView();
         List<BoardDTO> list = boardService.getboardView(seq);
         
         modelAndView.addObject("list", list);
         modelAndView.addObject("pg", pg);
         modelAndView.setViewName("board/boardUpdateForm");
         
         return modelAndView;
     }
     
     @RequestMapping(value = "boardUpdate", method = RequestMethod.POST)
     @ResponseBody
     public String boardUpdate(@RequestParam("subject") String subject,
                               @RequestParam("content") String content,
                               @RequestParam("category") String category,
                               @RequestParam("id") String id,
                               @RequestParam("seq") int seq,
                               @RequestParam(value = "imageUrls[]", required = false) List<String> imageUrls,
                               @RequestParam(value = "imageFileNames[]", required = false) List<String> imageFileNames,
                               @RequestParam(value = "imageOriginalFileNames[]", required = false) List<String> imageOriginalFileNames) {
         
			/*
			 * // 게시물 저장 로직 System.out.println("제목: " + subject); System.out.println("내용: "
			 * + content); System.out.println("카테고리: " + category);
			 * System.out.println("아이디: " + id); System.out.println("업로드된 이미지 URL: " +
			 * imageUrls); System.out.println("업로드된 이미지 파일 이름: " + imageFileNames);
			 * System.out.println("업로드된 이미지 원본 파일 이름: " + imageOriginalFileNames);
			 * 
			 * System.out.println("imageFileNames : " + imageFileNames);
			 */
         
         // 이미지 URL을 포함한 게시물 저장 로직 구현
         int result = boardService.boardUpdate(id, subject, content, category, seq);
         
         if(result > 0) {
             if(imageFileNames != null) {
                 userService.updateTotalWrite(id);
                 for (String imageFileName : imageFileNames) {
//                     System.out.println("업로드된 이미지 URL: " + imageFileName);
                     imageService.updateRef(imageFileName, seq);
//                     System.out.println("이미지 ref 1증가 : " + imageFileName);
                 }
//					System.out.println("이미지 작성글 1증가");
             } else {
//					System.out.println("이미지 작성글 그대로");
                 return "success";
             }  
         } else {
//				System.out.println("글작성 실패");
             return "fail";
         }
         
         return "success";
     }
     
     @RequestMapping(value = "boardDelete", method = RequestMethod.POST)
     @ResponseBody
     public String boardDelete(@RequestParam("seq") int seq, 
                               @RequestParam("id") String id,
                               @RequestParam("pg") int pg) {
			/* System.out.println("데이터 넘어옴"); */
         Map<String, Object> map = new HashedMap<String, Object>();
         map.put("id", id);
         map.put("seq", seq);
         int result = boardService.boardDelete(map);
			/* System.out.println("삭제 됨 : " + result); */
         
         if(result > 0) {
             return "success";
         } else {
             return "fail";
         }
     }
     
     @RequestMapping(value = "increaseHit", method = RequestMethod.POST)
     @ResponseBody // JSON 형식의 응답을 반환하기 위해 추가합니다.
     public ResponseEntity<String> increaseHit(@RequestParam("seq") int seq) {
         boolean isSuccess = boardService.increaseHit(seq); // 게시글 조회수 증가 메서드 호출

         if (isSuccess) {
             return ResponseEntity.ok("조회수가 증가했습니다."); // 성공 메시지 반환
         } else {
             return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("조회수 증가 실패."); // 실패 메시지 반환
         }
     }
}
