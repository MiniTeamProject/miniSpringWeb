package image.service.impl;

import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import image.dao.ImageDAO;
import image.service.ImageService;
import naver.service.ObjectStorageService;

@Service
public class ImageServiceImpl implements ImageService {
	@Autowired
    private ObjectStorageService objectStorageService;
	
	@Autowired
	private ImageDAO imageDAO;
	
	@Override
	public String uploadFile(String bucketName, String directoryPath, MultipartFile file) {
		String imageUrl = objectStorageService.uploadFile(bucketName, directoryPath, file);
		System.out.println("이미지 업로드 ImageServiceImpl : " + imageUrl);
		return imageUrl;
	}
	
	@Override
	public void updateRef(String imageFileName, int seq) {
		Map<String, Object> map = new HashedMap<String, Object>();
		map.put("imageFileName", imageFileName);
		map.put("seq", seq);
		imageDAO.updateRef(map);
	}
}
