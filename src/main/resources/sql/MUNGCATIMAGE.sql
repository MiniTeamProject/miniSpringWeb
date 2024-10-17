 -- [MySQL TABLE] 이미지 테이블
 CREATE TABLE MUNGCATIMAGE (
    seq INTEGER PRIMARY KEY AUTO_INCREMENT,                 -- 이미지 ID
    imageFileName VARCHAR(200) NOT NULL,                    -- 저장된 파일 이름(UUID)
    imageOriginalFileName VARCHAR(200) NOT NULL,            -- 원본 파일 이름
    logtime TIMESTAMP DEFAULT NOW()                        -- 이미지 업로드 날짜
);