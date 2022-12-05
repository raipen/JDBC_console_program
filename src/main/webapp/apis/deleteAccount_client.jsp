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

	if(id==null || pw==null){
		response.setStatus(401);
		obj.put("message", "fail");
	}else{
		response.setStatus(200);
        if(userDAO.deleteAccount(id)){
            Cookie idCookie = new Cookie("id",null);
            Cookie pwCookie = new Cookie("pw",null);
            idCookie.setPath("/");
            pwCookie.setPath("/");
            idCookie.setMaxAge(0);
            pwCookie.setMaxAge(0);
            response.addCookie(idCookie);
            response.addCookie(pwCookie);
        }
        obj.put("message", "success");
        //response.sendRedirect("../index.jsp");
	}
	response.getWriter().write(new JSONObject(obj).toString());
%>