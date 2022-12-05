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
            response.sendRedirect("../apis/logout.jsp");
        }else if(!user.getUserID().startsWith("gamemanager")){
            response.sendRedirect("../index.jsp");
        }
    }else{
        response.sendRedirect("../login.html");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 메인</title>
    <link rel="stylesheet" href="gmMain.css">
</head>
<body>
<div style="margin-top: 100px; text-align:center;" align="center">
    <div>
        <a href="userControl.jsp">
            <button id="userControl" class="btn-3d green large">유저 관리</button>
        </a>
    </div>
    <div>
        <a href="stastics.html">
            <button id="stastics" class="btn-3d green large">통계 자료</button>
        </a>
    </div>
    <div>
        <a href="../apis/logout.jsp">
            <button id="logout" class="btn-3d red small">로그아웃</button>
        </a>
    </div>

</div>
</body>
</html>