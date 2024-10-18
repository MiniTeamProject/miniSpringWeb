package board.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import board.bean.BoardDTO;
import board.service.BoardService;
import image.service.ImageService;
import user.service.UserService;

@Controller
@RequestMapping("board")
public class BoardController {
    @Autowired
    private BoardService boardService;
    
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
		    System.out.println("Content: " + content); 

	        // 정규 표현식을 사용하여 <img ... > 태그를 추출
	        Pattern imgPattern = Pattern.compile("<img[^>]*src=[\"']([^\"']*)[\"'][^>]*>");
	        Matcher matcher = imgPattern.matcher(content);
	        
	        if (matcher.find()) {
	            String imgSrc = matcher.group(1); // img 태그 안의 src 값 추출
	            imgSrcList.add(imgSrc); // 리스트에 이미지 URL 추가
	            System.out.println("imgSrc: " + imgSrc);
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
	            System.out.println("Hot imgSrc: " + imgSrc);
	        } else {
	            hotImgSrcList.add(""); // 이미지가 없을 경우 빈 문자열 추가
	        }
	    }
        
	    if (checkValue == null || checkValue.isEmpty()) {
	        modelAndView.addObject("fail", "fail");
	        System.out.println("모델 값 : " + modelAndView.getModel().get("fail"));
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
        System.out.println("제목: " + subject);
        System.out.println("내용: " + content);
        System.out.println("카테고리: " + category);
        System.out.println("아이디: " + id);
        System.out.println("업로드된 이미지 URL: " + imageUrls);
        System.out.println("업로드된 이미지 파일 이름: " + imageFileNames);
        System.out.println("업로드된 이미지 원본 파일 이름: " + imageOriginalFileNames);
        
        System.out.println("imageFileNames : " + imageFileNames);
        
        // 이미지 URL을 포함한 게시물 저장 로직 구현
        int result = boardService.boardWrite(id, subject, content, category);
        
        if(result > 0) {
        	if(imageFileNames != null) {
        		userService.updateTotalWrite(id);
        		for (String imageFileName : imageFileNames) {
                    System.out.println("업로드된 이미지 URL: " + imageFileName);
                    int seq = boardService.getRef(id);
                    imageService.updateRef(imageFileName, seq);
                    System.out.println("이미지 ref 1증가 : " + imageFileName);
                }
        		System.out.println("이미지 작성글 1증가");
        	} else {
        		System.out.println("이미지 작성글 그대로");
        		return "success";
        	}  
        } else {
        	System.out.println("글작성 실패");
        	return "fail";
        }
        
        return "success";
    }

}
