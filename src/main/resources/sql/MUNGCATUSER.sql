-- [MySQL TABLE] 회원 테이블
CREATE TABLE MUNGCATUSER (
    id VARCHAR(15) PRIMARY KEY,                                 -- 아이디, 필수, 기본키
    pwd VARCHAR(255) NOT NULL,                                  -- 비밀번호, 필수
    nickname VARCHAR(50) NOT NULL,                              -- 닉네임, 필수
    name VARCHAR(50) NOT NULL,                                  -- 이름, 필수
    gender CHAR(1) NOT NULL,                                    -- 성별, 필수
    email VARCHAR(300) NOT NULL,                                -- 이메일 주소, 필수
    tel VARCHAR(11),                                            -- 전화번호 뒷자리
    zipcode VARCHAR(20),                                        -- 우편번호
    addr1 VARCHAR(255),                                         -- 주소
    addr2 VARCHAR(255),                                         -- 상세주소
    profile INTEGER DEFAULT 0,                                  -- 프로필 사진 (이미지 SEQ)
    admin CHAR(1) DEFAULT '0' NOT NULL,                         -- 관리자 권한((0 -> 일반 사용자), (1 -> 관리자)
    logtime TIMESTAMP DEFAULT NOW()                             -- 가입일
);