package board.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public interface BoardService {

    public Map<String, Object> getBoardList(int pg);

    public void boardWrite(String subject, String content, String category, List<String> uploadedImages);
    
}
