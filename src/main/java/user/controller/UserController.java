package user.controller;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import user.bean.UserDTO;
import user.service.UserService;
import user.service.impl.JavaMailService;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;

@Controller
@RequestMapping("user")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private JavaMailService javaMailService;

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

    // 이메일과 인증번호를 저장할 ConcurrentHashMap
       private Map<String, Integer> authCodes = new ConcurrentHashMap<>();

       @ResponseBody
       @RequestMapping(value = "emailAuth", method = RequestMethod.POST)
       public int emailAuth(@RequestParam String email) {
           // 이메일 인증 번호 생성
           Random random = new Random();
           int checkNum = random.nextInt(888888) + 111111;

           // 이메일 보낼 내용
           String title = "회원가입 인증 이메일 입니다.";
           String content = "인증 코드는 " + checkNum + " 입니다." +
                   "<br>" +
                   "해당 인증 코드를 인증 코드 확인란에 기입하여 주세요.";

           // 이메일 전송
           javaMailService.sendEmail(email, title, content);

           // 인증번호를 맵에 저장
           authCodes.put(email, checkNum);

           return checkNum; // 생성된 인증 번호 반환
       }

       @ResponseBody
       @RequestMapping(value = "verifyAuthCode", method = RequestMethod.POST)
       public ResponseEntity<Map<String, Boolean>> verifyAuthCode(@RequestParam String email, @RequestParam int authCode) {
           // 저장된 인증번호를 가져옴
           Integer savedAuthCode = authCodes.get(email);

           // 입력된 인증번호와 저장된 인증번호 비교
           boolean isValid = savedAuthCode != null && savedAuthCode.equals(authCode);

           // 인증번호가 일치하면 해당 이메일의 인증번호를 삭제 (선택사항)
           if (isValid) {
               authCodes.remove(email); // 인증번호를 사용한 후 삭제
           }

           Map<String, Boolean> response = new HashMap<>();
           response.put("valid", isValid); // 결과 반환

           return ResponseEntity.ok(response);
       }
}

