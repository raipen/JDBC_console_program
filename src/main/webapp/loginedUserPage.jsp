<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="DAO.*"%>
<%@ page import="DTO.*"%>
<%
    Cookie[] cookies = request.getCookies();
    String id = null;
    String pw = null;
    if(cookies!=null){
        for(Cookie cookie : cookies){
            if(cookie.getName().equals("id")){
                id = cookie.getValue();
            }
            if(cookie.getName().equals("pw")){
                pw = cookie.getValue();
            }
        }
    }
    if(id!=null && pw!=null){
        UserDAO userDAO = UserDAO.getInstance();
        UserDTO user = userDAO.login(id,pw);
        if(user==null){
            response.sendRedirect("apis/logout.jsp");
        }else if(user.getUserID().startsWith("gamemanager")){
            response.sendRedirect("./GameManager/gmMain.jsp");
        }
    }else{
        response.sendRedirect("login.html");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>호반우 런</title>
    <link rel="stylesheet" href="css/loginedUserPage.css">
</head>
<body>
<div id="left">
    <div id="topMenu">
        <div class="button" id="changePW">PW 변경</div>
        <div class="button" id="deleteAccount">회원탈퇴</div>
        <a class="button" href="./apis/logout.jsp">로그아웃</a>
    </div>
    <div id="selectCharacter"></div>
    <br/>
    <div id="items"></div>
    <div id="bottomMenu">
        <div class="button" id="createCharacter">캐릭터 생성</div>
    </div>
</div>
<div id="right">
</div>
<div id="modal" class="modal"></div>
<script type='module'>
    import {getCharacterList} from './js/loginedUserPage.js'

    getCharacterList();
</script>
</body>
</html>