package user.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import user.bean.UserDTO;

@Mapper
public interface UserDAO {

	public UserDTO userLogin(Map<String, String> map);

    public UserDTO getCheckId(String id);

    public void userRegist(UserDTO userDTO);

	public void updateTotalWrite(String id);

	public boolean userUpdate(UserDTO userDTO);

	public UserDTO checkNickname(String nickname);

	public boolean userDelete(String id);

	public UserDTO checkPassword(Map<String, String> map);

	public String isEmail(String email);

	public String getId(String email);
}