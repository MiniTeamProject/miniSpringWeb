package store.service;

import org.springframework.stereotype.Component;

import store.bean.StoreDTO;

import java.util.List;
import java.util.Map;

@Component
public interface StoreService {

   public Map<String, Object> getStoreList(int pg);

   public int storeWrite(String name, String description, String price, String category);

   public List<StoreDTO> searchItems(String query);
}
