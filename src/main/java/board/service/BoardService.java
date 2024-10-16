package board.service;

import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public interface BoardService {

    Map<String, Object> getBoardList(int pg);
    
}
