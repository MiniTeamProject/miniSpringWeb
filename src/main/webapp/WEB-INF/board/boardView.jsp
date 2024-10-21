<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>멍캣: 멍캣글</title>
<link rel="stylesheet" href="../css/boardView.css">
</head>
<body>
<c:if test="${empty userDTO.id}">
    <script type="text/javascript">
        alert("로그인이 필요합니다.");
        window.location.href = '/miniSpringWeb/board/boardMain'; // 원하는 리디렉션 URL로 변경
    </script>
</c:if>
<header>
    <nav>
        <div class="logo"><span>멍캣</span></div>
        <div class="mobile-menu">
            <div class="hamburger">&#9776;</div>
        </div>
        <ul class="nav-links">
            <li><a href="/miniSpringWeb/store/storeMain"><img src="../image/logo2.png" alt="logo2" class="nav-icon">멍캣마켓</a></li>
            <li><a href="/miniSpringWeb/board/boardMain"><img src="../image/logo3.png" alt="logo3" class="nav-icon">멍캣광장</a></li>
            <c:if test="${userDTO.id == 'admin'}">
                <li><a href="#"><img src="../image/logo5.png" alt="logo5" class="nav-icon">관리자</a></li>
            </c:if>
            <c:if test="${not empty userDTO.id}">
                <li class="logoutview"><a href="/miniSpringWeb/user/logout"><img src="../image/logo5.png" alt="logo5" class="nav-icon">로그아웃</a></li>
                <li class="logoutview"><a href="/miniSpringWeb/user/userInfo"><img src="../image/logo6.png" alt="logo6" class="nav-icon">마이페이지</a></li>
            </c:if>
            <c:if test="${empty userDTO.id}">
                <li class="loginview"><a href="/miniSpringWeb/user/userLoginForm"><img src="../image/logo7.png" alt="logo7" class="nav-icon">로그인</a></li>
                <li class="loginview"><a href="/miniSpringWeb/user/userRegistForm"><img src="../image/logo6.png" alt="logo6" class="nav-icon">회원가입</a></li>
            </c:if>
        </ul>
        <div class="auth">
            <c:if test="${not empty userDTO.id}">
                <a href="/miniSpringWeb/user/userInfo">${userDTO.nickname} 님</a>
                <a href="/miniSpringWeb/user/logout">로그아웃</a>
            </c:if>
            <c:if test="${empty userDTO.id}">
                <a href="/miniSpringWeb/user/userLoginForm">로그인</a>
                <a href="/miniSpringWeb/user/userRegistForm">회원가입</a>
            </c:if>
        </div>
    </nav>
</header>

