<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
function deleteUser() {
    if (confirm("정말 삭제하시겠습니까??") == true){    //확인
        document.form.submit();
    }else{   //취소
        return;
    }
}

function updateUser() {
    if (confirm("정말 수정하시겠습니까?") == true){    //확인
        document.form.submit();
    }else{   //취소
        return;
    }
}

// 프로필 이미지를 클릭했을 때 프로필 유형 변경
$(document).ready(function() {
    // 각 프로필 이미지를 클릭할 때마다 프로필 유형 변경
    $("#profile_img_box img").click(function() {
        var profileType = $(this).attr("alt");
        showProfileImage(profileType);
    });

    // select 요소의 값이 변경될 때마다 프로필 이미지 변경
    $("select[name='profile']").change(function() {
        var profileType = $(this).val();
        showProfileImage(profileType);
    });

    // 초기에 선택된 프로필 이미지를 보여주는 함수
    function showProfileImage(profileType) {
        // 모든 프로필 이미지를 숨깁니다.
        $("#profile_img_box img").hide();
        // 선택된 프로필 이미지만 보이도록 합니다.
        $("#" + profileType).show();
    }
});
</script>

</head>
<body>
    <form id="updateForm" action="/omok/updateUser" method="get">
        <div>
            <div id="profile-container">
                <label id="profile_label">프로필 </label> 
                <select name="profile">
                    <option value="type1" selected>type1</option>
                    <option value="type2">type2</option>
                    <option value="type3">type3</option>
                    <option value="type4">type4</option>
                    <option value="type5">type5</option>
                    <option value="type6">type6</option>
                    <option value="type7">type7</option>
                </select>
                <div id="profile_img_box">
                    <img id="type1" src="/omok/images/profile/type1.png" alt="type1" />
                    <img id="type2" src="/omok/images/profile/type2.png" alt="type2" style="display: none;" />
                    <img id="type3" src="/omok/images/profile/type3.png" alt="type3" style="display: none;" />
                    <img id="type4" src="/omok/images/profile/type4.png" alt="type4" style="display: none;" />
                    <img id="type5" src="/omok/images/profile/type5.png" alt="type5" style="display: none;" />
                    <img id="type6" src="/omok/images/profile/type6.png" alt="type6" style="display: none;" />
                    <img id="type7" src="/omok/images/profile/type7.png" alt="type7" style="display: none;" />
                </div>
                <button type="button">프로필 수정</button> <br>
            </div>
        </div>
        
        <div>
            변경할 닉네임 <input type="text" name="nickname"> <br>
            변경할 비밀번호 <input type="password" name="pwd"> <br>
        </div>
    </form>

    <form id="deleteForm" action="/omok/deleteUser" method="post">
        <button type="button" onclick="deleteUser()">회원탈퇴</button> <br>
    </form>

    <input type="submit" value="변경 내용 저장" form="updateForm">
</body>
</html>
