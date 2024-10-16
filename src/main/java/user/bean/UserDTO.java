package user.bean;

import java.sql.Timestamp;
import lombok.Data;

@Data
public class UserDTO {
    private String id;                // 아이디
    private String pwd;               // 비밀번호
    private String nickname;          // 닉네임
    private String name;              // 이름
    private char gender;              // 성별
    private String email;             // 이메일 주소
    private String tel;               // 전화번호
    private String zipcode;           // 우편번호
    private String addr1;             // 주소
    private String addr2;             // 상세주소
    private String profile;           // 프로필 사진
    private char admin;               // 관리자 권한 (0: 일반 사용자, 1: 관리자)
    private Timestamp logtime;        // 가입일
}
