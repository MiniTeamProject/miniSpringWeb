## miniSpringWeb 프로젝트

### 팀원

- **김태훈** - codelily98@naver.com
- **김진환** - hks248@naver.com
- **박지현** - dlsdnr2479@naver.com

---

### 프로젝트 구조

**프로젝트 이름**: `miniSpringWeb`

### 1. **src/main/java**

- **com.controller.miniSpringWeb**
    - `MainController.java` (index 연결)
- **spring.config**
    - `NCPObjectController.java` (NCPObject 연결 설정)
    - `SpringConfiguration.java` (JDBC(MySQL) 연결 설정, MyBatis 사용 설정)
- **user.bean**
    - `UserDTO` (회원 정보)
    - `UserPage` (회원 리스트 - 관리자 전용)
- **user.controller**
    - `UserController.java` (@Controller, @RequestMapping("user"))
- **user.dao**
    - `UserDAO` (Interface, @Mapper)
- **user.service**
    - `ObjectStorageSerivce.java` (Interface, @Component)
    - `UserService.java` (Interface, @Component)
- **user.service.impl**
    - `NCPObjectStorageService` (NCP 연동, @Service)
    - `UserServiceImpl` (User 기능 DB MyBatis 연동, @Service)
- **board.bean**
    - `BoardDTO` (게시판(커뮤니티) 정보)
    - `BoardPage` (게시판(커뮤니티) 리스트)
- **board.controller**
    - `BoardController.java` (@Controller, @RequestMapping("board"))
- **board.dao**
    - `BoardDAO` (Interface, @Mapper)
- **board.service**
    - `ObjectStorageSerivce.java` (Interface, @Component)
    - `BoardService.java` (Interface, @Component)
- **board.service.impl**
    - `NCPObjectStorageService` (NCP 연동, @Service)
    - `BoardServiceImpl` (Board 기능 DB MyBatis 연동, @Service)
- **comment.bean**
    - `CommentDTO` (댓글 정보)
    - `CommentPage` (댓글 리스트)
- **comment.controller**
    - `CommentController.java` (@Controller, @RequestMapping("comment"))
- **comment.dao**
    - `CommentDAO` (Interface, @Mapper)
- **comment.service**
    - `CommentService.java` (Interface, @Component)
- **comment.service.impl**
    - `CommentServiceImpl` (Comment 기능 DB MyBatis 연동, @Service)
- **store.bean**
    - `StoreDTO` (스토어(애견용품) 정보)
    - `StorePage` (스토어(애견용품) 리스트)
- **store.controller**
    - `StoreController.java` (@Controller, @RequestMapping("store"))
- **store.dao**
    - `StoreDAO` (Interface, @Mapper)
- **store.service**
    - `ObjectStorageSerivce.java` (Interface, @Component)
    - `StoreService.java` (Interface, @Component)
- **store.service.impl**
    - `NCPObjectStorageService` (NCP 연동, @Service)
    - `StoreServiceImpl` (Store 기능 DB MyBatis 연동, @Service)

### 2. **src/main/resources**

- **mapper**
    - `userMapper.xml` (user 관련 MyBatis(MySQL) CRUD)
    - `boardMapper.xml` (board 관련 MyBatis(MySQL) CRUD)
    - `commentMapper.xml` (comment 관련 MyBatis(MySQL) CRUD)
    - `storeMapper.xml` (store 관련 MyBatis(MySQL) CRUD)
- **spring**
    - `db.properties` (NaverCloud MySQL 연동 계정 정보)
    - `mybatis-config.xml` (MyBatis 설정 파일, spring 세팅으로 사용 안함)
    - `ncp.properties` (NaverCloud ObjectStorage 연동 정보)
- **sql**
    - `MungCatUser.sql` (멍캣 회원 테이블)
    - `MungCatBoard.sql` (멍캣 커뮤니티 테이블)
    - `MungCatComment.sql` (멍캣 댓글 테이블)
    - `MungCatStore.sql` (멍캣 애견용품 테이블)

### 3. **src/main/webapp**

- **WEB-INF**
    - **css** (모든 .css 관리 폴더)
        - `.css`
    - **image** (NCP 업로드를 위한 임시 저장 폴더)
    - **js** (모든 .js 관리 폴더)
        - `.js`
    - **spring**
        - **appServlet**
            - `servlet-context.xml` (spring servlet 설정 파일)
        - `root-context.xml` (spring 설정 파일)
    - **user** (user 관련 모든 페이지 .jsp 관리 폴더)
        - `user*.jsp`
    - **board** (board 관련 모든 페이지 .jsp 관리 폴더)
        - `board*.jsp`
    - **comment** (comment 관련 모든 페이지 .jsp 관리 폴더)
        - `comment*.jsp`
    - **store** (store 관련 모든 페이지 .jsp 관리 폴더)
        - `store*.jsp`
    - `index.jsp` (메인 페이지)
    - `web.xml` (WAC 설정과 한글 인코딩 설정)

### 4. **pom.xml**

- Spring Dependency 설정

---

### 필수 구현 기능

1. **회원 시스템**
    - 회원가입(이메일 인증)
    - 로그인(SNS 연동)
    - 회원정보 수정/탈퇴
2. **커뮤니티 기능**
    - 글쓰기(이미지 첨부), 목록(페이징), 댓글/답글 기능
    - 글 수정/삭제
    - **스마트 에디터** 도입 (참고: [스마트 에디터 설치 가이드](https://beforb.tistory.com/53))
3. **상품 검색 및 페이징**
    - 검색 조건: 기간, 제목 또는 작성자
    - 검색할 input 제공, 결과 페이징 처리
4. **관리자 페이지(상품 등록/삭제/수정)**
    - 애견물품 등록/수정/삭제

---