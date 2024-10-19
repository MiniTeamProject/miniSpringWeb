package store.service.impl;

import board.bean.BoardDTO;
import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import store.bean.StoreDTO;
import store.bean.StorePaging;
import store.dao.StoreDAO;
import store.service.StoreService;

import java.util.List;
import java.util.Map;

@Service
public class StoreServiceimpl implements StoreService {
    @Autowired
    private StoreDAO storeDAO;
    @Autowired
    private StorePaging storePaging;

    @Override
    public Map<String, Object> getStoreList(int pg) {
        int page = pg;
            int endNum = 6;
            int startNum = (page * endNum) - endNum;

            Map<String, Integer> map = new HashedMap<String, Integer>();
            map.put("startNum", startNum);
            map.put("endNum", endNum);

            List<BoardDTO> storeList = storeDAO.getStoreList(map);
            List<BoardDTO> storeHotList = storeDAO.getStoreHotList(map);

            //페이징 처리(a태그)
            int totalA = storeDAO.getTotalA();

            storePaging.setTotalA(totalA);
            storePaging.setCurrentPage(page);
            storePaging.setPageBlock(5);
            storePaging.setPageSize(endNum);
            storePaging.makePagingHTML();

            Map<String, Object> pagingMap = new HashedMap<String, Object>();
            pagingMap.put("storeList", storeList);
            pagingMap.put("storeHotList", storeHotList);
            pagingMap.put("pg", page);
            pagingMap.put("storePaging", storePaging);

            return pagingMap;
    }

    @Override
    public int storeWrite(String name, String description, String price, String category) {
        Map<String, String> map = new HashedMap<String, String>();
        map.put("name", name);
        map.put("description", description);
        map.put("price", price);
        map.put("category", category);

        return storeDAO.storeWrite(map);
    }
    
    @Override
    public List<StoreDTO> searchItems(String query) {
    	return storeDAO.findByNameContaining(query);
    }
}