<main>
    <section class="board-view-section">
		<form id="boardViewForm">
		    <div id="category">
		        <c:choose>
		            <c:when test="${list[0].category == 0}">
		                일반
		            </c:when>
		            <c:when test="${list[0].category == 1}">
		                질문
		            </c:when>
		            <c:when test="${list[0].category == 2}">
		                후기
		            </c:when>
		            <c:otherwise>
		                카테고리 없음
		            </c:otherwise>
		        </c:choose>
		    </div>
		    <div class="boardview">
		        <div id="top-inline">
		            <div id="subject">제목 : ${list[0].subject}</div>
		        </div>
                <div id="middle-top">
                    <div id="hit">조회수 : ${list[0].hit}</div>
                    <div id="logtime">작성일 : 
                        <c:choose>
                            <c:when test="${not empty list[0].logtime}">
                                <c:set var="formattedDate" value="${fn:split(list[0].logtime, ' ')[0]}" /> <!-- "YYYY-MM-DD" 형식으로 자르기 -->
                                <c:set var="year" value="${fn:substring(formattedDate, 2, 4)}" /> <!-- 마지막 2자리 년도 -->
                                <c:set var="month" value="${fn:substring(formattedDate, 5, 7)}" /> <!-- 월 -->
                                <c:set var="day" value="${fn:substring(formattedDate, 8, 10)}" /> <!-- 일 -->
                                ${year}-${month}-${day} <!-- "YY-MM-DD" 형식으로 출력 -->
                            </c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </div>
                </div>
		        <div id="middle">
		            <div id="content">${list[0].content}</div> <!-- 내용 추가 -->
		        </div>
		        <div id="bottom-top">
		            <div id="btnwrap">
		            <c:if test="${userDTO.id == list[0].id}">
		                <input type="button" id="updateBtn" value="수정" onclick="location.href='/miniSpringWeb/board/boardUpdateForm?pg=${pg}&seq=${list[0].seq}'"/>
	                </c:if>
		                <input type="button" id="backBtn" value="목록" onclick="location.href='/miniSpringWeb/board/boardMain?pg=${pg}'"/>
		            </div>
		        </div>
		    </div>
		</form>
		<input type="hidden" id="seq" name="seq" value="${list[0].seq}"/>
        <input type="hidden" id="writerId" name="writerId" value="${list[0].id}"/> <!-- 작성자 ID -->
        <input type="hidden" id="visitorId" name="visitorId" value="${userDTO.id}"/> <!-- 방문자 ID -->
		<!-- 댓글 작성 버튼 -->
		<div id="togglewrap">
			<input type="button" id="toggleCommentForm" value="<댓글 작성>">
		</div>
		
        <form id="boardCommentForm">
	        <div id="bottom" style="display: none;">
	            <div class="commentWrtieForm">
	                <label for="comment">${userDTO.nickname}</label>
	                <textarea id="comment" name="comment" placeholder="댓글 입력.."></textarea>
	            </div>
	            <div id="checkDiv"></div>
	            <div id="commentBtnWrap">
	                <input type="button" id="commentWriteBtn" value="댓글 작성"/>
	            </div>
	        </div>
	        <input type="hidden" id="nickname" name="nickname" value="${userDTO.nickname}"/> <!-- 방문자 닉네임 -->
        </form>
        
        <!-- 댓글 리스트 출력 -->
        <div id="printComment">
            <c:forEach var="comment" items="${commentList}">
                <div class="commentItem">
                    <div class="commentWriter">${comment.nickname}</div> <!-- 작성자 닉네임 -->
                    <div class="commentContent">${comment.content}</div> <!-- 댓글 내용 -->
                    <c:if test="${comment.id == userDTO.id}">
                    	<a class="delete-button" href="/miniSpringWeb/comment/commentDelete?id=${comment.id}&seq=${comment.seq}&pg=${pg}&ref=${list[0].seq}" onclick="return confirm('정말로 이 댓글을 삭제하시겠습니까?');">삭제</a> <!-- 삭제 버튼 -->
                    </c:if>
                </div>
            </c:forEach>
        </div>

        <!-- 댓글 페이징 -->
        <div id="commentPaging">
            <c:if test="${commentPaging.totalPage > 1}">
                <c:if test="${commentPg > 1}">
                    <a href="/miniSpringWeb/board/boardView?pg=${pg}&seq=${list[0].seq}&commentpg=${commentPg - 1}">이전</a>
                </c:if>
                <c:forEach var="i" begin="1" end="${commentPaging.totalPage}">
                    <c:choose>
                        <c:when test="${i == commentPg}">
                            <span>${i}</span> <!-- 현재 페이지 -->
                        </c:when>
                        <c:otherwise>
                            <a href="/miniSpringWeb/board/boardView?pg=${pg}&seq=${list[0].seq}&commentpg=${i}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${commentPg < commentPaging.totalPage}">
                    <a href="/miniSpringWeb/board/boardView?pg=${pg}&seq=${list[0].seq}&commentpg=${commentPg + 1}">다음</a>
                </c:if>
            </c:if>
        </div>
    </section>
</main>
<footer>
    <p>Copyright ⓒ 2024 멍캣광장 글보기</p>
</footer>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="../js/boardView.js"></script>
<script type="text/javascript" src="../js/boardComment.js"></script>
<script src="../js/header.js"></script>
</body>
</html>
