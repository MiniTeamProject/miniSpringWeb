package store.bean;

import lombok.Data;

import java.security.Timestamp;

@Data
public class StoreDTO {
    private String id;
    private String name;
    private String description;
    private String price;
    private int stock;
    private String image;
    private String category;
    private Timestamp logtime;
    private Timestamp logtime_up;
}
