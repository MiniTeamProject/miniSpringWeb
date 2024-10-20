package user.service;

import org.springframework.stereotype.Component;

import user.bean.UserDTO;

@Component
public interface UserService {

	public UserDTO userLogin(String id, String pwd);

    public String getCheckId(String id);

    public void userRegist(UserDTO userDTO);

	public void updateTotalWrite(String id);

	public boolean userUpdate(UserDTO userDTO);

	public UserDTO isNicknameExist(String nickname);

	public boolean userDelete(String id);

	public UserDTO checkPassword(String id, String pwd);

	public String isEmail(String email);

	public String getId(String email);
}
