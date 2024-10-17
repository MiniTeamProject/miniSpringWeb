package user.service;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;

import user.bean.UserDTO;

@Component
public interface UserService {

	public UserDTO userLogin(String id, String pwd);

    public String getCheckId(String id);

    public void userRegist(UserDTO userDTO);
}
