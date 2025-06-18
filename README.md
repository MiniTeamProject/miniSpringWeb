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

## 기술 스택
<img src="https://storage.googleapis.com/next-step-assets/mungcat/stack.png" />

## ERD
<img src="https://storage.googleapis.com/next-step-assets/mungcat/erd.png" />

## 유즈케이스
<img src="https://storage.googleapis.com/next-step-assets/mungcat/usecase1.png" />
<img src="https://storage.googleapis.com/next-step-assets/mungcat/usecase2.png" />

## 기능
- 회원
  - 회원가입(이메일 인증)
  - 로그인/로그아웃
  - 정보수정(프로필, 닉네임, 주소, 비밀번호, 전화번호)
  - 회원탈퇴
  - 구매목록
  - 장바구니
- 멍캣광장
  - 글 목록 보기(인기글, 최신글)
  - 글 상세보기
  - 글/댓글/답글 작성/수정/삭제(이미지 첨부)
- 멍캣마켓
  - 상품 보기(인기 상품, 최신 상품)
  - 상품 상세 보기
  - 상품 구매
- 관리자
  - 상품 등록/수정/삭제
  - 공지사항 작성/수정/삭제
- 검색
  - 카테고리에 따른 검색 기능(멍캣광장, 멍캣마켓)

## 역할 (BE/FE)
- **프로젝트 팀장**
  - Git Flow 전략 도입
  - 프로젝트 구조 및 기능 설계/구현
  - ERD 설계 및 Usecase 작성
- **BE**
  - 회원 기능 구현 (회원가입/탈퇴, 로그인/로그아웃, 정보수정, 구매목록, 장바구니)
  - 커뮤니티 기능 구현 (글/댓글/답글 작성/수정/삭제)
  - 관리자 상품 기능 구현 (상품 등록/수정/삭제)
  - MyBatis를 활용한 NCP MySQL DB 연동 (db.properties 작성)
  - NCP Object 스토리지 이미지 업로드 기능 구현
  - Kakao/Naver login API 적용
- **FE**
  - 사이트 프론트 페이지 기능 구현 및 반응형 디자인 (전체)
  - florala 에디터 적용
- **CI/CD**
  - NCP Server에 Docker와 Jenkins를 이용한 FE/BE 배포 (Apache WAS)
  - http 형태로 배포

## 성과
- MyBatis를 이용한 DB 연동 숙달
- Spring 프로젝트 설계 및 개발 숙달
- Kakao와 Naver API 프로젝트 적용 경험
- 팀원들과의 Git을 통한 코드 리뷰와 프로젝트 관리 (Git Flow 전략) 경험
- NCP와 Jenkins/Docker를 활용한 CI/CD 경험
- florala 에디터 적용 경험

## 프로젝트 리뷰
- **Keep**
  - Git Flow 전략을 도입하여 팀 프로젝트를 진행
  - 반응형 웹 설계 및 작성
- **Problem**
  - https가 아닌 http 배포
  - 도메인을 사용하지 못함
  - 팀원들의 개인 사정으로 인한 프로젝트 이탈 및 시간 배분 문제

## 느낀점
- 지금까지 배웠던 것을 활용하고, Spring 기반 프로젝트에 적용할 수 있었습니다.
- 기본적인 CI/CD에 대해서 이해하고 활용할 수 있었습니다.
- 반응형 웹에 대해서 이해하고 반응형 페이지를 설계/작성할 수 있었습니다.

## 📝 실행 화면
### 메인화면
<img src="https://storage.googleapis.com/next-step-assets/mungcat/main.png" />
- <img src="https://storage.googleapis.com/next-step-assets/mungcat/main_moblie.png" />
- <img src="https://storage.googleapis.com/next-step-assets/mungcat/main_menu_moblie.png" />

---
