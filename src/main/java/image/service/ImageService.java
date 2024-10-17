package image.service;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public interface ImageService {

	public String uploadFile(String bucketName, String directoryPath, MultipartFile file);

	public void updateRef(String id, int seq);
}
