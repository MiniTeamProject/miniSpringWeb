package user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import user.bean.UserDTO;
import user.service.UserService;

@Controller
@RequestMapping("user")
public class UserController {
    @Autowired
    private UserService userService;
    
    
    
    @RequestMapping(value="userLoginForm", method = RequestMethod.GET)
    public String userLoginForm() {
        return "user/userLoginForm";
    }
    
    @RequestMapping(value="userLogin", method = RequestMethod.POST)
    @ResponseBody
    public String userLogin(@RequestParam String id, @RequestParam String pwd, HttpSession session) {

    	UserDTO userDTO = userService.userLogin(id, pwd);

    	if(userDTO != null){
    		session.setAttribute("userDTO", userDTO);
    		return "success";
    	} else {
    		return "fail";
    	}
    }
    
    
    @RequestMapping(value="userRegistForm", method = RequestMethod.GET)
    public String writeForm() {
        return "user/userRegistForm";
    }
    
    @RequestMapping(value = "userRegist", method = RequestMethod.POST)
    @ResponseBody
    public void userRegist() {
    	System.out.println("userRegist");
    }
 
    
    
}
