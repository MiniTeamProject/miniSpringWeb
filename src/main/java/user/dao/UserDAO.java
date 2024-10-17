package user.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.ui.ModelMap;

import user.bean.UserDTO;

@Mapper
public interface UserDAO {

	public UserDTO userLogin(Map<String, String> map);


    public UserDTO getCheckId(String id);

    public void userRegist(UserDTO userDTO);
}