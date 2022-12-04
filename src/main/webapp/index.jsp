//id,pw 쿠키가 존재하지 않을 경우 login.html로 이동
//id,pw 쿠키가 존재하지만 로그인 실패할 경우 login.html로 이동
//id,pw 쿠키가 존재할 경우 로그인 확인 후 gamemanager 확인
//gamemanager는 gmMain.html로 이동
//일반 유저는 loginedUserPage.html로 이동

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
            response.sendRedirect("login.html");
        }else if(user.getUserID().startsWith("gamemanager")){
            response.sendRedirect("./GameManager/gmMain.html");
        }else{
            response.sendRedirect("LoginedUserPage.html");
        }
    }else{
        response.sendRedirect("login.html");
    }
%>