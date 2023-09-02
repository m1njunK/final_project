-- 멤버 정보 테이블
CREATE TABLE MEMBER (
    IDN INT AUTO_INCREMENT PRIMARY KEY, 	-- 식별값
    ID VARCHAR(255) NOT NULL UNIQUE, 		-- 로그인용 ID
    NNAME VARCHAR(255) NOT NULL UNIQUE,		-- 닉네임	
    PASS VARCHAR(255) NOT NULL,				-- 비밀번호
    EMAIL VARCHAR(255) NOT NULL,			-- 이메일
    NAME VARCHAR(255),						-- 이름
    BIRTHDATE DATE,							-- 생년월일 추가
    GENDER VARCHAR(10),						-- 성별 추가
    STOPU BOOLEAN DEFAULT FALSE,			-- 정지 유저 구분
    POINT INT DEFAULT 0						-- 포인트(구매같은거 할때 쓰는)
);

ALTER TABLE member ADD withdraw BOOLEAN DEFAULT FALSE;
-- 닉네임 unique로 변경
-- 회원가입시 중복 확인 처리 필요 (id,nname)

drop table member;

-- 집에서 사용할 DB
-- 관리자 계정 만듬
INSERT INTO MEMBER(ID,NNAME,PASS,EMAIL,NAME,BIRTHDATE, GENDER, POINT)
VALUES('admin','admin','admin','EMAIL@EMAIL','admin','1111-11-11','남성','9999');
UPDATE MEMBER set id='admin' where id='admin';

-- 첫번째 유저
INSERT INTO MEMBER(ID,NNAME,PASS,EMAIL,NAME,BIRTHDATE, GENDER, POINT)
VALUES('USER1','NNAME1','12345','USER1@naver.com','NAME1','1995-07-14','남성', '1000');

INSERT INTO MEMBER(ID,NNAME,PASS,EMAIL,NAME,BIRTHDATE, GENDER, POINT)
VALUES('USER2','NNAME2','12345','USER2@naver.com','NAME2','1111-11-11','남성', '1000');

DROP TABLE MEMBER;

DESC MEMBER;

SELECT * FROM MEMBER;

-- 유저 정보 테이블 (2023,08,16 수정)
CREATE TABLE USER (
    IDN INT AUTO_INCREMENT PRIMARY KEY,			-- 식별값
    POINT INT DEFAULT 0,						-- 포인트(구매같은거 할때 쓰는)
    -- SAVE (임시) 								-- 임시
    FOREIGN KEY (IDN) REFERENCES MEMBER(IDN) 	-- 식별값 불러오기
);

DROP TABLE USER;

SELECT * FROM USER;

-- 자유게시판 테이블 생성
CREATE TABLE FreeBoard (
    BNO INT AUTO_INCREMENT PRIMARY KEY,			-- 글 번호
    Title VARCHAR(255) NOT NULL,				-- 글 제목
    Content TEXT,								-- 글 내용
    Auth VARCHAR(255),							-- 작성자
    Date DATETIME DEFAULT CURRENT_TIMESTAMP,	-- 작성 시간
    VCNT INT DEFAULT 0,							-- 조회수
    LCNT INT DEFAULT 0,							-- 좋아요 수
    del boolean default false,					-- 게시글 삭제 여부
    CommentCount INT DEFAULT 0,					-- 댓글 갯수
   	CONSTRAINT fk_nname FOREIGN KEY (Auth) 
    REFERENCES MEMBER(nname)
--    INDEX(IDN)								-- ID값 불러오기
);
-- 외래키 member id -> nname 변경
ALTER TABLE freeboard MODIFY content LONGTEXT;


-- 트리거추가
-- 댓글 달리면 해당 게시글 댓글 카운트 추가
delimiter |
CREATE TRIGGER update_comment_count3
AFTER INSERT ON freeboardComments
FOR EACH ROW
BEGIN
    UPDATE freeboard
    SET CommentCount = CommentCount + 1
    WHERE BNO = NEW.freeboardBNO;
END;
| 
delimiter ;

-- 댓글 삭제되면 해당 게시글 댓글 카운트 감소
DELIMITER //
CREATE TRIGGER update_comment_count4
AFTER DELETE ON freeboardComments
FOR EACH ROW BEGIN
    UPDATE freeBoard
    SET CommentCount = CommentCount - 1
    WHERE BNO = OLD.freeBoardBNO;
END;
//
DELIMITER ;

SELECT * FROM FreeBoard;

DROP TABLE FreeBoard;

-- 자유게시판 댓글 테이블
CREATE TABLE FreeBoardComments (
    CommentID INT AUTO_INCREMENT PRIMARY KEY,				-- 댓글 번호 저장
    FreeBoardBNO INT,										-- 자유게시판 글 번호
    CommentContent TEXT,									-- 자유게시판 댓글 내용 
    CommenterID VARCHAR(255),								-- 자유게시판 댓글 작성자
    CommentDate DATETIME DEFAULT CURRENT_TIMESTAMP,			-- 댓글 작성시간
    FOREIGN KEY (FreeBoardBNO) REFERENCES FreeBoard(BNO),	-- 외부 게시판 값 불러오기
    FOREIGN KEY (CommenterID) REFERENCES MEMBER(nname)			-- 외부 ID 값 불러오기
);
-- 외래키 member id -> nname 변경

