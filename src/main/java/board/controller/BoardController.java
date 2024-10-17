package board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import board.bean.BoardDTO;
import board.service.BoardService;
import naver.service.ObjectStorageService;

@Controller
@RequestMapping("board")
public class BoardController {
    @Autowired
    private BoardService boardService;
    
    @Autowired
    private ObjectStorageService objectStorageService;
    
    private String bucketName = "bitcamp-9th-bucket-97";
    
    @RequestMapping(value = "boardMain", method = RequestMethod.GET)
    public ModelAndView boardMain(@RequestParam(required = false, defaultValue = "1") String pg) {
        ModelAndView modelAndView = new ModelAndView();
        Map<String, Object> pagingMap = boardService.getBoardList(Integer.parseInt(pg));
        
        List<BoardDTO> checkValue = (List<BoardDTO>) pagingMap.get("boardList");
        
        if(checkValue == null || checkValue.isEmpty()) {
            modelAndView.addObject("fail", "fail");
            System.out.println("모델 값 : " + modelAndView.getModel().get("fail"));
        } else {
            modelAndView.addObject("boardList", pagingMap.get("boardList"));
            modelAndView.addObject("boardHotList", pagingMap.get("boardHotList"));
            modelAndView.addObject("pg", pagingMap.get("pg"));
            modelAndView.addObject("boardPaging", pagingMap.get("boardPaging"));
            modelAndView.setViewName("board/boardMain");
        }
        
        return modelAndView; 
    }
    
    @RequestMapping(value = "boardWriteForm", method = RequestMethod.GET)
    public ModelAndView boardWriteForm(/*@RequestParam("id") String id*/) {
        ModelAndView modelAndView = new ModelAndView();
        /*if(id == null || id == "") {
            modelAndView.addObject("fail", "fail");
        } else {
            modelAndView.addObject("id", id);
            modelAndView.addObject("success", "success");
        }*/
        modelAndView.setViewName("board/boardWriteForm");
        
        return modelAndView;
    }
    
    @RequestMapping(value = "uploadImage")
    @ResponseBody
    public Map<String, Object> uploadImage(@RequestParam("file") MultipartFile file) {
        Map<String, Object> response = new HashMap<>();

        if (file.isEmpty()) {
            response.put("error", "파일이 비어 있습니다.");
            return response;
        }

        try {
            String directoryPath = "uploads/"; // 저장할 디렉토리 경로
            String imageUrl = objectStorageService.uploadFile(bucketName, directoryPath, file);
            response.put("link", imageUrl);
        } catch (Exception e) {
            response.put("error", "이미지 업로드 중 오류가 발생했습니다: " + e.getMessage());
        }

        return response;
    }


    
    @RequestMapping(value = "boardWrite", method = RequestMethod.POST)
    public String boardWrite(@RequestParam Map<String, String> boardForm, @RequestParam("uploadedImages") String uploadedImagesJson) throws JsonMappingException, JsonProcessingException {
        String subject = boardForm.get("subject");
        String content = boardForm.get("content");
        String category = boardForm.get("category");

        // 업로드된 이미지 처리
        List<String> uploadedImages = new ObjectMapper().readValue(uploadedImagesJson, new TypeReference<List<String>>(){});

        // 이미지 URL을 포함한 게시물 저장 로직 구현
        boardService.boardWrite(subject, content, category, uploadedImages);

        return "redirect:/board/boardMain"; // 게시물 목록으로 리다이렉트
    }

}
