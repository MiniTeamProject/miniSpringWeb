package user.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import user.bean.UserDTO;
import user.service.UserService;
import user.service.impl.JavaMailService;

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
    		
            // 세션 유효 시간을 30분(1800초)으로 설정
            session.setMaxInactiveInterval(3600); 
    		System.out.println("세션 발급 : " + userDTO);
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
    
    // 닉네임 중복 체크 기능
    @RequestMapping(value = "/getCheckNickname", method = RequestMethod.POST)
    @ResponseBody
    public String getCheckNickname(String nickname) {
 	   UserDTO user = userService.isNicknameExist(nickname);
        
        if (user != null) {
            return "exist";
        } else {
            return "non_exist";
        }
    }
    
    @RequestMapping("userUpdate")
    @ResponseBody
    public ResponseEntity<Map<String, String>> userUpdate(@RequestParam String id,
                                                          @RequestParam String pwd,
                                                          @RequestParam String nickname,
                                                          @RequestParam String tel,
                                                          @RequestParam String zipcode,
                                                          @RequestParam String addr1,
                                                          @RequestParam String addr2) {
        Map<String, String> response = new HashMap<>();
        
        // 입력 유효성 검사
        if (id == null || pwd == null || nickname == null || tel == null || zipcode == null || addr1 == null) {
            response.put("status", "fail");
            response.put("message", "필수 입력 정보를 모두 입력해 주세요.");
            return ResponseEntity.badRequest().body(response);
        }

        UserDTO userDTO = new UserDTO();
        userDTO.setId(id);
        userDTO.setPwd(pwd); // 비밀번호는 그대로 사용
        userDTO.setNickname(nickname);
        userDTO.setTel(tel);
        userDTO.setZipcode(zipcode);
        userDTO.setAddr1(addr1);
        userDTO.setAddr2(addr2);

        boolean isUpdated = userService.userUpdate(userDTO);

        if (isUpdated) {
            response.put("status", "success");
            response.put("message", "회원정보가 수정되었습니다.");
            return ResponseEntity.ok(response);
        } else {
            response.put("status", "fail");
            response.put("message", "회원정보 수정에 실패했습니다.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    @RequestMapping(value = "userDelete")
    public ResponseEntity<Map<String, String>> userDelete(@RequestParam String id,
                                                          @RequestParam String pwd,
                                                          HttpServletRequest request) {
        Map<String, String> response = new HashMap<>();

        // 입력 유효성 검사
        if (id == null || pwd == null) {
            response.put("status", "fail");
            response.put("message", "필수 입력 정보를 모두 입력해 주세요.");
            return ResponseEntity.badRequest().body(response);
        }
        
        // 사용자 비밀번호 확인 및 삭제 로직
        UserDTO isPasswordCorrect = userService.checkPassword(id, pwd); // 비밀번호 확인 메서드
        if (isPasswordCorrect == null) {
            response.put("status", "fail");
            response.put("message", "비밀번호가 일치하지 않습니다.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }

        boolean isDeleted = userService.userDelete(id); // 사용자 삭제 메서드

        if (isDeleted) {
            // 세션 만료
            HttpSession session = request.getSession(false); // 현재 세션을 가져옴
            if (session != null) {
                session.invalidate(); // 세션 만료
            }

            response.put("status", "success");
            response.put("message", "회원정보가 삭제되었습니다.");
            return ResponseEntity.ok(response);
        } else {
            response.put("status", "fail");
            response.put("message", "회원정보 삭제에 실패했습니다.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
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
    	//이메일 인증 번호 생성
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
       
       System.out.println("인증번호 : " + checkNum);

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
   
   @ResponseBody
   @RequestMapping(value = "findIdEmailAuth", method = RequestMethod.POST)
   public int findIdEmailAuth(@RequestParam String email) {
       // 이메일 인증 번호 생성
       Random random = new Random();
       int checkNum = random.nextInt(888888) + 111111;

       // 이메일 보낼 내용
       String title = "멍캣 아이디 찾기 인증 이메일입니다.";
       String content = "<!DOCTYPE html>" +
           "<html>" +
           "<head>" +
           "<meta charset='UTF-8'>" +
           "</head>" +
           "<body style='margin: 0; padding: 0; background-color: #f4f4f4;'>" +
           "  <div style='max-width: 600px; margin: 0 auto; background-color: #ffffff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);'>" +
           "    <h1 style='color: #a90011; text-align: center;'>멍캣 아이디 찾기 인증</h1>" +
           "    <p style='font-size: 16px; line-height: 1.6;'>안녕하세요, <strong>멍캣</strong>을 이용해주셔서 감사합니다!</p>" +
           "    <p style='font-size: 16px; line-height: 1.6;'>아래 인증 코드를 아이디 찾기 페이지의 <strong>인증 코드 확인란</strong>에 입력하여 인증을 완료해 주세요:</p>" +
           "    <div style='margin: 20px 0; padding: 10px 15px; background-color: #f7f7f7; border: 1px solid #dddddd; border-radius: 4px; font-size: 18px; text-align: center; font-weight: bold; color: #333333;'>" +
           checkNum + "</div>" +
           "    <p style='font-size: 16px; line-height: 1.6;'>멍캣과 함께 더 많은 서비스를 즐기세요!</p>" +
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
       
       System.out.println("인증번호 : " + checkNum);

       return checkNum; // 생성된 인증 번호 반환
   }
   
   @RequestMapping(value = "forgotId")
   public String forgotId() {
       return "user/forgotId";
   }
 
   @RequestMapping(value = "isEmail", method = RequestMethod.POST)
   @ResponseBody
   public String isEmail(@RequestParam String email) {
	   String isEmail = userService.isEmail(email);
	   
	   if(isEmail != null) { return isEmail;}
	   else {return "null";}
   }
   
   
   @RequestMapping(value = "getId", method = RequestMethod.POST)
   @ResponseBody
   public String getId(@RequestParam String email) {
	   String getId = userService.getId(email);
	   
	   if(getId != null) { 
		   return getId;
	   }
	   else {
		   return "null";
	   }
   }
   
   @RequestMapping(value = "kakao")
   @ResponseBody
   public String kakaoLogin(@RequestBody UserDTO userDTO, HttpSession session) {
       // 클라이언트로부터 받은 JSON 데이터를 UserDTO로 변환하여 처리
       System.out.println("id: " + userDTO.getId());
       System.out.println("nickname: " + userDTO.getNickname());
       
       // 사용자 정보를 세션에 저장
       session.setAttribute("userDTO", userDTO);

       // 사용자 정보 처리 후 성공 메시지 반환
       return "success";
   }
}

