package store.dao;

import board.bean.BoardDTO;
import store.bean.StoreDTO;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface StoreDAO {

    public List<BoardDTO> getStoreList(Map<String, Integer> map);

    public List<BoardDTO> getStoreHotList(Map<String, Integer> map);

    public int getTotalA();

    public int storeWrite(Map<String, String> map);

	public List<StoreDTO> findByNameContaining(String query);

}
