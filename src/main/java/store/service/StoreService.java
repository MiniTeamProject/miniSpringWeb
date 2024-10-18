package store.service;

import org.springframework.stereotype.Component;

import java.util.Map;

@Component
public interface StoreService {

   public Map<String, Object> getStoreList(int pg);

   public int storeWrite(String name, String description, String price, String category);
}
