package user.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

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
    
    @RequestMapping(value = "logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
    
    @RequestMapping(value="userRegistForm", method = RequestMethod.GET)
    public String userRegistForm() {
        return "user/userRegistForm";
    }
    
    @ResponseBody
    @RequestMapping(value = "userRegist", method = RequestMethod.POST)
    public void userRegist(@ModelAttribute UserDTO userDTO) { userService.userRegist(userDTO);}

    @ResponseBody
    @RequestMapping(value = "getCheckId", method = RequestMethod.POST)
    public String getCheckId(String id) {return userService.getCheckId(id);}

}
