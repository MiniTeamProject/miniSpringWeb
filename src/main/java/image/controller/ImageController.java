package image.controller;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import image.dao.ImageDAO;
import image.bean.ImageDTO;
import image.service.ImageService;

@Controller
@RequestMapping("image")
public class ImageController {
	@Autowired
	private ImageService imageService;
	
	@Autowired
	private ImageDAO imageDAO;
	
	private String bucketName = "bitcamp-9th-bucket-97";
	
    @RequestMapping(value = "uploadImage")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> uploadImage(@RequestParam("file") MultipartFile file) {
        Map<String, Object> response = new HashMap<>();

        if (file.isEmpty()) {
        	response.put("error", "파일이 비어 있습니다.");
            return ResponseEntity.badRequest().body(response); // 400 상태 코드
        }
        
        ImageDTO imageDTO = new ImageDTO();
        System.out.println("여기까지는 오지?");
        String imageOriginalFileName = file.getOriginalFilename();
        
        imageDTO.setImageOriginalFileName(imageOriginalFileName);
        
        System.out.println("이미지 원래 파일명" + imageOriginalFileName);
        
        try {
            String directoryPath = "uploads/"; // 저장할 디렉토리 경로
            String imageUrl = imageService.uploadFile(bucketName, directoryPath, file);
            
            System.out.println("리턴 받은 NCP 이미지 경로 : " + imageUrl);
            
            // 이미지 URL에서 파일 이름만 추출
            String imageFileName = imageUrl.substring(imageUrl.lastIndexOf('/') + 1);
            
            System.out.println("NCP 경로 파일 이름 추출 : " + imageFileName);
            
            imageDTO.setImageFileName(imageFileName);        
            
            imageDAO.uploadImage(imageDTO);
            
            System.out.println("DTO 이미지 업로드 경로 : " + imageFileName);
            
            response.put("link", imageUrl);
            response.put("imageFileName", imageFileName);
            response.put("imageOriginalFileName", imageOriginalFileName);
            
            System.out.println("성공");
            
            return ResponseEntity.ok(response); // 200 상태 코드
        } catch (Exception e) {
        	// 예외 발생 시 로그 남기기
        	System.out.println("실패");
            System.err.println("Error occurred while uploading the image: " + e.getMessage());
            e.printStackTrace(); // 스택 트레이스 출력
            response.put("error", "이미지 업로드 중 오류가 발생했습니다: " + e.getMessage());
            
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response); // 500 상태 코드
        }
    }
}
