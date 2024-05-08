<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<form id="register_form" action="register.do" method="post">
  <input type="text" name="id" placeholder="아이디" />
  <input type="button" name="id_check" value="중복 아이디 확인" />
  <input type="password" name="password" placeholder="비밀번호" />
  <input type="password" name="password_confirm" placeholder="비밀번호 확인" />
  <input type="text" name="nickname" placeholder="닉네임" />

  <select name="character">
    <option value="1">캐릭터1</option>
    <option value="2">캐릭터2</option>
    <option value="3">캐릭터3</option>
    <option value="4">캐릭터4</option>
    <option value="5">캐릭터5</option>
    <option value="6">캐릭터6</option>
    <option value="7">캐릭터7</option>
  </select>

  <button type="submit">회원가입</button>
</form>

