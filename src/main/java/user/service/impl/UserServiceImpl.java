package user.service.impl;

import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import user.bean.UserDTO;
import user.dao.UserDAO;
import user.service.UserService;

@Service
public class UserServiceImpl implements UserService{
    @Autowired
    private UserDAO userDAO;
    
	@Override
	public UserDTO userLogin(String id, String pwd) {
		Map<String, String> map = new HashedMap<String, String>();
		map.put("id", id);
		map.put("pwd", pwd);

		UserDTO userDTO = userDAO.userLogin(map);	
		return userDTO;
	}

	@Override
	public String getCheckId(String id) {
		UserDTO userDTO = userDAO.getCheckId(id);
		if (userDTO == null) return "non_exist";
		else return "exist";
	}

	@Override
	public void userRegist(UserDTO userDTO) {
		userDAO.userRegist(userDTO);
	}
	
	@Override
	public void updateTotalWrite(String id) {
		userDAO.updateTotalWrite(id);
	}
	
	@Override
	public boolean userUpdate(UserDTO userDTO) {
		return userDAO.userUpdate(userDTO);		
	}
	
	@Override
	public UserDTO isNicknameExist(String nickname) {
        return userDAO.checkNickname(nickname);
	}
	
	@Override
	public boolean userDelete(String id) {
		return userDAO.userDelete(id);
	}
	
	@Override
	public UserDTO checkPassword(String id, String pwd) {
		Map<String, String> map = new HashedMap<String, String>();
		map.put("id", id);
		map.put("pwd", pwd);
		return userDAO.checkPassword(map);
	}
	
	@Override
	public String getId(String email) {
		String getId = userDAO.getId(email);
		return getId;
	}
	
	@Override
	public String isEmail(String email) {
		String isEmail = userDAO.isEmail(email);
		return isEmail;
	}
}