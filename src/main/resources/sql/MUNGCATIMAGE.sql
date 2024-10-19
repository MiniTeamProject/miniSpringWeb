-- [MySQL TABLE] �̹��� ���̺�
 CREATE TABLE MUNGCATIMAGE (
    seq INTEGER PRIMARY KEY AUTO_INCREMENT,                 -- �̹��� ID
    ref INTEGER DEFAULT 0,									-- �̹��� ÷�� �� �� SEQ
    imageFileName VARCHAR(200) NOT NULL,                    -- ����� ���� �̸�(UUID)
    imageOriginalFileName VARCHAR(200) NOT NULL,            -- ���� ���� �̸�
    logtime TIMESTAMP DEFAULT NOW()                         -- �̹��� ���ε� ��¥
);