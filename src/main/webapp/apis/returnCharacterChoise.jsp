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

    Cookie characterIdCookie = new Cookie("characterId",null);
    characterIdCookie.setMaxAge(0);
    characterIdCookie.setPath("/");
    response.addCookie(characterIdCookie);
	
    
    response.sendRedirect("../index.jsp");
%>