DROP TABLE FreeBoardComments;

-- 구매내역 테이블
CREATE TABLE Bought (
    PurchaseID INT AUTO_INCREMENT PRIMARY KEY,			-- 구매관리 번호
    UserID VARCHAR(255), 								-- 사용자 식별자 (로그인 ID 등)
    ProductName VARCHAR(255), 							-- 구매한 상품명
    PointSpent INT DEFAULT 0, 							-- 사용된 포인트
    FOREIGN KEY (UserID) REFERENCES MEMBER(ID)			-- 구매한 사람 ID 값 불러오기
);

DROP TABLE Bought;

-- 간단한 Q&A 테이블 생성
CREATE TABLE QnA (
    QnAID INT AUTO_INCREMENT PRIMARY KEY,				-- Q&A 식별값
    QuestionTitle VARCHAR(255), 						-- Q&A 제목
    QuestionContent TEXT         						-- Q&A 내용
);	

SELECT * FROM QnA;
INSERT INTO QnA (QuestionTitle, QuestionContent)  VALUES('제목','노트북 옅구름 함초롱하다 감사합니다 이플 사과 그루잠 별하 여우별 로운 나비잠 컴퓨터 함초롱하다 노트북 비나리 여우비 옅구름 우리는 별빛 로운 여우비 아름드리 여우비 감또개 도담도담 여우비 별빛 아슬라 가온해 안녕 책방 옅구름 달볓 바람꽃 포도 소록소록 아련 별빛 바나나 함초롱하다 안녕 도서관 소록소록 도담도담 도서관 별하 소솜 안녕 나비잠 도서.

도르레 아리아 로운 여우비 미쁘다 아름드리 여우별 책방 아리아 다솜 감사합니다 곰다시 로운 도서 아름드리 아름드리 산들림 다솜 아리아 소솜 곰다시 가온누리 이플 옅구름 가온누리 소솜 여우비 예그리나 도서 예그리나 나비잠 도서관 비나리 그루잠 바나나 곰다시 여우별 이플 여우별 바나나 달볓 여우별 바나나 아련 도서관 감또개 로운 가온누리 미리내 우리는.');

-- 업적 테이블
CREATE TABLE Achievements (
    AchievementID INT AUTO_INCREMENT PRIMARY KEY,		-- 업적 식별값
    UserID VARCHAR(255), 								-- 사용자 식별자 (로그인 ID 등)
    AchievementName VARCHAR(255), 						-- 업적명
    AchievementDate DATETIME DEFAULT CURRENT_TIMESTAMP, -- 달성한 날짜
    FOREIGN KEY (UserID) REFERENCES MEMBER(ID)			-- 업적 달성한 사람 ID 값 불러오기
);

DROP TABLE Achievements;

-- MEMBER 테이블의 NNAME 컬럼에 인덱스 추가
ALTER TABLE MEMBER ADD INDEX idx_nname (NNAME);

-- 쪽지 테이블

CREATE TABLE NOTE (
  NNO INT AUTO_INCREMENT PRIMARY KEY,									-- 쪽지 번호
  FROM_ID VARCHAR(255) NOT NULL,										-- 보낸사람
  TO_ID VARCHAR(255) NOT NULL,											-- 받은사람
  TITLE VARCHAR(255) NOT NULL,											-- 제목
  CONTENT TEXT NOT NULL,												-- 쪽지내용
  FOREIGN KEY (FROM_ID) REFERENCES MEMBER(ID),
  FOREIGN KEY (TO_ID) REFERENCES MEMBER(ID)
);

-- 쪽지 넣기
INSERT INTO NOTE (FROM_ID, TO_ID, TITLE ,CONTENT)
VALUES ('USER1', 'USER2', 'test','test');

INSERT INTO NOTE (FROM_ID, TO_ID, TITLE ,CONTENT)
VALUES ('USER2', 'USER1', 'test','test');

SELECT * FROM note;

DROP TABLE note;

-- 08/27 11:00 이미지 게시판 테이블 변경
-- 기존 test_comments / test_imageBoard 날리고 이걸로 새로 만들어 쓰세요
-- 만들고 밑에 트리거도 추가 해주세요
CREATE TABLE imageBoard (
	BNO INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,				-- 글 제목
    CONTENT LONGTEXT,								-- 글 내용
    Auth VARCHAR(255),							-- 작성자
    Date DATETIME DEFAULT CURRENT_TIMESTAMP,	-- 작성 시간
    VCNT INT DEFAULT 0,							-- 조회수
    LCNT INT DEFAULT 0,							-- 좋아요 수
    ImageURL VARCHAR(255),						-- 이미지 경로
    del boolean default false,
    CommentCount INT DEFAULT 0
);

-- 이미지 게시판 댓글 테이블 
CREATE TABLE imageBoardComments (
    CommentNO INT AUTO_INCREMENT PRIMARY KEY,				-- 댓글 번호 저장
    ImageBoardBNO INT,										-- 이미지게시판 댓글 번호
    CommentContent TEXT,									-- 이미지게시판 댓글 내용
    CommenterID VARCHAR(255),								-- 이미지게시판 댓글 작성자
    CommentDate DATETIME DEFAULT CURRENT_TIMESTAMP,			-- 댓글 작성시간
    FOREIGN KEY (ImageBoardBNO) REFERENCES imageBoard(BNO)	-- 외부 게시판 값 불러오기
);

-- 트리거추가
-- 댓글 달리면 해당 게시글 댓글 카운트 추가
DELIMITER //
CREATE TRIGGER update_comment_count
AFTER INSERT ON imageBoardComments
FOR EACH ROW
BEGIN
    UPDATE imageBoard
    SET CommentCount = CommentCount + 1
    WHERE BNO = NEW.ImageBoardBNO;
END;
// 
DELIMITER;

-- 댓글 삭제되면 해당 게시글 댓글 카운트 감소
DELIMITER //
CREATE TRIGGER update_comment_count2
AFTER DELETE ON imageBoardComments
FOR EACH ROW BEGIN
    UPDATE imageBoard
    SET CommentCount = CommentCount - 1
    WHERE BNO = OLD.ImageBoardBNO;
END;
//
DELIMITER ;

select * from member;

-- 공지사항 테이블 생성
CREATE TABLE IF NOT EXISTS noticeBoard (
    bno INT AUTO_INCREMENT PRIMARY KEY,			-- 글 번호
    title VARCHAR(255) NOT NULL,				-- 글 제목
    content MEDIUMTEXT NOT NULL,				-- 글 내용
    auth VARCHAR(255) NOT NULL,					-- 작성자
    updatedate DATETIME DEFAULT CURRENT_TIMESTAMP,	-- 최종 수정 시간
    vcnt INT DEFAULT 0,							-- 조회수
    fixedNotice BOOLEAN DEFAULT FALSE,			-- 고정 공지
   	FOREIGN KEY (auth) REFERENCES MEMBER(nname)
--    INDEX(IDN)								-- ID값 불러오기
);
    -- likeCnt INT DEFAULT 0,						-- 좋아요 수
CREATE TABLE IF NOT EXISTS notice_comment (
    CommentNO INT AUTO_INCREMENT PRIMARY KEY,           -- 댓글 번호 저장
    NoticeBNO INT,                                     -- 이미지게시판 댓글 번호
    CommentContent TEXT,                               -- 이미지게시판 댓글 내용
    CommenterID VARCHAR(255),                          -- 이미지게시판 댓글 작성자
    CommentDate DATETIME DEFAULT CURRENT_TIMESTAMP,    -- 댓글 작성시간
    FOREIGN KEY (NoticeBNO) REFERENCES noticeBoard(bno)
        ON DELETE CASCADE,
    FOREIGN KEY (CommenterID) REFERENCES MEMBER(nname),
    INDEX (NoticeBNO)
);
--    CONSTRAINT fk_nc_nb_bno FOREIGN KEY (NoticeBNO)    -- 외부 게시판 값 불러오기
--        REFERENCES noticeBoard(bno),
-- 공지사항 첨부파일 
CREATE TABLE noticeAttach(
	fullName VARCHAR(300) NOT NULL,
	bno INT NOT NULL,
	regdate TIMESTAMP NULL DEFAULT NOW(),
	FOREIGN KEY(bno) REFERENCES noticeBoard(bno) ON DELETE CASCADE
);
INSERT INTO noticeBoard(title,content,auth) 
SELECT title,content,auth FROM noticeBoard;


DESC noticeBoard;
DESC notice_comment;
SELECT * FROM noticeBoard;
SELECT * FROM notice_comment;
SELECT * FROM noticeAttach;
drop table noticeBoard;
drop table notice_comment;
drop table noticeAttach;
--INSERT INTO notice_comment (NoticeBNO,CommentContent,CommenterID) VALUES('1','댓글','admin');

-- 권한 table
CREATE TABLE member_auth(
	u_id VARCHAR(50) NOT NULL,
    u_auth VARCHAR(50) NOT NULL,
    constraint fk_member_auth FOREIGN KEY(u_id) 
    REFERENCES MEMBER(ID) ON DELETE CASCADE
    ON UPDATE CASCADE
);

DROP TABLE member_auth;

INSERT INTO member_auth(u_id,u_auth) 
VALUES('admin' , 'ROLE_ADMIN');

INSERT INTO member_auth(u_id,u_auth) 
VALUES('user1' , 'ROLE_USER');

INSERT INTO member_auth(u_id,u_auth) 
VALUES('user2', 'ROLE_USER');

SELECT * FROM member_auth;

DELETE FROM MEMBER;

-- 드랍전용 sql문
DROP TABLE MEMBER;
DROP TABLE USER;
DROP TABLE FreeBoard;
DROP TABLE ImageBoard;
DROP TABLE FreeBoardComments;
DROP TABLE ImageBoardComments;
DROP TABLE note;
DROP TABLE noticeboard;
DROP TABLE Bought;
DROP TABLE Achievements;
DROP TABLE Message;

commit;
