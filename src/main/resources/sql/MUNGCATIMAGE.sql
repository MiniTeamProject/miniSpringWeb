 -- [MySQL TABLE] �̹��� ���̺�
 CREATE TABLE MUNGCATIMAGE (
    seq INTEGER PRIMARY KEY AUTO_INCREMENT,                 -- �̹��� ID
    imageFileName VARCHAR(200) NOT NULL,                    -- ����� ���� �̸�(UUID)
    imageOriginalFileName VARCHAR(200) NOT NULL,            -- ���� ���� �̸�
    logtime TIMESTAMP DEFAULT NOW()                        -- �̹��� ���ε� ��¥
);