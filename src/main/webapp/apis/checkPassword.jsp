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
	HashMap<String, Object> obj = new HashMap<String, Object>();
	UserDAO userDAO = UserDAO.getInstance();
	JSONObject jsonObj = Utils.getJsonFromRequest(request);
	String id = (String)jsonObj.get("id");
	String pw = (String)jsonObj.get("pw");
	pw = Utils.getSha512(pw);

	UserDTO user = userDAO.login(id,pw);
	if(user==null){
		obj.put("result", false);
	}else{
		obj.put("result", true);
	}
    
    response.setStatus(200);
	response.getWriter().write(new JSONObject(obj).toString());
%>