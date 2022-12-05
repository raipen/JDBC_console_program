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
    <title>호반우 런</title>
    <link rel="stylesheet" href="userControl.css">
    <link rel="stylesheet" href="stastic.css">
    <link rel="stylesheet" href="gmMain.css">
</head>
<body>
<div id="left">

</div>
<div id="right">

</div>

<script type='module'>
    import {getUserList} from './userControl.js'

    getUserList();
</script>
</body>
</html>