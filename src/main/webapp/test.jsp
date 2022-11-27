<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="DAO.*"%>
<%@ page import="DTO.*"%>
<%@ page import="org.json.simple.JSONObject" %>

<%
	JSONObject obj = new JSONObject();
	UserDAO userDAO = UserDAO.getInstance();
	UserDTO user = userDAO.login(request.getParameter("id"),request.getParameter("pw"));
	if(user==null){
		obj.put("ID",null);
	}else{
		obj.put("ID",user.getUserID());
		obj.put("PW",user.getPassword());
	}
	out.println(obj);
%>