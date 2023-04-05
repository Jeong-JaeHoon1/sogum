DROP TABLE TRADE;
DROP TABLE DECLARATION;
DROP TABLE NOTE;
DROP TABLE F_REPLY;
DROP TABLE S_REPLY;
DROP TABLE SHARE_BOARD;
DROP TABLE FREE_BOARD;
DROP TABLE QNA;
DROP TABLE IMG_FILE;
DROP TABLE PRODUCT;
DROP TABLE USER_INFO;
DROP TABLE NOTICE;
DROP TABLE CATEGORY;
DROP TABLE GRADE;
DROP TABLE REGION;

DROP SEQUENCE SEQ_UNO;
DROP SEQUENCE SEQ_DNO;
DROP SEQUENCE SEQ_PNO;
DROP SEQUENCE SEQ_SNO;
DROP SEQUENCE SEQ_TNO;
DROP SEQUENCE SEQ_CNO;
DROP SEQUENCE SEQ_QNO;
DROP SEQUENCE SEQ_MNO;
DROP SEQUENCE SEQ_NOTICE;
DROP SEQUENCE SEQ_NOTE;
DROP SEQUENCE SEQ_SRNO;
DROP SEQUENCE SEQ_FRNO;
DROP SEQUENCE SEQ_REGION;
DROP SEQUENCE SEQ_INO;
DROP SEQUENCE SEQ_FNO;



--------------------------------------------------
--------------    ����     ------------------	
--------------------------------------------------
CREATE TABLE REGION (
	REGION_NO NUMBER PRIMARY KEY,
	REGION_NAME VARCHAR2(100) NOT NULL
);

COMMENT ON COLUMN REGION.REGION_NO IS '�����ڵ�';
COMMENT ON COLUMN REGION.REGION_NAME IS '������';

--------------------------------------------------
--------------     ȸ�� ���     ------------------	
--------------------------------------------------
CREATE TABLE GRADE (
	GRADE_NO NUMBER PRIMARY KEY,
	GRADE_NAME VARCHAR2(100) DEFAULT 'õ�Ͽ�' NOT NULL,
	MIN_GRADE NUMBER,
	MAX_GRADE NUMBER
);
COMMENT ON COLUMN GRADE.GRADE_NO IS '��޹�ȣ';
COMMENT ON COLUMN GRADE.GRADE_NAME IS '��޸�';
COMMENT ON COLUMN GRADE.MIN_GRADE IS '�ּҰ�';
COMMENT ON COLUMN GRADE.MAX_GRADE IS '�ִ밪';



--------------------------------------------------
--------------    ī�װ�     ------------------	
--------------------------------------------------
CREATE TABLE CATEGORY(
    CATEGORY_NO NUMBER PRIMARY KEY,
    CATEGORY_NAME VARCHAR2(100) NOT NULL
    );
COMMENT ON COLUMN CATEGORY.CATEGORY_NO IS 'ī�װ� ��ȣ';
COMMENT ON COLUMN CATEGORY.CATEGORY_NAME IS 'ī�װ� �̸�';


--------------------------------------------------
--------------    ��������     ------------------	
--------------------------------------------------
create table notice ( -- �������� ���̺� ���� 
    notice_no number primary key,
    notice_title varchar2(200) not null,
    notice_content varchar2(1000) not null,
    create_date date default sysdate not null,
    notice_views number default 0 not null,
    delete_status char(1) default 'N' check(delete_status in ('Y', 'N')) not null );
    
