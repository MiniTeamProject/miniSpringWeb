 -- [MySQL TABLE] ��� ���̺�
CREATE TABLE MUNGCATCOMMENT (
    seq INTEGER PRIMARY KEY AUTO_INCREMENT,
    ref INTEGER NOT NULL,
    id VARCHAR(20) NOT NULL,
    nickname VARCHAR(100) NOT NULL,
    content VARCHAR(4000) NOT NULL,
    lev INTEGER DEFAULT NULL,
    logtime TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_mungcatboard_ref FOREIGN KEY (ref) REFERENCES MUNGCATBOARD(seq) ON DELETE CASCADE
);