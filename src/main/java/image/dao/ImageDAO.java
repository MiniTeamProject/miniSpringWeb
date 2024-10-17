package image.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import image.bean.ImageDTO;

@Mapper
public interface ImageDAO {

	public void uploadImage(ImageDTO imageDTO);

	public void updateRef(Map<String, Object> map);
}