--------------------------------------------------
--------------     ȸ�� ����     ------------------	
--------------------------------------------------
CREATE TABLE USER_INFO (
	USER_NO NUMBER PRIMARY KEY,
	USER_PWD VARCHAR2(20) NOT NULL,
	USER_NAME VARCHAR2(20) NOT NULL,
	BIRTH DATE DEFAULT SYSDATE NOT NULL,
	PHONE CHAR(11) NOT NULL,
	EMAIL VARCHAR2(45),
	USER_ID VARCHAR2(20) NOT NULL UNIQUE,
	ENROLL_DATE DATE DEFAULT SYSDATE,
	STATUS CHAR(1) DEFAULT 'Y' CHECK (STATUS IN('Y', 'N')),
	SALTY_SCORE NUMBER DEFAULT 36.5,
    GRADE_NO NUMBER NOT NULL,
    REGION_NO NUMBER NOT NULL,
    FOREIGN KEY(GRADE_NO) REFERENCES GRADE(GRADE_NO),
    FOREIGN KEY(REGION_NO) REFERENCES REGION(REGION_NO)
);
COMMENT ON COLUMN USER_INFO.USER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN USER_INFO.USER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN USER_INFO.USER_NAME IS '�г���';
COMMENT ON COLUMN USER_INFO.BIRTH IS '�������';
COMMENT ON COLUMN USER_INFO.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN USER_INFO.EMAIL IS '�̸���';
COMMENT ON COLUMN USER_INFO.USER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN USER_INFO.ENROLL_DATE IS 'ȸ��������';
COMMENT ON COLUMN USER_INFO.STATUS IS 'ȸ��Ż�𿩺�';
COMMENT ON COLUMN USER_INFO.SALTY_SCORE IS '����';
COMMENT ON COLUMN USER_INFO.GRADE_NO IS '��޹�ȣ';
COMMENT ON COLUMN USER_INFO.REGION_NO IS '�����ڵ�';


--------------------------------------------------
--------------    �Ź�     ------------------	
--------------------------------------------------
create table product( -- PRODUCT ���̺� ���� 
    product_no number primary key,
    product_name varchar2(100) not null,
    product_status char(1) default 'N' check (product_status in ('Y','N')) not null,
    price number not null,
    created_at date default sysdate not null,
    delete_status char(1) default 'N' check (delete_status in ('Y','N')) not null,
    description varchar(1000) not null,
    category_no number,
    foreign key (category_no) references category(category_no),
    user_no number,
    foreign key (user_no) references user_info(user_no),
    region_no number references region(region_no)
    );


--------------------------------------------------
--------------    ��ǰ �̹���     ------------------	
--------------------------------------------------

CREATE TABLE IMG_FILE (
	FILE_ID NUMBER PRIMARY KEY,
	CHANGE_FILE_NAME VARCHAR2(100) NOT NULL,
	CREATED_AT DATE DEFAULT SYSDATE NOT NULL,
	DELETE_STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
	FILE_LEVEL CHAR(1) NOT NULL,
    PRODUCT_NO NUMBER NOT NULL,
	FOREIGN KEY (PRODUCT_NO) REFERENCES PRODUCT(PRODUCT_NO)
);


--------------------------------------------------
--------------    1:1 ����     ------------------	
--------------------------------------------------
create table qna(  -- QNA ���̺� ���� 
    qna_no number primary key,
    q_title varchar2(20) not null,
    q_content varchar2(1000) not null,
    q_date date default sysdate not null,
    qna_views number default 0 not null,
    a_content varchar2(1000) not null,
    a_date date default sysdate not null,
    user_no number not null,
    foreign key (user_no) references user_info(user_no)
    );

--------------------------------------------------
----------------    �����Խ���  	------------------
--------------------------------------------------

CREATE TABLE FREE_BOARD (
	FREE_BOARD_NO NUMBER PRIMARY KEY,
	USER_NO NUMBER NOT NULL,
	BOARD_TITLE VARCHAR2(100) NOT NULL,
	BOARD_CONTENT VARCHAR2(2000) NOT NULL,
	CREATED_DATE DATE DEFAULT SYSDATE NOT NULL,
	BOARD_VIEWS NUMBER DEFAULT 0,
	DELETE_STATUS CHAR(1) DEFAULT 'Y' CHECK (DELETE_STATUS IN('Y', 'N')),
	CATEGORY VARCHAR2(100) NOT NULL,
    FOREIGN KEY (USER_NO) REFERENCES USER_INFO (USER_NO)
);

