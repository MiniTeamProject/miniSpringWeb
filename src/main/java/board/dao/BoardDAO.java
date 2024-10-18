package board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import board.bean.BoardDTO;

@Mapper
public interface BoardDAO {

    public List<BoardDTO> getBoardList(Map<String, Integer> map);

    public List<BoardDTO> getBoardHotList(Map<String, Integer> map);

    public int getTotalA();

	public int boardWrite(Map<String, String> map);

	public int getRef(String id);

    public List<BoardDTO> getboardView(int seq);

    public int boardUpdate(Map<String, Object> map);

    public int boardDelete(Map<String, Object> map);

    public int increaseHit(int seq);
    
}
