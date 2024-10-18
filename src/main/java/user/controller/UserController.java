package user.controller;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import image.bean.ImageDTO;
import naver.service.ObjectStorageService;
import user.bean.UserDTO;
import user.service.UserService;
import user.service.impl.JavaMailService;

import java.io.File;
import java.io.IOException;
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
	private ObjectStorageService objectStorateService;
	private String bucketName = "bitcamp-9th-bucket-97";
    
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
    
    @RequestMapping(value = "userInfo")
    public String userInfo() {
        return "user/userInfo";
    }
    
    
    @RequestMapping(value = "userUpdate", method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
    @ResponseBody
    public void userUpdate(@ModelAttribute UserDTO userDTO, @RequestParam MultipartFile profile, HttpSession session) {
    	String filePath = session.getServletContext().getRealPath("WEB-INF/storage");
		System.out.println("실제폴더 : " + filePath);

	//	String imageFileName = objectStorateService.uploadFile(bucketName,"storage/", profile);
		String imageOriginalFileName = profile.getOriginalFilename();
		File file = new File(filePath, imageOriginalFileName);
		try {
			profile.transferTo(file);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		
		userDTO.setProfile(imageOriginalFileName);
    	
    	
    	
    	userService.userUpdate(userDTO);

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
           String title = "멍캣 회원가입 인증 이메일입니다.";
           String content = "<!DOCTYPE html>" +
                   "<html>" +
                   "<head>" +
                   "<meta charset='UTF-8'>" +
                   "</head>" +
                   "<body style='margin: 0; padding: 0; background-color: #f4f4f4;'>" +
                   "  <div style='max-width: 600px; margin: 0 auto; background-color: #ffffff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);'>" +
                   "    <h1 style='color: #a90011; text-align: center;'>멍캣 회원가입 인증</h1>" +
                   "    <p style='font-size: 16px; line-height: 1.6;'>안녕하세요, <strong>멍캣</strong>에 가입해주셔서 감사합니다!</p>" +
                   "    <p style='font-size: 16px; line-height: 1.6;'>아래 인증 코드를 회원가입 페이지의 <strong>인증 코드 확인란</strong>에 입력하여 인증을 완료해 주세요:</p>" +
                   "    <div style='margin: 20px 0; padding: 10px 15px; background-color: #f7f7f7; border: 1px solid #dddddd; border-radius: 4px; font-size: 18px; text-align: center; font-weight: bold; color: #333333;'>" +
                   checkNum + "</div>" +
                   "    <p style='font-size: 16px; line-height: 1.6;'>멍캣과 함께 반려동물과의 멋진 시간을 시작하세요!</p>" +
                   "    <p style='font-size: 16px; line-height: 1.6;'>감사합니다.<br>멍캣 팀 드림</p>" +
                   "    <div style='margin-top: 30px; text-align: center; font-size: 12px; color: #888888;'>" +
                   "      <p>&copy; 2024 멍캣 | All Rights Reserved</p>" +
                   "    </div>" +
                   "  </div>" +
                   "</body>" +
                   "</html>";

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