COMMENT ON COLUMN FREE_BOARD.FREE_BOARD_NO IS '�Խ��ǹ�ȣ';
COMMENT ON COLUMN FREE_BOARD.USER_NO IS '�ۼ���ȸ����ȣ';
COMMENT ON COLUMN FREE_BOARD.BOARD_TITLE IS '�Խ�������';
COMMENT ON COLUMN FREE_BOARD.BOARD_CONTENT IS '�Խ��ǳ���';
COMMENT ON COLUMN FREE_BOARD.CREATED_DATE IS '�Խ����ۼ���';
COMMENT ON COLUMN FREE_BOARD.BOARD_VIEWS IS '��ȸ��';
COMMENT ON COLUMN FREE_BOARD.DELETE_STATUS IS 'Y/N-������������/������';
COMMENT ON COLUMN FREE_BOARD.CATEGORY IS '����, ����, ���� .. �ϵ��ڵ�';

--------------------------------------------------
----------------    �����Խ���  	------------------
--------------------------------------------------

CREATE TABLE SHARE_BOARD (
	SHARE_BOARD_NO NUMBER PRIMARY KEY,
	REGION_NO NUMBER NOT NULL,
    USER_NO NUMBER NOT NULL,
	BOARD_TITLE	VARCHAR2(100) NOT NULL,
	BOARD_CONTENT VARCHAR2(2000) NOT NULL,
	CREATED_DATE DATE DEFAULT SYSDATE NOT NULL,
	BOARD_VIEWS NUMBER DEFAULT 0,
	DELETE_STATUS CHAR(1) DEFAULT 'Y' CHECK (DELETE_STATUS IN('Y', 'N')),
	SHARE_STATUS CHAR(1) DEFAULT 'N' CHECK (SHARE_STATUS IN('Y', 'N')),
    FOREIGN KEY (REGION_NO) REFERENCES REGION (REGION_NO),
	FOREIGN KEY (USER_NO) REFERENCES USER_INFO (USER_NO)
);

COMMENT ON COLUMN SHARE_BOARD.SHARE_BOARD_NO IS '�Խ��ǹ�ȣ';
COMMENT ON COLUMN SHARE_BOARD.REGION_NO IS '�����ڵ�';
COMMENT ON COLUMN SHARE_BOARD.USER_NO IS '�ۼ���ȸ����ȣ';
COMMENT ON COLUMN SHARE_BOARD.BOARD_TITLE IS '�Խ�������';
COMMENT ON COLUMN SHARE_BOARD.BOARD_CONTENT IS '�Խ��ǳ���';
COMMENT ON COLUMN SHARE_BOARD.CREATED_DATE IS '�Խ����ۼ���';
COMMENT ON COLUMN SHARE_BOARD.BOARD_VIEWS IS '��ȸ��';
COMMENT ON COLUMN SHARE_BOARD.DELETE_STATUS IS 'Y/N-������������/������';
COMMENT ON COLUMN SHARE_BOARD.SHARE_STATUS IS 'Y/N-�Ϸ�/������ // �����Ϸ� �� ���� +5��';

--------------------------------------------------
----------------    ���� ���   	---------------------
--------------------------------------------------

CREATE TABLE S_REPLY (
    REPLY_NO NUMBER PRIMARY KEY,
    BOARD_NO NUMBER NOT NULL,
    USER_NO NUMBER NOT NULL,
    REPLY_CONTENT VARCHAR2 (2000) NOT NULL, 
    CREATED_DATE DATE DEFAULT SYSDATE NOT NULL,
    DELETE_STATUS CHAR (1) DEFAULT 'Y' CHECK (DELETE_STATUS IN('Y', 'N')),
    FOREIGN KEY (BOARD_NO) REFERENCES SHARE_BOARD (SHARE_BOARD_NO),
    FOREIGN KEY (USER_NO) REFERENCES USER_INFO (USER_NO)
);


