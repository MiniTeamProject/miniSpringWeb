package board.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import board.bean.BoardDTO;
import board.service.BoardService;

@Controller
@RequestMapping("board")
public class BoardController {
    @Autowired
    private BoardService boardService;
    
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
}
