<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<%@ include file="layout/header.jsp"%>
</head>
<%
String userId = (String) session.getAttribute("userId");
String nickname = (String) session.getAttribute("nickname");
%>
<script>
$(function() {
    var userId = '<%=session.getAttribute("userId")%>';
    if (userId === null) {
        $.ajax({
            url: '/omok/login/loginForm.jsp',
            success: function(response) {
                $('#main_contents').html(response);
            },
            error: function(xhr, status, error) {
                console.error(error); // 오류 처리
            }
        });
        $('#signup').click(function(event) {
            event.preventDefault(); // 기본 동작 방지
            $.ajax({
                url: '/omok/login/registerForm.jsp',
                success: function(response) {
                    $('#main_contents').html(response); // 응답을 main_contents 요소에 삽입
                },
                error: function(xhr, status, error) {
                    console.error(error); // 오류 처리
                }
            });
        });
    } else {
        console.log(userId, "로 로그인했습니다.");
        $.ajax({
            url: '/omok/login/afterLogin.jsp',
            success: function(response) {
                $('#main_contents').html(response); // 응답을 main_contents 요소에 삽입
            },
            error: function(xhr, status, error) {
                console.error(error); // 오류 처리
            }
        });
    }
});

</script>

<body>
	<%--//main 부분을 ajax로 가져와서 동적으로 변경 
	 //--> 메인(로그인)부터 회원가입, 로그인 완료 화면까지 --%>
	<main>
		<%@ include file="../layout/mainContainer.jsp"%>
	</main>
</body>
<%@ include file="layout/footer.jsp"%>
