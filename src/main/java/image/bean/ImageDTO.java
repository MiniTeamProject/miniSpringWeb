package image.bean;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ImageDTO {
    private int seq;                    	// 이미지 ID
    private String imageFileName;       	// 저장된 파일 이름 (UUID)
    private String imageOriginalFileName; 	// 원본 파일 이름
    private Timestamp logtime;         		// 이미지 업로드 날짜
}
