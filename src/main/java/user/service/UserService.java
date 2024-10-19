package user.service;

import org.springframework.stereotype.Component;

import user.bean.UserDTO;

@Component
public interface UserService {

	public UserDTO userLogin(String id, String pwd);

    public String getCheckId(String id);

    public void userRegist(UserDTO userDTO);

	public void updateTotalWrite(String id);

	public void userUpdate(UserDTO userDTO);

	public UserDTO isNicknameExist(String nickname);
}
