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

}