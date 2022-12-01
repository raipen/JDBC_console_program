<%@ page language="java" contentType="application/json; charset=utf-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="utils.*" %>
<%@ page import="DAO.*"%>
<%@ page import="DTO.*"%>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONValue" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.parser.JSONParser" %>

<%
    response.setStatus(200);

    Cookie idCookie = new Cookie("id",null);
    Cookie pwCookie = new Cookie("pw",null);
    idCookie.setMaxAge(0);
    pwCookie.setMaxAge(0);
    idCookie.setPath("/");
    pwCookie.setPath("/");
    response.addCookie(idCookie);
    response.addCookie(pwCookie);

    response.sendRedirect("../index.jsp");
%>