package board.service;

import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public interface BoardService {

    public Map<String, Object> getBoardList(int pg);

    public int boardWrite(String id, String subject, String content, String category);

	public int getRef(String id);
    
}
