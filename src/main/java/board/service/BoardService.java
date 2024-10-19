package board.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import board.bean.BoardDTO;

@Component
public interface BoardService {

    public Map<String, Object> getBoardList(int pg);

    public int boardWrite(String id, String subject, String content, String category);

    public int getRef(String id);

    public List<BoardDTO> getboardView(int seq);

    public int boardUpdate(String id, String subject, String content, String category, int seq);

    public int boardDelete(Map<String, Object> map);

    public boolean increaseHit(int seq);

	public List<BoardDTO> searchList(String query);
    
}