--------------------------------------------------
----------------    ���� ���   	---------------------
--------------------------------------------------

CREATE TABLE F_REPLY (
    REPLY_NO NUMBER PRIMARY KEY,
    BOARD_NO NUMBER NOT NULL,
    USER_NO NUMBER NOT NULL,
    REPLY_CONTENT VARCHAR2 (2000) NOT NULL, 
    CREATED_DATE DATE DEFAULT SYSDATE NOT NULL,
    DELETE_STATUS CHAR (1) DEFAULT 'Y' CHECK (DELETE_STATUS IN('Y', 'N')),
    FOREIGN KEY (BOARD_NO) REFERENCES FREE_BOARD (FREE_BOARD_NO),
    FOREIGN KEY (USER_NO) REFERENCES USER_INFO (USER_NO)
);


--------------------------------------------------
----------------     ����   	---------------------
--------------------------------------------------

CREATE TABLE NOTE (
    NOTE_NO NUMBER PRIMARY KEY,
    USER_NO NUMBER NOT NULL,
    USER_NO2 NUMBER NOT NULL,
    SEND_TIME DATE DEFAULT SYSDATE NOT NULL,
    MESSAGE VARCHAR2 (2000) NOT NULL,
    FOREIGN KEY (USER_NO) REFERENCES USER_INFO(USER_NO)
);

--------------------------------------------------
----------------     �Ű�   	---------------------
--------------------------------------------------
CREATE TABLE DECLARATION (
	DECLARE_NO NUMBER PRIMARY KEY,
	DECLARE_TITLE VARCHAR2(100) NOT NULL,
	DECLARE_CONTENT VARCHAR2(2000) NOT NULL,
	DECLARE_TYPE VARCHAR2(20) NOT NULL,
	DECLARE_CHECK NUMBER DEFAULT 1 NOT NULL,
	DECLARE_DATE DATE DEFAULT SYSDATE NOT NULL,
	DECLARE_REASON VARCHAR2(2000) NOT NULL,
	DECLARE_CHECK_DATE DATE DEFAULT SYSDATE NOT NULL,
    FREE_BOARD_NO NUMBER NOT NULL,
    SHARE_BOARD_NO NUMBER NOT NULL,
    USER_NO NUMBER NOT NULL,
    FOREIGN KEY (FREE_BOARD_NO) REFERENCES FREE_BOARD(FREE_BOARD_NO),
	FOREIGN KEY (SHARE_BOARD_NO) REFERENCES SHARE_BOARD(SHARE_BOARD_NO),
    FOREIGN KEY (USER_NO) REFERENCES USER_INFO(USER_NO)
);
 
    

COMMENT ON COLUMN DECLARATION.DECLARE_CHECK IS '�Ű����';
COMMENT ON COLUMN DECLARATION.DECLARE_REASON IS '����';



--------------------------------------------------
--------------    �ŷ�     ------------------	
--------------------------------------------------
CREATE TABLE TRADE(
    TRADE_NO NUMBER PRIMARY KEY,
    TRADE_DATE DATE,
    TRADE_SCORE NUMBER,
    REVIEW_CONTENT VARCHAR2(2000),
    REVIEW_DATE DATE DEFAULT SYSDATE,
    USER_NO NUMBER NOT NULL,
    FOREIGN KEY (USER_NO) REFERENCES USER_INFO(USER_NO),
    PRODUCT_NO NUMBER NOT NULL,
    FOREIGN KEY (PRODUCT_NO) REFERENCES PRODUCT(PRODUCT_NO)
    );
COMMENT ON COLUMN TRADE.TRADE_NO IS '�ŷ���ȣ';
COMMENT ON COLUMN TRADE.TRADE_DATE IS '�ŷ���';
COMMENT ON COLUMN TRADE.TRADE_SCORE IS '����';
COMMENT ON COLUMN TRADE.REVIEW_CONTENT IS '�ı⳻��';
COMMENT ON COLUMN TRADE.REVIEW_DATE IS '�ı�����';


